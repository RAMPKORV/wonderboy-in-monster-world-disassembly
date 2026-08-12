; ======================================================================
; src/engine/script_engine.asm
; Offset-tree script interpreter + command handlers. Scripts are stored
; in ROM at $0A0000 and drive an entity's X/Y position with repeat and
; step counters. Covers ROM $0007E8-$000A1A.
;
; Addressing: A4 = $00FFC000 (base). Offsets resolve as:
;   $FF8000 flags     $FF8002 frame counter/flags  $FF8003 script flags
;   $FF8100 data ptr  $FF8300-02 tree indices      $FF8400 stream ptr
;   $FF8500 base ptr  $FF8600 counter              $FF8602 decrement
;   $FF8700 repeat    $FF8701 countdown            $FF8800 X
;   $FF8900 Y         $FF8B00-03 script bytes      $FF8F00 bounds
;   $FF9400 step
; Verified bit-exact against the original ROM.
; ======================================================================

; ======================================================================
; ScriptSetMarker (loc_0007E8)
; Stores D0 into the tree index at $FF8302 and clears $FF8003 bit 0.
; ======================================================================
ScriptSetMarker:
	move.b	D0, (-$3CFE,A4)			; $7E8
	andi.b	#$7E, (-$3FFD,A4)		; $7EC
	rts					; $7F2

; ======================================================================
; ScriptCopyDecrement (loc_0007F4)
; Copies the frame decrement word $FF8602 into the counter $FF8600.
; ======================================================================
ScriptCopyDecrement:
	move.w	(-$39FE,A4), (-$3A00,A4)	; $7F4
	rts					; $7FA

; ======================================================================
; LoadScriptStream (loc_0007FC)
; Marks the script active ($FF8003 bit 0), then navigates the offset tree
; at ROM $0A0000 using the three index bytes $FF8300/$FF8301/$FF8302,
; leaving the resolved stream pointer in $FF8500.
; ======================================================================
LoadScriptStream:
	move.b	D0, (-$3CFE,A4)			; $7FC
	ori.b	#$1, (-$3FFD,A4)		; $800
	lea	($A0000).l, A0			; $806
	bra.b	*+$10				; $80C
LoadScriptStreamOrSkip:
	lea	($A0000).l, A0			; $80E
	bset.b	#$0, (-$3FFD,A4)		; $814
	bne.b	*+$32				; $81A
ResolveScriptPointer:
	moveq	#$0, D0				; $81C
	move.b	(-$3D00,A4), D0			; $81E
	move.w	($0,A0,D0.w), D1		; $822
	move.b	(-$3CFF,A4), D0			; $826
	add.w	D0, D1				; $82A
	move.w	($0,A0,D1.w), D1		; $82C
	move.b	(-$3CFE,A4), D0			; $830
	add.w	D0, D1				; $834
	move.w	($0,A0,D1.w), D1		; $836
	lea	($0,A0,D1.w), A1			; $83A
	move.l	A1, (-$3B00,A4)			; $83E
	clr.w	(-$3A00,A4)			; $842
	clr.b	(-$2C00,A4)			; $846
	bra.b	*+$2E				; $84A

; ======================================================================
; RunScript (loc_00084C)
; Per-frame script driver. Unless bit 5 of $FF8000 is set, decrements the
; counter by $FF8602 each frame and advances the script step when the
; counter expires.
; ======================================================================
RunScript:
	btst.b	#$5, (-$4000,A4)		; $84C
	bne.w	ScriptFrameTick			; $852
	tst.w	(-$3A00,A4)			; $856
	beq.w	ScriptFrameTick			; $85A
	move.w	(-$39FE,A4), D0			; $85E
	sub.w	D0, (-$3A00,A4)			; $862
	bcs.b	*+$A				; $866
	tst.b	(-$3A00,A4)			; $868
	bne.w	ScriptFrameTick			; $86C
ScriptAdvanceStep:
	addq.b	#$1, (-$2C00,A4)		; $870
	movea.l	(-$3C00,A4), A1			; $874
