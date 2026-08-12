#!/usr/bin/env node
// addlabels.js — insert routine entry labels at given addresses.
const fs = require('fs');
const f = process.argv[2];
const labels = {};
for (const a of process.argv.slice(3)) {
  const [hex, name] = a.split('=');
  labels[parseInt(hex, 16)] = name;
}
const lines = fs.readFileSync(f, 'utf8').split('\n');
const out = [];
for (const line of lines) {
  const m = line.match(/;\s*\$([0-9A-F]{4,6})$/);
  if (m) {
    const addr = parseInt(m[1], 16);
    const lb = labels[addr];
    if (lb) out.push(lb + ':');
  }
  out.push(line);
}
fs.writeFileSync(f, out.join('\n') + '\n');
console.log('added', Object.keys(labels).length, 'labels');
