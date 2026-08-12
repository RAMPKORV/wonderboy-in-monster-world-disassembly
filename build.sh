#!/usr/bin/env bash
# Build the disassembled ROM with asm68k.
# Regenerates the asset-derived data modules (src/tile_blocks_*.asm,
# src/palette_table.asm) from assets/ first, then assembles. Unmodified
# assets reproduce the original ROM bit-for-bit.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"
echo "Building $(basename "$PWD") ROM..."
if [ -d assets ]; then
  node tools/regen_assets.js
fi
if [ -f text/scenes.json ]; then
  echo "Regenerating dialogue data from text/scenes.json..."
  node tools/regen_dialogue.js
fi
node tools/regen_rest.js game.rom
wine asm68k.exe /k /p /o ae- wonderboy.asm,out.bin,,game.lst
echo "Build complete: out.bin ($(stat -c%s out.bin 2>/dev/null || stat -f%z out.bin) bytes)"
