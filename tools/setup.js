#!/usr/bin/env node
// setup.js — initialize a disassembly project from a Sega Genesis ROM.
// Usage: node tools/setup.js <path-to-rom.bin>
//
// 1. Validates the ROM is a Sega Genesis/Mega Drive cartridge.
// 2. Reads + reports the ROM header (system, copyright, titles, serial,
//    checksum, ROM/RAM ranges, region, TMSS flag).
// 3. Generates header_vectors.asm (exception vectors + ROM header bytes),
//    wonderboy.asm (top-level build), and an empty tools/regions.json.
// 4. Runs regen_rest.js so the build is a pure raw-bytes baseline.
// 5. Builds with asm68k and verifies the baseline is bit-perfect.
//
// After setup, the whole ROM is still just dc.b data. The disassembly
// proceeds region-by-region via the pipeline in AGENTS.md.
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const [, , romArg] = process.argv;
if (!romArg) { console.error('Usage: node tools/setup.js <rom.bin>'); process.exit(1); }
const romPath = path.resolve(romArg);
const rom = fs.readFileSync(romPath);

// --- basic validation ---------------------------------------------------
if (rom.length < 0x200) { console.error('ROM too small to be a Genesis cartridge.'); process.exit(1); }
const sys = ascii(rom, 0x100, 16);
if (!/^SEGA/.test(sys)) {
  console.warn('WARNING: header at $100 does not start with "SEGA". ' +
    'This may not be a standard Genesis ROM (or it is encrypted).');
} else {
  console.log('Detected SEGA Genesis / Mega Drive cartridge.');
}

// --- header decode ------------------------------------------------------
function ascii(buf, off, len) {
  let s = '';
  for (let i = 0; i < len; i++) s += String.fromCharCode(buf[off + i] || 0x20);
  return s.replace(/[^\x20-\x7E]/g, '.');
}
const copyright = ascii(rom, 0x110, 16);
const domestic  = ascii(rom, 0x120, 48);
const overseas  = ascii(rom, 0x150, 48);
const serial    = ascii(rom, 0x180, 14);
const checksum  = rom.readUInt16BE(0x18E);
const romStart  = rom.readUInt32BE(0x1A0);
const romEnd    = rom.readUInt32BE(0x1A4);
const ramStart  = rom.readUInt32BE(0x1A8);
const ramEnd    = rom.readUInt32BE(0x1AC);
const region    = ascii(rom, 0x1F0, 3);
const sp        = rom.readUInt32BE(0x000);
const resetVec  = rom.readUInt32BE(0x004);
const tmssOk    = rom.readUInt32BE(0x100) === 0x53454741; // "SEGA"
const sha = sha256(rom);

console.log('\n=== ROM HEADER ===');
console.log('File          :', path.basename(romPath));
console.log('Size          :', rom.length, 'bytes (', (rom.length / 1024).toFixed(0), 'KB )');
console.log('SHA-256       :', sha);
console.log('System        :', sys.trim());
console.log('Copyright     :', copyright.trim());
console.log('Domestic name :', domestic.trim());
console.log('Overseas name :', overseas.trim());
console.log('Serial        :', serial.trim());
console.log('Checksum      : $' + checksum.toString(16).toUpperCase().padStart(4, '0'));
console.log('ROM range     : $' + romStart.toString(16).padStart(8, '0') +
            ' - $' + romEnd.toString(16).padStart(8, '0') + ' (declared ' +
            ((romEnd - romStart + 1) / 1024).toFixed(0) + ' KB)');
console.log('RAM range     : $' + ramStart.toString(16).padStart(8, '0') +
            ' - $' + ramEnd.toString(16).padStart(8, '0'));
console.log('Region        :', region.trim());
console.log('Stack pointer : $' + sp.toString(16).toUpperCase().padStart(8, '0'));
console.log('Reset vector  : $' + resetVec.toString(16).toUpperCase().padStart(8, '0'));
console.log('TMSS "SEGA"   :', tmssOk ? 'present (unlocked VDP)' : 'ABSENT (check for TMSS init code)');
if (![0x20000, 0x40000, 0x60000, 0x80000, 0xC0000, 0x100000, 0x200000, 0x400000].includes(rom.length)) {
  console.warn('NOTE: unusual ROM size for a Genesis cart (usual: 128/256/384/512/768KB, 1/2/4MB).');
}
if (romStart !== 0 || (romEnd !== rom.length - 1)) {
  console.warn('NOTE: declared ROM range does not match file size — verify against bytes.');
}

