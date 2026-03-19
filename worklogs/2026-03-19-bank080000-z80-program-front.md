# 2026-03-19 bank080000 Z80 program front

- Tightened the front of bank `0x080000`'s `0x098000-0x0991FF` island without forcing a sound-driver
  guess.
- Renamed `src/bank080000_mid_z80.asm` to `src/bank080000_z80_program.asm` because the opening bytes
  now prove a real Z80 program front rather than a merely Z80-like blob.
- `0x098000` now stands explicitly as a reset-style entry that opens on `DI`, `IM 1`, and an absolute
  jump to `0x09803B`.
- The former monolithic `0x098006-0x09803A` prelude is now split into a short returning front stub,
  one front stub cluster, and a tiny `NOP` / `RETI` handler at `0x098038` immediately before the main
  body.
- Kept the remaining `0x09803B-0x09907A` bytes grouped as the main program body. The local control-flow
  evidence is now strong enough for Z80-program ownership, but it still does not prove whether the owner
  is the sound driver or another Z80-resident subsystem.
- Tightened that front further without forcing a sound-driver claim: `0x098000-0x09803A` is now source-authored as
  explicit bytes instead of four tiny `incbin` slices.
- The front reset entry at `0x098000` remains the same `DI` / `IM 1` / `JP $003B` handoff, `0x098006` is now a
  direct source-visible returning stub, `0x098010-0x09801F` stays one mixed stub pocket, and the repeated
  `E3 2B E3 C3 8C 0F FF FF` runs at `0x098020`, `0x098028`, and `0x098030` are now explicit as three separate
  absolute jump stubs immediately before the tiny `NOP` / `RETI` handler at `0x098038`.
- Updated `tools/index/rom_map.json`, `tools/index/function_index.json`, and `tools/index/symbol_map.json` so the
  stronger Z80 front boundaries are reflected in the repo metadata as well as the assembly source.
