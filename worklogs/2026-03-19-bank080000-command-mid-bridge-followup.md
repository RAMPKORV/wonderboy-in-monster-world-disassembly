# 2026-03-19 bank080000 command mid bridge follow-up

- Tightened another middle-window pocket in bank `0x080000`'s `0x09C008-0x09E027` command body without forcing
  subsystem meaning.
- `src/bank080000_mid_command_tail_mid.asm` now source-authors the former raw `0x09C253-0x09C5B0` run as
  eighteen explicit FF-terminated records instead of eighteen `incbin` slices.
- `0x09C253` now stands explicitly as a compact alternating local-control bridge that falls into one short
  `F4 00` literal-row pocket around `0x30/0x2E/0x2B/0x31/0x34/0x35`, and `0x09C2BA-0x09C308` narrow that same
  neighborhood into three smaller literal-row continuations.
- `0x09C320-0x09C49B` now expose a neighboring mixed family: one compact local-target setup into a
  `0x37/0x3D/0x48/0x44/0x46` literal/high-byte row, short `F4 10` pockets around `0x54/0x4F/0x52` and
  `0x41/0x4D/0x4B/0x4A/0x48`, one denser local-control descent at `0x09C3B8`, and a later local-target /
  high-byte mix around the recurring `0x89/0x8B/0x90/0x91` plus `0xA0/0xA3/0xA4/0xA6` pairs.
- The later tail at `0x09C4B8-0x09C5B0` is clearer too: `0x09C4B8` now stands as one broader mixed
  literal/high-byte ladder around `0xA9/0x4C`, `0x9C/0x3D`, `0x99/0x3F`, and the recurring
  `0x43/0x41/0x40/0x97` pocket; `0x09C564-0x09C582` keep a shorter repeated literal ladder plus descending
  `0x9A/0x99/0x98/...` tail; and `0x09C5B0` returns to a compact local-control burst that repeats the same
  `0x60/0x10/0x05` literal-control row several times.
- Kept the naming structural. The ROM-order record ownership and recurring byte families are now explicit, but
  the wider loader path into the `0x099B00-0x09F776` command region is still unproven.
