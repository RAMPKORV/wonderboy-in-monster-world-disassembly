# Game Notes — Wonder Boy V: Monster World III (Wonder Boy in Monster World)

## Identity
- Title / revision: Wonder Boy V: Monster World III (domestic) / "WONDER BOY in Monster world" (overseas)
- Serial: GM G-4060  -00
- Region: UE (USA/Europe release)
- Copyright: (C)SEGA 1990.JAN
- ROM size: 786432 bytes (768 KB, 0xC0000)
- SHA-256: `6b2ac36f624f914ad26e32baa87d1253aea9dcfc13d2a5842ecdd2bd4a7a43b9`
- MD5: `edba0bdb192d47712edbe0097f885f40`
- Header checksum field: $9D79 (preserved verbatim; standard Sega algorithm recomputes to $6287 — do NOT regenerate)
- Reset vector: $00000200; initial SP: $00FF0C00
- Header RAM fields: "RA" + $E8 $40 (Backup RAM declared at $200001 — collapsed to a single odd address; treat as header-level observation)
- TMSS "SEGA": present

## External Research
- **Reference repo (same ROM!):** `github.com/RAMPKORV/wonderboy-in-monster-world-disassembly` — a Phase-0/1 parallel RE of the identical `wonderboy.bin`. Contains a RAM map (`docs/memory_map.md`), ROM layout (`docs/rom_layout.md`), VBlank dispatch worklog, and a recovered `engine_menu_core.asm`. Its RAM-map labels cross-validate my boot-flow decode. **Reuse as reference material (with user's blessing).**
- No public hash match for this exact dump (non-standard header lineage).
- Game: side-scrolling action-RPG by Westone, pub. Sega (1991 JP / 1992 US-EU). Protagonist Shion; towns, dungeons, shops, magic menu, equipment, SRAM save at inns (US version has Game Over screen instead of JP return-to-inn).
- Master System port exists (password save); TurboDuo remake = The Dynastic Hero. Not relevant to Genesis disasm.

## Engine Overview (from boot-flow mapping)
- **Standard Sega boot** at $200-$28C: TMSS unlock, 24 VDP regs from table at $28E, Z80 driver copy (38 bytes to $A00000), RAM clear, PSG silence. Then `jmp $4A06` (main init).
- **$306-$3B6:** Z80 driver upload (copies driver from ROM $98000, length prefix at $98006-$98007) + Z80 bus/reset helpers + Z80 mailbox command writer.
- **Main init $4A06:** VDP setup ($4A7A from tables at $4AD0/$4AF4), I/O init ($4B02), then subsystem inits: $5170, $6BA0, $5398, $4B42 (queue tables), $9F46. Enables IRQ ($2500), jumps to dispatcher.
- **VBlank handler (IRQ6) $4B5C:** `addq.b #1,$FF8A49` (frame counter) + set bit0 of $FF8006. HBlank/unused IRQs -> spin at $4B58.
- **Main loop / task dispatcher $4BBC:** iterates 4-slot *immediate task array* at $FF8048 (0x80 stride, callback at +$0C), then runs $53AA, $4C00 (VBlank/raster sync), $3B8 (IRQ poll). Loops forever. SP reset to $FF0C00 at $4BF8.
- **Secondary task array** loaded at $FF80C8 from inline descriptor lists at $4CC4-$4E63.
- **Round-robin object slots** at $FF8248 (16 x 0x80), cleaned each frame via $4B96; allocated through $444/$47A/$4A2 (slot finder uses $FF8248 base, id at +$4, callback at +$C).
- **Task-script interpreter:** bytecode-driven callbacks rooted at $4DE2; scratch state at $FF1400 (0x400 longs) and $FF8A4E-$FF8A52.
- **Input:** per-pad triplets (current/prev/new) at $FF8A7F-81 (P1) and $FF8A82-84 (P2); selected-input mirror $FF8A7A-7C; repeat logic at $805A.
- **RNG:** LCG at $5D8, state $FF8A52 (seed $2A6D365A).
- **VDP/scroll helpers** at $600-$8BC: register writers ($716/$72C/$74E/$764/$786/$79C), tilemap coord -> VRAM command ($79C, VRAM base table at $7E0), scroll registers $FF8A5A-6F.
- Error/trap handlers: bus error $49FA, address error $49F8, illegal $49FE, traps $4A02.

## Region Plan (conversion status)

Converted (all bit-perfect):
1. `src/core.asm` — $000200-$0005FE — boot/init, Z80, object slots, RNG
2. `src/scroll_vdp.asm` — $0005FE-$0007E8 — VDP/scroll helpers
3. `src/script_engine.asm` — $0007E8-$000A1A — offset-tree script interpreter
4. `src/entity.asm` — $000A1A-$001400 — entity subsystem + atan2
5. `src/gameplay1.asm` — $001400-$00220A — actions, dispatch tables, quiz strings, sprite DMA
6. `src/gameplay2.asm` — $00220A-$003000 — more gameplay, dialogue text, stat tables
7. `src/gameplay3.asm` — $003000-$004092 — movement/angle code, stat tables
8. `src/gameplay4.asm` — $004092-$004900 — sprite anim tables + entity code
9. `src/mainloop.asm` — $004900-$004C82 — engine core (MainInit, VBlank, dispatcher)
10. `src/subsystem.asm` — $004C82-$005700 — task lists, subsystem inits, controllers
11. `src/gameplay5a.asm` — $005700-$00579A — pre-palette-driver code (43 instr)
12. `src/palette_driver.asm` — $00579A-$005985 — palette animation driver
13. `src/gameplay5a_tail.asm` — $005986-$00599C — post-palette-adjust code
14. `src/palette_table.asm` — $00599C-$006A58 — 252 packed palettes
15. `src/gameplay5b.asm` — $006A58-$006BC4 — pre-flagged-loader code (127 instr)
16. `src/scene_decompressors.asm` — $006BC4-$006EA6 — LoadFlaggedData + decompressors
17. `src/gameplay5c.asm` — $006EA6-$007000 — flagged-loader data tables
18. `src/gameplay6.asm` — $007000-$008000 — sprite/anim data + code islands
19. `src/menus.asm` — $008000-$009000 — inventory/magic menu code + data
20. `src/gameplay7.asm` — $009000-$00A000 — gameplay code/data
21. `src/gamebank0-10.asm` — $00A000-$020000 — main gameplay/data bank (11 chunks, 1603 instr)
22. `src/z80_driver.asm` — $0098000-$0099A76 — Z80 sound driver (full Z80 disasm)
23. `src/data_banks.asm` — $00A0000-$00A4C76 — offset trees + script/monster data

All code regions are now converted. Pure-data regions remain raw dc.b:
- $020000-$045842 (text, maps, level data)
- $045842-$06BB12 tile blocks (converted via asset pipeline)
- $06BB12-$097FFF (tile/palette/graphics data)

## Final ROM layout (discovered)
```
$00000-$0A000  code + engine data (disassembled)
$0A000-$20000  main gameplay/data bank (gamebank0-10, disassembled)
$20000-$45842  text/dialogue, maps, level data (raw dc.b; text partially decoded)
$45842-$6BB12  tile blocks (asset-wired, tile_blocks_0..4.asm)
$6BB12-$98000  graphics/palette/animation data (raw dc.b)
$98000-$99A76  Z80 sound driver (uploaded to Z80 RAM by WriteZ80Driver)
$99A77-$9FFFF  data (text)
$A0000-$A4C76  offset trees + script/monster data (script_engine consumes these)
$A4C77-$BFFFF  $FF padding (empty)
```

## Notes / Findings
- A4 = $FFC000 is the entity-slot base for most code; the script interpreter ($7E4-$846) uses it too (offsets land in $FF8000-$FF9400).
- Exception vectors pointing to $00000006 are intentional dead traps — preserve exactly.
- The 68000 code is a Westone task-scheduler engine (see docs/engine.md).
