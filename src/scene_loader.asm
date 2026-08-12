; ======================================================================
; src/scene_loader.asm
; Scene tile loader, ResolveScene, text decoder, item actions
; Covers ROM $220A-$3000.
; Verified bit-exact against the original ROM.
; ======================================================================
loc_220A:
	lea (-$68AC).w, A3	; $220A
	moveq #$0, D1	; $220E
	move.w ($6,A3), D0	; $2210
	lsr.w #$3, D0	; $2214
	add.w (RAM_SceneOriginY).w, D0	; $2216
	add.w D7, D0	; $221A
	lsr.w #$1, D0	; $221C
	roxl.w #$1, D1	; $221E
	lsl.w #$6, D0	; $2220
	swap D7	; $2222
	move.w D0, D7	; $2224
	move.w ($4,A3), D0	; $2226
	lsr.w #$3, D0	; $222A
	add.w (RAM_SceneOriginX).w, D0	; $222C
	add.w D6, D0	; $2230
	lsr.w #$1, D0	; $2232
	roxl.w #$2, D1	; $2234
	swap D6	; $2236
	move.w D0, D6	; $2238
	move.w D1, -(SP)	; $223A
	jsr $2542.w	; $223C
	moveq #$0, D1	; $2240
	move.b D0, D1	; $2242
	andi.w #$300, D0	; $2244
	lsr.w #$6, D0	; $2248
	movea.l ($10,A3,D0.w), A0	; $224A
	lsl.w #$3, D1	; $224E
	add.w (SP)+, D1	; $2250
	move.w ($0,A0,D1.w), D0	; $2252
	swap D6	; $2256
	swap D7	; $2258
	rts	; $225A
	moveq #$0, D7	; $225C
loc_225E:
	moveq #$0, D6	; $225E
loc_2260:
	bsr.w loc_220A	; $2260
	bsr.w loc_2050	; $2264
	addq.w #$1, D6	; $2268
	cmp.w (RAM_ScreenTilesX).w, D6	; $226A
	bcs.b loc_2260	; $226E
	addq.w #$1, D7	; $2270
	cmp.w (RAM_ScreenTilesY).w, D7	; $2272
	bcs.b loc_225E	; $2276
	movea.w #$0, A4	; $2278
	moveq #$40, D0	; $227C
	tst.b (-$4000,A4)	; $227E
	bpl.b *+$10	; $2282
	bclr.b #$2, (-$4000,A4)	; $2284
	beq.b *+$8	; $228A
	ori.b #-$80, (-$3FFE,A4)	; $228C
loc_2292:
	addq.l #$4, A4	; $2292
	dbf D0, $227E	; $2294
	btst.b #$0, (RAM_word_FFFF8A51).w	; $2298
	beq.b *+$8	; $229E
	jmp $DE6A.l	; $22A0
loc_22A6:
	rts	; $22A6
	jsr $5A0.w	; $22A8
	lea ($C00000).l, A1	; $22AC
	move.w D1, D0	; $22B2
	bne.b *+$C	; $22B4
	moveq #$0, D0	; $22B6
	move.l D0, (A1)	; $22B8
	dbf D2, $22B8	; $22BA
	rts	; $22BE
loc_22C0:
	andi.w #-$20, D1	; $22C0
	lsr.w #$3, D1	; $22C4
	movea.w D1, A0	; $22C6
	adda.l #$41000, A0	; $22C8
	move.l (A0), D1	; $22CE
loc_22D0:
	bmi.w loc_22D0	; $22D0
	bclr.l #$18, D1	; $22D4
loc_22D8:
	beq.w loc_22D8	; $22D8
	movea.l D1, A0	; $22DC
	andi.w #$1F, D0	; $22DE
	lsl.w #$5, D0	; $22E2
	adda.w D0, A0	; $22E4
	subq.w #$1, D2	; $22E6
	move.l (A0)+, (A1)	; $22E8
	dbf D2, $22E8	; $22EA
	rts	; $22EE
	link A6, #-$2	; $22F0
	lea (-$71F8).w, A0	; $22F4
	move.w #$0, (-$2,A6)	; $22F8
loc_22FE:
	move.w (A0)+, D0	; $22FE
	bmi.b *+$3C	; $2300
	cmp.w ($7E,A0), D0	; $2302
	beq.b *+$36	; $2306
	move.w D0, ($7E,A0)	; $2308
	move.w A0, -(SP)	; $230C
	lea RAM_TileStagingBuffer, A1	; $230E
	jsr $6BC4.l	; $2314
	movea.w (SP)+, A0	; $231A
	move.w (-$2,A6), D0	; $231C
	ror.w #$6, D0	; $2320
	jsr $5A0.w	; $2322
	lea RAM_TileStagingBuffer, A1	; $2326
	lea ($C00000).l, A2	; $232C
	move.w #$FF, D0	; $2332
	move.l (A1)+, (A2)	; $2336
	dbf D0, $2336	; $2338
loc_233C:
	addq.w #$1, (-$2,A6)	; $233C
	cmpi.w #$40, (-$2,A6)	; $2340
	bcs.b loc_22FE	; $2346
	unlk A6	; $2348
	rts	; $234A
loc_234C:
	move.b (A0)+, D0	; $234C
	bmi.b *+$8	; $234E
	move.b D0, (A1)+	; $2350
	move.b (A0)+, (A1)+	; $2352
	bra.b loc_234C	; $2354
loc_2356:
	cmpi.b #-$40, D0	; $2356
	bcc.b *+$10	; $235A
	andi.w #$3F, D0	; $235C
	add.w D0, D0	; $2360
	movea.w D0, A1	; $2362
	lea (-$71F8,A1), A1	; $2364
	bra.b loc_234C	; $2368
loc_236A:
	bne.b *+$6	; $236A
	addq.l #$2, A1	; $236C
	bra.b loc_234C	; $236E
loc_2370:
	cmpi.b #-$1, D0	; $2370
	beq.b *+$30	; $2374
	cmpi.b #-$8, D0	; $2376
	bcc.b *+$18	; $237A
	andi.w #$3F, D0	; $237C
	subq.w #$1, D0	; $2380
	move.b (A0)+, D1	; $2382
	lsl.w #$8, D1	; $2384
	move.b (A0)+, D1	; $2386
	move.w D1, (A1)+	; $2388
	addq.w #$1, D1	; $238A
	dbf D0, $2388	; $238C
	bra.b loc_234C	; $2390
loc_2392:
	andi.w #$7, D0	; $2392
	moveq #-$1, D1	; $2396
	move.w D1, ($80,A1)	; $2398
	move.w D1, (A1)+	; $239C
	dbf D0, $2398	; $239E
	bra.b loc_234C	; $23A2
