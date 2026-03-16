'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const args = process.argv.slice(2);

function getArg(flag, fallback) {
  const index = args.indexOf(flag);
  return index !== -1 && args[index + 1] ? args[index + 1] : fallback;
}

const todosPath = path.resolve(repoRoot, getArg('--todos', 'todos.json'));
const schemaPath = path.resolve(repoRoot, getArg('--schema', 'tools/todos.schema.json'));

function loadJson(filePath) {
  if (!fs.existsSync(filePath)) {
    console.error(`ERROR: file not found: ${filePath}`);
    process.exit(1);
  }

  try {
    return JSON.parse(fs.readFileSync(filePath, 'utf8'));
  } catch (error) {
    console.error(`ERROR: JSON parse error in ${filePath}: ${error.message}`);
    process.exit(1);
  }
}

const todos = loadJson(todosPath);
loadJson(schemaPath);

const errors = [];

function addError(location, message) {
  errors.push(`  ${location}: ${message}`);
}

function validateType(value, type, location) {
  if (type === 'object' && (typeof value !== 'object' || value === null || Array.isArray(value))) {
    addError(location, `expected object, got ${typeof value}`);
  }
  if (type === 'array' && !Array.isArray(value)) {
    addError(location, `expected array, got ${typeof value}`);
  }
  if (type === 'string' && typeof value !== 'string') {
    addError(location, `expected string, got ${typeof value}`);
  }
  if (type === 'integer' && !Number.isInteger(value)) {
    addError(location, `expected integer, got ${typeof value}`);
  }
}

function validateTask(task, location) {
  const required = ['id', 'title', 'description', 'priority', 'effort', 'status'];
  for (const field of required) {
    if (!(field in task)) {
      addError(location, `missing required field "${field}"`);
    }
  }

  if (task.id !== undefined) {
    validateType(task.id, 'string', `${location}.id`);
    if (typeof task.id === 'string' && !/^[A-Z]+-[0-9]+$/.test(task.id)) {
      addError(`${location}.id`, `"${task.id}" does not match pattern ^[A-Z]+-[0-9]+$`);
    }
  }

  if (task.title !== undefined) {
    validateType(task.title, 'string', `${location}.title`);
    if (typeof task.title === 'string' && task.title.length < 5) {
      addError(`${location}.title`, 'minLength 5 not met');
    }
  }

  if (task.description !== undefined) {
    validateType(task.description, 'string', `${location}.description`);
    if (typeof task.description === 'string' && task.description.length < 10) {
      addError(`${location}.description`, 'minLength 10 not met');
    }
  }

  const validPriority = ['critical', 'high', 'medium', 'low'];
  if (task.priority !== undefined && !validPriority.includes(task.priority)) {
    addError(`${location}.priority`, `"${task.priority}" not in enum ${JSON.stringify(validPriority)}`);
  }

  const validEffort = ['small', 'medium', 'large', 'very_large'];
  if (task.effort !== undefined && !validEffort.includes(task.effort)) {
    addError(`${location}.effort`, `"${task.effort}" not in enum ${JSON.stringify(validEffort)}`);
  }

  const validStatus = ['todo', 'in_progress', 'done', 'blocked', 'cancelled'];
  if (task.status !== undefined && !validStatus.includes(task.status)) {
    addError(`${location}.status`, `"${task.status}" not in enum ${JSON.stringify(validStatus)}`);
  }
}

if (typeof todos !== 'object' || todos === null || Array.isArray(todos)) {
  addError('todos.json', 'root must be an object');
} else {
  for (const key of ['schema_version', 'task_defaults', 'quality_gates', 'categories']) {
    if (!(key in todos)) {
      addError('todos.json', `missing required top-level key "${key}"`);
    }
  }

  if ('schema_version' in todos) {
    validateType(todos.schema_version, 'integer', 'schema_version');
  }

  if ('categories' in todos) {
    validateType(todos.categories, 'object', 'categories');
  }

  const allIds = new Map();
  if (todos.categories && typeof todos.categories === 'object') {
    for (const [categoryName, category] of Object.entries(todos.categories)) {
      const categoryLocation = `categories.${categoryName}`;

      if (typeof category !== 'object' || category === null || Array.isArray(category)) {
        addError(categoryLocation, 'category must be an object');
        continue;
      }

      if (!('description' in category)) {
        addError(categoryLocation, 'missing required field "description"');
      }
      if (!('tasks' in category)) {
        addError(categoryLocation, 'missing required field "tasks"');
      }

      if (category.tasks !== undefined) {
        if (!Array.isArray(category.tasks)) {
          addError(`${categoryLocation}.tasks`, 'expected array');
        } else {
          category.tasks.forEach((task, index) => {
            const taskLocation = `${categoryLocation}.tasks[${index}]`;
            if (typeof task !== 'object' || task === null || Array.isArray(task)) {
              addError(taskLocation, 'task must be an object');
              return;
            }

            validateTask(task, taskLocation);
            if (task.id) {
              if (allIds.has(task.id)) {
                addError(taskLocation, `duplicate task id "${task.id}" (first seen at ${allIds.get(task.id)})`);
              } else {
                allIds.set(task.id, taskLocation);
              }
            }
          });
        }
      }
    }
  }
}

if (errors.length === 0) {
  const totalTasks = Object.values(todos.categories || {}).reduce((count, category) => {
    return count + (Array.isArray(category.tasks) ? category.tasks.length : 0);
  }, 0);
  console.log(`validate_todos.js: todos.json is valid (${totalTasks} tasks checked)`);
  process.exit(0);
}

console.error(`validate_todos.js: ${errors.length} validation error(s) found in todos.json:`);
for (const error of errors) {
  console.error(error);
}
process.exit(1);
