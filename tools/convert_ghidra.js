#!/usr/bin/env node
// convert_ghidra.js — turns Ghidra's DumpDisasm.txt output into asm68k syntax.
// Filters the dump to [startHex,endHex), applies syntax transforms, and emits
// one instruction per line (addr in a comment). Bit-perfection is NOT assumed:
// run tools/autofix.js afterwards; it rewrites any line that doesn't assemble
// byte-for-byte to dc.w.
//
// CLI: node convert_ghidra.js <dumpFile> <startHex> <endHex>
const fs = require('fs');

let dump, start, end;
if (require.main === module) {
  const [, , dumpArg, sa, ea] = process.argv;
  dump = fs.readFileSync(dumpArg, 'utf8');
  start = parseInt(sa, 16); end = parseInt(ea, 16);
} else {
  ({ dump, start } = module.exports);
}

function u8hex(v) { return v.toString(16).toUpperCase(); }

function convert(addrHex, mnem, op0, op1) {
  let ins = mnem;
  let ops = [];
  if (op0 && op0 !== '<UNSUPPORTED>') ops.push(op0);
  if (op1 && op1 !== '<UNSUPPORTED>') ops.push(op1);
  if (ops.length) ins += ' ' + ops.join(', ');
  return ins;
}

// transform one operand string (and mnemonic) to asm68k
function tx(mnem, op) {
  if (!op || op === '<UNSUPPORTED>') return op;
  let s = op;
  // indexed addressing scale: D0w*0x1 -> D0.w  (scale 1); drop other *0x1
  s = s.replace(/\b([DA])(\d)([bwl])\*0x1\b/g, '$1$2.$3');
  s = s.replace(/\*0x1\b/g, '');
  // register size suffix: D5w -> D5, A2b -> A2, D0w
  s = s.replace(/\b([DA])(\d)([bwl])\b/g, '$1$2');
  // immediate: #0x5a -> #$5A
  s = s.replace(/#0x([0-9A-Fa-f]+)/g, (m, h) => '#' + '$' + u8hex(parseInt(h, 16)));
  // trim trailing scale of index addressing: (0x418,PC,D0w*0x1) -> ($418,PC,D0.w)
  s = s.replace(/(PC|,\s*[DA]\d)\.([bwl])\*0x1/g, '$1.$2');
  s = s.replace(/\.([bwl])\*0x1/g, '.$1');
  // remaining hex values
  s = s.replace(/\b0x([0-9A-Fa-f]+)\b/g, (m, h) => '$' + u8hex(parseInt(h, 16)));
  // branch targets printed as absolute long: '$3D2'
  return s;
}

function run() {
  const lines = dump.split('\n');
  const out = [];
  for (const ln of lines) {
    const t = ln.split('\t');
    if (t.length < 2) continue;
    const a = parseInt(t[0], 16);
    if (!(a >= start && a < end)) continue;
    const mnem = t[1];
    const ops = t.slice(2).map(o => tx(mnem, o));
    // drop <UNSUPPORTED> operands, then join
    let opText = ops.filter(o => o && o !== '<UNSUPPORTED>').join(', ');
    out.push('; $' + a.toString(16).toUpperCase() + '\t' + mnem +
             (opText ? ' ' + opText : ''));
  }
  if (out.length === 0) {
    console.error('convert_ghidra: no instructions in range $' + start.toString(16) +
                  '-$' + end.toString(16) + ' (was this region analyzed by Ghidra?)');
    process.exit(2);
  }
  return out;
}

if (require.main === module) {
  const out = run();
  for (const l of out) console.log(l);
}
module.exports = { run, tx, convert };