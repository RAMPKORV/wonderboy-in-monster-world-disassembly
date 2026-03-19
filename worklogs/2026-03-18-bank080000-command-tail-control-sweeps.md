# 2026-03-18 bank080000 command tail control sweeps

- Tightened another opaque pocket inside the tail-bank `0x09E028-0x09F776` command window without forcing a
  subsystem guess.
- `src/bank080000_mid_command_tail_tail.asm` now source-authors sixteen more FF-terminated records as explicit
  `dc.b` data instead of raw `incbin` slices across `0x09F272-0x09F4D4`.
- The first and last records in that pocket (`0x09F272` and `0x09F489`) now read as compact local-control
  sweeps: each reuses the same `CA DF FA FE / DF FA FE` pocket and then walks a short `D0`-prefixed ladder
  through nearby `F1`/`F2`/`F3`/`F4` controls before the final `0xFF` terminator.
- The middle run at `0x09F2A5-0x09F3C5` is now clearer as one local byte-pair family. It shares short
  `F4 18` / `F4 05` headers while swapping among `C4/C6/C8/C9/CF` controls and small `0xAx/0x4x` plus
  `0x4x/0x3x` pair ladders.
- The neighboring `0x09F3D6-0x09F459` records now stand explicitly as a short literal/control pocket family
  built around the same `0x45/0x47/0x48/0x4A/0x4C` literal band and compact FF-terminated control tails.
- Kept the names structural. The byte evidence now supports a clearer command-tail neighborhood, but it still
  does not prove whether the decoder belongs to audio, credits, animation, or another tail-bank interpreter.
