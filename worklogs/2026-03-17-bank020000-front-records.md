# 2026-03-17 bank020000 front-record decomposition pass

- Followed the already source-authored bank-relative offset tables in `src/bank020000_offsets.asm`
  back into their target ranges instead of leaving the whole `0x020000-0x0211C9` front bank slice as
  one monolithic `incbin`.
- Added `src/bank020000_front_records_a.asm` for the 52 ROM-order starts proved by
  `Bank020000_BankRelativeTextOffsetTableA_0211DA`, making `0x0201D0-0x020539` explicit as short
  record slices rather than anonymous front-bank bytes.
- Added `src/bank020000_front_records_b.asm` for the 131 live ROM-order starts proved by
  `Bank020000_BankRelativeTextOffsetTableB_021258`, making `0x020E4C-0x0211C9` explicit as another
  dense record family before the front index island itself.
- Kept the new labels structural. The two offset tables prove stable boundaries and ROM order, but the
  target bytes still mix text fragments with undecoded control payloads, so the safer current names are
  bank-relative text/control records rather than a forced dialogue, quiz-host, or script subsystem.
- This pass narrows the remaining coarse front-bank gaps to `0x020000-0x0201CF` and
  `0x02053A-0x020E4B`, which is a much better base for the next consumer-driven recovery pass.