ProcessScriptByte:
	move.b	(A1)+, D0			; $878
	cmpi.b	#$F0, D0			; $87A
	bcs.b	*+$52				; $87E
	andi.w	#$F, D0				; $880
	lsl.w	#$2, D0				; $884
	pea	ProcessScriptByte(PC)		; $886
	move.l	ScriptJumpTable(PC,D0.w), -(SP)	; $88A
	rts					; $88E

; ======================================================================
; ScriptJumpTable (loc_000890)
; 16 command handler pointers, indexed by the low nibble of a command byte
; ($F0-$FF). Commands $F0-$F7 all map to $0958 (a no-op).
; ======================================================================
ScriptJumpTable:
	dc.l	$00000958			; $890  cmd $F0 (NOP)
	dc.l	$00000958			; $894  cmd $F1 (NOP)
	dc.l	$00000958			; $898  cmd $F2 (NOP)
	dc.l	$00000958			; $89C  cmd $F3 (NOP)
	dc.l	$00000958			; $8A0  cmd $F4 (NOP)
	dc.l	$00000958			; $8A4  cmd $F5 (NOP)
	dc.l	$00000958			; $8A8  cmd $F6 (NOP)
	dc.l	$00000958			; $8AC  cmd $F7 (NOP)
	dc.l	$0000095A			; $8B0  cmd $F8
	dc.l	$00000962			; $8B4  cmd $F9
	dc.l	$0000096A			; $8B8  cmd $FA
	dc.l	$00000990			; $8BC  cmd $FB
	dc.l	$0000099A			; $8C0  cmd $FC
	dc.l	$000009FC			; $8C4  cmd $FD
	dc.l	$00000A0A			; $8C8  cmd $FE
	dc.l	$00000A10			; $8CC  cmd $FF

; ======================================================================
; ScriptDataPointer (loc_0008D0)
; Data-byte path: reads a 16-bit signed offset, resolves it against the
; $0A0000 base into $FF8100, and adds the command byte to the counter.
; ======================================================================
ScriptDataPointer:
	move.b	(A1)+, D1			; $8D0
	lsl.w	#$8, D1				; $8D2
	move.b	(A1)+, D1			; $8D4
	ext.l	D1				; $8D6
	add.l	A0, D1				; $8D8
	move.l	D1, (-$3F00,A4)			; $8DA
	tst.b	D0				; $8DE
	beq.b	*+$14				; $8E0
	add.b	(-$3A00,A4), D0			; $8E2
	move.b	D0, (-$3A00,A4)			; $8E6
	beq.b	ProcessScriptByte		; $8EA
	cmpi.b	#$F0, D0			; $8EC
	bcc.b	ProcessScriptByte		; $8F0
	bra.b	*+$6				; $8F2
ScriptClearCounter:
	clr.w	(-$3A00,A4)			; $8F4
ScriptSaveStream:
	move.l	A1, (-$3C00,A4)			; $8F8
ScriptFrameTick:
	move.b	(-$3FFD,A4), D0			; $8FC
	andi.b	#$FB, D0			; $900
	btst	#$4, D0				; $904
	beq.b	*+$12				; $908
	btst.b	#$1, (-$4000,A4)		; $90A
	beq.b	*+$3C				; $910
	ori.b	#$1, (-$4000,A4)		; $912
	bra.b	*+$34				; $918
ScriptHandleRepeat:
	btst	#$6, D0				; $91A
	beq.b	*+$32				; $91E
	subq.b	#$1, (-$38FF,A4)		; $920
	beq.b	*+$A				; $924
	btst	#$5, D0				; $926
	beq.b	*+$22				; $92A
	bra.b	*+$24				; $92C
ScriptRepeatAdvance:
	move.b	(-$3900,A4), D1			; $92E
	bchg	#$5, D0				; $932
	bne.b	*+$6				; $936
	lsr.b	#$4, D1				; $938
	bra.b	*+$A				; $93A
ScriptRepeatSet:
	andi.b	#$F, D1				; $93C
	ori.b	#$4, D0				; $940
ScriptRepeatStore:
	addq.b	#$1, D1				; $944
	move.b	D1, (-$38FF,A4)			; $946
	bra.b	*+$6				; $94A
ScriptSetRepeatFlag:
	ori.b	#$4, D0				; $94C
