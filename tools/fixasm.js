#!/usr/bin/env node
// fixasm.js — post-process converter output into valid asm68k.
// Fixes: moveq/addq/subq immediates, movem register lists, stray braces.
const fs = require('fs');
const f = process.argv[2];
let t = fs.readFileSync(f, 'utf8');

// movem register lists: {A0 D0} -> A0/D0, {D1-D3} keep, remove stray }
t = t.replace(/\{([^}]*)\}/g, (m, inner) => inner.trim().split(/\s+/).join('/'));
t = t.replace(/\)\+, ([A-Z][0-7])\}/g, '$1');

// add '#': moveq / addq / subq immediates
t = t.replace(/\b(moveq|addq|subq)\.([bwl])\s+\$([-0-9A-Fa-f]+)/g, (m, op, sz, imm) =>
  op + '.' + sz + ' #$' + imm);
// moveq has no size suffix
t = t.replace(/\bmoveq\s+\$([-0-9A-Fa-f]+)/g, (m, imm) => 'moveq #$' + imm);
t = t.replace(/\bmoveq\s+(-?\$[0-9A-Fa-f]+)/g, (m, imm) => 'moveq #' + imm);

// remove any leftover leading '#size.' artifacts like "#addq.w"
t = t.replace(/^#(addq|subq|moveq)\.([bwl])\s+/, '$1.$2 ');
t = t.replace(/^\t#(addq|subq|moveq)\.([bwl])\s+/, '\t$1.$2 ');

fs.writeFileSync(f, t);
console.log('fixed');
