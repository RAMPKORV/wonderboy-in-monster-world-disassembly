# 2026-03-19 bank080000 command front lead-in

- Tightened the final raw lead-in pocket in bank `0x080000`'s `0x09A348-0x09C007` front command window without forcing subsystem ownership.
- `src/bank080000_z80_command_records_a.asm` now source-authors the former raw `0x09A348-0x09A3EB` run as six explicit FF-terminated records instead of six `incbin` slices.
- `0x09A348-0x09A34C` now stands explicitly as one tiny tuple lead-in, and `0x09A34D-0x09A360` follows as a compact local-control prelude before the first broader command pocket.
- `0x09A361-0x09A3D1` now resolves into the first front-window `F4 25` high-byte pair family around `0x97/0x99/0x95`, then `0xA0/0x9A/0xA1/0x9C`, while `0x09A3D2-0x09A3EB` closes with two short `0x9E/0xA0` pair tails immediately before the already explicit repeated-byte-pair record at `0x09A3EC`.
- Kept the naming structural. The wider loader path into the `0x099B00-0x09F776` command region is still unproven, but the whole `0x09A348-0x09C007` front window is now source-visible at FF-terminated record granularity.
