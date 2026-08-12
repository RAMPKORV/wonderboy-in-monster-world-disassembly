; ======================================================================
; src/entity.asm
; Entity subsystem: entity slot init/flags, X/Y movement physics with
; sine/atan lookup tables, collision/bound checks. Covers ROM $000A1A-$001400.
;
; Addressing: A4 = entity slot base ($00FFC000 for slot 0). Offsets:
;   $FF8000 flags   $FF8002 counter/flags   $FF8800 X   $FF8900 Y
;   $FF8300-02 tree/script indices   $FF8E00+ extra fields
; Verified bit-exact against the original ROM.
; ======================================================================
InitEntity:					; loc_000A1A
	move.w #-$4000, (-$4000,A4)	; $A1A
loc_A20:
	jsr $C1C.w	; $A20
	moveq #$0, D0	; $A24
	move.w D0, (-$3FFE,A4)	; $A26
	move.l D0, (-$3E00,A4)	; $A2A
	move.w #$100, (-$39FE,A4)	; $A2E
	rts	; $A34
InitEntityExt:				; loc_000A36
	bsr.b loc_A20	; $A36
	move.w D0, (-$3FFE,A4)	; $A38
	move.l D0, (-$3200,A4)	; $A3C
	move.l D0, (-$3100,A4)	; $A40
	move.l D0, (-$3000,A4)	; $A44
	move.l D0, (-$2F00,A4)	; $A48
	move.w D0, (-$2C00,A4)	; $A4C
	move.l D0, (-$2B00,A4)	; $A50
	move.l D0, (-$2A00,A4)	; $A54
	move.l D0, (-$2900,A4)	; $A58
	move.w D0, (-$21FE,A4)	; $A5C
	move.l D0, (-$2800,A4)	; $A60
	rts	; $A64
SetEntityFlagsActive:			; loc_000A66
	movea.w #$0, A4	; $A66
	moveq #$3F, D1	; $A6A
	move.b (-$4000,A4), D0	; $A6C
	bpl.b *+$16	; $A70
	bset.l #$5, D0	; $A72
	beq.b *+$8	; $A76
	ori.b #$10, D0	; $A78
	bra.b *+$6	; $A7C
loc_A7E:
	andi.b #-$11, D0	; $A7E
loc_A82:
	move.b D0, (-$4000,A4)	; $A82
loc_A86:
	addq.w #$4, A4	; $A86
	dbf D1, $A6C	; $A88
	rts	; $A8C
ClearEntityFlagsActive:			; loc_000A8E
	movea.w #$0, A4	; $A8E
	moveq #$3F, D1	; $A92
	move.b (-$4000,A4), D0	; $A94
	bpl.b *+$14	; $A98
	andi.b #-$21, D0	; $A9A
	bclr.l #$4, D0	; $A9E
	beq.b *+$6	; $AA2
	ori.b #$20, D0	; $AA4
loc_AA8:
	move.b D0, (-$4000,A4)	; $AA8
loc_AAC:
	addq.w #$4, A4	; $AAC
	dbf D1, $A94	; $AAE
	rts	; $AB2
	bsr.b *+$22	; $AB4
	swap D0	; $AB6
	move.b (-$35FF,A4), D0	; $AB8
	add.b D0, (-$37FE,A4)	; $ABC
	move.w (-$3800,A4), D2	; $AC0
	move.b (-$3600,A4), D0	; $AC4
	ext.w D0	; $AC8
	addx.w D2, D0	; $ACA
	move.w D0, (-$3800,A4)	; $ACC
	move.w D2, (-$2E00,A4)	; $AD0
	rts	; $AD4
loc_AD6:
	move.b (-$35FD,A4), D0	; $AD6
	add.b D0, (-$36FE,A4)	; $ADA
	move.w (-$3700,A4), D3	; $ADE
	move.b (-$35FE,A4), D0	; $AE2
	ext.w D0	; $AE6
	addx.w D3, D0	; $AE8
	move.w D0, (-$3700,A4)	; $AEA
	move.w D3, (-$2DFE,A4)	; $AEE
	rts	; $AF2
loc_AF4:
	move.w (-$3400,A4), D0	; $AF4
	btst.b #$0, (-$2F00,A4)	; $AF8
	bne.b *+$8	; $AFE
	add.w (-$3600,A4), D0	; $B00
	bra.b *+$38	; $B04
loc_B06:
	move.w (-$3300,A4), D2	; $B06
	move.w (-$3600,A4), D1	; $B0A
	tst.w D0	; $B0E
	beq.b *+$30	; $B10
	bmi.b *+$16	; $B12
	cmp.w D2, D1	; $B14
	blt.b *+$A	; $B16
	beq.b *+$28	; $B18
	neg.w D0	; $B1A
	asr.w #$1, D0	; $B1C
	bra.b *+$16	; $B1E
loc_B20:
	add.w D1, D0	; $B20
	cmp.w D2, D0	; $B22
	ble.b *+$18	; $B24
	bra.b *+$14	; $B26