loc_23A4:
	rts	; $23A4
	move.l A0, -(SP)	; $23A6
	lea ($6EA8).l, A1	; $23A8
	jsr $47A.w	; $23AE
	movea.l (SP)+, A0	; $23B2
	lea (-$6AF4).w, A1	; $23B4
	moveq #$7, D0	; $23B8
	tst.w (A1)	; $23BA
	bpl.b *+$10	; $23BC
	lea ($10,A1), A1	; $23BE
	dbf D0, $23BA	; $23C2
loc_23C6:
	jmp	loc_23C6.l			; $23C6
loc_23CC:
	clr.b (RAM_word_FFFF950A).w	; $23CC
	move.l #-$80000000, (A1)	; $23D0
	move.w (A0)+, ($4,A1)	; $23D6
	move.l A0, ($8,A1)	; $23DA
	move.l A0, ($C,A1)	; $23DE
	rts	; $23E2
	andi.w #$FF, D0	; $23E4
			dc.w	$43fa,$00ee	; dc.w
	cmp.b (A1)+, D0	; $23EC
	bcs.b *+$A	; $23EE
	ori.b #-$8, D0	; $23F0
	jmp $274C.w	; $23F4
loc_23F8:
	cmpi.b #$29, D0	; $23F8
	bne.b *+$C	; $23FC
	cmpi.b #$63, (RAM_word_FFFF959C).w	; $23FE
	bcs.b *+$52	; $2404
	bra.b *+$4C	; $2406
loc_2408:
	cmp.b (A1)+, D0	; $2408
	bcs.b *+$20	; $240A
	move.w D0, D1	; $240C
	bsr.w loc_2510	; $240E
	cmpi.b #$12, D0	; $2412
	bcs.b *+$10	; $2416
	subi.b #$2B, D1	; $2418
	tst.b (A0)	; $241C
	bmi.b *+$38	; $241E
	cmp.b (A0), D1	; $2420
	bhi.b *+$34	; $2422
	bra.b *+$2E	; $2424
loc_2426:
	tst.b (A0)	; $2426
	rts	; $2428
loc_242A:
	addq.w #$1, A1	; $242A
	cmp.b (A1)+, D0	; $242C
	bcs.b *+$1C	; $242E
	andi.b #$F, D0	; $2430
	moveq #$B, D1	; $2434
	cmpi.b #$5, D0	; $2436
	bcs.b *+$4	; $243A
	moveq #$0, D1	; $243C
loc_243E:
	lea (-$6A42).w, A0	; $243E
	cmp.b ($0,A0,D0.w), D1	; $2442
	bcc.b *+$10	; $2446
	bra.b *+$A	; $2448
loc_244A:
	bsr.w loc_2536	; $244A
	btst.b D0, (A0)	; $244E
	rts	; $2450
loc_2452:
	moveq #-$1, D0	; $2452
	rts	; $2454
loc_2456:
	moveq #$0, D0	; $2456
	rts	; $2458
	andi.w #$FF, D0	; $245A
			dc.w	$43fa,$0078	; dc.w
	cmp.b (A1)+, D0	; $2462
	bcs.b *+$18	; $2464
	move.b D0, D2	; $2466
	ori.b #-$8, D0	; $2468
	jsr $2752.w	; $246C
	move.b D2, D0	; $2470
	andi.w #$F, D0	; $2472
	jmp $8A04.l	; $2476
loc_247C:
	cmp.b (A1)+, D0	; $247C
	bcs.b *+$3C	; $247E
	move.w D0, D1	; $2480
	bsr.w loc_2510	; $2482
	cmpi.b #$12, D0	; $2486
	beq.b *+$6	; $248A
	addq.b #$1, (A0)	; $248C
	rts	; $248E
loc_2490:
	subi.b #$2B, D1	; $2490
	move.b D1, (A0)	; $2494
	addq.b #$8, D1	; $2496
	lea (-$60F0).w, A0	; $2498
	moveq #$1, D0	; $249C
	cmpi.b #$8, (A0)	; $249E
	bcs.b *+$10	; $24A2
	cmpi.b #$C, (A0)	; $24A4
	bcc.b *+$A	; $24A8
	move.b D1, (A0)	; $24AA
	jmp $76C4.l	; $24AC
loc_24B2:
	addq.w #$1, A0	; $24B2
	dbf D0, $249E	; $24B4
	rts	; $24B8
loc_24BA:
	cmp.b (A1)+, D0	; $24BA
	bcs.b *+$8	; $24BC
	jmp $8A3A.l	; $24BE
loc_24C4:
	cmp.b (A1)+, D0	; $24C4
	bcs.b *+$C	; $24C6
	andi.w #$F, D0	; $24C8
	jmp $8A04.l	; $24CC
loc_24D2:
	bsr.b *+$64	; $24D2
	bset.b D0, (A0)	; $24D4
	rts	; $24D6
	bra.b *+$2A	; $24D8
	move.l -(A0), D3	; $24DA
	andi.w #$FF, D0	; $24DC
	cmpi.b #$20, D0	; $24E0
	bcs.b *+$26	; $24E4
	move.w D0, D3	; $24E6
	jsr $882C.l	; $24E8
	move.w D3, D0	; $24EE
	move.w D0, D1	; $24F0
	bsr.b *+$1E	; $24F2
	cmpi.b #$12, D0	; $24F4
	beq.b *+$6	; $24F8
	subq.b #$1, (A0)	; $24FA
	rts	; $24FC
loc_24FE:
	tst.b (A0)	; $24FE
	bmi.b *+$E	; $2500
loc_2502:
	subi.b #$2A, D1	; $2502
	sub.b D1, (A0)	; $2506
	rts	; $2508
loc_250A:
	bsr.b *+$2C	; $250A
	bclr.b D0, (A0)	; $250C
loc_250E:
	rts	; $250E
loc_2510:
	lea (-$6A74).w, A0	; $2510
	cmpi.b #$29, D0	; $2514
	bcc.b *+$8	; $2518
	subi.b #$1C, D0	; $251A
	bra.b *+$14	; $251E
loc_2520:
	subi.b #$30, D0	; $2520
	bcc.b *+$E	; $2524
	addi.b #$17, D0	; $2526
	cmpi.b #$12, D0	; $252A
	bcs.b *+$4	; $252E
	moveq #$12, D0	; $2530
loc_2532:
	adda.w D0, A0	; $2532
	rts	; $2534
loc_2536:
	lea (-$6A36).w, A0	; $2536
	move.w D0, D1	; $253A
	lsr.w #$3, D1	; $253C
	adda.w D1, A0	; $253E
	rts	; $2540
	moveq #$0, D0	; $2542
	move.w D6, D2	; $2544
	subi.w #$100, D2	; $2546
	bcc.b *+$6	; $254A
	moveq #$0, D2	; $254C
	bra.b *+$C	; $254E
loc_2550:
	cmp.w ($44,A3), D2	; $2550
	bls.b *+$6	; $2554
	move.w ($44,A3), D2	; $2556
