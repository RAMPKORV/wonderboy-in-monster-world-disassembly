const fs = require('fs');
// Insert routine doc blocks before key entry points.
const docs = [
  ['src/engine/mainloop.asm', 'MainInit', [
    '; MainInit: full engine initialisation after PostBoot. Waits for VDP idle,',
    '; disables interrupts, clears VRAM, uploads the Z80 driver, initialises I/O,',
    '; runs the subsystem inits (InitSubsystems, palette/scene inits), enables',
    '; interrupts, then jumps to MainLoop. Sets the "2-player" flag from the',
    '; port-3 idle line and seeds RAM_VBlankFlag.',
  ]],
  ['src/engine/mainloop.asm', 'SetupVDP', [
    '; SetupVDP: writes the 9 VDP registers from VDPRegTable (mirroring each to its',
    '; RAM shadow), then configures Plane A ($C000), Plane B ($D800), sprite table',
    '; ($E000), sprite size, background colour and initial scroll offsets via the',
    '; register writers in src/engine/scroll_vdp.asm.',
  ]],
  ['src/engine/mainloop.asm', 'MainLoop', [
    '; MainLoop: the per-frame task dispatcher. Walks the 4 immediate task slots at',
    '; $FF8048 (0x80 stride), running each active slot\'s callback (pointer at +$0C),',
    '; then runs object maintenance ($53AA), waits for the VBlank scanline and frame,',
    '; and repeats forever. RAM_SchedulerCursor holds the current slot index.',
  ]],
  ['src/engine/mainloop.asm', 'VBlankHandler', [
    '; VBlankHandler (IRQ6): increments RAM_VBlankTick and sets bit 0 of',
    '; RAM_VBlankFlag. The main loop polls that flag to advance one frame.',
  ]],
  ['src/engine/mainloop.asm', 'CleanupObjects', [
    '; CleanupObjects: scans the 16 round-robin object slots ($FF8248, 0x80 stride);',
    '; slots whose first word is negative (active) have their ID processed via',
    '; ApplyToObjectsWithID ($4A4) and are then cleared.',
  ]],
  ['src/engine/mainloop.asm', 'DrawStatusPanel', [
    '; DrawStatusPanel: refreshes the HUD. Plays sound $1F, computes the HP-bar',
    '; length (ComputeHPBar), and updates the gold/HP mirrors (RAM_HUD_HP/Gold)',
    '; applying the stat threshold scaling and damage table.',
  ]],
  ['src/engine/mainloop.asm', 'WaitForVBlankScanline', [
    '; WaitForVBlankScanline: synchronises to the raster. Waits for VBlank/H-counter',
    '; transitions, polling the VDP status port, so the next Plane A write lands in',
    '; the display period.',
  ]],
  ['src/engine/mainloop.asm', 'RunRoundRobin', [
    '; RunRoundRobin: during VBlank, polls the 16 round-robin object slots, running',
    '; each active slot\'s callback. Clears RAM_VBlankTick before the loop.',
  ]],
  ['src/engine/subsystem.asm', 'InitSubsystems', [
    '; InitSubsystems: called from MainInit. Clears the scroll-mode mirrors, runs the',
    '; four subsystem inits, and enters the scene/plane init chain.',
  ]],
  ['src/engine/subsystem.asm', 'FrameUpdate', [
    '; FrameUpdate: per-frame subsystem driver. Runs the VBlank scroll/plane/window',
    '; writers, refreshes the sprite table, reads both controllers, computes new',
    '; presses, and updates the input latch.',
  ]],
  ['src/engine/subsystem.asm', 'ReadControllerPort', [
    '; ReadControllerPort: reads one controller port via the I/O registers ($A10003/05),',
    '; inverting and packing the pad bits into the per-pad triplet buffer, then',
    '; computes the new-press byte.',
  ]],
  ['src/engine/subsystem.asm', 'ComputeNewPresses', [
    '; ComputeNewPresses: new press = current & ~previous for the selected input',
    '; mirror; stores to RAM_InputSelectedNew.',
  ]],
  ['src/engine/subsystem.asm', 'InstallTaskList', [
    '; InstallTaskList: installs a task-list descriptor (A1) into the immediate task',
    '; array. Runs VBlankTick, copies the descriptor, marks the slot active, and',
    '; resets the stack to the object RAM base.',
  ]],
  ['src/gameplay/entity.asm', 'InitEntity', [
    '; InitEntity: initialises an entity slot (A4). Sets the active flag, clears',
    '; counters/velocity, seeds the frame counter. InitEntityExt additionally zeroes',
    '; the extended object fields.',
  ]],
  ['src/gameplay/entity.asm', 'CalcAngleToTarget', [
    '; CalcAngleToTarget: atan2. Computes the 16-bit angle from entity A4 to entity',
    '; A2 using the atan2 LUT (ROM_Atan2Table). Returns the angle in D3 (bits 0-15).',
    '; Used by homing projectiles and AI facing.',
  ]],
  ['src/gameplay/entity.asm', 'AngleToVector', [
    '; AngleToVector: converts an angle (D3) and magnitude (D4) into velocity',
    '; components D0 (X) and D5 (Y) via the sine tables.',
  ]],
  ['src/gameplay/entity.asm', 'CheckBoxOverlap', [
    '; CheckBoxOverlap: AABB overlap test between two hitboxes (A0, A1). Returns',
    '; carry clear when they overlap; used for attack/hurt-box and pickup checks.',
  ]],
  ['src/gameplay/entity.asm', 'LoadPalettes', [
    '; LoadPalettes: reads 4 palette index bytes from A0 and decodes each via',
    '; DecodePalette into RAM_PaletteSource (the display-layout buffer).',
  ]],
  ['src/gameplay/entity.asm', 'DecodePalette', [
    '; DecodePalette: unpacks one 17-byte packed palette (ROM_PaletteTable + idx*17)',
    '; into 16 RGB555 colour words at (A1)+.',
  ]],
  ['src/gameplay/movement.asm', 'ReadTile', [
    '; ReadTile: reads the collision byte at the tile containing (D6, D7). Computes',
    '; the tile index via ComputeTilemapIndex, looks up the tile data byte, and',
    '; expands it through GetTileBehavior. Returns the behaviour bits in D2.',
  ]],
  ['src/gameplay/movement.asm', 'GetTileBehavior', [
    '; GetTileBehavior: expands a tile data byte (D1) into collision-behaviour bits',
    '; in D2 (solid/water/spike/... flags) using the tile-block table at $3FC2.',
  ]],
  ['src/gameplay/movement.asm', 'MoveHorizontal', [
    '; MoveHorizontal: applies the horizontal movement state. Integrates velocity',
    '; into X, zeroes the subpixel accumulator, and stores the result velocity.',
  ]],
  ['src/gameplay/movement.asm', 'MoveVertical', [
    '; MoveVertical: applies the vertical movement state (gravity/impulse), calls the',
    '; vertical collision pass, and applies the result velocity.',
  ]],
  ['src/gameplay/movement.asm', 'CollideAndSlide', [
    '; CollideAndSlide: the main tile-collision resolver. Sweeps the entity\'s',
    '; bounding box over the tile grid, resolving hits by sliding along walls,',
    '; floors and ceilings and setting the movement state bits (ENT_State).',
  ]],
  ['src/gameplay/movement.asm', 'CheckEntityProximity', [
    '; CheckEntityProximity: tests whether another entity (A2) is within the',
    '; extended hitbox of this entity (A4). Used for contact damage and triggers.',
  ]],
  ['src/gameplay/actions.asm', 'RunSceneEventScript', [
    '; RunSceneEventScript: the scene-event bytecode interpreter. Reads commands from',
    '; the stream pointed to by RAM_SceneScriptPtr, dispatching through',
    '; ROM_DispatchTable1/2. Runs one step per frame so door entries and screen',
    '; scrolls play across frames.',
  ]],
  ['src/gameplay/actions.asm', 'SetupScene', [
    '; SetupScene: scene-entry geometry set-up. Resolves the scene (ResolveScene),',
    '; then reads the scene type entry: X origin, Y origin (x2-1), width and height',
    '; into the scroll/geometry RAM, and sets RAM_PlayerState = $80 (scene active).',
  ]],
  ['src/gameplay/actions.asm', 'RenderTilemapPlane', [
    '; RenderTilemapPlane: bulk tilemap renderer. Streams the visible rows/cols of the',
    '; decoded map buffer to Plane A, honouring the render-control values.',
  ]],
  ['src/gameplay/actions.asm', 'UpdateScrollRegs', [
    '; UpdateScrollRegs: recomputes the scroll offset from the player position plus',
    '; the scene origin, writes the VDP H/V scroll registers, and marks off-screen',
    '; entities for culling.',
  ]],
  ['src/gameplay/actions.asm', 'RunSceneEventScript', [
    '; RunSceneEventScript: scene-event bytecode interpreter (see above).',
  ]],
  ['src/gameplay/scene_loader.asm', 'ResolveScene', [
    '; ResolveScene: resolves a scene index (D0) via the scene table (ROM_SceneTable):',
    '; entry = [type byte][16-bit offset]. Stores the scene data pointer in',
    '; RAM_SceneDataPtr and returns the scene type entry (origin/geometry) in A1.',
  ]],
  ['src/gameplay/scene_loader.asm', 'EnterScene', [
    '; EnterScene: full scene entry. Resolves the scene, plays the scene-change',
    '; sound, initialises the scene data, and marks the player scene-active.',
  ]],
  ['src/gameplay/scene_loader.asm', 'LoadSceneTiles', [
    '; LoadSceneTiles: uploads a scene\'s tiles to VRAM. Walks the scene flag-index',
    '; list (A0), calling LoadFlaggedData for each into RAM_TileStagingBuffer and',
    '; streaming 64-tile blocks to VRAM. Caches loaded blocks (at list +$7E).',
  ]],
  ['src/gameplay/scene_loader.asm', 'DrawTile', [
    '; DrawTile: draws one tile at screen offset (D6, D7) into the map render',
    '; buffer, applying bounds checks against the scene geometry and the tile',
    '; behaviour attributes.',
  ]],
  ['src/gameplay/scene_loader.asm', 'SpawnMonster', [
    '; SpawnMonster: spawns a monster at the entity position using the current',
    '; scene script state. Sets the monster\'s HP, animation id, and script pointer.',
  ]],
  ['src/gameplay/scene_loader.asm', 'MonsterRage', [
    '; MonsterRage: the per-monster encounter/movement stream driver. Reads commands',
    '; from the monster\'s stream (RAM $FFFF9BBA): movement deltas, hit tests against',
    '; the player, and knockback.',
  ]],
  ['src/gameplay/scene_loader.asm', 'CheckItemCount', [
    '; CheckItemCount: tests whether the player has at least N of item D0. Returns',
    '; carry set when the requirement is met.',
  ]],
  ['src/gameplay/sprites.asm', 'KillEntity', [
    '; KillEntity: removes an entity. Returns its kill-drop table (ENT_Object),',
    '; clears the monster-kill flag, and can spawn a reward/drop item at the entity',
    '; position based on the drop table.',
  ]],
  ['src/gameplay/sprites.asm', 'CheckHitPlayer', [
    '; CheckHitPlayer: collision test between this entity and the player. On a hit,',
    '; applies contact damage and knockback to the player and flags the collision.',
  ]],
  ['src/gameplay/sprites.asm', 'HelperUpdate', [
    '; HelperUpdate: the helper/companion AI driver. Tracks the player (A2), keeps',
    '; within leash range, and applies facing/attack logic when the helper is',
    '; active.',
  ]],
  ['src/scene/scene_load.asm', 'LoadFlaggedData', [
    '; LoadFlaggedData: resolves flag index D0 in the flagged table (ROM_FlaggedTable,',
    '; 4-byte [tag][addr24] records) and loads the data into (A1): bit 18 = direct',
    '; 0x200-long copy, bit 19 = tile-stream decompress, else map decode.',
  ]],
  ['src/scene/scene_load.asm', 'DecodeMap', [
    '; DecodeMap: tree+LZSS decompresses a 32x32 tilemap (tag-$02 record) into the',
    '; destination buffer. Map values are tile-block indices.',
  ]],
  ['src/scene/scene_load.asm', 'DecompressTiles', [
    '; DecompressTiles: decompresses a tag-$00 4bpp tile stream (RLE/planar) into',
    '; 32-byte tile rows.',
  ]],
];

function insertDoc(file, label, docLines) {
  if (!fs.existsSync(file)) { console.log('MISSING FILE', file); return; }
  let lines = fs.readFileSync(file, 'latin1').split(/\r?\n/);
  const idx = lines.findIndex(l => l.startsWith(label + ':'));
  if (idx < 0) { console.log('MISSING LABEL', file, label); return; }
  let prev = idx - 1;
  while (prev >= 0 && lines[prev].trim() === '') prev--;
  if (prev >= 0 && lines[prev].trim().startsWith('; ----')) { console.log('has doc', label); return; }
  const block = ['; ----------------------------------------------------------------------']
    .concat(docLines)
    .concat(['; ----------------------------------------------------------------------']);
  lines.splice(idx, 0, ...block);
  fs.writeFileSync(file, lines.join('\n'));
  console.log('doc: ' + label + ' (' + file + ')');
}
for (const [f, l, d] of docs) insertDoc(f, l, d);
console.log('done');
