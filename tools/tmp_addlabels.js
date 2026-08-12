const fs = require('fs');
const addLabel = {
  'src/gameplay/entity.asm': {
    '1032': 'Atan2Fast', '1042': 'Atan2Fast2', '127A': 'ComputeDistance2', '13BC': 'CheckPlayerState',
  },
  'src/gameplay/actions.asm': {
    '1B50': 'Div16', '1FD0': 'DrawDialogueText',
  },
  'src/gameplay/scene_loader.asm': {
    '225C': 'RenderScreen', '22F0': 'LoadSceneTilesEntry', '23E4': 'CheckItemFlag2',
    '245A': 'CheckItemSprite', '24DC': 'CheckItemType3', '2542': 'ComputeTilemapIndex',
    '266C': 'DrawTile_Setup', '2672': 'DrawTile_Bounded', '26F0': 'ReadTileDataByte',
    '274C': 'CheckMonsterFlag', '2752': 'SetMonsterFlag', '2758': 'GetMonsterFlagAddr2',
    '279C': 'EnterScene', '27E6': 'FindFreeEntitySlot', '2856': 'DrawTileRect3',
    '2AAE': 'DialogueDispatch', '2CF0': 'SpawnMonster', '2F8E': 'MonsterMoveE_Setup',
    '2FD0': 'MonsterMoveE',
  },
  'src/gameplay/movement.asm': {
    '303A': 'MoveHorizontal', '3F54': 'ReadTileAtEntityPos', '3F58': 'ReadTileAtEntityPos2',
    '3FAC': 'ReadTileAtEntityPos3',
  },
};
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
        if (!already) { out.push(map[a] + ':'); changed = true; }
      }
    }
    out.push(ln);
  }
  if (changed) { fs.writeFileSync(file, out.join('\n')); console.log(file); }
}
console.log('labels inserted');
