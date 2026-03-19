# 2026-03-19 bank080000 command tail front-edge ladders

- Tightened the front edge of the bank `0x080000` tail command window one more step without forcing a subsystem guess.
- `src/bank080000_mid_command_tail_tail.asm` now source-authors the former raw `0x09E237-0x09E384` run as ten
  explicit FF-terminated records instead of ten `incbin` slices.
- `0x09E237` keeps the same short local-control sweep shape already seen nearby, then climbs through a compact
  `0x4F/0x51/0x52/.../0x5B` literal band.
- `0x09E264-0x09E2C0` now stand explicitly as one descending `AF/AE/AD` high-byte-pair family plus two short
  AC-rooted local-offset variants.
- `0x09E2C1` returns to a broader `F7/F0` local-control bridge before falling into a longer descending
  `0x57..0x4A` literal/high-byte ladder.
- `0x09E302-0x09E384` narrows into a short `F4 08` family: repeated AA/A9/A8 rows, one A7-centered pair ladder,
  one literal tail rooted on `0x5B/0x59/0x58/...`, and two tiny literal-band closers.
- Kept the naming structural. The ROM-order ownership is clearer, but the loader path into the wider
  `0x099B00-0x09F776` command region still is not proven enough to assign subsystem ownership.
