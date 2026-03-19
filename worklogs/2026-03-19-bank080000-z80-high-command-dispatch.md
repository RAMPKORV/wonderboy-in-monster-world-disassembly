# 2026-03-19 bank080000 Z80 high command dispatch

- Tightened the next proven Z80 main-body frontier in `src/bank080000_mid_z80_program.asm` from `0x098CA5` through `0x098F8B`.
- `0x098CA5-0x098D80` now stands explicitly as a descriptor/slot-to-record bridge that seeds one `IY`-local record either from a 6-byte descriptor family rooted at local `0x19F1` or from the current `IX` slot plus the existing candidate-selection helpers at `0x040D` / `0x0446`.
- `0x098D81-0x098E12` now closes that bridge with a shared `IY`-record initializer: it stores the working base word, calls the helper at `0x0E1B`, derives countdown bytes at `+0x3C/+0x3D`, mirrors slot ids/counters, and commits the initialized record.
- `0x098E1B-0x098E61` is now explicit as the nearby support band: a two-page mode-table reader, a 16-byte low-nibble scale table, a triplet-write-pointer helper, and a triplet append helper that writes `[lo][hi][tag]` triplets into the `IX+0x14` area.
- `0x098E62-0x098F8B` now exposes the local high-command dispatch family for raw bytes `$E0..$FF`, including the 32-entry little-endian dispatch table, handlers that load or combine inline bytes/words into `IX`-local state, and the backward triplet walker at `0x098F56-0x098F8B`.
- The unresolved Z80 main-body continuation now starts at `0x098F8C` rather than `0x098CA5`, leaving the next pass focused on the state-save / loader-owned tail immediately before the odd-aligned lookup tables.
