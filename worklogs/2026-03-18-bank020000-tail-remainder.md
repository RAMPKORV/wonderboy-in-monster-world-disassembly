# 2026-03-18 bank020000 tail remainder split

- Split the former single bank-end remainder at `0x03C6E0-0x03FFFF` out of
  `src/bank020000_tail_blocks.asm` into a dedicated ROM-order module,
  `src/bank020000_tail_remainder.asm`.
- Replaced the old monolithic tail remainder with five smaller structural slices starting at
  `0x03C6E0`, `0x03E846`, `0x03EF4E`, `0x03F4D1`, and `0x03FE24`.
- The new internal starts are not terminator-proven like the earlier `0xFF7A` / `0xFF7B`
  blocks, but they are still conservative evidence-backed boundaries: each candidate start begins
  with a short header-like prefix already seen at earlier proven block starts in the same tail,
  specifically `0x0960`, `0x0F00`, or `0x0B60`.
- Kept the labels structural and documented the uncertainty in `docs/open_questions.md` instead
  of baking in a stronger subsystem guess. The next useful evidence target is still the loader or
  decompressor path that explains whether these later starts are true blocks, nested substreams,
  or format variants.
