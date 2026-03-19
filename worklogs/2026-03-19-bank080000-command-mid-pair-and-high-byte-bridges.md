# 2026-03-19 bank080000 command mid pair and high-byte bridges

- Tightened the next adjacent middle-window pocket in bank `0x080000` without forcing subsystem meaning.
- `src/bank080000_z80_command_records_b.asm` now source-authors the former raw run at
  `0x09D342-0x09D5BE` as fifteen explicit FF-terminated records instead of `incbin` slices.
- `0x09D342-0x09D40F` now stays explicit as a continued `F4 FC` repeated-pair ladder neighborhood:
  two broader `0x29/0x30/0x35/0x37/0x32/0x34` row cycles, one mixed repeated-pair bridge, and one
  shorter `0x30/0x2B/0x37/0x39/0x35` tail.
- `0x09D429-0x09D464` now exposes the short local-target setup that feeds the next pocket, with compact
  same-window `D0/D1/D2` steps handing off into the later `F4 2C` family.
- `0x09D48A-0x09D5A9` is clearer too: the neighboring records now keep one compact `F4 2C` high-byte pair
  family explicit around `0x9E/0x9C/0x9B`, `0x99/0xA0/0x9E`, and a later `0x95/0x97/0x9C` to
  `0xAC/0xAA/0xA8/0xA6/0xA5/0xA3` tail, followed by two tiny literal ladders at `0x09D594` and `0x09D5A9`.
- Kept the naming structural. The ROM-order ownership and byte rhythm are now explicit, but the wider
  loader path into the `0x099B00-0x09F776` command region is still unproven.
