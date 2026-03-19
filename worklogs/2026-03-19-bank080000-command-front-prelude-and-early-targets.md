# 2026-03-19 bank080000 command front prelude and early targets

- Tightened the very front of bank `0x080000`'s `0x099B00-0x09A347` command table without forcing subsystem
  ownership.
- `src/bank080000_z80_resources.asm` now source-authors the former raw `0x099BB0-0x099D04` stretch as explicit tuple-led,
  FF-terminated, and FD-bridged subrecords instead of ten `incbin` slices.
- The unreferenced prelude at `0x099BB0-0x099BD2` is now clearer in source: one standalone lead byte at
  `0x099BB0`, one tuple-led FF-terminated setup record at `0x099BB1`, and one short `F3 ... FD` bridge at
  `0x099BC6` that feeds the first table-targeted command at `0x099BD3`.
- The earliest table-targeted records at `0x099BD3-0x099C8E` now read as a repeated family of tuple-style
  FF-terminated headers plus compact FF-terminated control bodies, each followed by a short `FD xxxx` bridge into
  the next local target.
- The later `0x099C8F-0x099D04` pocket narrows into a short tuple-plus-control record with two `E2`-tagged data
  pockets, one neighboring tuple-led record that ends on a compact `F5/FE` trailer, one denser `DD`-bearing
  control record with its own `F5/FE` tail, and one final tuple-led bridge whose trailing `F6 02` bytes belong to
  the following `0x099D05` target.
- Kept the labels structural. The bytes now justify a cleaner source-owned start to the command front, but they
  still do not prove whether the wider `0x099B00-0x09F776` interpreter belongs to audio, credits, animation, or
  another tail-bank subsystem.
