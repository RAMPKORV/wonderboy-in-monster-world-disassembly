; ======================================================================
; src/scene/palette.asm
; Palette system: pre-driver code, animation driver, palette source, post code
; Covers ROM $005700-$00599C.
; ======================================================================

	jsr (A2)	; $5700
	bra.b *-$22	; $5702
	move.b D2, ($1,A0)	; $5704
	move.b ($1,A1,D1.w), D2	; $5708
	addq.w #$2, D1	; $570C
	lea (-$74AA).w, A2	; $570E
	move.w ($0,A1,D1.w), D3	; $5712
	addq.w #$2, D1	; $5716
	move.w ($0,A1,D1.w), ($0,A2,D3.w)	; $5718
	addq.w #$2, D1	; $571E
	subq.b #$1, D2	; $5720
	bne.b *-$10	; $5722
	move.l A1, ($2,A0)	; $5724
	move.w D1, ($6,A0)	; $5728
	ori.b #$40, (RAM_word_FFFF8C56).w	; $572C
	bra.b *-$6A	; $5732
	adda.w D1, A1	; $5734
	move.w (A1)+, ($8,A0)	; $5736
	moveq #$0, D1	; $573A
	rts	; $573C
	dc.b	$53,$28,$00,$08	; $573E
	beq.b *+$8	; $5742
	rts	; $5744
	adda.w D1, A1	; $5746
	adda.w (A1), A1	; $5748
	moveq #$0, D1	; $574A
	rts	; $574C
	lea ($0,A1,D1.w), A2	; $574E
	addq.w #$4, D1	; $5752
	bra.b *+$12	; $5754
	dc.b	$00,$00,$57,$34	; $5756
	dc.b	$00,$00,$57,$3e	; $575A
	dc.b	$00,$00,$57,$46	; $575E
	dc.b	$00,$00,$57,$4e	; $5762
	lea (-$7398).w, A3	; $5766
	moveq #$0, D2	; $576A
	tst.b (A3)	; $576C
	bpl.b *+$8	; $576E
	dbf D2, $576C	; $5770
	rts	; $5774
	dc.b	$52,$38,$8C,$57	; $5776
	move.b #$1, ($2,A3)	; $577A
	move.b #$0, ($3,A3)	; $5780
	move.b (A2)+, (A3)	; $5786
	move.b (A2)+, ($4,A3)	; $5788
	move.b (A2)+, ($1,A3)	; $578C
	move.b (A2)+, ($5,A3)	; $5790
	ori.b #-$60, (A3)	; $5794
	rts	; $5798

