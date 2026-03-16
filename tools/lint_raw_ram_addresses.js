'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const ramPattern = /\$00FF[0-9A-Fa-f]{4}\b/g;
const ignore = new Set(['ram_addresses.asm', 'header.asm']);
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
      const found = line.match(ramPattern);
      if (found) {
        hits.push(`${relPath}:${index + 1}: ${found.join(', ')}`);
      }
    });
  }
}

walk(repoRoot);

if (hits.length === 0) {
  console.log('lint_raw_ram_addresses.js: no raw RAM addresses found outside constants/header');
  process.exit(0);
}

console.error(`lint_raw_ram_addresses.js: found ${hits.length} raw RAM address occurrence(s)`);
for (const hit of hits) {
  console.error(`  ${hit}`);
}
process.exit(1);
