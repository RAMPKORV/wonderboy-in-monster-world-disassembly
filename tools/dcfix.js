#!/usr/bin/env node
// dcfix.js — replace lines that FAIL to assemble with exact ROM bytes.
// Builds, reads asm68k error line numbers for the region file, maps each
// to its `; $ADDR`, groups contiguous address runs, and rewrites each run
// with the exact ROM bytes. Loops until the build passes.
// Usage: node tools/dcfix.js <regionFile> <rom> <startHex> <endHex>
const { execFileSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const DIR = path.resolve(__dirname, '..');
const REGION_FILE = process.argv[2];
const ROM = fs.readFileSync(process.argv[3]);
const START = parseInt(process.argv[4], 16);
const END = parseInt(process.argv[5], 16);

function build() {
  return execFileSync('wine', ['asm68k.exe', '/k', '/p', '/o', 'ae-',
    'wonderboy.asm,out.bin,,game.lst'],
    { cwd: DIR, stdio: ['ignore', 'pipe', 'pipe'] });
}

function erroredLines() {
  const base = path.basename(REGION_FILE).replace(/\.[^.]+$/, '');
  let err;
  try { build(); return []; }
  catch (e) { err = String((e.stdout || '') + (e.stderr || '')); }
  const re = new RegExp(base.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + '\\.ASM\\((\\d+)\\)\\s*:\\s*Error', 'gi');
  const set = new Set();
  let m;
  while ((m = re.exec(err))) set.add(parseInt(m[1], 10));
  return [...set].sort((a, b) => a - b);
}

function main() {
  for (let pass = 0; pass < 30; pass++) {
    const lines = fs.readFileSync(REGION_FILE, 'latin1').split(/\r?\n/);
    const addrOf = new Map();
    for (let i = 0; i < lines.length; i++) {
      const m = lines[i].match(/;\s*\$([0-9A-F]{3,6})\s*$/);
      if (m) addrOf.set(i, parseInt(m[1], 16));
    }
    const errors = erroredLines();
    if (errors.length === 0) { console.log(`dcfix: build OK (${pass} pass(es))`); return; }
    // map errors to addresses, drop any we can't locate
    const errAddrs = errors.map(ln => ({ ln, a: addrOf.get(ln) })).filter(x => x.a !== undefined);
    // group contiguous addresses (gap <= 2 means same block)
    const blocks = [];
    for (const { ln, a } of errAddrs) {
      const last = blocks[blocks.length - 1];
      if (last && a <= last.e + 4) { last.e = Math.max(last.e, a); last.lines.push(ln); }
      else blocks.push({ s: a, e: a, lines: [ln] });
    }
    let fixed = 0;
    for (const blk of blocks) {
      // extend end: find the next non-error code line's address after the block
      const errSet = new Set(errors);
      let e = blk.e + 2;
      for (let i = 0; i < lines.length; i++) {
        if (errSet.has(i)) continue;
        const a = addrOf.get(i);
        if (a !== undefined && a > blk.e) { e = a; break; }
      }
      const s = blk.s;
      const words = [];
      for (let o = s; o < e && o + 1 < ROM.length; o += 2) words.push('$' + ((ROM[o] << 8) | ROM[o + 1]).toString(16).toUpperCase().padStart(4, '0'));
      // remove the block's lines, insert dc.w
      const minLn = Math.min(...blk.lines);
      const maxLn = Math.max(...blk.lines);
      // also remove any lines in [s,e) range
      let startIdx = minLn, endIdx = maxLn;
      for (let i = minLn; i < lines.length; i++) {
        const a = addrOf.get(i);
        if (a !== undefined && a >= e) { endIdx = i; break; }
      }
      lines.splice(startIdx, endIdx - startIdx, '\tdc.w\t' + words.join(',') + '\t; $' + s.toString(16).toUpperCase());
      fixed++;
    }
    fs.writeFileSync(REGION_FILE, lines.join('\n'));
    console.log(`dcfix pass ${pass + 1}: fixed ${fixed} block(s)`);
  }
  console.error('dcfix: did not converge');
  process.exit(1);
}
main();
