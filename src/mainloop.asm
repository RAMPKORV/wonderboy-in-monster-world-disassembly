; ======================================================================
; src/mainloop.asm
; Engine core: status panel helpers, exception handlers, main init, VDP
; setup, I/O init, VBlank handler, and the task dispatcher main loop.
; Covers ROM $004900-$004C82.
; Verified bit-exact against the original ROM.
; ======================================================================
	rts					; $4900
	jsr $BEE.w	; $4902
	beq.b *+$8	; $4906
	jsr $4814.w	; $4908
	addq.w #$4, SP	; $490C
loc_490E:
	rts	; $490E
	lea (-$5EDE).w, A0	; $4910
	move.w (RAM_word_FFFFA142).w, D0	; $4914
loc_4918:
	cmp.w (A0)+, D1	; $4918
	beq.b *+$C	; $491A
	addq.w #$2, A0	; $491C
	subq.b #$1, D0	; $491E
	bne.b loc_4918	; $4920
loc_4922:
	bra.w loc_4922	; $4922
loc_4926:
	rts	; $4926
loc_4928:
	moveq #$0, D0	; $4928
	move.b (-$2BFD,A4), D0	; $492A
	lea ($1BA6C).l, A0	; $492E
	adda.w (A0), A0	; $4934
	move.w D0, D1	; $4936
	add.w D1, D1	; $4938
	add.w D1, D0	; $493A
	move.b ($0,A0,D0.w), D0	; $493C
	andi.w #$FF, D0	; $4940
	lsl.w #$5, D0	; $4944
	rts	; $4946
	tst.b (-$2BFE,A4)	; $4948
	bne.b *+$16	; $494C
	btst.b #$2, (-$2AFD,A4)	; $494E
	beq.b *+$E	; $4954
	bsr.b loc_4928	; $4956
	move.w D0, (RAM_HUD_HP).w	; $4958
	move.w (-$2600,A4), (RAM_HUD_Gold).w	; $495C
loc_4962:
	rts	; $4962
loc_4964:
	move.w (-$26FE,A4), D1	; $4964
	move.b ($4972,PC,D1.w), D1	; $4968
	mulu.w D1, D0	; $496C
	lsr.l #$6, D0	; $496E
	rts					; $4970
StatThresholdTable:				; loc_0004972
	dc.w	$8040,$3028,$201C,$1814		; $4972  per-stat threshold words
	dc.w	$1210,$0C0A,$0807,$0606		; $497A
	dc.w	$0505,$0404			; $4982
DrawStatusPanel:				; loc_0004986
	moveq	#$1F, D0			; $4986
	jsr	$366.w				; $4988
	bsr.w loc_4928	; $498C
	move.w D0, (RAM_HUD_HP).w	; $4990
	moveq #$0, D0	; $4994
	move.w (-$2600,A4), D2	; $4996
	tst.b (-$2AFD,A4)	; $499A
	bpl.b *+$38	; $499E
	move.w (-$23FE,A4), D0	; $49A0
	beq.b *+$32	; $49A4
	bsr.b loc_4964	; $49A6
	btst.b #$5, (RAM_word_FFFF9F03).w	; $49A8
	beq.b *+$28	; $49AE
	btst.b #$3, (-$2AFD,A4)	; $49B0
	beq.b *+$20	; $49B6
	move.w (RAM_word_FFFF9F16).w, D1	; $49B8
	beq.b *+$1A	; $49BC
	add.w D0, D0	; $49BE
	move.w (-$2300,A4), D3	; $49C0
	andi.w #$C0, D3	; $49C4
	lsr.w #$5, D3	; $49C8
	sub.w ($49F0,PC,D3.w), D1	; $49CA
	bpl.b *+$4	; $49CE
	moveq #$0, D1	; $49D0
loc_49D2:
	move.w D1, (RAM_word_FFFF9F16).w	; $49D2
loc_49D6:
	tst.b (-$21FF,A4)	; $49D6
	bpl.b *+$6	; $49DA
	add.w (-$21FE,A4), D0	; $49DC
loc_49E0:
	sub.w D0, D2	; $49E0
	bhi.b *+$4	; $49E2
	moveq #$0, D2	; $49E4
loc_49E6:
	move.w D2, (-$2600,A4)	; $49E6
	move.w D2, (RAM_HUD_Gold).w	; $49EA
	rts					; $49EE
DamageTable:					; loc_00049F0
	dc.w	$0400,$0400,$0400,$0400		; $49F0  damage subtractions
	nop					; $49F8
loc_49FA:
	bra.w loc_49FA	; $49FA
loc_49FE:
	bra.w loc_49FE	; $49FE
loc_4A02:
	nop	; $4A02
	bra.b loc_4A02	; $4A04
MainInit:					; loc_0004A06
	moveq #$2, D0	; $4A06
