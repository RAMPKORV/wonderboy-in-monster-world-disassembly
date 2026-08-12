; ======================================================================
; src/gamebank0.asm ($A000-$C000)
; ======================================================================
	addq.w #$1, D0	; $A000
	move.w D0, (A1)+	; $A002
	addi.w #$F, D0	; $A004
	move.w D0, (A1)+	; $A008
	addq.w #$1, D0	; $A00A
	move.w D0, (A1)+	; $A00C
	bra.b *+$54	; $A00E
	subq.b #$1, D1	; $A010
	bne.b *+$10	; $A012
	move.b (A2)+, D0	; $A014
	move.w D0, (A1)+	; $A016
	move.b (A2)+, D0	; $A018
	move.w D0, (A1)+	; $A01A
	move.b (A2)+, D0	; $A01C
	move.w D0, (A1)+	; $A01E
	bra.b *+$42	; $A020
	andi.w #-$1820, D0	; $A022
	move.b (A2)+, D1	; $A026
	move.b D1, D2	; $A028
	andi.w #$1F, D2	; $A02A
	or.w D0, D2	; $A02E
	andi.w #$C0, D1	; $A030
	lsl.w #$5, D1	; $A034
	or.w D2, D1	; $A036
	move.w D1, (A1)+	; $A038
	move.b (A2)+, D1	; $A03A
	move.b D1, D2	; $A03C
	andi.w #$1F, D2	; $A03E
	or.w D0, D2	; $A042
	andi.w #$C0, D1	; $A044
	lsl.w #$5, D1	; $A048
	or.w D2, D1	; $A04A
	move.w D1, (A1)+	; $A04C
	move.b (A2)+, D1	; $A04E
	move.b D1, D2	; $A050
	andi.w #$1F, D2	; $A052
	or.w D0, D2	; $A056
	andi.w #$C0, D1	; $A058
	lsl.w #$5, D1	; $A05C
	or.w D2, D1	; $A05E
	move.w D1, (A1)+	; $A060
	dbf D4, $9F82	; $A062
	rts	; $A066
	move.w A3, -(SP)	; $A068
	dc.b	$4E,$56,$FF,$F6	; $A06A
	move.b (A3), D0	; $A06E
	andi.w #$1, D0	; $A070
	lsl.w #$4, D0	; $A074
	move.b D0, (-$A,A6)	; $A076
	movea.w ($22,A3), A0	; $A07A
	move.w A0, (-$6,A6)	; $A07E
	moveq #$F, D1	; $A082
	dc.b	$70,$FF	; $A084
	move.l D0, (A0)+	; $A086
	dbf D1, $A086	; $A088
	movea.l ($34,A3), A4	; $A08C
	movea.l ($1C,A3), A1	; $A090
	move.l A3, -(SP)	; $A094
	bsr.w *-$132	; $A096
	movea.l (SP)+, A3	; $A09A
	move.w ($2,A4), D0	; $A09C
	lea ($0,A4,D0.w), A3	; $A0A0
	lea ($4,A4), A2	; $A0A4
	move.b (A2)+, D0	; $A0A8
	bpl.b *+$8	; $A0AA
	unlk A6	; $A0AC
	movea.w (SP)+, A3	; $A0AE
	rts	; $A0B0
	ext.w D0	; $A0B2
	movea.w D0, A0	; $A0B4
	adda.w (-$6,A6), A0	; $A0B6
	moveq #$0, D0	; $A0BA
	move.b (-$A,A6), D0	; $A0BC
	move.b D0, (A0)	; $A0C0
	add.w D0, D0	; $A0C2
	add.b (-$A,A6), D0	; $A0C4
	dc.b	$52,$2E,$FF,$F6	; $A0C8
	lsl.w #$7, D0	; $A0CC
	addi.l #RAM_word_FF5000, D0	; $A0CE
	move.l D0, (-$4,A6)	; $A0D4
	lea (-$68F4).w, A0	; $A0D8
	moveq #$0, D0	; $A0DC
	moveq #$5, D1	; $A0DE
	move.l D0, (A0)+	; $A0E0
	dbf D1, $A0E0	; $A0E2
	moveq #$0, D0	; $A0E6
	move.b (A2)+, D0	; $A0E8
	move.l A2, -(SP)	; $A0EA
	move.w ($0,A3,D0.w), D0	; $A0EC
	lea ($0,A4,D0.w), A2	; $A0F0
	dc.b	$7A,$C0	; $A0F4
	move.b (A2)+, (-$8,A6)	; $A0F6
	beq.w *+$58	; $A0FA
	bpl.b *+$E	; $A0FE
	bsr.w *+$C4	; $A100
	bra.b *-$10	; $A104
	tst.b D5	; $A106
	beq.w *+$9C	; $A108
	movea.l (-$4,A6), A1	; $A10C
	move.b (A2)+, D2	; $A110
	lsl.w #$8, D2	; $A112
	move.b (A2)+, D2	; $A114
	move.w #$17, D4	; $A116
	lea (-$68F4).w, A0	; $A11A
	moveq #$1, D0	; $A11E
	moveq #$0, D1	; $A120
	btst.b D1, (A0)	; $A122
	bne.b *+$14	; $A124
	subq.b #$1, D0	; $A126
	bne.b *+$6	; $A128
	moveq #$8, D0	; $A12A
	move.b (A2)+, D3	; $A12C
	lsr.b #$1, D3	; $A12E
	bcc.b *+$8	; $A130
	move.w D2, (A1)	; $A132
	bset.b D1, (A0)	; $A134
	subq.b #$1, D5	; $A136
	addq.l #$2, A1	; $A138
	addq.b #$1, D1	; $A13A
	bclr.l #$3, D1	; $A13C
	beq.b *-$1E	; $A140
	addq.l #$1, A0	; $A142
	dbf D4, $A122	; $A144
	dc.b	$53,$2E,$FF,$F8	; $A148
	bne.b *-$46	; $A14C
	tst.b D5	; $A14E
	beq.b *+$6E	; $A150
	moveq #$0, D3	; $A152
	moveq #$0, D4	; $A154
	lea (-$68F4).w, A0	; $A156
	movea.l (-$4,A6), A1	; $A15A
	btst.b D3, (A0)	; $A15E
	bne.b *+$50	; $A160
	dc.b	$4E,$FB,$40,$02	; $A162
	bra.b *+$12	; $A166
	bra.b *+$20	; $A168
	bra.b *+$2C	; $A16A
	move.b (A2)+, D0	; $A16C
	lsl.w #$8, D0	; $A16E
	andi.w #$300, D0	; $A170
	move.b (A2)+, D0	; $A174
	bra.b *+$2E	; $A176
	moveq #$0, D0	; $A178
	move.b (A2)+, D0	; $A17A
	move.b (A2)+, D1	; $A17C
	lsl.b #$1, D1	; $A17E
	roxl.w #$1, D0	; $A180
	lsl.b #$1, D1	; $A182
	roxl.w #$1, D0	; $A184
	bra.b *+$1E	; $A186
	moveq #$0, D0	; $A188
	move.b D1, D0	; $A18A
	lsl.w #$2, D0	; $A18C
	move.b (A2), D1	; $A18E
	lsr.b #$4, D1	; $A190
	or.b D1, D0	; $A192
	bra.b *+$10	; $A194
	moveq #$0, D0	; $A196
	move.b (A2)+, D0	; $A198
	lsl.b #$4, D0	; $A19A
	lsl.w #$2, D0	; $A19C
	move.b (A2), D1	; $A19E
	lsr.b #$2, D1	; $A1A0
	or.b D1, D0	; $A1A2
	move.w D0, (A1)	; $A1A4
	addq.w #$2, D4	; $A1A6
	andi.w #$6, D4	; $A1A8
	subq.b #$1, D5	; $A1AC
	beq.b *+$10	; $A1AE
	addq.l #$2, A1	; $A1B0
	addq.b #$1, D3	; $A1B2
	bclr.l #$3, D3	; $A1B4
	beq.b *-$5A	; $A1B8
	addq.l #$1, A0	; $A1BA
	bra.b *-$5E	; $A1BC
	movea.l (SP)+, A2	; $A1BE
	bra.w *-$118	; $A1C0
	lea (-$679E).w, A1	; $A1C4
	moveq #$0, D1	; $A1C8
	move.b (A2)+, D1	; $A1CA
	moveq #$0, D2	; $A1CC
	move.b (A2)+, D2	; $A1CE
	movea.l A2, A0	; $A1D0
	adda.w D2, A0	; $A1D2
	bra.b *+$18	; $A1D4
	moveq #$7, D0	; $A1D6
	move.b (A2)+, D3	; $A1D8
	moveq #$0, D4	; $A1DA
	add.b D3, D3	; $A1DC
	bcs.b *+$4	; $A1DE
	move.b (A0)+, D4	; $A1E0
	move.b D4, (A1)+	; $A1E2
	subq.w #$1, D1	; $A1E4
	beq.b *+$12	; $A1E6
	dbf D0, $A1DA	; $A1E8
	dbf D2, $A1D6	; $A1EC
	bra.b *+$4	; $A1F0
	move.b (A0)+, (A1)+	; $A1F2
	dbf D1, $A1F2	; $A1F4
	lea (-$679E).w, A2	; $A1F8
	rts	; $A1FC
	dc.b	$4E,$56,$FF,$FC	; $A1FE
	lea (-$68AC).w, A3	; $A202
	lea (RAM_long_FF3100).l, A1	; $A206
	move.w (RAM_word_FFFF974E).w, D7	; $A20C
	move.w (RAM_word_FFFF9752).w, (-$4,A6)	; $A210
	move.w (RAM_word_FFFF974C).w, D6	; $A216
	move.w (RAM_word_FFFF9750).w, (-$2,A6)	; $A21A
	jsr $260A.w	; $A220
	move.w (A0), (A1)+	; $A224
	addq.w #$1, D6	; $A226
	dc.b	$53,$6E,$FF,$FE	; $A228
	bne.b *-$C	; $A22C
	addi.w #$40, D7	; $A22E
	dc.b	$53,$6E,$FF,$FC	; $A232
	bne.b *-$20	; $A236
	unlk A6	; $A238
	rts	; $A23A
	dc.b	$4E,$56,$FF,$FC	; $A23C
	lea (-$68AC).w, A3	; $A240
	move.w (RAM_word_FFFF974E).w, D7	; $A244
	move.w (RAM_word_FFFF9752).w, (-$4,A6)	; $A248
	move.w (RAM_word_FFFF974C).w, D6	; $A24E
	move.w (RAM_word_FFFF9750).w, (-$2,A6)	; $A252
	jsr $260A.w	; $A258
	ori.w #-$8000, (A0)	; $A25C
	addq.w #$1, D6	; $A260
	dc.b	$53,$6E,$FF,$FE	; $A262
	bne.b *-$E	; $A266
	addi.w #$40, D7	; $A268
	dc.b	$53,$6E,$FF,$FC	; $A26C
	bne.b *-$22	; $A270
	unlk A6	; $A272
	rts	; $A274
	dc.b	$4E,$56,$FF,$FC	; $A276
	lea (RAM_long_FF3100).l, A1	; $A27A
	lea (-$68AC).w, A3	; $A280
	move.w (RAM_word_FFFF974E).w, D7	; $A284
	move.w (RAM_word_FFFF9752).w, (-$4,A6)	; $A288
	move.w (RAM_word_FFFF974C).w, D6	; $A28E
	move.w (RAM_word_FFFF9750).w, (-$2,A6)	; $A292
	jsr $260A.w	; $A298
	move.w (A1)+, (A0)	; $A29C
	addq.w #$1, D6	; $A29E
	dc.b	$53,$6E,$FF,$FE	; $A2A0
	bne.b *-$C	; $A2A4
	addi.w #$40, D7	; $A2A6
	dc.b	$53,$6E,$FF,$FC	; $A2AA
	bne.b *-$20	; $A2AE
	unlk A6	; $A2B0
	rts	; $A2B2
	dc.b	$4E,$56,$FF,$FC	; $A2B4
	lea (-$68AC).w, A3	; $A2B8
	move.w (RAM_word_FFFF974E).w, D7	; $A2BC
	move.w (RAM_word_FFFF9752).w, (-$4,A6)	; $A2C0
	move.w (RAM_word_FFFF974C).w, D6	; $A2C6
	move.w (RAM_word_FFFF9750).w, (-$2,A6)	; $A2CA
	jsr $2542.w	; $A2D0
	jsr $2672.w	; $A2D4
	addq.w #$1, D6	; $A2D8
	dc.b	$53,$6E,$FF,$FE	; $A2DA
	bne.b *-$E	; $A2DE
	addi.w #$40, D7	; $A2E0
	dc.b	$53,$6E,$FF,$FC	; $A2E4
	bne.b *-$22	; $A2E8
	unlk A6	; $A2EA
	rts	; $A2EC
	dc.b	$4E,$56,$FF,$F2	; $A2EE
	lsl.l #$2, D3	; $A2F2
	lsr.w #$2, D3	; $A2F4
	ori.w #$4000, D3	; $A2F6
	move.w D3, (-$E,A6)	; $A2FA
	swap D3	; $A2FE
	andi.w #$3, D3	; $A300
	move.w D3, (-$A,A6)	; $A304
	move.w D4, (-$2,A6)	; $A308
	move.w D5, (-$6,A6)	; $A30C
	move.w D6, (-$8,A6)	; $A310
	lsl.w #$6, D7	; $A314
	lea ($C00000).l, A2	; $A316
	move.w (-$2,A6), (-$4,A6)	; $A31C
	move.w (-$E,A6), (-$C,A6)	; $A322
	move.w (-$8,A6), D6	; $A328
	move.w D6, D2	; $A32C
	move.w D7, D3	; $A32E
	jsr $2570.w	; $A330
	move.w D0, D2	; $A334
	moveq #$0, D1	; $A336
	move.b D0, D1	; $A338
	andi.w #$300, D0	; $A33A
	lsr.w #$6, D0	; $A33E
	movea.l ($10,A3,D0.w), A0	; $A340
	lsl.w #$3, D1	; $A344
	adda.w D1, A0	; $A346
	move.l (-$C,A6), D0	; $A348
	move.l D0, ($4,A2)	; $A34C
	move.l (A0)+, (A2)	; $A350
	addi.l #$800000, D0	; $A352
	move.l D0, ($4,A2)	; $A358
	move.l (A0), (A2)	; $A35C
	addq.w #$1, D6	; $A35E
	dc.b	$58,$6E,$FF,$F4	; $A360
	dc.b	$53,$6E,$FF,$FC	; $A364
	bne.b *-$3C	; $A368
	addi.w #$100, (-$E,A6)	; $A36A
	addi.w #$40, D7	; $A370
	dc.b	$53,$6E,$FF,$FA	; $A374
	bne.b *-$5C	; $A378
	unlk A6	; $A37A
	rts	; $A37C
	movea.l ($1CC00).l, A1	; $A37E
	move.w (RAM_word_FFFF9676).w, D0	; $A384
	add.w D0, D0	; $A388
	movea.w D0, A0	; $A38A
	move.w ($0,A1,D0.w), D0	; $A38C
	lea ($0,A1,D0.w), A2	; $A390
	move.w (A2)+, (RAM_word_FFFF9668).w	; $A394
	move.w (A2)+, (RAM_word_FFFF9678).w	; $A398
	bsr.b *+$8	; $A39C
	move.w (A2)+, (RAM_word_FFFF996A).w	; $A39E
	rts	; $A3A2
	move.b (A2)+, D0	; $A3A4
	move.b (A2)+, D1	; $A3A6
	bsr.b *+$C	; $A3A8
	move.w D0, (RAM_word_FFFF967A).w	; $A3AA
	move.w D1, (RAM_word_FFFF967C).w	; $A3AE
	rts	; $A3B2
	andi.w #$FF, D0	; $A3B4
	lsl.w #$3, D0	; $A3B8
	addi.w #$1000, D0	; $A3BA
	andi.w #$FF, D1	; $A3BE
	lsl.w #$3, D1	; $A3C2
	addi.w #$1000, D1	; $A3C4
	rts	; $A3C8
	btst.b #$0, (RAM_word_FFFF966B).w	; $A3CA
	beq.b *+$6	; $A3D0
	asl (-$35FE,A4)	; $A3D2
	rts	; $A3D6
	btst.b #$6, (RAM_word_FFFF9659).w	; $A3D8
	bne.b *+$20	; $A3DE
	bclr.b #$0, (RAM_word_FFFF9966).w	; $A3E0
	bne.b *+$6	; $A3E6
	clr.b (RAM_word_FFFF9980).w	; $A3E8
	bclr.b #$1, (RAM_word_FFFF9966).w	; $A3EC
	bne.b *+$6	; $A3F2
	clr.b (RAM_word_FFFF9981).w	; $A3F4
	move.l (RAM_word_FFFF996C).w, D0	; $A3F8
	bne.b *+$4	; $A3FC
	rts	; $A3FE
	movea.l D0, A2	; $A400
	move.w #$1000, (RAM_word_FFFF9978).w	; $A402
	move.w #$1000, (RAM_word_FFFF997A).w	; $A408
	moveq #$10, D0	; $A40E
	move.w D0, (RAM_word_FFFF9974).w	; $A410
	move.w D0, (RAM_word_FFFF9976).w	; $A414
	moveq #$0, D0	; $A418
	move.b (A2)+, D0	; $A41A
	cmpi.b #-$40, D0	; $A41C
	bcs.b *+$42	; $A420
	cmpi.b #-$30, D0	; $A422
	bcc.b *+$10	; $A426
	andi.w #$F, D0	; $A428
	addq.w #$1, D0	; $A42C
	lsl.w #$4, D0	; $A42E
	move.w D0, (RAM_word_FFFF9974).w	; $A430
	bra.b *-$1C	; $A434
	cmpi.b #-$20, D0	; $A436
	bcc.b *+$10	; $A43A
	andi.w #$F, D0	; $A43C
	addq.w #$1, D0	; $A440
	lsl.w #$4, D0	; $A442
	move.w D0, (RAM_word_FFFF9976).w	; $A444
	bra.b *-$30	; $A448
	andi.w #$1F, D0	; $A44A
	add.w D0, D0	; $A44E
	dc.b	$41,$FA,$00,$3E	; $A450
	adda.w ($0,A0,D0.w), A0	; $A454
	jsr (A0)	; $A458
	tst.w (RAM_word_FFFF9962).w	; $A45A
	beq.b *-$46	; $A45E
	rts	; $A460
	add.w D0, D0	; $A462
	dc.b	$41,$FA,$00,$6A	; $A464
	adda.w ($0,A0,D0.w), A0	; $A468
	jmp (A0)	; $A46C
	moveq #$0, D0	; $A46E
	move.b (-$1,A2), D0	; $A470
	dc.b	$10,$3B,$00,$0A	; $A474
	adda.w D0, A2	; $A478
	bra.w *-$6C	; $A47A
	rts	; $A47E
	btst.l D2, D5	; $A480
	btst.l D2, D7	; $A482
	dc.b	$02,$03,$04,$03	; $A484
	btst.l D1, D4	; $A488
	dc.b	$02,$00,$07,$06	; $A48A
	btst.l D0, D0	; $A48E
	dc.b	$05,$4a,$ff,$ee,$05,$74	; $A490
	dc.b	$05,$80,$ff,$ee,$ff,$ee,$ff,$ee,$ff,$ee	; $A496
	dc.b	$05,$8c,$05,$d6	; $A4A0
	dc.b	$05,$ea,$06,$16	; $A4A4
	dc.b	$06,$3a,$ff,$ee,$ff,$ee,$ff,$ee,$ff,$ee,$ff,$ee,$ff,$ee,$ff,$ee	; $A4A8
	dc.b	$ff,$ee,$ff,$ee	; $A4B8
	dc.b	$06,$5a,$06,$7c,$06,$8a	; $A4BC
	dc.b	$06,$a2,$06,$b6,$06,$c2	; $A4C2
	dc.b	$06,$c8,$06,$e4	; $A4C8
	dc.b	$07,$1c	; $A4CC
	dc.b	$07,$28,$00,$1e	; $A4CE
	dc.b	$00,$36,$00,$4e,$00,$5e	; $A4D2
	dc.b	$00,$82,$00,$92,$00,$ec	; $A4D8
	dc.b	$01,$42,$ff,$9e,$02,$ca	; $A4DE
	dc.b	$03,$e4	; $A4E4
	dc.b	$04,$16,$ff,$9e,$ff,$9e	; $A4E6
	dc.b	$04,$3a,$61,$00,$04,$3c	; $A4EC
	dc.b	$64,$00,$ff,$7a	; $A4F2
	dc.b	$38,$38,$99,$74	; $A4F6
	dc.b	$e2,$4c	; $A4FA
	dc.b	$94,$44	; $A4FC
	dc.b	$30,$02	; $A4FE
	dc.b	$72,$00	; $A500
	dc.b	$60,$00,$04,$5e	; $A502
	dc.b	$61,$00,$04,$24	; $A506
	dc.b	$64,$00,$ff,$62	; $A50A
	dc.b	$d2,$78,$99,$76	; $A50E
	dc.b	$92,$6c,$c9,$00	; $A512
	dc.b	$44,$41	; $A516
	dc.b	$70,$00	; $A518
	dc.b	$60,$00,$04,$46	; $A51A
	dc.b	$61,$00,$04,$0c	; $A51E
	dc.b	$64,$00,$ff,$4a	; $A522
	dc.b	$70,$00	; $A526
	dc.b	$72,$00	; $A528
	dc.b	$60,$00,$04,$36	; $A52A
	dc.b	$61,$00,$03,$fc	; $A52E
	dc.b	$64,$00,$ff,$3a	; $A532
	dc.b	$38,$38,$99,$74	; $A536
	dc.b	$e2,$4c	; $A53A
	dc.b	$94,$44	; $A53C
	dc.b	$30,$02	; $A53E
	dc.b	$72,$00	; $A540
	dc.b	$61,$00,$04,$1e	; $A542
	dc.b	$10,$1a	; $A546
	dc.b	$e1,$40	; $A548
	dc.b	$10,$1a	; $A54A
	dc.b	$d1,$6c,$ca,$02	; $A54C
	dc.b	$4e,$75	; $A550
	dc.b	$11,$da,$9c,$16	; $A552
	dc.b	$11,$da,$9c,$17	; $A556
	dc.b	$31,$fc,$00,$08,$99,$62	; $A55A
	dc.b	$4e,$75	; $A560
	dc.b	$61,$00,$03,$b0	; $A562
	dc.b	$58,$40	; $A566
	dc.b	$34,$2c,$c8,$00	; $A568
	dc.b	$94,$40	; $A56C
	dc.b	$65,$00,$fe,$fe	; $A56E
	dc.b	$30,$38,$99,$74	; $A572
	dc.b	$51,$40	; $A576
	dc.b	$94,$40	; $A578
	dc.b	$64,$00,$fe,$f2	; $A57A
	dc.b	$70,$00	; $A57E
	dc.b	$10,$2c,$cb,$03	; $A580
	dc.b	$d0,$6c,$c9,$00	; $A584
	dc.b	$b0,$41	; $A588
	dc.b	$66,$00,$fe,$e2	; $A58A
	dc.b	$11,$ea,$00,$01,$99,$82	; $A58E
	dc.b	$11,$ea,$00,$02,$99,$83	; $A594
	dc.b	$21,$fc,$00,$00,$a5,$aa,$99,$8a	; $A59A
	dc.b	$50,$f8,$99,$80	; $A5A2
	dc.b	$60,$00,$fe,$c6	; $A5A6
	dc.b	$31,$fc,$00,$08,$99,$62	; $A5AA
	dc.b	$31,$f8,$99,$82,$9c,$16	; $A5B0
	dc.b	$61,$00,$39,$c8	; $A5B6
	dc.b	$4e,$75	; $A5BA
	dc.b	$61,$00,$03,$56	; $A5BC
	dc.b	$0c,$2a,$00,$08,$00,$01	; $A5C0
	dc.b	$66,$02	; $A5C6
	dc.b	$50,$40	; $A5C8
	dc.b	$34,$00	; $A5CA
	dc.b	$94,$6c,$c8,$00	; $A5CC
	dc.b	$6a,$02	; $A5D0
	dc.b	$44,$42	; $A5D2
	dc.b	$59,$42	; $A5D4
	dc.b	$64,$00,$fe,$96	; $A5D6
	dc.b	$74,$00	; $A5DA
	dc.b	$14,$2c,$cb,$03	; $A5DC
	dc.b	$d4,$6c,$c9,$00	; $A5E0
	dc.b	$b2,$42	; $A5E4
	dc.b	$66,$00,$fe,$86	; $A5E6
	dc.b	$31,$c0,$99,$82	; $A5EA
	dc.b	$31,$c1,$99,$84	; $A5EE
	dc.b	$21,$ca,$99,$86	; $A5F2
	dc.b	$21,$fc,$00,$00,$a6,$0a,$99,$8a	; $A5F6
	dc.b	$41,$fa,$00,$0a	; $A5FE
	dc.b	$50,$f8,$99,$80	; $A602
	dc.b	$60,$00,$fe,$66	; $A606
	dc.b	$31,$fc,$00,$05,$99,$62	; $A60A
	dc.b	$4e,$75	; $A610
	dc.b	$4a,$38,$9a,$00	; $A612
	dc.b	$6b,$00,$fe,$56	; $A616
	dc.b	$10,$2a,$00,$01	; $A61A
	dc.b	$4e,$b8,$27,$28	; $A61E
	dc.b	$66,$00,$fe,$4a	; $A622
	dc.b	$61,$00,$02,$ec	; $A626
	dc.b	$34,$00	; $A62A
	dc.b	$94,$6c,$c8,$00	; $A62C
	dc.b	$6a,$02	; $A630
	dc.b	$44,$42	; $A632
	dc.b	$51,$42	; $A634
	dc.b	$64,$00,$fe,$36	; $A636
	dc.b	$74,$00	; $A63A
	dc.b	$14,$2c,$cb,$03	; $A63C
	dc.b	$d4,$6c,$c9,$00	; $A640
	dc.b	$b2,$42	; $A644
	dc.b	$66,$00,$fe,$26	; $A646
	dc.b	$31,$c0,$99,$82	; $A64A
	dc.b	$31,$c1,$99,$84	; $A64E
	dc.b	$21,$ca,$99,$86	; $A652
	dc.b	$21,$fc,$00,$00,$a6,$8e,$99,$8a	; $A656
	dc.b	$50,$f8,$99,$80	; $A65E
	dc.b	$60,$00,$fe,$0a	; $A662
	dc.b	$31,$fc,$80,$00,$9a,$00	; $A666
	dc.b	$d0,$40	; $A66C
	dc.b	$41,$f9,$00,$00,$a6,$ca	; $A66E
	dc.b	$d0,$f0,$00,$00	; $A674
	dc.b	$21,$c8,$9a,$02	; $A678
	dc.b	$31,$c6,$9a,$06	; $A67C
	dc.b	$04,$47,$00,$10	; $A680
	dc.b	$31,$c7,$9a,$08	; $A684
	dc.b	$70,$2c	; $A688
	dc.b	$4e,$f8,$03,$66	; $A68A
	dc.b	$24,$78,$99,$86	; $A68E
	dc.b	$10,$2a,$00,$01	; $A692
	dc.b	$4e,$b8,$27,$30	; $A696
	dc.b	$70,$00	; $A69A
	dc.b	$10,$2a,$00,$02	; $A69C
	dc.b	$3c,$38,$99,$82	; $A6A0
	dc.b	$3e,$38,$99,$84	; $A6A4
	dc.b	$61,$bc	; $A6A8
	dc.b	$e8,$4e	; $A6AA
	dc.b	$53,$46	; $A6AC
	dc.b	$04,$47,$00,$10	; $A6AE
	dc.b	$e5,$4f	; $A6B2
	dc.b	$47,$f8,$97,$54	; $A6B4
	dc.b	$30,$3c,$01,$64	; $A6B8
	dc.b	$4e,$b8,$26,$92	; $A6BC
	dc.b	$30,$3c,$01,$65	; $A6C0
	dc.b	$52,$46	; $A6C4
	dc.b	$4e,$f8,$26,$92,$00,$48	; $A6C6
	dc.b	$00,$58,$00,$5a	; $A6CC
	dc.b	$00,$5c,$00,$5e	; $A6D0
	dc.b	$00,$60,$00,$62	; $A6D4
	dc.b	$00,$64,$00,$66	; $A6D8
	dc.b	$00,$68,$00,$6a,$00,$6c	; $A6DC
	dc.b	$00,$6e,$00,$70,$00,$72	; $A6E2
	dc.b	$00,$74,$00,$76,$00,$78	; $A6E8
	dc.b	$00,$7a,$00,$7c,$00,$7e	; $A6EE
	dc.b	$00,$80,$00,$82,$00,$84	; $A6F4
	dc.b	$00,$86,$00,$88,$00,$8a,$00,$8c,$00,$8e	; $A6FA
	dc.b	$00,$90,$00,$92,$00,$94	; $A704
	dc.b	$00,$a0,$00,$aa,$00,$ba,$00,$c6,$04,$0c,$04,$0c,$04,$0c,$04,$0c	; $A70A
	dc.b	$04,$0c,$04,$0c,$04,$0c	; $A71A
	dc.b	$16,$00	; $A720
	dc.b	$c0,$00	; $A722
	move.b D0, D5	; $A724
	dc.b	$14,$00	; $A726
	dc.b	$87,$00	; $A728
	dc.b	$8f,$00	; $A72A
	dc.b	$97,$00	; $A72C
	dc.b	$9f,$00,$a4,$00	; $A72E
	dc.b	$9a,$00,$a2,$00,$a5,$00,$a1,$00	; $A732
	dc.b	$b4,$00	; $A73A
	dc.b	$b3,$00	; $A73C
	dc.b	$b5,$00,$a9,$00	; $A73E
	dc.b	$98,$00	; $A742
	dc.b	$b6,$00	; $A744
	dc.b	$b7,$00	; $A746
	dc.b	$88,$00	; $A748
	dc.b	$90,$00,$aa,$00	; $A74A
	dc.b	$94,$00,$a3,$00,$a0,$00	; $A74E
	dc.b	$b2,$00	; $A754
	dc.b	$85,$00	; $A756
	dc.b	$b8,$00	; $A758
	dc.b	$b9,$00	; $A75A
	dc.b	$1a,$00,$08,$0c,$08,$0c,$08,$0c,$08,$0c,$08,$0c	; $A75C
	dc.b	$12,$00,$a0,$01,$a1,$01,$a2,$01,$a3,$01,$a4,$00,$06,$0c,$06,$0c	; $A768
	dc.b	$06,$0c,$06,$0c,$06,$0c,$06,$0c,$06,$0c	; $A778
	dc.b	$06,$00,$08,$20	; $A782
	dc.b	$08,$20,$08,$20	; $A786
	dc.b	$18,$20	; $A78A
	dc.b	$18,$20	; $A78C
	dc.b	$12,$00	; $A78E
	dc.b	$08,$20,$08,$20	; $A790
	dc.b	$08,$20,$0a,$20	; $A794
	dc.b	$12,$00	; $A798
	dc.b	$1c,$12	; $A79A
	dc.b	$e1,$4e	; $A79C
	dc.b	$1c,$2a,$00,$01	; $A79E
	dc.b	$1e,$2a,$00,$02	; $A7A2
	dc.b	$e1,$4f	; $A7A6
	dc.b	$1e,$2a,$00,$03	; $A7A8
	dc.b	$20,$79,$00,$01,$cc,$00	; $A7AC
	dc.b	$30,$06	; $A7B2
	dc.b	$d0,$40	; $A7B4
	dc.b	$d0,$f0,$00,$00	; $A7B6
	dc.b	$70,$00	; $A7BA
	dc.b	$10,$28,$00,$05	; $A7BC
	dc.b	$e7,$48	; $A7C0
	dc.b	$06,$40,$10,$00	; $A7C2
	dc.b	$72,$00	; $A7C6
	dc.b	$12,$2c,$cb,$03	; $A7C8
	dc.b	$d2,$6c,$c9,$00	; $A7CC
	dc.b	$b0,$41	; $A7D0
	dc.b	$66,$00,$fc,$9a	; $A7D2
	dc.b	$72,$00	; $A7D6
	dc.b	$12,$28,$00,$04	; $A7D8
	dc.b	$e7,$49	; $A7DC
	dc.b	$06,$41,$10,$00	; $A7DE
	dc.b	$70,$00	; $A7E2
	dc.b	$10,$28,$00,$02	; $A7E4
	dc.b	$4e,$fb,$00,$02	; $A7E8
	dc.b	$60,$56	; $A7EC
	dc.b	$60,$54	; $A7EE
	dc.b	$60,$7e	; $A7F0
	dc.b	$60,$50	; $A7F2
	dc.b	$60,$1a	; $A7F4
	dc.b	$60,$22	; $A7F6
	dc.b	$60,$4e	; $A7F8
	dc.b	$60,$74	; $A7FA
	dc.b	$60,$72	; $A7FC
	dc.b	$60,$70	; $A7FE
	dc.b	$61,$00,$00,$8a	; $A800
	dc.b	$64,$3e	; $A804
	dc.b	$21,$fc,$00,$00,$a8,$a6,$99,$8a	; $A806
	dc.b	$60,$6c	; $A80E
	dc.b	$08,$38,$00,$04,$9e,$f1	; $A810
	dc.b	$66,$58	; $A816
	dc.b	$60,$2a	; $A818
	dc.b	$08,$38,$00,$02,$9f,$0b	; $A81A
	dc.b	$67,$22	; $A820
	dc.b	$08,$38,$00,$06,$9f,$02	; $A822
	dc.b	$67,$1a	; $A828
	dc.b	$70,$00	; $A82A
	dc.b	$10,$2c,$cb,$02	; $A82C
	dc.b	$44,$40	; $A830
	dc.b	$d0,$6c,$c8,$00	; $A832
	dc.b	$51,$40	; $A836
	dc.b	$b0,$41	; $A838
	dc.b	$66,$08	; $A83A
	dc.b	$31,$fc,$00,$06,$99,$62	; $A83C
	dc.b	$60,$3c	; $A842
	dc.b	$60,$00,$fc,$28	; $A844
	dc.b	$08,$38,$00,$03,$9f,$0b	; $A848
	dc.b	$67,$f4	; $A84E
	dc.b	$08,$38,$00,$06,$9f,$02	; $A850
	dc.b	$67,$ec	; $A856
	dc.b	$70,$00	; $A858
	dc.b	$10,$2c,$cb,$02	; $A85A
	dc.b	$d0,$6c,$c8,$00	; $A85E
	dc.b	$50,$40	; $A862
	dc.b	$b0,$41	; $A864
	dc.b	$66,$dc	; $A866
	dc.b	$31,$fc,$00,$07,$99,$62	; $A868
	dc.b	$60,$10	; $A86E
	dc.b	$61,$1a	; $A870
	dc.b	$64,$d0	; $A872
	dc.b	$21,$fc,$00,$00,$a8,$98,$99,$8a	; $A874
	dc.b	$50,$f8,$99,$80	; $A87C
	dc.b	$31,$c6,$99,$82	; $A880
	dc.b	$31,$c7,$99,$84	; $A884
	dc.b	$60,$00,$fb,$e4	; $A888
	dc.b	$92,$6c,$c8,$00	; $A88C
	dc.b	$6a,$02	; $A890
	dc.b	$44,$41	; $A892
	dc.b	$59,$41	; $A894
	dc.b	$4e,$75	; $A896
	dc.b	$31,$f8,$99,$84,$96,$76	; $A898
	dc.b	$31,$fc,$00,$02,$99,$62	; $A89E
	dc.b	$4e,$75	; $A8A4
	dc.b	$31,$f8,$99,$84,$96,$76	; $A8A6
	dc.b	$31,$fc,$00,$0c,$99,$62	; $A8AC
	dc.b	$4e,$75	; $A8B2
	dc.b	$1e,$12	; $A8B4
	dc.b	$e1,$4f	; $A8B6
	dc.b	$1e,$2a,$00,$01	; $A8B8
	dc.b	$61,$00,$00,$d2	; $A8BC
	dc.b	$66,$00,$fb,$ac	; $A8C0
	dc.b	$31,$c7,$99,$82	; $A8C4
	dc.b	$21,$fc,$00,$00,$a8,$d8,$99,$8a	; $A8C8
	dc.b	$50,$f8,$99,$80	; $A8D0
	dc.b	$60,$00,$fb,$98	; $A8D4
	dc.b	$31,$f8,$99,$82,$99,$64	; $A8D8
	dc.b	$31,$fc,$00,$03,$99,$62	; $A8DE
	dc.b	$4e,$75	; $A8E4
	dc.b	$3e,$38,$99,$64	; $A8E6
	dc.b	$61,$00,$00,$a4	; $A8EA
	dc.b	$66,$00,$fb,$7e	; $A8EE
	dc.b	$21,$fc,$00,$00,$a9,$02,$99,$8e	; $A8F2
	dc.b	$50,$f8,$99,$81	; $A8FA
	dc.b	$60,$00,$fb,$6e	; $A8FE
	dc.b	$31,$fc,$00,$04,$99,$62	; $A902
	rts	; $A908
	dc.b	$10,$12	; $A90A
	dc.b	$4e,$b8,$03,$66	; $A90C
	dc.b	$60,$00,$fb,$5c	; $A910
	dc.b	$10,$12	; $A914
	dc.b	$12,$00	; $A916
	dc.b	$02,$40,$00,$0f	; $A918
	dc.b	$e9,$48	; $A91C
	dc.b	$d0,$78,$99,$78	; $A91E
	dc.b	$02,$41,$00,$f0	; $A922
	dc.b	$d2,$78,$99,$7a	; $A926
	dc.b	$4e,$75	; $A92A
	dc.b	$12,$12	; $A92C
	dc.b	$70,$0f	; $A92E
	dc.b	$c0,$41	; $A930
	dc.b	$e9,$48	; $A932
	dc.b	$d0,$78,$99,$78	; $A934
	dc.b	$34,$2c,$c8,$00	; $A938
	dc.b	$94,$40	; $A93C
	dc.b	$65,$1c	; $A93E
	dc.b	$b4,$78,$99,$74	; $A940
	dc.b	$64,$14	; $A944
	dc.b	$02,$41,$00,$f0	; $A946
	dc.b	$d2,$78,$99,$7a	; $A94A
	dc.b	$36,$2c,$c9,$00	; $A94E
	dc.b	$96,$41	; $A952
	dc.b	$65,$06	; $A954
	dc.b	$b6,$78,$99,$76	; $A956
	dc.b	$4e,$75	; $A95A
	dc.b	$02,$3c,$00,$fe	; $A95C
	dc.b	$4e,$75	; $A960
	dc.b	$31,$c0,$96,$7e	; $A962
	dc.b	$31,$c1,$96,$80	; $A966
	dc.b	$52,$8a	; $A96A
	dc.b	$11,$da,$96,$68	; $A96C
	dc.b	$11,$da,$96,$69	; $A970
	dc.b	$61,$00,$fa,$2e	; $A974
	dc.b	$61,$00,$fa,$50	; $A978
	dc.b	$11,$fc,$00,$02,$96,$78	; $A97C
	dc.b	$11,$fc,$00,$01,$96,$6a	; $A982
	dc.b	$31,$fc,$00,$01,$99,$62	; $A988
	dc.b	$4e,$75	; $A98E
	dc.b	$30,$07	; $A990
	dc.b	$e9,$48	; $A992
	dc.b	$20,$79,$00,$01,$cc,$08	; $A994
	dc.b	$76,$20	; $A99A
	dc.b	$4a,$30,$00,$07	; $A99C
	dc.b	$67,$02	; $A9A0
	dc.b	$76,$10	; $A9A2
	dc.b	$32,$03	; $A9A4
	dc.b	$e2,$49	; $A9A6
	dc.b	$d2,$30,$00,$04	; $A9A8
	dc.b	$d2,$70,$00,$00	; $A9AC
	dc.b	$92,$6c,$c8,$00	; $A9B0
	dc.b	$6a,$02	; $A9B4
	dc.b	$44,$41	; $A9B6
	dc.b	$59,$41	; $A9B8
	dc.b	$64,$1a	; $A9BA
	dc.b	$72,$00	; $A9BC
	dc.b	$12,$30,$00,$05	; $A9BE
	dc.b	$d2,$70,$00,$02	; $A9C2
	dc.b	$34,$2c,$c9,$00	; $A9C6
	dc.b	$94,$41	; $A9CA
	dc.b	$65,$08	; $A9CC
	dc.b	$b4,$43	; $A9CE
	dc.b	$64,$04	; $A9D0
	dc.b	$70,$00	; $A9D2
	dc.b	$4e,$75	; $A9D4
	dc.b	$70,$ff	; $A9D6
	dc.b	$4e,$75	; $A9D8
	dc.b	$12,$1a	; $A9DA
	dc.b	$e9,$49	; $A9DC
	dc.b	$70,$00	; $A9DE
	dc.b	$10,$01	; $A9E0
	dc.b	$02,$41,$0f,$00	; $A9E2
	dc.b	$06,$41,$0f,$00	; $A9E6
	dc.b	$31,$c1,$99,$78	; $A9EA
	dc.b	$04,$40,$00,$10	; $A9EE
	dc.b	$32,$00	; $A9F2
	dc.b	$d0,$40	; $A9F4
	dc.b	$d0,$41	; $A9F6
	dc.b	$e5,$40	; $A9F8
	dc.b	$06,$40,$10,$00	; $A9FA
	dc.b	$31,$c0,$99,$7a	; $A9FE
	dc.b	$4e,$75	; $AA02
	dc.b	$70,$00	; $AA04
	dc.b	$10,$1a	; $AA06
	dc.b	$e9,$48	; $AA08
	dc.b	$31,$c0,$99,$74	; $AA0A
	dc.b	$4e,$75	; $AA0E
	dc.b	$70,$00	; $AA10
	move.b (A2)+, D0	; $AA12
	dc.b	$e9,$48	; $AA14
	dc.b	$31,$c0,$99,$76	; $AA16
	dc.b	$4e,$75	; $AA1A
	dc.b	$3f,$0c	; $AA1C
	dc.b	$4e,$b8,$27,$e6	; $AA1E
	dc.b	$6a,$08	; $AA22
	dc.b	$d5,$fc,$00,$00,$00,$09	; $AA24
	dc.b	$60,$36	; $AA2A
	dc.b	$4e,$b8,$0a,$36	; $AA2C
	dc.b	$19,$5a,$c3,$00	; $AA30
	dc.b	$19,$5a,$c3,$01	; $AA34
	dc.b	$10,$1a	; $AA38
	dc.b	$19,$5a,$c3,$03	; $AA3A
	dc.b	$19,$5a,$c0,$02	; $AA3E
	dc.b	$19,$5a,$c8,$00	; $AA42
	dc.b	$19,$5a,$c8,$01	; $AA46
	dc.b	$19,$5a,$c9,$00	; $AA4A
	dc.b	$19,$5a,$c9,$01	; $AA4E
	dc.b	$39,$7c,$00,$04,$d4,$02	; $AA52
	dc.b	$4e,$b8,$07,$e8	; $AA58
	dc.b	$19,$7c,$00,$c0,$c0,$00	; $AA5C
	dc.b	$38,$5f	; $AA62
	dc.b	$4e,$75	; $AA64
	dc.b	$10,$1a	; $AA66
	dc.b	$e1,$48	; $AA68
	dc.b	$10,$1a	; $AA6A
	dc.b	$41,$f2,$00,$fe	; $AA6C
	dc.b	$2f,$0a	; $AA70
	dc.b	$4e,$b8,$27,$fa	; $AA72
	dc.b	$24,$5f	; $AA76
	dc.b	$4e,$75	; $AA78
	dc.b	$7a,$00	; $AA7A
	dc.b	$1a,$1a	; $AA7C
	dc.b	$18,$1a	; $AA7E
	dc.b	$e1,$4c	; $AA80
	dc.b	$18,$1a	; $AA82
	dc.b	$7c,$00	; $AA84
	dc.b	$1c,$1a	; $AA86
	dc.b	$e9,$4e	; $AA88
	dc.b	$06,$46,$0f,$00	; $AA8A
	dc.b	$7e,$00	; $AA8E
	dc.b	$1e,$1a	; $AA90
	dc.b	$e9,$4f	; $AA92
	dc.b	$06,$47,$0f,$00	; $AA94
	dc.b	$11,$da,$a0,$e0	; $AA98
	dc.b	$2f,$0a	; $AA9C
	dc.b	$61,$00,$71,$50	; $AA9E
	dc.b	$24,$5f	; $AAA2
	dc.b	$4e,$75	; $AAA4
	dc.b	$3c,$3c,$01,$00	; $AAA6
	dc.b	$3e,$06	; $AAAA
	dc.b	$1c,$1a	; $AAAC
	dc.b	$1e,$1a	; $AAAE
	dc.b	$ed,$4f	; $AAB0
	dc.b	$70,$00	; $AAB2
	dc.b	$10,$1a	; $AAB4
	dc.b	$72,$00	; $AAB6
	dc.b	$12,$1a	; $AAB8
	dc.b	$14,$1a	; $AABA
	dc.b	$e1,$4a	; $AABC
	dc.b	$14,$1a	; $AABE
	dc.b	$2f,$0a	; $AAC0
	dc.b	$4e,$b8,$28,$12	; $AAC2
	dc.b	$24,$5f	; $AAC6
	dc.b	$4e,$75	; $AAC8
	dc.b	$3c,$3c,$01,$00	; $AACA
	dc.b	$3e,$06	; $AACE
	dc.b	$1c,$1a	; $AAD0
	dc.b	$1e,$1a	; $AAD2
	dc.b	$ed,$4f	; $AAD4
	dc.b	$10,$1a	; $AAD6
	dc.b	$e1,$48	; $AAD8
	move.b (A2)+, D0	; $AADA
	dc.b	$2f,$0a	; $AADC
	dc.b	$41,$f2,$00,$fe	; $AADE
	dc.b	$4e,$b8,$28,$56	; $AAE2
	dc.b	$24,$5f	; $AAE6
	dc.b	$4e,$75	; $AAE8
	dc.b	$10,$1a	; $AAEA
	dc.b	$72,$18	; $AAEC
	dc.b	$c2,$40	; $AAEE
	dc.b	$e4,$49	; $AAF0
	dc.b	$30,$7b,$10,$10	; $AAF2
	dc.b	$02,$40,$00,$07	; $AAF6
	dc.b	$b0,$10	; $AAFA
	dc.b	$67,$00,$00,$ae	; $AAFC
	dc.b	$54,$4a	; $AB00
	dc.b	$4e,$75	; $AB02
	dc.b	$95,$ce	; $AB04
	dc.b	$95,$cf	; $AB06
	dc.b	$95,$d0	; $AB08
	dc.b	$95,$d1	; $AB0A
	dc.b	$08,$38,$00,$04,$9e,$f1	; $AB0C
	dc.b	$66,$00,$00,$98	; $AB12
	dc.b	$54,$4a	; $AB16
	dc.b	$4e,$75	; $AB18
	dc.b	$10,$1a	; $AB1A
	dc.b	$4e,$b8,$27,$58	; $AB1C
	dc.b	$14,$1a	; $AB20
	dc.b	$e1,$4a	; $AB22
	dc.b	$14,$1a	; $AB24
	dc.b	$01,$30,$10,$00	; $AB26
	dc.b	$67,$04	; $AB2A
	dc.b	$45,$f2,$20,$fe	; $AB2C
	dc.b	$4e,$75	; $AB30
	dc.b	$10,$1a	; $AB32
	dc.b	$14,$1a	; $AB34
	dc.b	$e1,$4a	; $AB36
	dc.b	$14,$1a	; $AB38
	dc.b	$4e,$b8,$27,$4c	; $AB3A
	dc.b	$67,$04	; $AB3E
	dc.b	$45,$f2,$20,$fe	; $AB40
	dc.b	$4e,$75	; $AB44
	dc.b	$10,$1a	; $AB46
	dc.b	$4e,$b8,$27,$58	; $AB48
	dc.b	$01,$f0,$10,$00	; $AB4C
	dc.b	$4e,$75	; $AB50
	dc.b	$10,$1a	; $AB52
	dc.b	$4e,$f8,$27,$52	; $AB54
	dc.b	$10,$1a	; $AB58
	dc.b	$14,$1a	; $AB5A
	dc.b	$e1,$4a	; $AB5C
	dc.b	$14,$1a	; $AB5E
	dc.b	$48,$e7,$20,$20	; $AB60
	dc.b	$4e,$b8,$23,$e4	; $AB64
	dc.b	$4c,$df,$04,$04	; $AB68
	dc.b	$67,$04	; $AB6C
	dc.b	$45,$f2,$20,$fe	; $AB6E
	dc.b	$4e,$75	; $AB72
	dc.b	$61,$00,$fd,$b6	; $AB74
	dc.b	$55,$c1	; $AB78
	dc.b	$70,$10	; $AB7A
	dc.b	$31,$c0,$99,$74	; $AB7C
	dc.b	$31,$c0,$99,$76	; $AB80
	dc.b	$4a,$01	; $AB84
	dc.b	$66,$04	; $AB86
	dc.b	$56,$4a	; $AB88
	dc.b	$60,$20	; $AB8A
	dc.b	$52,$4a	; $AB8C
	dc.b	$4a,$1a	; $AB8E
	dc.b	$66,$0c	; $AB90
	dc.b	$10,$1a	; $AB92
	dc.b	$4e,$b8,$27,$58	; $AB94
	dc.b	$01,$30,$10,$00	; $AB98
	dc.b	$60,$08	; $AB9C
	dc.b	$6b,$08	; $AB9E
	dc.b	$10,$1a	; $ABA0
	dc.b	$4e,$b8,$27,$4c	; $ABA2
	dc.b	$66,$04	; $ABA6
	dc.b	$54,$4a	; $ABA8
	dc.b	$4e,$75	; $ABAA
	dc.b	$10,$1a	; $ABAC
	dc.b	$e1,$48	; $ABAE
	dc.b	$10,$12	; $ABB0
	dc.b	$53,$40	; $ABB2
	dc.b	$d4,$c0	; $ABB4
	dc.b	$4e,$75	; $ABB6
	dc.b	$58,$8f	; $ABB8
	dc.b	$70,$00	; $ABBA
	dc.b	$4e,$75	; $ABBC
	dc.b	$42,$38,$9a,$8a	; $ABBE
	dc.b	$42,$78,$9a,$94	; $ABC2
	dc.b	$20,$38,$99,$6c	; $ABC6
	dc.b	$66,$02	; $ABCA
	dc.b	$4e,$75	; $ABCC
	dc.b	$24,$40	; $ABCE
	dc.b	$31,$fc,$10,$00,$99,$78	; $ABD0
	dc.b	$31,$fc,$10,$00,$99,$7a	; $ABD6
	dc.b	$70,$10	; $ABDC
	dc.b	$31,$c0,$99,$74	; $ABDE
	dc.b	$31,$c0,$99,$76	; $ABE2
	dc.b	$70,$00	; $ABE6
	dc.b	$10,$1a	; $ABE8
	dc.b	$0c,$00,$00,$c0	; $ABEA
	dc.b	$65,$3a	; $ABEE
	dc.b	$0c,$00,$00,$d0	; $ABF0
	dc.b	$64,$0e	; $ABF4
	dc.b	$02,$40,$00,$0f	; $ABF6
	dc.b	$52,$40	; $ABFA
	dc.b	$e9,$48	; $ABFC
	dc.b	$31,$c0,$99,$74	; $ABFE
	dc.b	$60,$e2	; $AC02
	dc.b	$0c,$00,$00,$e0	; $AC04
	dc.b	$64,$0e	; $AC08
	dc.b	$02,$40,$00,$0f	; $AC0A
	dc.b	$52,$40	; $AC0E
	dc.b	$e9,$48	; $AC10
	dc.b	$31,$c0,$99,$76	; $AC12
	dc.b	$60,$ce	; $AC16
	dc.b	$02,$40,$00,$1f	; $AC18
	dc.b	$d0,$40	; $AC1C
	dc.b	$41,$fa,$f8,$70	; $AC1E
	dc.b	$d0,$f0,$00,$00	; $AC22
	dc.b	$4e,$90	; $AC26
	dc.b	$60,$bc	; $AC28
	dc.b	$d0,$40	; $AC2A
	dc.b	$41,$fa,$00,$1c	; $AC2C
	dc.b	$d0,$f0,$00,$00	; $AC30
	dc.b	$4e,$d0	; $AC34
	dc.b	$70,$00	; $AC36
	dc.b	$10,$2a,$ff,$ff	; $AC38
	dc.b	$41,$fa,$f8,$42	; $AC3C
	dc.b	$10,$30,$00,$00	; $AC40
	dc.b	$d4,$c0	; $AC44
	dc.b	$60,$00,$ff,$94,$ff,$ec,$ff,$ec,$ff,$ec,$ff,$ec,$ff,$ec,$ff,$ec	; $AC46
	dc.b	$ff,$ec	; $AC56
	dc.b	$00,$1e,$00,$7c,$ff,$ec,$ff,$ec,$ff,$ec	; $AC58
	dc.b	$01,$a2	; $AC62
	dc.b	$02,$04,$ff,$ec	; $AC64
	dc.b	$61,$00,$fc,$aa	; $AC68
	dc.b	$3c,$00	; $AC6C
	dc.b	$3e,$01	; $AC6E
	dc.b	$e8,$4e	; $AC70
	dc.b	$53,$46	; $AC72
	dc.b	$04,$47,$00,$20	; $AC74
	dc.b	$e5,$4f	; $AC78
	dc.b	$47,$f8,$97,$54	; $AC7A
	dc.b	$10,$2a,$00,$01	; $AC7E
	dc.b	$2f,$0a	; $AC82
	dc.b	$4e,$b8,$27,$28	; $AC84
	dc.b	$66,$0e	; $AC88
	dc.b	$30,$3c,$01,$62	; $AC8A
	dc.b	$4e,$b8,$26,$66	; $AC8E
	dc.b	$30,$3c,$01,$63	; $AC92
	dc.b	$60,$0c	; $AC96
	dc.b	$30,$3c,$01,$64	; $AC98
	dc.b	$4e,$b8,$26,$66	; $AC9C
	dc.b	$30,$3c,$01,$65	; $ACA0
	dc.b	$52,$46	; $ACA4
	dc.b	$4e,$b8,$26,$66	; $ACA6
	dc.b	$06,$47,$00,$40	; $ACAA
	dc.b	$30,$3c,$01,$61	; $ACAE
	dc.b	$4e,$b8,$26,$66	; $ACB2
	dc.b	$53,$46	; $ACB6
	dc.b	$30,$3c,$01,$60	; $ACB8
	dc.b	$4e,$b8,$26,$66	; $ACBC
	dc.b	$24,$5f	; $ACC0
	dc.b	$60,$00,$ff,$72	; $ACC2
	dc.b	$61,$00,$fc,$4c	; $ACC6
	dc.b	$1a,$2a,$00,$02	; $ACCA
	dc.b	$3c,$00	; $ACCE
	dc.b	$7e,$f0	; $ACD0
	dc.b	$de,$41	; $ACD2
	dc.b	$4e,$b8,$2c,$f0	; $ACD4
	dc.b	$70,$00	; $ACD8
	dc.b	$10,$2a,$00,$01	; $ACDA
	dc.b	$39,$40,$ce,$02	; $ACDE
	dc.b	$4e,$b8,$27,$28	; $ACE2
	dc.b	$56,$c0	; $ACE6
	dc.b	$44,$00	; $ACE8
	dc.b	$d0,$00	; $ACEA
	dc.b	$4e,$b8,$07,$e8	; $ACEC
	dc.b	$19,$7c,$00,$c0,$c0,$00	; $ACF0
	dc.b	$60,$00,$ff,$3e	; $ACF6
	dc.b	$4a,$2c,$ce,$00	; $ACFA
	dc.b	$67,$42	; $ACFE
	dc.b	$19,$7c,$00,$03,$d1,$00	; $AD00
	dc.b	$39,$7c,$10,$10,$cb,$02	; $AD06
	dc.b	$39,$7c,$00,$40,$cc,$02	; $AD0C
	dc.b	$39,$7c,$06,$00,$cd,$02	; $AD12
	dc.b	$4e,$b8,$0b,$44	; $AD18
	dc.b	$4a,$6c,$ca,$02	; $AD1C
	dc.b	$6b,$1c	; $AD20
	dc.b	$30,$2c,$df,$02	; $AD22
	dc.b	$51,$40	; $AD26
	dc.b	$b0,$6c,$c9,$00	; $AD28
	dc.b	$64,$10	; $AD2C
	dc.b	$4e,$b8,$2e,$de	; $AD2E
	dc.b	$4e,$b8,$43,$62	; $AD32
	dc.b	$66,$04	; $AD36
	dc.b	$19,$40,$ce,$00	; $AD38
	dc.b	$4e,$75	; $AD3C
	dc.b	$4e,$f8,$0a,$b4	; $AD3E
	dc.b	$4a,$2c,$c3,$02	; $AD42
	dc.b	$67,$1e	; $AD46
	dc.b	$4a,$2c,$d8,$00	; $AD48
	dc.b	$67,$5c	; $AD4C
	dc.b	$53,$2c,$d8,$00	; $AD4E
	dc.b	$66,$56	; $AD52
	dc.b	$39,$7c,$00,$06,$d4,$02	; $AD54
	dc.b	$39,$7c,$12,$0a,$c3,$00	; $AD5A
	dc.b	$70,$00	; $AD60
	dc.b	$4e,$f8,$07,$fc	; $AD62
	dc.b	$4a,$38,$9a,$00	; $AD66
	dc.b	$6b,$3e	; $AD6A
	dc.b	$34,$78,$9e,$ee	; $AD6C
	dc.b	$30,$2a,$c8,$00	; $AD70
	dc.b	$90,$6c,$c8,$00	; $AD74
	dc.b	$6a,$02	; $AD78
	dc.b	$44,$40	; $AD7A
	dc.b	$51,$40	; $AD7C
	dc.b	$64,$2a	; $AD7E
	dc.b	$70,$00	; $AD80
	dc.b	$10,$2a,$cb,$03	; $AD82
	dc.b	$d0,$6a,$c9,$00	; $AD86
	dc.b	$04,$40,$00,$10	; $AD8A
	dc.b	$b0,$6c,$c9,$00	; $AD8E
	dc.b	$66,$16	; $AD92
	dc.b	$31,$cc,$99,$82	; $AD94
	dc.b	$21,$fc,$00,$00,$ad,$ac,$99,$8a	; $AD98
	dc.b	$50,$f8,$99,$80	; $ADA0
	dc.b	$00,$38,$00,$01,$99,$66	; $ADA4
	dc.b	$4e,$75	; $ADAA
	dc.b	$3f,$0c	; $ADAC
	dc.b	$38,$78,$99,$82	; $ADAE
	dc.b	$30,$2c,$ce,$02	; $ADB2
	dc.b	$6b,$04	; $ADB6
	dc.b	$4e,$b8,$27,$30	; $ADB8
	dc.b	$70,$00	; $ADBC
	dc.b	$10,$2c,$d8,$01	; $ADBE
	dc.b	$3c,$2c,$c8,$00	; $ADC2
	dc.b	$7e,$10	; $ADC6
	dc.b	$de,$6c,$c9,$00	; $ADC8
	dc.b	$61,$00,$f8,$98	; $ADCC
	dc.b	$70,$02	; $ADD0
	dc.b	$4e,$b8,$07,$e8	; $ADD2
	dc.b	$00,$78,$80,$00,$99,$94	; $ADD6
	dc.b	$4a,$6c,$ce,$02	; $ADDC
	dc.b	$6a,$06	; $ADE0
	dc.b	$19,$7c,$00,$40,$d8,$00	; $ADE2
	dc.b	$38,$5f	; $ADE8
	dc.b	$4e,$75	; $ADEA
	dc.b	$16,$12	; $ADEC
	dc.b	$e1,$4b	; $ADEE
	dc.b	$16,$2a,$00,$01	; $ADF0
	dc.b	$10,$03	; $ADF4
	dc.b	$08,$03,$00,$08	; $ADF6
	dc.b	$66,$0e	; $ADFA
	dc.b	$10,$03	; $ADFC
	dc.b	$4e,$b8,$27,$58	; $ADFE
	dc.b	$01,$30,$10,$00	; $AE02
	dc.b	$66,$42	; $AE06
	dc.b	$60,$06	; $AE08
	dc.b	$4e,$b8,$27,$4c	; $AE0A
	dc.b	$66,$3a	; $AE0E
	dc.b	$78,$00	; $AE10
	dc.b	$18,$2a,$00,$02	; $AE12
	dc.b	$e9,$4c	; $AE16
	dc.b	$06,$44,$0f,$00	; $AE18
	dc.b	$7a,$00	; $AE1C
	dc.b	$1a,$2a,$00,$03	; $AE1E
	dc.b	$e9,$4d	; $AE22
	dc.b	$06,$45,$0f,$00	; $AE24
	dc.b	$1e,$2a,$00,$04	; $AE28
	dc.b	$1c,$07	; $AE2C
	dc.b	$02,$46,$00,$0f	; $AE2E
	dc.b	$e9,$4e	; $AE32
	dc.b	$02,$47,$00,$f0	; $AE34
	dc.b	$10,$2a,$00,$05	; $AE38
	dc.b	$e1,$48	; $AE3C
	dc.b	$10,$2a,$00,$06	; $AE3E
	dc.b	$41,$f2,$00,$05	; $AE42
	dc.b	$4e,$b8,$2a,$6c	; $AE46
	dc.b	$60,$00,$fd,$ea	; $AE4A
	dc.b	$11,$ea,$00,$01,$9a,$8b	; $AE4E
	dc.b	$30,$3c,$01,$00	; $AE54
	dc.b	$10,$2a,$00,$02	; $AE58
	dc.b	$e9,$48	; $AE5C
	dc.b	$31,$c0,$9a,$8c	; $AE5E
	dc.b	$30,$3c,$01,$00	; $AE62
	dc.b	$10,$2a,$00,$03	; $AE66
	dc.b	$e9,$48	; $AE6A
	dc.b	$31,$c0,$9a,$8e	; $AE6C
	dc.b	$10,$12	; $AE70
	dc.b	$4e,$b8,$27,$4c	; $AE72
	dc.b	$66,$22	; $AE76
	dc.b	$11,$d2,$9a,$8a	; $AE78
	dc.b	$30,$3c,$01,$00	; $AE7C
	dc.b	$10,$2a,$00,$04	; $AE80
	dc.b	$e9,$48	; $AE84
	dc.b	$31,$c0,$9a,$90	; $AE86
	dc.b	$30,$3c,$01,$00	; $AE8A
	dc.b	$10,$2a,$00,$05	; $AE8E
	dc.b	$e9,$48	; $AE92
	dc.b	$31,$c0,$9a,$92	; $AE94
	dc.b	$60,$04	; $AE98
	dc.b	$4e,$b8,$2c,$08	; $AE9A
	dc.b	$60,$00,$fd,$96	; $AE9E
	dc.b	$38,$7c,$00,$e0	; $AEA2
	dc.b	$42,$78,$99,$fe	; $AEA6
	dc.b	$4a,$2c,$c0,$00	; $AEAA
	dc.b	$6a,$0c	; $AEAE
	dc.b	$30,$2c,$d4,$02	; $AEB0
	dc.b	$d0,$40	; $AEB4
	dc.b	$20,$7b,$00,$14	; $AEB6
	dc.b	$4e,$90	; $AEBA
	dc.b	$58,$4c	; $AEBC
	dc.b	$52,$78,$99,$fe	; $AEBE
	dc.b	$0c,$78,$00,$08,$99,$fe	; $AEC2
	dc.b	$65,$e0	; $AEC8
	dc.b	$4e,$75	; $AECA
	dc.b	$00,$00,$af,$16	; $AECC
	dc.b	$00,$00,$b0,$0a	; $AED0
	dc.b	$00,$00,$ae,$f0	; $AED4
	dc.b	$00,$00,$ae,$f2	; $AED8
	dc.b	$00,$00,$b0,$da	; $AEDC
	dc.b	$00,$00,$af,$06	; $AEE0
	dc.b	$00,$01,$a1,$c6	; $AEE4
	dc.b	$00,$00,$b2,$36	; $AEE8
	dc.b	$00,$00,$ac,$fa	; $AEEC
	dc.b	$4e,$75	; $AEF0
	dc.b	$08,$2c,$00,$06,$c0,$00	; $AEF2
	dc.b	$67,$0a	; $AEF8
	dc.b	$10,$2c,$c6,$00	; $AEFA
	dc.b	$66,$04	; $AEFE
	dc.b	$19,$40,$c0,$00	; $AF00
	dc.b	$4e,$75	; $AF04
	dc.b	$4e,$b8,$0a,$b4	; $AF06
	dc.b	$53,$6c,$da,$00	; $AF0A
	dc.b	$66,$04	; $AF0E
	dc.b	$42,$2c,$c0,$00	; $AF10
	dc.b	$4e,$75	; $AF14
	dc.b	$08,$2c,$00,$06,$c0,$00	; $AF16
	dc.b	$66,$3e	; $AF1C
	dc.b	$4e,$b8,$0a,$36	; $AF1E
	dc.b	$39,$7c,$06,$04,$c3,$00	; $AF22
	dc.b	$70,$00	; $AF28
	dc.b	$4e,$b8,$07,$e8	; $AF2A
	dc.b	$19,$7c,$00,$14,$c3,$03	; $AF2E
	dc.b	$39,$7c,$00,$50,$cc,$02	; $AF34
	dc.b	$00,$2c,$00,$02,$d1,$00	; $AF3A
	dc.b	$39,$7c,$08,$00,$cd,$02	; $AF40
	dc.b	$61,$58	; $AF46
	dc.b	$50,$40	; $AF48
	dc.b	$39,$40,$c8,$00	; $AF4A
	dc.b	$50,$41	; $AF4E
	dc.b	$39,$41,$c9,$00	; $AF50
	dc.b	$00,$2c,$00,$40,$c0,$00	; $AF54
	rts	; $AF5A
	dc.b	$4a,$2c,$d4,$01	; $AF5C
	dc.b	$66,$14	; $AF60
	dc.b	$52,$2c,$d4,$01	; $AF62
	dc.b	$61,$38	; $AF66
	dc.b	$3c,$00	; $AF68
	dc.b	$e8,$4e	; $AF6A
	dc.b	$3e,$01	; $AF6C
	dc.b	$e5,$4f	; $AF6E
	dc.b	$70,$00	; $AF70
	dc.b	$4e,$b8,$26,$6c	; $AF72
	dc.b	$4e,$b8,$0b,$44	; $AF76
	dc.b	$4e,$b8,$0a,$d6	; $AF7A
	dc.b	$61,$20	; $AF7E
	dc.b	$50,$42	; $AF80
	dc.b	$b4,$6c,$c9,$00	; $AF82
	dc.b	$62,$16	; $AF86
	dc.b	$51,$42	; $AF88
	dc.b	$3c,$00	; $AF8A
	dc.b	$e8,$4e	; $AF8C
	dc.b	$3e,$02	; $AF8E
	dc.b	$e5,$4f	; $AF90
	dc.b	$30,$3c,$03,$00	; $AF92
	dc.b	$4e,$b8,$26,$6c	; $AF96
	dc.b	$42,$2c,$c0,$00	; $AF9A
	dc.b	$4e,$75	; $AF9E
	dc.b	$72,$00	; $AFA0
	dc.b	$12,$2c,$da,$02	; $AFA2
	dc.b	$70,$00	; $AFA6
	dc.b	$10,$3b,$10,$1e	; $AFA8
	dc.b	$e9,$48	; $AFAC
	dc.b	$06,$40,$10,$00	; $AFAE
	dc.b	$74,$00	; $AFB2
	dc.b	$14,$3b,$10,$14	; $AFB4
	dc.b	$e9,$4a	; $AFB8
	dc.b	$12,$3b,$10,$0d	; $AFBA
	dc.b	$e9,$49	; $AFBE
	dc.b	$06,$41,$10,$00	; $AFC0
	dc.b	$d4,$41	; $AFC4
	dc.b	$4e,$75	; $AFC6
	dc.b	$12,$0c	; $AFC8
	dc.b	$07,$13,$0c,$08	; $AFCA
	dc.b	$14,$0c	; $AFCE
	dc.b	$08,$1b,$0c,$08	; $AFD0
	dc.b	$1c,$0c	; $AFD4
	dc.b	$08,$1d,$0c,$07	; $AFD6
	dc.b	$12,$0d	; $AFDA
	dc.b	$07,$13	; $AFDC
	dc.b	$0d,$08,$14,$0d	; $AFDE
	dc.b	$08,$1b,$0d,$08	; $AFE2
	dc.b	$1c,$0d	; $AFE6
	dc.b	$08,$1d,$0d,$07	; $AFE8
	dc.b	$12,$0e	; $AFEC
	dc.b	$07,$1d	; $AFEE
	dc.b	$0e,$07,$15,$10	; $AFF0
	dc.b	$04,$1a,$10,$04	; $AFF4
	dc.b	$15,$11	; $AFF8
	dc.b	$04,$16,$11,$04	; $AFFA
	dc.b	$17,$11	; $AFFE
	dc.b	$04,$18,$11,$04	; $B000
	dc.b	$19,$11	; $B004
	dc.b	$04,$1a,$11,$04	; $B006
	dc.b	$08,$2c,$00,$06,$c0,$00	; $B00A
	dc.b	$66,$64	; $B010
	dc.b	$32,$2c,$da,$00	; $B012
	dc.b	$19,$7b,$10,$58,$c3,$00	; $B016
	dc.b	$19,$7b,$10,$53,$c3,$01	; $B01C
	dc.b	$10,$3b,$10,$4e	; $B022
	dc.b	$4e,$b8,$07,$e8	; $B026
	dc.b	$19,$7c,$00,$14,$c3,$03	; $B02A
	dc.b	$30,$2c,$db,$00	; $B030
	dc.b	$e9,$48	; $B034
	dc.b	$50,$40	; $B036
	dc.b	$39,$40,$c8,$00	; $B038
	dc.b	$30,$2c,$db,$02	; $B03C
	dc.b	$e4,$48	; $B040
	dc.b	$50,$40	; $B042
	dc.b	$39,$40,$c9,$00	; $B044
	dc.b	$39,$7c,$00,$41,$cc,$02	; $B048
	dc.b	$39,$7c,$04,$80,$cd,$02	; $B04E
	dc.b	$00,$2c,$00,$02,$d1,$00	; $B054
	dc.b	$00,$2c,$00,$40,$c0,$00	; $B05A
	dc.b	$19,$7c,$00,$01,$ce,$02	; $B060
	dc.b	$61,$64	; $B066
	dc.b	$30,$3c,$02,$68	; $B068
	dc.b	$4e,$f8,$26,$66	; $B06C
	dc.b	$06,$02,$06,$06	; $B070
	dc.b	$04,$00,$10,$2c	; $B074
	dc.b	$d4,$01	; $B078
	dc.b	$66,$14	; $B07A
	dc.b	$53,$2c,$ce,$02	; $B07C
	dc.b	$66,$1a	; $B080
	dc.b	$52,$2c,$d4,$01	; $B082
	dc.b	$61,$44	; $B086
	dc.b	$70,$00	; $B088
	dc.b	$4e,$b8,$26,$70	; $B08A
	dc.b	$60,$04	; $B08E
	dc.b	$53,$00	; $B090
	dc.b	$66,$2c	; $B092
	dc.b	$08,$2c,$00,$00,$c0,$00	; $B094
	dc.b	$67,$2a	; $B09A
	dc.b	$4e,$b8,$0b,$44	; $B09C
	dc.b	$4e,$b8,$0a,$d6	; $B0A0
	dc.b	$4e,$b8,$3f,$54	; $B0A4
	dc.b	$08,$38,$00,$03,$9e,$df	; $B0A8
	dc.b	$67,$1a	; $B0AE
	dc.b	$52,$2c,$d4,$01	; $B0B0
	dc.b	$39,$7c,$12,$08,$c3,$00	; $B0B4
	dc.b	$70,$00	; $B0BA
	dc.b	$4e,$f8,$07,$e8	; $B0BC
	dc.b	$4a,$2c,$c6,$00	; $B0C0
	dc.b	$66,$04	; $B0C4
	dc.b	$42,$2c,$c0,$00	; $B0C6
	dc.b	$4e,$75	; $B0CA
	dc.b	$3c,$2c,$db,$00	; $B0CC
	dc.b	$3e,$2c,$db,$02	; $B0D0
	dc.b	$47,$f8,$97,$54	; $B0D4
	dc.b	$4e,$75	; $B0D8
	dc.b	$08,$2c,$00,$06,$c0,$00	; $B0DA
	dc.b	$66,$4e	; $B0E0
	dc.b	$4e,$b8,$0a,$36	; $B0E2
	dc.b	$30,$2c,$d3,$00	; $B0E6
	dc.b	$39,$7b,$00,$3c,$c8,$00	; $B0EA
	dc.b	$39,$7c,$10,$b0,$c9,$00	; $B0F0
	dc.b	$39,$7c,$00,$40,$cc,$02	; $B0F6
	dc.b	$42,$2c,$d1,$00	; $B0FC
	dc.b	$42,$2c,$d8,$00	; $B100
	dc.b	$39,$7c,$04,$20,$c2,$02	; $B104
	dc.b	$39,$7c,$0a,$14,$c3,$00	; $B10A
	dc.b	$19,$7c,$00,$16,$c3,$03	; $B110
	dc.b	$70,$00	; $B116
	dc.b	$4e,$b8,$07,$e8	; $B118
	dc.b	$42,$2c,$d4,$01	; $B11C
	dc.b	$00,$2c,$00,$40,$c0,$00	; $B120
	dc.b	$4e,$75	; $B126
	dc.b	$15,$00	; $B128
	dc.b	$15,$30,$15,$60,$15,$90	; $B12A
	dc.b	$10,$2c,$d4,$01	; $B130
	dc.b	$66,$52	; $B134
	dc.b	$4a,$6c,$d3,$00	; $B136
	dc.b	$66,$22	; $B13A
	dc.b	$30,$38,$96,$5a	; $B13C
	dc.b	$02,$40,$00,$3f	; $B140
	dc.b	$66,$38	; $B144
	dc.b	$34,$78,$9e,$ee	; $B146
	dc.b	$30,$2c,$c8,$00	; $B14A
	dc.b	$90,$6a,$c8,$00	; $B14E
	dc.b	$64,$02	; $B152
	dc.b	$44,$40	; $B154
	dc.b	$0c,$40,$00,$10	; $B156
	dc.b	$65,$22	; $B15A
	dc.b	$60,$0c	; $B15C
	dc.b	$4a,$2c,$d8,$00	; $B15E
	dc.b	$67,$1a	; $B162
	dc.b	$53,$2c,$d8,$00	; $B164
	dc.b	$66,$14	; $B168
	dc.b	$52,$2c,$d4,$01	; $B16A
	dc.b	$30,$2c,$d3,$00	; $B16E
	dc.b	$39,$7b,$00,$0c,$ca,$02	; $B172
	dc.b	$70,$02	; $B178
	dc.b	$4e,$f8,$07,$e8	; $B17A
	dc.b	$4e,$75,$fb,$00,$fa,$80,$fa,$00,$f9,$80	; $B17E
	dc.b	$53,$00	; $B188
	dc.b	$66,$00,$00,$7c	; $B18A
	dc.b	$4e,$b8,$0b,$44	; $B18E
	dc.b	$4e,$b8,$0a,$d6	; $B192
	dc.b	$34,$78,$9e,$ee	; $B196
	dc.b	$0c,$6c,$10,$a0,$c9,$00	; $B19A
	dc.b	$64,$5e	; $B1A0
	dc.b	$30,$2a,$c8,$00	; $B1A2
	dc.b	$90,$6c,$c8,$00	; $B1A6
	dc.b	$64,$02	; $B1AA
	dc.b	$44,$40	; $B1AC
	dc.b	$0c,$40,$00,$12	; $B1AE
	dc.b	$64,$4c	; $B1B2
	dc.b	$74,$16	; $B1B4
	dc.b	$30,$2a,$c9,$00	; $B1B6
	dc.b	$d0,$42	; $B1BA
	dc.b	$b0,$6c,$c9,$00	; $B1BC
	dc.b	$65,$3e	; $B1C0
	dc.b	$32,$2a,$d2,$02	; $B1C2
	dc.b	$d2,$42	; $B1C6
	dc.b	$b2,$6c,$d2,$02	; $B1C8
	dc.b	$64,$32	; $B1CC
	dc.b	$39,$40,$c9,$00	; $B1CE
	dc.b	$52,$2c,$d4,$01	; $B1D2
	dc.b	$30,$2c,$d3,$02	; $B1D6
	dc.b	$67,$08	; $B1DA
	dc.b	$30,$40	; $B1DC
	dc.b	$11,$7c,$00,$18,$d8,$00	; $B1DE
	dc.b	$30,$3c,$fa,$00	; $B1E4
	dc.b	$c5,$4c	; $B1E8
	dc.b	$61,$00,$3a,$1c	; $B1EA
	dc.b	$c5,$4c	; $B1EE
	dc.b	$70,$33	; $B1F0
	dc.b	$4e,$b8,$03,$66	; $B1F2
	dc.b	$42,$6c,$ca,$02	; $B1F6
	dc.b	$70,$04	; $B1FA
	dc.b	$4e,$f8,$07,$e8	; $B1FC
	dc.b	$4a,$6c,$ca,$02	; $B200
	dc.b	$6a,$0a	; $B204
	dc.b	$4e,$75	; $B206
	dc.b	$4e,$b8,$0b,$44	; $B208
	dc.b	$4e,$b8,$0a,$d6	; $B20C
	dc.b	$30,$3c,$10,$b0	; $B210
	dc.b	$b0,$6c,$c9,$00	; $B214
	dc.b	$64,$1a	; $B218
	dc.b	$39,$40,$c9,$00	; $B21A
	dc.b	$39,$40,$d2,$02	; $B21E
	dc.b	$70,$00	; $B222
	dc.b	$19,$40,$d4,$01	; $B224
	dc.b	$19,$40,$d8,$00	; $B228
	dc.b	$4e,$b8,$07,$e8	; $B22C
	dc.b	$42,$2c,$d4,$01	; $B230
	dc.b	$4e,$75	; $B234
	dc.b	$08,$2c,$00,$06,$c0,$00	; $B236
	dc.b	$66,$48	; $B23C
	dc.b	$4e,$b8,$0a,$36	; $B23E
	dc.b	$39,$7c,$16,$22,$c3,$00	; $B242
	dc.b	$70,$00	; $B248
	dc.b	$4e,$b8,$07,$e8	; $B24A
	dc.b	$19,$7c,$00,$0e,$c3,$03	; $B24E
	dc.b	$00,$2c,$00,$80,$c0,$02	; $B254
	dc.b	$30,$78,$9e,$ee	; $B25A
	dc.b	$30,$28,$c8,$00	; $B25E
	dc.b	$50,$40	; $B262
	dc.b	$39,$40,$c8,$00	; $B264
	dc.b	$30,$28,$c9,$00	; $B268
	dc.b	$54,$40	; $B26C
	dc.b	$39,$40,$c9,$00	; $B26E
	dc.b	$39,$7c,$00,$04,$d8,$00	; $B272
	dc.b	$39,$7c,$02,$00,$ca,$00	; $B278
	dc.b	$00,$2c,$00,$40,$c0,$00	; $B27E
	dc.b	$4e,$75	; $B284
	dc.b	$4e,$b8,$0a,$b8	; $B286
	dc.b	$0c,$6c,$10,$50,$c8,$00	; $B28A
	dc.b	$65,$06	; $B290
	dc.b	$42,$2c,$c0,$00	; $B292
	dc.b	$4e,$75	; $B296
	dc.b	$53,$2c,$d8,$01	; $B298
	dc.b	$66,$f8	; $B29C
	dc.b	$19,$7c,$00,$04,$d8,$01	; $B29E
	dc.b	$54,$2c,$d8,$00	; $B2A4
	dc.b	$10,$2c,$d8,$00	; $B2A8
	dc.b	$0c,$00,$00,$08	; $B2AC
	dc.b	$64,$e4	; $B2B0
	dc.b	$52,$6c,$ca,$00	; $B2B2
	dc.b	$4e,$f8,$07,$e8	; $B2B6
	dc.b	$4e,$56,$ff,$fc	; $B2BA
	dc.b	$3f,$0c	; $B2BE
	dc.b	$3d,$46,$ff,$fe	; $B2C0
	dc.b	$3d,$47,$ff,$fc	; $B2C4
	dc.b	$70,$00	; $B2C8
	dc.b	$4e,$b8,$26,$6c	; $B2CA
	dc.b	$e9,$4e	; $B2CE
	dc.b	$58,$46	; $B2D0
	dc.b	$3d,$46,$ff,$fe	; $B2D2
	dc.b	$e4,$4f	; $B2D6
	dc.b	$58,$47	; $B2D8
	dc.b	$3d,$47,$ff,$fc	; $B2DA
	dc.b	$32,$06	; $B2DE
	dc.b	$34,$07	; $B2E0
	dc.b	$30,$3c,$02,$06	; $B2E2
	dc.b	$61,$00,$56,$24	; $B2E6
	dc.b	$66,$3c	; $B2EA
	dc.b	$32,$2e,$ff,$fe	; $B2EC
	dc.b	$50,$41	; $B2F0
	dc.b	$34,$2e,$ff,$fc	; $B2F2
	dc.b	$30,$3c,$02,$08	; $B2F6
	dc.b	$61,$00,$56,$10	; $B2FA
	dc.b	$66,$28	; $B2FE
	dc.b	$32,$2e,$ff,$fe	; $B300
	dc.b	$34,$2e,$ff,$fc	; $B304
	dc.b	$50,$42	; $B308
	dc.b	$30,$3c,$02,$0a	; $B30A
	dc.b	$61,$00,$55,$fc	; $B30E
	dc.b	$66,$14	; $B312
	dc.b	$32,$2e,$ff,$fe	; $B314
	dc.b	$50,$41	; $B318
	dc.b	$34,$2e,$ff,$fc	; $B31A
	dc.b	$50,$42	; $B31E
	dc.b	$30,$3c,$02,$0c	; $B320
	dc.b	$61,$00,$55,$e6	; $B324
	dc.b	$38,$5f	; $B328
	dc.b	$4e,$5e	; $B32A
	dc.b	$4e,$75	; $B32C
	dc.b	$08,$38,$00,$03,$96,$6b	; $B32E
	dc.b	$67,$5c	; $B334
	dc.b	$38,$78,$9e,$ee	; $B336
	dc.b	$10,$2c,$cf,$00	; $B33A
	dc.b	$02,$40,$00,$0a	; $B33E
	dc.b	$55,$40	; $B342
	dc.b	$66,$4c	; $B344
	dc.b	$7e,$00	; $B346
	dc.b	$1e,$2c,$cb,$03	; $B348
	dc.b	$de,$6c,$c9,$00	; $B34C
	dc.b	$30,$07	; $B350
	dc.b	$02,$40,$00,$0f	; $B352
	dc.b	$66,$3a	; $B356
	dc.b	$e5,$4f	; $B358
	dc.b	$3c,$2c,$c8,$00	; $B35A
	dc.b	$e8,$4e	; $B35E
	dc.b	$47,$f8,$97,$54	; $B360
	dc.b	$4e,$b8,$30,$da	; $B364
	dc.b	$0c,$01,$00,$0d	; $B368
	dc.b	$67,$1e	; $B36C
	dc.b	$08,$02,$00,$02	; $B36E
	dc.b	$66,$1e	; $B372
	dc.b	$30,$2c,$c8,$00	; $B374
	dc.b	$02,$40,$00,$0f	; $B378
	dc.b	$51,$40	; $B37C
	dc.b	$64,$06	; $B37E
	dc.b	$61,$12	; $B380
	dc.b	$66,$0e	; $B382
	dc.b	$60,$42	; $B384
	dc.b	$61,$40	; $B386
	dc.b	$66,$08	; $B388
	dc.b	$60,$08	; $B38A
	dc.b	$7a,$00	; $B38C
	dc.b	$61,$00,$00,$70	; $B38E
	dc.b	$4e,$75	; $B392
	dc.b	$70,$00	; $B394
	dc.b	$10,$2c,$cb,$02	; $B396
	dc.b	$32,$2c,$c8,$00	; $B39A
	dc.b	$02,$41,$00,$0f	; $B39E
	dc.b	$92,$40	; $B3A2
	dc.b	$64,$14	; $B3A4
	dc.b	$53,$46	; $B3A6
	dc.b	$4e,$b8,$30,$da	; $B3A8
	dc.b	$0c,$01,$00,$0d	; $B3AC
	dc.b	$67,$0c	; $B3B0
	dc.b	$52,$46	; $B3B2
	dc.b	$08,$02,$00,$02	; $B3B4
	dc.b	$66,$0a	; $B3B8
	dc.b	$70,$00	; $B3BA
	dc.b	$4e,$75	; $B3BC
	dc.b	$7a,$00	; $B3BE
	dc.b	$61,$00,$00,$3e	; $B3C0
	dc.b	$70,$ff	; $B3C4
	dc.b	$4e,$75	; $B3C6
	dc.b	$70,$00	; $B3C8
	dc.b	$10,$2c,$cb,$02	; $B3CA
	dc.b	$32,$2c,$c8,$00	; $B3CE
	dc.b	$02,$41,$00,$0f	; $B3D2
	dc.b	$d2,$40	; $B3D6
	dc.b	$0c,$41,$00,$10	; $B3D8
	dc.b	$65,$14	; $B3DC
	dc.b	$52,$46	; $B3DE
	dc.b	$4e,$b8,$30,$da	; $B3E0
	dc.b	$0c,$01,$00,$0d	; $B3E4
	dc.b	$67,$0c	; $B3E8
	dc.b	$53,$46	; $B3EA
	dc.b	$08,$02,$00,$02	; $B3EC
	dc.b	$66,$0a	; $B3F0
	dc.b	$70,$00	; $B3F2
	dc.b	$4e,$75	; $B3F4
	dc.b	$7a,$00	; $B3F6
	dc.b	$61,$00,$00,$06	; $B3F8
	dc.b	$70,$ff	; $B3FC
	dc.b	$4e,$75	; $B3FE
	dc.b	$4e,$b8,$27,$e6	; $B400
	dc.b	$6b,$22	; $B404
	dc.b	$4e,$b8,$0a,$36	; $B406
	dc.b	$39,$45,$da,$00	; $B40A
	dc.b	$39,$46,$db,$00	; $B40E
	dc.b	$39,$47,$db,$02	; $B412
	dc.b	$39,$7c,$00,$02,$d4,$02	; $B416
	dc.b	$19,$7c,$00,$80,$c0,$00	; $B41C
	dc.b	$70,$4b	; $B422
	dc.b	$4e,$f8,$03,$66	; $B424
	dc.b	$4e,$75	; $B428
	dc.b	$0c,$00,$00,$40	; $B42A
	dc.b	$66,$0e	; $B42E
	dc.b	$0c,$78,$0e,$00,$9f,$00	; $B430
	dc.b	$65,$22	; $B436
	dc.b	$30,$3c,$10,$2a	; $B438
	dc.b	$60,$06	; $B43C
	dc.b	$0c,$00,$00,$2a	; $B43E
	dc.b	$66,$16	; $B442
	dc.b	$48,$a7,$e2,$00	; $B444
	dc.b	$4e,$b8,$23,$e4	; $B448
	dc.b	$4c,$9f,$00,$47	; $B44C
	dc.b	$67,$08	; $B450
	dc.b	$70,$1a	; $B452
	dc.b	$4e,$f9,$00,$01,$09,$16	; $B454
	dc.b	$4a,$78,$99,$62	; $B45A
	dc.b	$66,$00,$00,$38	; $B45E
	dc.b	$36,$00	; $B462
	dc.b	$26,$4c	; $B464
	dc.b	$4e,$b8,$27,$e6	; $B466
	dc.b	$6b,$28	; $B46A
	dc.b	$19,$7c,$00,$80,$c0,$00	; $B46C
	dc.b	$39,$41,$c8,$00	; $B472
	dc.b	$39,$42,$c9,$00	; $B476
	dc.b	$02,$43,$00,$ff	; $B47A
	dc.b	$39,$43,$dd,$00	; $B47E
	dc.b	$31,$cc,$99,$68	; $B482
	dc.b	$39,$7c,$00,$04,$d4,$02	; $B486
	dc.b	$31,$fc,$00,$09,$99,$62	; $B48C
	dc.b	$70,$00	; $B492
	dc.b	$28,$4b	; $B494
	dc.b	$4e,$75	; $B496
	dc.b	$70,$ff	; $B498
	dc.b	$4e,$75	; $B49A
	dc.b	$32,$7c,$00,$00	; $B49C
	dc.b	$70,$0f	; $B4A0
	dc.b	$4a,$29,$9a,$96	; $B4A2
	dc.b	$6a,$08	; $B4A6
	dc.b	$58,$49	; $B4A8
	dc.b	$51,$c8,$ff,$f6	; $B4AA
	dc.b	$4e,$75	; $B4AE
	dc.b	$10,$18	; $B4B0
	dc.b	$13,$58,$9a,$99	; $B4B2
	dc.b	$72,$80	; $B4B6
	dc.b	$53,$00	; $B4B8
	dc.b	$62,$08	; $B4BA
	dc.b	$66,$04	; $B4BC
	dc.b	$72,$e0	; $B4BE
	dc.b	$60,$02	; $B4C0
	dc.b	$72,$c0	; $B4C2
	dc.b	$10,$18	; $B4C4
	dc.b	$6a,$06	; $B4C6
	dc.b	$02,$00,$00,$7f	; $B4C8
	dc.b	$52,$01	; $B4CC
	dc.b	$13,$40,$9a,$97	; $B4CE
	dc.b	$13,$41,$9a,$96	; $B4D2
	dc.b	$13,$58,$9a,$98	; $B4D6
	dc.b	$30,$3c,$01,$00	; $B4DA
	dc.b	$32,$00	; $B4DE
	dc.b	$10,$18	; $B4E0
	dc.b	$33,$40,$9a,$d6	; $B4E2
	dc.b	$12,$18	; $B4E6
	dc.b	$ed,$49	; $B4E8
	dc.b	$33,$41,$9a,$d8	; $B4EA
	dc.b	$13,$58,$9b,$18	; $B4EE
	dc.b	$13,$58,$9b,$19	; $B4F2
	dc.b	$70,$ff	; $B4F6
	dc.b	$4e,$75	; $B4F8
	dc.b	$70,$00	; $B4FA
	dc.b	$30,$40	; $B4FC
	dc.b	$72,$0f	; $B4FE
	dc.b	$11,$40,$9a,$96	; $B500
	dc.b	$58,$48	; $B504
	dc.b	$51,$c9,$ff,$f8	; $B506
	dc.b	$4e,$75	; $B50A
	dc.b	$38,$7c,$00,$00	; $B50C
	dc.b	$70,$0f	; $B510
	dc.b	$4a,$2c,$9a,$96	; $B512
	dc.b	$6a,$06	; $B516
	dc.b	$3f,$00	; $B518
	dc.b	$61,$0a	; $B51A
	dc.b	$30,$1f	; $B51C
	dc.b	$58,$4c	; $B51E
	dc.b	$51,$c8,$ff,$f0	; $B520
	dc.b	$4e,$75	; $B524
	dc.b	$61,$00,$01,$64	; $B526
	dc.b	$61,$00,$01,$d6	; $B52A
	dc.b	$67,$06	; $B52E
	dc.b	$42,$2c,$9a,$96	; $B530
	dc.b	$4e,$75	; $B534
	dc.b	$08,$2c,$00,$00,$9a,$96	; $B536
	dc.b	$66,$0c	; $B53C
	dc.b	$19,$6c,$9b,$19,$9b,$56	; $B53E
	dc.b	$42,$2c,$9b,$58	; $B544
	dc.b	$4e,$75	; $B548
	dc.b	$19,$6c,$9b,$18,$9b,$56	; $B54A
	dc.b	$72,$00	; $B550
	dc.b	$12,$2c,$9a,$98	; $B552
	dc.b	$19,$41,$9b,$58	; $B556
	dc.b	$70,$00	; $B55A
	dc.b	$10,$2c,$9a,$97	; $B55C
	dc.b	$d0,$40	; $B560
	dc.b	$41,$fa,$01,$d8	; $B562
	dc.b	$3c,$2c,$9a,$d6	; $B566
	dc.b	$3e,$2c,$9a,$d8	; $B56A
	dc.b	$34,$30,$00,$00	; $B56E
	dc.b	$41,$fa,$00,$30	; $B572
	dc.b	$d0,$f0,$00,$00	; $B576
	dc.b	$4e,$90	; $B57A
	dc.b	$4e,$b8,$28,$12	; $B57C
	dc.b	$61,$00,$01,$a2	; $B580
	dc.b	$60,$00,$02,$20	; $B584
	dc.b	$52,$46	; $B588
	dc.b	$60,$02	; $B58A
	dc.b	$9c,$41	; $B58C
	dc.b	$30,$01	; $B58E
	dc.b	$72,$02	; $B590
	dc.b	$4e,$75	; $B592
	dc.b	$06,$47,$00,$40	; $B594
	dc.b	$60,$06	; $B598
	dc.b	$30,$01	; $B59A
	dc.b	$ed,$48	; $B59C
	dc.b	$9e,$40	; $B59E
	dc.b	$70,$02	; $B5A0
	dc.b	$4e,$75,$ff,$e4,$ff,$f0,$ff,$e8,$ff,$f6	; $B5A2
	dc.b	$38,$7c,$00,$00	; $B5AC
	dc.b	$70,$0f	; $B5B0
	dc.b	$4a,$2c,$9a,$96	; $B5B2
	dc.b	$6a,$06	; $B5B6
	dc.b	$3f,$00	; $B5B8
	dc.b	$61,$0a	; $B5BA
	dc.b	$30,$1f	; $B5BC
	dc.b	$58,$4c	; $B5BE
	dc.b	$51,$c8,$ff,$f0	; $B5C0
	dc.b	$4e,$75	; $B5C4
	dc.b	$61,$00,$01,$f0	; $B5C6
	dc.b	$08,$2c,$00,$01,$9a,$96	; $B5CA
	dc.b	$67,$54	; $B5D0
	dc.b	$53,$2c,$9b,$16	; $B5D2
	dc.b	$66,$3e	; $B5D6
	dc.b	$08,$2c,$00,$02,$9a,$96	; $B5D8
	dc.b	$66,$20	; $B5DE
	dc.b	$61,$00,$01,$62	; $B5E0
	dc.b	$10,$2c,$9b,$58	; $B5E4
	dc.b	$b0,$2c,$9a,$98	; $B5E8
	dc.b	$65,$00,$01,$36	; $B5EC
	dc.b	$19,$6c,$9b,$18,$9b,$56	; $B5F0
	dc.b	$02,$2c,$00,$fd,$9a,$96	; $B5F6
	dc.b	$60,$00,$01,$26	; $B5FC
	dc.b	$61,$00,$01,$9a	; $B600
	dc.b	$4a,$2c,$9b,$58	; $B604
	dc.b	$66,$00,$01,$1a	; $B608
	dc.b	$61,$00,$00,$f4	; $B60C
	dc.b	$67,$06	; $B610
	dc.b	$42,$2c,$9a,$96	; $B612
	dc.b	$4e,$75	; $B616
	dc.b	$19,$6c,$9b,$19,$9b,$56	; $B618
	dc.b	$02,$2c,$00,$f8,$9a,$96	; $B61E
	dc.b	$4e,$75	; $B624
	dc.b	$61,$00,$00,$da	; $B626
	dc.b	$67,$16	; $B62A
	dc.b	$08,$2c,$00,$00,$9a,$96	; $B62C
	dc.b	$66,$06	; $B632
	dc.b	$42,$2c,$9a,$96	; $B634
	dc.b	$4e,$75	; $B638
	dc.b	$00,$2c,$00,$06,$9a,$96	; $B63A
	dc.b	$4e,$75	; $B640
	dc.b	$4a,$2c,$9b,$56	; $B642
	dc.b	$67,$2c	; $B646
	dc.b	$08,$2c,$00,$00,$9a,$96	; $B648
	dc.b	$66,$16	; $B64E
	dc.b	$53,$2c,$9b,$56	; $B650
	dc.b	$66,$1c	; $B654
	dc.b	$19,$7c,$00,$01,$9b,$16	; $B656
	dc.b	$00,$2c,$00,$03,$9a,$96	; $B65C
	dc.b	$60,$00,$01,$42	; $B662
	dc.b	$53,$2c,$9b,$56	; $B666
	dc.b	$66,$08	; $B66A
	dc.b	$00,$2c,$00,$06,$9a,$96	; $B66C
	dc.b	$4e,$75	; $B672
	dc.b	$53,$2c,$9b,$16	; $B674
	dc.b	$66,$f8	; $B678
	dc.b	$61,$00,$00,$a8	; $B67A
	dc.b	$70,$00	; $B67E
	dc.b	$10,$2c,$9b,$17	; $B680
	dc.b	$52,$00	; $B684
	dc.b	$0c,$00,$00,$03	; $B686
	dc.b	$65,$02	; $B68A
	dc.b	$70,$00	; $B68C
	dc.b	$19,$40,$9b,$17	; $B68E
	dc.b	$3c,$2c,$9a,$d6	; $B692
	dc.b	$3e,$2c,$9a,$d8	; $B696
	dc.b	$d0,$40	; $B69A
	dc.b	$72,$00	; $B69C
	dc.b	$12,$2c,$9a,$97	; $B69E
	dc.b	$34,$01	; $B6A2
	dc.b	$d2,$41	; $B6A4
	dc.b	$d2,$42	; $B6A6
	dc.b	$d2,$41	; $B6A8
	dc.b	$d0,$41	; $B6AA
	dc.b	$d0,$40	; $B6AC
	dc.b	$41,$fb,$00,$22	; $B6AE
	dc.b	$30,$18	; $B6B2
	dc.b	$3f,$10	; $B6B4
	dc.b	$08,$02,$00,$00	; $B6B6
	dc.b	$67,$08	; $B6BA
	dc.b	$4e,$b8,$26,$6c	; $B6BC
	dc.b	$52,$46	; $B6C0
	dc.b	$60,$08	; $B6C2
	dc.b	$4e,$b8,$26,$6c	; $B6C4
	dc.b	$06,$47,$00,$40	; $B6C8
	dc.b	$30,$1f	; $B6CC
	dc.b	$4e,$f8,$26,$70	; $B6CE
	dc.b	$02,$aa,$02,$ab,$02,$ae,$02,$af	; $B6D2
	dc.b	$02,$ac,$02,$ad,$02,$98,$02,$99	; $B6DA
	dc.b	$02,$9a,$02,$9b,$02,$9c	; $B6E2
	dc.b	$02,$9d,$02,$a4,$02,$a5	; $B6E8
	dc.b	$02,$a8,$02,$a9,$02,$a6,$02,$a7	; $B6EE
	dc.b	$02,$9e,$02,$9f,$02,$a0	; $B6F6
	dc.b	$02,$a1,$02,$a2,$02,$a3	; $B6FC
	dc.b	$08,$2c,$00,$06,$9a,$96	; $B702
	dc.b	$67,$18	; $B708
	dc.b	$10,$2c,$9a,$99	; $B70A
	dc.b	$08,$2c,$00,$05,$9a,$96	; $B70E
	dc.b	$67,$04	; $B714
	dc.b	$4e,$f8,$27,$4c	; $B716
	dc.b	$4e,$b8,$27,$58	; $B71A
	dc.b	$01,$30,$10,$00	; $B71E
	dc.b	$4e,$75	; $B722
	dc.b	$70,$00	; $B724
	dc.b	$10,$2c,$9b,$58	; $B726
	dc.b	$19,$7b,$00,$06,$9b,$16	; $B72A
	dc.b	$4e,$75	; $B730
	dc.b	$10,$0c,$0a,$08	; $B732
	dc.b	$06,$05,$04,$03	; $B736
	dc.b	$02,$00,$02,$b0	; $B73A
	dc.b	$02,$b1,$02,$b2,$02,$b3,$52,$2c	; $B73E
	dc.b	$9b,$58	; $B746
	dc.b	$70,$00	; $B748
	dc.b	$10,$2c,$9a,$97	; $B74A
	dc.b	$d0,$40	; $B74E
	dc.b	$30,$3b,$00,$ea	; $B750
	dc.b	$3c,$2c,$9a,$d6	; $B754
	dc.b	$3e,$2c,$9a,$d8	; $B758
	dc.b	$3f,$00	; $B75C
	dc.b	$72,$00	; $B75E
	dc.b	$12,$2c,$9b,$58	; $B760
	dc.b	$14,$2c,$9a,$97	; $B764
	dc.b	$66,$04	; $B768
	dc.b	$dc,$41	; $B76A
	dc.b	$60,$10	; $B76C
	dc.b	$53,$02	; $B76E
	dc.b	$66,$06	; $B770
	dc.b	$ed,$49	; $B772
	dc.b	$de,$41	; $B774
	dc.b	$60,$14	; $B776
	dc.b	$53,$02	; $B778
	dc.b	$66,$0c	; $B77A
	dc.b	$9c,$41	; $B77C
	dc.b	$4e,$b8,$26,$6c	; $B77E
	dc.b	$06,$47,$00,$40	; $B782
	dc.b	$60,$0a	; $B786
	dc.b	$ed,$49	; $B788
	dc.b	$9e,$41	; $B78A
	dc.b	$4e,$b8,$26,$6c	; $B78C
	dc.b	$52,$46	; $B790
	dc.b	$30,$1f	; $B792
	dc.b	$4e,$b8,$26,$70	; $B794
	dc.b	$60,$00,$fe,$e4	; $B798
	dc.b	$70,$00	; $B79C
	dc.b	$61,$b4	; $B79E
	dc.b	$53,$2c,$9b,$58	; $B7A0
	dc.b	$4e,$75	; $B7A4
	dc.b	$4e,$b8,$05,$d8	; $B7A6
	dc.b	$02,$00,$00,$7f	; $B7AA
	dc.b	$06,$00,$00,$0c	; $B7AE
	dc.b	$19,$40,$9b,$57	; $B7B2
	dc.b	$4e,$75	; $B7B6
	dc.b	$08,$2c,$00,$00,$9a,$96	; $B7B8
	dc.b	$67,$4c	; $B7BE
	dc.b	$53,$2c,$9b,$57	; $B7C0
	dc.b	$66,$46	; $B7C4
	dc.b	$4e,$b8,$05,$d8	; $B7C6
	dc.b	$32,$2c,$9a,$d6	; $B7CA
	dc.b	$e9,$49	; $B7CE
	dc.b	$34,$2c,$9a,$d8	; $B7D0
	dc.b	$e4,$4a	; $B7D4
	dc.b	$38,$00	; $B7D6
	dc.b	$02,$44,$00,$0f	; $B7D8
	dc.b	$50,$44	; $B7DC
	dc.b	$76,$00	; $B7DE
	dc.b	$16,$2c,$9a,$97	; $B7E0
	dc.b	$d6,$43	; $B7E4
	dc.b	$41,$fa,$00,$3a	; $B7E6
	dc.b	$d0,$f0,$30,$00	; $B7EA
	dc.b	$4e,$90	; $B7EE
	dc.b	$36,$3c,$02,$04	; $B7F0
	dc.b	$08,$00,$00,$08	; $B7F4
	dc.b	$67,$04	; $B7F8
	dc.b	$36,$3c,$02,$10	; $B7FA
	dc.b	$30,$03	; $B7FE
	dc.b	$61,$00,$51,$0a	; $B800
	dc.b	$60,$a0	; $B804
	dc.b	$06,$41,$00,$12	; $B806
	dc.b	$d4,$44	; $B80A
	dc.b	$4e,$75	; $B80C
	dc.b	$d2,$44	; $B80E
	dc.b	$06,$42,$00,$12	; $B810
	dc.b	$4e,$75	; $B814
	dc.b	$55,$41	; $B816
	dc.b	$d4,$44	; $B818
	dc.b	$4e,$75	; $B81A
	dc.b	$d2,$44	; $B81C
	dc.b	$55,$42	; $B81E
	dc.b	$4e,$75,$ff,$e4,$ff,$ec,$ff,$f4,$ff,$fa	; $B820
	dc.b	$41,$f8,$9b,$96	; $B82A
	dc.b	$72,$03	; $B82E
	dc.b	$4a,$10	; $B830
	dc.b	$6a,$08	; $B832
	dc.b	$50,$48	; $B834
	dc.b	$51,$c9,$ff,$f8	; $B836
	dc.b	$4e,$75	; $B83A
	dc.b	$72,$08	; $B83C
	dc.b	$c0,$41	; $B83E
	dc.b	$d0,$41	; $B840
	dc.b	$eb,$48	; $B842
	dc.b	$00,$40,$80,$01	; $B844
	dc.b	$30,$c0	; $B848
	dc.b	$42,$58	; $B84A
	dc.b	$30,$c6	; $B84C
	dc.b	$30,$c7	; $B84E
	dc.b	$4e,$75	; $B850
	dc.b	$41,$f8,$9b,$96	; $B852
	dc.b	$70,$00	; $B856
	dc.b	$72,$03	; $B858
	dc.b	$10,$80	; $B85A
	dc.b	$50,$48	; $B85C
	dc.b	$51,$c9,$ff,$fa	; $B85E
	dc.b	$4e,$75	; $B862
	dc.b	$49,$f8,$9b,$96	; $B864
	dc.b	$47,$f8,$97,$54	; $B868
	dc.b	$4a,$14	; $B86C
	dc.b	$6a,$58	; $B86E
	dc.b	$53,$2c,$00,$01	; $B870
	dc.b	$66,$52	; $B874
	dc.b	$19,$7c,$00,$03,$00,$01	; $B876
	dc.b	$3c,$2c,$00,$04	; $B87C
	dc.b	$3e,$2c,$00,$06	; $B880
	dc.b	$30,$2c,$00,$02	; $B884
	dc.b	$66,$06	; $B888
	dc.b	$61,$48	; $B88A
	dc.b	$66,$2c	; $B88C
	dc.b	$60,$36	; $B88E
	dc.b	$08,$14,$00,$01	; $B890
	dc.b	$66,$08	; $B894
	dc.b	$dc,$40	; $B896
	dc.b	$61,$3a	; $B898
	dc.b	$66,$02	; $B89A
	dc.b	$54,$14	; $B89C
	dc.b	$08,$14,$00,$00	; $B89E
	dc.b	$66,$0e	; $B8A2
	dc.b	$3c,$2c,$00,$04	; $B8A4
	dc.b	$9c,$6c,$00,$02	; $B8A8
	dc.b	$61,$26	; $B8AC
	dc.b	$66,$02	; $B8AE
	dc.b	$52,$14	; $B8B0
	dc.b	$70,$03	; $B8B2
	dc.b	$c0,$14	; $B8B4
	dc.b	$57,$00	; $B8B6
	dc.b	$67,$0c	; $B8B8
	dc.b	$52,$6c,$00,$02	; $B8BA
	dc.b	$0c,$6c,$00,$04,$00,$02	; $B8BE
	dc.b	$65,$02	; $B8C4
	dc.b	$42,$14	; $B8C6
	dc.b	$49,$ec,$00,$08	; $B8C8
	dc.b	$b8,$f8,$9b,$b6	; $B8CC
	dc.b	$65,$9a	; $B8D0
	dc.b	$4e,$75	; $B8D2
	dc.b	$32,$3c,$01,$00	; $B8D4
	dc.b	$bc,$41	; $B8D8
	dc.b	$65,$1e	; $B8DA
	dc.b	$30,$38,$97,$98	; $B8DC
	dc.b	$90,$41	; $B8E0
	dc.b	$bc,$40	; $B8E2
	dc.b	$64,$14	; $B8E4
	dc.b	$4e,$b8,$25,$42	; $B8E6
	dc.b	$0c,$40,$02,$b4	; $B8EA
	dc.b	$67,$16	; $B8EE
	dc.b	$04,$40,$00,$49	; $B8F0
	dc.b	$65,$04	; $B8F4
	dc.b	$55,$40	; $B8F6
	dc.b	$63,$04	; $B8F8
	dc.b	$70,$00	; $B8FA
	dc.b	$4e,$75	; $B8FC
	dc.b	$30,$3c,$02,$b4	; $B8FE
	dc.b	$4e,$b8,$26,$70	; $B902
	dc.b	$70,$ff	; $B906
	dc.b	$4e,$75	; $B908
	dc.b	$31,$fc,$9b,$f4,$9c,$14	; $B90A
	dc.b	$4e,$75	; $B910
	dc.b	$38,$7c,$00,$08	; $B912
	dc.b	$32,$3c,$04,$00	; $B916
	dc.b	$12,$00	; $B91A
	dc.b	$39,$41,$c3,$00	; $B91C
	dc.b	$4e,$b8,$0a,$1a	; $B920
	dc.b	$30,$38,$9b,$ca	; $B924
	dc.b	$e7,$48	; $B928
	dc.b	$d0,$78,$9b,$c6	; $B92A
	dc.b	$39,$40,$c8,$00	; $B92E
	dc.b	$30,$38,$9b,$cc	; $B932
	dc.b	$e7,$48	; $B936
	dc.b	$d0,$78,$9b,$c8	; $B938
	dc.b	$39,$40,$c9,$00	; $B93C
	dc.b	$70,$00	; $B940
	dc.b	$4e,$f8,$07,$e8	; $B942
	dc.b	$70,$02	; $B946
	dc.b	$60,$04	; $B948
	dc.b	$10,$38,$9b,$f2	; $B94A
	dc.b	$38,$7c,$00,$08	; $B94E
	dc.b	$32,$3c,$04,$00	; $B952
	dc.b	$12,$00	; $B956
	dc.b	$39,$41,$c3,$00	; $B958
	dc.b	$4e,$b8,$0a,$1a	; $B95C
	dc.b	$30,$38,$9b,$e2	; $B960
	dc.b	$52,$40	; $B964
	dc.b	$e9,$48	; $B966
	dc.b	$d0,$78,$9b,$da	; $B968
	dc.b	$39,$40,$c8,$00	; $B96C
	dc.b	$30,$38,$9b,$e4	; $B970
	dc.b	$52,$40	; $B974
	dc.b	$e9,$48	; $B976
	dc.b	$d0,$78,$9b,$dc	; $B978
	dc.b	$39,$40,$c9,$00	; $B97C
	dc.b	$70,$00	; $B980
	dc.b	$4e,$f8,$07,$e8	; $B982
	dc.b	$30,$38,$99,$64	; $B986
	dc.b	$e9,$48	; $B98A
	dc.b	$02,$78,$bf,$7f,$99,$94	; $B98C
	dc.b	$20,$79,$00,$01,$cc,$08	; $B992
	dc.b	$38,$30,$00,$00	; $B998
	dc.b	$31,$c4,$9b,$da	; $B99C
	dc.b	$32,$04	; $B9A0
	dc.b	$e8,$49	; $B9A2
	dc.b	$31,$c1,$97,$4c	; $B9A4
	dc.b	$3a,$30,$00,$02	; $B9A8
	dc.b	$31,$c5,$9b,$dc	; $B9AC
	dc.b	$32,$05	; $B9B0
	dc.b	$e5,$49	; $B9B2
	dc.b	$31,$c1,$97,$4e	; $B9B4
	dc.b	$72,$00	; $B9B8
	dc.b	$12,$30,$00,$04	; $B9BA
	dc.b	$d8,$41	; $B9BE
	dc.b	$31,$c4,$9b,$ce	; $B9C0
	dc.b	$e8,$49	; $B9C4
	dc.b	$31,$c1,$9b,$e2	; $B9C6
	dc.b	$72,$00	; $B9CA
	dc.b	$12,$30,$00,$05	; $B9CC
	dc.b	$da,$41	; $B9D0
	dc.b	$31,$c5,$9b,$d0	; $B9D2
	dc.b	$e8,$49	; $B9D6
	dc.b	$31,$c1,$9b,$e4	; $B9D8
	dc.b	$11,$f0,$00,$06,$9b,$f2	; $B9DC
	dc.b	$72,$02	; $B9E2
	dc.b	$4a,$30,$00,$07	; $B9E4
	dc.b	$67,$02	; $B9E8
	dc.b	$72,$01	; $B9EA
	dc.b	$31,$c1,$9b,$d2	; $B9EC
	dc.b	$31,$c1,$9b,$d4	; $B9F0
	dc.b	$32,$30,$00,$08	; $B9F4
	dc.b	$48,$c1	; $B9F8
	dc.b	$67,$02	; $B9FA
	dc.b	$d2,$88	; $B9FC
	dc.b	$21,$c1,$a1,$1e	; $B9FE
	dc.b	$21,$f8,$99,$6c,$99,$70	; $BA02
	dc.b	$22,$48	; $BA08
	dc.b	$d2,$f0,$00,$0c	; $BA0A
	dc.b	$21,$c9,$99,$6c	; $BA0E
	dc.b	$d0,$f0,$00,$0e	; $BA12
	dc.b	$70,$00	; $BA16
	dc.b	$10,$18	; $BA18
	dc.b	$31,$c0,$9b,$de	; $BA1A
	dc.b	$31,$c0,$97,$50	; $BA1E
	dc.b	$10,$18	; $BA22
	dc.b	$31,$c0,$9b,$e0	; $BA24
	dc.b	$31,$c0,$97,$52	; $BA28
	dc.b	$21,$c8,$99,$7c	; $BA2C
	dc.b	$60,$00,$e7,$cc	; $BA30
	dc.b	$61,$5c	; $BA34
	dc.b	$4e,$b8,$25,$42	; $BA36
	dc.b	$31,$c0,$9b,$ea	; $BA3A
	dc.b	$70,$01	; $BA3E
	dc.b	$4e,$b8,$26,$70	; $BA40
	dc.b	$0c,$78,$00,$01,$9b,$ca	; $BA44
	dc.b	$67,$12	; $BA4A
	dc.b	$52,$46	; $BA4C
	dc.b	$4e,$b8,$25,$42	; $BA4E
	dc.b	$31,$c0,$9b,$ec	; $BA52
	dc.b	$70,$01	; $BA56
	dc.b	$4e,$b8,$26,$70	; $BA58
	dc.b	$53,$46	; $BA5C
	dc.b	$0c,$78,$00,$01,$9b,$cc	; $BA5E
	dc.b	$67,$2a	; $BA64
	dc.b	$06,$47,$00,$40	; $BA66
	dc.b	$4e,$b8,$25,$42	; $BA6A
	dc.b	$31,$c0,$9b,$ee	; $BA6E
	dc.b	$70,$01	; $BA72
	dc.b	$4e,$b8,$26,$70	; $BA74
	dc.b	$0c,$78,$00,$01,$9b,$ca	; $BA78
	dc.b	$67,$10	; $BA7E
	dc.b	$52,$46	; $BA80
	dc.b	$4e,$b8,$25,$42	; $BA82
	dc.b	$31,$c0,$9b,$f0	; $BA86
	dc.b	$70,$01	; $BA8A
	dc.b	$4e,$f8,$26,$70	; $BA8C
	dc.b	$4e,$75	; $BA90
	dc.b	$3c,$38,$9b,$c6	; $BA92
	dc.b	$3e,$38,$9b,$c8	; $BA96
	dc.b	$e8,$4e	; $BA9A
	dc.b	$02,$47,$ff,$f0	; $BA9C
	dc.b	$e5,$4f	; $BAA0
	dc.b	$47,$f8,$97,$54	; $BAA2
	dc.b	$4e,$75	; $BAA6
	dc.b	$61,$e8	; $BAA8
	dc.b	$30,$38,$9b,$ea	; $BAAA
	dc.b	$4e,$b8,$26,$70	; $BAAE
	dc.b	$0c,$78,$00,$01,$9b,$ca	; $BAB2
	dc.b	$67,$0c	; $BAB8
	dc.b	$52,$46	; $BABA
	dc.b	$30,$38,$9b,$ec	; $BABC
	dc.b	$4e,$b8,$26,$70	; $BAC0
	dc.b	$53,$46	; $BAC4
	dc.b	$0c,$78,$00,$01,$9b,$cc	; $BAC6
	dc.b	$67,$1e	; $BACC
	dc.b	$06,$47,$00,$40	; $BACE
	dc.b	$30,$38,$9b,$ee	; $BAD2
	dc.b	$4e,$b8,$26,$70	; $BAD6
	dc.b	$0c,$78,$00,$01,$9b,$ca	; $BADA
	dc.b	$67,$0a	; $BAE0
	dc.b	$52,$46	; $BAE2
	dc.b	$30,$38,$9b,$f0	; $BAE4
	dc.b	$4e,$f8,$26,$70	; $BAE8
	dc.b	$4e,$75	; $BAEC
	dc.b	$47,$f8,$97,$54	; $BAEE
	dc.b	$3c,$38,$9b,$e2	; $BAF2
	dc.b	$3e,$38,$9b,$e4	; $BAF6
	dc.b	$61,$00,$00,$92	; $BAFA
	dc.b	$0c,$78,$00,$01,$9b,$d2	; $BAFE
	dc.b	$67,$08	; $BB04
	dc.b	$52,$46	; $BB06
	dc.b	$61,$00,$00,$84	; $BB08
	dc.b	$53,$46	; $BB0C
	dc.b	$0c,$78,$00,$01,$9b,$d4	; $BB0E
	dc.b	$67,$14	; $BB14
	dc.b	$52,$47	; $BB16
	dc.b	$61,$00,$00,$74	; $BB18
	dc.b	$0c,$78,$00,$01,$9b,$d2	; $BB1C
	dc.b	$67,$06	; $BB22
	dc.b	$52,$46	; $BB24
	dc.b	$60,$00,$00,$66	; $BB26
	rts	; $BB2A
	dc.b	$22,$78,$99,$7c	; $BB2C
	dc.b	$30,$07	; $BB30
	dc.b	$32,$38,$9b,$de	; $BB32
	dc.b	$c2,$c0	; $BB36
	dc.b	$d2,$46	; $BB38
	dc.b	$30,$01	; $BB3A
	dc.b	$e5,$49	; $BB3C
	dc.b	$d2,$40	; $BB3E
	dc.b	$70,$03	; $BB40
	dc.b	$c0,$41	; $BB42
	dc.b	$e4,$49	; $BB44
	dc.b	$4a,$40	; $BB46
	dc.b	$66,$0e	; $BB48
	dc.b	$10,$31,$10,$00	; $BB4A
	dc.b	$e5,$48	; $BB4E
	dc.b	$12,$31,$10,$01	; $BB50
	dc.b	$ec,$09	; $BB54
	dc.b	$60,$24	; $BB56
	dc.b	$55,$40	; $BB58
	dc.b	$64,$10	; $BB5A
	dc.b	$70,$3f	; $BB5C
	dc.b	$c0,$31,$10,$00	; $BB5E
	dc.b	$e9,$48	; $BB62
	dc.b	$12,$31,$10,$01	; $BB64
	dc.b	$e8,$09	; $BB68
	dc.b	$60,$10	; $BB6A
	dc.b	$66,$12	; $BB6C
	dc.b	$70,$0f	; $BB6E
	dc.b	$c0,$31,$10,$00	; $BB70
	dc.b	$ed,$48	; $BB74
	dc.b	$12,$31,$10,$01	; $BB76
	dc.b	$e4,$09	; $BB7A
	dc.b	$80,$01	; $BB7C
	dc.b	$4e,$75	; $BB7E
	dc.b	$70,$03	; $BB80
	dc.b	$c0,$31,$10,$00	; $BB82
	dc.b	$e1,$48	; $BB86
	dc.b	$10,$31,$10,$01	; $BB88
	dc.b	$4e,$75	; $BB8C
	dc.b	$30,$06	; $BB8E
	dc.b	$48,$46	; $BB90
	dc.b	$3c,$00	; $BB92
	dc.b	$dc,$78,$97,$4c	; $BB94
	dc.b	$30,$07	; $BB98
	dc.b	$48,$47	; $BB9A
	dc.b	$3e,$00	; $BB9C
	dc.b	$ed,$4f	; $BB9E
	dc.b	$de,$78,$97,$4e	; $BBA0
	dc.b	$4e,$b8,$26,$0a	; $BBA4
	dc.b	$48,$46	; $BBA8
	dc.b	$48,$47	; $BBAA
	dc.b	$61,$00,$ff,$7e	; $BBAC
	dc.b	$30,$80	; $BBB0
	dc.b	$4e,$75	; $BBB2
	dc.b	$4e,$56,$ff,$fc	; $BBB4
	dc.b	$47,$f8,$97,$54	; $BBB8
	dc.b	$22,$78,$99,$7c	; $BBBC
	dc.b	$7e,$00	; $BBC0
	dc.b	$3d,$78,$97,$52,$ff,$fc	; $BBC2
	dc.b	$7c,$00	; $BBC8
	dc.b	$3d,$78,$97,$50,$ff,$fe	; $BBCA
	dc.b	$61,$00,$ff,$5a	; $BBD0
	dc.b	$61,$b8	; $BBD4
	dc.b	$52,$46	; $BBD6
	dc.b	$53,$6e,$ff,$fe	; $BBD8
	dc.b	$66,$f2	; $BBDC
	dc.b	$52,$47	; $BBDE
	dc.b	$53,$6e,$ff,$fc	; $BBE0
	dc.b	$66,$e2	; $BBE4
	dc.b	$4e,$5e	; $BBE6
	dc.b	$4e,$75	; $BBE8
	dc.b	$4e,$56,$ff,$f4	; $BBEA
	dc.b	$47,$f8,$97,$54	; $BBEE
	dc.b	$1d,$7c,$00,$0f,$ff,$f4	; $BBF2
	dc.b	$30,$38,$9b,$e2	; $BBF8
	dc.b	$90,$78,$9b,$e6	; $BBFC
	dc.b	$6a,$08	; $BC00
	dc.b	$02,$2e,$00,$0b,$ff,$f4	; $BC02
	dc.b	$70,$00	; $BC08
	dc.b	$3d,$40,$ff,$fe	; $BC0A
	dc.b	$30,$38,$9b,$e2	; $BC0E
	dc.b	$d0,$78,$9b,$d2	; $BC12
	dc.b	$53,$40	; $BC16
	dc.b	$d0,$78,$9b,$e6	; $BC18
	dc.b	$32,$38,$9b,$de	; $BC1C
	dc.b	$b0,$41	; $BC20
	dc.b	$65,$0a	; $BC22
	dc.b	$02,$2e,$00,$07,$ff,$f4	; $BC24
	dc.b	$30,$01	; $BC2A
	dc.b	$53,$40	; $BC2C
	dc.b	$3d,$40,$ff,$fc	; $BC2E
	dc.b	$30,$38,$9b,$e4	; $BC32
	dc.b	$90,$78,$9b,$e6	; $BC36
	dc.b	$6a,$08	; $BC3A
	dc.b	$02,$2e,$00,$0e,$ff,$f4	; $BC3C
	dc.b	$70,$00	; $BC42
	dc.b	$3d,$40,$ff,$fa	; $BC44
	dc.b	$30,$38,$9b,$e4	; $BC48
	dc.b	$d0,$78,$9b,$d4	; $BC4C
	dc.b	$53,$40	; $BC50
	dc.b	$d0,$78,$9b,$e6	; $BC52
	dc.b	$32,$38,$9b,$e0	; $BC56
	dc.b	$b0,$41	; $BC5A
	dc.b	$65,$0a	; $BC5C
	dc.b	$02,$2e,$00,$0d,$ff,$f4	; $BC5E
	dc.b	$30,$01	; $BC64
	dc.b	$53,$40	; $BC66
	dc.b	$3d,$40,$ff,$f8	; $BC68
	dc.b	$08,$2e,$00,$00,$ff,$f4	; $BC6C
	dc.b	$67,$06	; $BC72
	dc.b	$3e,$2e,$ff,$fa	; $BC74
	dc.b	$61,$32	; $BC78
	dc.b	$08,$2e,$00,$01,$ff,$f4	; $BC7A
	dc.b	$67,$06	; $BC80
	dc.b	$3e,$2e,$ff,$f8	; $BC82
	dc.b	$61,$24	; $BC86
	dc.b	$08,$2e,$00,$02,$ff,$f4	; $BC88
	dc.b	$67,$06	; $BC8E
	dc.b	$3c,$2e,$ff,$fe	; $BC90
	dc.b	$61,$44	; $BC94
	dc.b	$08,$2e,$00,$03,$ff,$f4	; $BC96
	dc.b	$67,$06	; $BC9C
	dc.b	$3c,$2e,$ff,$fc	; $BC9E
	dc.b	$61,$36	; $BCA2
	dc.b	$10,$2e,$ff,$f4	; $BCA4
	dc.b	$4e,$5e	; $BCA8
	dc.b	$4e,$75	; $BCAA
	dc.b	$ed,$4f	; $BCAC
	dc.b	$de,$78,$97,$4e	; $BCAE
	dc.b	$30,$2e,$ff,$fc	; $BCB2
	dc.b	$3c,$2e,$ff,$fe	; $BCB6
	dc.b	$90,$46	; $BCBA
	dc.b	$dc,$78,$97,$4c	; $BCBC
	dc.b	$3d,$40,$ff,$f6	; $BCC0
	dc.b	$4e,$b8,$25,$42	; $BCC4
	dc.b	$80,$78,$9b,$e8	; $BCC8
	dc.b	$4e,$b8,$26,$72	; $BCCC
	dc.b	$52,$46	; $BCD0
	dc.b	$53,$6e,$ff,$f6	; $BCD2
	dc.b	$6a,$ec	; $BCD6
	dc.b	$4e,$75	; $BCD8
	dc.b	$30,$2e,$ff,$f8	; $BCDA
	dc.b	$3e,$2e,$ff,$fa	; $BCDE
	dc.b	$90,$47	; $BCE2
	dc.b	$ed,$4f	; $BCE4
	dc.b	$de,$78,$97,$4e	; $BCE6
	dc.b	$dc,$78,$97,$4c	; $BCEA
	dc.b	$3d,$40,$ff,$f6	; $BCEE
	dc.b	$4e,$b8,$25,$42	; $BCF2
	dc.b	$80,$78,$9b,$e8	; $BCF6
	dc.b	$4e,$b8,$26,$72	; $BCFA
	dc.b	$06,$47,$00,$40	; $BCFE
	dc.b	$53,$6e,$ff,$f6	; $BD02
	dc.b	$6a,$ea	; $BD06
	dc.b	$4e,$75	; $BD08
	dc.b	$30,$78,$9c,$14	; $BD0A
	dc.b	$20,$df	; $BD0E
	dc.b	$31,$c8,$9c,$14	; $BD10
	dc.b	$70,$23	; $BD14
	dc.b	$4e,$b8,$03,$66	; $BD16
	dc.b	$4e,$b8,$04,$00	; $BD1A
	dc.b	$38,$7c,$00,$08	; $BD1E
	dc.b	$4a,$2c,$c6,$00	; $BD22
	dc.b	$67,$02	; $BD26
	dc.b	$4e,$75	; $BD28
	dc.b	$19,$7c,$00,$08,$c3,$03	; $BD2A
	dc.b	$4e,$b8,$07,$f4	; $BD30
	dc.b	$4e,$b8,$04,$00	; $BD34
	dc.b	$4a,$38,$c6,$08	; $BD38
	dc.b	$67,$02	; $BD3C
	dc.b	$4e,$75	; $BD3E
	dc.b	$70,$22	; $BD40
	dc.b	$4e,$b8,$03,$66	; $BD42
	dc.b	$32,$78,$9c,$14	; $BD46
	dc.b	$20,$61	; $BD4A
	dc.b	$31,$c9,$9c,$14	; $BD4C
	dc.b	$4e,$d0	; $BD50
	dc.b	$30,$78,$9c,$14	; $BD52
	dc.b	$20,$df	; $BD56
	dc.b	$31,$c8,$9c,$14	; $BD58
	dc.b	$70,$23	; $BD5C
	dc.b	$4e,$b8,$03,$66	; $BD5E
	dc.b	$4e,$b8,$04,$00	; $BD62
	dc.b	$38,$7c,$00,$08	; $BD66
	dc.b	$4a,$2c,$c6,$00	; $BD6A
	dc.b	$67,$02	; $BD6E
	dc.b	$4e,$75	; $BD70
	dc.b	$19,$7c,$00,$16,$c3,$03	; $BD72
	dc.b	$4e,$b8,$07,$f4	; $BD78
	dc.b	$4e,$b8,$04,$00	; $BD7C
	dc.b	$4a,$38,$c6,$08	; $BD80
	dc.b	$67,$02	; $BD84
	dc.b	$4e,$75	; $BD86
	dc.b	$70,$22	; $BD88
	dc.b	$4e,$b8,$03,$66	; $BD8A
	dc.b	$32,$78,$9c,$14	; $BD8E
	dc.b	$20,$61	; $BD92
	dc.b	$31,$c9,$9c,$14	; $BD94
	dc.b	$4e,$d0	; $BD98
	dc.b	$11,$fc,$00,$03,$96,$6a	; $BD9A
	dc.b	$61,$00,$3b,$fa	; $BDA0
	dc.b	$61,$00,$79,$e0	; $BDA4
	dc.b	$61,$00,$5d,$fa	; $BDA8
	dc.b	$60,$00,$53,$b0	; $BDAC
	dc.b	$61,$e8	; $BDB0
	dc.b	$61,$00,$d1,$e4	; $BDB2
	dc.b	$00,$38,$00,$01,$96,$5f	; $BDB6
	dc.b	$60,$00,$39,$ae	; $BDBC
	dc.b	$61,$00,$fb,$48	; $BDC0
	dc.b	$61,$d4	; $BDC4
	dc.b	$30,$38,$99,$f2	; $BDC6
	dc.b	$32,$38,$99,$f4	; $BDCA
	dc.b	$74,$10	; $BDCE
	dc.b	$76,$00	; $BDD0
	dc.b	$0c,$38,$00,$0f,$96,$68	; $BDD2
	dc.b	$67,$3e	; $BDD8
	dc.b	$76,$06	; $BDDA
	dc.b	$60,$3a	; $BDDC
	dc.b	$61,$00,$fb,$2a	; $BDDE
	dc.b	$61,$b6	; $BDE2
	dc.b	$20,$79,$00,$01,$cc,$00	; $BDE4
	dc.b	$30,$38,$99,$82	; $BDEA
	dc.b	$d0,$40	; $BDEE
	dc.b	$d0,$f0,$00,$00	; $BDF0
	dc.b	$0c,$28,$00,$10,$00,$02	; $BDF4
	dc.b	$67,$00,$39,$70	; $BDFA
	dc.b	$10,$28,$00,$04	; $BDFE
	dc.b	$12,$28,$00,$05	; $BE02
	dc.b	$61,$00,$e5,$ac	; $BE06
	dc.b	$16,$28,$00,$03	; $BE0A
	dc.b	$74,$10	; $BE0E
	dc.b	$0c,$03,$00,$08	; $BE10
	dc.b	$66,$02	; $BE14
	dc.b	$74,$08	; $BE16
	dc.b	$90,$42	; $BE18
	dc.b	$31,$c0,$9b,$c6	; $BE1A
	dc.b	$d4,$42	; $BE1E
	dc.b	$92,$42	; $BE20
	dc.b	$31,$c1,$9b,$c8	; $BE22
	dc.b	$e8,$4a	; $BE26
	dc.b	$31,$c2,$9b,$ca	; $BE28
	dc.b	$31,$c2,$9b,$cc	; $BE2C
	dc.b	$61,$00,$21,$4e	; $BE30
	dc.b	$10,$03	; $BE34
	dc.b	$61,$00,$fa,$da	; $BE36
	dc.b	$19,$7c,$00,$16,$c3,$03	; $BE3A
	dc.b	$4e,$b8,$04,$00	; $BE40
	dc.b	$61,$00,$fb,$ee	; $BE44
	dc.b	$61,$00,$fe,$c0	; $BE48
	dc.b	$60,$00,$d2,$b2	; $BE4C
	dc.b	$61,$00,$ff,$48	; $BE50
	dc.b	$61,$00,$21,$2a	; $BE54
	dc.b	$31,$fc,$00,$14,$9c,$1c	; $BE58
	jsr $400.w	; $BE5E
	dc.b	$53,$78,$9c,$1c	; $BE62
	dc.b	$66,$f6	; $BE66
	dc.b	$60,$00,$d2,$96	; $BE68
	dc.b	$61,$00,$fa,$9c	; $BE6C
	dc.b	$61,$00,$21,$0e	; $BE70
	dc.b	$08,$f8,$00,$04,$96,$59	; $BE74
	dc.b	$61,$00,$78,$2a	; $BE7A
	dc.b	$61,$00,$3b,$1c	; $BE7E
	dc.b	$61,$00,$4a,$76	; $BE82
	dc.b	$61,$00,$fa,$fe	; $BE86
	dc.b	$61,$00,$e3,$b0	; $BE8A
	dc.b	$61,$00,$fa,$ba	; $BE8E
	dc.b	$19,$7c,$00,$16,$c3,$03	; $BE92
	dc.b	$4e,$b8,$04,$00	; $BE98
	dc.b	$61,$00,$fc,$50	; $BE9C
	dc.b	$61,$00,$e4,$12	; $BEA0
	dc.b	$08,$f8,$00,$00,$96,$59	; $BEA4
	dc.b	$61,$00,$69,$9c	; $BEAA
	dc.b	$61,$00,$75,$02	; $BEAE
	dc.b	$08,$b8,$00,$00,$96,$59	; $BEB2
	dc.b	$61,$00,$fe,$50	; $BEB8
	dc.b	$61,$00,$fa,$88	; $BEBC
	dc.b	$42,$78,$9b,$e8	; $BEC0
	dc.b	$42,$78,$9b,$e6	; $BEC4
	dc.b	$61,$00,$fc,$ea	; $BEC8
	dc.b	$4e,$b8,$04,$00	; $BECC
	dc.b	$4e,$b8,$04,$00	; $BED0
	dc.b	$4e,$b8,$04,$00	; $BED4
	dc.b	$52,$78,$9b,$e6	; $BED8
	dc.b	$61,$00,$fd,$0c	; $BEDC
	dc.b	$66,$ea	; $BEE0
	dc.b	$4e,$b8,$04,$00	; $BEE2
	dc.b	$4e,$b8,$04,$00	; $BEE6
	dc.b	$42,$78,$99,$62	; $BEEA
	dc.b	$60,$00,$d1,$0c	; $BEEE
	dc.b	$61,$00,$fa,$16	; $BEF2
	dc.b	$61,$00,$20,$98	; $BEF6
	dc.b	$61,$00,$3a,$a0	; $BEFA
	dc.b	$61,$00,$49,$fa	; $BEFE
	dc.b	$61,$00,$e3,$72	; $BF02
	dc.b	$30,$38,$9b,$e2	; $BF06
	dc.b	$32,$38,$9b,$de	; $BF0A
	dc.b	$92,$40	; $BF0E
	dc.b	$92,$78,$9b,$d2	; $BF10
	dc.b	$b0,$41	; $BF14
	dc.b	$64,$02	; $BF16
	dc.b	$30,$01	; $BF18
	dc.b	$32,$38,$9b,$e4	; $BF1A
	dc.b	$b0,$41	; $BF1E
	dc.b	$64,$02	; $BF20
	dc.b	$30,$01	; $BF22
	dc.b	$34,$38,$9b,$e0	; $BF24
	dc.b	$94,$41	; $BF28
	dc.b	$94,$78,$9b,$d4	; $BF2A
	dc.b	$b0,$42	; $BF2E
	dc.b	$64,$02	; $BF30
	dc.b	$30,$02	; $BF32
	dc.b	$31,$c0,$9b,$e6	; $BF34
	dc.b	$31,$fc,$80,$00,$9b,$e8	; $BF38
	jsr $400.w	; $BF3E
	dc.b	$4e,$b8,$04,$00	; $BF42
	dc.b	$4e,$b8,$04,$00	; $BF46
	dc.b	$61,$00,$fc,$9e	; $BF4A
	dc.b	$53,$78,$9b,$e6	; $BF4E
	dc.b	$66,$ea	; $BF52
	dc.b	$61,$00,$f9,$f4	; $BF54
	dc.b	$61,$00,$fd,$f8	; $BF58
	dc.b	$61,$00,$77,$ea	; $BF5C
	dc.b	$08,$b8,$00,$04,$96,$59	; $BF60
	dc.b	$4e,$b8,$04,$00	; $BF66
	dc.b	$42,$38,$c0,$08	; $BF6A
	dc.b	$21,$f8,$99,$70,$99,$6c	; $BF6E
	dc.b	$61,$00,$e3,$3e	; $BF74
	dc.b	$42,$78,$99,$62	; $BF78
	dc.b	$60,$00,$d0,$7e	; $BF7C
	dc.b	$61,$00,$f9,$88	; $BF80
	dc.b	$61,$00,$1f,$fa	; $BF84
	dc.b	$61,$00,$3a,$12	; $BF88
	dc.b	$61,$00,$49,$6c	; $BF8C
	dc.b	$24,$78,$99,$86	; $BF90
	dc.b	$10,$2a,$00,$01	; $BF94
	dc.b	$72,$10	; $BF98
	dc.b	$0c,$00,$00,$08	; $BF9A
	dc.b	$66,$02	; $BF9E
	dc.b	$72,$08	; $BFA0
	dc.b	$34,$38,$99,$82	; $BFA2
	dc.b	$94,$41	; $BFA6
	dc.b	$31,$c2,$9b,$c6	; $BFA8
	dc.b	$d2,$41	; $BFAC
	dc.b	$34,$38,$99,$84	; $BFAE
	dc.b	$94,$41	; $BFB2
	dc.b	$31,$c2,$9b,$c8	; $BFB4
	dc.b	$e8,$49	; $BFB8
	dc.b	$31,$c1,$9b,$ca	; $BFBA
	dc.b	$31,$c1,$9b,$cc	; $BFBE
	dc.b	$61,$00,$f9,$4e	; $BFC2
	dc.b	$4e,$b8,$04,$00	; $BFC6
	dc.b	$61,$00,$fa,$68	; $BFCA
	dc.b	$61,$00,$fd,$3a	; $BFCE
	dc.b	$38,$78,$9e,$ee	; $BFD2
	dc.b	$00,$2c,$00,$10,$c0,$03	; $BFD6
	dc.b	$4e,$b8,$04,$00	; $BFDC
	dc.b	$61,$00,$fa,$c6	; $BFE0
	dc.b	$42,$78,$c0,$08	; $BFE4
	dc.b	$38,$78,$9e,$ee	; $BFE8
	dc.b	$4e,$b8,$0c,$1c	; $BFEC
	dc.b	$24,$78,$99,$86	; $BFF0
	dc.b	$10,$2a,$00,$02	; $BFF4
	dc.b	$12,$2a,$00,$03	; $BFF8
	dc.b	$61,$00,$e3,$b6	; $BFFC
