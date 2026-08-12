; ======================================================================
; src/scene/scene_load.asm
; Scene load system: flagged-table loader, tile/map decompressors, loader data
; Covers ROM $006A58-$007000.
; ======================================================================

	rts	; $6A58
	unlk A6	; $6A5A
	rts	; $6A5C
	moveq #$0, D0	; $6A5E
	move.b (A2)+, D0	; $6A60
	add.w (-$10,A6), D0	; $6A62
	move.w (RAM_ScrollY).w, D1	; $6A66
	subq.w #$1, D1	; $6A6A
	and.w D1, D0	; $6A6C
	move.w D0, (-$6,A6)	; $6A6E
	move.w D0, (-$2,A6)	; $6A72
	moveq #$0, D1	; $6A76
	move.b (A2)+, D1	; $6A78
	add.w (-$12,A6), D1	; $6A7A
	move.w (RAM_ScrollX).w, D2	; $6A7E
	subq.w #$1, D2	; $6A82
	and.w D2, D1	; $6A84
	move.w D1, (-$8,A6)	; $6A86
	move.w D1, (-$4,A6)	; $6A8A
	bsr.b *+$E	; $6A8E
	jsr $5A0.w	; $6A90
	lea ($C00000).l, A1	; $6A94
	rts	; $6A9A
	jsr $5CA.w	; $6A9C
	add.w (-$E,A6), D0	; $6AA0
	rts	; $6AA4
	move.b (A2)+, D7	; $6AA6
	asl.w #$8, D7	; $6AA8
	rts	; $6AAA
	moveq #$0, D3	; $6AAC
	move.b (A2)+, D3	; $6AAE
	move.b (A2)+, D7	; $6AB0
	bsr.w *+$B2	; $6AB2
	subq.w #$1, D3	; $6AB6
	bpl.b *-$6	; $6AB8
	rts	; $6ABA
	moveq #$0, D3	; $6ABC
	move.b (A2)+, D3	; $6ABE
	move.b (A2)+, D7	; $6AC0
	bsr.w *+$1E	; $6AC2
	rts	; $6AC6
	moveq #$0, D4	; $6AC8
	move.b (A2)+, D4	; $6ACA
	moveq #$0, D3	; $6ACC
	move.b (A2), D3	; $6ACE
	move.b ($1,A2), D7	; $6AD0
	bsr.w *+$C	; $6AD4
	subq.w #$1, D4	; $6AD8
	bpl.b *-$E	; $6ADA
	addq.w #$2, A2	; $6ADC
	rts	; $6ADE
	bsr.w *+$84	; $6AE0
	addq.b #$1, D7	; $6AE4
	subq.w #$1, D3	; $6AE6
	bpl.b *-$8	; $6AE8
	rts	; $6AEA
	moveq #$0, D3	; $6AEC
	move.b (A2)+, D3	; $6AEE
	move.b (A2), D7	; $6AF0
	bsr.w *+$72	; $6AF2
	addq.b #$1, D7	; $6AF6
	bsr.w *+$6C	; $6AF8
	addq.b #$1, D7	; $6AFC
	subq.w #$1, D3	; $6AFE
	bpl.b *-$10	; $6B00
	addq.w #$1, A2	; $6B02
	rts	; $6B04
	move.b (A2)+, D7	; $6B06
	bsr.w *+$5C	; $6B08
	rts	; $6B0C
	rts	; $6B0E
	move.b (A2)+, D0	; $6B10
	move.b D0, (-$A,A6)	; $6B12
	move.b D0, (-$C,A6)	; $6B16
	rts	; $6B1A
	moveq #$0, D3	; $6B1C
	move.b (A2)+, D3	; $6B1E
	swap D7	; $6B20
	clr.w D7	; $6B22
	bsr.w *+$40	; $6B24
	subq.w #$1, D3	; $6B28
	bpl.b *-$6	; $6B2A
	swap D7	; $6B2C
	rts	; $6B2E
	rts	; $6B30
	move.b (A2)+, (RAM_word_FFFF8C76).w	; $6B32
	bra.w *-$144	; $6B36
	move.w (-$6,A6), D0	; $6B3A
	move.w (-$4,A6), D1	; $6B3E
	addq.w #$1, D1	; $6B42
	cmp.w (RAM_ScrollX).w, D1	; $6B44
	bcs.b *+$4	; $6B48
	moveq #$0, D1	; $6B4A
	move.w D1, (-$4,A6)	; $6B4C
	move.w D0, (-$2,A6)	; $6B50
	bsr.w *-$B8	; $6B54
	jsr $5A0.w	; $6B58
	lea ($C00000).l, A1	; $6B5C
	rts	; $6B62
	move.w D7, (A1)	; $6B64
	dc.b	$53,$2E,$FF,$F4	; $6B66
	bpl.b *+$A	; $6B6A
	move.b (-$A,A6), (-$C,A6)	; $6B6C
	bra.b *-$38	; $6B72
	move.w (-$2,A6), D0	; $6B74
	addq.w #$1, D0	; $6B78
	cmp.w (RAM_ScrollY).w, D0	; $6B7A
	bcc.b *+$8	; $6B7E
	move.w D0, (-$2,A6)	; $6B80
	rts	; $6B84
	moveq #$0, D0	; $6B86
	move.w D0, (-$2,A6)	; $6B88
	move.w (-$4,A6), D1	; $6B8C
	bsr.w *-$F4	; $6B90
	jsr $5A0.w	; $6B94
	lea ($C00000).l, A1	; $6B98
	rts	; $6B9E
	lea (-$71F8).w, A0	; $6BA0
	moveq #$3F, D0	; $6BA4
	dc.b	$72,$FF	; $6BA6
	move.l D1, (A0)+	; $6BA8
	dbf D0, $6BA8	; $6BAA
	lea (-$6AF4).l, A0	; $6BAE
	moveq #$7, D0	; $6BB4
	moveq #$0, D1	; $6BB6
	move.w D1, (A0)	; $6BB8
	lea ($10,A0), A0	; $6BBA
	dbf D0, $6BB8	; $6BBE
	rts	; $6BC2

