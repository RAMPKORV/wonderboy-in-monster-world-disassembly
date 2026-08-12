; ======================================================================
; src/actions.asm
; Player input/action dispatch, scene render + scroll, quiz strings
; Covers ROM $1400-$2200.
; Verified bit-exact against the original ROM.
; ======================================================================
	bne.w loc_1CBC	; $1400
	btst.b #$5, (RAM_PlayerState).w	; $1404
	beq.w loc_14A6	; $140A
	bsr.w loc_1774	; $140E
	btst.b #$2, (RAM_InputSelectedNew).w	; $1412
	beq.b *+$C	; $1418
	btst.b #$1, (RAM_PlayerSubState).w	; $141A
	beq.b *+$28	; $1420
	bra.b *+$12	; $1422
loc_1424:
	btst.b #$3, (RAM_InputSelectedNew).w	; $1424
	beq.b *+$1E	; $142A
	btst.b #$1, (RAM_PlayerSubState).w	; $142C
	bne.b *+$16	; $1432
loc_1434:
	moveq #$25, D0	; $1434
	jsr $366.w	; $1436
	bsr.w loc_1782	; $143A
	bchg.b #$1, (RAM_PlayerSubState).w	; $143E
	bsr.w loc_1790	; $1444
loc_1448:
	btst.b #$4, (RAM_InputSelectedNew).w	; $1448
	beq.b *+$16	; $144E
	btst.b #$1, (RAM_PlayerSubState).w	; $1450
	bne.b *+$1E	; $1456
	bsr.w loc_1782	; $1458
	bset.b #$1, (RAM_PlayerSubState).w	; $145C
	bra.b *+$12	; $1462
loc_1464:
	btst.b #$6, (RAM_InputSelectedNew).w	; $1464
	bne.b *+$A	; $146A
	btst.b #$5, (RAM_InputSelectedNew).w	; $146C
	beq.b *+$32	; $1472
loc_1474:
	moveq #$26, D0	; $1474
	jsr $366.w	; $1476
	andi.b #-$21, (RAM_PlayerState).w	; $147A
	bsr.w loc_1790	; $1480
	movea.w (RAM_SceneScriptPtr).w, A0	; $1484
	movea.l (-$7386,A0), A2	; $1488
	move.b (A2)+, D0	; $148C
	lsl.w #$8, D0	; $148E
	move.b (A2)+, D0	; $1490
	btst.b #$1, (RAM_PlayerSubState).w	; $1492
	beq.b *+$6	; $1498
	subq.w #$2, D0	; $149A
	adda.w D0, A2	; $149C
loc_149E:
	move.l A2, (-$7386,A0)	; $149E
	bra.b *+$4	; $14A2
loc_14A4:
	rts	; $14A4
loc_14A6:
	btst.b #$0, (RAM_PlayerState).w	; $14A6
	beq.b *+$1C	; $14AC
	bsr.w loc_172E	; $14AE
	move.b (RAM_InputSelectedNew).w, D0	; $14B2
	andi.b #$70, D0	; $14B6
	bne.b *+$4	; $14BA
	rts	; $14BC
loc_14BE:
	bclr.b #$0, (RAM_PlayerState).w	; $14BE
	bsr.w loc_173C	; $14C4
loc_14C8:
	tst.b (RAM_word_FFFF8CA3).w	; $14C8
	beq.b *+$20	; $14CC
	btst.b #$4, (RAM_PlayerState).w	; $14CE
	bne.b *+$10	; $14D4
	btst.b #$5, (RAM_InputSelected).w	; $14D6
	beq.b *+$8	; $14DC
	clr.b (RAM_word_FFFF8CA3).w	; $14DE
	bra.b *+$A	; $14E2
loc_14E4:
	subq.b #$1, (RAM_word_FFFF8CA3).w	; $14E4
	beq.b *+$4	; $14E8
	rts	; $14EA
loc_14EC:
	movea.w (RAM_SceneScriptPtr).w, A0	; $14EC
	movea.l (-$7386,A0), A2	; $14F0
; ----------------------------------------------------------------------
; RunSceneEventScript: the scene-event bytecode interpreter. Reads commands from
; the stream pointed to by RAM_SceneScriptPtr (A2 via (RAM_SceneScriptPtr)) and
; dispatches through DispatchTable1/DispatchTable2. Runs one step per frame so
; door entries / screen scrolls play across frames. Stores the resume pointer
; back into RAM_SceneScriptPtr.
; ----------------------------------------------------------------------
RunSceneEventScript:
	move.b (A2)+, D3	; $14F4
	cmpi.b #$10, D3	; $14F6
	bcs.b *+$56	; $14FA
	move.w (RAM_CellX).w, D6	; $14FC
	cmp.w (RAM_SceneWidth).w, D6	; $1500
	bcs.b *+$A	; $1504
	bsr.w AdvanceSceneCellRow	; $1506
	move.b (-$1,A2), D3	; $150A
loc_150E:
	move.w (RAM_PlayerStateValue).w, D0	; $150E
	move.b #$20, D0	; $1512
	cmpi.b #-$2, D3	; $1516
	bcs.b *+$A	; $151A
	subi.b #$40, D3	; $151C
	move.b D3, D0	; $1520
	move.b (A2)+, D3	; $1522
loc_1524:
	move.w (RAM_CellX).w, D6	; $1524
	move.w (RAM_CellY).w, D7	; $1528
	add.w D7, D7	; $152C
	bsr.w	$13AE				; $152E
	addq.w #$1, D7	; $1532
	move.b D3, D0	; $1534
	bsr.w	$13AE				; $1536
	move.b (RAM_EventCounter).w, D0	; $153A
	or.b D0, (RAM_EventFlag).w	; $153E
	addq.w #$1, (RAM_CellX).w	; $1542
loc_1546:
	move.b (RAM_SceneEventCounter).w, (RAM_word_FFFF8CA3).w	; $1546
	bne.b *+$4A	; $154C
	bra.b RunSceneEventScript	; $154E
loc_1550:
	cmpi.b #$C, D3	; $1550
	bcc.b *+$12	; $1554
	moveq #$0, D0	; $1556
	move.b	D3, D0				; $1558
	add.w	D0, D0				; $155A
	lea	DispatchTable1(PC), A0		; $155C
	adda.w	($0,A0,D0.w), A0		; $1560
	jmp	(A0)				; $1564
loc_1566:
	move.b (A2)+, D2	; $1566
loc_1568:
	andi.w #$3, D3	; $1568
	lsl.w #$2, D3	; $156C
	movea.l ($1CC10).l, A1	; $156E
	movea.l ($0,A1,D3.w), A1	; $1574
	move.b D2, D3	; $1578
	add.w D3, D3	; $157A
	move.w ($0,A1,D3.w), D2	; $157C
	movea.w (RAM_SceneScriptPtr).w, A0	; $1580
	move.l A2, (-$7386,A0)	; $1584
	addq.l #$4, A0	; $1588
	move.w A0, (RAM_SceneScriptPtr).w	; $158A
	lea ($0,A1,D2.w), A2	; $158E
	bra.w RunSceneEventScript	; $1592
loc_1596:
	movea.w (RAM_SceneScriptPtr).w, A0	; $1596
	move.l A2, (-$7386,A0)	; $159A
	rts					; $159E
