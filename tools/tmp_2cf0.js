const fs = require('fs');
let lines = fs.readFileSync('src/gameplay/scene_loader.asm', 'latin1').split(/\r?\n/);
const out = [];
let changed = false;
for (const ln of lines) {
  if (/^\tjsr FindFreeEntitySlot\.w/.test(ln) && /;\s*\$2CF4/.test(ln)) {
    out.push('SpawnMonsterAt:');
    changed = true;
  }
  out.push(ln);
}
if (changed) fs.writeFileSync('src/gameplay/scene_loader.asm', out.join('\n'));
console.log('done');
