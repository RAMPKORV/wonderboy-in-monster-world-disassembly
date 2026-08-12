const fs = require('fs');
const f = process.argv[2];
const lines = fs.readFileSync(f, 'latin1').split(/\r?\n/);
for (let i = 0; i < lines.length; i++) {
  const m = /^([A-Za-z_][A-Za-z0-9_]*):/.exec(lines[i]);
  if (m && m[1].startsWith('loc_')) {
    console.log('=== ' + m[1] + ' (line ' + (i + 1) + ') ===');
    console.log(lines.slice(i, Math.min(i + 14, lines.length)).map((l, k) => (k === 0 ? '>>' : '  ') + l).join('\n'));
    console.log('');
  }
}
