# Progress

## Format crack status

| item | status | verified |
|------|--------|----------|
| 4bpp planar tile format + 20 block addresses | CRACKED | vs ROM + tools round-trip bit-perfect |
| tag $00 tile-stream decompressor ($6BFC) | CRACKED | vs live emulator VRAM (exact tile matches) |
| flagged-table loader ($6BC4) 3 data types | CRACKED | code-traced |
| packed palette format (17 bytes, $599C x 252) | CRACKED | 15/16 match vs live emulator CRAM |
| palette adjust engine ($594A) + buffers | CRACKED | code-traced |
| tag $02 map format (32x32 tilemaps, tree+LZSS) | CRACKED | 681/682 decode to exact record boundaries; 682 maps extracted |
| Z80 sound driver ($98000) | DISASSEMBLED | 4148 instructions annotated + 11 labels; bit-exact dc.b |
| text/control encoding ($020000+) | PARTIAL | ASCII + 169-word dictionary extracted |
| $02482C 0xFF7A/0xFF7B blocks | PARTIAL | structure: word-offset header + 0xFF7A/0xFF7B marker blocks (palette/animation data, ~37 markers across bank); exact encoding open |

## Asset pipeline (wired into build.sh)

- `tools/extract_assets.js` ROM -> `assets/tiles.png` + `assets/palettes.json`
  + `assets/tile_blocks.json` (lossless).
- `tools/regen_assets.js` -> `src/data/tile_blocks_0..4.asm` + `src/scene/palette_table.asm`.
- `./build.sh && ./verify.sh`: unmodified assets -> **bit-perfect** (same hash);
  edited tile verified to flow through (tile 0 block 0 -> 0xFF in out.bin).
- Fixed-size edits only; size-changing edits need pointer work (open).

## Map extraction + rendering

- `tools/extract_maps.js` decodes all 682 tag-$02 32x32 tilemaps to
  `maps/map_*.bin`.
- `tools/render_maps.js` renders them as colored PNGs (map value -> tile of the
  concatenated tag-$01 blocks, decoded palette) to `maps/png/`. Coherent
  game-area structure confirmed (towns, caves). Per-map palette selection is a
  follow-up (scene->tileset/palette mapping).
- Scene -> tileset/palette mapping (for exactly-colored screen renders) not yet
  traced.

## Disassembly regions (registered, bit-perfect)

- Code $200-$5700: core, scroll_vdp, script_engine, entity, actions, scene_loader, movement, sprites,
  mainloop, subsystem.
- $599C-$6A58: **palette_table.asm** (labeled, 252 palettes, asset-wired).
- $579A-$5985: **src/scene/palette.asm** (PaletteAnimationDriver, PaletteSourceToWorking,
  AdjustPaletteWord) ÃÂ¢ÃÂÃÂ hand-converted, bit-exact.
- $6BC4-$6EA6: **src/scene/scene_load.asm** (LoadFlaggedData, DecompressTiles,
  DecodeMap) ÃÂ¢ÃÂÃÂ hand-converted, bit-exact.
- $6EA6-$6F85: **src/scene/scene_load.asm** code (hand-verified per-instruction vs ROM) +
  $6F86-$6FFF data ÃÂ¢ÃÂÃÂ bit-exact.
- **$7000-$8000: sprite_data.asm CONVERTED** ÃÂ¢ÃÂÃÂ 23 code instructions (code islands)
  + sprite/animation data tables as dc.b; bit-exact. Method: Ghidra convert ->
  fix errors -> fix PC-relative operands -> one-pass convert mismatched runs to
  exact dc.b -> manual boundary fixes (Ghidra skips, mis-rendered operands,
  over-long rows).
- **$8000-$9000: menu_system.asm CONVERTED** ÃÂ¢ÃÂÃÂ 156 instructions + data, bit-exact.
- **$9000-$A000: gameplay_data.asm CONVERTED** ÃÂ¢ÃÂÃÂ 105 instructions + data, bit-exact.
- **$A000-$20000: src/data/main_data.asm CONVERTED** (11 chunks of 8KB) ÃÂ¢ÃÂÃÂ 1603
  instructions + data tables, bit-exact. This is the main gameplay/data bank
  (state dispatch tables, monster/level data).

### The converged conversion pipeline (used for $8000-$1FFFC)

1. `tmp_conv.js` ÃÂ¢ÃÂÃÂ Ghidra dump ($5700-$9FFE = g17, $A000-$1FFFC = g18) -> asm,
   leading-gap dc.b padding, branch/immediate normalization.
2. `tmp_fixerr.js` ÃÂ¢ÃÂÃÂ replace every asm68k-rejected line with exact-ROM dc.b
   (span = next line's address - this line's address). Loop to 0 errors.