; ----------------------------------------------------------------------
; LoadFlaggedData: resolves flag index D0 in the flagged table (ROM_FlaggedTable,
; 4-byte [tag][addr24] records) and loads the data into (A1): bit 18 = direct
; 0x200-long copy, bit 19 = tile-stream decompress, else map decode.
; ----------------------------------------------------------------------
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

; ----------------------------------------------------------------------
; DecompressTiles: decompresses a tag-$00 4bpp tile stream (RLE/planar) into
; 32-byte tile rows.
; ----------------------------------------------------------------------
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

; ----------------------------------------------------------------------
; DecodeMap: tree+LZSS decompresses a 32x32 tilemap (tag-$02 record) into the
; destination buffer. Map values are tile-block indices.
; ----------------------------------------------------------------------
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

	dc.b	$4e,$75,$4d,$78	; $6EA6
	dc.b	$63,$67	; $6EAA
	dc.b	$2b,$7c,$00,$00,$6b,$ae,$00,$08	; $6EAC
	dc.b	$3b,$78,$8f,$08,$00,$40	; $6EB4
	dc.b	$60,$42	; $6EBA
	dc.b	$4e,$b8,$04,$00	; $6EBC
	dc.b	$4a,$38,$95,$0a	; $6EC0
	dc.b	$66,$f6	; $6EC4
	dc.b	$52,$78,$8f,$08	; $6EC6
	dc.b	$30,$38,$8f,$08	; $6ECA
	dc.b	$32,$00	; $6ECE
	dc.b	$92,$6d,$00,$40	; $6ED0
	dc.b	$3b,$40,$00,$40	; $6ED4
	dc.b	$41,$f8,$95,$0c	; $6ED8
	dc.b	$74,$00	; $6EDC
	dc.b	$70,$07	; $6EDE
	dc.b	$4a,$50	; $6EE0
	dc.b	$6a,$06	; $6EE2
	dc.b	$93,$68,$00,$02	; $6EE4
	dc.b	$52,$02	; $6EE8
	dc.b	$41,$e8,$00,$10	; $6EEA
	dc.b	$51,$c8,$ff,$f0	; $6EEE
	dc.b	$4a,$42	; $6EF2
	dc.b	$66,$08	; $6EF4
	dc.b	$2b,$42,$00,$08	; $6EF6
	dc.b	$4e,$f8,$04,$e6	; $6EFA
	dc.b	$41,$f8,$95,$0c	; $6EFE
	dc.b	$1b,$7c,$00,$08,$00,$42	; $6F02
	dc.b	$3b,$48,$00,$44	; $6F08
	dc.b	$4e,$b8,$04,$0c	; $6F0C
	dc.b	$30,$6d,$00,$44	; $6F10
	dc.b	$4a,$50	; $6F14
	dc.b	$6b,$0c	; $6F16
	dc.b	$41,$e8,$00,$10	; $6F18
	dc.b	$53,$2d,$00,$42	; $6F1C
	dc.b	$66,$f2	; $6F20
	dc.b	$60,$98	; $6F22
	dc.b	$4a,$68,$00,$02	; $6F24
	dc.b	$67,$02	; $6F28
	dc.b	$6a,$ec	; $6F2A
	dc.b	$22,$68,$00,$0c	; $6F2C
	dc.b	$30,$19	; $6F30
	dc.b	$66,$04	; $6F32
	dc.b	$30,$80	; $6F34
	dc.b	$60,$e0	; $6F36
	dc.b	$6a,$1c	; $6F38
	dc.b	$d0,$40	; $6F3A
	dc.b	$66,$06	; $6F3C
	dc.b	$22,$68,$00,$08	; $6F3E
	dc.b	$60,$ec	; $6F42
	dc.b	$32,$19	; $6F44
	dc.b	$55,$40	; $6F46
	dc.b	$66,$06	; $6F48
	dc.b	$08,$90,$00,$00	; $6F4A
	dc.b	$66,$e0	; $6F4E
	dc.b	$43,$f1,$10,$fe	; $6F50
	dc.b	$60,$da	; $6F54
	dc.b	$34,$00	; $6F56
	dc.b	$02,$42,$7f,$00	; $6F58
	dc.b	$ea,$4a	; $6F5C
	dc.b	$02,$40,$00,$ff	; $6F5E
	dc.b	$d1,$68,$00,$02	; $6F62
	dc.b	$32,$19	; $6F66
	dc.b	$21,$49,$00,$0c	; $6F68
	dc.b	$34,$48	; $6F6C
	dc.b	$30,$28,$00,$04	; $6F6E
	dc.b	$4e,$b8,$22,$a8	; $6F72
	dc.b	$41,$ea,$00,$10	; $6F76
	dc.b	$53,$2d,$00,$42	; $6F7A
	dc.b	$66,$00,$ff,$88	; $6F7E
	dc.b	$60,$00,$ff,$38,$4b,$73	; $6F82
	dc.b	$65,$67	; $6F88
	dc.b	$61,$00,$e1,$fc	; $6F8A
	dc.b	$41,$fa,$00,$8c	; $6F8E
	dc.b	$4e,$b8,$23,$4c	; $6F92
	dc.b	$4e,$b8,$22,$f0	; $6F96
	dc.b	$41,$fa,$00,$7c	; $6F9A
	dc.b	$4e,$b8,$13,$5c	; $6F9E
	dc.b	$42,$78,$8b,$56	; $6FA2
	dc.b	$61,$00,$e6,$32	; $6FA6
	dc.b	$70,$18	; $6FAA
	dc.b	$61,$00,$e6,$aa	; $6FAC
	dc.b	$4e,$b8,$04,$00	; $6FB0
	dc.b	$11,$fc,$00,$02,$8c,$76	; $6FB4
	dc.b	$45,$fa,$00,$68	; $6FBA
	dc.b	$61,$00,$f9,$ee	; $6FBE
	dc.b	$61,$00,$e8,$56	; $6FC2
	dc.b	$4e,$b8,$04,$00	; $6FC6
	dc.b	$08,$38,$00,$04,$8c,$56	; $6FCA
	dc.b	$66,$02	; $6FD0
	dc.b	$4e,$75	; $6FD2
	dc.b	$3b,$7c,$00,$1e,$00,$40	; $6FD4
	dc.b	$4e,$b8,$04,$00	; $6FDA
	dc.b	$53,$6d,$00,$40	; $6FDE
	dc.b	$66,$f6	; $6FE2
	dc.b	$3b,$7c,$00,$b4,$00,$40	; $6FE4
	dc.b	$70,$1c	; $6FEA
	dc.b	$61,$00,$e6,$6a	; $6FEC
	dc.b	$4e,$b8,$04,$00	; $6FF0
	dc.b	$53,$6d,$00,$40	; $6FF4
	dc.b	$67,$02	; $6FF8
	dc.b	$4e,$75	; $6FFA
	dc.b	$61,$00,$e8,$44	; $6FFC

