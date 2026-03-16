'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const rows = [];

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
    let codeLines = 0;
    let commentLines = 0;
    for (const line of lines) {
      const trimmed = line.trim();
      if (!trimmed) {
        continue;
      }
      if (trimmed.startsWith(';')) {
        commentLines += 1;
        continue;
      }
      if (trimmed.includes(';')) {
        commentLines += 1;
      }
      codeLines += 1;
    }

    const ratio = codeLines === 0 ? 0 : commentLines / codeLines;
    rows.push({ file: relPath, codeLines, commentLines, ratio });
  }
}

walk(repoRoot);
rows.sort((a, b) => a.ratio - b.ratio || a.file.localeCompare(b.file));

console.log('comment_density.js: warning-level report');
for (const row of rows) {
  console.log(`  ${row.file} code=${row.codeLines} comments=${row.commentLines} ratio=${row.ratio.toFixed(2)}`);
}

process.exit(0);
