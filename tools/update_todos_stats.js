'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const args = process.argv.slice(2);
const flagIndex = args.indexOf('--todos');
const todosPath = path.resolve(repoRoot, flagIndex !== -1 && args[flagIndex + 1] ? args[flagIndex + 1] : 'todos.json');

if (!fs.existsSync(todosPath)) {
  console.error(`ERROR: file not found: ${todosPath}`);
  process.exit(1);
}

let todos;
try {
  todos = JSON.parse(fs.readFileSync(todosPath, 'utf8'));
} catch (error) {
  console.error(`ERROR parsing JSON in ${todosPath}: ${error.message}`);
  process.exit(1);
}

const byStatus = {};
const byPriority = {};
const byCategory = {};
let totalTasks = 0;

for (const [categoryName, category] of Object.entries(todos.categories || {})) {
  const tasks = Array.isArray(category.tasks) ? category.tasks : [];
  byCategory[categoryName] = tasks.length;
  totalTasks += tasks.length;

  for (const task of tasks) {
    byStatus[task.status] = (byStatus[task.status] || 0) + 1;
    byPriority[task.priority] = (byPriority[task.priority] || 0) + 1;
  }
}

todos.statistics = {
  total_tasks: totalTasks,
  by_status: byStatus,
  by_priority: byPriority,
  by_category: byCategory
};

const output = `${JSON.stringify(todos, null, 2)}\n`;
const tempPath = `${todosPath}.tmp`;
fs.writeFileSync(tempPath, output, 'utf8');
fs.renameSync(tempPath, todosPath);

console.log(`update_todos_stats.js: updated statistics in ${path.relative(repoRoot, todosPath)}`);
console.log(`  total tasks  : ${totalTasks}`);
for (const [status, count] of Object.entries(byStatus)) {
  console.log(`  status  ${status.padEnd(12)}: ${count}`);
}
for (const [priority, count] of Object.entries(byPriority)) {
  console.log(`  priority ${priority.padEnd(11)}: ${count}`);
}
