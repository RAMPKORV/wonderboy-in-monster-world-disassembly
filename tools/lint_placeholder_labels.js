'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const matches = [];
const patterns = [
  /\bFUN_[0-9A-Fa-f]+\b/g,
  /\bLAB_[0-9A-Fa-f]+\b/g,
  /\bDAT_[0-9A-Fa-f]+\b/g,
  /\bSUB_[0-9A-Fa-f]+\b/g,
  /\bUNK_[0-9A-Fa-f]+\b/g,
  /\bloc_[0-9A-Fa-f]+\b/g,
  /\bsub_[0-9A-Fa-f]{4,}\b/g
];

function walk(dirPath) {
  for (const entry of fs.readdirSync(dirPath, { withFileTypes: true })) {
    const fullPath = path.join(dirPath, entry.name);
    if (entry.isDirectory()) {
      walk(fullPath);
      continue;
    }
    if (!entry.name.toLowerCase().endsWith('.asm')) {
      continue;
    }

    const relPath = path.relative(repoRoot, fullPath);
    const lines = fs.readFileSync(fullPath, 'utf8').split(/\r?\n/);
    lines.forEach((line, index) => {
      for (const pattern of patterns) {
        const found = line.match(pattern);
        if (found) {
          matches.push(`${relPath}:${index + 1}: ${found.join(', ')}`);
        }
      }
    });
  }
}

walk(repoRoot);

if (matches.length === 0) {
  console.log('lint_placeholder_labels.js: no placeholder labels found');
  process.exit(0);
}

console.error(`lint_placeholder_labels.js: found ${matches.length} placeholder label occurrence(s)`);
for (const match of matches) {
  console.error(`  ${match}`);
}
process.exit(1);
