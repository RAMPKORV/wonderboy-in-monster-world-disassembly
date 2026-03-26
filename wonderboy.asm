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

	include "src/bootstrap_init.asm"
	include "src/vblank_tasks.asm"
	include "src/engine_menu_core.asm"
	include "src/text_bank.asm"
	include "src/reference_gfx_bank.asm"
	include "src/z80_offset_bank.asm"
