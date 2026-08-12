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
// find the dc.b row containing each target address
const targets = { '1032': 'Atan2Fast0', '1042': 'Atan2Fast1', '11C9E': 'Subroutine_11C9E', '2CF0': 'SpawnMonsterAt', '7EEE': 'DrawTextLine', '8A3A': 'SetItemState2' };
for (const path of walk('src')) {
  const lines = fs.readFileSync(path, 'latin1').split(/\r?\n/);
  let addr = -1;
  for (let i = 0; i < lines.length; i++) {
    const ln = lines[i];
    const am = /;\s*\$([0-9A-Fa-f]{4,6})$/.exec(ln);
    if (am) addr = parseInt(am[1], 16);
    // track current address of this row (start addr) if it's dc.b
    if (/^\tdc\.b\t/.test(ln) && am) {
      const a = parseInt(am[1], 16);
      for (const t of Object.keys(targets)) {
        const target = parseInt(t, 16);
        // approximate: the row covers a..a+n where n from value count
        const vals = ln.split('\t')[1].split(',').length;
        if (target >= a && target < a + vals) {
          console.log(path.replace('src/', '') + ' line ' + (i + 1) + ': target ' + t + ' in row @$' + a.toString(16) + ' (' + vals + ' bytes)');
        }
      }
    }
  }
}
