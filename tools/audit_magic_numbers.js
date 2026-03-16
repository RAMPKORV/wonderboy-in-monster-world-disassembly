'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const counts = new Map();

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

    const lines = fs.readFileSync(fullPath, 'utf8').split(/\r?\n/);
    for (const line of lines) {
      const code = line.split(';')[0];
      if (/\bequ\b/i.test(code)) {
        continue;
      }
      const matches = code.match(/\$[0-9A-Fa-f]+\b/g);
      if (!matches) {
        continue;
      }
      for (const match of matches) {
        counts.set(match.toUpperCase(), (counts.get(match.toUpperCase()) || 0) + 1);
      }
    }
  }
}

walk(repoRoot);

const rows = [...counts.entries()].sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0])).slice(0, 25);
console.log('audit_magic_numbers.js: warning-level report');
for (const [literal, count] of rows) {
  console.log(`  ${literal} count=${count}`);
}

process.exit(0);