loc_255A:
	move.w D7, D3	; $255A
	subi.w #$4000, D3	; $255C
	bcc.b *+$6	; $2560
	moveq #$0, D3	; $2562
	bra.b *+$C	; $2564
loc_2566:
	cmp.w ($46,A3), D3	; $2566
	bls.b *+$6	; $256A
	move.w ($46,A3), D3	; $256C
loc_2570:
	moveq #$0, D5	; $2570
	move.w #$C00, D4	; $2572
	cmp.w D4, D3	; $2576
	bcs.b *+$6	; $2578
	sub.w D4, D3	; $257A
	moveq #$20, D5	; $257C
loc_257E:
	lsr.w #$1, D4	; $257E
	cmp.w D4, D3	; $2580
	bcs.b *+$8	; $2582
	sub.w D4, D3	; $2584
	addi.w #$10, D5	; $2586
loc_258A:
	lsr.w #$1, D4	; $258A
	cmp.w D4, D3	; $258C
	bcs.b *+$6	; $258E
	sub.w D4, D3	; $2590
	addq.b #$8, D5	; $2592
loc_2594:
	btst.b #$1, ($0,A3)	; $2594
	beq.b *+$4	; $259A
	clr.w D5	; $259C
loc_259E:
	move.w D2, D4	; $259E
	lsr.w #$4, D4	; $25A0
	or.w D5, D4	; $25A2
	movea.w ($22,A3), A0	; $25A4
	move.b ($0,A0,D4.w), D4	; $25A8
	bmi.b *+$1C	; $25AC
	add.w D4, D4	; $25AE
	lsr.w #$1, D3	; $25B0
	moveq #$F, D1	; $25B2
	and.w D2, D1	; $25B4
	add.w D1, D1	; $25B6
	add.w D3, D1	; $25B8
	add.w ($25CA,PC,D4.w), D1	; $25BA
	lea RAM_word_00FF5000, A0	; $25BE
	move.w ($0,A0,D1.w), D0	; $25C4
loc_25C8:
	rts	; $25C8
DamageStatTable:				; loc_00025CA
	dc.w	$0000,$0180,$0300,$0480,$0600,$0780,$0900,$0A80	; $25CA
	dc.w	$0C00,$0D80,$0F00,$1080,$1200,$1380,$1500,$1680	; $25DA
	dc.w	$1800,$1980,$1B00,$1C80,$1E00,$1F80,$2100,$2280	; $25EA
	dc.w	$2400,$2580,$2700,$2880,$2A00,$2B80,$2D00,$2E80	; $25FA
loc_260A:
	move.w D6, D2	; $260A
	subi.w #$100, D2	; $260C
	move.w D7, D3	; $2610
	subi.w #$4000, D3	; $2612
	moveq #$0, D5	; $2616
	move.w #$C00, D4	; $2618
	cmp.w D4, D3	; $261C
	bcs.b *+$6	; $261E
	sub.w D4, D3	; $2620
	moveq #$20, D5	; $2622
loc_2624:
	lsr.w #$1, D4	; $2624
	cmp.w D4, D3	; $2626
	bcs.b *+$8	; $2628
	sub.w D4, D3	; $262A
	addi.w #$10, D5	; $262C
loc_2630:
	lsr.w #$1, D4	; $2630
	cmp.w D4, D3	; $2632
	bcs.b *+$6	; $2634
	sub.w D4, D3	; $2636
	addq.b #$8, D5	; $2638
loc_263A:
	move.w D2, D4	; $263A
	lsr.w #$4, D4	; $263C
	or.w D5, D4	; $263E
	movea.w ($22,A3), A0	; $2640
	move.b ($0,A0,D4.w), D4	; $2644
	move.w D4, D5	; $2648
	add.w D4, D4	; $264A
	add.w D5, D4	; $264C
	lsl.w #$7, D4	; $264E
	lsr.w #$1, D3	; $2650
	add.w D3, D4	; $2652
	andi.w #$F, D2	; $2654
	add.w D2, D2	; $2658
	add.w D2, D4	; $265A
	lea RAM_word_00FF5000, A0	; $265C
	adda.w D4, A0	; $2662
	rts	; $2664
loc_2666:
	bsr.b loc_260A	; $2666
	move.w D0, (A0)	; $2668
	rts	; $266A
	lea (-$68AC).w, A3	; $266C
loc_2670:
	bsr.b loc_2666	; $2670
	move.w D6, D1	; $2672
	sub.w ($8,A3), D1	; $2674
	bcs.b *+$18	; $2678
	cmp.w ($A,A3), D1	; $267A
	bcc.b *+$12	; $267E
	move.w D7, D1	; $2680
	sub.w ($C,A3), D1	; $2682
	bcs.b *+$A	; $2686
	cmp.w ($E,A3), D1	; $2688
	bcs.w loc_2694	; $268C
loc_2690:
	rts	; $2690
	bsr.b loc_2666	; $2692
loc_2694:
	move.w D0, D2	; $2694
	moveq #$0, D1	; $2696
	move.b D0, D1	; $2698
	andi.w #$300, D0	; $269A
	lsr.w #$6, D0	; $269E
	movea.l ($10,A3,D0.w), A0	; $26A0
	lsl.w #$3, D1	; $26A4
	adda.w D1, A0	; $26A6
	lea ($C00000).l, A1	; $26A8
	moveq #$1F, D1	; $26AE
	and.w D6, D1	; $26B0
	move.w D7, D3	; $26B2
	andi.w #$3C0, D3	; $26B4
	add.w D3, D1	; $26B8
	lsl.w #$2, D1	; $26BA
	or.w ($20,A3), D1	; $26BC
	swap D1	; $26C0
	addq.w #$3, D1	; $26C2
	move.l D1, ($4,A1)	; $26C4
	bset.l #$17, D1	; $26C8
	tst.w D2	; $26CC
	bmi.b *+$C	; $26CE
	move.l (A0)+, (A1)	; $26D0
	move.l D1, ($4,A1)	; $26D2
	move.l (A0), (A1)	; $26D6
	rts	; $26D8
loc_26DA:
	move.l #-$7FFF8000, D3	; $26DA
	move.l (A0)+, D0	; $26E0
	or.l D3, D0	; $26E2
	move.l D0, (A1)	; $26E4
	move.l D1, ($4,A1)	; $26E6
	or.l (A0), D3	; $26EA
	move.l D3, (A1)	; $26EC
	rts	; $26EE
	jsr $2542.w	; $26F0
	move.w D0, D1	; $26F4
	andi.w #$300, D1	; $26F6
	lsr.w #$6, D1	; $26FA
	movea.l ($10,A3,D1.w), A0	; $26FC
	move.w #$800, D1	; $2700
	move.b D0, D1	; $2704
	move.b ($0,A0,D1.w), D1	; $2706
	rts	; $270A
