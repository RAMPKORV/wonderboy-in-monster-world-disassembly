const fs = require('fs');
const rom = fs.readFileSync('game.rom');
const words = [];
let i = 0x22027;
for (let n = 0; n < 200; n++) {
  const e = rom.indexOf(0, i);
  if (e < 0 || e - i > 30) break;
  words.push(rom.slice(i, e).toString('ascii'));
  i = e + 1;
}
function word(idx) { return (idx < words.length && words[idx]) ? words[idx] : '<?' + idx.toString(16) + '>'; }
function decodeText(start, end) {
  const out = [];
  let i = start;
  while (i < end) {
    const b = rom[i];
    if (b === 0x00 || b === 0x05) { out.push('\n'); i++; continue; }
    if (b === 0x09) { out.push('\n'); i++; continue; }
    if (b === 0x02) { out.push('…'); i++; continue; }
    if (b === 0x04) { i++; continue; }
    if (b === 0x0C) {
      const nb = rom[i + 1];
      out.push(nb < 0x40 ? word(nb) : word(nb - 0x40));
      i += 2; continue;
    }
    if (b >= 0x20 && b < 0x7F) { out.push(String.fromCharCode(b)); i++; continue; }
    if (b === 0x01) { i++; continue; }   // font/name toggle
    if (b === 0x0B || b === 0x10) { i += 2; continue; } // speaker/control
    if (b === 0x03 || b === 0x06 || b === 0x07 || b === 0x08 || b === 0x0A || b === 0x0F) { i++; continue; }
    i++;
  }
  return out.join('').replace(/\n{3,}/g, '\n\n');
}
const SCENE_TABLE = 0x1DD94;
const scenes = [];
for (let idx = 0; idx < 200; idx++) {
  const off = SCENE_TABLE + idx * 3;
  const type = rom[off];
  const offset = (rom[off + 1] << 8) | rom[off + 2];
  const dataAddr = SCENE_TABLE + offset;
  if (dataAddr <= SCENE_TABLE + idx * 3 && idx > 0) break;
  if (dataAddr >= SCENE_TABLE + 0x3000) break;
  scenes.push({ index: idx, type, dataAddr });
}
fs.mkdirSync('text', { recursive: true });
let all = '# Dialogue — Wonder Boy in Monster World\n\n';
for (let k = 0; k < scenes.length; k++) {
  const s = scenes[k];
  const end = (k + 1 < scenes.length) ? scenes[k + 1].dataAddr : 0x20000;
  const t = decodeText(s.dataAddr, end);
  all += '## Scene ' + s.index + ' (type ' + s.type + ' @ $' + s.dataAddr.toString(16) + ')\n\n' + t + '\n\n---\n\n';
}
fs.writeFileSync('text/dialogue.md', all);
console.log('wrote text/dialogue.md (' + scenes.length + ' scenes)');
console.log(all.split('---')[1]);
