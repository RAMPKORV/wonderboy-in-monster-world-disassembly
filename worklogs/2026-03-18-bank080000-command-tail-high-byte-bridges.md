# 2026-03-18 bank080000 command tail high-byte bridges

- Tightened another visible opaque pocket inside the bank `0x080000` tail command window without forcing a
  subsystem guess.
- `src/bank080000_mid_command_tail_tail.asm` now source-authors four more FF-terminated records as explicit
  `dc.b` data instead of raw `incbin` slices across `0x09E792-0x09E9A2`.
- The front record at `0x09E792-0x09E8C9` now reads as one longer `F7/F0` local-target sweep that hands off
  into repeated `0x9x/0xAx` high-byte ladders and several `E4`-tagged local-offset tails before `0xFF`.
- The next record at `0x09E8CA-0x09E925` keeps the same neighborhood but collapses into repeated
  `0x9F/0x9E` byte-pair rows with short `F5 FB` and `F5 05` variations plus a few late local-offset hops.
- The short bridge at `0x09E926-0x09E962` returns to the compact `CA/DF/FE` local-control sweep shape, and
  `0x09E963-0x09E9A2` follows with a denser literal/high-byte descent around the recurring
  `0x48/0x4A/0x4B/0x4D` family.
- Kept the names structural. The new proof is still local command shape and ownership inside the late tail
  window, not yet a loader-proven subsystem like audio, credits, or animation.
