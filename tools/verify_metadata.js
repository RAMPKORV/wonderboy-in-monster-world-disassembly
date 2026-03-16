'use strict';

const crypto = require('crypto');
const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');

function mustRead(filePath) {
  if (!fs.existsSync(filePath)) {
    throw new Error(`missing file: ${path.relative(repoRoot, filePath)}`);
  }
  return fs.readFileSync(filePath);
}

function hashFile(filePath) {
  return crypto.createHash('sha256').update(mustRead(filePath)).digest('hex');
}

function statTime(filePath) {
  return fs.statSync(filePath).mtimeMs;
}

function checkRangeCoverage(ranges, expectedStart, expectedEnd) {
  const ordered = [...ranges].sort((a, b) => Number.parseInt(a.start, 16) - Number.parseInt(b.start, 16));
  let cursor = expectedStart;
  for (const range of ordered) {
    const start = Number.parseInt(range.start, 16);
    const end = Number.parseInt(range.end, 16);
    if (start !== cursor) {
      throw new Error(`rom_map gap or overlap near 0x${cursor.toString(16).padStart(6, '0')}`);
    }
    if (end < start) {
      throw new Error(`rom_map invalid range ${range.start}-${range.end}`);
    }
    cursor = end + 1;
  }
  if (cursor !== expectedEnd + 1) {
    throw new Error(`rom_map terminates at 0x${(cursor - 1).toString(16).padStart(6, '0')} instead of 0x${expectedEnd.toString(16).padStart(6, '0')}`);
  }
}

try {
  const originalPath = path.join(repoRoot, 'original', 'wonderboy.bin');
  const rebuiltPath = path.join(repoRoot, 'out.bin');
  const romMapPath = path.join(repoRoot, 'tools', 'index', 'rom_map.json');
  const functionIndexPath = path.join(repoRoot, 'tools', 'index', 'function_index.json');
  const symbolMapPath = path.join(repoRoot, 'tools', 'index', 'symbol_map.json');
  const todosPath = path.join(repoRoot, 'todos.json');

  const expectedHash = '6b2ac36f624f914ad26e32baa87d1253aea9dcfc13d2a5842ecdd2bd4a7a43b9';
  const originalHash = hashFile(originalPath);
  const rebuiltHash = hashFile(rebuiltPath);
  if (originalHash !== expectedHash) {
    throw new Error(`original ROM hash mismatch: ${originalHash}`);
  }
  if (rebuiltHash !== expectedHash) {
    throw new Error(`rebuilt ROM hash mismatch: ${rebuiltHash}`);
  }

  const original = mustRead(originalPath);
  const rebuilt = mustRead(rebuiltPath);
  if (!original.subarray(0x100, 0x200).equals(rebuilt.subarray(0x100, 0x200))) {
    throw new Error('rebuilt ROM header bytes differ from original baseline');
  }

  const romMap = JSON.parse(fs.readFileSync(romMapPath, 'utf8'));
  checkRangeCoverage(romMap.ranges || [], 0x000000, 0x0BFFFF);

  const functionIndex = JSON.parse(fs.readFileSync(functionIndexPath, 'utf8'));
  for (const entry of functionIndex.entries || []) {
    const address = Number.parseInt(entry.address, 16);
    if (Number.isNaN(address) || address < 0x000000 || address > 0x0BFFFF) {
      throw new Error(`function_index entry out of range: ${entry.name}`);
    }
  }

  const symbolMap = JSON.parse(fs.readFileSync(symbolMapPath, 'utf8'));
  for (const entry of symbolMap.entries || []) {
    const address = Number.parseInt(entry.address, 16);
    if (Number.isNaN(address) || address < 0x000000 || address > 0xFFFFFF) {
      throw new Error(`symbol_map entry out of range: ${entry.name}`);
    }
  }

  const metadataOutputs = [romMapPath, functionIndexPath, symbolMapPath];
  const metadataSources = [
    path.join(repoRoot, 'header.asm'),
    path.join(repoRoot, 'src', 'rom_body.asm'),
    path.join(repoRoot, 'hw_constants.asm'),
    path.join(repoRoot, 'ram_addresses.asm'),
    path.join(repoRoot, 'game_constants.asm'),
    path.join(repoRoot, 'sound_constants.asm')
  ];
  const newestSourceTime = Math.max(...metadataSources.map(statTime));
  for (const output of metadataOutputs) {
    if (statTime(output) + 1 < newestSourceTime) {
      throw new Error(`metadata file is stale: ${path.relative(repoRoot, output)}`);
    }
  }

  console.log('verify_metadata.js: metadata and header checks passed');
  process.exit(0);
} catch (error) {
  console.error(`verify_metadata.js: ${error.message}`);
  process.exit(1);
}