DispatchTable1:				; loc_00015A0
	dc.w	$008E,$00AA,$00B6,$00BE		; $15A0
	dc.w	$00CC,$00D8,$00EC,$00FA		; $15A8
	dc.w	$0104,$010E,$011E,$0018		; $15B0
	moveq	#$0, D0				; $15B8
	move.b	(A2)+, D0			; $15BA
	add.w	D0, D0				; $15BC
	lea	DispatchTable2(PC), A0		; $15BE
	adda.w	($0,A0,D0.w), A0		; $15C2
	jmp	(A0)				; $15C6
DispatchTable2:				; loc_00015C8
	dc.w	$01FC,$01FE,$0208,$022E,$0240,$0258,$029C,$02B6	; $15C8
	dc.w	$02CC,$02EA,$02F6,$02FE,$0308,$0312,$031C,$0324	; $15D8
	dc.w	$037E,$0386,$039A,$03AA,$03B8,$03C2,$03D0,$03D8	; $15E8
	dc.w	$03F2,$0400,$040A,$0440,$044C,$0458,$0466,$0478	; $15F8
	dc.w	$0488,$04B8,$04C8,$053C,$059E,$05B6,$05CA,$05D6	; $1608
	dc.w	$0606,$0648,$065A,$066A,$0676,$069A,$06A8,$06AE	; $1618
	dc.w	$06B8,$06DE,$06E8			; $1628
	move.w	(RAM_SceneScriptPtr).w, D0		; $162E
	bne.b *+$8	; $1632
	clr.b (RAM_PlayerState).w	; $1634
	rts	; $1638
loc_163A:
	subq.w #$4, D0	; $163A
	move.w D0, (RAM_SceneScriptPtr).w	; $163C
	movea.w D0, A0	; $1640
	movea.l (-$7386,A0), A2	; $1642
	bra.w RunSceneEventScript	; $1646
	move.b (A2)+, D0	; $164A
	lsl.w #$8, D0	; $164C
	move.w D0, (RAM_PlayerStateValue).w	; $164E
	bra.w RunSceneEventScript	; $1652
	bsr.w AdvanceSceneCellRow	; $1656
	bra.w loc_1546	; $165A
	move.b (A2)+, D0	; $165E
		dc.w	$6100,$09d8	; bsr.w
	move.b D0, (RAM_SceneEventCounter).w	; $1664
	bra.w RunSceneEventScript	; $1668
	moveq #$0, D0	; $166C
	move.b (A2)+, D0	; $166E
	add.w D0, (RAM_CellX).w	; $1670
	bra.w RunSceneEventScript	; $1674
	ori.b #$1, (RAM_PlayerState).w	; $1678
	bsr.w loc_1754	; $167E
	bset.b #$0, (RAM_PlayerSubState).w	; $1682
	bra.w loc_1596	; $1688
loc_168C:
	move.b (A2)+, D0	; $168C
	lsl.w #$8, D0	; $168E
	move.b (A2), D0	; $1690
	subq.w #$1, D0	; $1692
	adda.w D0, A2	; $1694
	bra.w RunSceneEventScript	; $1696
	ori.b #$10, (RAM_PlayerState).w	; $169A
	bra.w RunSceneEventScript	; $16A0
	andi.b #-$11, (RAM_PlayerState).w	; $16A4
	bra.w RunSceneEventScript	; $16AA
	bsr.b *+$18	; $16AE
	moveq #$0, D0	; $16B0
	move.b (RAM_TransitionValue).w, D0	; $16B2
	add.w D0, (RAM_CellX).w	; $16B6
	bra.w RunSceneEventScript	; $16BA
	move.b (A2)+, (RAM_TransitionValue).w	; $16BE
	bra.w RunSceneEventScript	; $16C2
; ----------------------------------------------------------------------
; AdvanceSceneCellRow: the player reached the right edge of the current screen
; cell. Clears the cell X counter, increments the cell Y, and re-renders the
; tilemap for the next cell row (wrapping at the scene height).
; ----------------------------------------------------------------------
AdvanceSceneCellRow:
	clr.w (RAM_CellX).w	; $16C6
	addq.w #$1, (RAM_CellY).w	; $16CA
	move.w (RAM_CellY).w, D7	; $16CE
	cmp.w (RAM_SceneHeight).w, D7	; $16D2
	bcs.b *+$56	; $16D6
	subq.w #$1, (RAM_CellY).w	; $16D8
	move.w (RAM_SceneHeight).w, D0	; $16DC
	subq.w #$1, D0	; $16E0
	beq.b *+$24	; $16E2
	add.w D0, D0	; $16E4
	move.w D0, (RAM_RenderRowSkip).w	; $16E6
	move.w (RAM_SceneWidth).w, (RAM_RenderCols).w	; $16EA
	move.w #$1, (RAM_RenderMode).w	; $16F0
	move.w #$1, (RAM_RenderRows).w	; $16F6
	move.w #$2, (RAM_RenderColSkip).w	; $16FC
	jsr $2082.w	; $1702
loc_1706:
	move.w (RAM_SceneHeight).w, D7	; $1706
	subq.w #$1, D7	; $170A
	add.w D7, D7	; $170C
	addq.w #$1, D7	; $170E
	move.w #-$7FE0, D0	; $1710
	moveq #$1, D4	; $1714
	move.w (RAM_SceneWidth).w, D3	; $1716
	moveq #$1, D6	; $171A
loc_171C:
		dc.w	$6100,$0932	; bsr.w
	addq.w #$1, D6	; $1720
	subq.w #$1, D3	; $1722
	bne.b loc_171C	; $1724
	addq.w #$1, D7	; $1726
	dbf D4, $1716	; $1728
loc_172C:
	rts	; $172C
loc_172E:
	subq.b #$1, (RAM_TransitionTimer).w	; $172E
	bne.b *+$18	; $1732
	btst.b #$0, (RAM_PlayerSubState).w	; $1734
	beq.b *+$12	; $173A
loc_173C:
	bclr.b #$0, (RAM_PlayerSubState).w	; $173C
	beq.b *+$8	; $1742
	move.w #-$7FE0, D0	; $1744
	bra.b *+$10	; $1748
loc_174A:
	rts	; $174A
loc_174C:
	bset.b #$0, (RAM_PlayerSubState).w	; $174C
	bne.b loc_174A	; $1752
loc_1754:
	move.w #-$6FED, D0	; $1754
; ----------------------------------------------------------------------
; RenderFullScene: draws the whole 32x32 tilemap to Plane A on scene entry.
; Computes the scene centre from RAM_SceneWidth/RAM_SceneHeight and runs the
; bulk tilemap renderer.
; ----------------------------------------------------------------------
RenderFullScene:
	move.b #$14, (RAM_TransitionTimer).w	; $1758
	move.w (RAM_SceneHeight).w, D7	; $175E
	add.w D7, D7	; $1762
	addq.w #$1, D7	; $1764
	move.w (RAM_SceneWidth).w, D6	; $1766
	lsr.w #$1, D6	; $176A
	addq.w #$1, D6	; $176C
		dc.w	$6000,$08e0	; bra.w
	rts	; $1772
loc_1774:
	subq.b #$1, (RAM_TransitionTimer).w	; $1774
	bne.b *+$4A	; $1778
	btst.b #$2, (RAM_PlayerSubState).w	; $177A
	beq.b *+$10	; $1780
loc_1782:
	bclr.b #$2, (RAM_PlayerSubState).w	; $1782
	beq.b *+$3A	; $1788
	move.w #-$7FE0, D0	; $178A
	bra.b *+$E	; $178E
loc_1790:
	bset.b #$2, (RAM_PlayerSubState).w	; $1790
	bne.b *+$2C	; $1796
