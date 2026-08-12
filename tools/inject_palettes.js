#!/usr/bin/env node
// inject_palettes.js — pack 16 display-layout colors back to the ROM's 17-byte
// palette format at $599C. Inverse of tools/extract_palettes.js.
//
// Input JSON: array of palettes, each { index, colors: [16 hex words] }.
// Packing: byte = r | (g<<3) | (blueHi2 << 6); field bit c = color[c+1] bit 11.
// USAGE: node inject_palettes.js palettes.json <rom_out.bin> [--verify]
const fs = require('fs');

function packPalette(colors) {
  const field = new Array(15).fill(0);
  const bytes = [];
  for (let c = 1; c < 16; c++) {
    const w = parseInt(colors[c], 16);
    const r = (w >> 1) & 7;
    const g = (w >> 5) & 7;
    const bHi = (w >> 9) & 3;
    bytes.push(r | (g << 3) | (bHi << 6));
    if ((w >> 11) & 1) field[c - 1] = 1;
  }
  // field = bits 0-14 (color c+1 uses bit c). Stored as byte0<<8 | byte1 (D3).
  let f = 0;
  for (let c = 0; c < 15; c++) if (field[c]) f |= 1 << c;
  return [f >> 8, f & 0xff, ...bytes];
}

const inJson = process.argv[2];
const outPath = process.argv[3];
const verify = process.argv.includes('--verify');
const rom = fs.readFileSync('game.rom');
const palettes = JSON.parse(fs.readFileSync(inJson, 'utf8'));

const out = Buffer.from(rom);
let changed = 0;
for (const p of palettes) {
  const base = 0x599C + p.index * 17;
  const packed = packPalette(p.colors);
  for (let i = 0; i < 17; i++) {
    if (out[base + i] !== packed[i]) { out[base + i] = packed[i]; changed++; }
  }
}
fs.writeFileSync(outPath, out);
console.log('wrote', outPath, '| bytes changed:', changed);

if (verify) {
  // extract original palettes, re-inject, confirm identical to original ROM
  let mism = 0;
  for (const p of palettes) {
    const base = 0x599C + p.index * 17;
    for (let i = 0; i < 17; i++) if (rom[base + i] !== out[base + i]) mism++;
  }
  console.log('verify: bytes differing from original ROM:', mism);
}
