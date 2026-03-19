# 2026-03-19 bank080000 command tail descending ladder

- Tightened the late tail-bank `0x09E028-0x09F776` command window one more step without forcing a subsystem
  guess.
- `src/bank080000_mid_command_tail_tail.asm` now source-authors the former raw `0x09EFD3-0x09F00A` run as one
  explicit FF-terminated record instead of a single `incbin` slice.
- The bytes fit the same compact `F4/F5` command neighborhood already proven around `0x09F00B+`, but this bridge
  is simpler: it walks a descending literal-pair ladder across `0x30`, `0x2F`, `0x2D`, `0x2B`, `0x29`, and
  `0x28` with repeated `C4/C6/C7` control pivots before the terminator.
- Kept the naming structural. The record shape and ROM-order ownership are now explicit, but the wider loader
  path into the `0x098000+` command region is still unproven, so the bytes are not yet assigned to audio,
  credits, animation, or another subsystem.
