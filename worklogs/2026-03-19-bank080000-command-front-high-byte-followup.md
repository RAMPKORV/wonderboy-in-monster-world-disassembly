# 2026-03-19 bank080000 command front high-byte followup

- Tightened the next adjacent pocket in bank `0x080000`'s front command window without forcing subsystem meaning.
- `src/bank080000_mid_command_tail_front.asm` now source-authors the former raw run at
  `0x09AA5C-0x09AB29` as four explicit FF-terminated records instead of four `incbin` slices.
- `0x09AA5C-0x09AA98` now stands explicitly as a compact local-control sweep into two short `F4 08`
  literal-control rows built around `0x00/0x0C/0x05/0x60`.
- `0x09AA99-0x09AB29` now resolves into the neighboring repeated high-byte pair pocket: one local-control
  prelude feeds a short `0x8D/0x39`, `0x8C/0x38`, `0x88/0x34` ladder, then a denser follow-on record grows
  into repeated `0x93/0x3F` and `0x94/0x40` rows before the already explicit 0x18-byte triplet at `0x09AB2A`.
- Kept the naming structural. The byte rhythm and ROM-order ownership are clearer, but the wider loader path
  into the `0x099B00-0x09F776` command region is still unproven, so the new records are not yet assigned to a
  concrete subsystem.
