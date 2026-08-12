const fs = require('fs');
function insertDoc(file, label, docLines) {
  let lines = fs.readFileSync(file, 'latin1').split(/\r?\n/);
  const idx = lines.findIndex(l => l.startsWith(label + ':'));
  if (idx < 0) { console.log('MISSING', label); return; }
  // skip if a doc block already precedes (previous non-empty line starts with '; -----')
  let prev = idx - 1;
  while (prev >= 0 && lines[prev].trim() === '') prev--;
  if (lines[prev] && lines[prev].trim().startsWith('; ----')) { console.log('skip (has doc)', label); return; }
  const block = ['; ----------------------------------------------------------------------']
    .concat(docLines)
    .concat(['; ----------------------------------------------------------------------']);
  lines.splice(idx, 0, ...block);
  fs.writeFileSync(file, lines.join('\n'));
  console.log('doc added:', label, '@', file);
}
insertDoc('src/actions.asm', 'RunSceneEventScript', [
  '; RunSceneEventScript: the scene-event bytecode interpreter. Reads commands from',
  '; the stream pointed to by RAM_SceneScriptPtr (A2 via (RAM_SceneScriptPtr)) and',
  '; dispatches through DispatchTable1/DispatchTable2. Runs one step per frame so',
  '; door entries / screen scrolls play across frames. Stores the resume pointer',
  '; back into RAM_SceneScriptPtr.',
]);
insertDoc('src/actions.asm', 'AdvanceSceneCellRow', [
  '; AdvanceSceneCellRow: the player reached the right edge of the current screen',
  '; cell. Clears the cell X counter, increments the cell Y, and re-renders the',
  '; tilemap for the next cell row (wrapping at the scene height).',
]);
insertDoc('src/actions.asm', 'RenderFullScene', [
  '; RenderFullScene: draws the whole 32x32 tilemap to Plane A on scene entry.',
  '; Computes the scene centre from RAM_SceneWidth/RAM_SceneHeight and runs the',
  '; bulk tilemap renderer.',
]);
insertDoc('src/actions.asm', 'SetupScene', [
  '; SetupScene: scene-entry geometry set-up. Resolves the scene (ResolveScene),',
  '; then reads the scene type entry: X origin -> RAM_SceneOriginX, Y origin',
  '; (x2-1) -> RAM_SceneOriginY, width -> RAM_SceneWidth, height ->',
  '; RAM_SceneHeight. Sets RAM_PlayerState = $80 (scene active).',
]);
insertDoc('src/actions.asm', 'WriteTilemapEntry', [
  '; WriteTilemapEntry: writes one tilemap word to Plane A. Computes the Plane A',
  '; VRAM address from (scroll Y + row) << 6 + (scroll X + col), ORs $4000 (Plane A',
  '; base), emits the VDP control word then the tile+attribute word. D0 = tile word,',
  '; D6/D7 = col/row.',
]);
insertDoc('src/actions.asm', 'RenderTilemapPlane', [
  '; RenderTilemapPlane: bulk tilemap renderer. Iterates the visible rows/cols of',
  '; the decoded map buffer (A0) and streams them to Plane A, honouring the',
  '; render-control values RAM_RenderRowSkip/RAM_RenderColSkip.',
]);
insertDoc('src/scene_loader.asm', 'ComputeTilemapCoord', [
  '; ComputeTilemapCoord: converts a screen position (D6/D7) plus camera offset into',
  '; a tilemap index. Uses RAM_SceneOriginX/Y and the screen tile size; returns the',
  '; index in D0.',
]);
insertDoc('src/scene_loader.asm', 'LoadTileBlock', [
  '; LoadTileBlock: loads one 64-tile block from the flagged table into the',
  '; destination buffer. D1 = flag index (masked), A1 = destination. Reads the',
  '; record at ROM_FlaggedTable and copies the tile data.',
]);
insertDoc('src/scene_loader.asm', 'LoadSceneTiles', [
  '; LoadSceneTiles: scene tile upload loop. Walks the scene flag-index list (A0)',
  '; until a negative word, calling LoadFlaggedData for each index into',
  '; RAM_TileStagingBuffer and streaming 64-tile blocks to VRAM. Uses the cache',
  '; field at (A0)+$7E to skip blocks already in VRAM. Loads up to $40 blocks',
  '; (4096 tiles = full VRAM tile area).',
]);
insertDoc('src/scene_loader.asm', 'ResolveScene', [
  '; ResolveScene: resolves a scene index (D0) via the scene table (ROM_SceneTable):',
  '; entry = [type byte][16-bit offset]; scene data pointer = table base + offset',
  '; stored to RAM_SceneDataPtr; A1 = scene type entry (type x4 into',
  '; ROM_SceneTypeTable). The type entry carries X/Y origin + W/H geometry.',
]);
insertDoc('src/scene_loader.asm', 'InitSceneData', [
  '; InitSceneData: initialises the scene data after ResolveScene. Sets the scene',
  '; origin/dimension RAM and (optionally) runs the flagged-loader housekeeping',
  '; ($7F00) before returning.',
]);
