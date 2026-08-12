const fs = require('fs');
const ENT = {
  '4000': 'ENT_Flags', '3FFE': 'ENT_Counter', '3FFD': 'ENT_ScriptFlag', '3F00': 'ENT_DataPtr',
  '3D00': 'ENT_TreeIdx0', '3CFF': 'ENT_TreeIdx1', '3CFE': 'ENT_TreeIdx2', '3C00': 'ENT_StreamPtr',
  '3B00': 'ENT_BasePtr', '3A00': 'ENT_Counter2', '39FE': 'ENT_Decrement', '3900': 'ENT_Repeat',
  '38FF': 'ENT_Countdown', '3800': 'ENT_X', '37FE': 'ENT_XSub', '3700': 'ENT_Y',
  '36FE': 'ENT_YSub', '3600': 'ENT_VelX', '35FE': 'ENT_VelY', '35FD': 'ENT_VelYSub',
  '3500': 'ENT_ColW', '34FF': 'ENT_ColH', '34FE': 'ENT_ColW2', '34FD': 'ENT_ColH2',
  '3400': 'ENT_AccelX', '3300': 'ENT_MaxVelX', '32FE': 'ENT_MaxVelY', '3100': 'ENT_State',
  '3000': 'ENT_StateVal', '2F00': 'ENT_ColFlags', '2E00': 'ENT_PrevX', '2DFE': 'ENT_PrevY',
  '2D00': 'ENT_Object', '2C00': 'ENT_Step', '2BFF': 'ENT_Anim', '2BFE': 'ENT_HPTimer',
  '2BFD': 'ENT_HP', '2AFD': 'ENT_PlayerFlags', '2700': 'ENT_Attack', '26FE': 'ENT_StatIdx',
  '2600': 'ENT_Gold', '23FE': 'ENT_Damage', '2300': 'ENT_Defense', '2100': 'ENT_AttackRange',
};
function walk(dir) {
  const out = [];
  for (const f of fs.readdirSync(dir)) {
    const p = dir + '/' + f;
    if (fs.statSync(p).isDirectory()) out.push(...walk(p));
    else if (f.endsWith('.asm')) out.push(p);
  }
  return out;
}
let total = 0;
for (const path of walk('src')) {
  let txt = fs.readFileSync(path, 'latin1');
  let before = txt;
  for (const [hex, name] of Object.entries(ENT)) {
    const re = new RegExp('\\(-\\$' + hex + ',A([24])\\)', 'g');
    txt = txt.replace(re, '(' + name + ',A$1)');
  }
  if (txt !== before) { fs.writeFileSync(path, txt); total++; console.log(path); }
}
console.log('files touched:', total);