loc_B28:
	neg.w D2	; $B28
	cmp.w D2, D1	; $B2A
	bgt.b *+$8	; $B2C
	neg.w D0	; $B2E
	asr.w #$1, D0	; $B30
	bra.b loc_B20	; $B32
loc_B34:
	add.w D1, D0	; $B34
	cmp.w D2, D0	; $B36
	bge.b *+$4	; $B38
loc_B3A:
	move.w D2, D0	; $B3A
loc_B3C:
	move.w D0, (-$3600,A4)	; $B3C
loc_B40:
	rts	; $B40
	bsr.b loc_AF4	; $B42
	move.w (-$33FE,A4), D0	; $B44
	btst.b #$1, (-$2F00,A4)	; $B48
	bne.b *+$8	; $B4E
	add.w (-$35FE,A4), D0	; $B50
	bra.b *+$38	; $B54
loc_B56:
	move.w (-$32FE,A4), D2	; $B56
	move.w (-$35FE,A4), D1	; $B5A
	tst.w D0	; $B5E
	beq.b *+$30	; $B60
	bmi.b *+$16	; $B62
	cmp.w D2, D1	; $B64
	blt.b *+$A	; $B66
	beq.b *+$28	; $B68
	neg.w D0	; $B6A
	asr.w #$1, D0	; $B6C
	bra.b *+$16	; $B6E
loc_B70:
	add.w D1, D0	; $B70
	cmp.w D2, D0	; $B72
	ble.b *+$18	; $B74
	bra.b *+$14	; $B76
loc_B78:
	neg.w D2	; $B78
	cmp.w D2, D1	; $B7A
	bgt.b *+$8	; $B7C
	neg.w D0	; $B7E
	asr.w #$1, D0	; $B80
	bra.b loc_B70	; $B82
loc_B84:
	add.w D1, D0	; $B84
	cmp.w D2, D0	; $B86
	bge.b *+$4	; $B88
loc_B8A:
	move.w D2, D0	; $B8A
loc_B8C:
	move.w D0, (-$35FE,A4)	; $B8C
loc_B90:
	rts	; $B90
	move.w (-$3600,A4), D1	; $B92
	beq.b *+$14	; $B96
	bpl.b *+$8	; $B98
	add.w D0, D1	; $B9A
	bmi.b *+$A	; $B9C
	bra.b *+$6	; $B9E
loc_BA0:
	sub.w D0, D1	; $BA0
	bpl.b *+$4	; $BA2
loc_BA4:
	moveq #$0, D1	; $BA4
loc_BA6:
	move.w D1, (-$3600,A4)	; $BA6
loc_BAA:
	rts	; $BAA
	move.w (-$35FE,A4), D1	; $BAC
	beq.b *+$14	; $BB0
	bpl.b *+$8	; $BB2
	add.w D0, D1	; $BB4
	bmi.b *+$A	; $BB6
	bra.b *+$6	; $BB8
loc_BBA:
	sub.w D0, D1	; $BBA
	bpl.b *+$4	; $BBC
loc_BBE:
	moveq #$0, D1	; $BBE
loc_BC0:
	move.w D1, (-$35FE,A4)	; $BC0
loc_BC4:
	rts	; $BC4
loc_BC6:
	move.w (-$3800,A4), D0	; $BC6
	moveq #$0, D2	; $BCA
	move.b (-$34FE,A4), D2	; $BCC
	sub.w (RAM_PlayerX).w, D0	; $BD0
	move.w D0, D1	; $BD4
	add.w D2, D1	; $BD6
	addi.w #$20, D1	; $BD8
	bmi.b *+$E	; $BDC
	sub.w D2, D0	; $BDE
	subi.w #$140, D0	; $BE0
	bpl.b *+$6	; $BE4
	moveq #$0, D0	; $BE6
	rts	; $BE8
loc_BEA:
	moveq #-$1, D0	; $BEA
	rts	; $BEC
	bsr.b loc_BC6	; $BEE
	beq.b *+$4	; $BF0
	rts	; $BF2
loc_BF4:
	move.w (-$3700,A4), D0	; $BF4
	moveq #$0, D2	; $BF8
	move.b (-$34FD,A4), D2	; $BFA
	sub.w (RAM_PlayerY).w, D0	; $BFE
	move.w D0, D1	; $C02
	add.w D2, D1	; $C04
	addi.w #$20, D1	; $C06
	bmi.b *+$E	; $C0A
	sub.w D2, D0	; $C0C
	subi.w #$E0, D0	; $C0E
	bpl.b *+$6	; $C12
	moveq #$0, D0	; $C14
	rts	; $C16
loc_C18:
	moveq #-$1, D0	; $C18
	rts	; $C1A
	moveq #$0, D0	; $C1C
	move.l D0, (-$3600,A4)	; $C1E
	moveq #$0, D0	; $C22
	move.w D0, (-$37FE,A4)	; $C24
	move.w D0, (-$36FE,A4)	; $C28
	rts	; $C2C
	moveq #$0, D0	; $C2E
	move.l D0, (-$3600,A4)	; $C30
	rts	; $C34
	exg A2, A4	; $C36
	bsr.b *+$6	; $C38
	exg A2, A4	; $C3A
	rts	; $C3C
