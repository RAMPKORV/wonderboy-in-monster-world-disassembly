# 2026-03-19 bank080000 command mid literal-control pockets

- Tightened another middle-window pocket in bank `0x080000`'s `0x09C008-0x09E027` command body without forcing
  subsystem meaning.
- `src/bank080000_z80_command_records_b.asm` now source-authors the former raw `0x09C0D7-0x09C252` run as nine
  explicit FF-terminated records instead of nine `incbin` slices.
- `0x09C0D7` now stands explicitly as one compact local-control sweep that falls into a dense
  `0x4F/0x4E/0x4D/0x4C/0x4B/0x48` literal/high-byte pocket, followed by two tiny neighboring tails at
  `0x09C14D` and `0x09C158`.
- `0x09C15B-0x09C252` now reads as a closely related literal-control pocket family built around the same compact
  `F4 00 C2/C4 F5 12` framing, with repeated `0x00/0x05/0x0F` rows and one short `0x0D/0x0E/0x11` tail.
- The same pass also makes `0x09C62F-0x09C686` explicit as four short `F4 04` literal-control records centered
  on `0x00/0x05/0x0D/0x0E/0x11/0x60/0x65`, with one small `E2 A8` local-offset hop in the final record.
- Kept the naming structural. The bytes now make two more bridge pockets readable in ROM order, but the wider
  loader path into the `0x099B00-0x09F776` command region is still unproven.
