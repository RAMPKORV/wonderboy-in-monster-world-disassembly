'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..', '..');
const exportDir = path.join(repoRoot, 'ghidra', 'exports');
const indexDir = path.join(repoRoot, 'tools', 'index');

function loadOptionalJson(fileName) {
  const filePath = path.join(exportDir, fileName);
  if (!fs.existsSync(filePath)) {
    return [];
  }
  return JSON.parse(fs.readFileSync(filePath, 'utf8'));
}

function writeJson(fileName, payload) {
  const filePath = path.join(indexDir, fileName);
  fs.writeFileSync(filePath, JSON.stringify(payload, null, 2) + '\n', 'utf8');
  console.log(`import_ghidra_exports.js: wrote ${path.relative(repoRoot, filePath)}`);
}

fs.mkdirSync(indexDir, { recursive: true });

writeJson('ghidra_symbols.json', { generated: new Date().toISOString(), entries: loadOptionalJson('symbols.json') });
writeJson('ghidra_functions.json', { generated: new Date().toISOString(), entries: loadOptionalJson('functions.json') });
writeJson('ghidra_comments.json', { generated: new Date().toISOString(), entries: loadOptionalJson('comments.json') });
writeJson('ghidra_bookmarks.json', { generated: new Date().toISOString(), entries: loadOptionalJson('bookmarks.json') });
