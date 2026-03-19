# 2026-03-18 bank040000 fixed-stride families

- Split the repeated `0x4C0`-byte islands inside the bank `0x040000` same-bank table-targeted
  payload into dedicated ROM-order modules instead of leaving them mixed into the larger irregular
  payload files.
- The earlier isolated `0x045842-0x045D01` block now also stands alone in
  `src/bank040000_gfx_tiles_045842.asm`. It was easy to miss while the front payload still lived in
  one coarse module, but the same flagged table already marks it with tag `$01`, matching the later
  graphics-oriented families.
- The first eight-record run at `0x04BFAA-0x04E5A9` now lives in
  `src/bank040000_gfx_tiles_04bfaa.asm`.
- The isolated `0x4C0`-byte record at `0x05C5DA-0x05CA99` now stands alone in
  `src/bank040000_gfx_tiles_05c5da.asm`, which makes its relationship to the later tile run
  explicit instead of hiding it among unrelated record sizes.
- The later eight-record run at `0x05D630-0x05FC2F` now lives in
  `src/bank040000_gfx_tiles_05d630.asm`, and the short final two-record run at
  `0x06B192-0x06BB11` now lives in `src/bank040000_gfx_tiles_06b192.asm`.
- Follow-up byte review strengthens those modules from generic fixed-stride ownership to graphics-
  oriented ownership: every record is exactly `0x4C0` bytes (`38 * 0x20`), and sampled rows show
  stable 4bpp planar tile patterns rather than pointer or script structure.
- That same review now narrows one part of the flagged-table semantics too: every same-bank `$01`
  target in `src/bank040000_tables.asm` lands on one of these `0x4C0`-byte planar tile blocks,
  while `$00` and `$02` still remain unresolved structural tags.
- Kept the names conservative at tile-family level. The flagged table at `0x041000` still proves
  starts and ownership, but not yet whether these blocks are maps, sprites, font pages, UI art, or
  another graphics family.