loc_1798:
	move.w #-$784B, D0	; $1798
loc_179C:
	move.b #$14, (RAM_TransitionTimer).w	; $179C
	move.w (RAM_CellY).w, D7	; $17A2
	add.w D7, D7	; $17A6
	addq.w #$2, D7	; $17A8
	moveq #$0, D6	; $17AA
	move.b (RAM_word_FFFF8CAC).w, D6	; $17AC
	btst.b #$1, (RAM_PlayerSubState).w	; $17B0
	beq.b *+$6	; $17B6
	move.b (RAM_word_FFFF8CAD).w, D6	; $17B8
loc_17BC:
	addq.w #$1, D6	; $17BC
		dc.w	$6000,$0890	; bra.w
loc_17C2:
	rts	; $17C2
	rts	; $17C4
	move.b (A2)+, D3	; $17C6
	move.b (RAM_word_FFFF8CAF).w, D2	; $17C8
	bra.w loc_1568	; $17CC
	ori.b #$20, (RAM_PlayerState).w	; $17D0
	move.b (A2)+, (RAM_word_FFFF8CAC).w	; $17D6
	move.b (A2)+, (RAM_word_FFFF8CAD).w	; $17DA
	andi.b #-$3, (RAM_PlayerSubState).w	; $17DE
	ori.b #$4, (RAM_PlayerSubState).w	; $17E4
	movea.w (RAM_SceneScriptPtr).w, A0	; $17EA
	move.l A2, (-$7386,A0)	; $17EE
	bra.w loc_1798	; $17F2
	move.l (RAM_word_FFFF962C).w, D0	; $17F6
	cmp.l (RAM_word_FFFF8CB2).w, D0	; $17FA
	bcs.w loc_168C	; $17FE
	addq.l #$2, A2	; $1802
	bra.w RunSceneEventScript	; $1804
	move.b (A2)+, D0	; $1808
	cmpi.b #-$1, D0	; $180A
	bne.b *+$6	; $180E
	move.b (RAM_word_FFFF8CAE).w, D0	; $1810
loc_1814:
	bsr.w	$1D92				; $1814
	move.l D0, (RAM_word_FFFF8CB2).w	; $1818
	bra.w RunSceneEventScript	; $181C
	move.l (RAM_word_FFFF8CB2).w, D1	; $1820
	lea (-$7340).w, A1	; $1824
	bsr.b *+$16	; $1828
	movea.w (RAM_SceneScriptPtr).w, A0	; $182A
	move.l A2, (-$7386,A0)	; $182E
	addq.w #$4, A0	; $1832
	move.w A0, (RAM_SceneScriptPtr).w	; $1834
	movea.l A1, A2	; $1838
	bra.w RunSceneEventScript	; $183A
loc_183E:
	clr.b (A1)	; $183E
loc_1840:
	moveq #$0, D0	; $1840
	moveq #$1F, D2	; $1842
	add.l D1, D1	; $1844
	addx.b D0, D0	; $1846
	cmpi.b #$A, D0	; $1848
	bcs.b *+$8	; $184C
	subi.b #$A, D0	; $184E
	addq.b #$1, D1	; $1852
loc_1854:
	dbf D2, $1844	; $1854
	addi.b #$30, D0	; $1858
	move.b D0, -(A1)	; $185C
	tst.l D1	; $185E
	bne.b loc_1840	; $1860
	rts	; $1862
	moveq #$D, D3	; $1864
	move.b (RAM_word_FFFF8CAE).w, D2	; $1866
	cmpi.b #$60, D2	; $186A
	bcs.b *+$C	; $186E
	cmpi.b #$66, D2	; $1870
	bcc.b *+$6	; $1874
	subi.b #$40, D2	; $1876
loc_187A:
	bra.w loc_1568	; $187A
	move.l (RAM_word_FFFF8CB2).w, D0	; $187E
	sub.l D0, (RAM_word_FFFF962C).w	; $1882
loc_1886:
	move.l A2, -(SP)	; $1886
	jsr	$85A8.l				; $1888
	movea.l (SP)+, A2	; $188E
	bra.w RunSceneEventScript	; $1890
	move.b (A2)+, D0	; $1894
	cmpi.b #-$1, D0	; $1896
	bne.b *+$6	; $189A
	move.b (RAM_word_FFFF8CAE).w, D0	; $189C
loc_18A0:
	move.l A2, -(SP)	; $18A0
	jsr $245A.w	; $18A2
	movea.l (SP)+, A2	; $18A6
	ori.w #$4000, (RAM_word_FFFF9994).w	; $18A8
	bra.w RunSceneEventScript	; $18AE
	movea.w (RAM_word_FFFF8CB0).w, A0	; $18B2
	clr.b (-$4000,A0)	; $18B6
	bra.w RunSceneEventScript	; $18BA
	move.b (A2)+, (RAM_word_FFFF8CAE).w	; $18BE
	bra.w RunSceneEventScript	; $18C2
	jsr	$1C494.l			; $18C6
	bra.w RunSceneEventScript	; $18CC
	ori.b #$3, (RAM_word_FFFF9BF3).w	; $18D0
	bra.w RunSceneEventScript	; $18D6
	ori.b #$1, (RAM_word_FFFF9BF3).w	; $18DA
	bra.w RunSceneEventScript	; $18E0
	move.b (A2)+, (RAM_word_FFFF965E).w	; $18E4
	bra.w RunSceneEventScript	; $18E8
	moveq #$0, D0	; $18EC
	move.b (A2)+, D0	; $18EE
	cmpi.b #-$1, D0	; $18F0
	bne.b *+$6	; $18F4
	move.b (RAM_word_FFFF965E).w, D0	; $18F6
loc_18FA:
	lsl.w #$2, D0	; $18FA
	move.l ($1906,PC,D0.w), (RAM_word_FFFF8CB2).w	; $18FC
	bra.w RunSceneEventScript	; $1902
	ori.b #$0, D0	; $1906
	ori.b #$A, D0	; $190A
	ori.b #$F, D0	; $190E
	ori.b #$14, D0	; $1912
	ori.b #$1E, D0	; $1916
	ori.b #$32, D0	; $191A
	ori.b #$50, D0	; $191E
	ori.b #$64, D0	; $1922
	ori.b #-$24, D0	; $1926
	ori.b #-$6, D0	; $192A
	ori.b #-$6, D0	; $192E
	ori.b #-$6, D0	; $1932
		dc.w	$0000,$012c	; ori.b
		dc.w	$0000,$012c	; ori.b
		dc.w	$0000,$012c	; ori.b
		dc.w	$0000,$012c	; ori.b
	clr.l (RAM_word_FFFF962C).w	; $1946
	bra.w loc_1886	; $194A
	move.b (A2)+, D0	; $194E
	jsr $2758.w	; $1950
	btst.b D0, ($0,A0,D1.w)	; $1954
	bne.w loc_168C	; $1958
	addq.l #$2, A2	; $195C
	bra.w RunSceneEventScript	; $195E
	move.b (A2)+, D0	; $1962
	jsr $274C.w	; $1964
	bne.w loc_168C	; $1968
	addq.l #$2, A2	; $196C
	bra.w RunSceneEventScript	; $196E
	move.b (A2)+, D0	; $1972
	jsr $2758.w	; $1974
	bset.b D0, ($0,A0,D1.w)	; $1978
	bra.w RunSceneEventScript	; $197C
	move.b (A2)+, D0	; $1980
	jsr $2752.w	; $1982
	bra.w RunSceneEventScript	; $1986
	move.l A2, -(SP)	; $198A
	jsr	$1C330.l			; $198C
	movea.l (SP)+, A2	; $1992
	bra.w RunSceneEventScript	; $1994
	move.b (A2)+, (RAM_EventCounter).w	; $1998
	bra.w RunSceneEventScript	; $199C
	move.b (A2)+, D0	; $19A0
	cmpi.b #-$1, D0	; $19A2
	bne.b *+$6	; $19A6
	move.b (RAM_word_FFFF8CAE).w, D0	; $19A8