PaletteAnimationDriver:
	lea (-$7398).w, A2	; $579A
	moveq #$0, D0	; $579E
	move.b (A2), D4	; $57A0
	bpl.b *+$70	; $57A2
	move.b ($3,A2), D5	; $57A4
	subq.b #$1, ($2,A2)	; $57A8
	bne.b *+$26	; $57AC
	move.b ($1,A2), ($2,A2)	; $57AE
	btst.b #$5, (A2)	; $57B4
	bne.b *+$A	; $57B8
	add.b ($4,A2), D5	; $57BA
	bmi.b *+$14	; $57BE
	bra.b *+$C	; $57C0
	sub.b ($4,A2), D5	; $57C2
	cmpi.b #-$E, D5	; $57C6
	bge.b *+$8	; $57CA
	bchg.b #$5, (A2)	; $57CC
	bra.b *-$1C	; $57D0
	move.b D5, ($3,A2)	; $57D2
	moveq #$0, D1	; $57D6
	moveq #$0, D2	; $57D8
	moveq #$0, D3	; $57DA
	btst.l #$0, D4	; $57DC
	bne.b *+$6	; $57E0
	move.b D5, D1	; $57E2
	ext.w D1	; $57E4
	btst.l #$1, D4	; $57E6
	bne.b *+$8	; $57EA
	move.b D5, D2	; $57EC
	ext.w D2	; $57EE
	asl.w #$4, D2	; $57F0
	btst.l #$2, D4	; $57F2
	bne.b *+$8	; $57F6
	move.b D5, D3	; $57F8
	ext.w D3	; $57FA
	asl.w #$8, D3	; $57FC
	moveq #$0, D4	; $57FE
	move.b ($5,A2), D4	; $5800
	add.w D4, D4	; $5804
	lea (-$742A).w, A0	; $5806
	adda.w D4, A0	; $580A
	lea (A0), A1	; $580C
	bsr.w *+$13C	; $580E
	addq.w #$6, A2	; $5812
	dbf D0, $57A0	; $5814
	rts	; $5818
	bsr.b *+$64	; $581A
	andi.b #-$39, (RAM_word_FFFF8C56).w	; $581C
	ori.b #$20, (RAM_word_FFFF8C56).w	; $5822
	move.b #-$10, (RAM_word_FFFF8C70).w	; $5828
	move.b #$1, (RAM_word_FFFF8C6E).w	; $582E
	move.b #$1, (RAM_word_FFFF8C6F).w	; $5834
	move.b #$2, (RAM_word_FFFF8C74).w	; $583A
	rts	; $5840
	bsr.b *+$3C	; $5842
	andi.b #-$39, (RAM_word_FFFF8C56).w	; $5844
	ori.b #$28, (RAM_word_FFFF8C56).w	; $584A
	clr.b (RAM_word_FFFF8C70).w	; $5850
	move.b #$1, (RAM_word_FFFF8C6E).w	; $5854
	move.b #$1, (RAM_word_FFFF8C6F).w	; $585A
	move.b #$2, (RAM_word_FFFF8C74).w	; $5860
	rts	; $5866
	bsr.b *-$26	; $5868
	move.b #$2, (RAM_word_FFFF8C6E).w	; $586A
	move.b #$2, (RAM_word_FFFF8C6F).w	; $5870
	move.b #$1, (RAM_word_FFFF8C74).w	; $5876
	rts	; $587C
	lea ($5608).l, A1	; $587E
	jsr $47A.w	; $5884
	tst.b D0	; $5888
	bne.b *+$6	; $588A
	bsr.w *-$2B2	; $588C
	rts	; $5890
	subq.b #$1, (RAM_word_FFFF8C6E).w	; $5892
	beq.b *+$4	; $5896
	rts	; $5898
	btst.b #$6, (RAM_word_FFFF8A5D).w	; $589A
	bne.b *+$6	; $58A0
	jsr $618.w	; $58A2
	move.b (RAM_word_FFFF8C6F).w, (RAM_word_FFFF8C6E).w	; $58A6
	move.b (RAM_word_FFFF8C70).w, D0	; $58AC
	add.b (RAM_word_FFFF8C74).w, D0	; $58B0
	bmi.b *+$10	; $58B4
	andi.b #-$39, (RAM_word_FFFF8C56).w	; $58B6
	ori.b #$52, (RAM_word_FFFF8C56).w	; $58BC
	rts	; $58C2
	move.b D0, (RAM_word_FFFF8C70).w	; $58C4
	move.b D0, (RAM_word_FFFF8C71).w	; $58C8
	move.b D0, (RAM_word_FFFF8C72).w	; $58CC
	move.b D0, (RAM_word_FFFF8C73).w	; $58D0
	rts	; $58D4
	subq.b #$1, (RAM_word_FFFF8C6E).w	; $58D6
	beq.b *+$4	; $58DA
	rts	; $58DC
	move.b (RAM_word_FFFF8C6F).w, (RAM_word_FFFF8C6E).w	; $58DE
	move.b (RAM_word_FFFF8C70).w, D0	; $58E4
	sub.b (RAM_word_FFFF8C74).w, D0	; $58E8
	cmpi.b #-$E, D0	; $58EC
	bge.b *+$14	; $58F0
	andi.b #-$39, (RAM_word_FFFF8C56).w	; $58F2
	ori.b #$10, (RAM_word_FFFF8C56).w	; $58F8
	jsr $62A.w	; $58FE
	rts	; $5902
	move.b D0, (RAM_word_FFFF8C70).w	; $5904
	move.b D0, (RAM_word_FFFF8C71).w	; $5908
	move.b D0, (RAM_word_FFFF8C72).w	; $590C
	move.b D0, (RAM_word_FFFF8C73).w	; $5910
	rts	; $5914

PaletteSourceToWorking:
	lea (-$74AA).w, A0	; $5916
	lea (-$742A).w, A1	; $591A
	moveq #$3F, D0	; $591E
	move.b (RAM_word_FFFF8C71).w, D1	; $5920
	ext.w D1	; $5924
	move.b (RAM_word_FFFF8C72).w, D2	; $5926
	ext.w D2	; $592A
	asl.w #$4, D2	; $592C
	move.b (RAM_word_FFFF8C73).w, D3	; $592E
	ext.w D3	; $5932
	asl.w #$8, D3	; $5934
	bsr.b *+$14	; $5936
	dbf D0, $5936	; $5938
	andi.b #$3F, (RAM_word_FFFF8C56).w	; $593C
	ori.b #-$7F, (RAM_word_FFFF8C56).w	; $5942
	rts	; $5948

AdjustPaletteWord:
	moveq #$E, D7	; $594A
	move.w (A0)+, D4	; $594C
	move.w D4, D5	; $594E
	and.w D7, D5	; $5950
	add.w D1, D5	; $5952
	bpl.b *+$6	; $5954
	moveq #$0, D5	; $5956
	bra.b *+$8	; $5958
	cmp.w D7, D5	; $595A
	bcs.b *+$4	; $595C
	move.w D7, D5	; $595E
	asl.w #$4, D7	; $5960
	move.w D4, D6	; $5962
	and.w D7, D6	; $5964
	add.w D2, D6	; $5966
	bmi.b *+$A	; $5968
	cmp.w D7, D6	; $596A
	bcs.b *+$4	; $596C
	move.w D7, D6	; $596E
	or.w D6, D5	; $5970
	asl.w #$4, D7	; $5972
	and.w D7, D4	; $5974
	add.w D3, D4	; $5976
	bmi.b *+$A	; $5978
	cmp.w D7, D4	; $597A
	bcs.b *+$4	; $597C
	move.w D7, D4	; $597E
	or.w D4, D5	; $5980
	move.w D5, (A1)+	; $5982
	rts	; $5984

	dc.b	$70,$FF	; $5986
	moveq #$1F, D1	; $5988
	lea (-$742A).w, A0	; $598A
	move.l D0, (A0)+	; $598E
	dbf D1, $598E	; $5990
	ori.b #-$7C, (RAM_word_FFFF8C56).w	; $5994
	rts	; $599A

