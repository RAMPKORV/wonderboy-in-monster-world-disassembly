const fs = require('fs');
const lines = fs.readFileSync('src/data/main_data.asm', 'latin1').split(/\r?\n/);
// find runs of code (non dc.b/dc.w/dc.l) and data runs
let runs = [];
let cur = null;
for (let i = 0; i < lines.length; i++) {
  const ln = lines[i];
  const am = /;\s*\$([0-9A-Fa-f]{4,6})$/.exec(ln);
  const a = am ? parseInt(am[1], 16) : -1;
  const isCode = /^\t[a-z]/.test(ln) || /^\t([a-z])/.test(ln) || /^[A-Za-z_]/.test(ln);
  const isData = /^\tdc\./.test(ln);
  const kind = isCode ? 'CODE' : (isData ? 'DATA' : 'OTHER');
  if (cur && cur.kind === kind && a > 0 && (a === cur.end || a === cur.end + 2 || cur.end === -1)) {
    cur.end = a + (isCode ? 2 : 16);
    cur.lastLine = i;
  } else {
    if (cur) runs.push(cur);
    cur = { kind, start: a, end: a > 0 ? a + (isCode ? 2 : 16) : -1, startLine: i, lastLine: i };
  }
}
if (cur) runs.push(cur);
// print the CODE runs (the code islands) and long DATA runs
let codeCount = 0;
for (const r of runs) {
  if (r.kind === 'CODE' && r.start > 0) {
    codeCount++;
    console.log('CODE $' + r.start.toString(16) + '-$' + r.end.toString(16) + ' lines ' + r.startLine + '-' + r.lastLine + ' len ' + (r.lastLine - r.startLine));
  }
}
console.log('total CODE islands:', codeCount);
console.log('total runs:', runs.length);
// print DATA runs longer than 100 lines (potential tables)
for (const r of runs) {
  if (r.kind === 'DATA' && r.lastLine - r.startLine > 200 && r.start > 0) {
    console.log('LONG DATA $' + r.start.toString(16) + '-' + r.end.toString(16) + ' lines ' + r.startLine + '-' + r.lastLine);
  }
}
