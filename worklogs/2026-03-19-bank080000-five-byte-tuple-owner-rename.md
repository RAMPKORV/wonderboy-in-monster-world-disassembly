# 2026-03-19 bank080000 five-byte tuple owner rename

- Promoted the top-level owner for bank `0x080000`'s proven `0x0A10AB-0x0A34FF` record family from
  the address-stamped `src/bank080000_a10ab.asm` name to the format-owned
  `src/bank080000_ff_terminated_five_byte_tuples.asm`.
- Kept ROM order and byte identity unchanged. The existing child segments remain split at the same
  proven starts (`0x0A1411`, `0x0A1D4F`, `0x0A2400`, `0x0A258B`, `0x0A2610`, `0x0A27CB`, `0x0A2D9B`,
  and `0x0A304B`), but the parent include now reflects the strongest current ownership evidence:
  one FF-terminated five-byte tuple family with a few explicit mixed bridge pockets.
- Updated the ROM-order include in `src/bank080000_offset_tree_payload.asm`, refreshed `tools/index/rom_map.json`,
  and recorded the stronger format-owned naming in repo notes so future passes do not keep treating
  this family as a generic address-derived blob owner.