// --- persist configuration ---------------------------------------------
const cfg = {
  romFile: path.basename(romPath),
  romSize: rom.length,
  sha256: sha,
  system: sys.trim(),
  copyright: copyright.trim(),
  domesticTitle: domestic.trim(),
  overseasTitle: overseas.trim(),
  serial: serial.trim(),
  checksum: '$' + checksum.toString(16).toUpperCase().padStart(4, '0'),
  romStart: '$' + romStart.toString(16).padStart(8, '0'),
  romEnd: '$' + romEnd.toString(16).padStart(8, '0'),
  ramStart: '$' + ramStart.toString(16).padStart(8, '0'),
  ramEnd: '$' + ramEnd.toString(16).padStart(8, '0'),
  region: region.trim(),
  stackPointer: '$' + sp.toString(16).toUpperCase().padStart(8, '0'),
  resetVector: '$' + resetVec.toString(16).toUpperCase().padStart(8, '0'),
  tmss: tmssOk,
};
fs.writeFileSync(path.join(ROOT, 'game.config.json'), JSON.stringify(cfg, null, 2) + '\n');
fs.writeFileSync(path.join(ROOT, 'game.rom.sha256'), sha + '  ' + cfg.romFile + '\n');

// --- copy the ROM into place -------------------------------------------
fs.copyFileSync(romPath, path.join(ROOT, 'game.rom'));

// --- generate header_vectors.asm: bytes $0-$200 ------------------------
let hdr = [];
hdr.push('; ======================================================================');
hdr.push('; header_vectors.asm — AUTO-GENERATED by tools/setup.js');
hdr.push('; 68000 exception vectors ($000-$0FF) + ROM header ($100-$1FF)');
hdr.push('; as raw bytes from the original ROM. Do not hand-edit.');
hdr.push('; ======================================================================');
for (let a = 0; a < 0x200; a += 16) {
  const slice = [];
  for (let i = 0; i < 16 && a + i < 0x200; i++) slice.push('$' + rom[a + i].toString(16).padStart(2, '0'));
  hdr.push('\tdc.b\t' + slice.join(', '));
}
fs.writeFileSync(path.join(ROOT, 'src', 'header_vectors.asm'), hdr.join('\n') + '\n');

// --- top-level wonderboy.asm -------------------------------------------------
const gameAsm = [
'; ======================================================================',
'; wonderboy.asm — top-level build entry.',
'; Includes the raw vectors/header and the auto-generated data_rest.asm',
'; which in turn includes each disassembled region module.',
'; ======================================================================',
'',
'\tinclude "src/header_vectors.asm"',
'\tinclude "src/hw_constants.asm"',
'\tinclude "src/game_constants.asm"',
'\tinclude "data_rest.asm"',
'',
].join('\n');
fs.writeFileSync(path.join(ROOT, 'wonderboy.asm'), gameAsm + '\n');

// --- empty regions manifest --------------------------------------------
fs.writeFileSync(path.join(ROOT, 'tools', 'regions.json'), '[]\n');

// --- generate data_rest.asm (all raw bytes at this point) ---------------
try {
  execSync('node tools/regen_rest.js game.rom', { cwd: ROOT, stdio: ['ignore', 'ignore', 'pipe'] });
  console.log('data_rest.asm       raw-bytes build orchestrator');
} catch (e) {
  console.error('regen_rest.js failed:', String(e.stderr || e).slice(0, 300));
  process.exit(1);
}

console.log('\n=== GENERATED ===');
console.log('wonderboy.asm             top-level build entry');
console.log('game.rom             working copy of the ROM');
console.log('game.config.json     header values (reported above)');
console.log('game.rom.sha256      expected hash for verify.sh');
console.log('src/header_vectors.asm  raw $000-$1FF');
console.log('tools/regions.json   empty region manifest');

// --- baseline build -----------------------------------------------------
console.log('\n=== BASELINE BUILD ===');
try {
  execSync('wine asm68k.exe /k /p /o ae- wonderboy.asm,out.bin,,game.lst',
    { cwd: ROOT, stdio: ['ignore', 'ignore', 'pipe'] });
  const out = fs.readFileSync(path.join(ROOT, 'out.bin'));
  if (out.length === rom.length && out.equals(rom)) {
    console.log('BASELINE BIT-PERFECT: raw-bytes build matches the ROM exactly.');
  } else {
    console.error('BASELINE MISMATCH: out.bin != ROM. Check data_rest.asm generation.');
    process.exit(1);
  }
} catch (e) {
  console.error('asm68k build failed. Is wine + asm68k.exe working?');
  console.error(String(e.stderr || e).slice(0, 500));
  process.exit(1);
}

console.log('\nSetup complete. Next: read AGENTS.md and start disassembling regions.');

function sha256(buf) {
  const crypto = require('crypto');
  return crypto.createHash('sha256').update(buf).digest('hex');
}
