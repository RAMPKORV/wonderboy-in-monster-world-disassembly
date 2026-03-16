# Toolchain Decision

## Selected Assembler

Use `ASM68K` for the bootstrap phase.

## Why ASM68K

- The sibling Vermilion project already builds with `ASM68K`, so the workflow and batch
  scripts transfer directly.
- The earliest Wonder Boy baseline only needs exact `dc.*`, `include`, and `incbin`
  behavior, which `ASM68K` handles without extra compatibility shims.
- Keeping the same assembler during phase 0 reduces risk while the ROM is still mostly
  opaque binary data.

## Current Setup

- `asm68k.exe` is copied into the repo root from `E:\Romhacking\vermilion\asm68k.exe`.
- `build.bat` and `verify.bat` call the assembler directly from the working tree.

## Revisit Criteria

Re-evaluate VASM or AS only if a later split exposes an `ASM68K` output mismatch, an
unsupported macro pattern, or workflow friction severe enough to outweigh proven
bit-perfect output.

## ASM68K Encoding Notes

- For 68000 absolute-short work-RAM operands in the `0xFFFF8000-0xFFFFFFFF` window,
  `ASM68K` accepts the `.w` form only when the operand is expressed as a signed 16-bit
  value such as `($FFFF8A49).w` or an equivalent negative `equ`.
- Using a positive 24-bit RAM constant like `$00FF8A49` without an explicit `.w`
  signed alias causes `ASM68K` to widen the operand to absolute long, which breaks
  bit-perfect rebuilds in the VBlank/task-dispatch block.
- `incbin` supports offset and length operands directly (`incbin "file",start,length`),
  so front-of-blob source splits can preserve the untouched tail in-place once the
  exact instruction encodings are authored correctly.
