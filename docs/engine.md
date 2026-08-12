# Wonder Boy in Monster World â Engine Deep Dive

Reverse-engineered from the bit-perfect disassembly in `src/`. Addresses are
ROM (68000) unless noted as RAM ($FFxxxx) or VRAM. This document describes the
engine the way you would re-implement it: data formats, load pipelines, and the
per-frame flow. Cross-references into `src/*.asm` are given as `$ADDR` (ROM).

The whole game is a **Westone task-scheduler engine** built on top of the
Genesis VDP: a small set of reusable primitives (tile upload, tilemap decode,
palette upload, scroll, sprite DMA) driven by a three-level task scheduler and a
bytecode script interpreter. Every scene is assembled from the same four
building blocks: a **tileset** (tag-$01/$00 flagged records), a **tilemap**
(tag-$02 record), **palettes** (packed at $599C), and a **scene script** that
orchestrates both the scene content and the door transitions between scenes.

---

## 1. Memory map

### VRAM (64 KB, addressed 16-bit)

| Range      | Size | Contents |
|------------|------|----------|
| $0000-$3FFF | 16 K | tile patterns 0-1023 (4bpp, 32 bytes each) |
| $C000-$D7FF | 6 K  | Plane A tilemap (64 cols x 32 rows) |
| $D800-$DFFF | 2 K  | Plane B tilemap (64 x 32) |
| $E000-$F2FF | 4.7 K | sprite attribute table |
| $F300+     |      | sprite tile patterns / scratch |

Setup (`VDPPlaneTable`, mainloop.asm `$4AF4`): Plan A = $C000, Plan B = $D800,
sprite table = $E000, sprite dimensions at $D000, background color reg at $D400.

Plane size: **64 columns x 32 rows**, 2 bytes per entry (tile index + attribute
bits). Scroll registers: HScroll via reg $8014/$9014, VScroll via $8016/$9016.

### Work RAM ($FF0000-$FFFFFF)

Key ranges (see also Â§11 RAM map):

| Address      | Purpose |
|--------------|---------|
| $FF8048      | immediate task array (4 slots) |
| $FF80C8      | secondary task array (8 slots) |
| $FF8248      | round-robin object task array (16 slots) |
| $FF8A48-4C   | scheduler cursor / current slot |
| $FF8A49      | VBlank frame counter |
| $FF8006      | VBlank flag (bit 0 set in VBlank) |
| $FF8A52      | RNG state (LCG, seed $2A6D365A) |
| $FF8A7A-7C   | selected-input mirror (current/prev/new) |
| $FF8A7F-84   | per-pad triplets P1/P2 |
| $FF8B56      | palette source (display layout), 128 B |
| $FF8BD6      | palette working (uploaded to CRAM) |
| $FF8C7A      | current scene data pointer |
| $FF8C9A/9C   | current map cell X/Y (screen units) |
| $FF8C9E/A0   | scene dimensions X/Y |
| $FF8CA4      | player state byte |
| $FF8CA5      | player sub-state byte |
| $FF8CA6/8     | player state value / script pointer |
| $FF8D92/94   | scene origin X/Y |
| $FF8D9A/9C   | current scroll offset X/Y (tiles) |
| $FF8D96/98   | screen size in tiles X/Y |
| $FF8DA0-A6   | tilemap render control (row/col/skip) |
| $FF9758/5A   | player world X/Y |
| $FF9628/2A   | HUD HP/gold mirrors |
| $FFC000      | entity flag base (64 x 4-byte slots) |
| $FF0C00      | object RAM blocks (index * $40) |

---

## 2. Boot sequence

```
Reset vector ($000200)            ; SP=$FF0C00
  TMSS "SEGA" unlock
  24 VDP registers from table ($28E)
  Z80 bus control, 38-byte bootstrap upload
  RAM clear, PSG silence
  -> PostBoot ($2FA) -> jmp MainInit ($4A06)
MainInit:
  wait VDP idle; SR=$2700
  SetupVDP ($4A7A)                ; VDP regs + plane table (see Â§1)
  clear VRAM
  WriteZ80Driver ($306)           ; copy Z80 driver $98000 -> Z80 RAM $A0000
  InitIO ($4B02)                  ; joypad ports, zero input RAM
  subsystem inits: $5170, $6BA0, $5398, $9F46
  InitQueues ($4B42)              ; zero the 0x80-strided task slots
  SR=$2500
  -> jmp MainLoop ($4CB8)
```

