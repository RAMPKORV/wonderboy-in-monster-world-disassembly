; ======================================================================
; header.asm
; ROM header, exception vectors, and shared constants
; Wonder Boy in Monster World (Genesis, GM G-4060-00)
; Reconstructed bit-perfect from game.rom
; ======================================================================

	include "macros.asm"
	include "src/hw_constants.asm"
	include "ram_addresses.asm"
	include "sound_constants.asm"
	include "src/game_constants.asm"

; ============================================================
; Exception vectors ($000-$1FF) + ROM header
; ============================================================
; AUTO-GENERATED raw bytes by tools/setup.js from the original ROM.
; Contains the 68000 exception vectors and the Sega cartridge header.
; Do not hand-edit.
; ============================================================
	include "src/header_vectors.asm"
