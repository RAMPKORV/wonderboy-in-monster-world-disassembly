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
const addrToLabel = new Map();
for (const path of walk('src')) {
  const lines = fs.readFileSync(path, 'latin1').split(/\r?\n/);
  let pending = [];
  for (const ln of lines) {
    const lm = /^([A-Za-z_][A-Za-z0-9_]*):/.exec(ln);
    if (lm) { pending.push(lm[1]); continue; }
    const am = /;\s*\$([0-9A-Fa-f]{4,6})$/.exec(ln);
    if (am && pending.length) {
      const a = parseInt(am[1], 16).toString(16).toUpperCase();
      if (!addrToLabel.has(a)) addrToLabel.set(a, pending[0]);
      pending = [];
    }
  }
}
const counts = { jsr: 0, jmp: 0, bsr: 0, bra: 0, hasLabel: 0, noLabel: 0 };
const noLabelAddrs = new Set();
for (const path of walk('src')) {
  const txt = fs.readFileSync(path, 'latin1');
  for (const m of txt.matchAll(/\b(jsr|jmp|bsr|bra)\s+\$([0-9A-Fa-f]{4,6})(?:\.([wl]))?\b/g)) {
    const op = m[1], hex = m[2];
    counts[op]++;
    const key = parseInt(hex, 16).toString(16).toUpperCase();
    if (addrToLabel.has(key)) counts.hasLabel++;
    else { counts.noLabel++; noLabelAddrs.add(key); }
  }
}
console.log(counts);
console.log('distinct unlabeled targets:', noLabelAddrs.size);
console.log([...noLabelAddrs].sort().slice(0, 40).join(' '));
