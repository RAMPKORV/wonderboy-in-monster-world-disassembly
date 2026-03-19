# 2026-03-18 bank080000 command mid clusters

- Tightened another opaque pocket inside the tail-bank `0x09C008-0x09E027` command window without forcing a
  subsystem guess.
- `src/bank080000_z80_command_records_b.asm` now source-authors fourteen more FF-terminated records as explicit
  `dc.b` data instead of raw `incbin` slices: the repeated-shape cluster at `0x09D981-0x09D9FE`, the second
  repeated-shape cluster at `0x09DBCC-0x09DC59`, and the neighboring singleton record at `0x09DE91-0x09DEA8`.
- The first cluster now reads as four adjacent `0x18`-byte records with the same compact `F4/F1/F5` framing,
  followed by two shorter FF-terminated continuations that keep the same pair-heavy payload style.
- The second cluster repeats that same local pattern with two adjacent `0x18`-byte records plus four shorter
  FF-terminated continuations, which makes the local cadence much clearer than the old incbin-backed slices.
- `0x09DE91-0x09DEA8` now stands explicitly as one more singleton FF-terminated record with the same framing,
  even though it does not yet prove a larger neighboring family.
- Kept the names structural. The new proof is about local record shape and ownership inside the mid command
  window, not yet whether the tail-bank interpreter belongs to audio, credits, animation, or another system.
