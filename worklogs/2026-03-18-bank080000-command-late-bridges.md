# 2026-03-18 bank080000 command late bridges

- Tightened two more visible opaque pockets inside the bank `0x080000` command windows without
  forcing a subsystem guess.
- `src/bank080000_z80_command_records_b.asm` now source-authors `0x09DE58-0x09DFB3` as explicit
  `dc.b` data instead of three raw `incbin` slices.
- That middle-window follow-up now reads as one compact `F6/F7/F0` local-target setup bridge at
  `0x09DE58`, followed by a longer repeated `0x9x/0xAx` high-byte ladder around a recurring
  `B4 59` anchor at `0x09DF2B` and a short descending high-byte tail at `0x09DF92`.
- `src/bank080000_z80_command_records_c.asm` now source-authors `0x09E6E2-0x09E6F6` plus
  `0x09E9A3-0x09E9E6` as explicit `dc.b` data instead of four raw `incbin` slices.
- Those late-tail follow-ups make one more compact low-byte ladder bridge explicit at `0x09E6E2`,
  then expose a short `F4 1B` literal-descent pocket across `0x09E9A3-0x09E9E6` with two smaller
  neighboring continuations at `0x09E9CC` and `0x09E9DA`.
- Kept the names structural. The new proof is still local command shape and ROM ownership inside
  the unresolved tail-bank interpreter, not yet a loader-proven subsystem like audio, credits,
  animation, or another command-driven resource family.