loc_270C:
	moveq #$0, D2	; $270C
	move.b D0, D2	; $270E
	lsr.w #$3, D2	; $2710
	move.b D0, D1	; $2712
	andi.w #$7, D1	; $2714
	lea (-$6646).w, A0	; $2718
	cmpi.b #$20, D0	; $271C
	bcs.b *+$6	; $2720
	lea (-$6642).w, A0	; $2722
loc_2726:
	rts	; $2726
	bsr.b loc_270C	; $2728
	btst.b D1, ($0,A0,D2.w)	; $272A
	rts	; $272E
	bsr.b loc_270C	; $2730
	bset.b D1, ($0,A0,D2.w)	; $2732
	rts	; $2736
loc_2738:
	moveq #$0, D1	; $2738
	move.b D0, D1	; $273A
	lsr.w #$3, D1	; $273C
	lea (-$6642).w, A0	; $273E
	adda.w D1, A0	; $2742
	move.b D0, D1	; $2744
	andi.w #$7, D1	; $2746
	rts	; $274A
	bsr.b loc_2738	; $274C
	btst.b D1, (A0)	; $274E
	rts	; $2750
	bsr.b loc_2738	; $2752
	bset.b D1, (A0)	; $2754
	rts	; $2756
	moveq #$0, D1	; $2758
	move.b D0, D1	; $275A
	andi.w #$7, D0	; $275C
	lea (-$666E).w, A0	; $2760
	lsr.w #$3, D1	; $2764
	eori.w #$1, D1	; $2766
	rts	; $276A
loc_276C:
	move.w D0, D1	; $276C
	add.w D0, D0	; $276E
	add.w D1, D0	; $2770
	movea.l ($1CC14).l, A1	; $2772
	move.b ($1,A1,D0.w), D1	; $2778
	lsl.w #$8, D1	; $277C
	move.b ($2,A1,D0.w), D1	; $277E
	lea ($0,A1,D1.w), A0	; $2782
	move.l A0, (RAM_SceneDataPtr).w	; $2786
	moveq #$0, D1	; $278A
	move.b ($0,A1,D0.w), D1	; $278C
	lsl.w #$2, D1	; $2790
	movea.l ($1CC18).l, A1	; $2792
	adda.w D1, A1	; $2798
	rts	; $279A
	bsr.b loc_276C	; $279C
	moveq #$4F, D0	; $279E
	jsr $366.w	; $27A0
	bsr.w loc_27B0	; $27A4
	move.b #-$80, (RAM_PlayerState).w	; $27A8
	rts	; $27AE
loc_27B0:
	tst.w (RAM_word_FFFF965C).w	; $27B0
	beq.b *+$6	; $27B4
	bsr.w	$7F00				; $27B6
loc_27BA:
	moveq #$0, D0	; $27BA
	move.b (A1)+, D0	; $27BC
	move.w D0, (RAM_SceneOriginX).w	; $27BE
	move.b (A1)+, D0	; $27C2
	move.w D0, (RAM_SceneOriginY).w	; $27C4
	move.b (A1)+, D0	; $27C8
	move.w D0, (RAM_SceneWidth).w	; $27CA
	addq.w #$2, D0	; $27CE
	move.w D0, (RAM_ScreenTilesX).w	; $27D0
	move.b (A1)+, D0	; $27D4
	move.w D0, (RAM_SceneHeight).w	; $27D6
	add.w D0, D0	; $27DA
	addq.w #$3, D0	; $27DC
	move.w D0, (RAM_ScreenTilesY).w	; $27DE
	jmp $2110.w	; $27E2
	movea.w #$E0, A4	; $27E6
	moveq #$7, D0	; $27EA
	bra.b *+$4	; $27EC
	addq.w #$4, A4	; $27EE
loc_27F0:
	tst.b (-$4000,A4)	; $27F0
	dbpl D0, $27EE	; $27F4
	rts	; $27F8
	lea (-$68AC).w, A3	; $27FA
loc_27FE:
	move.w (A0)+, D0	; $27FE
	bpl.b *+$4	; $2800
	rts	; $2802
loc_2804:
	move.w (A0)+, D6	; $2804
	move.w (A0)+, D7	; $2806
	move.l A0, -(SP)	; $2808
	jsr $2670.w	; $280A
	movea.l (SP)+, A0	; $280E
	bra.b loc_27FE	; $2810
	link A6, #-$A	; $2812
	lea (-$68AC).w, A3	; $2816
	move.w D0, (-$2,A6)	; $281A
	move.w D1, (-$8,A6)	; $281E
	move.w D2, (-$A,A6)	; $2822
	move.w D6, (-$4,A6)	; $2826
loc_282A:
	move.w (-$4,A6), D6	; $282A
	move.w (-$2,A6), (-$6,A6)	; $282E
loc_2834:
	move.w (-$A,A6), D0	; $2834
	jsr $2670.w	; $2838
	addq.w #$1, D6	; $283C
	subq.w #$1, (-$6,A6)	; $283E
	bne.b loc_2834	; $2842
	addi.w #$40, D7	; $2844
	subq.w #$1, (-$8,A6)	; $2848
	bne.b loc_282A	; $284C
	unlk A6	; $284E
	rts	; $2850
	move.w (A0)+, D6	; $2852
	move.w (A0)+, D7	; $2854
	link A6, #-$8	; $2856
	lea (-$68AC).w, A3	; $285A
	moveq #$0, D0	; $285E
	move.b (A0)+, D0	; $2860
	move.w D0, (-$2,A6)	; $2862
	move.b (A0)+, D0	; $2866
	move.w D0, (-$8,A6)	; $2868
	move.w D6, (-$4,A6)	; $286C
loc_2870:
	move.w (-$4,A6), D6	; $2870
	move.w (-$2,A6), (-$6,A6)	; $2874
loc_287A:
	move.w (A0)+, D0	; $287A
	move.l A0, -(SP)	; $287C
	jsr $2670.w	; $287E
	movea.l (SP)+, A0	; $2882
	addq.w #$1, D6	; $2884
	subq.w #$1, (-$6,A6)	; $2886
	bne.b loc_287A	; $288A
	addi.w #$40, D7	; $288C
	subq.w #$1, (-$8,A6)	; $2890
	bne.b loc_2870	; $2894
	unlk A6	; $2896
	rts	; $2898
	moveq #$0, D0	; $289A
	lea (-$63CC).w, A0	; $289C
	moveq #$7, D1	; $28A0
	move.b D0, (A0)	; $28A2
	addq.w #$4, A0	; $28A4
	dbf D1, $28A2	; $28A6
	rts	; $28AA
	movea.w #$0, A4	; $28AC
loc_28B0:
	tst.b (-$63CC,A4)	; $28B0
	bpl.w loc_2968	; $28B4
	tst.b (-$63CB,A4)	; $28B8
	beq.w loc_2968	; $28BC
	subq.b #$1, (-$63CB,A4)	; $28C0
	bne.w loc_2968	; $28C4
	movea.l (-$62E4,A4), A0	; $28C8