loc_19AC:
	jsr $23E4.w	; $19AC
	bne.w loc_168C	; $19B0
	addq.l #$2, A2	; $19B4
	bra.w RunSceneEventScript	; $19B6
	move.b (A2)+, D0	; $19BA
		dc.w	$6100,$067c	; bsr.w
	move.b D0, (RAM_word_FFFF8CA3).w	; $19C0
	bra.w loc_1596	; $19C4
	move.b (A2)+, D0	; $19C8
	jsr $366.w	; $19CA
	bra.w RunSceneEventScript	; $19CE
	move.l (SP)+, (RAM_word_FFFF8CD6).w	; $19D2
	move.b (A2)+, D0	; $19D6
	bpl.b *+$6	; $19D8
	move.b (RAM_word_FFFF8CAE).w, D0	; $19DA
loc_19DE:
	movea.w (RAM_SceneScriptPtr).w, A0	; $19DE
	move.l A2, (-$7386,A0)	; $19E2
	jsr $2AAE.w	; $19E6
	move.l (RAM_word_FFFF8CD6).w, -(SP)	; $19EA
	movea.w (RAM_SceneScriptPtr).w, A0	; $19EE
	movea.l (-$7386,A0), A2	; $19F2
	tst.b D0	; $19F6
	bmi.w loc_168C	; $19F8
	addq.l #$2, A2	; $19FC
	beq.w loc_168C	; $19FE
	addq.l #$2, A2	; $1A02
	bra.w RunSceneEventScript	; $1A04
	move.b (A2)+, (RAM_word_FFFF8CC4).w	; $1A08
	move.b (A2)+, (RAM_word_FFFF8CC5).w	; $1A0C
	bra.w RunSceneEventScript	; $1A10
	move.b (RAM_word_FFFF8CC4).w, D3	; $1A14
	move.b (RAM_word_FFFF8CC5).w, D2	; $1A18
	bra.w loc_1568	; $1A1C
	move.w (RAM_word_FFFF968A).w, D0	; $1A20
	jsr	$F906.l				; $1A24
	bra.w RunSceneEventScript	; $1A2A
	moveq #$0, D0	; $1A2E
	move.b (A2)+, D0	; $1A30
	move.w D0, (RAM_CellX).w	; $1A32
	move.b (A2)+, D0	; $1A36
	move.w D0, (RAM_CellY).w	; $1A38
	bra.w RunSceneEventScript	; $1A3C
	moveq #$C, D3	; $1A40
	moveq #$0, D0	; $1A42
	move.b (A2)+, D0	; $1A44
	movea.w D0, A0	; $1A46
	move.b (-$733A,A0), D2	; $1A48
	bra.w loc_1568	; $1A4C
	move.w #-$7FE0, D0	; $1A50
	moveq #$1, D7	; $1A54
	move.w (RAM_SceneHeight).w, D5	; $1A56
	add.w D5, D5	; $1A5A
	addq.w #$1, D5	; $1A5C
loc_1A5E:
	moveq #$1, D6	; $1A5E
	move.w (RAM_SceneWidth).w, D4	; $1A60
loc_1A64:
	jsr $2050.w	; $1A64
	addq.w #$1, D6	; $1A68
	subq.w #$1, D4	; $1A6A
	bne.b loc_1A64	; $1A6C
	addq.w #$1, D7	; $1A6E
	subq.w #$1, D5	; $1A70
	bne.b loc_1A5E	; $1A72
	move.w D5, (RAM_CellX).w	; $1A74
	move.w D5, (RAM_CellY).w	; $1A78
	bra.w RunSceneEventScript	; $1A7C
	move.w #$F0, (RAM_word_FFFF8CD4).w	; $1A80
	bset.b #$3, (RAM_PlayerState).w	; $1A86
	bra.w loc_1596	; $1A8C
	move.l A2, -(SP)	; $1A90
	moveq #$0, D0	; $1A92
	move.b (RAM_word_FFFF8CD2).w, D0	; $1A94
	movea.w D0, A0	; $1A98
	move.b (-$7336,A0), D0	; $1A9A
	lsl.w #$2, D0	; $1A9E
	lea ($1AD6,PC,D0.w), A1	; $1AA0
	lea (-$733A).w, A2	; $1AA4
	move.b (A1), (A2)+	; $1AA8
	jsr $5D8.w	; $1AAA
	moveq #$6, D1	; $1AAE
	jsr $1B50.w	; $1AB0
	move.b ($1AFE,PC,D2.w), D0	; $1AB4
	moveq #$2, D1	; $1AB8
	lea (-$7331).w, A0	; $1ABA
	move.b D0, D2	; $1ABE
	andi.w #$3, D2	; $1AC0
	move.b D2, (A0)+	; $1AC4
	move.b ($1,A1,D2.w), (A2)+	; $1AC6
	lsr.w #$2, D0	; $1ACA
	dbf D1, $1ABE	; $1ACC
	movea.l (SP)+, A2	; $1AD0
	bra.w RunSceneEventScript	; $1AD2
	movep.w ($D0E, A4), D5	; $1AD6
	btst.b D7, (A1)	; $1ADA
	move.b (A2), D0	; $1ADC
	move.b (A4), -(A1)	; $1ADE
	move.b (A6), -(A2)	; $1AE0
	move.b (A2)+, -(A3)	; $1AE2
	move.b (A1)+, D4	; $1AE4
	move.b (A4)+, -(A5)	; $1AE6
	move.b (A6)+, -(A6)	; $1AE8
	move.b -(A1), -(SP)	; $1AEA
	move.l -(A2), D0	; $1AEC
	move.l -(A5), -(A1)	; $1AEE
	move.l -(A6), D2	; $1AF0
	move.l ($282A,A1), -(A3)	; $1AF2
	move.l ($2C2E,A5), -(A5)	; $1AF6
	move.l ($31,A2,D3.w), -(SP)	; $1AFA
	move.l (A0)+, D2	; $1AFE
	move.l A1, -(A0)	; $1B00
	move.b D6, D1	; $1B02
	link	A6, #-$A			; $1B04
	dc.w	$41ee,$fff6	; 1B08
	moveq #$9, D0	; $1B0C
	clr.b (A0)+	; $1B0E
	dbf D0, $1B0E	; $1B10
	lea (-$7336).w, A1	; $1B14
	moveq #$A, D7	; $1B18
loc_1B1A:
	jsr $5D8.w	; $1B1A
	move.w D7, D1	; $1B1E
	jsr $1B50.w	; $1B20
	lea (-$A,A6), A0	; $1B24
	moveq #$0, D1	; $1B28
