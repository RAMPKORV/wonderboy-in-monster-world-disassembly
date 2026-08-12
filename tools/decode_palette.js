#!/usr/bin/env node
// decode_palette.js — decode the game's 17-byte packed palettes at $599C.
//
// Each palette = 17 bytes: byte0 (unused), byte1 bit0 = shared blue-high bit,
// then 15 packed color bytes (bits 0-2 = red, 3-5 = green, 6-7 = blue hi).
// Output is display-layout words (0bBBB0_GGG0_RRR0): color 0 = $0000,
// colors 1-15 decoded. USAGE: node decode_palette.js <indexHex> [count]
const fs = require('fs');
const rom = fs.readFileSync('game.rom');

function decodePalette(idx) {
  const base = 0x599C + idx * 17;
  const colors = [0x0000];
  const b1 = rom[base + 1];
  const blueHi = (b1 & 1) << 11;
  for (let c = 0; c < 15; c++) {
    const byte = rom[base + 2 + c];
    const r = (byte & 7) << 1;
    const g = (byte & 0x38) << 2;
    const b = ((byte & 0xC0) << 3) | blueHi;
    colors.push(r | g | b);
  }
  return colors;
}

function toRGB(w) {
  const r = (w >> 1) & 7, g = (w >> 5) & 7, b = (w >> 9) & 7;
  return `(${r},${g},${b})`;
}

const start = parseInt(process.argv[2] || '0', 16);
const count = parseInt(process.argv[3] || '8', 16);
for (let i = start; i < start + count; i++) {
  const c = decodePalette(i);
  console.log('PAL' + i + ' @ $' + (0x599C + i * 17).toString(16) + ':');
  for (let p = 0; p < 16; p += 4) {
    console.log('  ' + [0,1,2,3].map(k => '$' + c[p+k].toString(16).padStart(4,'0') + toRGB(c[p+k])).join(' '));
  }
}
