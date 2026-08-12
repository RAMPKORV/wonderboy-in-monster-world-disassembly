#!/usr/bin/env node
// extract_scenes.js — walk the scene table and dump each scene's type entry,
// data pointer, and readable text preview. Outputs scenes/scenes.json.
//
// Scene table at $1DD94 (pointer $1CC14): entry i = [type][off16],
// sceneData = $1DD94 + offset. Type table at $1DD74 (pointer $1CC18):
// per-type [X][Y][W][H].

const fs = require('fs');
const rom = fs.readFileSync('game.rom');
const SCENE_TABLE = 0x1DD94;
const TYPE_TABLE = 0x1DD74;
const MAX_SCENES = 256;

function printable(addr, maxLen) {
  // extract printable ASCII runs (skip control bytes 0x00-0x08, keep 0x09/0x0A/0x0D as separators)
  let s = '';
  for (let i = 0; i < maxLen && addr + i < rom.length; i++) {
    const b = rom[addr + i];
    if (b >= 0x20 && b < 0x7F) s += String.fromCharCode(b);
    else if (b === 0x00) break;
    else s += '·';
  }
  return s;
}

const scenes = [];
for (let i = 0; i < MAX_SCENES; i++) {
  const off = SCENE_TABLE + i * 3;
  if (off + 3 > rom.length) break;
  const type = rom[off];
  const offset = (rom[off + 1] << 8) | rom[off + 2];
  const dataAddr = SCENE_TABLE + offset;
  if (dataAddr <= SCENE_TABLE + i * 3 && i > 0) break;
  if (dataAddr >= SCENE_TABLE + 0x3000) break;
  const geo = [rom[TYPE_TABLE + type * 4], rom[TYPE_TABLE + type * 4 + 1], rom[TYPE_TABLE + type * 4 + 2], rom[TYPE_TABLE + type * 4 + 3]];
  scenes.push({
    index: i, type, offset,
    dataAddr: '0x' + dataAddr.toString(16),
    geom: { x: geo[0], y: geo[1], w: geo[2], h: geo[3] },
    text: printable(dataAddr, 60),
  });
}
fs.mkdirSync('scenes', { recursive: true });
fs.writeFileSync('scenes/scenes.json', JSON.stringify(scenes, null, 1));
console.log('wrote scenes/scenes.json (' + scenes.length + ' scenes)');
// print a sample table
for (const s of scenes.slice(0, 12)) {
  console.log('scene ' + String(s.index).padStart(2) + ' type ' + s.type + ' ' + s.dataAddr + ' w' + s.geom.w + 'h' + s.geom.h + ' | ' + s.text.slice(0, 40));
}
