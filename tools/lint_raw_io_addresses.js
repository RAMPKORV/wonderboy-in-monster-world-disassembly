'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const targets = [
  '$00C00000', '$00C00004', '$00C00011', '$00A10001', '$00A10003', '$00A10005',
  '$00A10007', '$00A10009', '$00A11100', '$00A11200'
];
const ignore = new Set(['hw_constants.asm', 'header.asm']);
const hits = [];

function walk(dirPath) {
  for (const entry of fs.readdirSync(dirPath, { withFileTypes: true })) {
    const fullPath = path.join(dirPath, entry.name);
    if (entry.isDirectory()) {
      walk(fullPath);
      continue;
    }
    if (!entry.name.toLowerCase().endsWith('.asm') || ignore.has(entry.name)) {
      continue;
    }

    const relPath = path.relative(repoRoot, fullPath);
    const lines = fs.readFileSync(fullPath, 'utf8').split(/\r?\n/);
    lines.forEach((line, index) => {
      for (const target of targets) {
        if (line.includes(target)) {
          hits.push(`${relPath}:${index + 1}: ${target}`);
        }
      }
    });
  }
}

walk(repoRoot);

if (hits.length === 0) {
  console.log('lint_raw_io_addresses.js: no raw I/O addresses found outside constants/header');
  process.exit(0);
}

console.error(`lint_raw_io_addresses.js: found ${hits.length} raw I/O address occurrence(s)`);
for (const hit of hits) {
  console.error(`  ${hit}`);
}
process.exit(1);
