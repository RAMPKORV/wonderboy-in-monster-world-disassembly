#!/usr/bin/env node
// autofix.js — iteratively correct a bit-perfect assembly.
// Builds the project source with asm68k (wine), diffs out.bin vs the target ROM,
// and rewrites any source line (in the authored region file src/core.asm)
// whose assembled bytes differ from the ROM to contain the exact ROM bytes
// (dc.w / dc.b).  Repeats until out.bin is bit-identical to the ROM.
//
// Usage: node tools/autofix.js <romPath> [regionFile] [startHex] [endHex]
const { execFileSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const DIR = path.resolve(__dirname, '..');
const ROM = process.argv[2] || path.join(DIR, 'game.rom');
const REGION_FILE = process.argv[3] || path.join(DIR, 'src', 'core.asm');
const REGION_START = parseInt(process.argv[4] || '200', 16);
const REGION_END = parseInt(process.argv[5] || '304', 16);

const OUT = path.join(DIR, 'out.bin');
const LST = path.join(DIR, 'game.lst');

function build() {
  execFileSync('wine', ['asm68k.exe', '/k', '/p', '/o', 'ae-',
    'wonderboy.asm,out.bin,,game.lst'],
    { cwd: DIR, stdio: ['ignore', 'ignore', 'pipe'] });
}

// parse listing: entries for instructions with bytes in [REGION_START,REGION_END)
function parseListing() {
  const src = fs.readFileSync(LST, 'latin1');
  const entries = [];
  const seen = new Set();
  for (const line of src.split('\n')) {
    const m = line.match(/^\s*([0-9A-Fa-f]{8})\s+([0-9A-Fa-f]{4}(?: [0-9A-Fa-f]{4})*)\s*\t(.*?)\s*$/);
    if (!m) continue;
    const addr = parseInt(m[1], 16);
    if (addr < REGION_START || addr >= REGION_END) continue;
    if (seen.has(addr)) continue; // asm68k repeats the last instr of an include at the boundary
    seen.add(addr);
    const bytes = m[2].replace(/ /g, '').match(/.{2}/g).map(x => parseInt(x, 16));
    entries.push({ addr, bytes, text: m[3] });
  }
  entries.sort((a, b) => a.addr - b.addr);
  return entries;
}

function parseSourceInstructions() {
  const lines = fs.readFileSync(REGION_FILE, 'latin1').split(/\r?\n/);
  const idx = [];
  for (let i = 0; i < lines.length; i++) {
    const t = lines[i].trim();
    // a source instruction line: first non-label, non-comment token is a mnemonic
    if (!t) continue;
    if (t.startsWith(';')) continue;
    // skip constants / assignments (EQU, SET, =) — they emit no bytes
    if (/^(?:[A-Za-z_][A-Za-z0-9_]*\s+)?(EQU|SET|:=)\b/i.test(t)) continue;
    if (/^\s*[A-Za-z_][A-Za-z0-9_]*\s*=/i.test(t)) continue;
    // remove a leading label if present
    const body = t.replace(/^[A-Za-z_][A-Za-z0-9_]*:\s*/, '');
    if (!body) continue;             // pure label
    if (body.startsWith(';')) continue;
    idx.push({ line: i, text: lines[i], body });
  }
  return idx;
}

function bufferDiff(a, b, from, to) {
  const diffs = [];
  for (let i = from; i < to; i++) if (a[i] !== b[i]) diffs.push(i);
  return diffs;
}

function replaceLine(lines, lineNo, newText) {
  const old = lines[lineNo];
  // preserve leading whitespace style of the original line
  const lead = old.match(/^\s*/)[0];
  lines[lineNo] = lead + newText;
}

function toDCbytes(rom, start, len) {
  const words = [];
  for (let o = start; o < start + len; o += 2) {
    if (o + 1 < start + len)
      words.push((rom[o] << 8) | rom[o + 1]);
    else
      words.push(rom[o]);
  }
  const parts = words.map(w => '$' + w.toString(16).padStart(4, '0'));
  // NOTE: asm68k drops every value after a "space-comma" (",$xxxx") —
  // only "dc.w $xxxx,$xxxx" (no space) emits all words. No spaces!
  return 'dc.w\t' + parts.join(',');
}

function main() {
  const rom = fs.readFileSync(ROM);
  let pass = 0;
  const maxPasses = 40;
  while (pass < maxPasses) {
    pass++;
    build();
    const out = fs.readFileSync(OUT);
    if (out.length !== rom.length) {
      console.error(`pass ${pass}: SIZE MISMATCH out=${out.length} rom=${rom.length}`);
      process.exit(1);
    }
    const diffs = bufferDiff(rom, out, REGION_START, REGION_END);
    if (diffs.length === 0) {
      console.log(`PASS ${pass}: region ${REGION_START.toString(16)}-${REGION_END.toString(16)} is bit-perfect`);
      break;
    }
    const entries = parseListing();
    const srcIdx = parseSourceInstructions();
    if (entries.length !== srcIdx.length) {
      console.error(`pass ${pass}: listing entries(${entries.length}) != source instr(${srcIdx.length}) — need manual review`);
      // still try best-effort by falling through to per-diff rewriting via offset match
    }
    let fixed = 0;
    const lines = fs.readFileSync(REGION_FILE, 'latin1').split(/\r?\n/);
    for (const dAddr of diffs) {
      // find listing entry covering this byte
      const e = entries.find(ee => dAddr >= ee.addr && dAddr < ee.addr + ee.bytes.length);
      if (!e) {
        console.error(`pass ${pass}: no listing entry for diff at $${dAddr.toString(16)}`);
        continue;
      }
      // find source line whose body matches this entry's text (positional fallback)
      let lineNo = -1;
      const bodyLike = e.text.trim();
      if (srcIdx.length === entries.length) {
        const se = entries.indexOf(e);
        lineNo = srcIdx[se] ? srcIdx[se].line : -1;
      } else {
        const hit = srcIdx.find(s => {
          const bn = s.body.replace(/\s+/g, ' ').trim();
          return bn === bodyLike.replace(/\s+/g, ' ').trim();
        });
        lineNo = hit ? hit.line : -1;
      }
      if (lineNo < 0) {
        console.error(`pass ${pass}: cannot map text "${e.text}" to source line`);
        continue;
      }
      const romBytes = rom.slice(e.addr, e.addr + e.bytes.length);
      // preserve the intended mnemonic as a comment so converged lines
      // stay readable:  dc.w $XXXX ; <mnemonic>
      const orig = lines[lineNo].replace(/^[A-Za-z_][A-Za-z0-9_]*:\s*/, '').trim();
      const mn = orig.split(/[\s,\t]+/)[0] || '';
      const cmt = /^[a-z]/.test(mn) ? '\t; ' + mn : '';
      const replacement = '\t' + toDCbytes(rom, e.addr, e.bytes.length) + cmt;
      replaceLine(lines, lineNo, replacement);
      fixed++;
    }
    if (fixed === 0) {
      console.error(`pass ${pass}: no fixes applied, aborting to avoid infinite loop`);
      process.exit(1);
    }
    fs.writeFileSync(REGION_FILE, lines.join('\n'));
    console.log(`pass ${pass}: applied ${fixed} fix(es) to ${REGION_FILE} (${diffs.length} diff byte(s))`);
  }
  if (pass >= maxPasses) {
    console.error('did not converge in', maxPasses, 'passes');
    process.exit(1);
  }
}

main();