SetupVDP mirrors every VDP register value to a RAM shadow (`VDPRegTable`,
`$4AD0`) so the rest of the code can read back what it wrote. Register writers
for the common ones live in `src/scroll_vdp.asm` ($716/$72C/$74E/$764/$786/$79C).

---

## 3. Main loop and task scheduler

**MainLoop ($4BBC):**
1. Set $FF8A48 = $80 and A5 = $FF8048 (immediate task array).
2. Walk the array: for each slot whose byte 0 has bit 7 set, read the callback
   pointer at `slot+$0C` and `jsr (A0)`. Slot stride is $80.
3. Run `$53AA` (object table maintenance / round-robin cleanup).
4. `WaitForVBlankScanline ($4C00)` + `FrameWait ($3B8)` â sync to the raster.

**VBlank (IRQ6, $4B5C):** increments `$FF8A49`, sets bit 0 of `$FF8006`.
The main loop polls that bit to know a frame has started.

**Three task arrays** (all $80-byte slots, function pointer at +$0C):

| Array | Address | Slots | Used for |
|-------|---------|-------|----------|
| immediate | $FF8048 | 4 | per-frame callbacks dispatched by MainLoop |
| secondary | $FF80C8 | 8 | loaded from inline descriptor lists ($4CC4-$4E63) |
| round-robin | $FF8248 | 16 | object/entity tasks, cleaned by `$53AA`/`$4B96` |

Entities register a task-slot entry + an object RAM block (`$FF0C00 + idx*$40`).
Spawn helpers: SpawnObject ($444), FindOrSpawnObject ($47A), ApplyToObjectsWithID
($4A2), CleanupObjects ($4B96).

---

## 4. The scene / plane system  <-- THE CORE

This is the heart of the game and the answer to "how is a plane exposed when I
walk through a door". A **scene** is a self-contained area (town, castle, cave,
shop, room). The engine exposes it by (a) resolving a scene *index* to its data,
(b) streaming the scene's tiles into VRAM, (c) decoding the 32x32 tilemap and
writing it to **Plane A**, (d) loading the palette, and (e) re-homing the camera
and player. Doors are just scene indices: entering one re-runs this pipeline for
the target scene.

### 4.1 The scene table ($1CC14) and scene type table ($1CC18)

Two global pointers (stored as longs at ROM $1CC14 and $1CC18) anchor the scene
system:

- **Scene table** = pointer at $1CC14 -> $1DD94.
  Entry `i` is **3 bytes**: `[type byte][16-bit offset]`, relative to the scene
  table base. `sceneData = $1DD94 + offset`.
- **Scene type table** = pointer at $1CC18 -> $1DD74.
  Entry `type` is **4 bytes**: `[X-origin][Y-origin][width][height]`. These are
  the per-type screen geometry.

`ResolveScene (loc_276C)` implements this lookup:
```
D0 = scene index
D0 = D0 * 3
A1 = scene table ($1DD94)
offset = (A1[D0+1] << 8) | A1[D0+2]
A0 = $1DD94 + offset            ; scene data
$FF8C7A = A0                     ; current scene data pointer
type  = A1[D0]                   ; 0..7
A1 = type table ($1DD74) + type*4
```

The scene's *data* (the script + dialogue, `$FF8C7A`) is consumed by the script
interpreter (Â§7). The *type entry* (geometry) is what the plane set-up uses.

### 4.2 Scene geometry set-up (loc_2002 / loc_27B0)

After resolving the scene, the engine reads the type entry's 4 bytes into the
camera/scroll state and marks the player active:

