# 2026-03-19 bank080000 `0x0A10AB-0x0A34FF` embedded-`FF` record follow-up

- Tightened the middle five-byte tuple family in `src/bank080000_a10ab.asm` without forcing subsystem names.
- Promoted five former anomaly pockets into explicit FF-terminated records:
  `0x0A1322-0x0A132C`, `0x0A1406-0x0A1410`, `0x0A2765-0x0A27CA`, `0x0A2D86-0x0A2D9A`, and
  `0x0A3040-0x0A304A`.
- The proof is local byte cadence rather than loader evidence. Each recovered pocket ends on a real local
  `$FF` terminator, and the preceding bytes still group cleanly into five-byte tuples even when one tuple
  embeds `$FF` as a field value.
- The larger `0x0A2765-0x0A27CA` pocket resolves into two neighboring FF-terminated records at `0x0A2765`
  and `0x0A278E`.
- After this pass, only five short mixed gaps remain inside the broader `0x0A10AB-0x0A34FF` family:
  `0x0A136E-0x0A1377`, `0x0A1D3F-0x0A1D4E`, `0x0A23F6-0x0A23FF`, `0x0A2586-0x0A258A`, and
  `0x0A2606-0x0A260F`.