loc_28CC:
	move.b (A0)+, D0	; $28CC
	bne.b *+$A	; $28CE
	move.b D0, (-$63CC,A4)	; $28D0
	bra.w loc_2968	; $28D4
loc_28D8:
	cmpi.b #-$3, D0	; $28D8
	bcs.b *+$1E	; $28DC
	cmpi.b #-$2, D0	; $28DE
	beq.b *+$C	; $28E2
	bcc.b *+$80	; $28E4
	ori.b #$1, (-$63CC,A4)	; $28E6
	bra.b loc_28CC	; $28EC
loc_28EE:
	move.b (A0)+, D0	; $28EE
	lsl.w #$8, D0	; $28F0
	move.b (A0), D0	; $28F2
	subq.w #$1, D0	; $28F4
	adda.w D0, A0	; $28F6
	bra.b loc_28CC	; $28F8
loc_28FA:
	cmpi.b #-$6, D0	; $28FA
	bcs.b *+$28	; $28FE
	bne.b *+$C	; $2900
	move.b (A0)+, (-$63CA,A4)	; $2902
	move.l A0, (-$6270,A4)	; $2906
	bra.b loc_28CC	; $290A
loc_290C:
	cmpi.b #-$4, D0	; $290C
	beq.b *+$E	; $2910
	subq.b #$1, (-$63CA,A4)	; $2912
	beq.b loc_28CC	; $2916
	movea.l (-$6270,A4), A0	; $2918
	bra.b loc_28CC	; $291C
loc_291E:
	bchg.b #$1, (-$63CC,A4)	; $291E
	bra.b loc_28CC	; $2924
loc_2926:
	move.b D0, (-$63CB,A4)	; $2926
	lea (-$68AC).w, A3	; $292A
	btst.b #$1, (-$63CC,A4)	; $292E
	beq.b *+$6	; $2934
	lea (-$682C).w, A3	; $2936
loc_293A:
	move.b (A0)+, D0	; $293A
	lsl.w #$8, D0	; $293C
	move.b (A0)+, D0	; $293E
	tst.w D0	; $2940
	bmi.b *+$22	; $2942
	move.w (-$6358,A4), D6	; $2944
	move.b (A0)+, D1	; $2948
	ext.w D1	; $294A
	add.w D1, D6	; $294C
	move.w (-$6356,A4), D7	; $294E
	move.b (A0)+, D1	; $2952
	ext.w D1	; $2954
	lsl.w #$6, D1	; $2956
	add.w D1, D7	; $2958
	move.l A0, -(SP)	; $295A
	bsr.w loc_2670	; $295C
	movea.l (SP)+, A0	; $2960
	bra.b loc_293A	; $2962
loc_2964:
	move.l A0, (-$62E4,A4)	; $2964
loc_2968:
	addq.w #$4, A4	; $2968
	cmpa.w #$20, A4	; $296A
	bcs.w loc_28B0	; $296E
	rts	; $2972
	movea.w #$0, A1	; $2974
	moveq #$7, D0	; $2978
	tst.b (-$63CC,A1)	; $297A
	bpl.b *+$A	; $297E
	addq.w #$4, A1	; $2980
	dbf D0, $297A	; $2982
	rts	; $2986
loc_2988:
	move.b #-$80, (-$63CC,A1)	; $2988
	move.b #$1, (-$63CB,A1)	; $298E
	move.w D6, (-$6358,A1)	; $2994
	move.w D7, (-$6356,A1)	; $2998
	move.l A0, (-$62E4,A1)	; $299C
	moveq #$0, D0	; $29A0
	rts	; $29A2
	lea (-$61FC).w, A0	; $29A4
	moveq #$3, D0	; $29A8
	clr.b (A0)	; $29AA
	addq.w #$4, A0	; $29AC
	dbf D0, $29AA	; $29AE
	rts	; $29B2
	movea.w #$0, A3	; $29B4
	movea.w (RAM_word_FFFF9EEE).w, A4	; $29B8
loc_29BC:
	tst.b (-$61FC,A3)	; $29BC
	bpl.w loc_2A60	; $29C0
	move.w (-$3800,A4), D0	; $29C4
	sub.w (-$61C8,A3), D0	; $29C8
	bcs.b *+$28	; $29CC
	cmp.w (-$6194,A3), D0	; $29CE
	bcc.b *+$22	; $29D2
	move.w (-$3700,A4), D0	; $29D4
	sub.w (-$61C6,A3), D0	; $29D8
	bcs.b *+$18	; $29DC
	cmp.w (-$6192,A3), D0	; $29DE
	bcc.b *+$12	; $29E2
	bset.b #$2, (-$61FC,A3)	; $29E4
	bne.b *+$10	; $29EA
	ori.b #$2, (-$61FC,A3)	; $29EC
	bra.b *+$8	; $29F2
loc_29F4:
	andi.b #-$5, (-$61FC,A3)	; $29F4
loc_29FA:
	btst.b #$1, (-$61FC,A3)	; $29FA
	beq.b *+$60	; $2A00
	moveq #$0, D0	; $2A02
	move.b (-$61FA,A3), D0	; $2A04
	move.w (-$6194,A3), D1	; $2A08
	lsr.w #$1, D1	; $2A0C
	add.w (-$61C8,A3), D1	; $2A0E
	move.w (-$6192,A3), D2	; $2A12
	add.w (-$61C6,A3), D2	; $2A16
	move.w A3, -(SP)	; $2A1A
	jsr $1090C.l	; $2A1C
	movea.w (SP)+, A3	; $2A22
	bmi.b *+$3C	; $2A24
	move.b (-$61FB,A3), D0	; $2A26
	btst.b #$0, (-$61FC,A3)	; $2A2A
	bne.b *+$C	; $2A30
	jsr $2758.w	; $2A32
	bset.b D0, ($0,A0,D1.w)	; $2A36
	bra.b *+$6	; $2A3A
loc_2A3C:
	jsr $2752.w	; $2A3C
loc_2A40:
	andi.b #-$3, (-$61FC,A3)	; $2A40
	movea.l (-$6160,A3), A0	; $2A46
	move.b (A0)+, D0	; $2A4A
	cmpi.b #-$1, D0	; $2A4C
	bne.b *+$8	; $2A50
	clr.b (-$61FC,A3)	; $2A52
	bra.b *+$A	; $2A56
loc_2A58:
	move.b D0, (-$61FA,A3)	; $2A58
	move.l A0, (-$6160,A3)	; $2A5C
loc_2A60:
	addq.w #$4, A3	; $2A60
	cmpa.w #$10, A3	; $2A62
	bcs.w loc_29BC	; $2A66
	rts	; $2A6A
	movea.w #$0, A1	; $2A6C
	moveq #$3, D0	; $2A70
	tst.b (-$61FC,A1)	; $2A72
	bpl.b *+$A	; $2A76
	addq.l #$4, A1	; $2A78
	dbf D0, $2A72	; $2A7A
	rts	; $2A7E
