'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const args = process.argv.slice(2);

function getArg(flag, fallback) {
  const index = args.indexOf(flag);
  return index !== -1 && args[index + 1] ? args[index + 1] : fallback;
}

const filePath = path.resolve(repoRoot, getArg('--file', 'wonderboy.bin'));
const offset = Number.parseInt(getArg('--offset', '0x100'), 0);
const count = Number.parseInt(getArg('--count', '16'), 0);

const data = fs.readFileSync(filePath);
console.log(`palette_viewer.js: ${path.relative(repoRoot, filePath)} offset=0x${offset.toString(16)} count=${count}`);
for (let i = 0; i < count; i += 1) {
  const pos = offset + i * 2;
  if (pos + 1 >= data.length) {
    break;
  }
  const word = data.readUInt16BE(pos);
  const r = (word >> 1) & 0x7;
  const g = (word >> 5) & 0x7;
  const b = (word >> 9) & 0x7;
  console.log(`  [${i.toString().padStart(2, '0')}] 0x${pos.toString(16).padStart(6, '0')} raw=0x${word.toString(16).padStart(4, '0')} rgb3=${r},${g},${b}`);
}
