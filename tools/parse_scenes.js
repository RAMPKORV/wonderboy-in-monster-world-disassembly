#!/usr/bin/env node
// parse_scenes.js — segment each scene's bytecode into control bytes + editable
// text runs. Writes text/scenes.json (the mod-editing format) and regenerates
// text/dialogue.md (human-readable).
//
// Each scene's data is a script bytecode. Text runs are ASCII chars, 0x0C word
// references (word index: byte<0x40 ? byte : byte-0x40), ellipsis 0x02 and line
// breaks 0x09. Everything else is preserved verbatim as a control segment.

const fs = require('fs');
const rom = fs.readFileSync('game.rom');
const words = [];
let wi = 0x22027;
for (let n = 0; n < 200; n++) {
  const e = rom.indexOf(0, wi);
  if (e < 0 || e - wi > 30) break;
  words.push(rom.slice(wi, e).toString('ascii'));
  wi = e + 1;
}
function word(idx) { return (idx < words.length && words[idx]) ? words[idx] : null; }

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

function isTextByte(b) {
  return (b >= 0x20 && b < 0x7F) || b === 0x02 || b === 0x09 || b === 0x0C;
}
function segmentScene(dataAddr, endAddr) {
  const segs = [];
  let i = dataAddr;
  while (i < endAddr) {
    const b = rom[i];
    if (isTextByte(b) || b === 0x0C) {
      // start a text run
      let j = i;
      let text = '';
      const raw = [];
      while (j < endAddr) {
        const c = rom[j];
        if (c >= 0x20 && c < 0x7F) { text += String.fromCharCode(c); raw.push(c); j++; continue; }
        if (c === 0x02) { text += '…'; raw.push(c); j++; continue; }
        if (c === 0x09) { text += '\n'; raw.push(c); j++; continue; }
        if (c === 0x0C) {
          const nb = rom[j + 1];
          const w = nb < 0x40 ? word(nb) : word(nb - 0x40);
          text += (w || ('<?' + nb.toString(16) + '>'));
          raw.push(c, nb);
          j += 2; continue;
        }
        break;
      }
      segs.push({ type: 'text', text, origText: text, raw: Array.from(raw) });
      i = j;
    } else {
      // control byte(s); capture the raw bytes verbatim
      let j = i;
      if (b === 0x0B || b === 0x10) j += 2;
      else j += 1;
      segs.push({ type: 'ctl', raw: Array.from(rom.slice(i, j)) });
      i = j;
    }
  }
  return segs;
}

const out = [];
for (let k = 0; k < scenes.length; k++) {
  const s = scenes[k];
  const end = (k + 1 < scenes.length) ? scenes[k + 1].dataAddr : 0x20000;
  const segs = segmentScene(s.dataAddr, end);
  out.push({ index: s.index, type: s.type, dataAddr: s.dataAddr, segments: segs });
}
fs.mkdirSync('text', { recursive: true });
fs.writeFileSync('text/scenes.json', JSON.stringify(out, null, 1));
console.log('wrote text/scenes.json (' + out.length + ' scenes)');
