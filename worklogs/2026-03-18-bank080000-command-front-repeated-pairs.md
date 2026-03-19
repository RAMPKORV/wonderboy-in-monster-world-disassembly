# 2026-03-18 bank080000 command front repeated pairs

- Tightened five more FF-terminated records inside the front tail-bank command window
  `0x09A348-0x09C007` without forcing a subsystem guess.
- `src/bank080000_mid_command_tail_front.asm` now source-authors `0x09A497-0x09A4F9`,
  `0x09A59B-0x09A613`, `0x09A63B-0x09A6D6`, `0x09AB72-0x09AB94`, and
  `0x09AB95-0x09ABE0` as explicit `dc.b` data instead of raw `incbin` slices.
- The first, second, third, and fifth records all keep the same compact command framing
  already visible in nearby explicit records: short `F6/F7/F0 ...` or `F4/F1/F5 ...`
  setup/control prefixes, then repeated byte-pair sweeps, then a final `0xFF` terminator.
- `0x09AB72-0x09AB94` now reads more clearly as the short follow-on continuation immediately
  after the already explicit 24-byte triplet family at `0x09AB2A-0x09AB71`, instead of as
  one more anonymous FF-terminated slice.
- Kept the names structural. The bytes now support stronger local ownership and cadence inside
  the command-tail front, but not yet whether this decoder belongs to audio, credits,
  animation, or another tail-bank interpreter.
