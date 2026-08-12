const fs = require('fs');
function walk(dir) {
  const out = [];
  for (const f of fs.readdirSync(dir)) {
    const p = dir + '/' + f;
    if (fs.statSync(p).isDirectory()) out.push(...walk(p));
    else if (f.endsWith('.asm')) out.push(p);
  }
  return out;
}
// Build addr -> label map; prefer the ; loc_000XXXXX provenance comment address,
// else the next instruction's ; $HEX.
const addrToLabel = new Map();
for (const path of walk('src')) {
  const lines = fs.readFileSync(path, 'latin1').split(/\r?\n/);
  let pending = [];
  for (let i = 0; i < lines.length; i++) {
    const ln = lines[i];
    const lm = /^([A-Za-z_][A-Za-z0-9_]*):/.exec(ln);
    if (lm) {
      // check the label's own provenance comment first: ; loc_000XXXX
      const prov = /loc_000([0-9A-Fa-f]{4,6})/.exec(ln);
      if (prov) {
        const a = prov[1].toUpperCase();
        if (!addrToLabel.has(a)) addrToLabel.set(a, lm[1]);
      } else {
        pending.push({ name: lm[1], line: ln });
      }
      continue;
    }
    const prov = /loc_000([0-9A-Fa-f]{4,6})/.exec(ln);
    if (prov && pending.length) {
      const a = prov[1].toUpperCase();
      if (!addrToLabel.has(a)) addrToLabel.set(a, pending[0].name);
      pending = [];
      continue;
    }
    const am = /;\s*\$([0-9A-Fa-f]{4,6})$/.exec(ln);
    if (am && pending.length) {
      const a = parseInt(am[1], 16).toString(16).toUpperCase();
      if (!addrToLabel.has(a)) addrToLabel.set(a, pending[0].name);
      pending = [];
    }
  }
}
console.log('labels mapped:', addrToLabel.size);
let total = 0;
for (const path of walk('src')) {
  let txt = fs.readFileSync(path, 'latin1');
  let before = txt;
  txt = txt.replace(/\b(jsr|jmp|bsr|bra)\s+\$([0-9A-Fa-f]{4,6})(?:\.([wl]))?\b/g, (m, op, hex, sz) => {
    const key = parseInt(hex, 16).toString(16).toUpperCase();
    const lab = addrToLabel.get(key);
    if (!lab) return m;
    const s = sz || 'w';
    total++;
    return op + ' ' + lab + '.' + s;
  });
  if (txt !== before) { fs.writeFileSync(path, txt); console.log(path); }
}
console.log('references replaced:', total);
