# 2026-03-18 bank040000 front blocks

- Split the former single bank-front `incbin` at `0x040000-0x0409F9` out of `src/bank040000.asm`
  into a dedicated ROM-order module, `src/bank040000_front_blocks.asm`.
- Replaced the old bank-front monolith with a unique lead-in at `0x040000-0x0400FF` plus six
  smaller structural slices starting at `0x040100`, `0x04025C`, `0x040400`, `0x04053C`,
  `0x0406C4`, and `0x0408D4`.
- Those starts are weaker than the table-proven boundaries later in bank `0x040000`, but they are
  still useful conservative structure: each begins with a short header-like prefix that recurs in
  the same front slice (`FFFF 000A`, `FFFF 000E`, or `0000 0102` near a later `FFFF 001E/000E`
  pocket).
- Kept the labels structural and recorded the uncertainty in `docs/open_questions.md` instead of
  forcing a subsystem guess before the consumer for the `0x040000` front island is known.
