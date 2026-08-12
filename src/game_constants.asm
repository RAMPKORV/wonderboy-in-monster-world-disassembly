; ======================================================================
; game_constants.asm
; Game-specific symbolic constants for Wonder Boy in Monster World (Genesis)
; Verified against game.rom (see docs/engine.md for the engine deep-dive).
;
; CONVENTIONS:
;   - RAM addresses:  RAM_*            (defined in ram_addresses.asm)
;   - ROM data addrs: ROM_*            (here)
;   - State values:   STATE_*          (here)
;
; NOTE: shared constants used across modules MUST live here (included
; first), because asm68k resolves EQU symbols at their point of use.
; Routine LABELS may be forward-referenced across modules freely.
; ======================================================================

; ============================================================
; Program state
; ============================================================
; The byte at $00FFF600 is the game state. The main state dispatch
; ($02B2-style) masks it; exact state values are decoded in
; docs/engine.md and the module that owns the dispatcher.
RAM_ProgramState       = RAM_word_00FFF600   ; game state byte
STATE_MASK             = $0000001C   ; state dispatch mask (bits 2-4)

; ============================================================
; Scene / plane system (see docs/engine.md ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ§4)
; ============================================================
; Two global pointers anchor the scene system. They are stored as longs
; at ROM $1CC14 and $1CC18 and dereferenced by ResolveScene (ResolveScene).
ROM_SceneTablePtr      = $00001CC14  ; long: pointer to the scene table
ROM_SceneTypeTablePtr  = $00001CC18  ; long: pointer to the scene type table
ROM_SceneTable         = $0001DD94   ; scene table: [type byte][16-bit offset] per index
ROM_SceneTypeTable     = $0001DD74   ; scene type table: [X-origin][Y-origin][W][H]

; Scene data pointer RAM slot (written by ResolveScene).
RAM_CurrentScene       = $00FF8C7A   ; current scene data pointer

; ============================================================
; ROM data locations (verified bit-exact)
; ============================================================
ROM_FlaggedTable       = $00041000   ; [tag byte][24-bit addr] records; LoadFlaggedData ($6BC4)
ROM_PaletteTable       = $0000599C   ; 252 x 17-byte packed palettes (LoadPalettes/DecodePalette)
ROM_TileBitSpread      = $00006D1C   ; 4 x 16-word nibble->planar lookup tables (tile decoder)
ROM_Z80Driver          = $00098000   ; Z80 sound driver (uploaded to Z80 RAM $A0000)
ROM_TextDict           = $00022026   ; 169 NUL-terminated dialogue dictionary words

; ============================================================
; Flagged-table data-type tags (LoadFlaggedData at $6BC4)
; ============================================================
FLAG_TAG_DIRECT_COPY   = $01          ; direct copy 0x400 bytes (32 planar tiles)
FLAG_TAG_MAP           = $02          ; tree+LZSS 32x32 tilemap ($6D9C)
FLAG_TAG_TILES         = $00          ; compressed tile stream ($6BFC)

; ============================================================
; Palette system
; ============================================================
; RAM_PaletteSource / RAM_PaletteWorking are defined in ram_addresses.asm.
; LoadPalettes/DecodePalette labels are in src/entity.asm ($135C/$1370)
; AdjustPaletteWord label is in src/scene/palette.asm ($594A)

; ============================================================
; Data loaders (scene engine) ÃÂÃÂÃÂÃÂ¢ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ routine labels are in src/scene/scene_load.asm
; ============================================================
; LoadFlaggedData ($6BC4) / DecompressTiles ($6BFC) / DecodeMap ($6D9C)


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
ROM_ProjectileVelDeltaTable = $00002CE0  ; projectile velocity deltas (src/gameplay/scene_loader.asm)
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

; ============================================================
; Text / dialogue encoding
; ============================================================
; Strings use 7-bit ASCII + control codes (0x09 = print, 0x0C = colour/
; face/control). Dictionary words at ROM_TextDict shorten common words.
TEXT_PRINT              = $09        ; print string control code
TEXT_CONTROL            = $0C        ; colour/face/control code
