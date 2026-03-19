# 2026-03-19 bank080000 command front high-byte follow-up 2

- Tightened the next adjacent front-window pocket in bank `0x080000` without forcing subsystem ownership.
- `src/bank080000_mid_command_tail_front.asm` now source-authors the former raw `0x09B702-0x09B8C6` continuation as eight explicit FF-terminated records instead of eight `incbin` slices.
- `0x09B702-0x09B727` now stands explicitly as a short `F4 04` literal/high-byte ladder around `0x45/0x49/0x4A/0x4C/0x50/0x51`, followed by a tiny `CA FA` cap at `0x09B723`.
- `0x09B728-0x09B7C1` now reads as a broader local-control bridge into a denser `0x4F/0x4D/0x4C/0x4A/0x48/0x47/0x45/0x43/0x41/0x40/0x3E` literal/high-byte descent, with a shorter `0x51/0x4C/0x53/0x48/0x4A` continuation at `0x09B78D` and another tiny cap at `0x09B7BD`.
- `0x09B7C2-0x09B83D` now keeps a repeated `0x39/0x40/0x41/0x42/0x3B/0x3C/0x3D/0x3A` literal-row cycle explicit, including the short `E2 2A` and `E2 A8` local-offset hops near the tail.
- `0x09B83E-0x09B8C6` closes the pocket as a compact local-control bridge into two `F4 04` literal-row ladders centered on `0x30/0x37/0x39/0x3C` and `0x32/0x35/0x3B/0x3E/0x40/0x41/0x43`.
- Kept the names structural. The wider loader path into the `0x099B00-0x09F776` command region is still unproven, so the new labels stay anchored to byte-local behavior rather than subsystem guesses.
