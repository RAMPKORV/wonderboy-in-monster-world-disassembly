; ======================================================================
; src/scroll_vdp.asm
; VDP/scroll register helper cluster: scroll mode bit ops, plane/sprite
; register writers, tilemap-to-VRAM addressing. Covers ROM $0005FE-$0007E8.
; Verified bit-exact against the original ROM.
; ======================================================================

; ======================================================================
; Scroll mode register $FF8A5A bit ops (written straight to VDP).
; SetScrollMode  = set bit 4 (OR  $10)
; ClearScrollMode = clear bit 4 (AND $EF)
; ======================================================================
SetScrollMode:
	moveq	#$10, D0			; $5FE
	or.w	($FFFF8A5A).w, D0		; $600
	bra.b	*+$8				; $604
ClearScrollMode:
	moveq	#-$11, D0			; $606
	and.w	($FFFF8A5A).w, D0		; $608
WriteScrollMode:
	move.w	D0, ($FFFF8A5A).w		; $60C
	move.w	D0, ($C00004).l			; $610
	rts					; $616

; ======================================================================
; Scroll control register $FF8A5C bit ops; each set requests a VDP
; update via bit 1 of $FF8006.
; ======================================================================
ScrollControlSet:
	moveq	#$40, D0			; $618
	or.w	($FFFF8A5C).w, D0		; $61A
	move.w	D0, ($FFFF8A5C).w		; $61E
	ori.b	#$2, ($FFFF8006).w		; $622
	rts					; $628
ScrollControlClear:
	moveq	#-$41, D0			; $62A
	and.w	($FFFF8A5C).w, D0		; $62C
	move.w	D0, ($FFFF8A5C).w		; $630
	ori.b	#$2, ($FFFF8006).w		; $634
	jmp	FrameWait.w			; $63A
SetScrollCtrlBit40:
	moveq	#$40, D0			; $63E
	or.w	($FFFF8A5C).w, D0		; $640
	bra.b	*+$1C				; $644
ClearScrollCtrlBit40:
	moveq	#-$41, D0			; $646
	and.w	($FFFF8A5C).w, D0		; $648
	bra.b	*+$1C				; $64C
SetScrollCtrlBit20:
	moveq	#$20, D0			; $64E
	or.w	($FFFF8A5C).w, D0		; $650
	bra.b	*+$C				; $654
ClearScrollCtrlBit20:
	moveq	#-$21, D0			; $656
	and.w	($FFFF8A5C).w, D0		; $658
	bra.b	*+$C				; $65C
SetScrollCtrlBit10:
	moveq	#$10, D0			; $65E
loc_660:
	or.w	($FFFF8A5C).w, D0		; $660
	bra.b	*+$8				; $664
ClearScrollCtrlBit10:
	moveq	#-$11, D0			; $666
loc_668:
	and.w	($FFFF8A5C).w, D0		; $668
WriteScrollControl:
	move.w	D0, ($FFFF8A5C).w		; $66C
	move.w	D0, ($C00004).l			; $670
	rts					; $676

; ======================================================================
; WriteScrollRegA (loc_000678)
; Writes VDP control word held in RAM $FF8A6C (value byte in D0 -> $FF8A6D).
; ======================================================================
WriteScrollRegA:
	move.b	D0, ($FFFF8A6D).w		; $678
	move.w	($FFFF8A6C).w, ($C00004).l	; $67C
	rts					; $684

; ======================================================================
; Scroll mode register $FF8A5E bit ops.
; ======================================================================
loc_686:
	moveq	#$8, D0				; $686
	bra.b	*+$26				; $688
loc_68A:
	moveq	#-$9, D0			; $68A
	bra.b	*+$E				; $68C
loc_68E:
	move.w	#$FFFB, D0			; $68E
	bra.b	*+$8				; $692
loc_694:
	moveq	#$4, D0				; $694
	bra.b	*+$18				; $696
loc_698:
	moveq	#-$4, D0			; $698
loc_69A:
	and.w	($FFFF8A5E).w, D0		; $69A
	bra.b	*+$14				; $69E
loc_6A0:
	moveq	#-$4, D0			; $6A0
	and.w	($FFFF8A5E).w, D0		; $6A2
	ori.w	#$2, D0				; $6A6
	bra.b	*+$8				; $6AA
loc_6AC:
	moveq	#$3, D0				; $6AC
loc_6AE:
	or.w	($FFFF8A5E).w, D0		; $6AE
WriteScrollMode2:
	move.w	D0, ($FFFF8A5E).w		; $6B2
	move.w	D0, ($C00004).l			; $6B6
	rts					; $6BC

; ======================================================================
; Scroll mode register $FF8A60 bit ops.
; ======================================================================
loc_6BE:
	move.w	($FFFF8A60).w, D0		; $6BE
	andi.b	#$7E, D0			; $6C2
	bra.b	*+$36				; $6C6
loc_6C8:
	move.w	($FFFF8A60).w, D0		; $6C8
	andi.b	#$7E, D0			; $6CC
	ori.b	#$81, D0			; $6D0
	bra.b	*+$28				; $6D4
loc_6D6:
	moveq	#-$7, D0			; $6D6
	bra.b	*+$20				; $6D8
