'use strict';

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const repoRoot = path.resolve(__dirname, '..');
const todos = JSON.parse(fs.readFileSync(path.join(repoRoot, 'todos.json'), 'utf8'));
const args = process.argv.slice(2);

function getArg(flag, fallback) {
  const index = args.indexOf(flag);
  return index !== -1 && args[index + 1] ? args[index + 1] : fallback;
}

const ghidraRun = getArg('--ghidra', todos._meta && todos._meta.ghidra_path);
const projectDir = path.resolve(repoRoot, getArg('--project-dir', 'ghidra'));
const projectName = getArg('--project-name', 'wonderboy');
const programName = getArg('--program', 'wonderboy.bin');
const outputDir = path.resolve(repoRoot, getArg('--output-dir', 'ghidra/exports'));

if (!ghidraRun) {
  console.error('ghidra_export.js: missing Ghidra path');
  process.exit(1);
}

const ghidraRoot = path.dirname(ghidraRun);
const analyzeHeadless = path.join(ghidraRoot, 'support', 'analyzeHeadless.bat');
if (!fs.existsSync(analyzeHeadless)) {
  console.error(`ghidra_export.js: analyzeHeadless not found at ${analyzeHeadless}`);
  process.exit(1);
}

fs.mkdirSync(outputDir, { recursive: true });

const commandArgs = [
  analyzeHeadless,
  projectDir,
  projectName,
  '-process',
  programName,
  '-noanalysis',
  '-scriptPath',
  path.join(repoRoot, 'ghidra', 'scripts'),
  '-postScript',
  'ExportWonderboyAnalysis.py',
  outputDir
];

const result = spawnSync('cmd', ['/c', ...commandArgs], {
  cwd: repoRoot,
  stdio: 'inherit',
  shell: false
});

process.exit(result.status || 0);
