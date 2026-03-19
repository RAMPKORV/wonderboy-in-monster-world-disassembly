# 2026-03-19 bank080000 command front literal row ladders

- Tightened the next adjacent front-window pocket in bank `0x080000` without forcing subsystem ownership.
- `src/bank080000_z80_command_records_a.asm` now source-authors the former raw `0x09B576-0x09B701` continuation as eight explicit FF-terminated records instead of eight `incbin` slices.
- `0x09B576-0x09B600` now stands explicitly as a compact `F4 02` literal-row ladder family around `0x2D/0x34/0x2B/0x32`, including one denser FA-gated variation and a short `0x34/0x32/0x31/0x2F/0x30` descent.
- `0x09B601-0x09B681` now reads as a compact local-control bridge into an `F4 18` literal/high-byte ladder around `0x48/0x4A/0x4C/0x4D/0x4F`, plus two shorter literal-row continuations.
- `0x09B682-0x09B701` closes the pocket as a small `F4 04` local-control handoff into `0x40/0x43/0x45/0x47/0x48/0x4A`, including one short literal/high-byte tail and one denser repeated `0x41/0x40/0x3E` continuation.
- Kept the names structural. The wider loader path into the `0x099B00-0x09F776` command region is still unproven, so the new labels stay anchored to byte-local behavior rather than subsystem guesses.