loc_4A08:
	and.w ($C00004).l, D0	; $4A08
	bne.b loc_4A08	; $4A0E
	move #$2700, SR	; $4A10
	bsr.b *+$66	; $4A14
	move.l	#$C0000000, ($C00004).l	; $4A16
	move.w	#$0, ($C00000).l		; $4A20
	jsr	WriteZ80Driver.w			; $4A28
	jsr	InitIO.l				; $4A2C
	bsr.w	$5170				; $4A32
	bsr.w	$6BA0				; $4A36
	bsr.w	$5398				; $4A3A
	bsr.w	InitQueues			; $4A3E
	bsr.w	$9F46				; $4A42
	clr.b	(RAM_word_FFFF8A50).w			; $4A46
	clr.b	(RAM_word_FFFF8A51).w			; $4A4A
	clr.b	(RAM_word_FFFF9855).w			; $4A4E
	moveq	#$1, D0				; $4A52
	and.w	($C00004).l, D0			; $4A54
	move.b	D0, (RAM_word_FFFF8A8B).w		; $4A5A
	move.b	#$1, (RAM_VBlankFlag).w		; $4A5E
	move	#$2500, SR			; $4A64
	jsr	$64E.w				; $4A68
	bsr.w	$51C6				; $4A6C
	bsr.w	$51C6				; $4A70
	jmp	$4CB8.l				; $4A74
SetupVDP:					; loc_0004A7A
	lea	(VDPRegTable).l, A0		; $4A7A
	move.w #$8, D1	; $4A80
	move.w (A0)+, D0	; $4A84
	movea.w (A0)+, A1	; $4A86
	move.w D0, (A1)	; $4A88
	move.w D0, ($C00004).l	; $4A8A
	dbf D1, $4A84	; $4A90
	lea	(VDPPlaneTable).l, A1		; $4A94
	move.w (A1)+, (RAM_PlaneA_Addr).w	; $4A9A
	jsr $716.w	; $4A9E
	move.w (A1)+, (RAM_PlaneB_Addr).w	; $4AA2
	jsr $72C.w	; $4AA6
	move.w (A1)+, (RAM_SpriteTable_Addr).w	; $4AAA
	jsr $74E.w	; $4AAE
	move.w (A1)+, (RAM_SpriteDims_Addr).w	; $4AB2
	jsr $764.w	; $4AB6
	move.w (A1)+, (RAM_BgColor_Addr).w	; $4ABA
	jsr $786.w	; $4ABE
	move.w (A1)+, (RAM_ScrollX).w	; $4AC2
	move.w (A1)+, (RAM_ScrollY).w	; $4AC6
	jsr $79C.w	; $4ACA
	rts	; $4ACE
VDPRegTable:
	dc.w	$8004,$8A5A			; $4AD0  VDP reg -> RAM mirror pairs
	dc.w	$8104,$8A5C			; $4AD4
	dc.w	$8700,$8A6C			; $4AD8
	dc.w	$8A00,$8A78			; $4ADC
	dc.w	$8B00,$8A5E			; $4AE0
	dc.w	$8C00,$8A60			; $4AE4
	dc.w	$8F02,$8A6E			; $4AE8
	dc.w	$9100,$8A74			; $4AEC
	dc.w	$9200,$8A76			; $4AF0  (unused padding)
VDPPlaneTable:
	dc.w	$C000				; $4AF4  Plan A address
	dc.w	$D800				; $4AF6  Plan B address
	dc.w	$E000				; $4AF8  Sprite table
	dc.w	$D000				; $4AFA  Sprite dimensions
	dc.w	$D400				; $4AFC  Background color
	dc.w	$0020				; $4AFE  Scroll X
	dc.w	$0040				; $4B00  Scroll Y
InitIO:						; loc_0004B02
	moveq #$40, D0	; $4B02
	move.b D0, ($A10009).l	; $4B04
	move.b D0, ($A1000B).l	; $4B0A
	move.b D0, ($A1000D).l	; $4B10
	moveq #$0, D0	; $4B16
	move.b D0, (RAM_InputSelected).w	; $4B18
	move.b D0, (RAM_InputSelectedPrev).w	; $4B1C
	move.b D0, (RAM_InputSelectedNew).w	; $4B20
	move.b D0, (RAM_P1Pad).w	; $4B24
	move.b D0, (RAM_word_FFFF8A80).w	; $4B28
	move.b D0, (RAM_word_FFFF8A81).w	; $4B2C
	move.b D0, (RAM_P2Pad).w	; $4B30
	move.b D0, (RAM_word_FFFF8A83).w	; $4B34
	move.b D0, (RAM_word_FFFF8A84).w	; $4B38
	move.b D0, (RAM_InputSelected2).w	; $4B3C
	rts	; $4B40
InitQueues:					; loc_0004B42
	lea (-$7FB8).w, A0	; $4B42
	moveq #$13, D0	; $4B46
	clr.w (A0)	; $4B48
	lea ($80,A0), A0	; $4B4A
	dbf D0, $4B48	; $4B4E
	bsr.w ClearTaskSlots	; $4B52
	rts	; $4B56
TrapSpin:
	nop	; $4B58
	bra.b TrapSpin	; $4B5A
VBlankHandler:					; loc_0004B5C (IRQ6)
	addq.b #$1, (RAM_VBlankTick).l	; $4B5C
	ori.b #$1, (RAM_VBlankFlag).w	; $4B62
	rte					; $4B68
