# 2026-03-17 bank080000 cross-payload pass

- Followed the cross-bank flagged ROM-reference tables in `src/bank040000_tables.asm` into the tail
  bank instead of stopping at the bank boundary.
- Confirmed those table entries do not just point vaguely into bank `0x080000`: they provide 178 stable
  ROM-order starts spanning `0x0801CD-0x0961D7`.
- Split the former opaque owner in `src/bank080000.asm` into a small untargeted lead-in at
  `0x080000-0x0801CC`, a large front record window at `0x0801CD-0x093FD0`, an explicit untargeted gap
  at `0x093FD1-0x094149`, a shorter tail record window at `0x09414A-0x0961D7`, and a final untargeted
  gap at `0x0961D8-0x09622A` before the already confirmed fill run at `0x09622B`.
- Added `src/bank080000_cross_payload_front.asm` and `src/bank080000_cross_payload_tail.asm` so the
  table-targeted bank `0x080000` payload now reads like the mature bank `0x040000` payload family: real
  ROM-order record starts are visible in source instead of being hidden inside one monolithic pre-fill
  `incbin`.
- Kept the labels structural. The cross-bank table proves ownership and ordering, but not yet whether
  the records are maps, scripts, graphics metadata, sound resources, or another late-game family.
- The most useful next step is still consumer-side: recover the code or descriptor path that loads the
  bank `0x040000` flagged-reference table so the flag byte and these cross-bank payload records can move
  from structural slices to a named subsystem.
