const fs = require('fs');
const addLabel = {
  'src/data/main_data.asm': {
    '1090C': 'CheckCollisionPoint', '10910': 'SpawnPickup', '12812': 'SpawnMagicWave',
    '133B2': 'ApplyDamage', '13542': 'ApplyStatusEffect', '1357E': 'ApplyKnockback',
    '1AA3C': 'InitGameState', '1AD62': 'UpdateEquipment', '1C330': 'SceneSpawnCommand',
    '1C494': 'SceneItemCommand', 'DD7C': 'DrawHelperSprite', 'DE6A': 'GameStateHandler',
    'F906': 'ApplyMagicEffect',
  },
  'src/scene/menu_system.asm': {
    '85A8': 'RunSceneScript', '882C': 'ItemEffect', '8A04': 'SetItemState', '8AA2': 'UpdateHUD',
  },
  'src/scene/sprite_data.asm': {
    '76C4': 'SetScenePalette',
  },
  'src/gameplay/sprites.asm': {
    '4356': 'CheckAnimTimer', '43BC': 'CheckCollisionFlag2', '46D6': 'UpdateHelperPos',
    '46DA': 'UpdateHelperPos2', '46F4': 'UpdateHelper', '4778': 'HelperHitCheck',
    '4792': 'HelperAttack', '47AE': 'HelperAttack2', '4814': 'KillEntity',
  },
  'src/engine/mainloop.asm': {
    '4910': 'FindWordInTable',
  },
  'src/engine/subsystem.asm': {
    '4CA8': 'ClearTaskSlot', '4CB8': 'LoadTaskList', '50D4': 'LoadTaskDescriptor', '5262': 'FrameUpdate',
  },
};
let total = 0;
for (const [file, map] of Object.entries(addLabel)) {
  let lines = fs.readFileSync(file, 'latin1').split(/\r?\n/);
  const out = [];
  let changed = false;
  for (const ln of lines) {
    const am = /;\s*\$([0-9A-Fa-f]{4,6})$/.exec(ln);
    if (am) {
      const a = parseInt(am[1], 16).toString(16).toUpperCase();
      if (map[a]) {
        let p = out.length - 1;
        while (p >= 0 && out[p].trim() === '') p--;
        const already = p >= 0 && /^[A-Za-z_][A-Za-z0-9_]*:$/.test(out[p].trim());
        if (!already) { out.push(map[a] + ':'); changed = true; total++; }
      }
    }
    out.push(ln);
  }
  if (changed) fs.writeFileSync(file, out.join('\n'));
}
console.log('labels inserted:', total);
