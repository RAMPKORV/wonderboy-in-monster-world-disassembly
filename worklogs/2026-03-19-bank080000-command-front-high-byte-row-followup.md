# 2026-03-19 bank080000 command front high-byte row follow-up

- Tightened the next adjacent front-window pocket in bank `0x080000` without forcing subsystem ownership.
- `src/bank080000_z80_command_records_a.asm` now source-authors the former raw `0x09B28A-0x09B575` run as ten explicit FF-terminated records instead of ten `incbin` slices.
- `0x09B28A` now stands explicitly as a compact local-control sweep feeding repeated `0xAB/0xAA/0xA8/0xA6/0xA5/0xAD/0xAE/0xB1/0xB2` high-byte rows around `0x4F/0x4E/0x4B/0x4A/0x48/0x51/0x52/0x54/0x56`, followed by a short `F7 08` literal tail.
- `0x09B319-0x09B36A` now resolves into the neighboring `F4 28` family: one repeated `0xA2/0x43` high-byte pocket with timing pivots and one shorter literal descent rooted on `0x46/0x48/0x4F/0x4E/0x4B/0x4A/0x4D`.
- `0x09B36B-0x09B494` now reads as one compact local-control bridge into a short `0x3C/0x43/0x42/0x46` crest plus a four-record `F4 00` literal-control family around `0x60/0x0D/0x00/0x0C/0x65/0x05/0x0F/0x6C/0x6D`.
- `0x09B495-0x09B575` also now stands explicitly as a local-control bridge into repeated `E2`-tagged `0x3B/0x3C` rows, a short literal continuation, and a denser `E2 04/44/2C` sweep around `0x2F/0x30/0x31/0x32/0x34/0x35/0x36/0x37/0x2D/0x2C/0x2B`.
- Kept the names structural. The wider loader path into the `0x099B00-0x09F776` command region is still unproven, so the new records stay framed by byte-local behavior rather than subsystem guesses.
