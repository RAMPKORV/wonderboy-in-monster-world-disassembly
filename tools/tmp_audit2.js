const fs = require('fs');
const files = fs.readdirSync('src').filter(f => f.endsWith('.asm'));
let total = 0;
for (const f of files) {
  const lines = fs.readFileSync('src/' + f, 'latin1').split(/\r?\n/);
  let loc = 0, named = 0;
  const locs = [];
  for (const ln of lines) {
    const m = /^([A-Za-z_][A-Za-z0-9_]*):/.exec(ln);
    if (m) { if (m[1].startsWith('loc_')) { loc++; locs.push(m[1]); } else named++; }
  }
  total += loc;
  if (loc > 0) console.log(f + ': ' + loc + ' loc_ | ' + named + ' named | ' + locs.join(' '));
}
console.log('TOTAL loc_ labels:', total);
