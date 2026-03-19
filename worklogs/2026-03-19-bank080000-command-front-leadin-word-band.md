# 2026-03-19 bank080000 command front lead-in word band

- Tightened the last raw lead-in pocket at the front of bank `0x080000`'s `0x099B00-0x09A347` command table without
  forcing subsystem ownership.
- `src/bank080000_mid.asm` now source-authors the former raw `0x099B00-0x099B31` range as an explicit 25-word
  structural band instead of one remaining `incbin` slice.
- The neighboring `0x099B32-0x099BAF` offset table still gives the best current evidence for why this range matters:
  the wider command front can target back into the same local neighborhood, but the bytes do not yet prove a stronger
  loader or subsystem name.
- Kept the labels structural. This leaves the full `0x099B00-0x09A347` pre-window command front source-visible in
  ROM order while the controlling loader and concrete subsystem owner remain open questions.
