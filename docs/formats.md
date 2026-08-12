# Data & Compression Formats (cracked so far)

Bit-perfect disassembly + emulator-verified reverse engineering of
Wonder Boy in Monster World (Genesis). ROM bytes are ground truth.

## ROM layout

```
$000000-$00A000  engine code + data        (disassembled, see src/)
$00A000-$01FFFF  more code (partially decoded)
$020000-$03FFFF  dialogue/text + compressed-data blocks
$040000-$07FFFF  flagged reference tables + tile graphics + payloads
$080000-$0BFFFF  Z80 sound driver, offset trees, $FF fill
```

## Flagged ROM-reference table at $041000

4-byte records `[tag byte][24-bit address]`:
- `$000000-$000003` region: local table ($041000-$0418AB), then cross-bank
  table ($0418AC-$041B3F).
- Consumer: `LoadFlaggedData` at $6BC4.

### LoadFlaggedData ($6BC4) — the three data loaders

Called with D0 = record index, A1 = destination. Indexes `$041000 + index*4`,
reads `[tag][addr]` long, then dispatches on the tag byte bits:

| tag | handler | meaning |
|-----|---------|---------|
| bit7 set | clear dest (0x100 longs = 0x400 bytes) | filler/clear |
| bit0 (`$01`) | direct copy 0x400 bytes (32 tiles) | uncompressed tile block |
| bit1 (`$02`) | tree builder at $6D9C | linked/tree structure (map/level?) |
| bit0+bit1 clear (`$00`) | stream decompressor at $6BFC | compressed tile block |

## Tile format (all tile data)

- Genesis 4bpp planar: each tile = 32 bytes = 4 bitplanes x 8 bytes.
  Plane byte for row y at `tile + y*4 + plane`; pixel x = bit `(byte>>(7-x))&1`.
- One tile = 8x8 pixels, 16 colors (index = plane bits 0..3).
- Uncompressed blocks (tag $01) are 0x4C0 bytes = 38 tiles.
  Addresses (20 blocks, 760 tiles total) found by scanning the flagged table
  for tag `$01`.

## Compression (tag $00 stream decompressor at $6BFC)

Each block decompresses to exactly 32 tiles (1024 bytes). Control byte per tile:

| control | meaning |
|---------|---------|
| `$00` | next 32 bytes are the literal tile |
| `$01-$7F` | RLE/bitmask (below) |
| `$80-$FF` | pattern expansion + nibble->planar spread (below) |

### RLE/bitmask (control `$01-$7F`)

- Repeat `control` times: read a fill byte + a 4-byte **big-endian** 32-bit mask.
  For each set bit of the mask (MSB first), write the fill byte to the tile.
  (Masks OR together across repeats.)
- Then for each bit CLEAR in the combined mask (MSB first), copy one literal
  byte from the stream.
- Net output exactly 32 bytes per tile.

### Pattern + planar (control `$80-$FF`)

Builds a 32-byte pattern in a scratch buffer, then spreads nibbles to planar:
- 4 passes, 8 bytes each. Per pass: header byte bit selects "all-0/1 fill"
  vs 8-bit-control literal mode; the outer control byte bit selects an
  optional XOR pass over the 8 just-written bytes.
- Planar conversion reads `pattern[i]`, `pattern[i+8]`, `pattern[i+16]`,
  `pattern[i+24]` for i=0..7, splits each byte into high/low nibble, and
  spreads each nibble into 16 bits via lookup tables at $6D1C/$6D3C/$6D5C/$6D7C
  (each nibble bit -> bit positions 0/4/8/12, 1/5/9/13, 2/6/10/14, 3/7/11/15),
  producing 4 bytes of planar output per i.

**Verification:** the JS decompressor (`tools/decompress_tiles.js`) reproduces
tiles that appear byte-exact in a live emulator's VRAM, and block consumption
matches the reference repo's independently-derived region boundaries
(e.g. $04A4B0 -> next region $04A70F).