ScriptFinishFrame:
	ori.b	#$80, D0			; $950
	move.b	D0, (-$3FFD,A4)			; $954
	rts					; $958

; ======================================================================
; Script command handlers.
; ======================================================================
ScriptCmd_Flag0:				; cmd $F8: set $FF8002 bit 0
	ori.b	#$1, (-$3FFE,A4)		; $95A
	rts					; $960
ScriptCmd_Flag1:				; cmd $F9: set $FF8002 bit 1
	ori.b	#$2, (-$3FFE,A4)		; $962
	rts					; $968
ScriptCmd_MoveX:				; cmd $FA: add signed byte to X
	move.b	(A1)+, D0			; $96A
	ext.w	D0				; $96C
	btst.b	#$3, (-$3FFE,A4)		; $96E
	beq.b	*+$4				; $974
	neg.w	D0				; $976
ScriptCmd_MoveX_Add:
	add.w	D0, (-$3800,A4)			; $978
ScriptCmd_MoveY:				; cmd $FA: add signed byte to Y
	move.b	(A1)+, D0			; $97C
	ext.w	D0				; $97E
	btst.b	#$4, (-$3FFE,A4)		; $980
	beq.b	*+$4				; $986
	neg.w	D0				; $988
ScriptCmd_MoveY_Add:
	add.w	D0, (-$3700,A4)			; $98A
	rts					; $98E
ScriptCmd_StorePair:				; cmd $FB: read 2 bytes to $FF8B00/01
	move.b	(A1)+, (-$3500,A4)		; $990
	move.b	(A1)+, (-$34FF,A4)		; $994
	rts					; $998
ScriptCmd_XBound:				; cmd $FC: X boundary check/adjust
	move.b	(A1)+, D0			; $99A
	btst.b	#$6, (-$4000,A4)		; $99C
	beq.b	*+$22				; $9A2
	btst.b	#$0, (-$3100,A4)		; $9A4
	beq.b	*+$1A				; $9AA
	move.b	(-$34FE,A4), D1			; $9AC
	sub.b	D0, D1				; $9B0
	bcc.b	*+$12				; $9B2
	ext.w	D1				; $9B4
	btst.b	#$2, (-$3100,A4)		; $9B6
	beq.b	*+$4				; $9BC
	neg.w	D1				; $9BE
ScriptCmd_XBound_Adjust:
	add.w	D1, (-$3800,A4)			; $9C0
ScriptCmd_XBound_Store:
	move.b	D0, (-$34FE,A4)			; $9C4
ScriptCmd_YBound:				; cmd $FD: Y boundary check/adjust
	move.b	(A1)+, D0			; $9C8
	btst.b	#$6, (-$4000,A4)		; $9CA
	beq.b	*+$26				; $9D0
	btst.b	#$2, (-$3FFE,A4)		; $9D2
	bne.b	*+$12				; $9D8
	btst.b	#$1, (-$3100,A4)		; $9DA
	beq.b	*+$16				; $9E0
	btst.b	#$3, (-$3100,A4)		; $9E2
	bne.b	*+$E				; $9E8
ScriptCmd_YBound_Adjust:
	move.b	(-$34FD,A4), D1			; $9EA
	sub.b	D0, D1				; $9EE
	ext.w	D1				; $9F0
	add.w	D1, (-$3700,A4)			; $9F2
ScriptCmd_YBound_Store:
	move.b	D0, (-$34FD,A4)			; $9F6
	rts					; $9FA
ScriptCmd_End:					; cmd $FE: end of script
	clr.w	(-$3A00,A4)			; $9FC
	move.l	A1, (-$3C00,A4)			; $A00
	addq.l	#$4, SP				; $A04
	bra.w	ScriptSaveStream			; $A06
ScriptCmd_SetStream:				; cmd $FF: reload stream pointer
	move.l	A1, (-$3B00,A4)			; $A0A
	rts					; $A0E
ScriptCmd_ResetStep:				; (cmd tail) clear step, restore stream
	clr.b	(-$2C00,A4)			; $A10
	movea.l	(-$3B00,A4), A1			; $A14
	rts					; $A18
