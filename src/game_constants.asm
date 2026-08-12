; ======================================================================
; game_constants.asm
; Game-specific symbolic constants and RAM addresses.
; Filled in progressively as regions are disassembled.
;
; CONVENTIONS:
;   - RAM addresses:  RAM_<type>_<hex>  e.g. RAM_word_FFFFF600
;   - ROM data addrs: <Name>_<hex>      e.g. SpriteTable_1234
;   - State values:   STATE_0 ... STATE_N
;
; NOTE: shared constants used across modules MUST live here (included
; first), because asm68k resolves EQU symbols at their point of use.
; Routine LABELS may be forward-referenced across modules freely.
; ======================================================================

; ============================================================
; Program state
; ============================================================
RAM_ProgramState       = $00FFF600   ; game state byte (see STATE_* below)

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
RAM_PaletteSource      = $00FF8B56   ; 4 palettes source (display layout), 128 bytes
RAM_PaletteWorking     = $00FF8BD6   ; working palette uploaded to CRAM ($5370)
; LoadPalettes/DecodePalette labels are in src/entity.asm ($135C/$1370)
; AdjustPaletteWord label is in src/palette_driver.asm ($594A)

; ============================================================
; Data loaders (scene engine) — routine labels are in src/scene_decompressors.asm
; ============================================================
; LoadFlaggedData ($6BC4) / DecompressTiles ($6BFC) / DecodeMap ($6D9C)

; ============================================================
; RAM layout (discovered during disassembly)
; ============================================================
; TODO: fill in as addresses are identified. Use the format:
;   RAM_word_FFFFF600    = $00FFF600   ; purpose / owner module
;