'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const args = process.argv.slice(2);

function getArg(flag, fallback) {
  const index = args.indexOf(flag);
  return index !== -1 && args[index + 1] ? args[index + 1] : fallback;
}

const originalPath = path.resolve(repoRoot, getArg('--original', 'original/wonderboy.bin'));
const rebuiltPath = path.resolve(repoRoot, getArg('--rebuilt', 'out.bin'));
const limit = Number.parseInt(getArg('--limit', '32'), 10);

function load(filePath) {
  if (!fs.existsSync(filePath)) {
    console.error(`ERROR: file not found: ${filePath}`);
    process.exit(1);
  }
  return fs.readFileSync(filePath);
}

const original = load(originalPath);
const rebuilt = load(rebuiltPath);
const maxLength = Math.max(original.length, rebuilt.length);
const diffs = [];

for (let offset = 0; offset < maxLength; offset += 1) {
  const a = offset < original.length ? original[offset] : null;
  const b = offset < rebuilt.length ? rebuilt[offset] : null;
  if (a !== b) {
    diffs.push({ offset, original: a, rebuilt: b });
    if (diffs.length >= limit) {
      break;
    }
  }
}

if (diffs.length === 0 && original.length === rebuilt.length) {
  console.log('rom_diff.js: no differences found');
  process.exit(0);
}

console.log(`rom_diff.js: differences found between ${path.relative(repoRoot, originalPath)} and ${path.relative(repoRoot, rebuiltPath)}`);
console.log(`  original size: ${original.length}`);
console.log(`  rebuilt size : ${rebuilt.length}`);
for (const diff of diffs) {
  const a = diff.original === null ? '--' : diff.original.toString(16).padStart(2, '0');
  const b = diff.rebuilt === null ? '--' : diff.rebuilt.toString(16).padStart(2, '0');
  console.log(`  0x${diff.offset.toString(16).padStart(6, '0')}: original=${a} rebuilt=${b}`);
}
if (original.length !== rebuilt.length) {
  console.log('  size mismatch contributes to diff output');
}
process.exit(1);
