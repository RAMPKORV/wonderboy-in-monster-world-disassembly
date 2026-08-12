const fs = require('fs');
// For each target: split the dc.b/dc.w row at the target address and insert a label.
const splits = [
  ['src/scene/sprite_data.asm', 0x7EEE, 'DrawTextLine'],
  ['src/data/main_data.asm', 0x11C9E, 'Subroutine_11C9E'],
  ['src/scene/menu_system.asm', 0x8A3A, 'SetItemState2'],
  ['src/gameplay/entity.asm', 0x1032, 'Atan2Fast0'],
  ['src/gameplay/entity.asm', 0x1042, 'Atan2Fast1'],
];
function splitRow(ln, target, rowStart, nBytes) {
  // ln is a dc.b/dc.w line; split into before/after parts
  const m = /^(\t)(dc\.\w)\t(.+)\t; \$([0-9A-Fa-f]{4,6})$/.exec(ln);
  if (!m) return null;
  const values = m[3].split(',');
  const perByte = m[2] === 'dc.b' ? 1 : 2;
  const off = (target - rowStart) / perByte;
  if (off <= 0 || off >= values.length) return null;
  const size = m[2];
  const fmt = (arr, a) => '\t' + size + '\t' + arr.join(',') + '\t; $' + a.toString(16).toUpperCase();
  return {
    before: fmt(values.slice(0, off), rowStart),
    after: fmt(values.slice(off), target),
  };
}
let total = 0;
for (const [file, target, name] of splits) {
  const lines = fs.readFileSync(file, 'latin1').split(/\r?\n/);
  const out = [];
  let changed = false;
  for (let i = 0; i < lines.length; i++) {
    const ln = lines[i];
    const am = /;\s*\$([0-9A-Fa-f]{4,6})$/.exec(ln);
    if (am && /^\tdc\./.test(ln)) {
      const rowStart = parseInt(am[1], 16);
      const vals = ln.split('\t')[2].split(',').length;
      const perByte = /^\tdc\.b/.test(ln) ? 1 : 2;
      const nBytes = vals * perByte;
      if (target >= rowStart && target < rowStart + nBytes) {
        const split = splitRow(ln, target, rowStart, nBytes);
        if (split) {
          out.push(split.before);
          // check a label isn't already just before
          let p = out.length - 1;
          while (p >= 0 && out[p].trim() === '') p--;
          if (!(p >= 0 && /^[A-Za-z_][A-Za-z0-9_]*:$/.test(out[p].trim()))) {
            out.push(name + ':');
            total++;
          }
          out.push(split.after);
          changed = true;
          continue;
        }
      }
    }
    out.push(ln);
  }
  if (changed) fs.writeFileSync(file, out.join('\n'));
}
console.log('rows split + labels:', total);
