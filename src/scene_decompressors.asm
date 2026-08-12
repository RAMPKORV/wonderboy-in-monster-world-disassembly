; ======================================================================
; src/scene_decompressors.asm - LoadFlaggedData, tile decompressor, map decoder
; Hand-converted, addresses verified against the ROM. Bit-exact.
; ======================================================================
LoadFlaggedData:
	lsl.w #$2, D0	; $6BC4
	movea.w D0, A0	; $6BC6
	adda.l #$41000, A0	; $6BC8
	move.l (A0), D0	; $6BCE
	bpl.b *+$10	; $6BD0
	move.w #$FF, D1	; $6BD2
	moveq #$0, D0	; $6BD6
	move.l D0, (A1)+	; $6BD8
	dbf D1, $6BD8	; $6BDA
	rts	; $6BDE
	bclr.l #$18, D0	; $6BE0
	beq.b *+$10	; $6BE4
	movea.l D0, A0	; $6BE6
	move.w #$FF, D1	; $6BE8
	move.l (A0)+, (A1)+	; $6BEC
	dbf D1, $6BEC	; $6BEE
	rts	; $6BF2
	bclr.l #$19, D0	; $6BF4
	bne.w *+$1A4	; $6BF8

DecompressTiles:
	movea.l D0, A0	; $6BFC
	moveq #$1F, D7	; $6BFE
	move.b (A0)+, D0	; $6C00
	bne.b *+$10	; $6C02
	moveq #$1F, D0	; $6C04
	move.b (A0)+, (A1)+	; $6C06
	dbf D0, $6C06	; $6C08
	dbf D7, $6C00	; $6C0C
	rts	; $6C10
	bmi.b *+$44	; $6C12
	ext.w D0	; $6C14
	subq.b #$1, D0	; $6C16
	moveq #$0, D3	; $6C18
	move.b (A0)+, D1	; $6C1A
	move.b (A0)+, D2	; $6C1C
	lsl.w #$8, D2	; $6C1E
	move.b (A0)+, D2	; $6C20
	swap D2	; $6C22
	move.b (A0)+, D2	; $6C24
	lsl.w #$8, D2	; $6C26
	move.b (A0)+, D2	; $6C28
	or.l D2, D3	; $6C2A
	movea.l A1, A2	; $6C2C
	add.l D2, D2	; $6C2E
	bcc.b *+$4	; $6C30
	move.b D1, (A2)	; $6C32
	addq.l #$1, A2	; $6C34
	tst.l D2	; $6C36
	bne.b *-$A	; $6C38
	dbf D0, $6C1A	; $6C3A
	not.l D3	; $6C3E
	movea.l A1, A2	; $6C40
	add.l D3, D3	; $6C42
	bcc.b *+$4	; $6C44
	move.b (A0)+, (A2)	; $6C46
	addq.l #$1, A2	; $6C48
	tst.l D3	; $6C4A
	bne.b *-$A	; $6C4C
	adda.l #$20, A1	; $6C4E
	bra.b *-$48	; $6C54
	move.b (A0)+, D1	; $6C56
	moveq #$3, D6	; $6C58
	lea (-$7218).w, A2	; $6C5A
	movea.l A2, A3	; $6C5E
	lsr.b #$1, D1	; $6C60
	scs D2	; $6C62
	lsr.b #$1, D1	; $6C64
	bcc.b *+$C	; $6C66
	ext.w D2	; $6C68
	ext.l D2	; $6C6A
	move.l D2, (A3)+	; $6C6C
	move.l D2, (A3)+	; $6C6E
	bra.b *+$14	; $6C70
	move.b (A0)+, D3	; $6C72
	moveq #$7, D4	; $6C74
	move.b D2, D5	; $6C76
	lsr.b #$1, D3	; $6C78
	bcc.b *+$4	; $6C7A
	move.b (A0)+, D5	; $6C7C
	move.b D5, (A3)+	; $6C7E
	dbf D4, $6C76	; $6C80
	lsr.b #$1, D0	; $6C84
	bcc.b *+$12	; $6C86
	subq.l #$8, A3	; $6C88
	move.b (A3)+, D4	; $6C8A
	moveq #$6, D2	; $6C8C
	move.b (A3), D3	; $6C8E
	eor.b D3, D4	; $6C90
	move.b D4, (A3)+	; $6C92
	dbf D2, $6C8E	; $6C94
	dbf D6, $6C60	; $6C98
	moveq #$7, D0	; $6C9C
	move.b (A2)+, D2	; $6C9E
	move.b D2, D3	; $6CA0
	lsr.w #$3, D3	; $6CA2
	andi.w #$1E, D3	; $6CA4
	move.w ($6D1C,PC,D3.w), D1	; $6CA8
	swap D1	; $6CAC
	andi.w #$F, D2	; $6CAE
	add.w D2, D2	; $6CB2
	move.w ($6D1C,PC,D2.w), D1	; $6CB4
	swap D1	; $6CB8
	move.b ($7,A2), D2	; $6CBA
	move.b D2, D3	; $6CBE
	lsr.w #$3, D3	; $6CC0
	andi.w #$1E, D3	; $6CC2
	or.w ($6D3C,PC,D3.w), D1	; $6CC6
	swap D1	; $6CCA
	andi.w #$F, D2	; $6CCC
	add.w D2, D2	; $6CD0
	or.w ($6D3C,PC,D2.w), D1	; $6CD2
	swap D1	; $6CD6
	move.b ($F,A2), D2	; $6CD8
	move.b D2, D3	; $6CDC
	lsr.w #$3, D3	; $6CDE
	andi.w #$1E, D3	; $6CE0
	or.w ($6D5C,PC,D3.w), D1	; $6CE4
	swap D1	; $6CE8
	andi.w #$F, D2	; $6CEA
	add.w D2, D2	; $6CEE
	or.w ($6D5C,PC,D2.w), D1	; $6CF0
	swap D1	; $6CF4
	move.b ($17,A2), D2	; $6CF6
	move.b D2, D3	; $6CFA
	lsr.w #$3, D3	; $6CFC
	andi.w #$1E, D3	; $6CFE
	or.w ($6D7C,PC,D3.w), D1	; $6D02
	swap D1	; $6D06
	andi.w #$F, D2	; $6D08
	add.w D2, D2	; $6D0C
	or.w ($6D7C,PC,D2.w), D1	; $6D0E
	move.l D1, (A1)+	; $6D12
	dbf D0, $6C9E	; $6D14
	bra.w *-$10C	; $6D18

