const fs = require('fs');
const files = fs.readdirSync('src').filter(f => f.endsWith('.asm'));
const forms = new Map();
for (const f of files) {
  const lines = fs.readFileSync('src/' + f, 'latin1').split(/\r?\n/);
  for (const ln of lines) {
    const code = ln.split(';')[0];
    for (const mm of code.matchAll(/\(?\$((?:00)?FF[0-9A-F]{4,6})\)?(?:\.w|\.l)?/g)) {
      const full = mm[0];
      const key = full.replace(/\$/, '').replace(/\(|\)|\.w|\.l/g, '');
      if (!forms.has(key)) forms.set(key, []);
      forms.get(key).push({ f, full });
    }
  }
}
const sorted = [...forms.entries()].sort((a, b) => a[0].localeCompare(b[0]));
let out = '';
for (const [key, occ] of sorted) {
  const samples = [...new Set(occ.map(o => o.full))].join('|');
  out += key + '\t' + samples + '\n';
}
fs.writeFileSync('/tmp/ramforms.txt', out);
console.log('distinct RAM address keys:', sorted.length);
