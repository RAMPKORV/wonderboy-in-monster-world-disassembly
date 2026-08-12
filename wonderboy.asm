; ======================================================================
; wonderboy.asm — top-level build entry.
; Includes the raw vectors/header and the auto-generated data_rest.asm
; which in turn includes each disassembled region module.
; ======================================================================

	include "src/header_vectors.asm"
	include "src/hw_constants.asm"
	include "src/game_constants.asm"
	include "data_rest.asm"

