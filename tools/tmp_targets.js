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
// build addr -> line text map
const addrLine = new Map();
for (const path of walk('src')) {
  const lines = fs.readFileSync(path, 'latin1').split(/\r?\n/);
  for (const ln of lines) {
    const am = /;\s*\$([0-9A-Fa-f]{4,6})$/.exec(ln);
    if (am) addrLine.set(parseInt(am[1], 16).toString(16).toUpperCase(), path + ' | ' + ln.trim());
  }
}
const targets = '1032 1042 1090C 10910 11C9E 127A 12812 133B2 13542 1357E 13BC 1AA3C 1AD62 1B50 1C330 1C494 1FD0 225C 22F0 23E4 245A 24DC 2542 266C 2672 26F0 274C 2752 2758 279C 27E6 2856 2AAE 2CF0 2F8E 2FD0 303A 3F54 3F58 3FAC'.split(' ');
for (const t of targets) {
  console.log(t + ': ' + (addrLine.get(t.toUpperCase()) || '?'));
}
