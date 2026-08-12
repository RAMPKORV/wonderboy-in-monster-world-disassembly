const fs = require('fs');
for (const f of ['src/gameplay/scene_loader.asm']) {
  let t = fs.readFileSync(f, 'latin1');
  t = t.split('DamageStatTable').join('TilemapVramOffsetTable');
  t = t.split('StatDeltaTable').join('ProjectileVelDeltaTable');
  fs.writeFileSync(f, t);
}
console.log('tables renamed');
