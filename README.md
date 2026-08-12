# Wonder Boy in Monster World (Genesis) — Disassembly

A **bit-perfect** 68000 disassembly of *Wonder Boy in Monster World* (also
known as *Wonder Boy V: Monster World III*), Sega Genesis / Mega Drive,
serial **GM G-4060-00** (US/EU release).

`./build.sh` + `./verify.sh` reproduce the original ROM byte-for-byte
(SHA-256 `6b2ac36f624f914ad26e32baa87d1253aea9dcfc13d2a5842ecdd2bd4a7a43b9`).

## What's here

- **Full code disassembly** — every code region from `$000200` to `$020000`
  is converted to annotated assembler source in `src/`, verified bit-exact
  against the ROM. The main gameplay/data bank (`gamebank0-10.asm`) is
  included, along with the palette driver, scene decompressors, menu code,
  and the Z80 sound driver.
- **Asset pipeline** — tiles and palettes are extracted losslessly from the
  ROM (`tools/extract_assets.js`), wired into the build, and flow back
  bit-perfect. Editing an asset's pixels rebuilds the ROM.
- **682 decoded maps** — every tag-`$02` 32x32 tilemap decoded to
  `maps/map_*.bin` and rendered to `maps/png/` (`tools/extract_maps.js`,
  `tools/render_maps.js`).
- **Engine documentation** — `docs/engine.md` documents the Westone
  task-scheduler engine, the scene/plane system, and how doors and scene
  transitions work, aimed at re-implementation.

## Quick Start

```bash
./build.sh   # assemble wonderboy.asm -> out.bin
./verify.sh  # hash-check out.bin vs the ROM
```

The ROM (`game.rom`, a copy of `wonderboy.bin`) is gitignored; `verify.sh`
checks against it and the committed `game.rom.sha256`.

## Documentation

| File | What it is |
|------|------------|
| `docs/engine.md` | Engine deep-dive: boot, task scheduler, scene/plane system, doors, data formats |
| `docs/game-notes.md` | Game identity, external research, region plan, ROM layout |
| `docs/progress.md` | Format crack status + conversion tracking |
| `AGENTS.md` | Master instructions for AI agents |
| `docs/segagenesis.md` | Genesis/Mega Drive ROM + hardware reference |
| `docs/pipeline.md` | The region-conversion pipeline |
| `docs/asm68k.md` | asm68k.exe quirks (the hard-won lessons) |
| `docs/workflow.md` | Day-to-day agent workflow |

## Requirements

- Linux (or WSL) with `wine`
- Node.js (for the tools)
- Ghidra (optional but recommended; `tools/m68kdis.js` is a fallback
  disassembler)

## The one rule

The build must always reproduce the ROM byte-for-byte.
`./verify.sh` must always print `BUILD VERIFIED - ROM IS BIT-PERFECT`.
