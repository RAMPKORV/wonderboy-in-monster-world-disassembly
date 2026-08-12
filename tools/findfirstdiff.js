#!/usr/bin/env node
// findfirstdiff.js — locate first byte where out.bin differs from the ROM.
const fs = require('fs');
const rom = fs.readFileSync(process.argv[2]);
const out = fs.readFileSync(process.argv[3] || 'out.bin');
console.log('rom', rom.length, 'out', out.length);
for (let i = 0; i < Math.min(rom.length, out.length); i++) {
  if (rom[i] !== out[i]) {
    console.log('first diff at $' + i.toString(16).toUpperCase(),
      'rom=' + rom[i].toString(16), 'out=' + out[i].toString(16));
    process.exit(0);
  }
}
console.log('identical');
