#!/usr/bin/env node
// inject_maps.js — recompress an edited tag-$02 map back into a ROM copy.
// The payload is written either over the original slot (if it fits) or into
// free space with the flagged-table record updated to point at it.
//
// USAGE: node inject_maps.js <mapBinFile> [romOut]

const fs = require('fs');
const { compress } = require('./compress_tag02.js');
const { decompress } = require('./decompress_tag02.js');

const mapFile = process.argv[2];
const romOut = process.argv[3] || 'game_patched.bin';
if (!mapFile) { console.log('usage: node inject_maps.js <mapBinFile> [romOut]'); process.exit(1); }
const m = /map_([0-9A-Fa-f]+)\.bin$/.exec(mapFile);
if (!m) { console.log('map filename must be maps/map_<HEXADDR>.bin'); process.exit(1); }
const addr = parseInt(m[1], 16);

const rom = fs.readFileSync('game.rom');
const data = fs.readFileSync(mapFile);
const res = decompress(rom, addr);
const oldLen = res.next - addr;
const out = compress(data);
const patched = Buffer.from(rom);

// locate the flagged-table record that points at this payload
let record = -1;
for (let off = 0x41000; off < 0x41B40; off += 4) {
  const tag = rom[off];
  const a = (rom[off + 1] << 16) | (rom[off + 2] << 8) | rom[off + 3];
  if (tag === 2 && a === addr) { record = off; break; }
}
if (record < 0) { console.log('ERROR: no flagged-table tag-2 record points at $' + addr.toString(16)); process.exit(1); }

if (out.length <= oldLen) {
  out.copy(patched, addr);
  patched.fill(0, addr + out.length, addr + oldLen);
  console.log('in-place: $' + addr.toString(16) + ' (' + out.length + '/' + oldLen + ' bytes)');
} else {
  // relocate into the $FF-padded free region at the end of the bank
  let free = 0xA4C77;
  // scan for a run of 0xFF big enough
  let best = -1, bestLen = 0, run = 0, runStart = 0;
  for (let i = 0xA4C77; i < 0xBFFFF - out.length; i++) {
    if (patched[i] === 0xFF) { if (run === 0) runStart = i; run++; if (run > bestLen) { bestLen = run; best = runStart; } }
    else run = 0;
  }
  if (bestLen < out.length) { console.log('ERROR: no free region big enough in $A4C77-$BFFFF'); process.exit(1); }
  free = best;
  out.copy(patched, free);
  // update the flagged-table record's 24-bit address
  patched[record + 1] = (free >> 16) & 0xFF;
  patched[record + 2] = (free >> 8) & 0xFF;
  patched[record + 3] = free & 0xFF;
  console.log('relocated: $' + addr.toString(16) + ' -> $' + free.toString(16) + ' (' + out.length + ' bytes, slot ' + oldLen + ')');
}
fs.writeFileSync(romOut, patched);
const verify = decompress(patched, (out.length <= oldLen) ? addr : (() => { const r2 = (patched[record+1]<<16)|(patched[record+2]<<8)|patched[record+3]; return r2; })());
console.log('round-trip after patch:', verify.data.equals(data) ? 'OK' : 'MISMATCH');
console.log('wrote', romOut);