VBlankTick:					; loc_0004B6A
	clr.b (RAM_SchedulerCursor).w	; $4B6A
	bsr.b *+$14	; $4B6E
	bsr.b *+$26	; $4B70
ClearTaskSlots:
	moveq #$0, D0	; $4B72
	lea (-$7FF8).w, A0	; $4B74
	moveq #$1F, D1	; $4B78
	move.w D0, (A0)+	; $4B7A
	dbf D1, $4B7A	; $4B7C
	rts	; $4B80
ClearFirstTaskSlots:
	moveq #$0, D0	; $4B82
	lea (-$7FB8).w, A0	; $4B84
	moveq #$3, D1	; $4B88
	move.w D0, (A0)	; $4B8A
	lea ($80,A0), A0	; $4B8C
	dbf D1, $4B8A	; $4B90
	rts	; $4B94
CleanupObjects:
	lea (-$7DB8).w, A0	; $4B96
	moveq #$F, D1	; $4B9A
	tst.w (A0)	; $4B9C
	bpl.b *+$14	; $4B9E
	move.w A0, -(SP)	; $4BA0
	move.w D1, -(SP)	; $4BA2
	move.l ($4,A0), D2	; $4BA4
	jsr $4A4.w	; $4BA8
	move.w (SP)+, D1	; $4BAC
	movea.w (SP)+, A0	; $4BAE
	clr.w (A0)	; $4BB0
loc_4BB2:
	lea ($80,A0), A0	; $4BB2
	dbf D1, $4B9C	; $4BB6
	rts	; $4BBA
MainLoop:					; loc_0004BBC
	move.b #-$80, (RAM_SchedulerCursor).w	; $4BBC
	lea (-$7FB8).w, A5	; $4BC2
DispatchImmediateTask:
	move.b (A5), D0	; $4BC6
	andi.b #-$80, D0	; $4BC8
	beq.b *+$10	; $4BCC
	move.w A5, (RAM_CurrentTaskSlot).w	; $4BCE
	movea.l ($C,A5), A0	; $4BD2
	jsr (A0)	; $4BD6
	movea.w (RAM_CurrentTaskSlot).w, A5	; $4BD8
NextTaskSlot:
	lea ($80,A5), A5	; $4BDC
	addq.b #$1, (RAM_SchedulerCursor).w	; $4BE0
	cmpi.b #-$7C, (RAM_SchedulerCursor).w	; $4BE4
	bcs.b DispatchImmediateTask	; $4BEA
	bsr.w	$53AA				; $4BEC
	bsr.b *+$10	; $4BF0
loc_4BF2:
	bsr.w	FrameWait			; $4BF2
	bra.b	MainLoop			; $4BF6
ResetStack:					; loc_0004BF8
	movea.l #RAM_ObjectRAM, SP	; $4BF8
	bra.b loc_4BF2	; $4BFE
WaitForVBlankScanline:				; loc_0004C00
	btst.b #$6, (RAM_word_FFFF8A5D).w	; $4C00
	beq.b *+$54	; $4C06
	cmpi.b #$10, (RAM_VBlankTick).w	; $4C08
	bcc.b *+$4C	; $4C0E
	moveq #$0, D0	; $4C10
	move.b (RAM_word_FFFF8A4A).w, D0	; $4C12
	asl.w #$7, D0	; $4C16
	addi.w #-$7DB8, D0	; $4C18
	movea.w D0, A5	; $4C1C
	move.b #$10, (RAM_word_FFFF8A4B).w	; $4C1E
loc_4C24:
	move.w ($C00004).l, D0	; $4C24
	andi.w #$8, D0	; $4C2A
	bne.b *+$2A	; $4C2E
	move.w ($C00008).l, D0	; $4C30
	andi.w #-$100, D0	; $4C36
loc_4C3A:
	move.w D0, D2	; $4C3A
	move.w ($C00008).l, D0	; $4C3C
	andi.w #-$100, D0	; $4C42
	cmp.w D0, D2	; $4C46
	bne.b loc_4C3A	; $4C48
	cmpi.w #-$3000, D2	; $4C4A
	bcc.b *+$A	; $4C4E
	bsr.b *+$1E	; $4C50
	subq.b #$1, (RAM_word_FFFF8A4B).w	; $4C52
	bne.b loc_4C24	; $4C56
loc_4C58:
	rts	; $4C58
loc_4C5A:
	move.b #$10, (RAM_word_FFFF8A4B).w	; $4C5A
	lea (-$7DB8).w, A5	; $4C60
loc_4C64:
	bsr.b *+$A	; $4C64
	subq.b #$1, (RAM_word_FFFF8A4B).w	; $4C66
	bne.b loc_4C64	; $4C6A
	rts	; $4C6C
RunRoundRobinTask:				; loc_0004C6E
	clr.b (RAM_VBlankTick).w	; $4C6E
	move.b (A5), D0	; $4C72
	andi.b #-$80, D0	; $4C74
	beq.b	*+$16				; $4C78
	move.w A5, (RAM_CurrentTaskSlot).w	; $4C7A
	movea.l ($C,A5), A0	; $4C7E
