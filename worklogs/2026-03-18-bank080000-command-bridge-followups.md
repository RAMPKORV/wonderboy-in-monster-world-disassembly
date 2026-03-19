# 2026-03-18 bank080000 command bridge followups

- Tightened two more opaque bridge pockets inside the bank `0x080000` command-tail body without forcing a
  subsystem guess.
- `src/bank080000_mid_command_tail_mid.asm` now source-authors `0x09DB5B-0x09DBCB` as explicit `dc.b`
  data instead of three raw `incbin` slices.
- That mid-window bridge now reads as one compact setup/local-target sweep that reuses `E0/E1`-tagged
  local steps before ending in a short repeated literal row, followed by two neighboring compact
  literal-row continuations with the same `F4/C4/F1/F5` framing and one tiny `C2/F1` pivot.
- `src/bank080000_mid_command_tail_tail.asm` now source-authors `0x09F51D-0x09F596` as explicit `dc.b`
  data instead of three raw `incbin` slices.
- That late-tail bridge now exposes one more compact `CA/DF/FE`-style local-control sweep at `0x09F51D`,
  followed by a short `F4 00 C2` literal/control pair at `0x09F561` and `0x09F57C` that varies the same
  local `0x60/0x65/0x6C/0x0F` pocket immediately before the already explicit repeated-burst family at
  `0x09F597`.
- Kept the names structural. The new proof is still local command shape and ownership inside the tail-bank
  command windows, not yet a loader-proven subsystem like audio, credits, animation, or another
  interpreter.
