const fs = require('fs');
const cp = require('child_process');
const ROM = fs.readFileSync('game.rom');
const f = process.argv[2];
function build() {
  try {
    cp.execFileSync('wine', ['asm68k.exe','/k','/p','/o','ae-','wonderboy.asm,out.bin,,game.lst'], { stdio: ['ignore','pipe','pipe'] });
    return { ok: true, errs: [] };
  } catch (e) {
    const txt = (e.stderr ? e.stderr.toString() : '') + (e.stdout ? e.stdout.toString() : '');
    const errs = [];
    for (const m of txt.matchAll(/ASM\((\d+)\)\s*:\s*Error/gi)) errs.push(parseInt(m[1]));
    return { ok: false, errs };
  }
}
let lines = fs.readFileSync(f, 'latin1').split(/\r?\n/);
const addrs = lines.map(l => { const m = /;\s*\$([0-9A-Fa-f]{4,6})$/.exec(l); return m ? parseInt(m[1], 16) : -1; });
function spanEnd(idx) {
  const a = addrs[idx];
  for (let k = idx + 1; k < addrs.length; k++) if (addrs[k] > a) return addrs[k];
  return a + 2;
}
for (let pass = 1; pass <= 100; pass++) {
  const res = build();
  if (res.ok) { console.log('ALL ERRORS CLEAR at pass', pass); break; }
  let fixed = 0;
  for (const lno of res.errs) {
    const idx = lno - 1;
    if (idx < 0 || idx >= lines.length) continue;
    if (addrs[idx] < 0) continue;
    const a = addrs[idx];
    const end = spanEnd(idx);
    const len = Math.max(2, end - a);
    const bytes = [];
    for (let i = 0; i < len; i++) bytes.push(ROM[a + i]);
    const bytesHex = bytes.map(b => '$' + b.toString(16).padStart(2, '0').toUpperCase()).join(',');
    lines[idx] = '\tdc.b\t' + bytesHex + '\t; $' + a.toString(16).toUpperCase();
    fixed++;
  }
  fs.writeFileSync(f, lines.join('\n'));
  console.log('pass', pass, 'fixed', fixed);
  if (!fixed) break;
}
