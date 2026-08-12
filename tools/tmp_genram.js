const fs = require('fs');

// Hand-named symbols for addresses we understand (from engine.md RAM map + code tracing).
// Key = literal address string as it appears in code (e.g. 'FFFF8CA4' or '00FF2D00').
const handNamed = {
  'FFFF8006': ['RAM_VBlankFlag', 'VBlank flag (bit 0 set in VBlank)'],
  'FFFF8A48': ['RAM_SchedulerCursor', 'task scheduler cursor / active flag'],
  'FFFF8A49': ['RAM_VBlankTick', 'VBlank frame counter'],
  'FFFF8A4C': ['RAM_CurrentTaskSlot', 'current task slot pointer'],
  'FFFF8A52': ['RAM_RNGState', 'RNG LCG state (seed $2A6D365A)'],
  'FFFF8A7A': ['RAM_InputSelected', 'selected-input mirror (current)'],
  'FFFF8A7B': ['RAM_InputSelectedPrev', 'selected-input mirror (previous)'],
  'FFFF8A7C': ['RAM_InputSelectedNew', 'selected-input mirror (new press)'],
  'FFFF8A7D': ['RAM_InputSelected2', 'second selected-input mirror byte'],
  'FFFF8A7F': ['RAM_P1Pad', 'P1 pad triplet base (current/prev/new)'],
  'FFFF8A82': ['RAM_P2Pad', 'P2 pad triplet base (current/prev/new)'],
  'FFFF8A72': ['RAM_ScrollX', 'scroll offset X (pixels)'],
  'FFFF8A70': ['RAM_ScrollY', 'scroll offset Y (pixels)'],
  'FFFF8A86': ['RAM_ScrollPixelX', 'scroll X pixel counter'],
  'FFFF8A88': ['RAM_ScrollPixelY', 'scroll Y pixel counter'],
  'FFFF8A8A': ['RAM_ScrollPlaneBase', 'scroll plane base nibble'],
  'FFFF8A62': ['RAM_PlaneA_Addr', 'Plane A VRAM address'],
  'FFFF8A66': ['RAM_PlaneB_Addr', 'Plane B VRAM address'],
  'FFFF8A64': ['RAM_SpriteTable_Addr', 'sprite attribute table VRAM address'],
  'FFFF8A68': ['RAM_SpriteDims_Addr', 'sprite dimensions VRAM address'],
  'FFFF8A6A': ['RAM_BgColor_Addr', 'background colour VRAM address'],
  '00FF8B56': ['RAM_PaletteSource', 'palette source (display layout), 128 bytes'],
  '00FF8BD6': ['RAM_PaletteWorking', 'palette working, uploaded to CRAM'],
  'FFFF8B56': ['RAM_PaletteSourceW', 'palette source (.w form)'],
  'FFFF8BD6': ['RAM_PaletteWorkingW', 'palette working (.w form)'],
  'FFFF8C7A': ['RAM_SceneDataPtr', 'current scene data pointer'],
  'FFFF8C9A': ['RAM_CellX', 'current map cell X (screen units)'],
  'FFFF8C9C': ['RAM_CellY', 'current map cell Y (screen units)'],
  'FFFF8C9E': ['RAM_SceneWidth', 'scene width (screen cells)'],
  'FFFF8CA0': ['RAM_SceneHeight', 'scene height (screen cells)'],
  'FFFF8CA2': ['RAM_SceneEventCounter', 'scene event loop counter'],
  'FFFF8CA4': ['RAM_PlayerState', 'player state byte'],
  'FFFF8CA5': ['RAM_PlayerSubState', 'player sub-state byte'],
  'FFFF8CA6': ['RAM_PlayerStateValue', 'player state value'],
  'FFFF8CA8': ['RAM_SceneScriptPtr', 'scene-event script pointer'],
  'FFFF8CAA': ['RAM_TransitionTimer', 'scene transition timer'],
  'FFFF8CAB': ['RAM_TransitionValue', 'scene transition value'],
  'FFFF8CC2': ['RAM_EventFlag', 'scene event flag byte'],
  'FFFF8CC3': ['RAM_EventCounter', 'scene event counter'],
  'FFFF8CDA': ['RAM_PlayerEnterHandler', 'per-scene enter-handler pointer'],
  'FFFF8D92': ['RAM_SceneOriginX', 'scene X origin'],
  'FFFF8D94': ['RAM_SceneOriginY', 'scene Y origin'],
  'FFFF8D9A': ['RAM_ScrollOffsetX', 'current scroll offset X (tiles)'],
  'FFFF8D9C': ['RAM_ScrollOffsetY', 'current scroll offset Y (tiles)'],
  'FFFF8D96': ['RAM_ScreenTilesX', 'screen size X (tiles)'],
  'FFFF8D98': ['RAM_ScreenTilesY', 'screen size Y (tiles)'],
  'FFFF8D9E': ['RAM_RenderMode', 'tilemap render mode'],
  'FFFF8DA0': ['RAM_RenderRows', 'tilemap render rows'],
  'FFFF8DA2': ['RAM_RenderCols', 'tilemap render cols'],
  'FFFF8DA4': ['RAM_RenderRowSkip', 'tilemap render row skip'],
  'FFFF8DA6': ['RAM_RenderColSkip', 'tilemap render col skip'],
  'FFFF9628': ['RAM_HUD_HP', 'HUD HP mirror'],
  'FFFF962A': ['RAM_HUD_Gold', 'HUD gold mirror'],
  'FFFF9758': ['RAM_PlayerX', 'player world X'],
  'FFFF975A': ['RAM_PlayerY', 'player world Y'],
  '00FF2D00': ['RAM_TileStagingBuffer', 'tile decode staging buffer (0x800 bytes)'],
  '00FF1400': ['RAM_ScriptScratch', 'script interpreter scratch (0x400 longs)'],
  'FFC000': ['RAM_EntityFlags', 'entity flag base (64 x 4-byte slots)'],
  '00FFC000': ['RAM_EntityFlagsL', 'entity flag base (.l form)'],
  'FFFFC000': ['RAM_EntityFlagsW', 'entity flag base (.w form)'],
  'FF0C00': ['RAM_ObjectRAM', 'object RAM block base (index * $40)'],
  '00FF0C00': ['RAM_ObjectRAML', 'object RAM block base (.l form)'],
};