loc_1B2A:
	addq.b #$1, D1	; $1B2A
	tst.b (A0)+	; $1B2C
	bne.b loc_1B2A	; $1B2E
	subq.b #$1, D2	; $1B30
	bpl.b loc_1B2A	; $1B32
	st -(A0)	; $1B34
	subq.b #$1, D1	; $1B36
	move.b D1, (A1)+	; $1B38
	subq.w #$1, D7	; $1B3A
	cmpi.b #$5, D7	; $1B3C
	bcc.b loc_1B1A	; $1B40
	clr.b (RAM_word_FFFF8CD3).w	; $1B42
	clr.b (RAM_word_FFFF8CD2).w	; $1B46
	unlk A6	; $1B4A
	bra.w RunSceneEventScript	; $1B4C
	moveq #$0, D2	; $1B50
	moveq #$F, D3	; $1B52
	add.w D0, D0	; $1B54
	addx.w D2, D2	; $1B56
	cmp.b D1, D2	; $1B58
	bcs.b *+$6	; $1B5A
	sub.b D1, D2	; $1B5C
	addq.b #$1, D0	; $1B5E
loc_1B60:
	dbf D3, $1B54	; $1B60
	rts	; $1B64
	moveq #$0, D0	; $1B66
	move.b (RAM_word_FFFF8CD3).w, D0	; $1B68
	move.b (A2)+, D1	; $1B6C
	lsl.w #$8, D1	; $1B6E
	move.b (A2)+, D1	; $1B70
	dbf D0, $1B6C	; $1B72
	lea (-$2,A2,D1.w), A2	; $1B76
	bra.w RunSceneEventScript	; $1B7A
	move.b (A2)+, D0	; $1B7E
	lsl.w #$8, D0	; $1B80
	move.b (A2)+, D0	; $1B82
	swap D0	; $1B84
	move.b (A2)+, D0	; $1B86
	lsl.w #$8, D0	; $1B88
	move.b (A2)+, D0	; $1B8A
	move.l D0, (RAM_word_FFFF8CB2).w	; $1B8C
	rts	; $1B90
	move.l (RAM_word_FFFF8CB2).w, D0	; $1B92
	add.l D0, (RAM_word_FFFF962C).w	; $1B96
	bra.w loc_1886	; $1B9A
	clr.l (RAM_word_FFFF8CB2).w	; $1B9E
	move.l A2, -(SP)	; $1BA2
	clr.l (RAM_word_FFFF8CB2).w	; $1BA4
	moveq #$7, D0	; $1BA8
loc_1BAA:
	move.w D0, -(SP)	; $1BAA
	jsr $23E4.w	; $1BAC
	beq.b *+$6	; $1BB0
	addq.w #$1, (RAM_word_FFFF8CB4).w	; $1BB2
loc_1BB6:
	move.w (SP)+, D0	; $1BB6
	addq.w #$8, D0	; $1BB8
	cmpi.w #$20, D0	; $1BBA
	bcs.b loc_1BAA	; $1BBE
	movea.l (SP)+, A2	; $1BC0
	move.w (RAM_word_FFFF8CB4).w, D0	; $1BC2
	add.w D0, D0	; $1BC6
	adda.w D0, A2	; $1BC8
	bra.w loc_168C	; $1BCA
	ori.b #$4, (RAM_PlayerState).w	; $1BCE
	move.l #$1BE6, (RAM_PlayerEnterHandler).w	; $1BD4
	moveq #$3D, D0	; $1BDC
	jsr $366.w	; $1BDE
	bra.w loc_1596	; $1BE2
	movea.w (RAM_word_FFFF9EEE).w, A0	; $1BE6
	addi.w #$10, (-$2600,A0)	; $1BEA
	move.w (RAM_word_FFFF9F00).w, D0	; $1BF0
	cmp.w (-$2600,A0), D0	; $1BF4
	bhi.b *+$12	; $1BF8
	move.w D0, (-$2600,A0)	; $1BFA
	andi.b #-$5, (RAM_PlayerState).w	; $1BFE
	moveq #$3E, D0	; $1C04
	jsr $366.w	; $1C06
loc_1C0A:
	jmp	$8AA2.l				; $1C0A
	moveq #$0, D0	; $1C10
	move.b (RAM_word_FFFF8CAE).w, D0	; $1C12
	move.l A2, -(SP)	; $1C16
	jsr $24DC.w	; $1C18
	movea.l (SP)+, A2	; $1C1C
	bra.w RunSceneEventScript	; $1C1E
	move.b (A2)+, D0	; $1C22
	cmp.b (RAM_word_FFFF959C).w, D0	; $1C24
	bls.w loc_168C	; $1C28
loc_1C2C:
	addq.w #$2, A2	; $1C2C
	bra.w RunSceneEventScript	; $1C2E
	cmpi.w #$E00, (RAM_word_FFFF9F00).w	; $1C32
loc_1C38:
	bcc.w loc_168C	; $1C38
	bra.b loc_1C2C	; $1C3C
	moveq #$C, D0	; $1C3E
	cmp.b (RAM_word_FFFF95BE).w, D0	; $1C40
	bne.b loc_1C2C	; $1C44
	cmp.b (RAM_word_FFFF95BF).w, D0	; $1C46
	bne.b loc_1C2C	; $1C4A
	cmp.b (RAM_word_FFFF95C0).w, D0	; $1C4C
	bne.b loc_1C2C	; $1C50
	cmp.b (RAM_word_FFFF95C1).w, D0	; $1C52
	bne.b loc_1C2C	; $1C56
	cmp.b (RAM_word_FFFF95C2).w, D0	; $1C58
	bne.b loc_1C2C	; $1C5C
	bra.w loc_168C	; $1C5E
	movea.w (RAM_word_FFFF9EEE).w, A0	; $1C62
	move.w (-$2600,A0), D0	; $1C66
	cmp.w (RAM_word_FFFF9F00).w, D0	; $1C6A
	bra.b loc_1C38	; $1C6E
	bsr.w	$8E9C				; $1C70
	bra.b loc_1C2C	; $1C74
	tst.w (RAM_word_FFFF9F32).w	; $1C76
	bmi.b loc_1C2C	; $1C7A
	bra.w loc_168C	; $1C7C
	cmpi.w #$E00, (RAM_word_FFFF9F00).w	; $1C80
	bcc.b *+$1C	; $1C86
	addi.w #$100, (RAM_word_FFFF9F00).w	; $1C88
	movea.w (RAM_word_FFFF9EEE).w, A0	; $1C8E
	addi.w #$100, (-$2600,A0)	; $1C92
	move.l A2, -(SP)	; $1C98
	jsr	$8AA2.l				; $1C9A
loc_1CA0:
	movea.l (SP)+, A2	; $1CA0
loc_1CA2:
	bra.w RunSceneEventScript	; $1CA2
	move.l A2, -(SP)	; $1CA6
	jsr	$76C4.l				; $1CA8
	bra.b loc_1CA0	; $1CAE
	moveq #$0, D0	; $1CB0
	move.b (A2)+, D0	; $1CB2
	move.w D0, (RAM_SceneHeight).w	; $1CB4
	bra.w RunSceneEventScript	; $1CB8
loc_1CBC:
	btst.b #$6, (RAM_InputSelectedNew).w	; $1CBC
	beq.b *+$6	; $1CC2
	moveq #$0, D0	; $1CC4
	bra.b *+$30	; $1CC6
loc_1CC8:
	btst.b #$4, (RAM_InputSelectedNew).w	; $1CC8
	beq.b *+$6	; $1CCE
	moveq #$1, D0	; $1CD0
	bra.b *+$24	; $1CD2
loc_1CD4:
	btst.b #$5, (RAM_InputSelectedNew).w	; $1CD4
	beq.b *+$6	; $1CDA
	moveq #$2, D0	; $1CDC
	bra.b *+$18	; $1CDE