3. `tmp_pcfix.js` ÃÂ¢ÃÂÃÂ resolve `(d,PC,xn)` to absolute `(addr,PC,xn)`.
4. `tmp_fixerr.js` ÃÂ¢ÃÂÃÂ clear errors reintroduced by pcfix.
5. `tmp_spanforce.js` ÃÂ¢ÃÂÃÂ build, compare each line's lst address/length/bytes vs
   ROM at its comment address; rewrite mismatches to span-exact dc.b (16 bytes
   per line). Converges in 1-2 passes.

**asm68k crash gotcha (important):** a single `dc.b` line with many values
(~100+) makes asm68k.exe page-fault (wine unhandled exception), NOT a syntax
error. ALWAYS split dc.b to <=16 values per line. Symptom: `pass N BUILD ERROR,
errs=0` and a hung build; verify no giant dc.b lines.
**lst gotcha:** asm68k's lst byte column truncates at 10 bytes per row with a
`+`; never parse byte counts from the byte column ÃÂ¢ÃÂÃÂ derive length from the next
lst row's address, bytes from out.bin. The lst also echoes the last dc.b line of
an include twice (benign; dedupe by address).
**regions.json gotcha:** a module that isn't registered is silently ignored ÃÂ¢ÃÂÃÂ
spanforce will oscillate forever against data_rest's raw rows. Register the
module BEFORE running spanforce.
- Tile blocks $45842..$6BB12: **tile_blocks_0..4.asm** (labeled, from assets).
- $5700-$579A: **palette.asm CONVERTED** ÃÂ¢ÃÂÃÂ 43 instructions + data, bit-exact.
- $5986-$599C: **palette_post.asm CONVERTED** ÃÂ¢ÃÂÃÂ 6 instructions + data, bit-exact.
- $6A58-$6BC4: **scene_load.asm CONVERTED** ÃÂ¢ÃÂÃÂ 127 instructions + data, bit-exact.
- $6EA6-$6FFF: **scene_load.asm CONVERTED** ÃÂ¢ÃÂÃÂ data (flagged-loader tables), bit-exact.
- $20000-$45842: raw dc.b (data tables: text, maps, level data ÃÂ¢ÃÂÃÂ deferred).
- $98000-$99A76: **z80_driver.asm** (full Z80 disassembly annotated + 20 labels).
- $A0000-$A4C76: data_banks.asm.

## Readability / modding infrastructure (reviews executed)

- **Every routine named**: 0 `loc_`/anonymous labels remain; all 1,195+
  routines have descriptive PascalCase names. Entry-point labels added for
  spawn/damage/menu/scene code (CheckCollisionPoint, SceneSpawnCommand,
  ApplyDamage, KillEntity, UpdateHelper, FrameUpdate, EnterScene...).
- **All raw-address calls resolved**: 0 `jsr/jmp/bsr $XXXX` remain; every
  call site uses a named label (builds a real call graph, rename-safe).
- **94 routine doc blocks** on engine/gameplay entry points (zoom-style).
- **Entity object layout symbolized**: 575 `ENT_*` A4-relative symbols in
  ram_addresses.asm (X/Y, velocity, HP `$FF9403`, gold `$FF9A00`, attack,
  stat index, defense, collision box, state).
- **21 ROM table EQU constants** added to game_constants.asm (stat/damage/
  angle/scene/dispatch tables). Fixed two misleading names (DamageStatTable,
  StatDeltaTable).
- **Dialogue fully extracted + moddable**: text/dialogue.md (all scenes),
  text/scenes.json (editable), regen_dialogue.js wired into build.sh.
- **Map editing round-trip**: `compress_tag02.js` + `inject_maps.js`
  (verified on all 682 maps). **Scene manifest**: `extract_scenes.js` ->
  scenes/scenes.json + docs/scenes.md.

## Ghidra conversion limitation (documented)

Ghidra's force-disassembly mis-sizes/skips instructions where data tables are
interleaved (e.g. decodes `movea.w $6367,A6` as a stray `bls`). This makes
auto-conversion of the data-heavy regions unreliable; the clean code blocks
were hand-converted and verified bit-exact, the rest stays raw dc.b.

## Emulator tooling

- RetroArch + Genesis Plus GX core. Config at `tools/retroarch-wb.cfg`.
- Screenshots: `retroarch --max-frames N --max-frames-ss` (needs X; the x11
  driver name is not available ÃÂ¢ÃÂÃÂ falls back to vulkan/gl).
- Save states (`~/.config/retroarch/states/Genesis Plus GX/`) are zlib chunks
  after an 8-byte header; RASTATE wrapper + core state. Work RAM starts at
  decompressed offset 0x20, so RAM $FFxxxx sits at state offset $20+$xxxx
  (byte order appears swapped for words).
