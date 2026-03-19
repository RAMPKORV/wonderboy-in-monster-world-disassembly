# 2026-03-19 bank080000 Z80 selection finalizer

- Tightened the next proven Z80 main-body frontier in `src/bank080000_mid_z80_program.asm` from `0x098446` through `0x0984B0`.
- `0x098446-0x098468` is now source-visible as a post-selector bridge that calls `0x0436`, stores the derived local selector in `0x1C11`, and for the low six-value case also splits a doubled low-bit flag into `0x1C10` before branching on `(IX+1)`.
- `0x098469-0x09848B` now exposes two direct finalize/update paths for `(IX+1) >= 2`: the equal case writes `0x78` to the IX-local byte at `+0x29` and emits a `0x9F`-based byte to `0x7F11`, while the greater-than case uses the nearby `0x1C13` latch and a fixed `0xFF` write to that same destination before clearing the active slot.
- `0x09848C-0x0984B0` is now explicit as the `<2` cleanup path that feeds `B = 0x80/0x84/0x88/0x8C` with `C = 0xFF` through `0x06C8`, conditionally calls `0x06E2` when bit 1 of the IX-local status byte is clear, and then retires the current slot.
- The unresolved Z80 main-body continuation now starts later at `0x0984B1`, which is a cleaner next frontier than `0x098446` because this whole branch-owned selection finalizer is no longer hidden.
