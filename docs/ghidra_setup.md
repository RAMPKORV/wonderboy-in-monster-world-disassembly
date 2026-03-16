# Ghidra Setup

## Tool

- Ghidra launcher: `C:/ProgramData/chocolatey/lib/ghidra/tools/ghidra_12.0_PUBLIC/ghidraRun.bat`

## Initial Project Steps

1. Launch Ghidra and create a non-shared project inside `ghidra/`.
2. Import `original/wonderboy.bin`.
3. Select the Motorola 68000 language for Sega Mega Drive ROM analysis.
4. Set the ROM image base to `0x000000`.
5. Preserve the imported file as the canonical analysis target; compare source rebuilds
   against `original/wonderboy.bin`, not against ad hoc exports.

## Current State

This repo only documents the reproducible import target and location for now. Detailed
bookmarking, exports, and symbol synchronization remain future tasks.
