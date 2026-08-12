#!/usr/bin/env bash
# Verify the build is bit-perfect against the original ROM.
# The expected hash is in game.rom.sha256 (written by tools/setup.js).
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

if [ ! -f game.rom.sha256 ]; then
    echo "Missing game.rom.sha256 — run: node tools/setup.js <rom.bin> first"
    exit 1
fi

EXPECTED_HASH=$(awk '{print $1}' game.rom.sha256)

echo "Building ROM..."
wine asm68k.exe /k /p /o ae- wonderboy.asm,out.bin,,game.lst || { echo "BUILD FAILED"; exit 1; }

echo ""
echo "Verifying ROM hash..."
ACTUAL_HASH=$(sha256sum out.bin | awk '{print $1}')

if [ "$ACTUAL_HASH" = "$EXPECTED_HASH" ]; then
    echo ""
    echo "========================================"
    echo "   BUILD VERIFIED - ROM IS BIT-PERFECT"
    echo "========================================"
    echo "Hash: $ACTUAL_HASH"
    exit 0
else
    echo ""
    echo "========================================"
    echo "   VERIFICATION FAILED - ROM MISMATCH"
    echo "========================================"
    echo "Expected: $EXPECTED_HASH"
    echo "Actual:   $ACTUAL_HASH"
    exit 1
fi
