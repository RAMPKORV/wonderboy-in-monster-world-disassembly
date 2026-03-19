# 2026-03-19 bank080000 command front row pocket follow-up

- Tightened the next front-window bridge in bank `0x080000`'s `0x09A348-0x09C007` command body without forcing a loader guess.
- `src/bank080000_z80_command_records_a.asm` now source-authors the former raw `0x09B091-0x09B289` run as eleven explicit FF-terminated records instead of eleven `incbin` slices.
- `0x09B091-0x09B113` now stands explicitly as one compact local-control-to-literal-row pocket followed by two shorter `F4 00` row continuations around `0x30/0x33/0x36/0x3A/0x39/0x37` and the recurring `0x2B` tail.
- `0x09B12A-0x09B1AB` now resolves into one local-control bridge into a short `F4 18` literal/high-byte row around `0x3C/0x3F/0x42/0x46/0x45/0x43`, followed by two neighboring `0x9F/0xA0/0xA1/0xA2` then `0x9F/0x9E/0x9C/0x9A/0x99` high-byte descents.
- `0x09B1C9-0x09B24B` is also clearer now: a paired literal-row pocket carries a short `0x9E/0x9D/0x9A/0x99/0x97/0x92` high-byte tail plus one `0x93/0x95`-rooted bridge, and `0x09B24C-0x09B289` closes with another compact local-control sweep into a repeated `0x48/0x54` literal-row family.
- Kept the naming structural. The bytes make another bridge in the front command window readable, but the owning loader and subsystem for the wider `0x099B00-0x09F776` interpreter still are not proven.
