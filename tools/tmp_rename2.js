const fs = require('fs');
const renames = {
  'loc_8F4': 'ScriptClearCounter',
  'loc_91A': 'ScriptHandleRepeat',
  'loc_92E': 'ScriptRepeatAdvance',
  'loc_93C': 'ScriptRepeatSet',
  'loc_944': 'ScriptRepeatStore',
  'loc_94C': 'ScriptSetRepeatFlag',
  'loc_950': 'ScriptFinishFrame',
  'loc_978': 'ScriptCmd_MoveX_Add',
  'loc_98A': 'ScriptCmd_MoveY_Add',
  'loc_9C0': 'ScriptCmd_XBound_Adjust',
  'loc_9C4': 'ScriptCmd_XBound_Store',
  'loc_9EA': 'ScriptCmd_YBound_Adjust',
  'loc_9F6': 'ScriptCmd_YBound_Store',
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
