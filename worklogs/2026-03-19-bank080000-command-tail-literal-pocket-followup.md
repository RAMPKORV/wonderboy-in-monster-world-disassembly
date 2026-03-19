# 2026-03-19 bank080000 command tail literal pocket follow-up

- Tightened the next adjacent late-tail pocket in bank `0x080000`'s `0x09E028-0x09F776` command window
  without forcing a loader guess.
- `src/bank080000_mid_command_tail_tail.asm` now source-authors the former raw
  `0x09E385-0x09E604` run as sixteen explicit FF-terminated records instead of sixteen `incbin` slices.
- `0x09E385-0x09E404` now stands as a short `F4 08` literal crest followed by two compact
  `F4 00` literal-control rows.
- `0x09E424` is now explicit as a longer local-control / local-offset prelude that falls into a repeated
  `0x2B/0x2A/0x29/0x28` literal-pair ladder.
- `0x09E4EE` follows with a compact local-target setup into a short `0x3E/0x40/0x41/0x42` rise, while
  `0x09E50C` expands into a broader `0x43/0x47/0x48/0x4A/0x4C` literal/high-byte ladder.
- `0x09E599-0x09E604` then narrow back into a short local-control-to-literal descent around
  `0x53/0x58/0x56/0x4F` plus a final small `0x60/0x0F/0x10/0x05` burst.
- Kept the naming structural. The bytes now make another bridge in the tail-bank command family readable,
  but the owning loader and subsystem for the wider `0x099B00-0x09F776` interpreter still are not proven.
