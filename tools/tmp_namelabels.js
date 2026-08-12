const fs = require('fs');
const renames = {
  'loc_2002': 'SetupScene',
  'loc_2050': 'WriteTilemapEntry',
  'loc_2082': 'RenderTilemapPlane',
  'loc_209C': 'RenderTilemapRow',
  'loc_21E8': 'WriteScrollRegs',
  'loc_14F4': 'RunSceneEventScript',
  'loc_16C6': 'AdvanceSceneCellRow',
  'loc_1758': 'RenderFullScene',
  'loc_22C0': 'LoadTileBlock',
  'loc_22FE': 'LoadSceneTiles',
  'loc_276C': 'ResolveScene',
  'loc_27B0': 'InitSceneData',
  'loc_220A': 'ComputeTilemapCoord',
  'loc_13C4': 'ResetPlayerForScene',
  'loc_4B96': 'CleanupObjects',
  'loc_4B72': 'ClearTaskSlots',
  'loc_4B82': 'ClearFirstTaskSlots',
  'loc_4BDC': 'NextTaskSlot',
  'loc_4BC6': 'DispatchImmediateTask',
  'loc_4B58': 'TrapSpin',
};
let total = 0;
for (const f of fs.readdirSync('src').filter(x => x.endsWith('.asm'))) {
  let txt = fs.readFileSync('src/' + f, 'latin1');
  let before = txt;
  for (const [old, next] of Object.entries(renames)) {
    txt = txt.split(old).join(next);
  }
  if (txt !== before) { fs.writeFileSync('src/' + f, txt); total++; console.log(f); }
}
console.log('files touched:', total);
