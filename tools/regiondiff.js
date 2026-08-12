#!/usr/bin/env node
// regiondiff.js — diff out.bin vs the target ROM over [startHex,endHex).
// Prints each differing byte offset + values. Also reports a summary.
// Usage: node tools/regiondiff.js <rom> <startHex> <endHex> [out.bin]
const fs = require('fs');
const [, , romArg, sArg, eArg, outArg] = process.argv;
if (!romArg || !sArg || !eArg) {
  console.error('Usage: regiondiff.js <rom> <startHex> <endHex> [outFile]');
  process.exit(1);
}
const rom = fs.readFileSync(romArg);
const out = fs.readFileSync(outArg || 'out.bin');
const s = parseInt(sArg, 16), e = parseInt(eArg, 16);
const r = rom.slice(s, e), o = out.slice(s, e);
if (r.length !== o.length) {
  console.log(`SIZE MISMATCH in region: rom=${r.length} out=${o.length}`);
  const min = Math.min(r.length, o.length);
  for (let i = 0; i < min; i++) if (r[i] !== o[i])
    console.log(`diff $${(s + i).toString(16).toUpperCase()} rom=${r[i].toString(16)} out=${o[i].toString(16)}`);
} else {
  let n = 0;
  for (let i = 0; i < r.length; i++) if (r[i] !== o[i]) {
    n++;
    if (n <= 24)
      console.log(`diff $${(s + i).toString(16).toUpperCase()} rom=${r[i].toString(16)} out=${o[i].toString(16)}`);
  }
  console.log(`region $${s.toString(16)}-$${e.toString(16)}: ${n} differing byte(s)`);
}