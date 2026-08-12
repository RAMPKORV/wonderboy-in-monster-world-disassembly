const fs = require('fs');
const map = JSON.parse(fs.readFileSync('/tmp/ramsymbols.json', 'latin1'));
// sort literals longest-first so overlapping keys replace safely
const literals = Object.keys(map).sort((a, b) => b.length - a.length);
function replaceLine(code) {
  for (const lit of literals) {
    const re = new RegExp('\\' + lit, 'g');
    code = code.replace(re, map[lit]);
  }
  return code;
}
let total = 0;
for (const f of fs.readdirSync('src').filter(x => x.endsWith('.asm'))) {
  const path = 'src/' + f;
  const lines = fs.readFileSync(path, 'latin1').split(/\r?\n/);
  let changed = 0;
  for (let i = 0; i < lines.length; i++) {
    const ln = lines[i];
    const semi = ln.indexOf(';');
    const code = semi >= 0 ? ln.slice(0, semi) : ln;
    const comment = semi >= 0 ? ln.slice(semi) : '';
    const newCode = replaceLine(code);
    if (newCode !== code) {
      lines[i] = newCode + comment;
      changed++;
    }
  }
  if (changed > 0) {
    fs.writeFileSync(path, lines.join('\n'));
    console.log(f + ': ' + changed + ' lines touched');
    total += changed;
  }
}
console.log('TOTAL lines touched:', total);
