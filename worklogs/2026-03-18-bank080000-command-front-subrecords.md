# 2026-03-18 bank080000 command-front subrecords

- Tightened another opaque pocket inside the tail-bank `0x099B00+` command region without forcing a
  subsystem guess. The formerly incbin-backed `0x09A199-0x09A287` span in `src/bank080000_mid.asm`
  is now source-authored as FF-terminated command subrecords plus the two tiny non-terminated gaps
  between them.
- The first two records at `0x09A199-0x09A1BA` and `0x09A1BB-0x09A1D7` now expose the same local
  pattern already seen elsewhere in this command pocket: a short table-targeted FF-terminated lead-in
  followed by one larger FF-terminated command payload.
- The next two records at `0x09A1D8-0x09A1F1` and `0x09A1F2-0x09A22A` tighten further into three and
  five FF-terminated pieces respectively, which makes the local command cadence much clearer than the
  old one-record incbins.
- The bridge bytes at `0x09A22B-0x09A22C` now stand alone as a two-byte lead-in, and `0x09A26A` is now
  explicit as one standalone `0xFF` sentinel between neighboring command records.
- The remaining records at `0x09A22D-0x09A287` now also expose their internal FF-terminated slices in
  source, including the short trailing `F5 .. FE FF` tails at `0x09A284-0x09A287` and the lone
  non-terminated seven-byte tail at `0x09A263-0x09A269`.
- Kept the names structural. The new proof is about byte boundaries and local FF-delimited ownership,
  not yet whether this front command stream belongs to audio, credits, animation, or another banked
  interpreter.
