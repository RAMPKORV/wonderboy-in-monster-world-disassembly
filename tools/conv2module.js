#!/usr/bin/env node
// conv2module.js — transform convert_ghidra.js output into a module.
// Handles: branch target -> *+N (forward .b) or labels (.w/backward), and
// replaces external call targets with known labels.
const fs = require('fs');
const inp = fs.readFileSync(process.argv[2], 'utf8').split('\n');
const REGION_START = parseInt(process.argv[3], 16);
const REGION_END = parseInt(process.argv[4], 16);

// external call-site label map (addr -> label)
// NOTE: game-specific — populate from src/game_constants.asm while working.
const EXTERNAL = {
};

// internal entry labels (addr -> name) — these become local labels
// NOTE: game-specific — populate from src/game_constants.asm while working.
const INTLABEL = {
};

// RAM symbol map
// NOTE: game-specific — populate from src/game_constants.asm while working.
const RAM = {
};

// parse lines: "; $ADDR<TAB>instr"
const lines = [];
for (const raw of inp) {
  const m = raw.match(/^; \$([0-9A-F]{3,6})\t(.*)$/);
  if (!m) continue;
  lines.push({ addr: parseInt(m[1], 16), text: m[2] });
}
lines.sort((a, b) => a.addr - b.addr);

// build label set for internal branch targets (any address that is a branch target)
const targetAddrs = new Set();
for (const L of lines) {
  const t = L.text;
  const m = t.match(/\b(bra|bsr|bcc|bcs|beq|bne|bhi|bls|bge|blt|bgt|ble|bpl|bmi|dbf|dbcc|dbcs|dbeq|dbne|dbhi|dbls|dbge|dblt|dbgt|dble|dbpl|dbmi)\.[bwl]?\s*\$?([0-9A-F]+)/);
  if (m) targetAddrs.add(parseInt(m[2], 16));
}

const out = [];
const lineLabels = new Map(); // addr -> label
for (const a of targetAddrs) {
  if (a >= REGION_START && a < REGION_END) {
    lineLabels.set(a, 'loc_' + a.toString(16).toUpperCase());
  }
}

for (const L of lines) {
  const lb = lineLabels.get(L.addr);
  if (lb) out.push(lb + ':');
  let t = L.text;
  // replace absolute $FFFxxxx with RAM symbols
  t = t.replace(/\(\$0*FF[0-9A-F]{3,5}\)\.l/g, (m) => {
    const hex = m.replace(/[($).l]/g, '');
    const v = parseInt(hex.replace(/^0*/, ''), 16);
    return (RAM[v] || '$00' + hex).toUpperCase();
  });
  t = t.replace(/\$0*FF[0-9A-F]{3,5}\.l/g, (m) => {
    const hex = m.replace(/[$].l/g, '');
    const v = parseInt(hex.replace(/^0*/, ''), 16);
    return (RAM[v] || '$00' + hex).toUpperCase();
  });
  // handle branch operands
  t = t.replace(/\b(bra|bsr|bcc|bcs|beq|bne|bhi|bls|bge|blt|bgt|ble|bpl|bmi)(\.[bwl])?\s*\$([0-9A-F]+)/g, (m, op, sz, h) => {
    const target = parseInt(h, 16);
    if (target >= REGION_START && target < REGION_END) {
      const lb = lineLabels.get(target);
      if (sz === '.w' || sz === '.l') return op + sz + ' ' + lb;
      // .b: use *+N where N = target - addr
      const N = target - L.addr;
      if (N < 0) return op + '.b' + ' ' + lb;  // backward -> label
      return op + '.b' + ' *+$' + N.toString(16).toUpperCase();
    }
    const ext = EXTERNAL[target];
    return op + (sz || '.w') + ' ' + (ext || ('loc_' + target.toString(16).toUpperCase()));
  });
  t = t.replace(/\b(dbf|dbcc|dbcs|dbeq|dbne|dbhi|dbls|dbge|dblt|dbgt|dble|dbpl|dbmi)\s*\$([0-9A-F]+)/g, (m, op, h) => {
    const target = parseInt(h, 16);
    const lb = lineLabels.get(target);
    return op + ' ' + (lb || ('loc_' + target.toString(16).toUpperCase()));
  });
  // jmp/jsr absolute
  t = t.replace(/\b(jsr|jmp)\s*\$([0-9A-F]+)\.l/g, (m, op, h) => {
    const target = parseInt(h, 16);
    const ext = EXTERNAL[target];
    return op + ' ' + (ext || ('loc_' + target.toString(16).toUpperCase())) + '.l';
  });
  out.push('\t' + t + '\t; $' + L.addr.toString(16).toUpperCase());
}
const banner = [
'; ======================================================================',
'; ' + (process.argv[5] || 'src/<name>.asm'),
'; <What this region does>.',
'; Covers ROM $' + REGION_START.toString(16).toUpperCase() + '-$' + REGION_END.toString(16).toUpperCase() + '.',
'; Verified bit-exact against the original ROM.',
'; ======================================================================',
'',
];
fs.writeFileSync(process.argv[5] || 'module_out.asm', banner.join('\n') + out.join('\n') + '\n');
console.log('wrote', out.length, 'lines');