```
loc_2002:  jsr $276C (resolve)   ; A1 = type entry
  byte 0 -> $FF8D92, $FF8D9A     ; scene X origin
  byte 1 : (b*2 - 1) -> $FF8D94, $FF8D9C ; scene Y origin
  byte 2 -> $FF8C9E              ; scene width (X, in screen cells)
  byte 3 -> $FF8CA0              ; scene height (Y, in screen cells)
  $FF8CA4 = $80                  ; player state active
```

`$FF8C9E/$FF8CA0` bound the player: when `$FF8C9A (cell X) >= $FF8C9E` the
engine scrolls to the next cell row (`loc_16C6`: clear cell X, increment cell Y,
re-render). So the 32x32 tilemap is sliced into **screen-sized cells** and the
player walks cell to cell; the camera origin tells each cell where it sits in
world space.

### 4.3 "Exposing the plane" â the full load pipeline

When a scene change is triggered (door, start of game, shop entry), the engine
runs these in order:

**Step 1 â tile upload (scene tile loader, $22F0 + loc_22FE).**
A scene's tiles come from the **flagged table** (see Â§4.4). The loader walks a
list of flag indices and streams each record into a VRAM tile-block:
```
A0 = scene flag-index list        ; list ends with a negative word
loop:
  D0 = (A0)+                      ; flag index
  if D0 < 0: end
  if D0 == (A0+$7E): skip         ; "last loaded" cache - block already in VRAM
  (A0+$7E) = D0
  LoadFlaggedData(D0) -> buffer $FF2D00   ; decode the record
  VRAM block addr = blockCounter ror #6   ; block * $40 tiles
  copy 0x800 bytes (64 tiles) buffer -> VDP data port ($C00000)
  blockCounter++
  while blockCounter < $40        ; up to 64 blocks = 4096 tiles = full VRAM
```
The cache field at `+$7E` of the list means a scene change that reuses the same
tile blocks does not re-upload them (this is why town interiors feel instant).

**Step 2 â tilemap decode (DecodeMap $6D9C).**
The tag-$02 map record is a tree+LZSS-compressed 32x32 tilemap. DecodeMap writes
the 1024 tile indices into the map buffer (caller-supplied, in RAM). Map values
are tile *block* indices into the tileset loaded in Step 1.

**Step 3 â palette load.** `LoadPalettes/DecodePalette` ($135C/$1370) decode the
packed palettes (17 bytes each, see Â§8) into `$FF8B56` (source) / `$FF8BD6`
(working) and upload to CRAM.

**Step 4 â render the tilemap to Plane A.** Two writers:
- `loc_2050`: writes ONE tilemap entry. Computes the Plane A VRAM address from
  `(scrollY + row) << 6 + (scrollX + col)`, ORs $4000 (Plane A base), writes the
  control word to $C00004 then the tile+attr word to $C00000.
- `loc_2082`: bulk renderer â iterates the visible rows/cols of the map buffer
  and streams them to Plane A, honouring a dirty/skip mask (`$FF8DA0-$FF8DA6`).
- `loc_1758`: full-scene render â used on scene entry to draw the whole map
  (it computes the scene centre and calls the bulk renderer).

**Step 5 â home the camera.** `UpdateScrollRegs ($2110)`:
```
$FF8D9A = (playerX >> 3) + sceneX origin, & $3F
$FF8D9C = (playerY >> 3) + sceneY origin, & $1F
write HScroll ($8014/$9014) and VScroll ($8016/$9016) via $21E8
```
The two masks are the plane width/height in tiles (64/32), so the camera wraps
correctly inside the plane. Every frame the main gameplay code re-runs this from
the player position, which is what makes the plane scroll as you walk.

### 4.4 The flagged table ($41000-$41B40) â scene building blocks

`LoadFlaggedData ($6BC4)` resolves a flag index to a record in this table and
decodes it. Records are **4 bytes**: `[tag byte][24-bit address]`. Flag index `n`
reads the record at `$41000 + n*4`.

| Tag | Meaning | Decoder |
|-----|---------|---------|
| $00 | compressed 4bpp tile stream | DecompressTiles ($6BFC) |
| $01 | direct tile block (0x4C0 bytes = 38 planar tiles) | direct copy |
| $02 | 32x32 tilemap (tree+LZSS) | DecodeMap ($6D9C) |

