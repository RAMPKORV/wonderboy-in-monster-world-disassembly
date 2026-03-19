# 2026-03-18 bank080000 command tail late pocket

- Tightened another opaque pocket inside the tail-bank `0x09E028-0x09F776` command window without forcing a
  subsystem guess.
- `src/bank080000_mid_command_tail_tail.asm` now source-authors sixteen more FF-terminated records as explicit
  `dc.b` data instead of raw `incbin` slices across `0x09E9E7-0x09ECD5`.
- `0x09E9E7` now stands as one longer `F4 1B` literal/high-byte ladder continuation that reuses the recurring
  `0x43/0x46/0x48/0x4A/0x4D` band before ending in a short repeated `0x4A/0x56` tail.
- `0x09EA5F` and `0x09EBDB` now read as two more compact local-control sweeps that walk same-window targets and
  then fall into short high-byte-pair or literal/control bursts before the final `0xFF` terminator.
- The records at `0x09EAA0-0x09EAEA` are now explicit as one short `F4 1F` high-byte ladder family, while the
  neighboring `0x09EB07-0x09EB41` trio narrows into a compact literal-descent run with the same local framing.
- `0x09EB51` and `0x09EB99` now expose two denser literal/high-byte pockets, and `0x09EC4A-0x09EC93` closes the
  pocket with three tiny literal/control rows plus one alternating local-control bridge that ends in an
  `E3 80 01`-seeded literal tail.
- Kept the names structural. The new proof is still local command shape and ownership inside the tail-bank
  command window, not yet a loader-proven subsystem like audio, credits, or animation.
