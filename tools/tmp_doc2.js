const fs = require('fs');
const adds = [
  ['src/gameplay/scene_loader.asm', 'SpawnMonsterAt', [
    '; SpawnMonsterAt: spawns a monster at the current scene script position. Finds',
    '; a free entity slot (FindFreeEntitySlot), initialises it, sets its HP,',
    '; animation id and script state.',
  ]],
  ['src/gameplay/sprites.asm', 'UpdateHelper', [
    '; UpdateHelper: the helper/companion AI driver. Tracks the player (A2), keeps',
    '; within leash range, and applies facing/attack logic when the helper is',
    '; active.',
  ]],
];
for (const [file, label, docLines] of adds) {
  let lines = fs.readFileSync(file, 'latin1').split(/\r?\n/);
  const idx = lines.findIndex(l => l.startsWith(label + ':'));
  if (idx < 0) { console.log('MISSING', label); continue; }
  let prev = idx - 1;
  while (prev >= 0 && lines[prev].trim() === '') prev--;
  if (prev >= 0 && lines[prev].trim().startsWith('; ----')) { console.log('has doc', label); continue; }
  const block = ['; ----------------------------------------------------------------------'].concat(docLines).concat(['; ----------------------------------------------------------------------']);
  lines.splice(idx, 0, ...block);
  fs.writeFileSync(file, lines.join('\n'));
  console.log('doc: ' + label);
}
