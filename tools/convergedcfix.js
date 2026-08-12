#!/usr/bin/env node
// convergedcfix.js — converge a module to the correct SIZES and assemblability.
//
// Handles the two blockers before autofix can run:
//  1. Non-assembling lines (data decoded as garbage) -> dc.w of the ROM bytes.
//  2. Size drift (Ghidra wrong-sized instructions)   -> dc.w of the ROM bytes.
// Loops until out.bin == rom length and the module assembles. Then run autofix
// to converge any remaining value diffs.
//
// Usage: node tools/convergedcfix.js <regionFile> <rom> <startHex> <endHex>
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

function readModule() {
  const lines = fs.readFileSync(REGION_FILE, 'latin1').split(/\r?\n/);
  const addrOf = []; // per line
  for (let i = 0; i < lines.length; i++) {
    const m = lines[i].match(/;\s*\$([0-9A-F]{3,6})\s*$/);
    addrOf.push(m ? parseInt(m[1], 16) : -1);
  }
  return { lines, addrOf };
}

function listingEntries() {
  const lst = fs.readFileSync(path.join(DIR, 'game.lst'), 'latin1');
  const entries = [];
  for (const line of lst.split('\n')) {
    const m = line.match(/^\s*([0-9A-Fa-f]{8})\s+((?:[0-9A-Fa-f]{2,4}\+? ?)+)\s*\t/);
    if (!m) continue;
    const addr = parseInt(m[1], 16);
    if (addr < START || addr >= END) continue;
    const hex = m[2].replace(/\+/g, '').replace(/ /g, '');
    entries.push([addr, addr + hex.length / 2]);
  }
  entries.sort((a, b) => a[0] - b[0]);
  return entries;
}

function replaceRangeAt(lines, addrOf, addr, size) {
  // find the line whose intended addr == addr; replace with dc.w of [addr, addr+size)
  let li = -1;
  for (let i = 0; i < lines.length; i++) {
    if (addrOf[i] === addr) { li = i; break; }
  }
  if (li < 0) return false;
  const words = [];
  for (let o = addr; o < addr + size && o + 1 < ROM.length; o += 2)
    words.push('$' + ((ROM[o] << 8) | ROM[o + 1]).toString(16).toUpperCase().padStart(4, '0'));
  lines[li] = '\tdc.w\t' + words.join(',') + '\t; $' + addr.toString(16).toUpperCase();
  return true;
}

function main() {
  for (let pass = 0; pass < 400; pass++) {
    let err = null;
    try { build(); }
    catch (e) { err = String((e.stdout || '') + (e.stderr || '')); }
    const { lines, addrOf } = readModule();
    const out = fs.existsSync(path.join(DIR, 'out.bin')) ? fs.readFileSync(path.join(DIR, 'out.bin')) : null;

    // Case 1: build failed -> fix error lines
    if (err || !out) {
      const base = path.basename(REGION_FILE).replace(/\.[^.]+$/, '').toUpperCase();
      const re = new RegExp(base.replace(/[^A-Z0-9]/g, '\\$&') + '\\.ASM\\((\\d+)\\)\\s*:\\s*Error', 'gi');
      const errLines = new Set();
      let m;
      while ((m = re.exec(err))) errLines.add(parseInt(m[1], 10));
      if (errLines.size === 0) { console.log(`pass ${pass + 1}: build failed with no parseable errors`); return; }
      let fixed = 0;
      for (const ln of [...errLines]) {
        const a = addrOf[ln - 1];
        if (a === undefined || a < 0) continue;
        let size = 2;
        for (let j = ln; j < addrOf.length; j++) {
          if (addrOf[j] >= 0 && addrOf[j] > a) { size = Math.min(addrOf[j] - a, 8); break; }
        }
        if (replaceRangeAt(lines, addrOf, a, size)) fixed++;
      }
      fs.writeFileSync(REGION_FILE, lines.join('\n'));
      if (pass % 10 === 0) console.log(`pass ${pass + 1}: fixed ${fixed} error lines`);
      continue;
    }

    // Case 2: size drift -> fix first divergent line
    if (out.length !== ROM.length) {
      const entries = listingEntries();
      let ai = 0;
      let problem = -1;
      for (let ii = 0; ii < addrOf.length && ai < entries.length; ii++) {
        const want = addrOf[ii];
        if (want < 0) continue;
        while (ai < entries.length && entries[ai][0] < want) ai++;
        if (ai >= entries.length) break;
        if (entries[ai][0] === want) { ai++; continue; }
        problem = want;
        break;
      }
      if (problem < 0) {
        // all intended addrs present but total size wrong -> likely extra at the end
        problem = addrOf[addrOf.length - 1];
        console.log(`pass ${pass + 1}: size drift at region end (total ${out.length - ROM.length})`);
        // extend the last line's dc.w by the excess
        const li = addrOf.indexOf(problem);
        const words = [];
        for (let o = problem; o < Math.min(problem + 8, ROM.length); o += 2)
          words.push('$' + ((ROM[o] << 8) | ROM[o + 1]).toString(16).toUpperCase().padStart(4, '0'));
        lines[li] = '\tdc.w\t' + words.join(',') + '\t; $' + problem.toString(16).toUpperCase();
        fs.writeFileSync(REGION_FILE, lines.join('\n'));
        continue;
      }
      let li = -1;
      for (let i = addrOf.length - 1; i >= 0; i--) {
        if (addrOf[i] >= 0 && addrOf[i] <= problem) { li = i; break; }
      }
      const a = addrOf[li];
      let size = 2;
      for (let j = li + 1; j < addrOf.length; j++) {
        if (addrOf[j] > a) { size = Math.min(addrOf[j] - a, 8); break; }
      }
      // try progressively larger sizes until out.bin shifts toward rom
      replaceRangeAt(lines, addrOf, a, size);
      fs.writeFileSync(REGION_FILE, lines.join('\n'));
      if (pass % 10 === 0) console.log(`pass ${pass + 1}: fixed size at $${a.toString(16)} (size ${size})`);
      continue;
    }

    console.log(`convergedcfix: done in ${pass + 1} pass(es)`);
    return;
  }
  console.error('convergedcfix: did not converge');
  process.exit(1);
}
main();