`LoadFlaggedData` dispatch:
```
D0 = flag index; A0 = $41000 + (D0<<2); D0 = (A0) record
if bit 18 ($40000): direct copy 0x200 longs (0x800 bytes) to (A1)
if bit 19 ($80000): DecompressTiles (tag $00 stream) to (A1)
else:               DecodeMap (tag $02) to (A1)
```
The 24-bit addresses point into the $41000-$45842 graphics/text bank. Tag-$01
blocks cover the tilesets (each 38 tiles, e.g. $459A8, $4C1EA, $5C7DA...);
tag-$02 records are the 682 maps (see `tools/extract_maps.js`).

### 4.5 Tile / map encoding details

**Tiles** are 4bpp planar (four bit-planes, 32 bytes/tile). The planar
nibble->byte expansion is done with `TileBitSpreadTables` ($6D1C) â four 16-word
lookups that spread a 4-bit index into the four planes.

**DecompressTiles ($6BFC)** (tag-$00 stream): per 32-byte row, a header byte;
$00 = repeat byte 0x20 times, positive = run-length token, negative = the 
$6C56 routine (per-plane bit decode + the bit-spread re-assembly). It writes
row by row (32-byte rows).

**DecodeMap ($6D9C)** (tag-$02 map): a bit-stream LZSS variant. Tokens build a
small cache (`-$70F6` RAM) of repeated words, then a row/column filler emits
32x32 words. Map values are tile-block indices; attribute bits (palette/flip)
are applied by the renderer at Plane A write time.

### 4.6 Doors and transitions

A **door** is a scene-change trigger. When the player activates one (standing on
a doorway tile and pressing Up, or touching a door entity), the game:

1. **Resolves the target scene index** through `loc_276C` -> new `$FF8C7A`
   pointer + type entry. Door targets are stored in the scene/door data inside
   the current scene's script (the script interpreter emits a "change scene"
   command with the target index).
2. **Runs the scene set-up** (loc_2002 / loc_27B0): new origins + dimensions,
   player state = $80.
3. **Resets the player object** (loc_13C4, entity.asm): clears sub-state
   `$FF8CA5`, script pointer `$FF8CA8`, cell `$FF8C9A`, clears event flags
   `$FF8CA2/$FF8CC2`, sets `$FF8CC3 = 1`, resets `$FF8CA6 = $8000`. If a
   per-scene "enter handler" pointer is set (bit 2 of $FF8CA4) it is dispatched.
4. **Re-exposes the plane** with the new scene: tile upload (Â§4.3 step 1, using
   the tile-block cache so shared blocks skip), map decode (Â§4.3 step 2),
   palette, full-scene render (Â§4.3 step 4 via loc_1758), camera home (Â§4.3
   step 5).
5. **Repositions the player** at the door's spawn point (the door data carries
   an X/Y; the renderer/scroll re-homes the camera on the player).

The **scene-event bytecode interpreter (loc_14F4)** is what plays the transition
itself. It reads a byte stream pointed to by `$FF8CA8` (script pointer) and
dispatches commands through two offset tables:

- `DispatchTable1` ($15A0) â codes < $0C map to the in-scene commands.
- `DispatchTable2` ($15C8) â codes >= $0C via a second jump table.

Commands include: advance to next screen row (loc_16C6), add to the current map
cell (`$FF8C9A`), set `$FF8CA6` to a 16-bit value, set `$FF8CA2` (loop counter),
set/clear player-state bits ($FF8CA4 bits 0/4/5), jump to an offset within the
stream (loc_168C), and "set flag / spawn" ops. The script pointer is stored back
into `$FF8CA8` so the interpreter resumes where it left off each frame â this is
how a door-entry cutscene (walk up, screen fade, tile load, walk into the new
area) is scripted: the same bytecode runs across many frames.

Because the script holds the target scene index, the *door table itself* is
really just the scene list: door "targets" are entries in the $1DD94 scene table.
A scene's script decides which neighbouring scene indices are reachable from its
doors.

