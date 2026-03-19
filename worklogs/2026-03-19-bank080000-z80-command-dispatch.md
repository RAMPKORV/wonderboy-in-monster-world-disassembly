# 2026-03-19 bank080000 Z80 command dispatch

- Tightened the first opaque slice inside bank `0x080000`'s Z80 program main body without forcing a sound-driver or subsystem guess.
- `src/bank080000_z80_program.asm` now exposes `0x098275-0x0982B9` directly in source instead of leaving the whole `0x09803B-0x09907A` main body behind one `incbin`.
- The key proof is local control flow: code at `0x0981C5-0x0981D0` complements raw bytes `$FA..$FF`, doubles the result into a word index, and dispatches through the little-endian table at `0x098275`, so the six entries there are now explicit as stable command targets for `$FF`, `$FE`, `$FD`, `$FC`, `$FB`, and `$FA`.
- Three of those targets are now partially source-visible too. `0x098282` is a tiny standalone handler, while `0x098288` and `0x09829C` both only load different inline 3-byte record tables (`0x09828D` and `0x0982B1`) before the shared tail at `0x09829F-0x0982B0` stores the chosen table base in `0x1C0E`, clears the active cursor/state words, and sets the mode byte at `0x1C09`.
- Kept the remaining dispatch targets at `0x0982BA`, `0x0982E2`, and `0x098369` incbin-backed for now. Their ownership is proven by the dispatch table, but the handler semantics and the field meaning of the 3-byte record tables still need the wider loader/decoder path.
- Updated `tools/index/rom_map.json`, `tools/index/function_index.json`, and `tools/index/symbol_map.json` so the new command-dispatch structure is visible in repo metadata as well as source.