loc_2A80:
	move.b D3, (-$61FB,A1)	; $2A80
	lsr.w #$8, D3	; $2A84
	andi.b #$1, D3	; $2A86
	ori.b #-$80, D3	; $2A8A
	move.b D3, (-$61FC,A1)	; $2A8E
	move.w D4, (-$61C8,A1)	; $2A92
	move.w D5, (-$61C6,A1)	; $2A96
	move.w D6, (-$6194,A1)	; $2A9A
	move.w D7, (-$6192,A1)	; $2A9E
	move.b (A0)+, (-$61FA,A1)	; $2AA2
	move.l A0, (-$6160,A1)	; $2AA6
	moveq #$0, D0	; $2AAA
	rts	; $2AAC
	movea.w (RAM_word_FFFF9C14).w, A0	; $2AAE
	move.l (SP)+, (A0)+	; $2AB2
	move.w A0, (RAM_word_FFFF9C14).w	; $2AB4
	ext.w D0	; $2AB8
	add.w D0, D0	; $2ABA
			dc.w	$45fa,$007a	; dc.w
	adda.w ($0,A2,D0.w), A2	; $2AC0
loc_2AC4:
	move.l A2, (RAM_word_FFFF9ED6).w	; $2AC4
	move.w #$3C, (RAM_word_FFFF9ED4).w	; $2AC8
loc_2ACE:
	jsr $400.w	; $2ACE
	move.b (RAM_InputSelectedNew).w, D0	; $2AD2
	andi.b #$70, D0	; $2AD6
	bne.b *+$C	; $2ADA
	subq.w #$1, (RAM_word_FFFF9ED4).w	; $2ADC
	bne.b loc_2ACE	; $2AE0
	moveq #$1, D0	; $2AE2
	bra.b *+$18	; $2AE4
loc_2AE6:
	bsr.b *+$22	; $2AE6
	movea.l (RAM_word_FFFF9ED6).w, A2	; $2AE8
	cmp.b (A2)+, D0	; $2AEC
	bne.b *+$C	; $2AEE
	cmpi.b #-$1, (A2)	; $2AF0
	bne.b loc_2AC4	; $2AF4
	moveq #$0, D0	; $2AF6
	bra.b *+$4	; $2AF8
loc_2AFA:
	moveq #-$1, D0	; $2AFA
loc_2AFC:
	movea.w (RAM_word_FFFF9C14).w, A1	; $2AFC
	movea.l -(A1), A0	; $2B00
	move.w A1, (RAM_word_FFFF9C14).w	; $2B02
	jmp (A0)	; $2B06
loc_2B08:
	moveq #$0, D2	; $2B08
	move.b (RAM_InputSelectedNew).w, D1	; $2B0A
	btst.l #$6, D1	; $2B0E
	bne.b *+$16	; $2B12
	moveq #$1, D2	; $2B14
	btst.l #$4, D1	; $2B16
	bne.b *+$E	; $2B1A
	moveq #$2, D2	; $2B1C
	btst.l #$5, D1	; $2B1E
	bne.b *+$6	; $2B22
	moveq #-$1, D0	; $2B24
	rts	; $2B26
loc_2B28:
	move.b ($2B34,PC,D2.w), D0	; $2B28
	jsr $366.w	; $2B2C
	move.w D2, D0	; $2B30
	rts	; $2B32
	move.b (A1)+, D4	; $2B34
	move.b D0, D5	; $2B36
QuizTextData:				; loc_0002B38 - music quiz dialogue (control+text)
	dc.b	$00,$06,$00,$0E,$00,$16,$01,$00			; $2B38
	dc.b	$01,$00,$01,$02,$01,$FF,$00,$01,$02,$01,$02,$00,$01,$FF,$00,$02	; $2B40
	dc.b	$02,$00,$01,$00,$01,$FF,$07,$03,$06,$53,$68,$69,$6F,$6E,$20,$70	; $2B50
	dc.b	$6C,$61,$79,$73,$02,$74,$68,$65,$20,$0B,$0A,$28,$0C,$02,$2E,$0B	; $2B60
	dc.b	$19,$1B,$0B,$18,$96,$02,$4F,$68,$2C,$20,$74,$68,$61,$74,$20,$73	; $2B70
	dc.b	$6F,$75,$6E,$64,$73,$20,$6C,$6F,$76,$65,$6C,$79,$2E,$05,$00,$07	; $2B80
	dc.b	$03,$06,$53,$68,$69,$6F,$6E,$20,$70,$6C,$61,$79,$73,$02,$74,$68	; $2B90
	dc.b	$65,$20,$0B,$0A,$28,$0C,$02,$2E,$00,$07,$03,$06,$02,$59,$6F,$75	; $2BA0
	dc.b	$20,$70,$6C,$61,$79,$20,$62,$65,$61,$75,$74,$69,$66,$75,$6C,$6C	; $2BB0
	dc.b	$79,$2E,$05,$00,$07,$03,$06,$02,$42,$75,$74,$20,$49,$20,$63,$61	; $2BC0
	dc.b	$6E,$27,$74,$20,$70,$6C,$61,$79,$20,$76,$65,$72,$79,$02,$77,$65	; $2BD0
	dc.b	$6C,$6C,$2E,$05,$00,$07,$03,$06,$02,$54,$68,$65,$20,$6D,$65,$6C	; $2BE0
	dc.b	$6F,$64,$79,$20,$69,$73,$6E,$27,$74,$20,$71,$75,$69,$74,$65,$20	; $2BF0
	dc.b	$72,$69,$67,$68,$74,$2E,$05,$00				; $2C00
loc_2BB8:
loc_2BC2:
loc_2BCC:
loc_2BE8:
	move.w (RAM_word_FFFF9A8C).w, D6	; $2C08
	lsr.w #$4, D6	; $2C0C
	subq.w #$1, D6	; $2C0E
	move.w (RAM_word_FFFF9A8E).w, D7	; $2C10
	subi.w #$20, D7	; $2C14
	lsl.w #$2, D7	; $2C18
	moveq #$0, D0	; $2C1A
	move.b (RAM_word_FFFF9A8B).w, D0	; $2C1C
loc_2C20:
	lsl.w #$3, D0	; $2C20
	lea ($2C46,PC,D0.w), A4	; $2C22
	move.w (A4)+, D0	; $2C26
	jsr $266C.w	; $2C28
loc_2C2C:
	move.w (A4)+, D0	; $2C2C
	addq.w #$1, D6	; $2C2E
	jsr $2670.w	; $2C30
	move.w (A4)+, D0	; $2C34
	addi.w #$40, D7	; $2C36
	jsr $2670.w	; $2C3A
	subq.w #$1, D6	; $2C3E
	move.w (A4), D0	; $2C40
	jmp $2670.w	; $2C42
	dc.b	$02,$74,$02,$75,$02,$77,$02,$76			; $2C46  (attack bytes)
	move.b	(RAM_word_FFFF9A8A).w, D0		; $2C4E
	jsr $2752.w	; $2C52
