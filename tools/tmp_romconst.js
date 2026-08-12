const fs = require('fs');
let t = fs.readFileSync('src/game_constants.asm', 'latin1');
const block = `
; ============================================================
; ROM lookup tables (labels defined in their owning module)
; ============================================================
ROM_StatThresholdTable    = $00004972   ; per-stat scaling words (src/engine/mainloop.asm)
ROM_DamageTable           = $000049F0   ; damage subtractions (src/engine/mainloop.asm)
ROM_StatGateTable         = $00003872   ; stat gate values (src/gameplay/movement.asm)
ROM_AttackSpeedTable      = $00003FC2   ; per-level attack bytes (src/gameplay/movement.asm)
ROM_GaugeFillTable        = $00003E32   ; gauge fill deltas (src/gameplay/movement.asm)
ROM_AngleDeltaTable       = $00003EB8   ; sine/scroll delta curve (src/gameplay/movement.asm)
ROM_TilemapVramOffsetTable= $000025CA   ; tilemap VRAM offset table (src/gameplay/scene_loader.asm)
ROM_ProjectileVelDeltaTable=$00002CE0   ; projectile velocity deltas (src/gameplay/scene_loader.asm)
ROM_DispatchTable1        = $000015A0   ; scene-event command dispatch 1 (src/gameplay/actions.asm)
ROM_DispatchTable2        = $000015C8   ; scene-event command dispatch 2 (src/gameplay/actions.asm)
ROM_SpriteAnimTable       = $00004092   ; sprite animation frames (src/gameplay/sprites.asm)
ROM_ScrollPlaneBaseTable  = $000007E0   ; plane base/size nibbles (src/engine/scroll_vdp.asm)
ROM_VDPRegTable           = $00004AD0   ; VDP reg -> RAM mirror pairs (src/engine/mainloop.asm)
ROM_VDPPlaneTable         = $00004AF4   ; plane/sprite VRAM addresses (src/engine/mainloop.asm)
ROM_TaskListData          = $00004CC4   ; task descriptor lists (src/engine/subsystem.asm)
ROM_EquipmentInitData     = $00004E5C   ; equipment initial data (src/engine/subsystem.asm)
ROM_ControllerPatchData   = $000051C0   ; controller port patch (src/engine/subsystem.asm)
ROM_QuizTextData          = $00002B38   ; music quiz dialogue (src/gameplay/scene_loader.asm)
ROM_QuizStrings           = $00001D72   ; quiz result strings (src/gameplay/actions.asm)
ROM_FoundGoldStrings      = $00001FE6   ; gold pickup strings (src/gameplay/actions.asm)
ROM_SineTable             = $00000F26   ; sine LUT (src/gameplay/entity.asm)
ROM_SineQuarterTable      = $00000FE2   ; quarter sine table (src/gameplay/entity.asm)
ROM_Atan2Table            = $00001102   ; atan2 lookup table (src/gameplay/entity.asm)
`;
t = t.replace('; ============================================================\n; Text / dialogue encoding', block + '\n; ============================================================\n; Text / dialogue encoding');
fs.writeFileSync('src/game_constants.asm', t);
console.log('ROM table EQU constants added');
