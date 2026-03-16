'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..', '..');
const outDir = path.join(repoRoot, 'ghidra', 'exports');
const outputPath = path.join(outDir, 'source_sync_bundle.json');

function loadJson(relativePath) {
  return JSON.parse(fs.readFileSync(path.join(repoRoot, relativePath), 'utf8'));
}

fs.mkdirSync(outDir, { recursive: true });

const bundle = {
  generated: new Date().toISOString(),
  symbol_map: loadJson('tools/index/symbol_map.json'),
  function_index: loadJson('tools/index/function_index.json'),
  rom_map: loadJson('tools/index/rom_map.json')
};

fs.writeFileSync(outputPath, JSON.stringify(bundle, null, 2) + '\n', 'utf8');
console.log(`export_source_sync.js: wrote ${path.relative(repoRoot, outputPath)}`);