## tag $02 payload records (tree + LZSS, at $6D9C) — PARTIALLY CRACKED

`LoadFlaggedData` dispatches tag bit1 ($02) records to $6D9C, which:
1. Builds a binary decision tree from a header bitstream (bit=1 creates a
   node at RAM $FF8F0A+4n, bit=0 sets a token leaf via an 8-bit or 5-bit
   extended read; 0x11F leaf = escape).
2. Decodes a ~1024-byte LZSS stream: token < 0x100 = literal byte,
   token >= 0x100 = match (len = token-0xFD, distance token follows).
   Output looks like 32x32 tilemap data (values 0x01-0xE1).

`tools/decompress_tag02.js` implements this. It produces plausible 32x32
tilemaps for the $041C00+ records but **over-consumes the input** (record 1
decodes in 311 bytes vs the 207-byte table boundary), so the tree or match
logic has a residual bug. Records with few distinct symbols decode to
5-node trees; larger ones to 97 nodes. Verification against emulator
VRAM / game screens is still pending.

## Map / level format — CRACKED (tag $02 records, verified)

- The flagged-table tag `$02` records at `$041C00+` are **32x32 tilemaps**
  (1024 bytes, 1 byte per tile). 682 maps decoded.
- **Compression:** Huffman decision tree built at runtime from a header
  bitstream (bit=1 creates a node, bit=0 sets a token leaf via an 8-bit or
  5-bit extended read), then an LZSS loop:
  - token < `$100` = literal byte
  - token >= `$100` = match (len = token-`$FD`, distance token follows)
  - output length 0x3FF+ (=1024) bytes
- Decompressor at `$6D9C` (tree build `$6D9C-$6DE6`, walker `$6E2E`,
  token readers `$6E4E/$6E76`, LZSS `$6DEA-$6E2C`).
- **Verification:** `tools/decompress_tag02.js` consumes each record to
  EXACTLY the next record boundary (681/682 exact; the one exception spans a
  known region gap). Decoded maps show coherent game-area structure.
- **Tool:** `tools/extract_maps.js` writes all 682 maps to `maps/map_*.bin`
  (+ PNG previews with a placeholder tileset/palette).

## Runtime data-loading flow

- Scene loader at $22F4 reads flagged-table indices from a list at $FF8E08;
  for each changed index it calls `LoadFlaggedData($6BC4)` with dest $FF2D00,
  then copies $FF2D00 -> VDP data port to upload tiles to VRAM.
- Tile upload loop: `move.l (A1)+,(A2)` x 0x100 (256 longs = 1024 bytes) to
  `$C00000`.

## Palettes — CRACKED (verified 15/16 against live emulator)

- **Location:** packed palette table at ROM `$599C`, stride **17 bytes** per
  palette. Indexed by scene data bytes via `LoadPalettes` at $135C ->
  `DecodePalette` at $1370 (base `$599C + index*17`).
- **Format (17 bytes):**
  - bytes 0-1 = 15-bit "blue-high" field (bit *c* sets display bit 11 for
    color *c+1*; field read as `byte0<<8|byte1`, shifted 1 bit per color)
  - bytes 2-16 = 15 packed color bytes, color 0 is implicitly `$0000`:
    - red   = `(byte & 7)   << 1`   (display bits 1-3)
    - green = `(byte & 0x38) << 2`  (display bits 5-7)
    - blue  = `(byte & 0xC0) << 3`  (display bits 9-10) + bit 11 from field
- **Output layout:** display convention `0bBBB0_GGG0_RRR0` (white `$0EEE`).
- **Loader chain:** scene reads 4 palette indices (byte each) -> `LoadPalettes`
  ($135C) decodes into `$FF8B58+` (colors 1-15; color 0 stays black) ->
  `AdjustPaletteWord` ($594A) applies R/G/B fades/flashes -> working buffer
  `$FF8BD6` -> CRAM upload ($5370).