loc_1CE0:
	subq.w #$1, (RAM_word_FFFF8CD4).w	; $1CE0
	bne.w loc_1D70	; $1CE4
	ori.b #$40, (RAM_EventFlag).w	; $1CE8
			dc.w	$45fa,$0082	; dc.w
	moveq #$35, D0	; $1CF2
	bra.b *+$38	; $1CF4
loc_1CF6:
	movea.w D0, A0	; $1CF6
	move.w D0, D7	; $1CF8
	add.w D7, D7	; $1CFA
	addq.w #$6, D7	; $1CFC
	moveq #$2, D6	; $1CFE
	addi.w #-$5FF0, D0	; $1D00
		dc.w	$6100,$034a	; bsr.w
	tst.b (-$7331,A0)	; $1D08
	beq.b *+$10	; $1D0C
	ori.b #$40, (RAM_EventFlag).w	; $1D0E
			dc.w	$45fa,$0067	; dc.w
	moveq #$35, D0	; $1D18
	bra.b *+$12	; $1D1A
loc_1D1C:
	ori.b #-$80, (RAM_EventFlag).w	; $1D1C
			dc.w	$45fa,$0064	; dc.w
	addq.b #$1, (RAM_word_FFFF8CD3).w	; $1D26
	moveq #$34, D0	; $1D2A
loc_1D2C:
	jsr $366.w	; $1D2C
	movea.w (RAM_SceneScriptPtr).w, A0	; $1D30
	addq.w #$4, A0	; $1D34
	move.l A2, (-$7386,A0)	; $1D36
	move.w A0, (RAM_SceneScriptPtr).w	; $1D3A
	move.w #$2, (RAM_CellX).w	; $1D3E
	clr.w (RAM_CellY).w	; $1D44
	move.w #-$7FE0, D0	; $1D48
	moveq #$1, D7	; $1D4C
	moveq #$4, D5	; $1D4E
loc_1D50:
	moveq #$1, D6	; $1D50
	move.w (RAM_SceneWidth).w, D4	; $1D52
loc_1D56:
	jsr $2050.w	; $1D56
	addq.w #$1, D6	; $1D5A
	subq.w #$1, D4	; $1D5C
	bne.b loc_1D56	; $1D5E
	addq.w #$1, D7	; $1D60
	subq.w #$1, D5	; $1D62
	bne.b loc_1D50	; $1D64
	addq.b #$1, (RAM_word_FFFF8CD2).w	; $1D66
	bclr.b #$3, (RAM_PlayerState).w	; $1D6A
loc_1D70:
	rts					; $1D70
QuizStrings:				; loc_0001D72
	dc.b	"Time's up.",0			; $1D72
	dc.b	"Incorrect.",0			; $1D7D
	dc.b	"Correct.",0,0			; $1D88
	andi.w	#$00FF, D0			; $1D92
	cmpi.b	#$60, D0			; $1D96
	bcs.b	*+$C				; $1D9A
	cmpi.b	#$66, D0			; $1D9C
	bcc.b	*+$6				; $1DA0
	subi.w	#$40, D0			; $1DA2
loc_1DA6:
	lsl.w #$2, D0	; $1DA6
	move.l ($1DAE,PC,D0.w), D0	; $1DA8
	rts	; $1DAC
		dc.w	$0000,$4d58	; ori.b
		dc.w	$0000,$09c4	; ori.b
	ori.b #-$6, D0	; $1DB6
	ori.b #$A, D0	; $1DBA
		dc.w	$0000,$2710	; ori.b
		dc.w	$0000,$1964	; ori.b
	ori.b #$50, D0	; $1DC6
		dc.w	$0000,$2134	; ori.b
		dc.w	$0000,$5cf8	; ori.b
		dc.w	$0000,$2710	; ori.b
		dc.w	$0000,$1388	; ori.b
		dc.w	$0000,$0320	; ori.b
	ori.b #-$24, D0	; $1DDE
	ori.b #$46, D0	; $1DE2
	ori.b #$1E, D0	; $1DE6
		dc.w	$0000,$2710	; ori.b
		dc.w	$0000,$4e20	; ori.b
		dc.w	$0000,$1f40	; ori.b
		dc.w	$0000,$0dac	; ori.b
loc_1DFA:
		dc.w	$0000,$07d0	; ori.b
	ori.b #-$6A, D0	; $1DFE
	ori.b #-$38, D0	; $1E02
	ori.b #$32, D0	; $1E06
		dc.w	$0000,$2ee0	; ori.b
		dc.w	$0000,$2710	; ori.b
		dc.w	$0000,$0fa0	; ori.b
		dc.w	$0000,$04b0	; ori.b
		dc.w	$0000,$012c	; ori.b
	ori.b #$32, D0	; $1E1E
	ori.b #$1E, D0	; $1E22
	ori.b #$14, D0	; $1E26
		dc.w	$0000,$1388	; ori.b
		dc.w	$0000,$01f4	; ori.b
		dc.w	$0000,$01f4	; ori.b
		dc.w	$0000,$01f4	; ori.b
		dc.w	$0000,$01f4	; ori.b
		dc.w	$0000,$01f4	; ori.b
		dc.w	$0000,$01f4	; ori.b
	ori.b #$64, D0	; $1E46
		dc.w	$0001,$e240	; ori.b
		dc.w	$0000,$09c4	; ori.b
		dc.w	$0007,$a120	; ori.b
		dc.w	$0000,$0bb8	; ori.b
	ori.b #$A, D0	; $1E5A
	ori.b #$32, D0	; $1E5E
	ori.b #-$38, D0	; $1E62
		dc.w	$0000,$1388	; ori.b
loc_1E6A:
	clr.w (RAM_word_FFFF8D10).w	; $1E6A
	clr.w (RAM_word_FFFF8CDE).w	; $1E6E
	lea (-$7320).w, A3	; $1E72
	moveq #$D, D3	; $1E76
	bsr.w loc_1ED0	; $1E78
loc_1E7C:
	move.b (A2)+, D3	; $1E7C
	bne.b *+$14	; $1E7E
	move.w (RAM_word_FFFF8D10).w, D0	; $1E80
	bne.b *+$4	; $1E84
	rts	; $1E86
loc_1E88:
	subq.w #$4, D0	; $1E88
	movea.w D0, A0	; $1E8A
	movea.l (-$7300,A0), A2	; $1E8C
	bra.b loc_1E7C	; $1E90
loc_1E92:
	cmpi.b #$10, D3	; $1E92
	bcc.b *+$1E	; $1E96
	cmpi.b #$C, D3	; $1E98
loc_1E9C:
	bcs.w loc_1E9C	; $1E9C
	move.b (A2)+, D0	; $1EA0
	movea.w (RAM_word_FFFF8D10).w, A0	; $1EA2
	move.l A2, (-$7300,A0)	; $1EA6
	addq.w #$4, A0	; $1EAA
	move.w A0, (RAM_word_FFFF8D10).w	; $1EAC
	bsr.b *+$20	; $1EB0
	bra.b loc_1E7C	; $1EB2
loc_1EB4:
	moveq #$20, D2	; $1EB4
	cmpi.b #-$2, D3	; $1EB6
	bcs.b *+$A	; $1EBA
	subi.b #$40, D3	; $1EBC
	move.b D3, D2	; $1EC0
	move.b (A2)+, D3	; $1EC2
loc_1EC4:
	move.b D3, ($10,A3)	; $1EC4
	move.b D2, (A3)+	; $1EC8
	addq.w #$1, (RAM_word_FFFF8CDE).w	; $1ECA
	bra.b loc_1E7C	; $1ECE
