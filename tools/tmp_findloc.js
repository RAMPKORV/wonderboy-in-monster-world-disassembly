const fs = require('fs');
const files = fs.readdirSync('src').filter(f => f.endsWith('.asm'));
for (const f of files) {
  const lines = fs.readFileSync('src/' + f, 'latin1').split(/\r?\n/);
  for (let i = 0; i < lines.length; i++) {
    const m = /^([A-Za-z_][A-Za-z0-9_]*):/.exec(lines[i]);
    if (m && m[1].startsWith('loc_')) {
      console.log(f + ':' + (i + 1) + ' ' + m[1]);
      console.log(lines.slice(i, Math.min(i + 8, lines.length)).map((l, k) => (k === 0 ? '  >>' : '     ') + l).join('\n'));
      console.log('');
    }
  }
}
