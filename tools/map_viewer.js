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
const offset = Number.parseInt(getArg('--offset', '0x200'), 0);
const width = Number.parseInt(getArg('--width', '16'), 0);
const height = Number.parseInt(getArg('--height', '16'), 0);

const data = fs.readFileSync(filePath);
console.log(`map_viewer.js: ${path.relative(repoRoot, filePath)} offset=0x${offset.toString(16)} size=${width}x${height}`);
for (let y = 0; y < height; y += 1) {
  const row = [];
  for (let x = 0; x < width; x += 1) {
    const pos = offset + y * width + x;
    if (pos >= data.length) {
      row.push('..');
    } else {
      row.push(data[pos].toString(16).padStart(2, '0'));
    }
  }
  console.log(`  ${row.join(' ')}`);
}
