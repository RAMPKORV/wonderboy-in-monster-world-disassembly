const fs = require('fs');
{
  let t = fs.readFileSync('src/game_constants.asm', 'latin1');
  t = t.replace('src/scene_decompressors.asm', 'src/scene/scene_load.asm');
  fs.writeFileSync('src/game_constants.asm', t);
}
{
  let t = fs.readFileSync('docs/progress.md', 'utf8');
  t = t.split('anim_data.asm CONVERTED').join('sprite_data.asm CONVERTED');
  t = t.split('palette_pre.asm CONVERTED').join('palette.asm CONVERTED');
  t = t.split('flagged_loader_pre.asm CONVERTED').join('scene_load.asm CONVERTED');
  t = t.split('flagged_loader_data.asm CONVERTED').join('scene_load.asm CONVERTED');
  fs.writeFileSync('docs/progress.md', t);
}
console.log('done');
