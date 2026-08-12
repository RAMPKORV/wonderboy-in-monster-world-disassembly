# Asset Extraction & Rebuild Pipeline

Editable assets live in `assets/`; the build regenerates their data modules
from them. **Unmodified assets reproduce the original ROM bit-for-bit**; edited
assets flow through `build.sh` with no pointer changes (formats are fixed-size).

## Assets

| asset | source | derived modules | format |
|-------|--------|-----------------|--------|
| `assets/tiles.png` | 20 tile blocks (760 tiles) | `src/tile_blocks_0..4.asm` | indexed PNG, 38 tiles per row, one row per block; each tile 8x8, 4bpp planar (16 colors) |
| `assets/palettes.json` | 252 packed palettes | `src/palette_table.asm` | display-layout color words (`0bBBB0GGG0RRR0`), 16 per palette |
| `assets/tile_blocks.json` | block addresses | (read by regen_assets) | list of ROM addresses |

## Commands

```bash
node tools/extract_assets.js   # ROM -> assets/ (lossless; resets to original)
node tools/regen_assets.js     # assets/ -> src/tile_blocks_*.asm + src/palette_table.asm
./build.sh                     # regen_assets + regen_rest + asm68k -> out.bin
./verify.sh                    # hash-check out.bin vs game.rom (bit-perfect)
```

`build.sh` runs `regen_assets.js` + `regen_rest.js` automatically whenever
`assets/` exists.

## Workflow for a modder

1. `node tools/extract_assets.js` — extract current assets.
2. Edit `assets/tiles.png` (in an indexed editor; keep 16 colors per tile,
   keep the 20-row x 38-tile layout) or `assets/palettes.json`.
3. `./build.sh && ./verify.sh` — `verify.sh` will report a different hash
   (expected when assets change); boot `out.bin` in an emulator to check.

## Formats (bit-exact verified)

- **Tiles:** Genesis 4bpp planar, 32 bytes/tile (4 bitplanes x 8 bytes).
  Block = 38 tiles (0x4C0 bytes). Tag `$01` records of the flagged table at
  `$041000`. See docs/formats.md.
- **Palettes:** 17 bytes each. Bytes 0-1 = 15-bit blue-high field (bit c sets
  display bit 11 for color c+1; byte0 bit7 unused, preserved verbatim).
  Bytes 2-16 = 15 packed colors: r=`(b&7)<<1`, g=`(b&0x38)<<2`,
  b=`(b&0xC0)<<3` (+ bit 11 from field). Color 0 is implicitly `$0000`.

## Scope / limitations

- Fixed-size edits only (tiles stay 38/block, palettes stay 17 bytes). Adding
  tiles/palettes requires re-laying-out the affected regions and fixing the
  flagged table (`$041000`) and any other pointers — not yet automated.
- Text, maps (tag `$02`), and the `$02482C+` compressed blocks are not yet
  asset-wired.
