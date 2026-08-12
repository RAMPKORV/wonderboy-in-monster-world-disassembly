# Game Notes Ã¢ÂÂ Wonder Boy V: Monster World III (Wonder Boy in Monster World)

## Identity
- Title / revision: Wonder Boy V: Monster World III (domestic) / "WONDER BOY in Monster world" (overseas)
- Serial: GM G-4060  -00
- Region: UE (USA/Europe release)
- Copyright: (C)SEGA 1990.JAN
- ROM size: 786432 bytes (768 KB, 0xC0000)
- SHA-256: `6b2ac36f624f914ad26e32baa87d1253aea9dcfc13d2a5842ecdd2bd4a7a43b9`
- MD5: `edba0bdb192d47712edbe0097f885f40`
- Header checksum field: $9D79 (preserved verbatim; standard Sega algorithm recomputes to $6287 Ã¢ÂÂ do NOT regenerate)
- Reset vector: $00000200; initial SP: $00FF0C00
- Header RAM fields: "RA" + $E8 $40 (Backup RAM declared at $200001 Ã¢ÂÂ collapsed to a single odd address; treat as header-level observation)
- TMSS "SEGA": present

## External Research
- **Reference repo (same ROM!):** `github.com/RAMPKORV/wonderboy-in-monster-world-disassembly` Ã¢ÂÂ a Phase-0/1 parallel RE of the identical `wonderboy.bin`. Contains a RAM map (`docs/memory_map.md`), ROM layout (`docs/rom_layout.md`), VBlank dispatch worklog, and a recovered `engine_menu_core.asm`. Its RAM-map labels cross-validate my boot-flow decode. **Reuse as reference material (with user's blessing).**
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
1. `src/engine/core.asm` Ã¢ÂÂ $000200-$0005FE Ã¢ÂÂ boot/init, Z80, object slots, RNG
2. `src/engine/scroll_vdp.asm` Ã¢ÂÂ $0005FE-$0007E8 Ã¢ÂÂ VDP/scroll helpers
3. `src/engine/script_engine.asm` Ã¢ÂÂ $0007E8-$000A1A Ã¢ÂÂ offset-tree script interpreter
4. `src/gameplay/entity.asm` Ã¢ÂÂ $000A1A-$001400 Ã¢ÂÂ entity subsystem + atan2
5. `src/actions.asm` Ã¢ÂÂ $001400-$00220A Ã¢ÂÂ actions, dispatch tables, quiz strings, sprite DMA
6. `src/scene_loader.asm` Ã¢ÂÂ $00220A-$003000 Ã¢ÂÂ more gameplay, dialogue text, stat tables
7. `src/movement.asm` Ã¢ÂÂ $003000-$004092 Ã¢ÂÂ movement/angle code, stat tables
8. `src/sprites.asm` Ã¢ÂÂ $004092-$004900 Ã¢ÂÂ sprite anim tables + entity code
9. `src/engine/mainloop.asm` Ã¢ÂÂ $004900-$004C82 Ã¢ÂÂ engine core (MainInit, VBlank, dispatcher)
10. `src/engine/subsystem.asm` Ã¢ÂÂ $004C82-$005700 Ã¢ÂÂ task lists, subsystem inits, controllers
11. `src/palette_pre.asm` Ã¢ÂÂ $005700-$00579A Ã¢ÂÂ pre-palette-driver code (43 instr)
12. `src/scene/palette.asm` Ã¢ÂÂ $00579A-$005985 Ã¢ÂÂ palette animation driver
13. `src/palette_post.asm` Ã¢ÂÂ $005986-$00599C Ã¢ÂÂ post-palette-adjust code
14. `src/scene/palette_table.asm` Ã¢ÂÂ $00599C-$006A58 Ã¢ÂÂ 252 packed palettes
15. `src/flagged_loader_pre.asm` Ã¢ÂÂ $006A58-$006BC4 Ã¢ÂÂ pre-flagged-loader code (127 instr)
16. `src/scene/scene_load.asm` Ã¢ÂÂ $006BC4-$006EA6 Ã¢ÂÂ LoadFlaggedData + decompressors
17. `src/flagged_loader_data.asm` Ã¢ÂÂ $006EA6-$007000 Ã¢ÂÂ flagged-loader data tables
18. `src/scene/sprite_data.asm` Ã¢ÂÂ $007000-$008000 Ã¢ÂÂ sprite/anim data + code islands
19. `src/scene/menu_system.asm` Ã¢ÂÂ $008000-$009000 Ã¢ÂÂ inventory/magic menu code + data
20. `src/scene/gameplay_data.asm` Ã¢ÂÂ $009000-$00A000 Ã¢ÂÂ gameplay code/data
21. `src/src/data/main_data.asm` Ã¢ÂÂ $00A000-$020000 Ã¢ÂÂ main gameplay/data bank (11 chunks, 1603 instr)
22. `src/z80/z80_driver.asm` Ã¢ÂÂ $0098000-$0099A76 Ã¢ÂÂ Z80 sound driver (full Z80 disasm)
23. `src/data/data_banks.asm` Ã¢ÂÂ $00A0000-$00A4C76 Ã¢ÂÂ offset trees + script/monster data

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
- Exception vectors pointing to $00000006 are intentional dead traps Ã¢ÂÂ preserve exactly.
- The 68000 code is a Westone task-scheduler engine (see docs/engine.md).
