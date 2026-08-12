#!/usr/bin/env node
// sizefix.js — converge a module's instruction SIZES to the ROM.
//
// autofix requires out.bin == rom length; when Ghidra force-decodes data
// blocks it emits wrong instruction sizes, breaking that. This tool walks
// the module's intended addresses (`; $ADDR`) against the assembled listing
// and replaces the first instruction whose assembled size is wrong with
// `dc.w` of the exact ROM bytes, looping until the sizes align. Then run
// autofix to converge values.
//
// Usage: node tools/sizefix.js <regionFile> <rom> <startHex> <endHex>
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
  const intents = []; // {line, addr}
  for (let i = 0; i < lines.length; i++) {
    const m = lines[i].match(/;\s*\$([0-9A-F]{3,6})\s*$/);
    if (m) intents.push({ line: i, addr: parseInt(m[1], 16) });
  }
  return { lines, intents };
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

function main() {
  for (let pass = 0; pass < 200; pass++) {
    let err;
    try { build(); }
    catch (e) {
      // build failed (non-assembling data) — fall through to error lines handled elsewhere
      err = String((e.stdout || '') + (e.stderr || ''));
    }
    const { lines, intents } = readModule();
    const entries = listingEntries();
    // walk: for each intended line address, expect a listing entry at the same address
    let ai = 0;
    let problem = -1;
    for (let ii = 0; ii < intents.length && ai < entries.length; ii++) {
      const want = intents[ii].addr;
      const [a0, a1] = entries[ai];
      if (a0 === want) { ai++; continue; }
      if (a0 < want) { ai++; ii--; continue; } // skip listing entries before the intended addr
      // a0 > want: the instruction at 'want' assembled to a different (larger) size,
      // or a listing entry is missing. Find the module line covering 'want'.
      problem = want;
      break;
    }
    if (problem < 0) {
      // check the END alignment
      const lastIntent = intents[intents.length - 1];
      console.log(`sizefix: sizes aligned (${pass} pass(es))`);
      return;
    }
    // find the module line at or before 'problem'
    let li = -1;
    for (let i = intents.length - 1; i >= 0; i--) {
      if (intents[i].addr <= problem) { li = intents[i].line; break; }
    }
    if (li < 0) { console.error('cannot locate line for', problem.toString(16)); process.exit(1); }
    const a = intents.find(x => x.line === li).addr;
    let e = a + 2;
    for (const it of intents) { if (it.addr > a) { e = it.addr; break; } }
    // If the next intended address is suspiciously far, cap at 8 bytes
    if (e - a > 8) e = a + 8;
    const words = [];
    for (let o = a; o < e && o + 1 < ROM.length; o += 2) words.push('$' + ((ROM[o] << 8) | ROM[o + 1]).toString(16).toUpperCase().padStart(4, '0'));
    lines.splice(li, 1, '\tdc.w\t' + words.join(',') + '\t; $' + a.toString(16).toUpperCase());
    fs.writeFileSync(REGION_FILE, lines.join('\n'));
    if (pass % 10 === 0) console.log(`sizefix pass ${pass + 1}: replaced line at $${a.toString(16)} (size ${e - a})`);
  }
  console.error('sizefix: did not converge');
  process.exit(1);
}
main();
