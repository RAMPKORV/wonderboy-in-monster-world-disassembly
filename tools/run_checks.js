'use strict';

const { spawnSync } = require('child_process');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const checks = [
  {
    label: 'todos validation',
    command: 'node',
    args: ['tools/validate_todos.js']
  },
  {
    label: 'todos statistics refresh',
    command: 'node',
    args: ['tools/update_todos_stats.js']
  },
  {
    label: 'placeholder label lint',
    command: 'node',
    args: ['tools/lint_placeholder_labels.js']
  },
  {
    label: 'raw I/O address lint',
    command: 'node',
    args: ['tools/lint_raw_io_addresses.js']
  },
  {
    label: 'raw RAM address lint',
    command: 'node',
    args: ['tools/lint_raw_ram_addresses.js']
  },
  {
    label: 'dc decimal lint',
    command: 'node',
    args: ['tools/lint_dc_decimal.js']
  },
  {
    label: 'comment density audit',
    command: 'node',
    args: ['tools/comment_density.js']
  },
  {
    label: 'magic number audit',
    command: 'node',
    args: ['tools/audit_magic_numbers.js']
  },
  {
    label: 'bit-perfect verify',
    command: 'cmd',
    args: ['/c', 'verify.bat']
  },
  {
    label: 'metadata verification',
    command: 'node',
    args: ['tools/verify_metadata.js']
  },
  {
    label: 'rom diff sanity',
    command: 'node',
    args: ['tools/rom_diff.js']
  }
];

for (const check of checks) {
  console.log(`Running ${check.label}...`);
  const result = spawnSync(check.command, check.args, {
    cwd: repoRoot,
    stdio: 'inherit',
    shell: false
  });

  if (result.status !== 0) {
    process.exit(result.status || 1);
  }
}

console.log('run_checks.js: all checks passed');
