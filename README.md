# Wonder Boy in Monster World Bit-Perfect Disassembly

This repository bootstraps a rebuildable disassembly workspace for `wonderboy.bin`.
The current baseline preserves the original Mega Drive ROM byte-for-byte by writing
the vector table and header in source form and including the remaining ROM body as
an extracted binary blob.

## Prerequisites

- Windows
- Node.js
- `asm68k.exe` in the repo root

## Build

```bat
cmd /c build.bat
```

## Verify

```bat
cmd /c verify.bat
node tools/validate_todos.js
node tools/run_checks.js
```

## Layout

- `wonderboy.asm` - top-level include order for the rebuild
- `header.asm` - vector table and Mega Drive header in source form
- `src/rom_body.asm` - remaining ROM body as `incbin`
- `data/rom/` - extracted raw ROM segments that still need decoding
- `original/` - immutable baseline ROM copy
- `docs/` - baseline notes, process docs, and milestone planning
- `tools/` - todo validation and project checks
- `ghidra/` - analysis workspace placeholder
- `worklogs/` - chronological reverse-engineering notes

## Current Status

Phase 0 is in place: the project scaffolding exists, the canonical ROM baseline is
captured, and the initial build/verify flow targets a bit-perfect rebuild.
