# 2026-03-19 bank080000 command mid row families

- Tightened the next adjacent middle-window pocket in bank `0x080000` without forcing subsystem meaning.
- `src/bank080000_z80_command_records_b.asm` now source-authors the former raw run at
  `0x09CFBD-0x09D341` as nineteen explicit FF-terminated records instead of `incbin` slices.
- `0x09CFBD-0x09D093` now reads as one denser `F4 F0` literal-row cycle followed by a compact `F4 20`
  row-family pocket with two tiny cap records.
- `0x09D098-0x09D1C6` is clearer too: one broader setup bridge now falls into a mixed `0x3C/0x3E/0x40/0x41`
  literal-row family, a neighboring setup record exposes a compact `0xAC/0xAA/0xA8/.../0xA1` high-byte
  ladder, and `0x09D1C6` returns to a longer literal-row descent around `0x3C/0x3B/0x39/0x37/0x35/0x34/0x32/0x30`.
- The final `0x09D240-0x09D330` bridge now stands explicitly as a short literal-control family around
  `0x0F/0x71/0x0D/0x0C` followed by a repeated `F4 FC` pair-ladder cluster that leads directly into the
  already explicit `0x09D342+` continuation.
- Kept the new labels structural. The surrounding command cadence is easier to audit in source, but the loader
  path and subsystem owner for the wider `0x099B00-0x09F776` interpreter still need control-flow proof.
