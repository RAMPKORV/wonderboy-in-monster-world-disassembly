# 2026-03-18 bank080000 command mid bridges

- Tightened two more opaque bridges inside the tail-bank `0x09C008-0x09E027` command window without forcing a
  subsystem guess.
- `src/bank080000_mid_command_tail_mid.asm` now source-authors sixteen more FF-terminated records as explicit
  `dc.b` data instead of raw `incbin` slices across `0x09DA43-0x09DB5A` and `0x09DCD6-0x09DE57`.
- The first pocket at `0x09DA43-0x09DB5A` now reads as one compact `F4/F1/F5` family with short
  `0xBx/0x5x` and `0xAx/0x4x` high-byte pair ladders, two tiny literal-control pivots, and one longer mixed
  literal-plus-high-byte continuation before the next local-target setup record at `0x09DB5B`.
- The second pocket at `0x09DCD6-0x09DE57` is now clearer as a short local neighborhood of related records:
  one `0x05/0x0D` literal-control pair family, two adjacent `0x60/0x65/0x6C/0x6D` burst records, a compact
  local-target sweep, and three pair-ladder continuations before the next setup record at `0x09DE58`.
- Kept the names structural. The new proof is still local command shape and ownership inside the middle
  command window, not yet a loader-proven subsystem like audio, credits, animation, or another interpreter.
