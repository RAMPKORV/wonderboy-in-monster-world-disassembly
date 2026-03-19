# 2026-03-19 bank080000 Z80 marked slot bridge

- Tightened the next proven Z80 main-body frontier in `src/bank080000_mid_z80_program.asm` from `0x098B7F` through `0x098CA4`.
- `0x098B7F-0x098B9B` now stands explicitly as a sweep across ten `0x1EC0`-rooted `0x20`-byte slot records, incrementing the shared counter at `0x1C07` and calling the neighboring updater only for active entries whose flags still carry bit 7.
- `0x098B9C-0x098CA4` now advances one marked slot record: if bit 6 is still clear it seeds several countdown/state bytes, preserves only the low bit of `(IX+0x11)`, reloads the pointed stream at `+0x06/+0x07` when the slot-local word at `+0x02/+0x03` expires, snapshots the local base word into `0x1C18/0x1C19`, and dispatches the next control byte through the local `0x0E62` handler table or the neighboring `0x0E55` / `0x0CA5` helper paths.
- The unresolved Z80 main-body continuation now starts at `0x098CA5` rather than `0x098B7F`, leaving the next pass focused on the downstream local-handler table and its slot-state consumers.