DecodeMap:
; $6D1C TileBitSpreadTables
	dc.b	$00,$00,$00,$01,$00,$10,$00,$11,$01,$00,$01,$01,$01,$10,$01,$11	; $6D1C
	dc.b	$10,$00,$10,$01,$10,$10,$10,$11,$11,$00,$11,$01,$11,$10,$11,$11	; $6D2C
	dc.b	$00,$00,$00,$02,$00,$20,$00,$22,$02,$00,$02,$02,$02,$20,$02,$22	; $6D3C
	dc.b	$20,$00,$20,$02,$20,$20,$20,$22,$22,$00,$22,$02,$22,$20,$22,$22	; $6D4C
	dc.b	$00,$00,$00,$04,$00,$40,$00,$44,$04,$00,$04,$04,$04,$40,$04,$44	; $6D5C
	dc.b	$40,$00,$40,$04,$40,$40,$40,$44,$44,$00,$44,$04,$44,$40,$44,$44	; $6D6C
	dc.b	$00,$00,$00,$08,$00,$80,$00,$88,$08,$00,$08,$08,$08,$80,$08,$88	; $6D7C
	dc.b	$80,$00,$80,$08,$80,$80,$80,$88,$88,$00,$88,$08,$88,$80,$88,$88	; $6D8C
	movea.l D0, A0	; $6D9C
	move.b (A0)+, D0	; $6D9E
	add.b D0, D0	; $6DA0
	moveq #$7, D1	; $6DA2
	move.w #-$70F6, D3	; $6DA4
	movea.w D3, A2	; $6DA8
	movea.l A1, A3	; $6DAA
	moveq #$0, D2	; $6DAC
	moveq #$0, D4	; $6DAE
	dbf D1, $6DB8	; $6DB0
	move.b (A0)+, D0	; $6DB4
	moveq #$7, D1	; $6DB6
	add.b D0, D0	; $6DB8
	bcc.b *+$1A	; $6DBA
	addq.w #$4, D3	; $6DBC
	tst.w D2	; $6DBE
	bne.b *+$A	; $6DC0
	move.w A2, (A3)+	; $6DC2
	addq.w #$1, D4	; $6DC4
	move.w D3, (A2)	; $6DC6
	bra.b *+$8	; $6DC8
	move.w D3, ($2,A2)	; $6DCA
	moveq #$0, D2	; $6DCE
	movea.w D3, A2	; $6DD0
	bra.b *-$22	; $6DD2
	bsr.b *+$7A	; $6DD4
	tst.w D2	; $6DD6
	bne.b *+$8	; $6DD8
	move.w D7, (A2)	; $6DDA
	moveq #$2, D2	; $6DDC
	bra.b *-$2E	; $6DDE
	move.w D7, ($2,A2)	; $6DE0
	movea.w -(A3), A2	; $6DE4
	dbf D4, $6DB0	; $6DE6
	move.w #$3FF, D2	; $6DEA
	bsr.b *+$40	; $6DEE
	cmpi.w #$100, D7	; $6DF0
	bcs.b *+$32	; $6DF4
	move.w D7, D3	; $6DF6
	subi.w #$FD, D3	; $6DF8
	sub.w D3, D2	; $6DFC
	bsr.b *+$30	; $6DFE
	neg.w D7	; $6E00
	lea (-$1,A1,D7.w), A2	; $6E02
	bra.b *+$C	; $6E06
	move.b (A2)+, (A1)+	; $6E08
	move.b (A2)+, (A1)+	; $6E0A
	move.b (A2)+, (A1)+	; $6E0C
	move.b (A2)+, (A1)+	; $6E0E
	move.b (A2)+, (A1)+	; $6E10
	subq.w #$5, D3	; $6E12
	bcc.b *-$C	; $6E14
	addq.w #$4, D3	; $6E16
	bmi.b *+$8	; $6E18
	move.b (A2)+, (A1)+	; $6E1A
	dbf D3, $6E1A	; $6E1C
	tst.w D2	; $6E20
	bpl.b *-$34	; $6E22
	rts	; $6E24
	move.b D7, (A1)+	; $6E26
	dbf D2, $6DEE	; $6E28
	rts	; $6E2C
	lea (-$70F6).w, A2	; $6E2E
	dbf D1, $6E3A	; $6E32
	move.b (A0)+, D0	; $6E36
	moveq #$7, D1	; $6E38
	add.b D0, D0	; $6E3A
	bcc.b *+$4	; $6E3C
	addq.w #$2, A2	; $6E3E
	move.w (A2), D7	; $6E40
	bpl.b *+$6	; $6E42
	movea.w D7, A2	; $6E44
	bra.b *-$14	; $6E46
	cmpi.w #$11F, D7	; $6E48
	bne.b *+$16	; $6E4C
	dbf D1, $6E56	; $6E4E
	move.b (A0)+, D0	; $6E52
	moveq #$7, D1	; $6E54
	add.b D0, D0	; $6E56
	bcs.b *+$1E	; $6E58
	moveq #$0, D7	; $6E5A
	tst.b D1	; $6E5C
	bne.b *+$6	; $6E5E
	move.b (A0)+, D7	; $6E60
	rts	; $6E62
	move.b D0, D7	; $6E64
	move.b (A0)+, D0	; $6E66
	move.b D0, D6	; $6E68
	lsr.b D1, D6	; $6E6A
	or.b D6, D7	; $6E6C
	moveq #$8, D6	; $6E6E
	sub.b D1, D6	; $6E70
	lsl.b D6, D0	; $6E72
	rts	; $6E74
	move.w #$100, D7	; $6E76
	tst.b D1	; $6E7A
	bne.b *+$E	; $6E7C
	move.b (A0)+, D0	; $6E7E
	move.b D0, D7	; $6E80
	lsr.b #$3, D7	; $6E82
	lsl.b #$5, D0	; $6E84
	moveq #$3, D1	; $6E86
	rts	; $6E88
	move.b D0, D7	; $6E8A
	lsr.b #$3, D7	; $6E8C
	subq.b #$5, D1	; $6E8E
	bcs.b *+$6	; $6E90
	lsl.b #$5, D0	; $6E92
	rts	; $6E94
	addq.b #$8, D1	; $6E96
	move.b (A0)+, D0	; $6E98
	move.b D0, D6	; $6E9A
	lsr.b D1, D6	; $6E9C
	or.b D6, D7	; $6E9E
	moveq #$8, D6	; $6EA0
	sub.b D1, D6	; $6EA2
	lsl.b D6, D0	; $6EA4