loc_1ED0:
	andi.w #$3, D3	; $1ED0
	lsl.w #$2, D3	; $1ED4
	movea.l ($1CC10).l, A2	; $1ED6
	movea.l ($0,A2,D3.w), A2	; $1EDC
	andi.w #$FF, D0	; $1EE0
	add.w D0, D0	; $1EE4
	adda.w ($0,A2,D0.w), A2	; $1EE6
	rts	; $1EEA
loc_1EEC:
	bsr.w loc_1E6A	; $1EEC
	bsr.w loc_1FAC	; $1EF0
	move.w (RAM_word_FFFF8CDE).w, D0	; $1EF4
	addi.w #$6, D0	; $1EF8
	moveq #$1C, D1	; $1EFC
	sub.w D0, D1	; $1EFE
	andi.w #-$2, D1	; $1F00
	lea (-$72EE).w, A2	; $1F04
	adda.w D1, A2	; $1F08
	move.w #-$7FE0, D1	; $1F0A
	move.w D1, D0	; $1F0E
			dc.w	$41fa,$00d4	; dc.w
	bsr.w loc_1F8E	; $1F14
	lea (-$7320).w, A0	; $1F18
	move.w #-$6000, D0	; $1F1C
	move.w (RAM_word_FFFF8CDE).w, D1	; $1F20
	beq.b *+$12	; $1F24
loc_1F26:
	move.b ($10,A0), D0	; $1F26
	move.w D0, ($40,A2)	; $1F2A
	move.b (A0)+, D0	; $1F2E
	move.w D0, (A2)+	; $1F30
	subq.w #$1, D1	; $1F32
	bne.b loc_1F26	; $1F34
loc_1F36:
	move.w #-$7FE0, D1	; $1F36
	move.w D1, D0	; $1F3A
			dc.w	$41fa,$00c1	; dc.w
	bsr.w loc_1F8E	; $1F40
	rts	; $1F44
loc_1F46:
	link	A6, #-$C			; $1F46
	dc.w	$6160	; 1F4A
	move.l D0, D1	; $1F4C
	lea (-$2,A6), A1	; $1F4E
	movea.l A1, A0	; $1F52
	bsr.w loc_183E	; $1F54
	suba.l A1, A0	; $1F58
	move.w A0, D0	; $1F5A
	addi.w #$5, D0	; $1F5C
	moveq #$1A, D1	; $1F60
	sub.w D0, D1	; $1F62
	andi.w #-$2, D1	; $1F64
	lea (-$72EE).w, A2	; $1F68
	adda.w D1, A2	; $1F6C
	move.w #-$7FE0, D1	; $1F6E
	move.w D1, D0	; $1F72
			dc.w	$41fa,$007b	; dc.w
	bsr.w loc_1F8E	; $1F78
	movea.l A1, A0	; $1F7C
	bsr.w loc_1F8E	; $1F7E
			dc.w	$41fa,$0074	; dc.w
	bsr.w loc_1F8E	; $1F86
	unlk A6	; $1F8A
	rts	; $1F8C
loc_1F8E:
	move.w D1, D2	; $1F8E
loc_1F90:
	move.b (A0)+, D0	; $1F90
	beq.b *+$18	; $1F92
	cmpi.b #-$2, D0	; $1F94
	bcs.b *+$A	; $1F98
	move.b D0, D2	; $1F9A
	subi.b #$40, D2	; $1F9C
	bra.b loc_1F90	; $1FA0
loc_1FA2:
	move.w D0, ($40,A2)	; $1FA2
	move.w D2, (A2)+	; $1FA6
	bra.b loc_1F8E	; $1FA8
loc_1FAA:
	rts	; $1FAA
loc_1FAC:
	lea (-$72EE).w, A0	; $1FAC
	move.w #-$7FE0, D2	; $1FB0
	move.w #-$785F, D3	; $1FB4
	bsr.w loc_1FBC	; $1FB8
loc_1FBC:
	move.w D3, (A0)+	; $1FBC
	moveq #$1D, D1	; $1FBE
	move.w D2, (A0)+	; $1FC0
	dbf D1, $1FC0	; $1FC2
	move.w D3, (A0)+	; $1FC6
	rts	; $1FC8
	bsr.w loc_1F46	; $1FCA
	bra.b *+$6	; $1FCE
	bsr.w loc_1EEC	; $1FD0
loc_1FD4:
	lea (-$72EE).w, A0	; $1FD4
	jsr	$7EEE.l				; $1FD8
	move.w #$3C, (RAM_word_FFFF965C).w	; $1FDE
	rts					; $1FE4
FoundGoldStrings:				; loc_0001FE6
	dc.b	"Found the ",$00,"Found ",$00	; $1FE6
	dc.b	" GOLD.",$00,".",$00,$00		; $1FF8
; ----------------------------------------------------------------------
; SetupScene: scene-entry geometry set-up. Resolves the scene (ResolveScene),
; then reads the scene type entry: X origin -> RAM_SceneOriginX, Y origin
; (x2-1) -> RAM_SceneOriginY, width -> RAM_SceneWidth, height ->
; RAM_SceneHeight. Sets RAM_PlayerState = $80 (scene active).
; ----------------------------------------------------------------------
SetupScene:
	jsr	$276C.w				; $2002
	moveq	#$0, D0				; $2006
	move.b	(A1)+, D0			; $2008
	subq.w	#$1, D0				; $200A
	move.w	D0, (RAM_SceneOriginX).w		; $200C
	move.w	D0, (RAM_ScrollOffsetX).w		; $2010
	moveq	#$0, D0				; $2014
	move.b	(A1)+, D0			; $2016
	add.w	D0, D0				; $2018
	subq.w	#$1, D0				; $201A
	move.w	D0, (RAM_SceneOriginY).w		; $201C
	move.w	D0, (RAM_ScrollOffsetY).w		; $2020
	moveq	#$0, D0				; $2024
	move.b	(A1)+, D0			; $2026
	move.w	D0, (RAM_SceneWidth).w		; $2028
	move.b	(A1)+, D0			; $202C
	move.w	D0, (RAM_SceneHeight).w		; $202E
	move.b	#$80, (RAM_PlayerState).w		; $2032
	rts					; $2038
GetMagicMeterValue:				; loc_000203A
	tst.b	(RAM_word_FFFF8A8B).w			; $203A
	beq.b	*+$10				; $203E
	moveq	#$0, D1				; $2040
	move.b	D0, D1				; $2042
	lsl.w	#$2, D1				; $2044
			dc.w	$d240	; dc.w
	dc.w	$C141				; $2048  ; EXG D1,D0
	moveq	#$6, D1				; $204A
	divu.w	D1, D0				; $204C
	rts					; $204E
; ----------------------------------------------------------------------
; WriteTilemapEntry: writes one tilemap word to Plane A. Computes the Plane A
; VRAM address from (scroll Y + row) << 6 + (scroll X + col), ORs $4000 (Plane A
; base), emits the VDP control word then the tile+attribute word. D0 = tile word,
; D6/D7 = col/row.
; ----------------------------------------------------------------------
WriteTilemapEntry:
	move.w	D7, D1				; $2050
	add.w	(RAM_ScrollOffsetY).w, D1		; $2052
	andi.w	#$1F, D1			; $2056
	lsl.w	#$6, D1				; $205A
	move.w	D6, D2				; $205C
	add.w	(RAM_ScrollOffsetX).w, D2		; $205E
	andi.w	#$3F, D2			; $2062
	add.w	D2, D1				; $2066
	add.w	D1, D1				; $2068
	ori.w	#$4000, D1			; $206A
	swap	D1				; $206E
	move.w	#$3, D1				; $2070
	move.l	D1, ($C00004).l			; $2074
	move.w	D0, ($C00000).l			; $207A
	rts					; $2080
