# 2026-03-19 bank080000 `0x0A10AB-0x0A34FF` gap-bridge cleanup

- Removed the last five raw `incbin` gaps from `src/bank080000_a10ab.asm`.
- `0x0A1D3F-0x0A1D4E` fits the surrounding FF-terminated five-byte tuple family once embedded `$FF`
  fields are accepted, so it now stands as an explicit tuple record.
- The four other former gaps (`0x0A136E-0x0A1377`, `0x0A23F6-0x0A23FF`, `0x0A2586-0x0A258A`, and
  `0x0A2606-0x0A260F`) still end on local `$FF` markers but do not preserve the same 5-byte payload
  cadence, so they now use conservative mixed-bridge labels instead of forced tuple labels.
- Also removed the tiny raw tail from `src/bank080000_a0b26.asm` by making `0x0A0C79-0x0A0C82` explicit as
  one unresolved byte band. Those 10 bytes still do not prove the earlier FF-terminated lead-in cadence, so
  the label stays structural.