loc_6DA:
	moveq	#-$7, D0			; $6DA
	and.w	D0, ($FFFF8A60).w		; $6DC
	moveq	#$2, D0				; $6E0
	bra.b	*+$E				; $6E2
loc_6E4:
	moveq	#-$7, D0			; $6E4
	and.w	D0, ($FFFF8A60).w		; $6E6
	moveq	#$4, D0				; $6EA
	bra.b	*+$4				; $6EC
loc_6EE:
	moveq	#$8, D0				; $6EE
loc_6F0:
	or.w	($FFFF8A60).w, D0		; $6F0
	bra.b	*+$8				; $6F4
loc_6F6:
	moveq	#-$9, D0			; $6F6
loc_6F8:
	and.w	($FFFF8A60).w, D0		; $6F8
WriteScrollMode3:
	move.w	D0, ($FFFF8A60).w		; $6FC
	move.w	D0, ($C00004).l			; $700
	rts					; $706

; ======================================================================
; WriteScrollRegB (loc_000708)
; Writes VDP control word held in RAM $FF8A6E (value byte in D0 -> $FF8A6F).
; ======================================================================
WriteScrollRegB:
	move.b	D0, ($FFFF8A6F).w		; $708
	move.w	($FFFF8A6E).w, ($C00004).l	; $70C
	rts					; $714

; ======================================================================
; VDP register writers (each mirrors a value in RAM then emits the
; register-set command word to the VDP control port).
; ======================================================================
WritePlaneAAddr:				; reg 2: Plan A base
	move.w	($FFFF8A62).w, D0		; $716
	rol.w	#$6, D0				; $71A
	andi.w	#$38, D0			; $71C
	ori.w	#$8200, D0			; $720
	move.w	D0, ($C00004).l			; $724
	rts					; $72A
WritePlaneBAddr:				; reg 3: Plan B base
	move.w	($FFFF8A66).w, D0		; $72C
	rol.w	#$6, D0				; $730
	andi.w	#$3E, D0			; $732
	btst.b	#$0, ($FFFF8A60).w		; $736
	beq.b	*+$6				; $73C
	andi.w	#$3C, D0			; $73E
loc_742:
	ori.w	#$8300, D0			; $742
	move.w	D0, ($C00004).l			; $746
	rts					; $74C
WriteSpriteTableAddr:				; reg 4: sprite attribute table
	move.w	($FFFF8A64).w, D0		; $74E
	rol.w	#$3, D0				; $752
	andi.w	#$7, D0				; $754
	ori.w	#$8400, D0			; $758
	move.w	D0, ($C00004).l			; $75C
	rts					; $762
WriteSpriteDim:					; reg 5: sprite size
	move.w	($FFFF8A68).w, D0		; $764
	rol.w	#$7, D0				; $768
	andi.w	#$7F, D0			; $76A
	btst.b	#$0, ($FFFF8A60).w		; $76E
	beq.b	*+$6				; $774
	andi.w	#$7E, D0			; $776
loc_77A:
	ori.w	#$8500, D0			; $77A
	move.w	D0, ($C00004).l			; $77E
	rts					; $784
WriteBackgroundColor:				; reg 7: background color
	move.w	($FFFF8A6A).w, D0		; $786
	rol.w	#$6, D0				; $78A
	andi.w	#$3F, D0			; $78C
	ori.w	#$8D00, D0			; $790
	move.w	D0, ($C00004).l			; $794
	rts					; $79A

; ======================================================================
; SetScrollPlane (loc_00079C)
; Converts the scroll pixel offsets (RAM $FF8A72 = X, $FF8A70 = Y) into
; a VRAM address command, using ScrollPlaneBaseTable for the plane base.
; ======================================================================
SetScrollPlane:
	moveq	#$0, D0				; $79C
	lea	($7E0).l, A0			; $79E
	move.w	($FFFF8A72).w, D1		; $7A4
	move.w	D1, D2				; $7A8
	asl.w	#$3, D2				; $7AA
	subq.w	#1, D2				; $7AC
	move.w	D2, ($FFFF8A86).w		; $7AE
	lsr.w	#$6, D1				; $7B2
	move.b	($0,A0,D1.w), D0		; $7B4
	asl.w	#$4, D0				; $7B8
	move.w	($FFFF8A70).w, D1		; $7BA
	move.w	D1, D2				; $7BE
	asl.w	#$3, D2				; $7C0
	subq.w	#1, D2				; $7C2
	move.w	D2, ($FFFF8A88).w		; $7C4
	lsr.w	#$6, D1				; $7C8
	or.b	($0,A0,D1.w), D0		; $7CA
	ori.w	#$9000, D0			; $7CE
	move.w	D0, ($C00004).l			; $7D2
	move.b	($4,A0,D1.w), ($FFFF8A8A).w	; $7D8
	rts					; $7DE

; ======================================================================
; ScrollPlaneBaseTable (loc_0007E0)
; Plane base/size nibbles selected by (scroll offset >> 6).
; ======================================================================
ScrollPlaneBaseTable:
	dc.b	$00,$01,$00,$03			; $7E0
	dc.b	$05,$06,$05,$07			; $7E4