loc_C3E:
	move.l (-$2A00,A2), D0	; $C3E
	beq.b *+$5A	; $C42
	movea.l D0, A0	; $C44
	move.l (-$2900,A4), D0	; $C46
	beq.b *+$52	; $C4A
	movea.l D0, A1	; $C4C
	link A6, #-$A	; $C4E
	move.b (A1)+, (-$6,A6)	; $C52
	move.b (A0)+, D0	; $C56
	move.b D0, (-$4,A6)	; $C58
	move.b D0, (-$2,A6)	; $C5C
	move.l A0, (-$A,A6)	; $C60
loc_C64:
	bsr.b *+$3C	; $C64
	bls.b *+$1E	; $C66
	addq.w #$4, A0	; $C68
	subq.b #$1, (-$2,A6)	; $C6A
	bne.b loc_C64	; $C6E
	addq.w #$4, A1	; $C70
	move.b (-$4,A6), (-$2,A6)	; $C72
	movea.l (-$A,A6), A0	; $C78
	subq.b #$1, (-$6,A6)	; $C7C
	bne.b loc_C64	; $C80
	bra.b *+$18	; $C82
loc_C84:
	ori.b #$40, (-$2AFD,A2)	; $C84
	ori.b #$10, (-$2AFD,A4)	; $C8A
	bsr.w loc_E1A	; $C90
	unlk A6	; $C94
	moveq #-$1, D0	; $C96
	rts	; $C98
loc_C9A:
	unlk A6	; $C9A
loc_C9C:
	moveq #$0, D0	; $C9C
	rts	; $C9E
loc_CA0:
	move.b ($0,A1), D0	; $CA0
	btst.b #$3, (-$3FFE,A4)	; $CA4
	beq.b *+$4	; $CAA
	neg.b D0	; $CAC
loc_CAE:
	ext.w D0	; $CAE
	add.w (-$3800,A4), D0	; $CB0
	move.b ($0,A0), D1	; $CB4
	btst.b #$3, (-$3FFE,A2)	; $CB8
	beq.b *+$4	; $CBE
	neg.b D1	; $CC0
loc_CC2:
	ext.w D1	; $CC2
	add.w (-$3800,A2), D1	; $CC4
	cmp.w D1, D0	; $CC8
	bcc.b *+$4	; $CCA
			dc.w	$c340	; EXG D1,D0
loc_CCE:
	sub.w D1, D0	; $CCE
	moveq #$0, D1	; $CD0
	moveq #$0, D2	; $CD2
	move.b ($2,A0), D1	; $CD4
	move.b ($2,A1), D2	; $CD8
	add.w D2, D1	; $CDC
	sub.w D1, D0	; $CDE
	bhi.b *+$42	; $CE0
	move.b ($1,A1), D1	; $CE2
	ext.w D1	; $CE6
	btst.b #$4, (-$3FFE,A4)	; $CE8
	beq.b *+$4	; $CEE
	neg.b D1	; $CF0
loc_CF2:
	add.w (-$3700,A4), D1	; $CF2
	move.b ($1,A0), D2	; $CF6
	btst.b #$4, (-$3FFE,A2)	; $CFA
	beq.b *+$4	; $D00
	neg.b D2	; $D02
loc_D04:
	ext.w D2	; $D04
	add.w (-$3700,A2), D2	; $D06
	cmp.w D2, D1	; $D0A
	bcc.b *+$4	; $D0C
			dc.w	$c541	; EXG D2,D1
loc_D10:
	sub.w D2, D1	; $D10
	moveq #$0, D2	; $D12
	moveq #$0, D3	; $D14
	move.b ($3,A0), D2	; $D16
	move.b ($3,A1), D3	; $D1A
	add.w D3, D2	; $D1E
	sub.w D2, D1	; $D20
loc_D22:
	rts	; $D22
	exg A2, A4	; $D24
	bsr.b *+$6	; $D26
	exg A2, A4	; $D28
	rts	; $D2A
loc_D2C:
	btst.b #$5, (-$2AFD,A4)	; $D2C
	bne.b *+$38	; $D32
	move.l (-$2900,A2), D0	; $D34
	beq.b *+$32	; $D38
	movea.l D0, A0	; $D3A
	link A6, #-$2	; $D3C
	move.b (A0)+, (-$2,A6)	; $D40
loc_D44:
	bsr.b *+$72	; $D44
	bls.b *+$C	; $D46
	addq.w #$4, A0	; $D48
	subq.b #$1, (-$2,A6)	; $D4A
	bne.b loc_D44	; $D4E
	bra.b *+$18	; $D50
loc_D52:
	ori.b #$10, (-$2AFD,A2)	; $D52
	ori.b #$2, (-$2AFD,A4)	; $D58
	bsr.w loc_E1A	; $D5E
	unlk A6	; $D62
	moveq #-$1, D0	; $D64
	rts	; $D66
