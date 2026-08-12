const fs = require('fs');
const files = fs.readdirSync('src').filter(f => f.endsWith('.asm'));
let locTotal = 0, namedTotal = 0, ramAddrs = new Set();
for (const f of files) {
  const lines = fs.readFileSync('src/' + f, 'latin1').split(/\r?\n/);
  let loc = 0, named = 0;
  for (const ln of lines) {
    const m = /^([A-Za-z_][A-Za-z0-9_]*):/.exec(ln);
    if (m) { if (m[1].startsWith('loc_')) loc++; else named++; }
    for (const mm of ln.matchAll(/\$(FFFF[0-9A-F]{4}|FF[0-9A-F]{4,6}|00FF[0-9A-F]{4,6})/g)) ramAddrs.add(mm[1].toLowerCase());
  }
  locTotal += loc; namedTotal += named;
  if (loc > 0 || named > 0) console.log(f + ': loc_' + loc + ' named ' + named);
}
console.log('TOTAL loc_ labels:', locTotal, 'named labels:', namedTotal);
console.log('distinct RAM address strings:', ramAddrs.size);
