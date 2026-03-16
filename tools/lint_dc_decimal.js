'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const hits = [];
const directivePattern = /^\s*dc\.[bwl]\s+(.+)$/i;
const decimalTokenPattern = /(^|[,\s])(\d+)(?=$|[,\s])/g;

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
      const code = line.split(';')[0];
      const match = code.match(directivePattern);
      if (!match) {
        return;
      }

      const values = match[1];
      if (values.includes('"') || values.includes("'")) {
        return;
      }

      const found = [];
      let token;
      while ((token = decimalTokenPattern.exec(values)) !== null) {
        found.push(token[2]);
      }
      decimalTokenPattern.lastIndex = 0;

      if (found.length > 0) {
        hits.push(`${relPath}:${index + 1}: ${found.join(', ')}`);
      }
    });
  }
}

walk(repoRoot);

if (hits.length === 0) {
  console.log('lint_dc_decimal.js: no decimal dc.* literals found');
  process.exit(0);
}

console.error(`lint_dc_decimal.js: found ${hits.length} decimal dc.* literal occurrence(s)`);
for (const hit of hits) {
  console.error(`  ${hit}`);
}
process.exit(1);