loc_D68:
	unlk A6	; $D68
loc_D6A:
	moveq #$0, D0	; $D6A
	rts	; $D6C
	exg A2, A4	; $D6E
	bsr.b *+$6	; $D70
	exg A2, A4	; $D72
	rts	; $D74
loc_D76:
	btst.b #$6, (-$2AFD,A4)	; $D76
	bne.b *+$8	; $D7C
	move.l (-$2A00,A2), D0	; $D7E
	bne.b *+$4	; $D82
loc_D84:
	rts	; $D84
loc_D86:
	movea.l D0, A0	; $D86
	link A6, #-$2	; $D88
	move.b (A0)+, (-$2,A6)	; $D8C
loc_D90:
	bsr.b *+$26	; $D90
	bls.b *+$C	; $D92
	addq.w #$4, A0	; $D94
	subq.b #$1, (-$2,A6)	; $D96
	bne.b loc_D90	; $D9A
	bra.b *+$16	; $D9C
loc_D9E:
	ori.b #$20, (-$2AFD,A2)	; $D9E
	ori.b #-$78, (-$2AFD,A4)	; $DA4
	move.w (-$2400,A2), (-$23FE,A4)	; $DAA
	bsr.b *+$6A	; $DB0
loc_DB2:
	unlk A6	; $DB2
	rts	; $DB4
loc_DB6:
	move.w (-$3800,A4), D0	; $DB6
	move.b ($0,A0), D1	; $DBA
	btst.b #$3, (-$3FFE,A2)	; $DBE
	beq.b *+$4	; $DC4
	neg.b D1	; $DC6
loc_DC8:
	ext.w D1	; $DC8
	add.w (-$3800,A2), D1	; $DCA
	cmp.w D1, D0	; $DCE
	bcc.b *+$4	; $DD0
			dc.w	$c340	; EXG D1,D0
loc_DD4:
	sub.w D1, D0	; $DD4
	moveq #$0, D1	; $DD6
	moveq #$0, D2	; $DD8
	move.b (-$3500,A4), D1	; $DDA
	move.b ($2,A0), D2	; $DDE
	add.w D2, D1	; $DE2
	sub.w D1, D0	; $DE4
	bhi.b *+$32	; $DE6
	move.w (-$3700,A4), D1	; $DE8
	move.b ($1,A0), D2	; $DEC
	btst.b #$4, (-$3FFE,A2)	; $DF0
	beq.b *+$4	; $DF6
	neg.b D2	; $DF8
loc_DFA:
	ext.w D2	; $DFA
	add.w (-$3700,A2), D2	; $DFC
	cmp.w D2, D1	; $E00
	bcc.b *+$4	; $E02
			dc.w	$c541	; EXG D2,D1
loc_E06:
	sub.w D2, D1	; $E06
	moveq #$0, D2	; $E08
	moveq #$0, D3	; $E0A
	move.b (-$34FF,A4), D2	; $E0C
	move.b ($3,A0), D3	; $E10
	add.w D3, D2	; $E14
	sub.w D2, D1	; $E16
loc_E18:
	rts	; $E18
loc_E1A:
	bsr.b *+$30	; $E1A
	or.b D4, (-$2AFD,A2)	; $E1C
	bchg.l #$0, D4	; $E20
	or.b D4, (-$2AFD,A4)	; $E24
	move.w (-$3800,A2), (-$2500,A4)	; $E28
	move.w (-$3800,A4), (-$2500,A2)	; $E2E
	move.w (-$3700,A2), (-$24FE,A4)	; $E34
	move.w (-$3700,A4), (-$24FE,A2)	; $E3A
	move.w A4, (-$22FE,A2)	; $E40
	move.w A2, (-$22FE,A4)	; $E44
	rts	; $E48
loc_E4A:
	moveq #-$2, D0	; $E4A
	and.b D0, (-$2AFD,A4)	; $E4C
	and.b D0, (-$2AFD,A2)	; $E50
	moveq #$0, D4	; $E54
	move.w (-$3800,A4), D0	; $E56
	cmp.w (-$3800,A2), D0	; $E5A
	bcc.b *+$4	; $E5E
	moveq #$1, D4	; $E60
loc_E62:
	rts	; $E62
	tst.b (-$2AFD,A2)	; $E64
	bmi.b *+$30	; $E68
	bsr.b *+$30	; $E6A
	bhi.b *+$2C	; $E6C
	move.w D4, D3	; $E6E
	move.w (-$2700,A2), (-$23FE,A4)	; $E70
	ori.b #-$7C, D3	; $E76
	or.b D3, (-$2AFD,A2)	; $E7A
	move.w (-$2700,A4), (-$23FE,A2)	; $E7E
	move.w A4, (-$22FE,A2)	; $E84
	bchg.l #$0, D4	; $E88
	ori.b #$4, D4	; $E8C
	or.b D4, (-$2AFD,A4)	; $E90
	move.w A2, (-$22FE,A4)	; $E94
loc_E98:
	rts	; $E98
