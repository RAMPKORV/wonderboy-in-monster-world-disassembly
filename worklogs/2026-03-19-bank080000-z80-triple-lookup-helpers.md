# 2026-03-19 bank080000 Z80 triple lookup helpers

- Tightened the next proven Z80 main-body frontier in `src/bank080000_mid_z80_program.asm` from `0x0984B1` through `0x09853B`.
- `0x0984B1-0x098515` is now source-visible as two neighboring helper variants that derive a small table index from the high nibbles of `D/E` plus the incoming `HL` base, read one local 3-byte record, and fold the residual through two rounded halves before returning an adjusted `DE` pair.
- The only proven difference between the two helpers so far is which loaded byte is subtracted before the first halving step, so the new names stay structural rather than forcing a subsystem-specific role.
`0x098516-0x09853B` is now explicit as a compact threshold bucketizer: values `>= 0x60` take a fixed return path, while lower values peel through `0x30`, `0x18`, and `0x0C` cutoffs, accumulate a small band id in `C`, and leave the reduced high-byte remainder in `D`.
- The unresolved Z80 main-body continuation now starts later at `0x09853C`, which is a cleaner next frontier than `0x0984B1` because this whole lookup-and-bucketing bridge is no longer hidden.
