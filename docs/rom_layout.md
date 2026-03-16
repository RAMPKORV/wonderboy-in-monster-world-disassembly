# ROM Layout

## Coarse Regions

- `0x000000-0x0000FF` vector table
- `0x000100-0x0001FF` Mega Drive header
- `0x000200-0x004FFF` bootstrap and early startup code blob
- `0x005000-0x01FFFF` early engine/code-heavy body blob
- `0x020000-0x03FFFF` mid-ROM mixed code/data blob
- `0x040000-0x07FFFF` late-ROM mixed code/data blob
- `0x080000-0x0BFFFF` tail banks with heavy `0xFF` fill and likely large data banks

## Current Source Ownership

- `header.asm` owns `0x000000-0x0001FF`
- `src/init.asm` owns `0x000200-0x004B57` through `data/rom/init_000200_004b57.bin`
- `src/vblank.asm` owns `0x004B58-0x004FFF` through `data/rom/vblank_004b58_004fff.bin`
- `src/core.asm` owns `0x005000-0x01FFFF` through `data/rom/core_005000_01ffff.bin`
- `data/rom/bank_020000_03ffff.bin` mirrors `0x020000-0x03FFFF`
- `data/rom/bank_040000_07ffff.bin` mirrors `0x040000-0x07FFFF`
- `data/rom/bank_080000_0bffff.bin` mirrors `0x080000-0x0BFFFF`

## Observations

- The first `0x200` bytes are already source-authored and rebuild byte-identically.
- The tail quarter of the ROM contains a very high density of `0xFF` bytes, suggesting
  padding, sparse tables, or banked asset regions that should be mapped carefully before
  any hand rewrite.
- Long repeated-byte runs exist throughout the ROM, so future splits should document
  whether each run is padding, compressed data, or structured fill.

## Known Padding And Fill Hotspots

- Header padding spaces at `0x00013E-0x00014F`, `0x00016B-0x00017F`, and `0x0001BC-0x0001EF`
- Large `0xFF` runs at `0x01C602-0x01CBFF` and `0x0409FA-0x040FFF`
- Tail banks contain dense `0xFF` regions and should be treated as opaque until mapped
