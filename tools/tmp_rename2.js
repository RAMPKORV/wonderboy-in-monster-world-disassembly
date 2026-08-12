const fs = require('fs');
// delete data label loc_1DFA in actions.asm
{
  let lines = fs.readFileSync('src/actions.asm', 'latin1').split(/\r?\n/);
  const out = lines.filter(l => l.trim() !== 'loc_1DFA:');
  fs.writeFileSync('src/actions.asm', out.join('\n'));
}
// rename loc_E98 in entity.asm
{
  let txt = fs.readFileSync('src/entity.asm', 'latin1');
  txt = txt.split('loc_E98').join('UnlinkCollisionPair_Done');
  fs.writeFileSync('src/entity.asm', txt);
}
console.log('done');
