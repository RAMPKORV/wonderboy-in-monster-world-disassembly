# 2026-03-19 bank080000 `0x0A10AB+` final regular runs

- Tightened the last still-incbin-backed regular runs inside bank `0x080000`'s `0x0A10AB-0x0A34FF`
  FF-terminated five-byte tuple family without forcing subsystem meaning.
- `src/bank080000_a2d9b.asm` and `src/bank080000_a304b.asm` now source-author the former
  `0x0A2D9B-0x0A303F` and `0x0A304B-0x0A34FF` runs directly as literal `dc.b` tuples instead of one
  sliced `incbin` per proven record.
- The structural evidence does not change: each record still ends on a local `$FF`, and every
  pre-terminator payload length still remains one of the already observed `5n` sizes. The last two
  authored runs keep the same local size histograms already noted elsewhere: `6/11/21/46` for
  `0x0A2D9B-0x0A303F` and `6/11/16/21/41` for `0x0A304B-0x0A34FF`.
- This closes the remaining readability gap inside the regular `0x0A10AB-0x0A34FF` family. Only the
  five short mixed bridge pockets remain structurally grouped; the regular tuple records are now all
  byte-visible in source in ROM order.
