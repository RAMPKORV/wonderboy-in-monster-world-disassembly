	include "header.asm"
	include "macros.asm"
	include "hw_constants.asm"
	include "ram_addresses.asm"
	include "sound_constants.asm"
	include "game_constants.asm"

; ======================================================================
; wonderboy.asm
; Top-level build order for the rebuildable ROM image
; ======================================================================

	include "src/init.asm"
	include "src/vblank.asm"
	include "src/core.asm"
	include "src/bank020000.asm"
	include "src/bank040000.asm"
	include "src/bank080000.asm"