> NOTE: the door *trigger tiles* and the exact "standing on door tile" collision
> test are not individually labelled in the current disassembly (they sit in the
> raw data-dense blocks), but the scene-change pipeline above is fully traced
> from `loc_276C`, `loc_2002`, `loc_22FE`, `loc_16C6`, `loc_13C4` and
> `UpdateScrollRegs`.

### 4.7 Per-frame scene flow (gameplay loop)

Each frame while a scene is active:

1. Read joypads -> `$FF8A7F-84`; build selected-input mirror `$FF8A7A-7C`.
2. Run the player state machine (`$FF8CA4` bits + `$FF8CA5` sub-state).
3. If a scene-event script is active, run one step of it (loc_14F4).
4. Update the player X/Y (`$FF9758/$FF975A`) from input + collision.
5. Bound-check the player against the scene (`$FF8C9E/$FF8CA0`); if it crossed a
   cell boundary, scroll to the next cell (loc_16C6) and re-render.
6. `UpdateScrollRegs` â write H/V scroll from player + scene origin.
7. Object/entity tasks (round-robin array) + sprite DMA (update sprite table).
8. HUD (HP/gold mirrors at $FF9628/$FF962A) and palette animation driver
   ($594A) as scheduled.

---

## 5. Entity / object system

- 64 entity flag slots at $FFC000 (4 bytes each, index 0-63).
- Object RAM blocks at $FF0C00 + index*$40; object slots have +0 active flag,
  +4 ID (long), +8 update fn, +$C callback.
- SpawnObject ($444) / FindOrSpawnObject ($47A) / ApplyToObjectsWithID ($4A2).
- `$53AA` each frame walks the round-robin slots, runs callbacks, and cleans up
  finished objects ($4B96).
- Angles: CalcAngleToTarget ($108C) is an atan2 using the sine/delta tables
  ($3EB8-$3F07) and the angle LUT ($1102-$1201).

Entities are driven partly by the object task system and partly by the scene
script interpreter, which can spawn/move/remove them with commands.

---

## 6. Script interpreter ($7E8-$A1A)

The offset-tree bytecode interpreter that drives cutscenes, NPCs, dialogue and
doors. Scripts live at ROM $A0000 (offset tree of word offsets), state in
$FF8100-$FF9600. A4 = $FFC000 is the entity-slot base. Command bytes >= $F0
dispatch through a 16-entry jump table; data bytes load signed 16-bit values.
This is the same family of engine as the in-scene bytecode (loc_14F4) â a
stack-less stream interpreter with a fixed working area.

---

## 7. Text / dialogue encoding

- Text lives in the $20000+ bank; strings are 7-bit-ish ASCII plus control
  codes (0x09 = print string, 0x0C = control/colour/face, 0x04 = ...).
- A 169-word dictionary at $22026 shortens common words; control codes >= $F0
  are handled by the text renderer.
- "Found the GOLD." style strings at $1FE6 confirm the string/control layout.

---

## 8. Palette system

- **Format**: 252 packed palettes at $599C, **17 bytes each**: 1 tag byte
  (palette index / behaviour) + 16 nibble-pairs packed 4:1 (the 17th byte packs
  the top nibbles). 15/16 CRAM match verified against the live emulator.
- **Load**: LoadPalettes/DecodePalette ($135C/$1370) -> source $FF8B56
  (128 bytes, display layout) -> working $FF8BD6 -> CRAM.
- **Animation**: PaletteAnimationDriver + AdjustPaletteWord ($594A) animate
  water/lava via the palette adjust engine ($594A) reading RAM buffers.
- CRAM is 4 palettes x 16 colors (RGB555).

---

## 9. Input

- Ports read each frame at $51C6.
- Per-pad triplets: P1 `$FF8A7F-81`, P2 `$FF8A82-84` = (current, previous,
  new-press). Selected-input mirror `$FF8A7A-7C`.
- Auto-repeat gating at $805A; the action handler (actions.asm $1400-$1474)
  maps buttons to actions (A = confirm/attack, B = cancel, C = jump, Up = enter
  door/use, Start = menu).

