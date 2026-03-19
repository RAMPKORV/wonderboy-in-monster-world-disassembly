# 2026-03-19 bank080000 command front control bursts

- Tightened the front command window in bank `0x080000` one more step without forcing a subsystem guess.
- `src/bank080000_z80_command_records_a.asm` now source-authors the former raw `0x09A6D7-0x09AA5B` run as
  fourteen explicit FF-terminated records instead of fourteen `incbin` slices.
- `0x09A6D7-0x09A7FC` now stands explicitly as one local-control-plus-literal-control burst family built around
  recurring `0x60/0x61/0x00/0x05/0x0F/0x01` pockets.
- `0x09A7FD-0x09A874` is now explicit as a compact local-target sweep that hands off into a short `F4 F8`
  literal-pair family around `0x29/0x28/0x35/0x2F/0x36/0x37`.
- `0x09A875-0x09A9CB` now resolves into a longer `F4 11` literal/high-byte ladder around
  `0x43/0x41/0x40/0x3C/0x39/0x45/0x48/0x4A/0x4C`, then a shorter `0x4C/0x4D/0x4F/0x51` ladder with small
  `E2`/`E3` local-offset hops and one compact `0x39/0x35/0x40/0x3C/.../0x2F` descent.
- `0x09A9CD-0x09AA5B` is now explicit too: two tiny `F4 05` literal rows followed by a compact local-control
  bridge that ends as an `E4`-tagged local-offset ladder carrying eight short 4-byte literal rows.
- Kept the naming structural. The byte rhythm and ROM-order ownership are clearer, but the wider loader path
  into the `0x099B00-0x09F776` command region is still unproven, so the new records are not yet assigned to a
  concrete subsystem.
