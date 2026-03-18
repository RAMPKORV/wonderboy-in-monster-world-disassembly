# 2026-03-18 bank040000 fixed-stride families

- Split the repeated `0x4C0`-byte islands inside the bank `0x040000` same-bank table-targeted
  payload into dedicated ROM-order modules instead of leaving them mixed into the larger irregular
  payload files.
- The first eight-record run at `0x04BFAA-0x04E5A9` now lives in
  `src/bank040000_payload_stride_04bfaa.asm`.
- The isolated `0x4C0`-byte record at `0x05C5DA-0x05CA99` now stands alone in
  `src/bank040000_payload_stride_05c5da.asm`, which makes its relationship to the later stride
  run explicit instead of hiding it among unrelated record sizes.
- The later eight-record run at `0x05D630-0x05FC2F` now lives in
  `src/bank040000_payload_stride_05d630.asm`, and the short final two-record run at
  `0x06B192-0x06BB11` now lives in `src/bank040000_payload_stride_06b192.asm`.
- Kept the labels structural. The current proof is still shape and ownership: the flagged table at
  `0x041000` targets each start monotonically, and every record in these families is exactly
  `0x4C0` bytes long. That is enough to justify family-level module boundaries even though the
  loader and higher-level resource meaning remain unresolved.
