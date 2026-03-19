# 2026-03-19 bank080000 Z80 transfer handshake

- Tightened the last unresolved front-Z80 slice in `src/bank080000_mid_z80_program.asm` from `0x098F8C` through `0x09907A`.
- The repeated jump stubs at `0x098020`, `0x098028`, and `0x098030` all land on this routine, so the full `0x098000-0x09907A` Z80 front is now source-visible.
- `0x098F8C-0x098FBF` now stands explicitly as a register snapshot prologue that stores primary `BC/DE/HL`, `IX`, `IY`, the popped return address, `SP`, primary `AF`, alternate `AF'`, and alternate `BC'/DE'/HL'` into the `0x1B80+` save area.
- `0x098FC0-0x098FEF` is now explicit as three copy-out passes over descriptor families at `0x1BA0/0x1BA2/0x1BA3`, `0x1BA8/0x1BAA/0x1BAB`, and `0x1BB0/0x1BB2/0x1BB3`, each following the structural layout `[target word][length byte][local mirror bytes]`.
- `0x098FF6-0x099003` raises handshake flags at `0x1B98/0x1B99` and then busy-waits until an external owner clears `0x1B99`.
- `0x099004-0x09905D` copies each nonempty transfer slot back into its local mirror and overwrites the destination head with `E7`, `EF`, or `F7` plus zero fill; `0x09905E-0x09907A` restores the saved primary subset plus the return address, clears `0x1B98`, and returns.
- Kept the naming structural rather than forcing a subsystem guess. The bytes support a state-save / transfer-handshake routine today, but not yet a stronger claim like sound-driver mailbox, loader trap bridge, or another specific owner until the caller side and handshake consumer are proven.