loc_E9A:
	moveq #$0, D4	; $E9A
	move.w (-$3800,A4), D0	; $E9C
	move.w (-$3800,A2), D1	; $EA0
	cmp.w D1, D0	; $EA4
	bcc.b *+$6	; $EA6
			dc.w	$c340	; EXG D1,D0
	moveq #$1, D4	; $EAA
loc_EAC:
	sub.w D1, D0	; $EAC
	moveq #$0, D1	; $EAE
	moveq #$0, D2	; $EB0
	move.b (-$3500,A4), D1	; $EB2
	move.b (-$3500,A2), D2	; $EB6
	add.w D2, D1	; $EBA
	sub.w D1, D0	; $EBC
	bhi.b *+$22	; $EBE
	move.w (-$3700,A4), D1	; $EC0
	move.w (-$3700,A2), D2	; $EC4
	cmp.w D2, D1	; $EC8
	bcc.b *+$4	; $ECA
			dc.w	$c541	; EXG D2,D1
loc_ECE:
	sub.w D2, D1	; $ECE
	moveq #$0, D2	; $ED0
	moveq #$0, D3	; $ED2
	move.b (-$34FF,A4), D2	; $ED4
	move.b (-$34FF,A2), D3	; $ED8
	add.w D3, D2	; $EDC
	sub.w D2, D1	; $EDE
loc_EE0:
	rts	; $EE0
loc_EE2:
	addi.w #$4000, D3	; $EE2
loc_EE6:
	move.w D3, D2	; $EE6
	bpl.b *+$4	; $EE8
	neg.w D2	; $EEA
loc_EEC:
	cmpi.w #$4000, D2	; $EEC
	bne.b *+$6	; $EF0
	move.w D2, D0	; $EF2
	bra.b *+$2A	; $EF4
loc_EF6:
	bcs.b *+$8	; $EF6
	eori.w #$7FFF, D2	; $EF8
	addq.w #$1, D2	; $EFC
loc_EFE:
	move.w D2, D1	; $EFE
	lsr.w #$8, D1	; $F00
	add.w D1, D1	; $F02
	move.w ($F26,PC,D1.w), D0	; $F04
	move.w ($F28,PC,D1.w), D1	; $F08
	sub.w D0, D1	; $F0C
	lsr.w #$1, D1	; $F0E
	tst.b D2	; $F10
	bpl.b *+$4	; $F12
	add.w D1, D0	; $F14
loc_F16:
	lsr.w #$1, D1	; $F16
	add.b D2, D2	; $F18
	bpl.b *+$4	; $F1A
	add.w D1, D0	; $F1C
loc_F1E:
	tst.w D3	; $F1E
	bpl.b *+$4	; $F20
	neg.w D0	; $F22
loc_F24:
	rts	; $F24
	dc.w	$0000,$0192,$0323,$04b5,$0645,$07d5,$0964,$0af1	; $F26
	dc.w	$0c7c,$0e05,$0f8c,$1111,$1294,$1413,$158f,$1708	; $F36
	dc.w	$187d,$19ef,$1b5d,$1cc6,$1e2b,$1f8b,$20e7,$223d	; $F46
	dc.w	$238e,$24da,$261f,$275f,$2899,$29cd,$2afa,$2c21	; $F56
	dc.w	$2d41,$2e5a,$2f6b,$3076,$3179,$3274,$3367,$3453	; $F66
	dc.w	$3536,$3612,$36e5,$37af,$3871,$392a,$39da,$3a82	; $F76
	dc.w	$3b20,$3bb6,$3c42,$3cc5,$3d3e,$3dae,$3e14,$3e71	; $F86
	dc.w	$3ec5,$3f0e,$3f4e,$3f84,$3fb1,$3fd3,$3fec,$3ffb	; $F96
	dc.w	$4000	; $FA6
	bsr.w loc_EE6	; $FA8
	muls.w D4, D0	; $FAC
	asl.l #$2, D0	; $FAE
	swap D0	; $FB0
	move.w D0, D5	; $FB2
	bsr.w loc_EE2	; $FB4
	muls.w D4, D0	; $FB8
	asl.l #$2, D0	; $FBA
	swap D0	; $FBC
	rts	; $FBE
loc_FC0:
	addi.w #$400, D3	; $FC0
	lsl.l #$6, D3	; $FC4
	swap D3	; $FC6
	andi.w #$3E, D3	; $FC8
	move.w ($FE2,PC,D3.w), D5	; $FCC
	muls.w D4, D5	; $FD0
	asl.l #$2, D5	; $FD2
	swap D5	; $FD4
	move.w ($FF2,PC,D3.w), D0	; $FD6
	muls.w D4, D0	; $FDA
	asl.l #$2, D0	; $FDC
	swap D0	; $FDE
	rts	; $FE0
	dc.w	$0000,$0c7c,$187d,$238e,$2d41,$3536,$3b20,$3ec5	; $FE2
	dc.w	$4000,$3ec5,$3b20,$3536,$2d41,$238e,$187d,$0c7c	; $FF2
	dc.w	$0000,$f384,$e783,$dc72,$d2bf,$caca,$c4e0,$c13b	; $1002
	dc.w	$c000,$c13b,$c4e0,$caca,$d2bf,$dc72,$e783,$f384	; $1012
	dc.w	$0000	; $1022
	dc.w	$0c7c,$187d,$238e,$2d41,$3536,$3b20,$3ec5,$302a	; $1024
	dc.w	$c800,$906c,$c800,$322a,$c900,$926c,$c900,$7400	; $1034
	tst.w D0	; $1044
	bpl.b *+$6	; $1046
	addq.w #$2, D2	; $1048
	neg.w D0	; $104A
