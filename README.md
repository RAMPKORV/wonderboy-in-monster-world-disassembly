# Sega Genesis ROM Disassembly Base

A copy-paste base project for disassembling **any** Sega Genesis / Mega
Drive ROM into bit-perfect 68000 assembly source.

## Quick Start

```bash
# 1. Copy this folder, put your ROM in it
cp -r disassembly my-new-game
cd my-new-game

# 2. Initialize from the ROM
node tools/setup.js "/path/to/Game (USA).bin"
#    -> prints the ROM header, writes game.rom / game.config.json /
#       src/header_vectors.asm / wonderboy.asm, and verifies a raw baseline.

# 3. Start disassembling (as an agent, read AGENTS.md; as a human,
#    read docs/workflow.md)
```

Then, as an agent, say **"Continue working"** or **"Work according to
plan"** and follow `AGENTS.md` + `docs/workflow.md`.

## What you get

- A verified **bit-perfect** baseline build of the raw ROM bytes.
- A region-by-region conversion pipeline (Ghidra → asm68k → autofix →
  verify) that never leaves the build broken.
- `asm68k.exe` (SN System 68k v2.53) and all pipeline tools.
- Full documentation: Genesis hardware/ROM format, the pipeline, and the
  assembler quirks that break naive conversions.

## Documentation

| File | What it is |
|------|------------|
| `AGENTS.md` | Master instructions for AI agents |
| `docs/segagenesis.md` | Genesis/Mega Drive ROM + hardware reference |
| `docs/pipeline.md` | The region-conversion pipeline |
| `docs/asm68k.md` | asm68k.exe quirks (the hard-won lessons) |
| `docs/workflow.md` | Day-to-day agent workflow |
| `docs/game-notes.md` | Per-game research & region plan (create per game) |
| `docs/progress.md` | Region conversion tracking (create per game) |
| `docs/engine.md` | Engine architecture notes (create per game) |

## Requirements

- Linux (or WSL) with `wine`
- Node.js (for the tools)
- Ghidra (optional but recommended; `tools/m68kdis.js` is a fallback
  disassembler)

## The one rule

The build must always reproduce the ROM byte-for-byte.
`./verify.sh` must always print `BUILD VERIFIED - ROM IS BIT-PERFECT`.
