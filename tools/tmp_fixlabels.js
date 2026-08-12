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
// For each label line with a ; loc_000XXXX provenance comment, if the label's
// current position is AFTER the instruction that carries ; $XXXX, move the label
// up so it points at the true entry address.
let moved = 0;
for (const path of walk('src')) {
  const lines = fs.readFileSync(path, 'latin1').split(/\r?\n/);
  const out = [];
  let changed = false;
  for (let i = 0; i < lines.length; i++) {
    const ln = lines[i];
    const prov = /^([A-Za-z_][A-Za-z0-9_]*):\s*;.*loc_000([0-9A-Fa-f]{4,6})/.exec(ln);
    if (!prov) { out.push(ln); continue; }
    const want = parseInt(prov[2], 16).toString(16).toUpperCase();
    // find the most recent emitted line carrying ; $HEX
    let j = out.length - 1;
    let entryLine = -1;
    while (j >= 0) {
      const am = /;\s*\$([0-9A-Fa-f]{4,6})$/.exec(out[j]);
      if (am && parseInt(am[1], 16).toString(16).toUpperCase() === want) { entryLine = j; break; }
      if (/;\s*\$/.test(out[j]) && !/loc_000/.test(out[j])) break; // a different address - stop
      j--;
    }
    if (entryLine >= 0) {
      // move the label before the entry instruction line
      const labelLine = ln;
      out.splice(entryLine, 0, labelLine);
      changed = true;
      moved++;
      continue;
    }
    out.push(ln);
  }
  if (changed) fs.writeFileSync(path, out.join('\n'));
}
console.log('labels moved:', moved);
