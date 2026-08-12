const fs = require('fs');
const rom = fs.readFileSync('game.rom');
const S = parseInt(process.argv[2], 16);
const E = parseInt(process.argv[3], 16);
const outFile = process.argv[4];
const dumpFile = process.argv[5] || '/tmp/wbgh2/g17.txt';
const dump = fs.readFileSync(dumpFile, 'utf8');
const BRANCH = /^(bra|bsr|bcc|bcs|bne|beq|bmi|bpl|bvc|bvs|blt|bge|ble|bgt|bls|bhi|bhs|blo)\s*\.?([bw]?)\s+/i;
const entries = [];
for (const ln of dump.split('\n')) {
  const t = ln.split('\t');
  if (t.length < 2) continue;
  const a = parseInt(t[0], 16);
  if (a >= S && a < E) entries.push({ a, line: ln });
}
entries.sort((x, y) => x.a - y.a);
const out = [];
out.push('; ======================================================================');
out.push('; ' + outFile + ' ($' + S.toString(16).toUpperCase() + '-$' + E.toString(16).toUpperCase() + ')');
out.push('; ======================================================================');
for (let i = 0; i < entries.length; i++) {
  const { a, line } = entries[i];
  if (i === 0 && a > S) {
    let off = S;
    while (off < a) {
      const n = Math.min(16, a - off);
      const bytes = [];
      for (let b = 0; b < n; b++) bytes.push('$' + rom[off + b].toString(16).padStart(2, '0'));
      out.push('\tdc.b\t' + bytes.join(',') + '\t; $' + off.toString(16).toUpperCase());
      off += n;
    }
  }
  const t = line.split('\t');
  let mnem = t[1];
  let ops = t.slice(2).map(o => {
    let s = o || '';
    s = s.replace(/\b([DA])(\d)([bwl])\*0x1\b/g, '$1$2.$3');
    s = s.replace(/\*0x1\b/g, '');
    s = s.replace(/\b([DA])(\d)([bwl])\b/g, '$1$2');
    s = s.replace(/#0x([0-9A-Fa-f]+)/g, (m, h) => '#' + '$' + parseInt(h, 16).toString(16).toUpperCase());
    s = s.replace(/\b0x([0-9A-Fa-f]+)\b/g, (m, h) => '$' + parseInt(h, 16).toString(16).toUpperCase());
    s = s.replace(/([DA])(\d)\*\$?([0-9A-Fa-f]+)/g, '$1$2.w*$3');
    s = s.replace(/:\s*\$([0-9A-Fa-f]+)$/, ' $1');
    if (!/^(bra|bsr|jmp|jsr|bcc|bcs|bne|beq|bmi|bpl|bvc|bvs|blt|bge|ble|bgt|bls|bhi|bhs|blo)\b/i.test(mnem)) {
      s = s.replace(/^(\$[0-9A-Fa-f]+)(,\s*[DA]\d)/, '#$1$2');
    }
    return s;
  });
  let ins = mnem;
  const opText = ops.filter(o => o && o !== '<UNSUPPORTED>').join(', ');
  if (opText) ins += ' ' + opText;
  const bm = BRANCH.exec(ins);
  if (bm) {
    const op = bm[1].toLowerCase();
    const sz = bm[2] || 'b';
    const rest = ins.slice(bm[0].length);
    const tm = /^\$([0-9A-Fa-f]{3,6})$/.exec(rest.trim());
    if (tm) {
      const target = parseInt(tm[1], 16);
      const n = target - a;
      const signed = n < 0 ? '-$' + (-n).toString(16).toUpperCase() : '+$' + n.toString(16).toUpperCase();
      ins = op + (Math.abs(n) <= 127 ? '.' + sz : '.w') + ' *' + signed;
    }
  }
  ins = ins.replace(/^(dbf|dbra)\.([bwl])\s+/, '$1 ');
  out.push('\t' + ins + '\t; $' + a.toString(16).toUpperCase());
}
fs.writeFileSync(outFile, out.join('\n') + '\n');
console.log('converted', outFile, entries.length, 'instructions');