loc_104C:
	tst.w D1	; $104C
	bpl.b *+$6	; $104E
	addq.w #$4, D2	; $1050
	neg.w D1	; $1052
loc_1054:
	cmp.w D1, D0	; $1054
	bcs.b *+$6	; $1056
	addq.w #$8, D2	; $1058
	exg D0, D1	; $105A
loc_105C:
	add.w D0, D0	; $105C
	cmp.w D1, D0	; $105E
	bcs.b *+$6	; $1060
	ori.w #$10, D2	; $1062
loc_1066:
	move.w ($106C,PC,D2.w), D3	; $1066
	rts	; $106A
	dc.w	$4000,$4000,$c000,$c000,$0000,$8000,$0000,$8000	; $106C
	dc.w	$2000,$6000,$e000,$a000,$2000,$6000,$e000,$a000	; $107C
loc_108C:
CalcAngleToTarget:			; loc_00108C (atan2: angle to another entity)
	move.w (-$3800,A2), D0	; $108C
	sub.w (-$3800,A4), D0	; $1090
	move.w (-$3700,A2), D1	; $1094
	sub.w (-$3700,A4), D1	; $1098
	moveq #$0, D2	; $109C
	tst.w D0	; $109E
	bpl.b *+$6	; $10A0
	addq.w #$2, D2	; $10A2
	neg.w D0	; $10A4
loc_10A6:
	tst.w D1	; $10A6
	bpl.b *+$6	; $10A8
	addq.w #$4, D2	; $10AA
	neg.w D1	; $10AC
loc_10AE:
	cmp.w D0, D1	; $10AE
	bcs.b *+$6	; $10B0
	addq.w #$1, D2	; $10B2
	exg D0, D1	; $10B4
loc_10B6:
	swap D1	; $10B6
	clr.w D1	; $10B8
	moveq #$0, D3	; $10BA
	tst.w D0	; $10BC
	beq.b *+$42	; $10BE
	divu.w D0, D1	; $10C0
	cmp.w ($1102,PC,D3.w), D1	; $10C2
	bcs.b *+$1A	; $10C6
	move.w #$80, D0	; $10C8
loc_10CC:
	or.w D0, D3	; $10CC
	cmp.w ($1102,PC,D3.w), D1	; $10CE
	bcc.b *+$4	; $10D2
	eor.w D0, D3	; $10D4
loc_10D6:
	lsr.w #$1, D0	; $10D6
	btst.l #$0, D0	; $10D8
	beq.b loc_10CC	; $10DC
	addq.w #$2, D3	; $10DE
loc_10E0:
	lsr.w #$1, D2	; $10E0
	bcc.b *+$8	; $10E2
	eori.w #$1FE, D3	; $10E4
	addq.w #$2, D3	; $10E8
loc_10EA:
	lsr.w #$1, D2	; $10EA
	bcc.b *+$8	; $10EC
	eori.w #$3FE, D3	; $10EE
	addq.w #$2, D3	; $10F2
loc_10F4:
	lsr.w #$1, D2	; $10F4
	bcc.b *+$8	; $10F6
	eori.w #$7FE, D3	; $10F8
	addq.w #$2, D3	; $10FC
loc_10FE:
	lsl.w #$5, D3	; $10FE