- **Tools:** `tools/extract_palettes.js` (ROM -> JSON), `tools/decode_palette.js`.

## Text / dialogue encoding (partial)

Dialogue is ASCII with control bytes, driven by a dictionary of common words:
- Dictionary: 169 NUL-terminated words at ROM `$022026` (Alsedo, Amulet, ...,
  "you"). Dialogue strings reference words with `0x0C xx` (xx = index);
  codes >= dict length are effect/control commands (some also control-color).
- Control bytes: `0x09` = line break, `0x02` = ellipsis/continue,
  `0x0B xx` / `0x10 xx` = speaker/effect controls, `0x00`/`0x05` = end of
  string. `0x02`-style markers and `[03]`-style byte codes appear in-line.
- Tool: `tools/extract_text.js` (ROM -> JSON; best-effort dictionary decode;
  unresolved codes kept as `<0c:xx>` placeholders).
- Fully resolving the effect controls requires tracing the text-renderer.

## Z80 sound driver ($98000-$99A76) — disassembled

- Full Z80 disassembly annotated in `src/z80_driver.asm` (bit-exact `dc.b`
  per byte + Z80 mnemonic comments on instruction starts).
- `tools/z80dis.js` is a full Z80 disassembler (CB/DD/FD/ED prefixes).
- Structure: reset entry (DI, IM 1), memcpy helper, RST handler stubs,
  repeated `EX (SP),HL` command stubs, main init ($003B clears work RAM at
  $1B80+, sets up YM2612), and a channel-processing loop ($070B iterates
  channels at $1C80+0x40n).
- YM2612 writes: wait-for-busy loop on port $4000, then reg->$4000,
  data->$4001 (`YM2612Write` at z$06CB, `YM2612WriteRegs` at z$06F7).
  DAC/sound select port $6000.
- Labels: Z80DriverReset, Z80CopyBlock, Z80Rst18Handler, Z80DriverInit,
  YM2612Write, YM2612WriteRegs (approximate names; deeper semantics open).

## $02482C+ compressed blocks — PARTIAL

- 14 large blocks in `$02482C-$03FFFF`, delimited by `0xFF7A`/`0xFF7B`
  terminator words (block 1 `$02482C-$025124`, block 2 `$025126-$0289B5`, ...).
- Block 1 has a front table `$02482C-$024835` = 4 relative offsets + `$FF7B`;
  the offsets point into the block. Later blocks have no such header.
- Not the tile-stream (tag $00) nor map (tag $02) compression — both decoders
  over-consume/divert. A separate format; decompressor lives in the
  undisassembled $A000-$20000 code. Open.

## Map rendering (palette + tile-order status)

- `tools/render_maps.js` renders all 682 maps to `maps/png/` (palette index 0
  by default; `png_pal1..3` comparison sets for 20 maps).
- **Palette verified via emulator attract mode:** the attract gameplay frames
  use exactly ROM palette 0 (`$0E68,$0E80,$0EEE,$0444,$0666,...`), which is the
  default render — so the decoded palette + CRAM layout are correct.
- **Tile order is approximate:** map values index into the scene's VRAM
  tileset (a scene-specific ordering of tile blocks), not simply the
  concatenated tag-$01 blocks. Renders are structurally coherent but exact
  on-screen matching needs the scene->tileset ordering (scene descriptors are
  consumed by undisassembled $A000-$20000 code).

## Open items

- Scene -> tileset/palette mapping for rendering maps with correct graphics.
- tag $00 tile-stream **compressor** (for the rebuild pipeline; original
  streams are kept as-is for bit-perfect builds).
- Text/control encoding ($020000-$0211C9 records; quiz/names tables).
- Compressed-data blocks at $02482C+ (0xFF7A/0xFF7B terminators) — separate
  format from the tile streams.
- Z80 sound driver semantics ($98000+).
- Rebuild pipeline: tile/palette inject done; maps/text + recompression +
  pointer/alignment fixes pending.
