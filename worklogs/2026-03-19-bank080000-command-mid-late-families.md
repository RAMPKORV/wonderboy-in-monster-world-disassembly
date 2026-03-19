# 2026-03-19 bank080000 command mid late families

- Tightened another visible pocket inside bank `0x080000`'s middle command window without forcing subsystem
  meaning.
- `src/bank080000_mid_command_tail_mid.asm` now source-authors the former raw run at
  `0x09CBEE-0x09CFBC` as thirty explicit FF-terminated records instead of `incbin` slices.
- `0x09CBEE-0x09CC00` now stand explicitly as a short `F4 00` literal-control pair, `0x09CC16-0x09CCEC`
  expose three broader setup records with one low-byte ladder, one mixed literal/high-byte pocket, and one
  `0x6D/0x6C` literal-control burst, and `0x09CD3C-0x09CD8D` now show a local-seeded literal row followed
  by compact `F4 14` literal ladders and tiny cap records.
- The later half is clearer too: `0x09CD90-0x09CE48` now covers one short same-window sweep into a literal
  cap plus a neighboring `F4 14` literal/high-byte ladder family, `0x09CE49-0x09CEF2` narrows into a
  compact `F4 1A` low-byte ladder family, and `0x09CEF7-0x09CF77` now exposes a broader local-target sweep
  into literal/high-byte ladders plus one final local-control-to-literal-row bridge.
- Kept the new labels structural. The byte patterns are now much easier to audit in source, but the loader
  path and subsystem owner for the wider `0x099B00-0x09F776` command region still need control-flow proof.
