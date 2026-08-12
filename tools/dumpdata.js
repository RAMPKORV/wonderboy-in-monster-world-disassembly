#!/usr/bin/env node
// dumpdata.js — dump ROM bytes [startHex,endHex) as dc.b lines for pasting
// into a module. Usage: node tools/dumpdata.js <rom> <startHex> <endHex> [perLine]
const fs = require('fs');
const [, , romArg, sArg, eArg, perArg] = process.argv;
const rom = fs.readFileSync(romArg);
const s = parseInt(sArg, 16), e = parseInt(eArg, 16);
const per = parseInt(perArg || '16', 10);
let out = [];
for (let a = s; a < e; a += per) {
  const slice = [];
  for (let i = 0; i < per && a + i < e; i++)
    slice.push('$' + rom[a + i].toString(16).padStart(2, '0'));
  out.push('\tdc.b\t' + slice.join(', '));
}
console.log(out.join('\n'));
