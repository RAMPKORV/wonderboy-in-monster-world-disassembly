; ======================================================================
; src/<name>.asm
; <What this region does>.
; Covers ROM $XXXXXX-$YYYYYY.
; Verified bit-exact against the original ROM.
; ======================================================================

; ======================================================================
; <RoutineName> (loc_XXXXXX)
; <One-line description>.
; ======================================================================
RoutineName:
	; one instruction per line, uppercase mnemonic, lowercase size
	; suffix, trailing "; $ADDR" comment
	move.w	#0, D0					; $XXXX
	rts						; $XXXX
