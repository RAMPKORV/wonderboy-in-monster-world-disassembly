# 2026-03-18 bank080000 command tail bursts

- Tightened three more late records inside the tail-bank `0x09E028-0x09F776` command window
  without forcing a subsystem guess.
- The records at `0x09F597-0x09F5F7` and `0x09F5F8-0x09F669` are now explicit `dc.b` data in
  `src/bank080000_mid_command_tail_tail.asm` instead of raw `incbin` slices.
- Both records keep the same compact `F4 00 C2` header and a long repeated-literal rhythm built
  from `0x0F` bursts plus recurring `0x60/0x6C/0x6D/0x65` control bytes, with the second record
  extending the first family's pattern rather than introducing a new local shape.
- The neighboring `0x09F66A-0x09F6AD` record is now source-authored too. Its byte cadence is more
  compact: alternating `D2/D6 61` against `D0 7C` for most of the record before a short final
  `D2 97 / D0 F8 / F5 / FF` tail.
- Kept the new names structural. The local bytes now prove another repeated-record pocket in the
  late tail window, but they still do not identify the higher-level decoder as audio, credits,
  animation, or another tail-bank interpreter.
