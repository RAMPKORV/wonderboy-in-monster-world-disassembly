#!/usr/bin/env node
// fixmovem.js — fix movem register lists: {A0 D0} -> A0/D0, remove stray }
const fs = require('fs');
const f = process.argv[2];
let t = fs.readFileSync(f, 'utf8');
t = t.replace(/\{([^}]*)\}/g, (m, inner) => inner.trim().split(/\s+/).join('/'));
t = t.replace(/\)\+, [A-Z][0-7]\}/g, (m) => m.slice(0, -1));
fs.writeFileSync(f, t);
console.log('fixed');
