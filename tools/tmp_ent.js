const fs = require('fs');
// Entity object layout: A4 = entity slot base ($FFC000 for slot 0).
// Offsets are negative A4-relative; absolute address = $FFC000 + offset.
// Named from code tracing (entity.asm header, movement/stats code).
const ENT = {
  '4000': ['ENT_Flags', 'active/flags byte ($FF8000)'],
  '3FFE': ['ENT_Counter', 'counter/flags word ($FF8002)'],
  '3FFD': ['ENT_ScriptFlag', 'script flags ($FF8003)'],
  '3F00': ['ENT_DataPtr', 'data pointer ($FF8100)'],
  '3D00': ['ENT_TreeIdx0', 'script tree index 0 ($FF8300)'],
  '3CFF': ['ENT_TreeIdx1', 'script tree index 1 ($FF8301)'],
  '3CFE': ['ENT_TreeIdx2', 'script tree index 2 ($FF8302)'],
  '3C00': ['ENT_StreamPtr', 'script stream pointer ($FF8400)'],
  '3B00': ['ENT_BasePtr', 'script base pointer ($FF8500)'],
  '3A00': ['ENT_Counter2', 'script counter ($FF8600)'],
  '39FE': ['ENT_Decrement', 'script counter decrement ($FF8602)'],
  '3900': ['ENT_Repeat', 'script repeat count ($FF8700)'],
  '38FF': ['ENT_Countdown', 'script countdown ($FF8701)'],
  '3800': ['ENT_X', 'world X ($FF8800)'],
  '37FE': ['ENT_XSub', 'world X subpixel ($FF8802)'],
  '3700': ['ENT_Y', 'world Y ($FF8900)'],
  '36FE': ['ENT_YSub', 'world Y subpixel ($FF8902)'],
  '3600': ['ENT_VelX', 'velocity X ($FF8A00)'],
  '35FE': ['ENT_VelY', 'velocity Y ($FF8A02)'],
  '35FD': ['ENT_VelYSub', 'velocity Y subpixel ($FF8A03)'],
  '3500': ['ENT_ColW', 'collision width ($FF8B00)'],
  '34FF': ['ENT_ColH', 'collision height ($FF8B01)'],
  '34FE': ['ENT_ColW2', 'collision width 2 ($FF8B02)'],
  '34FD': ['ENT_ColH2', 'collision height 2 ($FF8B03)'],
  '3400': ['ENT_AccelX', 'acceleration X ($FF8C00)'],
  '3300': ['ENT_MaxVelX', 'max velocity X ($FF8D00)'],
  '32FE': ['ENT_MaxVelY', 'max velocity Y ($FF8D02)'],
  '3100': ['ENT_State', 'movement state bits ($FF8F00)'],
  '3000': ['ENT_StateVal', 'movement state value ($FF9000)'],
  '2F00': ['ENT_ColFlags', 'collision flags ($FF9100)'],
  '2E00': ['ENT_PrevX', 'previous X ($FF9200)'],
  '2DFE': ['ENT_PrevY', 'previous Y ($FF9202)'],
  '2D00': ['ENT_Object', 'linked object slot ($FF9300)'],
  '2C00': ['ENT_Step', 'script step counter ($FF9400)'],
  '2BFF': ['ENT_Anim', 'animation id ($FF9401)'],
  '2BFE': ['ENT_HPTimer', 'HP timer ($FF9402)'],
  '2BFD': ['ENT_HP', 'current HP ($FF9403)'],
  '2AFD': ['ENT_PlayerFlags', 'player/entity flags ($FF9503)'],
  '2700': ['ENT_Attack', 'attack value ($FF9900)'],
  '26FE': ['ENT_StatIdx', 'stat index ($FF9902)'],
  '2600': ['ENT_Gold', 'gold ($FF9A00)'],
  '23FE': ['ENT_Damage', 'damage source ($FF9C02)'],
  '2300': ['ENT_Defense', 'defense bits ($FF9D00)'],
  '2100': ['ENT_AttackRange', 'attack range ($FF9F00)'],
};

// Append ENT_* to ram_addresses.asm
let ra = fs.readFileSync('ram_addresses.asm', 'latin1');
ra += '\n; ============================================================\n';
ra += '; Entity object layout (A4 = entity slot base, $FFC000 for slot 0)\n';
ra += '; Offsets are negative A4-relative. Absolute = $FFC000 + offset.\n';
ra += '; ============================================================\n';
for (const [hex, [name, desc]] of Object.entries(ENT)) {
  ra += name.padEnd(28) + '= -$' + hex + ' ; ' + desc + '\n';
}
fs.writeFileSync('ram_addresses.asm', ra);

// Replace (-$HEX,A4) / (-$HEX,A2) literals with (ENT_*,A4)/(ENT_*,A2)
let total = 0;
for (const f of fs.readdirSync('src').filter(x => x.endsWith('.asm'))) {
  const files = f.includes('/') ? ['src/' + f] : (fs.existsSync('src/' + f) ? ['src/' + f] : []);
  for (const path of files) {
    let txt = fs.readFileSync(path, 'latin1');
    let before = txt;
    for (const [hex, [name]] of Object.entries(ENT)) {
      // only replace the operand form (-$HEX,Ax) where Ax is A2 or A4
      const re = new RegExp('\\(-\\$' + hex + ',A([24])\\)', 'g');
      txt = txt.replace(re, '(' + name + ',A$1)');
    }
    if (txt !== before) { fs.writeFileSync(path, txt); total++; }
  }
}
console.log('ENT symbols added; ' + total + ' files touched');
