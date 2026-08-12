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
const addrLine = new Map();
for (const path of walk('src')) {
  const lines = fs.readFileSync(path, 'latin1').split(/\r?\n/);
  for (const ln of lines) {
    const am = /;\s*\$([0-9A-Fa-f]{4,6})$/.exec(ln);
    if (am) addrLine.set(parseInt(am[1], 16).toString(16).toUpperCase(), path.replace('src/', '') + ' | ' + ln.trim());
  }
}
const targets = '1032 1042 1090C 10910 11C9E 12812 133B2 13542 1357E 1AA3C 1AD62 1C330 1C494 2CF0 4356 43BC 46D6 46DA 46F4 4778 4792 47AE 4814 4910 4CA8 4CB8 50D4 5262 76C4 7EEE 85A8 882C 8A04 8A3A 8AA2 DD7C DE6A F906'.split(' ');
for (const t of targets) {
  const info = addrLine.get(t.toUpperCase());
  if (info) console.log(t + ': ' + info);
  else console.log(t + ': (no line)');
}
