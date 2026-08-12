; ======================================================================
; macros.asm
; Assembly macros for Sega Genesis development (ASM68K syntax)
; ======================================================================

; Wait for vertical blank (polls VDP H/V status)
; Usage: WaitVBlank
WaitVBlank MACRO
	MOVE.W	#$4000, D0
WaitVBlank\@:
	BTST	#7, VDP_control_port			; bit 7 = VBlank flag
	BEQ.S	WaitVBlank\@
	ENDM

; ============================================================
; VDP command helper — write a VDP register
; Usage: VDPWriteReg reg, value
;   reg   = VDP register number (0-25)
;   value = register value (byte)
; ============================================================
VDPWriteReg MACRO
	MOVE.B	\2, VDP_control_port+1
	MOVE.B	\1, VDP_control_port+1
	ENDM
