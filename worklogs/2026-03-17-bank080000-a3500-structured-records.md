# 2026-03-17 bank080000 `0x0A3500+` structured-record pass

- Tightened the back half of bank `0x080000`'s `0x0A0000-0x0A4C76` island without forcing a
  subsystem guess. The large table-targeted module `src/bank080000_a3500.asm` no longer treats every
  proven target as a raw sliced `incbin`.
- Promoted the compact cluster at `0x0A37B0-0x0A37FD` into explicit source-authored data: twelve fixed
  3-word records at `0x0A37B0-0x0A37F7`, followed by two standalone local-offset values encoded as
  3-byte records at `0x0A37F8` and `0x0A37FB`.
- Promoted the long run at `0x0A3B77-0x0A3C16` into explicit source-authored local-offset triplet
  records. Each entry is three local 24-bit offsets followed by `$FD`, and every pointed start lands
  back in the already split `0x0A12EC-0x0A1519` five-byte-tuple family.
- Promoted the later compact group at `0x0A4AA3-0x0A4AEB` into explicit source-authored data too:
  eight fixed 3-word records at `0x0A4AA3-0x0A4ACD`, followed immediately by an FF-terminated local-
  offset list at `0x0A4AD3-0x0A4AEB` that names those same eight starts.
- Promoted the following tail continuation at `0x0A4AEC-0x0A4C76` into explicit source-authored data as
  well. It starts with three standalone local offsets, then resumes the same compact local-offset/control
  motif with repeated `FC`/`FB`/`FE` prefix groups and short `FF`/`FD`-terminated local-offset lists.
- Those new tail lists cross-link back into several already split families instead of pointing only to the
  immediately preceding cluster: `0x0A0E85+`, `0x0A157B+`, `0x0A319E+`, `0x0A323F+`, and `0x0A3476+` all now
  show up directly in the authored bytes, which is a stronger structural fit than leaving the tail as forty
  one-line `incbin` records.
- Kept the labels structural. The new proof is stronger than simple monotone target starts, but still
  local: repeated word cadence, self-referential offset lists, and back-references into already split
  tuple families. That is enough to replace more raw slices with readable assembly while the loader and
  higher-level owner remain unresolved.
