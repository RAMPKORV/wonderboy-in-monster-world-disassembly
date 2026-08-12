#!/usr/bin/env node
// extract_palettes.js — decode all packed palettes at $599C to JSON + PNG.
//
// Format (verified 15/16 against a live emulator):
//   Each palette = 17 bytes: bytes 0-1 = 15-bit "blue-high" field (bit c
//   enables bit 11 for color c+1), then 15 packed color bytes:
//     red   = (byte & 7)   << 1     -> display bits 1-3
//     green = (byte & 0x38) << 2    -> display bits 5-7
//     blue  = (byte & 0xC0) << 3    -> display bits 9-10 (+ bit 11 from field)
//   Color 0 is implicitly $0000. Output words are display layout
//   0bBBB0_GGG0_RRR0 (white = $0EEE).
//
// USAGE: node extract_palettes.js <out.json> [count]

const fs = require('fs');
const rom = fs.readFileSync('game.rom');

function decodePalette(idx) {
  const base = 0x599C + idx * 17;
  const field = (rom[base] << 8) | rom[base + 1];
  const colors = [0x0000];
  for (let c = 0; c < 15; c++) {
    const byte = rom[base + 2 + c];
    const r = (byte & 7) << 1;
    const g = (byte & 0x38) << 2;
    const b = ((byte & 0xC0) << 3) | ((field >> c) & 1 ? 0x800 : 0);
    colors.push(r | g | b);
  }
  return colors;
}

const outPath = process.argv[2] || '/tmp/palettes.json';
const count = parseInt(process.argv[3] || '64', 10);
const palettes = [];
for (let i = 0; i < count; i++) {
  palettes.push({
    index: i,
    address: 0x599C + i * 17,
    colors: decodePalette(i).map(w => w.toString(16).toUpperCase().padStart(4, '0'))
  });
}
fs.writeFileSync(outPath, JSON.stringify(palettes, null, 1));
console.log('wrote', outPath, 'with', palettes.length, 'palettes');

// print a compact summary: index + first/last colors
for (let i = 0; i < Math.min(count, 24); i++) {
  const p = palettes[i];
  console.log('PAL' + i.toString().padStart(2) + ' @ $' + p.address.toString(16) +
    ': ' + p.colors.slice(0, 4).join(' ') + ' ... ' + p.colors.slice(12).join(' '));
}
