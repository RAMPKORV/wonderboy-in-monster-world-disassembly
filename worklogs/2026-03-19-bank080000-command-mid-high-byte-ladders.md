# 2026-03-19 bank080000 command mid high-byte ladders

- Tightened the bank `0x080000` mid command window one more step without forcing a subsystem guess.
- `src/bank080000_mid_command_tail_mid.asm` now source-authors the former raw `0x09DFB4-0x09E027` run as two
  explicit FF-terminated records instead of two `incbin` slices.
- Both records stay in the same compact `F4 08` command neighborhood already proven at `0x09DF2B`, but the
  first record is mostly short `0xAC/0xAB/0xAA` to `0xA7/0xA5/0xA4/0xA3/0xA0` high-byte pair sweeps with
  repeated `F5 FB` pivots, while the second shifts into a denser descending `0xA7/0xA5/0xA3/0xA1/0xA0/0x9E`
  `0x9C/0x9B` tail.
- Kept the naming structural. The ROM-order ownership and byte rhythm are now explicit, but the wider loader
  path into the `0x099B00-0x09F776` command region is still unproven, so the records are not yet assigned to
  audio, animation, credits, or another concrete subsystem.
