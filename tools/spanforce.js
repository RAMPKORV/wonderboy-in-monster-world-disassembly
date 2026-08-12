const fs = require('fs');
const cp = require('child_process');
const ROM = fs.readFileSync('game.rom');
const f = process.argv[2];
const S = parseInt(process.argv[3], 16);
const E = parseInt(process.argv[4], 16);
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
function lstRows() {
  const lstLines = fs.readFileSync('game.lst', 'latin1').split('\n');
  const rows = [];
  for (let li = 0; li < lstLines.length; li++) {
    const m = /^([0-9A-F]{8}) [0-9A-F]/.exec(lstLines[li]);
    if (!m) continue;
    const a = parseInt(m[1], 16);
    if (a < S || a >= E) continue;
    if (rows.length && rows[rows.length - 1].a === a) continue;
    rows.push({ a });
  }
  return rows;
}
function srcRows() {
  const lines = fs.readFileSync(f, 'latin1').split(/\r?\n/);
  const rows = [];
  for (let i = 0; i < lines.length; i++) {
    const m = /;\s*\$([0-9A-Fa-f]{4,6})$/.exec(lines[i]);
    if (m) rows.push({ i, a: parseInt(m[1], 16) });
  }
  return { lines, rows };
}
let { lines, rows } = srcRows();
for (let pass = 1; pass <= 60; pass++) {
  const res = build();
  if (!res.ok) { console.log('pass', pass, 'BUILD ERROR, errs=', res.errs.length); for (const e of res.errs.slice(0,5)) console.log('  line', e); break; }
  const out = fs.readFileSync('out.bin');
  const lr = lstRows();
  const lrIdx = new Map();
  for (let k = 0; k < lr.length; k++) lrIdx.set(lr[k].a, k);
  let changed = 0;
  for (let k = rows.length - 1; k >= 0; k--) {
    const r = rows[k];
    const span = (k + 1 < rows.length ? rows[k + 1].a : E) - r.a;
    if (span <= 0 || span > 16384) { console.log('BAD SPAN line', r.i + 1, r.a.toString(16), span); continue; }
    let match = false;
    const ki = lrIdx.get(r.a);
    if (ki !== undefined) {
      const lstA = lr[ki].a;
      const lstLen = (ki + 1 < lr.length ? lr[ki + 1].a : E) - lstA;
      match = lstA === r.a && lstLen === span;
      if (match) for (let b = 0; b < span; b++) if (out[lstA + b] !== ROM[lstA + b]) { match = false; break; }
    }
    if (!match) {
      const newRows = [];
      let off = r.a;
      while (off < r.a + span) {
        const n = Math.min(16, r.a + span - off);
        const bytes = [];
        for (let i = 0; i < n; i++) bytes.push('$' + ROM[off + i].toString(16).padStart(2, '0'));
        newRows.push('\tdc.b\t' + bytes.join(',') + '\t; $' + off.toString(16).toUpperCase());
        off += n;
      }
      lines.splice(r.i, 1, ...newRows);
      changed++;
      if (process.env.DBGSF && changed <= 8) {
        const ki2 = lrIdx.get(r.a);
        console.log('  DBG line', r.i + 1, 'comment=$' + r.a.toString(16), 'span', span, 'lstA', ki2 !== undefined ? lr[ki2].a.toString(16) : 'NONE', 'lstLen', ki2 !== undefined && ki2 + 1 < lr.length ? (lr[ki2+1].a - lr[ki2].a).toString(16) : '?');
      }
    }
  }
  console.log('pass', pass, 'changed', changed, '(rows', rows.length, 'lst', lr.length + ')');
  if (!changed) break;
  fs.writeFileSync(f, lines.join('\n'));
  ({ lines, rows } = srcRows());
}
