#!/usr/bin/env node
// extract_text.js — extract dialogue/text from the ROM's text regions.
//
// Text encoding (partially cracked):
//   0x00 / 0x05        end of string
//   0x09               line break
//   0x02               ellipsis/continue marker
//   0x0C xx            dictionary word reference (xx < 192) or effect control
//   0x0B xx            control (speaker/effect)
//   0x10 xx            control
//   else 0x20-0x7E     literal ASCII
// The dictionary (192 NUL-terminated words) is at ROM $022026.
//
// USAGE: node extract_text.js <out.json> [startHex] [endHex]
const fs = require('fs');
const rom = fs.readFileSync('game.rom');

const dict = (() => {
  const words = [];
  let i = 0x22026;
  while (i < rom.length) {
    const end = rom.indexOf(0, i);
    if (end < 0 || end - i > 24) break;
    words.push(rom.slice(i, end).toString('ascii'));
    i = end + 1;
  }
  return words;
})();

function decode(start) {
  const out = [];
  let i = start;
  while (i < rom.length) {
    const b = rom[i];
    if (b === 0x05 || b === 0x00) break;
    if (b === 0x09) { out.push('\n'); i++; continue; }
    if (b === 0x02) { out.push('…'); i++; continue; }
    if (b === 0x0C || b === 0x0B || b === 0x10) {
      const idx = rom[i + 1];
      const w = idx < dict.length ? dict[idx] : '';
      out.push(w && w.length ? '{' + w + '}' : '<' + b.toString(16).padStart(2, '0') + ':' + idx.toString(16).padStart(2, '0') + '>');
      i += 2; continue;
    }
    if (b >= 0x20 && b < 0x7F) { out.push(String.fromCharCode(b)); i++; continue; }
    out.push('[' + b.toString(16).padStart(2, '0') + ']');
    i++;
  }
  return out.join('').replace(/\n/g, ' / ');
}

const outPath = process.argv[2] || '/tmp/text.json';
const start = parseInt(process.argv[3] || '20000', 16);
const end = parseInt(process.argv[4] || '24000', 16);
const strings = [];
let i = start;
while (i < end) {
  const b = rom[i];
  if (b === 0x05 || b === 0x00) {
    const j = i + 1;
    if (rom[j] === 0x09 || rom[j] === 0x0C || rom[j] === 0x0B || rom[j] === 0x10 || (rom[j] >= 0x20 && rom[j] < 0x7F)) {
      const text = decode(j);
      if (text.trim().length >= 2) strings.push({ address: '$' + j.toString(16), text });
      let k = j;
      while (k < rom.length && rom[k] !== 0x05 && rom[k] !== 0x00) k++;
      i = k + 1;
      continue;
    }
  }
  i++;
}
fs.writeFileSync(outPath, JSON.stringify(strings, null, 1));
console.log('wrote', outPath, 'with', strings.length, 'strings (dictionary:', dict.length, 'words)');
for (const s of strings.slice(0, 12)) console.log(s.address + ': ' + s.text.slice(0, 100));
