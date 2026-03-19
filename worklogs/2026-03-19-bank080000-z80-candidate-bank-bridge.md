# 2026-03-19 bank080000 Z80 candidate-bank bridge

- Tightened the next proven Z80 main-body frontier in `src/bank080000_z80_program.asm` from `0x098393` through `0x098445`.
- `0x098393-0x098403` is now source-visible as a masked candidate-selector routine that uses the even-valued selector at `0x1C20` to choose one of three record-bank descriptors, masks `0x1C21` against the chosen active-bit mask, and picks the best active 0x40-byte record before calling the shared helper at `0x0446`.
- The new table at `0x098404-0x09840C` is now explicit as three compact `[little-endian record base][active-bit mask]` descriptors for banks rooted at `0x1C80`, `0x1E00`, and `0x1E80` with masks `0x3F`, `0x07`, and `0x01`.
- `0x09840D-0x098435` now stands explicitly as a scan over the `0x1C80` family that matches `0x1C07` plus the current `IX`-local packed delta against record bytes `+6/+7`.
- `0x098436-0x098445` is now explicit as a helper that packs the current `IX` pointer into a 0x40-byte record index relative to `0x1C80`.
- The unresolved Z80 main-body continuation now starts at `0x098446`, which is a cleaner next frontier than `0x098393` because the intervening bank-selection and record-index glue is no longer hidden.
