# 2026-03-19 bank080000 Z80 main-body prelude

- Tightened the remaining front-Z80 hole in `src/bank080000_z80_program.asm` from `0x09803B` through `0x098274`.
- The former `incbin` now stands directly in source as a startup / sequencing / slot-management bridge instead of one anonymous prelude.
- `0x09803B-0x0980E1` resets the `0x1B80+`, `0x1C80+`, and `0x1ED1+` work areas, emits fixed setup bursts through already proven output helpers, and enters a three-step warmup loop.
- `0x0980E2-0x09810A` is a short startup-burst helper plus an output-selector reset that clears the active output byte, selects page `2` in `0x1C10`, and pulses `RST 10` four times.
- `0x09810B-0x09815F` is a countdown-driven tick with a small wide-record phase initializer and an optional mirror from `0x1C2B` into `0x1C0B` when `0x1C2A` is nonzero.
- `0x098160-0x09820A` advances and consumes an inline control stream: bytes `$FA..$FF` dispatch through the later explicit meta-command table at `0x098275`, while smaller values below `$58` index the local pointer table at `0x099B01` and seed state at `0x1C14/0x1C16`.
- `0x09820B-0x098274` seeds or updates `0x1EC0`-rooted `0x20`-byte slot descriptors from inline pointer lists and the current selector byte at `0x1C28`, retiring lower-priority active slots before reloading their inline source pointers.
- This closes the last raw `incbin` inside `0x098000-0x09907A`; the remaining uncertainty in this owner is now loader-side subsystem ownership rather than local byte structure.
