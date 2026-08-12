const fs = require('fs');
const rom = fs.readFileSync('game.rom');
// Dictionary: words 0-167 plain ASCII at $22027; words 168+ packed/unknown.
const words = [];
let i = 0x22027;
for (let n = 0; n < 300; n++) {
  const e = rom.indexOf(0, i);
  if (e < 0 || e - i > 30) break;
  words.push({ w: rom.slice(i, e), a: i });
  i = e + 1;
}
const wordStr = (idx) => {
  if (idx < words.length) {
    const b = words[idx].w;
    if (b.every(x => x >= 0x20 && x < 0x7F)) return b.toString('ascii');
    return '‹' + [...b].map(x => x.toString(16)).join('') + '›'; // packed word
  }
  return '<?' + idx.toString(16) + '>';
};

// decode a scene-script text run (dialogue). Returns plaintext with control
// codes as readable markers.
function decodeText(start, maxLen) {
  const out = [];
  const end = Math.min(start + maxLen, rom.length);
  let i = start;
  while (i < end) {
    const b = rom[i];
    if (b === 0x00 || b === 0x05) { out.push('\n'); i++; continue; }  // end of line/box
    if (b === 0x09) { out.push('\n'); i++; continue; }
    if (b === 0x02) { out.push('…'); i++; continue; }
    if (b === 0x04) { i++; continue; } // filler
    if (b === 0x0C) { const w = wordStr(rom[i + 1]); out.push(w); i += 2; continue; }
    if (b >= 0x20 && b < 0x7F) { out.push(String.fromCharCode(b)); i++; continue; }
    // control codes and unknown bytes -> readable placeholder
    out.push('«' + b.toString(16).padStart(2, '0') + (rom[i + 1] < 0x20 || rom[i + 1] >= 0x7F ? '' : String.fromCharCode(rom[i + 1])) + '»');
    i += (b === 0x0B || b === 0x10 || b === 0x07) ? 2 : 1;
  }
  return out.join('');
}
module.exports = { decodeText, wordStr, words };
