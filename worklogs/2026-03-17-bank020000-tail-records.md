# 2026-03-17 bank020000 tail-record continuation pass

- Split the front `0x024538-0x02482B` slice out of the remaining coarse bank `0x020000` tail into
  `src/bank020000_tail_records.asm`.
- Confirmed this span is not an unrelated opaque blob after `0x024537`: it continues the same local
  `$FFFF`-delimited big-endian word-record cadence already exposed in `src/bank020000_records.asm`.
- The front record at `0x024538` is especially useful because it reuses several mixed control-like words
  already visible nearby, including repeated `$E001/$E010/$E012/$E021/$E031/$E042/$E071` patterns,
  `$D301` words, and embedded `$FF00` markers before the final `$FFFF` terminator.
- The following eight shorter records keep the same structural fit as the earlier band: pointer-like or
  offset-like front words followed by compact word tuples and a trailing `$FFFF` sentinel.
- Kept the labels structural rather than subsystem-specific. This pass proves one larger ROM-order record
  family reaching through `0x02482B`, but the code that scans these sentinels and interprets the mixed
  control words still needs to be recovered before stronger names are safe.
