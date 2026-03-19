# 2026-03-18 bank080000 pre-descriptor records

- Tightened the formerly incbin-backed `0x099649-0x09988F` span inside
  `src/bank080000_z80_pre_descriptor_data.asm` into explicit source-authored records instead of two coarse
  mixed/control byte bands.
- Promoted `0x099649-0x099828` into thirty fixed 16-byte records. The byte cadence is now stable
  enough to justify ROM-order record ownership even though the field meanings are still unproven.
- Promoted `0x099829-0x09988F` one step further too: the first three bytes now stand alone as a
  short lead-in, and the remaining `0x64` bytes resolve cleanly into twenty fixed 5-byte records.
- Kept the labels structural rather than subsystem-specific. The new evidence proves record widths
  and boundaries, but not yet whether these pre-descriptor records belong to audio, credits,
  layout metadata, sprites, or another tail-bank format family.