function inferType(samples) {
  if (samples.some(s => s.includes('.l'))) return 'long';
  if (samples.some(s => s.includes('.w'))) return 'word';
  return 'word';
}

// Read the address keys + sample forms from the extraction
const lines = fs.readFileSync('/tmp/ramforms.txt', 'latin1').split('\n');
const symbols = [];
const usedNames = new Set();
for (const ln of lines) {
  const [key, samplesStr] = ln.split('\t');
  if (!key) continue;
  const samples = samplesStr.split('|');
  const literal = '$' + key;
  if (handNamed[key]) {
    const [name, desc] = handNamed[key];
    if (!usedNames.has(name)) {
      symbols.push({ key, literal, name, desc, manual: true });
      usedNames.add(name);
    }
  } else {
    const type = inferType(samples);
    const name = 'RAM_' + type + '_' + key;
    if (!usedNames.has(name)) {
      symbols.push({ key, literal, name, desc: '', manual: false });
      usedNames.add(name);
    }
  }
}
symbols.sort((a, b) => a.key.localeCompare(b.key));

// Write ram_addresses.asm
let out = [];
out.push('; ======================================================================');
out.push('; ram_addresses.asm');
out.push('; RAM address definitions for Wonder Boy in Monster World (Genesis)');
out.push('; Work RAM is mapped at $FF0000-$FFFFFF on the 68K bus.');
out.push('; Symbols are auto-named RAM_<type>_<hex>; hand-named ones are traced.');
out.push('; ======================================================================');
out.push('');
let lastBucket = '';
for (const s of symbols) {
  const bucket = s.key.slice(0, 2);
  if (bucket !== lastBucket) {
    out.push('; ============================================================');
    out.push('; $' + bucket + 'xxxx work RAM');
    out.push('; ============================================================');
    lastBucket = bucket;
  }
  const eq = '='.padStart(1);
  const val = s.literal;
  const comment = s.desc ? ' ; ' + s.desc : '';
  out.push(s.name.padEnd(34) + eq + ' ' + val + comment);
}
out.push('');
fs.writeFileSync('ram_addresses.asm', out.join('\n'));
console.log('wrote ram_addresses.asm with', symbols.length, 'symbols');

// Save the symbol map for the replacement step
const map = {};
for (const s of symbols) map[s.literal] = s.name;
fs.writeFileSync('/tmp/ramsymbols.json', JSON.stringify(map));
