# 2026-03-18 bank080000 command tail ladders

- Tightened another opaque pocket inside the tail-bank `0x09E028-0x09F776` command window without forcing a
  subsystem guess.
- `src/bank080000_mid_command_tail_tail.asm` now source-authors five more FF-terminated records as explicit
  `dc.b` data instead of raw `incbin` slices: the compact low-byte ladder pair at `0x09E6B2-0x09E6E1`, the
  neighboring local-seed plus low-byte ladder pair at `0x09E73F-0x09E791`, and the later local-target sweep /
  high-byte pair pocket at `0x09F0AE-0x09F18B`.
- `0x09E6B2-0x09E6E1` now reads as two short FF-terminated records with the same compact `F4/F1/F5` framing as
  nearby repeated-shape clusters, but with narrower low-byte ladders and `C0/C2/C4/C6` control pockets.
- `0x09E73F-0x09E791` now stands explicitly as one E3-seeded short record followed by a longer low-byte ladder
  continuation, which clarifies the local cadence just before the larger `0x09E792+` record.
- `0x09F0AE-0x09F18B` is now split into a compact local-target sweep, one short `0xA1/0xA3` high-byte pair
  ladder, and one longer `0x9x/0x3x` high-byte pair sweep with a small `C2/F1` pivot in the middle.
- Kept the names structural. The new proof is still local command shape and ownership inside the tail command
  window, not yet a loader-proven subsystem like audio, credits, or animation.