loc_2C56:
	moveq #$57, D0	; $2C56
	jsr $366.w	; $2C58
	clr.b (RAM_word_FFFF9A8A).w	; $2C5C
	move.w #$2, (RAM_word_FFFF9A94).w	; $2C60
	move.w (RAM_word_FFFF9A8C).w, D6	; $2C66
	move.w (RAM_word_FFFF9A8E).w, D7	; $2C6A
	subi.w #$10, D7	; $2C6E
	jsr $27E6.w	; $2C72
	bmi.b *+$48	; $2C76
	move.w #$120A, (-$3D00,A4)	; $2C78
	bsr.b *+$42	; $2C7E
	move.w #$6, (-$2BFE,A4)	; $2C80
	move.b #$12, (-$3CFD,A4)	; $2C86
			dc.w	$41fa,$0052	; dc.w
	moveq #$3, D5	; $2C90
	jsr $27E6.w	; $2C92
	bmi.b *+$28	; $2C96
	move.w #$160A, (-$3D00,A4)	; $2C98
	bsr.b *+$22	; $2C9E
	move.w (A0)+, (-$3600,A4)	; $2CA0
	move.w (A0)+, (-$35FE,A4)	; $2CA4
	move.w #$A, (-$2BFE,A4)	; $2CA8
	move.w #$1E, (-$2600,A4)	; $2CAE
	move.b #$14, (-$3CFD,A4)	; $2CB4
	dbf D5, $2C92	; $2CBA
loc_2CBE:
	rts	; $2CBE
loc_2CC0:
	move.w D6, (-$3800,A4)	; $2CC0
	move.w D7, (-$3700,A4)	; $2CC4
	jsr $A36.w	; $2CC8
	move.b #-$80, (-$3FFE,A4)	; $2CCC
	moveq #$0, D0	; $2CD2
	jsr $7E8.w	; $2CD4
	move.b #-$40, (-$4000,A4)	; $2CD8
	rts	; $2CDE
StatDeltaTable:					; loc_0002CE0
	dc.w	$0400,$0400,$FC00,$0400,$FC00,$FC00,$0400,$FC00	; $2CE0
	jsr	$27E6.w				; $2CF4
	jsr	$A36.w				; $2CF8
	move.w D6, (-$3800,A4)	; $2CF8
	move.w D7, (-$3700,A4)	; $2CFC
	move.w #$1600, (-$3D00,A4)	; $2D00
	move.b #$1E, (-$3CFD,A4)	; $2D06
	andi.w #$FF, D5	; $2D0C
	move.w D5, (-$2800,A4)	; $2D10
	move.w #$10, (-$2BFE,A4)	; $2D14
	rts	; $2D1A
	tst.b (RAM_word_FFFF9BB6).w	; $2D1C
	bpl.b *+$8	; $2D20
	subq.b #$1, (RAM_word_FFFF9BB8).w	; $2D22
	beq.b *+$4	; $2D26
loc_2D28:
	rts	; $2D28
loc_2D2A:
	move.b (RAM_word_FFFF9BB9).w, D5	; $2D2A
	bpl.b *+$32	; $2D2E
	andi.w #$7F, D5	; $2D30
	move.w (RAM_word_FFFF9BBE).w, D6	; $2D34
	move.w (RAM_word_FFFF9BC0).w, D7	; $2D38
	jsr $2CF0.w	; $2D3C
	move.w D7, (-$20FE,A4)	; $2D40
	st (-$31FE,A4)	; $2D44
	st (-$3200,A4)	; $2D48
	move.w #-$600, (-$35FE,A4)	; $2D4C
	moveq #$0, D0	; $2D52
	jsr $7E8.w	; $2D54
	move.b #-$40, (-$4000,A4)	; $2D58
	bra.b *+$80	; $2D5E
loc_2D60:
	jsr $5D8.w	; $2D60
	moveq #$0, D2	; $2D64
	move.w D0, D2	; $2D66
	move.w (RAM_word_FFFF9BC4).w, D3	; $2D68
	divu.w D3, D2	; $2D6C
	swap D2	; $2D6E
	tst.w D0	; $2D70
	bpl.b *+$4	; $2D72
	neg.w D2	; $2D74
loc_2D76:
	jsr $5D8.w	; $2D76
	moveq #$0, D1	; $2D7A
	move.w D0, D1	; $2D7C
	move.w (RAM_word_FFFF9BC2).w, D3	; $2D7E
	divu.w D3, D1	; $2D82
	swap D1	; $2D84
	tst.w D0	; $2D86
	bpl.b *+$4	; $2D88
	neg.w D1	; $2D8A
loc_2D8C:
	movem.w D2/D1, -(SP)	; $2D8C
	add.w (RAM_word_FFFF9BBE).w, D1	; $2D90
	add.w (RAM_word_FFFF9BC0).w, D2	; $2D94
	moveq #$0, D0	; $2D98
	move.b (RAM_word_FFFF9BB9).w, D0	; $2D9A
	jsr $1090C.l	; $2D9E
	spl D0	; $2DA4
	movem.w (SP)+, D1/D2	; $2DA6
	tst.b D0	; $2DAA
	bne.b *+$8	; $2DAC
	move.b D0, (RAM_word_FFFF9BB6).w	; $2DAE
	rts	; $2DB2
loc_2DB4:
	ori.b #$1, (-$25FD,A0)	; $2DB4
	asl.w #$3, D1	; $2DBA
	move.w D1, (-$2100,A0)	; $2DBC
	btst.b #$0, (RAM_word_FFFF9BB6).w	; $2DC0
	beq.b *+$6	; $2DC6
	moveq #$0, D0	; $2DC8
	bra.b *+$10	; $2DCA
loc_2DCC:
	jsr $5D8.w	; $2DCC
	andi.w #$1FF, D0	; $2DD0
	addi.w #$400, D0	; $2DD4
	neg.w D0	; $2DD8
loc_2DDA:
	move.w D0, (-$20FE,A0)	; $2DDA
loc_2DDE:
	movea.l (RAM_word_FFFF9BBA).w, A0	; $2DDE
	move.b (A0)+, D0	; $2DE2
	move.b D0, (RAM_word_FFFF9BB9).w	; $2DE4
	addq.b #$1, D0	; $2DE8
	bne.b *+$8	; $2DEA
	move.b D0, (RAM_word_FFFF9BB6).w	; $2DEC
	rts	; $2DF0
