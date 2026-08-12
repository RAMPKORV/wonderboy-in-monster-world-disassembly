; ======================================================================
; src/flagged_loader_pre.asm ($6A58-$6BC4)
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