---

## 10. Sound (Z80 driver)

- Driver at ROM $98000, length prefix at $98006-07 (little-endian), uploaded to
  Z80 RAM $A0000 by WriteZ80Driver ($306).
- Command mailbox: write byte to `$A01C30 + (cmd & $F)` in Z80 RAM
  (SendZ80Command, $364).
- `src/z80_driver.asm` is a full annotated Z80 disassembly (4148 instructions,
  20+ labels): FM/PSG sequencer, tempo, per-channel voice data.

---

## 11. RAM map (consolidated)

| Address | Size | Meaning |
|---------|------|---------|
| $FF8006 | 1 | VBlank flag (bit0) |
| $FF8A48 | 1 | scheduler cursor |
| $FF8A49 | 1 | VBlank frame counter |
| $FF8A4C | 2 | current task slot (word) |
| $FF8A52 | 4 | RNG state |
| $FF8A62-A8 | | VDP register shadows / scroll values |
| $FF8A72/70 | 2 | scroll X/Y (pixels) |
| $FF8A7A-7C | 3 | selected input mirror |
| $FF8A7F-84 | 6 | raw pad triplets |
| $FF8B56 | 128 | palette source |
| $FF8BD6 | 128 | palette working |
| $FF8C7A | 4 | current scene data pointer |
| $FF8C9A/9C | 2 | current cell X/Y |
| $FF8C9E/A0 | 2 | scene dims X/Y |
| $FF8CA2 | 1 | scene event loop counter |
| $FF8CA4 | 1 | player state |
| $FF8CA5 | 1 | player sub-state |
| $FF8CA6 | 2 | player state value |
| $FF8CA8 | 2 | scene-event script pointer |
| $FF8CAA | 1 | transition timer (0x14) |
| $FF8CC2/3 | 1 | event flags / counter |
| $FF8D92/94 | 2 | scene origin X/Y |
| $FF8D9A/9C | 2 | current scroll (tiles) |
| $FF8D96/98 | 2 | screen size (tiles) |
| $FF8DA0-A6 | | tilemap render ctrl |
| $FF9628/2A | 2 | HUD HP / gold |
| $FF9658-5C | | game mode / sub-scene state |
| $FF9758/5A | 2 | player world X/Y |
| $FF2D00 | 0x800 | tile decode staging buffer |
| $FFC000 | 256 | entity flags |
| $FF0C00 | | object RAM blocks |

---

## 12. Data format reference (quick table)

| Thing | Location | Format |
|-------|----------|--------|
| flagged table | $41000 | 4B `[tag][addr24]` per index |
| tiles | $45842+ | 4bpp planar, 32B/tile |
| tile blocks | tag $01 | 38 tiles (0x4C0 B) |
| tile streams | tag $00 | RLE/planar (DecompressTiles) |
| maps | tag $02 | tree+LZSS 32x32 tilemap |
| scene table | $1DD94 | 3B `[type][off16]` per index |
| scene type table | $1DD74 | 4B `[X][Y][W][H]` |
| palettes | $599C | 252 x 17B packed |
| dictionary | $22026 | 169 NUL-terminated words |
| scene scripts | $1DF1D+ | bytecode + ASCII text |
| Z80 driver | $98000 | Z80 code, length @ $98006 |
| script tree | $A0000 | offset tree of word offsets |

---

## 13. What to trace next (for a 1:1 clone)

1. **Door trigger tiles**: the collision test that turns "standing on doorway
   tile + Up" into "run scene change with target index". Lives in the raw
   data-dense blocks; the scene-change pipeline it calls is documented above.
2. **Scene script opcode table**: the full DispatchTable1/2 command set
   (partially mapped in Â§4.6).
3. **Item/magic menu data** (menu_system.asm) and shop tables (gamebank bank).
4. **Exact per-map palette selection** (scene -> tileset/palette mapping) for
   colour-correct renders.
5. **$02482C 0xFF7A/0xFF7B blocks**: word-offset header + marker blocks
   (palette/animation data) â encoding still open.
