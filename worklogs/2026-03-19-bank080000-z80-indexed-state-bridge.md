# 2026-03-19 bank080000 Z80 indexed state bridge

- Tightened the next proven Z80 main-body frontier in `src/bank080000_z80_program.asm` from `0x098976` through `0x098B7E`.
- `0x098976-0x098A07` is now source-visible as another IX-local countdown/pointer updater. When its local timer expires it reloads bytes through `+0x2A/+0x2B`, peels the fetched control byte into a low-nibble countdown at `+0x2C` plus an upper-band value at `+0x30`, and refreshes the derived byte at `+0x28` from that band plus the existing `+0x1C` state.
- `0x098A08-0x098AA8` now stands explicitly as dispatch target `0x0A08`: it indexes the fixed 19-byte bank-local record family rooted at local `0x1281` (ROM `0x099281`), mirrors changed bytes through `0x06C8`, calls the fixed-output helper at `0x067C`, then emits four triplet-spaced row updates through `0x0667` / `0x06C7` before returning via `0x06E2`.
- `0x098AA9-0x098AB1` is now explicit as a tiny fixed-output prelude that seeds `+0x29` with `0x78`, writes `0xDF` to `0x7F11`, and falls straight into the next initializer.
- `0x098AB2-0x098B5A` now stands explicitly as dispatch target `0x0AB2`: it seeds several IX-local state fields from compact bank-local records rooted at local `0x1828`, `0x188F`, `0x1901`, and `0x19D8`, initializes paired primary/secondary stream bytes, then calls `0x0B5B`, writes literal byte `0x32`, and returns.
- `0x098B5B-0x098B65` now resolves `HL = 0x1BF7 + [0x1BF6]`, and `0x098B66-0x098B7E` scales that indexed scratch byte through a fixed shift/add recurrence, adds `0x7F`, stores it back, and returns.
- The unresolved Z80 main-body continuation now starts at `0x098B7F` rather than `0x098976`, giving the next pass a smaller opaque bridge before the later `JP $0F8C` target and embedded data-heavy region.
