# 2026-03-18 bank080000 command tail triplets

- Tightened two more repeated-shape pockets inside the tail-bank `0x09A348-0x09F776` command windows
  without forcing a subsystem guess.
- The repeated 24-byte triplets at `0x09AB2A-0x09AB71`, `0x09E6F7-0x09E73E`, and
  `0x09F4D5-0x09F51C` are now explicit `dc.b` records instead of raw `incbin` slices. Each triplet keeps
  the same compact `F4/F1/F5`-style framing while varying only the repeated byte-pair payload.
- The longer neighboring `0xAB`-byte records at `0x09A3EC-0x09A496` and `0x09E607-0x09E6B1` are also now
  source-authored. They use the same local command framing but expand into longer repeated byte-pair sweeps
  before their final `0xFF` terminators.
- Kept the new names structural. The byte evidence now supports stable repeated-record ownership inside the
  command tail, but it still does not prove whether the decoder belongs to audio, credits, animation, or
  another tail-bank interpreter.
