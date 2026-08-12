# Sega Genesis / Mega Drive — ROM & Hardware Reference

Everything you need to understand a Genesis cartridge ROM before (and while)
disassembling it. This is generic to the platform; game-specific details
belong in the project notes.

## The Cartridge Layout

A Genesis/Mega Drive cartridge exposes its 68k ROM in the address range
`$000000-$3FFFFF` (up to 4MB; most games are 256KB-1MB). The first 2KB are
special:

| Offset  | Size   | Contents                                              |
|---------|--------|-------------------------------------------------------|
| $000    | $100   | 68000 exception vector table (64 longs)               |
| $100    | $100   | The "ROM header" (see below)                          |
| $200    | ...    | Program code + data                                   |

### Exception vectors ($000-$0FF)

Each entry is a 32-bit *address* (big-endian). The critical ones:

| Offset | Vector   | Purpose                                   |
|--------|----------|-------------------------------------------|
| $000   | reset SP | Initial stack pointer (usually $FFFFFF00) |
| $004   | reset PC | Entry point (first instruction)           |
| $008   | bus err  | Bus error handler                         |
| $00C   | addr err | Address error handler                     |
| $010   | ill op   | Illegal instruction handler               |
| $014   | div zero | Divide-by-zero handler                    |
| $018   | chk      | CHK instruction handler                   |
| $01C   | trapv    | TRAPV handler                             |
| $020   | priv viol| Privilege violation handler               |
| $060   | TRAP #0  | Software trap (many games use this)       |
| $064   | TRAP #1  | ...                                       |
| $068   | TRAP #2  | ...                                       |
| $06C   | TRAP #3  | ...                                       |
| $06C+  | TRAP #4-15 | ...                                     |
| $070   |        | (unused vectors)                          |
| $080-$0FC |        | reserved                                  |
| $100   |        | (header begins — not a vector)            |

Vectors beyond the 68000's architectural set (in the $100+ region or the
game's own IRQ handling) are game-specific.

### The ROM Header ($100-$1FF)

The de-facto standard "PlutiaDev" layout used by virtually all retail carts.
The value `"SEGA"` at $100 also doubles as the TMSS check that some consoles
require.

| Offset | Size | Field               | Example (Sonic 1)        |
|--------|------|---------------------|--------------------------|
| $100   | 16   | System type         | `"SEGA MEGA DRIVE "`     |
| $110   | 16   | Copyright           | `(C)SEGA 1991.`          |
| $120   | 48   | Domestic title      | `SONIC THE                   ` |
| $150   | 48   | Overseas title      | `SONIC THE                   ` |
| $180   | 14   | Serial number       | `GM 00004049-01`          |
| $18E   | 2    | ROM checksum        | (16-bit sum, see below)   |
| $190   | 16   | Device support      | `"J               "`      |
| $1A0   | 8    | ROM address range   | start/end longs          |
| $1A8   | 8    | RAM address range   | start/end longs          |
| $1B0   | 12   | Extra memory (SRAM) | `"RA"` + type byte + ... |
| $1BC   | 12   | Modem support       | `"        "`             |
| $1C8   | 40   | Reserved            | spaces                   |
| $1F0   | 3    | Region              | `"JUE"` etc.             |
| $1F3   | 13   | Reserved            | spaces                   |

Notes:
- **ROM checksum** at $18E: the standard Sega algorithm is the two's
  complement of the 16-bit sum of all words from $200 to the end of the
  ROM, but **actual games vary** — many ship with an incorrect, patched,
  or non-standard checksum, and some emulators ignore it entirely. Treat
  the header field as ROM bytes, never as something to regenerate: this
  pipeline preserves $000-$1FF verbatim in `src/header_vectors.asm`, so
  the build is bit-perfect regardless of the checksum value.
- **Declared ROM range** should match the file size; if not, the game may
  have a boot loader or unusual banking.
- **Extra memory** field: `"RA"` + `$F8` means 8-bit SRAM at a RAM-mapped
  address (needs the SRAM enable latch at $A130F1). Other values: `$FA` =
  16-bit SRAM, `$FC` = EEPROM.
- **Region**: `J`=Japan, `U`=USA, `E`=Europe, `B`=Brazil, `4`=World.

## The 68000 Core (in brief)

- 32-bit, big-endian, 14 addressable registers: D0-D7, A0-A7 (A7=SP).
- Address space: ROM at $000000, Z80+YM at $A00000-$A11FFF, VDP I/O at
  $C00000-$C00004, controller ports at $A10000-$A1000F, TMSS at $A14000.
- **Instructions are uppercase** in the canonical style, size suffixes are
  `.b`/`.w`/`.l`. Branch displacement is relative to `PC+2` for all
  branches.
- Common idioms to expect in game code:
  - `MOVE.L #$40000003, VDP_control_port` — VRAM write command.
  - `MOVE.W #$8174, VDP_control_port` — enable display + VBlank.
  - `SWAP` / `LSR.W` used to fold a 32-bit co-ordinate into a VRAM address.
  - `JMP (An)` or `JMP (d,PC,Dn.w)` for state-machine / table dispatch.
  - Z80 bus requests (`MOVE.W #$100, Z80_bus_request`) when DMA-ing the
    sound driver.

## Typical Game Structure (common to most Genesis games)

Almost every retail game follows this skeleton:

1. **Init**: set SP (already done by reset vector), write "SEGA" to the TMSS
   register, set VDP registers, clear RAM.
2. **Z80 boot**: copy a small 68k routine into Z80 RAM (or release the Z80)
   and DMA a sound driver to Z80 RAM.
3. **Title / attract**: SEGA logo, title screen, demo attract mode.
4. **Game states**: a state byte + a jump table. States such as
   TITLE, MENU, PLAYING, PAUSED, GAME_OVER, HIGH_SCORE.
5. **Main loop**: each frame — VBlank handler (DMA scroll/plane updates),
   read pads, update entities, render.
6. **Level data**: tilemaps, tile patterns, palettes, object/sprite tables,
   compressed with the game's own scheme (often RLE or LZ).

## Disassembling a Specific Game

For *game-specific* knowledge (what each routine does, level structure,
cheat codes, etc.) do web research on the game:
- Search for existing disassemblies / reverse-engineering threads (Sonic
  Retro, romhacking.net, GitHub).
- Look for the game's manual, level maps, and technical documents.
- Check the game's serial (`GM xxxxxxxx-xx`) to confirm which title you
  have and whether it differs from other revisions.
- Note revision differences: a "Rev 01" or "Rev A" ROM may have different
  code addresses than the common dump.

Then record what you learn in `docs/game-notes.md` (create if absent).