loc_1100:
	rts	; $1100
	dc.w	$00c9,$025b,$03ed,$057f,$0712,$08a4,$0a37,$0bca	; $1102
	dc.w	$0d5d,$0ef0,$1084,$1218,$13ac,$1541,$16d6,$186b	; $1112
	dc.w	$1a01,$1b98,$1d2f,$1ec7,$205f,$21f8,$2391,$252b	; $1122
	dc.w	$26c6,$2862,$29ff,$2b9c,$2d3a,$2ed9,$3079,$321b	; $1132
	dc.w	$33bd,$3560,$3704,$38a9,$3a4f,$3bf7,$3da0,$3f4a	; $1142
	dc.w	$40f5,$42a2,$4450,$45ff,$47b0,$4963,$4b17,$4ccc	; $1152
	dc.w	$4e83,$503c,$51f7,$53b3,$5571,$5731,$58f2,$5ab6	; $1162
	dc.w	$5c7c,$5e43,$600d,$61d9,$63a7,$6577,$6749,$691e	; $1172
	dc.w	$6af5,$6ccf,$6eab,$7089,$726b,$744e,$7635,$781e	; $1182
	dc.w	$7a0a,$7bf9,$7deb,$7fe0,$81d8,$83d3,$85d1,$87d3	; $1192
	dc.w	$89d8,$8be1,$8ded,$8ffc,$920f,$9426,$9641,$985f	; $11A2
	dc.w	$9a82,$9ca9,$9ed4,$a103,$a336,$a56e,$a7aa,$a9eb	; $11B2
	dc.w	$ac31,$ae7b,$b0cb,$b31f,$b579,$b7d7,$ba3c,$bca5	; $11C2
	dc.w	$bf15,$c18a,$c405,$c686,$c90d,$cb9a,$ce2e,$d0c8	; $11D2
	dc.w	$d369,$d611,$d8bf,$db75,$de33,$e0f8,$e3c4,$e699	; $11E2
	dc.w	$e975,$ec5a,$ef47,$f23d,$f53b,$f843,$fb54,$fe6f	; $11F2
	jsr $108C.w	; $1202
	move.w D3, D6	; $1206
	jsr $FA8.w	; $1208
	move.w D0, (-$3600,A4)	; $120C
	move.w D5, (-$35FE,A4)	; $1210
	rts	; $1214
	jsr $108C.w	; $1216
	move.w D3, D6	; $121A
	jmp $FA8.w	; $121C
	jsr $1032.w	; $1220
	move.w D3, D6	; $1224
	jsr $FC0.w	; $1226
	move.w D0, (-$3600,A4)	; $122A
	move.w D5, (-$35FE,A4)	; $122E
	rts	; $1232
	jsr $108C.w	; $1234
	move.w D3, D6	; $1238
	jsr $FC0.w	; $123A
	move.w D0, (-$3600,A4)	; $123E
	move.w D5, (-$35FE,A4)	; $1242
	rts	; $1246
	bsr.w loc_108C	; $1248
	move.w D3, D6	; $124C
	bra.w loc_FC0	; $124E
	move.w (-$3800,A2), D0	; $1252
	sub.w (-$3800,A4), D0	; $1256
	bpl.b *+$4	; $125A
	neg.w D0	; $125C
loc_125E:
	move.w (-$3700,A2), D1	; $125E
	sub.w (-$3700,A4), D1	; $1262
	bpl.b *+$4	; $1266
	neg.w D1	; $1268
loc_126A:
	cmp.w D0, D1	; $126A
	bcs.b *+$4	; $126C
	exg D0, D1	; $126E
loc_1270:
	lsr.w #$1, D1	; $1270
	add.w D1, D0	; $1272
	lsr.w #$2, D1	; $1274
	sub.w D1, D0	; $1276
	rts	; $1278
	move.w D0, D4	; $127A
	bpl.b *+$4	; $127C
	neg.w D4	; $127E
loc_1280:
	move.w D1, D5	; $1280
	bpl.b *+$4	; $1282
	neg.w D5	; $1284
loc_1286:
	cmp.w D5, D4	; $1286
	scc D3	; $1288
	bcc.b *+$4	; $128A
	exg D4, D5	; $128C
loc_128E:
	tst.w D4	; $128E
	bne.b *+$6	; $1290
	clr.w D2	; $1292
	rts	; $1294
loc_1296:
	swap D5	; $1296
	clr.w D5	; $1298
	divu.w D4, D5	; $129A
	mulu.w D2, D5	; $129C
	swap D5	; $129E
	exg D2, D4	; $12A0
	tst.b D3	; $12A2
	bne.b *+$4	; $12A4
	exg D4, D5	; $12A6
loc_12A8:
	tst.w D0	; $12A8
	bpl.b *+$4	; $12AA
	neg.w D4	; $12AC
loc_12AE:
	tst.w D1	; $12AE
	bpl.b *+$4	; $12B0
	neg.w D5	; $12B2
loc_12B4:
	rts	; $12B4
	tst.w D1	; $12B6
	bpl.b *+$26	; $12B8
	moveq #$0, D2	; $12BA
	move.w D1, D2	; $12BC
	neg.w D2	; $12BE
	bsr.b *+$50	; $12C0
	tst.w D5	; $12C2
	beq.b *+$2A	; $12C4
	move.w D5, D3	; $12C6
	subq.w #$7, D3	; $12C8
	move.w D3, D4	; $12CA
	subq.w #$1, D4	; $12CC
	lsl.w #$5, D4	; $12CE
	mulu.w D3, D4	; $12D0
	lsl.w #$8, D6	; $12D2
	sub.w D4, D6	; $12D4
	lsl.w #$6, D3	; $12D6
	neg.w D3	; $12D8
	neg.w D6	; $12DA
	bra.b *+$2C	; $12DC
loc_12DE:
	moveq #$0, D2	; $12DE
	move.w D1, D2	; $12E0
	bsr.b *+$2E	; $12E2
	tst.w D5	; $12E4
	beq.b *+$8	; $12E6
	move.w #-$1C0, D3	; $12E8
	bra.b *+$1A	; $12EC