loc_2DF2:
	move.l A0, (RAM_word_FFFF9BBA).w	; $2DF2
	move.b (RAM_word_FFFF9BB7).w, (RAM_word_FFFF9BB8).w	; $2DF6
	rts	; $2DFC
	move.b (A0)+, D4	; $2DFE
	ori.b #-$80, D4	; $2E00
	move.b D4, (RAM_word_FFFF9BB6).w	; $2E04
	move.b (A0)+, (RAM_word_FFFF9BB7).w	; $2E08
	move.b (A0)+, (RAM_word_FFFF9BB8).w	; $2E0C
	cmpi.b #$12, (RAM_word_FFFF9668).w	; $2E10
	bne.b *+$6	; $2E16
			dc.w	$41fa,$0010	; dc.w
loc_2E1C:
	move.l A0, (RAM_word_FFFF9BBA).w	; $2E1C
	lea (-$643A).w, A0	; $2E20
	movem.w D3/D2/D1/D0, -(A0)	; $2E24
	bra.b loc_2DDE	; $2E28
	dc.b	$0C,$16,$0C,$10,$0C,$16,$10,$0C			; $2E2A  (stat table)
	dc.b	$0C,$0C,$12,$0C,$FF,$00				; $2E32
	lea (-$68AC).w, A3	; $2E38
	jsr $AB8.w	; $2E3C
	jsr $3F08.w	; $2E40
	move.b (-$3100,A4), (-$2EFF,A4)	; $2E44
	move.w (-$30FE,A4), (-$2EFE,A4)	; $2E4A
	moveq #$0, D0	; $2E50
	move.b D0, (-$3100,A4)	; $2E52
	move.w D0, (-$30FE,A4)	; $2E56
	jsr $3AFC.w	; $2E5A
	jsr $3142.w	; $2E5E
	jsr $303A.w	; $2E62
	btst.b #$6, (-$3100,A4)	; $2E66
	beq.b *+$1E	; $2E6C
	move.w (-$3800,A4), D6	; $2E6E
	moveq #$0, D7	; $2E72
	move.b (-$34FD,A4), D7	; $2E74
	add.w (-$3700,A4), D7	; $2E78
	jsr $30D2.w	; $2E7C
	move.w D2, (-$30FE,A4)	; $2E80
	move.b D1, (-$30FF,A4)	; $2E84
	rts	; $2E88
loc_2E8A:
	jsr $AD6.w	; $2E8A
	jsr $3C22.w	; $2E8E
	jsr $3A54.w	; $2E92
	jsr $3584.w	; $2E96
	jmp $3098.w	; $2E9A
	lea (-$68AC).w, A3	; $2E9E
	jsr $AB8.w	; $2EA2
	jsr $3F08.w	; $2EA6
	move.b (-$3100,A4), (-$2EFF,A4)	; $2EAA
	move.w (-$30FE,A4), (-$2EFE,A4)	; $2EB0
	moveq #$0, D0	; $2EB6
	move.b D0, (-$3100,A4)	; $2EB8
	move.w D0, (-$30FE,A4)	; $2EBC
	jsr $3310.w	; $2EC0
	jsr $303A.w	; $2EC4
	jsr $AD6.w	; $2EC8
	jsr $39FA.w	; $2ECC
	jmp $3098.w	; $2ED0
	lea (-$68AC).w, A3	; $2ED4
	jsr $AB8.w	; $2ED8
	bra.b *+$E	; $2EDC
	lea (-$68AC).w, A3	; $2EDE
	jsr $AB8.w	; $2EE2
	jsr $3F08.w	; $2EE6
loc_2EEA:
	move.b (-$3100,A4), (-$2EFF,A4)	; $2EEA
	move.w (-$30FE,A4), (-$2EFE,A4)	; $2EF0
	moveq #$0, D0	; $2EF6
	move.b D0, (-$3100,A4)	; $2EF8
	move.w D0, (-$30FE,A4)	; $2EFC
	jsr $32FE.w	; $2F00
	jsr $303A.w	; $2F04
	btst.b #$6, (-$3100,A4)	; $2F08
	beq.b *+$1A	; $2F0E
	move.w (-$3800,A4), D6	; $2F10
	moveq #$0, D7	; $2F14
	move.b (-$34FD,A4), D7	; $2F16
	add.w (-$3700,A4), D7	; $2F1A
	jsr $30D2.w	; $2F1E
	move.w D2, (-$30FE,A4)	; $2F22
	rts	; $2F26
loc_2F28:
	jsr $AD6.w	; $2F28
	jsr $356E.w	; $2F2C
	jmp $3098.w	; $2F30
	lea (-$68AC).w, A3	; $2F34
	jsr $AB8.w	; $2F38
	jsr $3F08.w	; $2F3C
	move.b (-$3100,A4), (-$2EFF,A4)	; $2F40
	move.w (-$30FE,A4), (-$2EFE,A4)	; $2F46
	moveq #$0, D0	; $2F4C
	move.b D0, (-$3100,A4)	; $2F4E
	move.w D0, (-$30FE,A4)	; $2F52
	jsr $32FE.w	; $2F56
	jsr $303A.w	; $2F5A
	btst.b #$6, (-$3100,A4)	; $2F5E
	beq.b *+$1A	; $2F64
	move.w (-$3800,A4), D6	; $2F66
	moveq #$0, D7	; $2F6A
	move.b (-$34FD,A4), D7	; $2F6C
	add.w (-$3700,A4), D7	; $2F70
	jsr $30D2.w	; $2F74
	move.w D2, (-$30FE,A4)	; $2F78
	rts	; $2F7C
loc_2F7E:
	jsr $AD6.w	; $2F7E
	jsr $3AB0.w	; $2F82
	jsr $356E.w	; $2F86
	jmp $3098.w	; $2F8A
	lea (-$68AC).w, A3	; $2F8E
	jsr $AB8.w	; $2F92
	jsr $3F08.w	; $2F96
	move.b (-$3100,A4), (-$2EFF,A4)	; $2F9A
	move.w (-$30FE,A4), (-$2EFE,A4)	; $2FA0
	moveq #$0, D0	; $2FA6
	move.b D0, (-$3100,A4)	; $2FA8
	move.w D0, (-$30FE,A4)	; $2FAC
	jsr $3AFC.w	; $2FB0
	jsr $322E.w	; $2FB4
	jsr $303A.w	; $2FB8
	jsr $AD6.w	; $2FBC
	jsr $3C22.w	; $2FC0
	jsr $3A4C.w	; $2FC4
	jsr $3948.w	; $2FC8
	jmp $3098.w	; $2FCC
	lea (-$68AC).w, A3	; $2FD0
	jsr $AB8.w	; $2FD4
	move.b (-$3100,A4), (-$2EFF,A4)	; $2FD8
	move.w (-$30FE,A4), (-$2EFE,A4)	; $2FDE
	moveq #$0, D0	; $2FE4
	move.b D0, (-$3100,A4)	; $2FE6
	move.w D0, (-$30FE,A4)	; $2FEA
	jsr $3AFC.w	; $2FEE
	jsr $322E.w	; $2FF2
	jsr $303A.w	; $2FF6
	btst.b #$6, (-$3100,A4)	; $2FFA
