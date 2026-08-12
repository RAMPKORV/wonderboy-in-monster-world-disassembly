const fs = require('fs');
const f = process.argv[2];
let lines = fs.readFileSync(f, 'latin1').split(/\r?\n/);
let out = [];
let split = 0;
for (const ln of lines) {
  const m = /^(\t)dc\.b\t(.+)\t; \$([0-9A-Fa-f]{4,6})$/.exec(ln);
  if (m && m[2].split(',').length > 16) {
    const a = parseInt(m[3], 16);
    const vals = m[2].split(',');
    let off = a;
    for (let i = 0; i < vals.length; i += 16) {
      const chunk = vals.slice(i, i + 16);
      out.push('\tdc.b\t' + chunk.join(',') + '\t; $' + off.toString(16).toUpperCase());
      off += chunk.length;
    }
    split++;
  } else out.push(ln);
}
fs.writeFileSync(f, out.join('\n'));
console.log('split', split, 'long dc.b rows');
