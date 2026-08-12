#!/usr/bin/env node
// findshift.js — locate where out.bin diverges from the ROM and compute the
// cumulative byte delta over the whole file.
const fs = require('fs');
const rom = fs.readFileSync(process.argv[2]);
const out = fs.readFileSync('out.bin');
console.log('rom', rom.length, 'out', out.length);
let delta = 0;
for (let i = 0; i < out.length; i++) {
  const romB = i + delta < rom.length ? rom[i + delta] : -1;
  if (out[i] === romB) continue;
  // out[i] does not match rom at i+delta; adjust delta and report
  console.log('shift starts around $' + i.toString(16).toUpperCase() +
    ' (delta ' + delta + '): out=' + out[i].toString(16) + ' rom@' + (i + delta).toString(16));
  break;
}
// total delta = out.length - rom.length
console.log('total delta:', out.length - rom.length);