loc_12EE:
	move.w D3, D5	; $12EE
	lsr.w #$1, D5	; $12F0
	move.w D1, D3	; $12F2
	ext.l D3	; $12F4
	lsl.l #$8, D3	; $12F6
	divs.w D5, D3	; $12F8
	move.w D5, D4	; $12FA
	addq.w #$1, D4	; $12FC
	lsl.w #$5, D4	; $12FE
	sub.w D4, D3	; $1300
	move.w #$200, D2	; $1302
loc_1306:
	moveq #$0, D6	; $1306
loc_1308:
	tst.w D0	; $1308
	bpl.b *+$4	; $130A
	neg.w D2	; $130C
loc_130E:
	rts	; $130E
loc_1310:
	addq.w #$7, D2	; $1310
	move.w D2, D6	; $1312
	lsl.w #$5, D2	; $1314
	addq.w #$1, D2	; $1316
	moveq #$0, D5	; $1318
	moveq #$0, D3	; $131A
	moveq #$7, D4	; $131C
	add.w D5, D5	; $131E
	lsl.l #$2, D2	; $1320
	swap D2	; $1322
	add.w D3, D3	; $1324
	addq.w #$1, D3	; $1326
	cmp.w D3, D2	; $1328
	bcc.b *+$6	; $132A
	subq.w #$1, D3	; $132C
	bra.b *+$8	; $132E
loc_1330:
	sub.w D3, D2	; $1330
	addq.w #$1, D3	; $1332
	addq.w #$1, D5	; $1334
loc_1336:
	swap D2	; $1336
	dbf D4, $131E	; $1338
	subq.w #$1, D5	; $133C
	lsr.w #$1, D5	; $133E
	addq.w #$7, D5	; $1340
	moveq #$0, D2	; $1342
	move.w D0, D2	; $1344
	bpl.b *+$4	; $1346
	neg.w D2	; $1348
loc_134A:
	move.w D2, D3	; $134A
	lsl.l #$8, D2	; $134C
	divu.w D5, D2	; $134E
	cmpi.w #$200, D2	; $1350
	bhi.b *+$4	; $1354
	rts	; $1356
loc_1358:
	moveq #$0, D5	; $1358
	rts	; $135A
	lea (-$74A8).w, A1	; $135C
LoadPalettes:				; loc_000135C (read 4 palette index bytes from A0, decode to RAM_PaletteSource)
	moveq #$3, D5	; $1360
	moveq #$0, D0	; $1362
	move.b (A0)+, D0	; $1364
	bsr.b *+$A	; $1366
	addq.w #$2, A1	; $1368
	dbf D5, $1362	; $136A
	rts	; $136E
DecodePalette:				; loc_0001370 (decode one 17-byte packed palette at ROM_PaletteTable+idx*17)
	move.w D0, D1	; $1370
	lsl.w #$4, D1	; $1372
	add.w D1, D0	; $1374
	addi.l #$599C, D0	; $1376
	movea.l D0, A2	; $137C
	moveq #$E, D4	; $137E
	move.b (A2)+, D3	; $1380
	lsl.w #$8, D3	; $1382
	move.b (A2)+, D3	; $1384
	move.b (A2)+, D2	; $1386
	moveq #$7, D0	; $1388
	and.w D2, D0	; $138A
	add.w D0, D0	; $138C
	moveq #$38, D1	; $138E
	and.w D2, D1	; $1390
	lsl.w #$2, D1	; $1392
	or.w D1, D0	; $1394
	andi.w #$C0, D2	; $1396
	lsl.w #$3, D2	; $139A
	or.w D2, D0	; $139C
	lsr.w #$1, D3	; $139E
	bcc.b *+$6	; $13A0
	ori.w #$800, D0	; $13A2
loc_13A6:
	move.w D0, (A1)+	; $13A6
	dbf D4, $1386	; $13A8
	rts	; $13AC
	addq.w #$1, D6	; $13AE
	addq.w #$1, D7	; $13B0
	bsr.w $2050	; $13B2
	subq.w #$1, D6	; $13B6
	subq.w #$1, D7	; $13B8
	rts	; $13BA
	tst.b (RAM_PlayerState).w	; $13BC
	bmi.b *+$4	; $13C0
	rts	; $13C2
loc_13C4:
	bset.b #$6, (RAM_PlayerState).w	; $13C4
	bne.b *+$22	; $13CA
	clr.b (RAM_PlayerSubState).w	; $13CC
	clr.w (RAM_SceneScriptPtr).w	; $13D0
	clr.l (RAM_CellX).w	; $13D4
	clr.w (RAM_SceneEventCounter).w	; $13D8
	clr.b (RAM_EventFlag).w	; $13DC
	move.b #$1, (RAM_EventCounter).w	; $13E0
	move.w #-$8000, (RAM_PlayerStateValue).w	; $13E6
loc_13EC:
	btst.b #$2, (RAM_PlayerState).w	; $13EC
	beq.b *+$8	; $13F2
	movea.l (RAM_PlayerEnterHandler).w, A0	; $13F4
	jmp (A0)	; $13F8
loc_13FA:
	btst.b #$3, (RAM_PlayerState).w	; $13FA

