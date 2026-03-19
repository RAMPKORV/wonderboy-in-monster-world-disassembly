# 2026-03-19 bank080000 Z80 paired stream bridge

- Tightened the next proven Z80 main-body frontier in `src/bank080000_mid_z80_program.asm` from `0x098772` through `0x098975`.
- `0x098772-0x098865` is now source-visible as a primary IX-local stream/state updater. Bytes below `$F8` load a countdown plus delta word, while `$FF` reloads HL from the stream, `$FE/$FD` manage a nested countdown plus saved pointer, `$FC` subtracts the current delta word, `$FB` reloads that delta word, and `$FA/$F9` clear or reload local counters before the shared state store at `0x098865`.
- `0x09886E-0x0988A0` now conditionally folds the extra IX-local offset word at `+0x1A/+0x1B` into the working base cached at `0x0C/0x0D` when bit 4 is set in the IX-local flags byte.
- `0x0988A1-0x0988CD` now resolves a secondary target word into `+0x08/+0x09`: when `0x3F` is nonzero it calls `0x0B66`, repeatedly doubles the returned signed base step, and then adds the current base plus the fixed `+0x26/+0x27` offset.
- `0x0988CE-0x098961` mirrors the same command-driven pattern for a secondary stream with step-byte state rather than the earlier delta-word pair.
- `0x098962-0x098975` is now explicit as the shared post-update dispatch: nonzero `(IX+1)` routes through `0x0976`, then a bit-7 gate on the IX-local flags byte decides whether the deeper `0x053C -> 0x05BA` path should run.
- The unresolved Z80 main-body continuation now starts later at `0x098976`, and the metadata/docs were refreshed to match.
