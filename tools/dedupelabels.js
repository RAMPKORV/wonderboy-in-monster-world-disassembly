#!/usr/bin/env node
// dedupelabels.js — remove consecutive duplicate label lines.
const fs = require('fs');
const f = process.argv[2];
const lines = fs.readFileSync(f, 'utf8').split('\n');
const out = [];
for (const line of lines) {
  if (out.length && line === out[out.length - 1]) continue;
  out.push(line);
}
fs.writeFileSync(f, out.join('\n') + '\n');
console.log('deduped', lines.length - out.length, 'lines');
