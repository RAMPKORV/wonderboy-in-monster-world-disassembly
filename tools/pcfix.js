const fs = require('fs');
const rom = fs.readFileSync('game.rom');
const f = process.argv[2];
let lines = fs.readFileSync(f, 'latin1').split(/\r?\n/);
let count = 0;
for (let i = 0; i < lines.length; i++) {
  const ln = lines[i];
  const m = /^(\t[^;]*)\t; \$([0-9A-Fa-f]{4,6})$/.exec(ln);
  if (!m) continue;
  const a = parseInt(m[2], 16);
  let ins = m[1].trim();
  const pr = /\(\$([0-9A-F]{1,4}),PC\)|\(\$([0-9A-F]{1,4}),PC,([DA]\d)\.([wl])\)/gi;
  let mm;
  while ((mm = pr.exec(ins))) {
    const d = parseInt(mm[1] || mm[2], 16);
    const target = a + 2 + d;
    if (mm[2]) ins = ins.replace(mm[0], '($' + target.toString(16).toUpperCase() + ',PC,' + mm[3] + '.' + mm[4] + ')');
    else ins = ins.replace(mm[0], '($' + target.toString(16).toUpperCase() + ',PC)');
    count++;
  }
  lines[i] = '\t' + ins + '\t; $' + m[2].toUpperCase();
}
fs.writeFileSync(f, lines.join('\n'));
console.log('fixed ' + count + ' PC-relative operands');