; ----------------------------------------------------------------------
; RenderTilemapPlane: bulk tilemap renderer. Iterates the visible rows/cols of
; the decoded map buffer (A0) and streams them to Plane A, honouring the
; render-control values RAM_RenderRowSkip/RAM_RenderColSkip.
; ----------------------------------------------------------------------
RenderTilemapPlane:
	move.l	A2, -(SP)			; $2082
	lea	($C00000).l, A0			; $2084
	lea	($4,A0), A1			; $208A
	move.w	(RAM_RenderColSkip).w, D4		; $208E
	lsl.w	#$7, D4				; $2092
	move.w	(RAM_RenderRows).w, D7		; $2094
	move.w	(RAM_RenderRowSkip).w, D6		; $2098
RenderTilemapRow:
	move.w	D7, D3				; $209C
	add.w	(RAM_ScrollOffsetY).w, D3		; $209E
	andi.w	#$1F, D3			; $20A2
	lsl.w	#$7, D3				; $20A6
	move.w	(RAM_RenderMode).w, D2		; $20A8
	add.w	(RAM_ScrollOffsetX).w, D2		; $20AC
	add.w	D2, D2				; $20B0
	ori.w	#$4000, D2			; $20B2
	move.w	(RAM_RenderCols).w, D5		; $20B6
	move.w	D2, D1				; $20BA
	lea	(-$7258).w, A2			; $20BC
loc_20C0:
	andi.w	#$7E, D2			; $20C0
loc_20C4:
	move.w	(A1), D0			; $20C4
	btst	#$9, D0				; $20C6
	beq.b	loc_20C4			; $20CA
	move.w	D3, D0				; $20CC
	add.w	D4, D0				; $20CE
	or.w	D2, D0				; $20D0
	andi.w	#$FFE, D0			; $20D2
	swap	D0				; $20D6
	move.w	#$3, D0				; $20D8
	move.l	D0, (A1)			; $20DC
	move.w	(A0), (A2)+			; $20DE
	addq.w	#$2, D2				; $20E0
	subq.w	#$1, D5				; $20E2
	bne.b	loc_20C0			; $20E4
	move.w	(RAM_RenderCols).w, D5		; $20E6
	lea	(-$7258).w, A2			; $20EA
loc_20EE:
	andi.w	#$407E, D1			; $20EE
	move.w	D3, D0				; $20F2
	or.w	D1, D0				; $20F4
	swap	D0				; $20F6
	move.w	#$3, D0				; $20F8
	move.l	D0, (A1)			; $20FC
	move.w	(A2)+, (A0)			; $20FE
	addq.w	#$2, D1				; $2100
	subq.w	#$1, D5				; $2102
	bne.b	loc_20EE			; $2104
	addq.w	#$1, D7				; $2106
	subq.w	#$1, D6				; $2108
	bne.b	RenderTilemapRow			; $210A
	movea.l	(SP)+, A2			; $210C
	rts					; $210E
UpdateScrollRegs:				; loc_0002110
	move.w	(RAM_PlayerX).w, D0		; $2110
	lsr.w	#$3, D0				; $2114
	add.w	(RAM_SceneOriginX).w, D0		; $2116
	andi.w	#$3F, D0			; $211A
	move.w	D0, (RAM_ScrollOffsetX).w		; $211E
	move.w	(RAM_PlayerY).w, D0		; $2122
	lsr.w	#$3, D0				; $2126
	add.w	(RAM_SceneOriginY).w, D0		; $2128
	andi.w	#$1F, D0			; $212C
	move.w	D0, (RAM_ScrollOffsetY).w		; $2130
	moveq	#$0, D7				; $2134
	move.w	#$8014, D0			; $2136
	move.l	#$88148015, D5			; $213A
	bsr.w	$21E8				; $2140
	moveq	#$1, D7				; $2144
	move.w	(RAM_ScreenTilesY).w, D4		; $2146
	subq.w	#$3, D4				; $214A
	move.w	#$8016, D0			; $214C
		dc.w	$2a3c,$8816,$8020	; move.l
	bsr.w	$21E8				; $2156
	addq.w	#$1, D7				; $215A
	dbf	D4, $214C			; $215C
	move.w	#$9014, D0			; $2160
	move.l	#$98149015, D5			; $2164
	bsr.b	$21E8				; $216A
	move.w	(RAM_SceneOriginX).w, D4		; $216C
	lsl.w	#$3, D4				; $2170
	add.w	(RAM_PlayerX).w, D4		; $2172
	move.w	(RAM_ScreenTilesX).w, D6		; $2176
	lsl.w	#$3, D6				; $217A
	move.w	(RAM_SceneOriginY).w, D5		; $217C
	lsl.w	#$3, D5				; $2180
	add.w	(RAM_PlayerY).w, D5		; $2182
	move.w	(RAM_ScreenTilesY).w, D7		; $2186
	lsl.w	#$3, D7				; $218A
	movea.w	#$0, A4				; $218C
	moveq	#$0, D1				; $2190
	moveq	#$3F, D3				; $2192
loc_2194:
	tst.b	(-$4000,A4)			; $2194
	bpl.b	*+$48				; $2198
	tst.b	(-$3FFE,A4)			; $219A
	bpl.b	*+$42				; $219E
	cmpi.b	#$4, (-$3CFD,A4)		; $21A0
	bcs.b	*+$3A				; $21A6
	move.w	(-$3800,A4), D0		; $21A8
	move.b	(-$34FE,A4), D1		; $21AC
	add.w	D1, D0				; $21B0
	sub.w	D4, D0				; $21B2
	bls.b	*+$2C				; $21B4
	sub.w	D1, D0				; $21B6
	sub.w	D1, D0				; $21B8
	cmp.w	D6, D0				; $21BA
	bge.b	*+$24				; $21BC
	move.w	(-$3700,A4), D0		; $21BE
	move.b	(-$34FD,A4), D1		; $21C2
	add.w	D1, D0				; $21C6
	sub.w	D5, D0				; $21C8
	bls.b	*+$16				; $21CA
	sub.w	D1, D0				; $21CC
	sub.w	D1, D0				; $21CE
	cmp.w	D7, D0				; $21D0
	bge.b	*+$E				; $21D2
	andi.b	#$7F, (-$3FFE,A4)		; $21D4
	ori.b	#$4, (-$4000,A4)		; $21DA
loc_21E0:
	addq.l	#$4, A4				; $21E0
	dbf	D3, loc_2194			; $21E2
	rts					; $21E6
WriteScrollRegs:
	moveq	#$0, D6				; $21E8
	bsr.w	$2050				; $21EA
	addq.w	#$1, D6				; $21EE
	move.w	(RAM_ScreenTilesX).w, D3		; $21F0
	subq.w	#$3, D3				; $21F4
loc_21F6:
	move.w	D5, D0				; $21F6
	bsr.w	$2050				; $21F8
	addq.w	#$1, D6				; $21FC
	dbf	D3, loc_21F6			; $21FE
	swap	D5				; $2202
	move.w	D5, D0				; $2204
		dc.w	$6000,$fe48	; bra.w
