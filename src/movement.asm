; ======================================================================
; src/movement.asm
; Player movement/collision/angle code, stat tables
; Covers ROM $3000-$4092.
; Verified bit-exact against the original ROM.
; ======================================================================
	beq.b *+$1A	; $3000
	move.w (-$3800,A4), D6	; $3002
	moveq #$0, D7	; $3006
	move.b (-$34FD,A4), D7	; $3008
	add.w (-$3700,A4), D7	; $300C
	jsr $30D2.w	; $3010
	move.w D2, (-$30FE,A4)	; $3014
	rts	; $3018
MoveVertical:
	jsr $AD6.w	; $301A
	jsr $3C22.w	; $301E
	move.w (-$3700,A4), D0	; $3022
	sub.w (-$2DFE,A4), D0	; $3026
	bpl.b *+$8	; $302A
	jsr $3A54.w	; $302C
	bra.b *+$6	; $3030
MoveVertical_Alt:
	jsr $3584.w	; $3032
MoveVertical_End:
	bra.w MoveVertical_Apply	; $3036
	btst.b #$0, (-$3100,A4)	; $303A
	beq.b *+$56	; $3040
	tst.b (-$3100,A4)	; $3042
	bmi.b *+$A	; $3046
	move.w (-$3000,A4), D0	; $3048
	add.w D0, (-$3800,A4)	; $304C
MoveHorizontal_Apply:
	moveq #$0, D0	; $3050
	move.w D0, (-$37FE,A4)	; $3052
	btst.b #$2, (-$3100,A4)	; $3056
	bne.b *+$8	; $305C
	move.w #-$1, (-$37FE,A4)	; $305E
MoveHorizontal_Vel:
	move.w (-$3600,A4), D0	; $3064
	beq.b *+$2E	; $3068
	btst.b #$2, (-$3100,A4)	; $306A
	beq.b *+$8	; $3070
	tst.w D0	; $3072
	bpl.b *+$22	; $3074
	bra.b *+$6	; $3076
MoveHorizontal_VelNeg:
	tst.w D0	; $3078
	bmi.b *+$1C	; $307A
MoveHorizontal_VelTest:
	btst.b #$4, (-$2F00,A4)	; $307C
	bne.b *+$6	; $3082
	moveq #$0, D0	; $3084
	bra.b *+$C	; $3086
MoveHorizontal_VelFlip:
	btst.b #$2, (-$2F00,A4)	; $3088
	bne.b *+$8	; $308E
	neg.w D0	; $3090
MoveHorizontal_VelStore:
	move.w D0, (-$3600,A4)	; $3092
MoveHorizontal_Done:
	rts	; $3096
MoveVertical_Apply:
	move.b (-$3100,A4), D0	; $3098
	andi.b #-$5E, D0	; $309C
	subq.b #$2, D0	; $30A0
	bne.b *+$2A	; $30A2
	move.w (-$2FFE,A4), D0	; $30A4
	add.w D0, (-$3700,A4)	; $30A8
	moveq #$0, D0	; $30AC
	move.w D0, (-$36FE,A4)	; $30AE
	btst.b #$5, (-$2F00,A4)	; $30B2
	bne.b *+$8	; $30B8
	move.w D0, (-$35FE,A4)	; $30BA
	rts	; $30BE
MoveVertical_Bounce:
	btst.b #$3, (-$2F00,A4)	; $30C0
	bne.b *+$6	; $30C6
	neg.w (-$35FE,A4)	; $30C8
MoveVertical_Done:
	rts	; $30CC
ReadTileSetup:
	lea (-$68AC).w, A3	; $30CE
ReadTile:
	lsr.w #$4, D6	; $30D2
	andi.w #-$10, D7	; $30D4
	asl.w #$2, D7	; $30D8
ReadTileData:
	jsr $2542.w	; $30DA
	move.w D0, D1	; $30DE
	andi.w #$300, D1	; $30E0
	lsr.w #$6, D1	; $30E4
	movea.l ($10,A3,D1.w), A0	; $30E6
	move.w #$800, D1	; $30EA
	move.b D0, D1	; $30EE
	move.b ($0,A0,D1.w), D1	; $30F0
GetTileBehavior:
	move.b D1, D2	; $30F4
	andi.w #$F0, D2	; $30F6
	lsr.w #$3, D2	; $30FA
	movea.w #$3FC2, A0	; $30FC
	move.w ($0,A0,D2.w), D2	; $3100
	adda.w D2, A0	; $3104
	move.b D1, D2	; $3106
	andi.w #$F, D2	; $3108
	add.w D2, D2	; $310C
	move.w ($0,A0,D2.w), D2	; $310E
	cmpa.w (RAM_word_FFFF9EEE).w, A4	; $3112
	bne.b *+$2A	; $3116
	move.w D2, D0	; $3118
	andi.w #-$1000, D0	; $311A
	cmpi.w #$5000, D0	; $311E
	bne.b *+$E	; $3122
	btst.b #$5, (RAM_word_FFFF9EF1).w	; $3124
	bne.b *+$16	; $312A
	moveq #$8, D2	; $312C
	bra.b *+$12	; $312E
GetTileBehavior_Spike:
	cmpi.w #$6000, D0	; $3130
	bne.b *+$C	; $3134
	btst.b #$4, (RAM_word_FFFF9EF1).w	; $3136
	bne.b *+$4	; $313C
	moveq #$F, D2	; $313E
GetTileBehavior_Done:
	rts	; $3140
CheckCollision:
	btst.b #$1, (RAM_word_FFFF966B).w	; $3142
	beq.b *+$6	; $3148
	jsr $341C.w	; $314A
CheckCollisionRect:
	link A6, #-$A	; $314E
	moveq #$0, D0	; $3152
	move.b (-$34FE,A4), D0	; $3154
	move.w (-$3800,A4), D6	; $3158
	move.w D6, D1	; $315C
	add.w D0, D1	; $315E
	subq.w #$1, D1	; $3160
	move.w D1, (-$8,A6)	; $3162
	sub.w D0, D6	; $3166
	move.w D6, (-$6,A6)	; $3168
	moveq #$0, D7	; $316C
	move.b (-$34FD,A4), D7	; $316E
	move.w D7, D0	; $3172
	add.w (-$3700,A4), D0	; $3174
	subq.w #$1, D0	; $3178
	neg.w D7	; $317A
	add.w (-$3700,A4), D7	; $317C
	move.w D7, (-$A,A6)	; $3180
	moveq #-$10, D1	; $3184
	and.w D1, D0	; $3186
	and.w D1, D7	; $3188
	sub.w D7, D0	; $318A
	lsr.w #$4, D0	; $318C
	move.w D0, (-$4,A6)	; $318E
	move.w D0, (-$2,A6)	; $3192
	lsr.w #$4, D6	; $3196
	andi.w #-$10, D7	; $3198
	asl.w #$2, D7	; $319C
CheckCollisionRect_Row:
	jsr $30DA.w	; $319E
	move.w D2, D0	; $31A2
	andi.w #$102, D0	; $31A4
	subq.w #$2, D0	; $31A8
	bne.b *+$1E	; $31AA
	move.w (-$6,A6), D0	; $31AC
	neg.w D0	; $31B0
	andi.w #$F, D0	; $31B2
	move.w D0, (-$3000,A4)	; $31B6
	andi.b #$7F, (-$3100,A4)	; $31BA
	ori.b #$5, (-$3100,A4)	; $31C0
	bra.b *+$C	; $31C6
CheckCollisionRect_NextRow:
	addi.w #$40, D7	; $31C8
	subq.w #$1, (-$2,A6)	; $31CC
	bpl.b CheckCollisionRect_Row	; $31D0
CheckCollisionRect_Col:
	move.w (-$A,A6), D7	; $31D2
	move.w (-$8,A6), D6	; $31D6
	lsr.w #$4, D6	; $31DA
	andi.w #-$10, D7	; $31DC
	asl.w #$2, D7	; $31E0
CheckCollisionRect_ColLoop:
	jsr $30DA.w	; $31E2
	move.w D2, D0	; $31E6
	andi.w #$101, D0	; $31E8
	subq.w #$1, D0	; $31EC
	bne.b *+$32	; $31EE
	move.b (-$3100,A4), D0	; $31F0
	andi.b #-$7B, D0	; $31F4
	subq.b #$5, D0	; $31F8
	bne.b *+$A	; $31FA
	andi.b #-$2, (-$3100,A4)	; $31FC
	bra.b *+$28	; $3202
CheckCollisionRect_Block:
	moveq #$F, D0	; $3204
	and.w (-$8,A6), D0	; $3206
	addq.w #$1, D0	; $320A
	neg.w D0	; $320C
	move.w D0, (-$3000,A4)	; $320E
	andi.b #$7F, (-$3100,A4)	; $3212
	ori.b #$1, (-$3100,A4)	; $3218
	bra.b *+$C	; $321E
CheckCollisionRect_NextCol:
	addi.w #$40, D7	; $3220
	subq.w #$1, (-$4,A6)	; $3224
	bpl.b CheckCollisionRect_ColLoop	; $3228
CheckCollisionRect_Done:
	unlk A6	; $322A
	rts	; $322C
CheckHorizontalVelocity:
	tst.w (-$3600,A4)	; $322E
	bne.b *+$4	; $3232
	rts	; $3234
CheckCollisionRow_Scan:
	btst.b #$1, (RAM_word_FFFF966B).w	; $3236
	beq.b *+$6	; $323C
	jsr $341C.w	; $323E
CheckCollisionRow_Setup:
	link A6, #-$4	; $3242
	moveq #$0, D7	; $3246
	move.b (-$34FD,A4), D7	; $3248
	move.w D7, D0	; $324C
	add.w (-$3700,A4), D0	; $324E
	subq.w #$1, D0	; $3252
	neg.w D7	; $3254
	add.w (-$3700,A4), D7	; $3256
	moveq #-$10, D1	; $325A
	and.w D1, D0	; $325C
	and.w D1, D7	; $325E
	sub.w D7, D0	; $3260
	lsr.w #$4, D0	; $3262
	move.w D0, (-$4,A6)	; $3264
	moveq #$0, D6	; $3268
	move.b (-$34FE,A4), D6	; $326A
	tst.w (-$3600,A4)	; $326E
	bpl.b *+$42	; $3272
	neg.w D6	; $3274
	add.w (-$3800,A4), D6	; $3276
	move.w D6, (-$2,A6)	; $327A
	lsr.w #$4, D6	; $327E
	andi.w #-$10, D7	; $3280
	asl.w #$2, D7	; $3284
CheckCollisionRow_ScanLoop:
	jsr $30DA.w	; $3286
	andi.w #$102, D2	; $328A
	subq.w #$2, D2	; $328E
	beq.b *+$E	; $3290
	addi.w #$40, D7	; $3292
	subq.w #$1, (-$4,A6)	; $3296
	bpl.b CheckCollisionRow_ScanLoop	; $329A
	bra.b *+$5E	; $329C
CheckCollisionRow_Hit:
	move.w D2, (-$30FE,A4)	; $329E
	move.w (-$2,A6), D0	; $32A2
	neg.w D0	; $32A6
	andi.w #$F, D0	; $32A8
	ori.b #$5, (-$3100,A4)	; $32AC
	bra.b *+$3E	; $32B2
CheckCollisionRow_Scan2:
	add.w (-$3800,A4), D6	; $32B4
	move.w D6, (-$2,A6)	; $32B8
	lsr.w #$4, D6	; $32BC
	andi.w #-$10, D7	; $32BE
	asl.w #$2, D7	; $32C2
CheckCollisionRow_Scan2Loop:
	jsr $30DA.w	; $32C4
	andi.w #$101, D2	; $32C8
	subq.w #$1, D2	; $32CC
	beq.b *+$E	; $32CE
	addi.w #$40, D7	; $32D0
	subq.w #$1, (-$4,A6)	; $32D4
	bpl.b CheckCollisionRow_Scan2Loop	; $32D8
	bra.b *+$20	; $32DA
CheckCollisionRow_Block:
	move.w D2, (-$30FE,A4)	; $32DC
	moveq #$F, D0	; $32E0
	and.w (-$2,A6), D0	; $32E2
	addq.w #$1, D0	; $32E6
	neg.w D0	; $32E8
	ori.b #$1, (-$3100,A4)	; $32EA
CheckCollisionRow_Store:
	andi.b #$7F, (-$3100,A4)	; $32F0
	move.w D0, (-$3000,A4)	; $32F6
CheckCollisionRow_Done:
	unlk A6	; $32FA
	rts	; $32FC
CheckCollisionCol_Entry:
	btst.b #$1, (RAM_word_FFFF966B).w	; $32FE
	beq.b *+$6	; $3304
	jsr $341C.w	; $3306
CheckCollisionCol_Start:
	move.w #$100, D0	; $330A
	bra.b *+$4	; $330E
CheckCollisionCol_Entry2:
	moveq #$0, D0	; $3310
CheckCollisionCol_Check:
	tst.w (-$3600,A4)	; $3312
	bne.b *+$4	; $3316
	rts	; $3318
CheckCollisionCol_Setup:
	link A6, #-$6	; $331A
	move.w D0, (-$6,A6)	; $331E
	clr.b (-$4,A6)	; $3322
	tst.w (-$3600,A4)	; $3326
	bpl.b *+$8	; $332A
	move.b #$1, (-$4,A6)	; $332C
CheckCollisionCol_Scan:
	moveq #$0, D7	; $3332
	move.b (-$34FD,A4), D7	; $3334
	move.w D7, D0	; $3338
	add.w (-$3700,A4), D0	; $333A
	subq.w #$1, D0	; $333E
	neg.w D7	; $3340
	add.w (-$3700,A4), D7	; $3342
	moveq #-$10, D1	; $3346
	and.w D1, D0	; $3348
	and.w D1, D7	; $334A
	sub.w D7, D0	; $334C
	lsr.w #$4, D0	; $334E
	move.w D0, (-$2,A6)	; $3350
	move.w (-$3800,A4), D6	; $3354
	lsr.w #$4, D6	; $3358
	andi.w #-$10, D7	; $335A
	asl.w #$2, D7	; $335E
CheckCollisionCol_ScanLoop:
	jsr $26F0.w	; $3360
	jsr $30F4.w	; $3364
	move.w D2, D0	; $3368
	move.w (-$6,A6), D1	; $336A
	and.w D1, D0	; $336E
	bne.b *+$A	; $3370
	move.b (-$4,A6), D1	; $3372
	btst.l D1, D2	; $3376
	bne.b *+$E	; $3378
CheckCollisionCol_Next:
	addi.w #$40, D7	; $337A
	subq.w #$1, (-$2,A6)	; $337E
	bpl.b CheckCollisionCol_ScanLoop	; $3382
	bra.b *+$30	; $3384
CheckCollisionCol_Hit:
	andi.b #$7F, (-$3100,A4)	; $3386
	move.w (-$3800,A4), D0	; $338C
	tst.b D1	; $3390
	bne.b *+$12	; $3392
	andi.w #$F, D0	; $3394
	addq.w #$1, D0	; $3398
	neg.w D0	; $339A
	ori.b #$1, (-$3100,A4)	; $339C
	bra.b *+$E	; $33A2
CheckCollisionCol_Hit2:
	neg.w D0	; $33A4
	andi.w #$F, D0	; $33A6
	ori.b #$5, (-$3100,A4)	; $33AA
CheckCollisionCol_Store:
	move.w D0, (-$3000,A4)	; $33B0
CheckCollisionCol_Done:
	unlk A6	; $33B4
	rts	; $33B6
	tst.w (-$3600,A4)	; $33B8
	bne.b *+$4	; $33BC
	rts	; $33BE
CheckCollisionFoot:
	link A6, #-$2	; $33C0
	clr.b (-$2,A6)	; $33C4
	tst.w (-$3600,A4)	; $33C8
	bpl.b *+$8	; $33CC
	move.b #$1, (-$2,A6)	; $33CE
CheckCollisionFoot_Scan:
	move.w (-$3800,A4), D6	; $33D4
	moveq #$0, D7	; $33D8
	move.b (-$34FD,A4), D7	; $33DA
	subq.b #$1, D7	; $33DE
	add.w (-$3700,A4), D7	; $33E0
	jsr $30D2.w	; $33E4
	move.b (-$2,A6), D1	; $33E8
	btst.l D1, D2	; $33EC
	beq.b *+$2A	; $33EE
	move.w (-$3800,A4), D0	; $33F0
	tst.b D1	; $33F4
	bne.b *+$12	; $33F6
	andi.w #$F, D0	; $33F8
	addq.w #$1, D0	; $33FC
	neg.w D0	; $33FE
	ori.b #$1, (-$3100,A4)	; $3400
	bra.b *+$E	; $3406
CheckCollisionFoot_Hit:
	neg.w D0	; $3408
	andi.w #$F, D0	; $340A
	ori.b #$5, (-$3100,A4)	; $340E
CheckCollisionFoot_Store:
	move.w D0, (-$3000,A4)	; $3414
CheckCollisionFoot_Done:
	unlk A6	; $3418
	rts	; $341A
GetXDelta:
	move.w (-$3800,A4), D1	; $341C
	move.w (-$2E00,A4), D0	; $3420
	sub.w D1, D0	; $3424
	bne.b *+$4	; $3426
	rts	; $3428
SlideCollision:
	link A6, #-$8	; $342A
	move.w #$2, (-$4,A6)	; $342E
	tst.w D0	; $3434
	bpl.b *+$8	; $3436
	eori.w #$3, (-$4,A6)	; $3438
SlideCollision_Setup:
	move.w D0, (-$2,A6)	; $343E
	moveq #-$10, D2	; $3442
	move.w (-$2E00,A4), D0	; $3444
	and.w D2, D0	; $3448
	and.w D2, D1	; $344A
	sub.w D0, D1	; $344C
	move.w D1, (-$6,A6)	; $344E
	btst.b #$1, (-$2EFF,A4)	; $3452
	bne.w SlideCollision_Done	; $3458
	moveq #$0, D0	; $345C
	move.b (-$34FD,A4), D0	; $345E
	move.w (-$3700,A4), D7	; $3462
	subq.w #$1, D0	; $3466
	add.w D0, D7	; $3468
	move.w D7, (-$8,A6)	; $346A
	tst.w D1	; $346E
	beq.b *+$56	; $3470
	move.w (-$2E00,A4), D6	; $3472
	jsr $30D2.w	; $3476
	move.w D2, D0	; $347A
	move.w #$108, D3	; $347C
	or.w (-$4,A6), D3	; $3480
	and.w D3, D0	; $3484
	eor.w D3, D0	; $3486
	bne.b *+$3E	; $3488
	jsr $3860.w	; $348A
	bmi.w SlideCollision_XScan	; $348E
	move.w (-$2E00,A4), D0	; $3492
	move.w (-$8,A6), D1	; $3496
	movea.w #$40DC, A0	; $349A
	bsr.w ReadCollisionOffset	; $349E
	tst.b D4	; $34A2
	bmi.b *+$22	; $34A4
	add.w (-$2,A6), D0	; $34A6
	move.w (-$2,A6), D4	; $34AA
	bpl.b *+$10	; $34AE
	tst.w D0	; $34B0
	beq.w SlideCollision_Apply	; $34B2
	bpl.b *+$10	; $34B6
	cmp.w D4, D0	; $34B8
	bcc.b *+$5E	; $34BA
	bra.b *+$A	; $34BC
SlideCollision_XNeg:
	tst.w D0	; $34BE
	bmi.b *+$6	; $34C0
	sub.w D0, D4	; $34C2
	bpl.b *+$54	; $34C4
SlideCollision_XScan:
	move.w (-$8,A6), D7	; $34C6
	move.w (-$3800,A4), D6	; $34CA
	jsr $30D2.w	; $34CE
	move.w D2, D0	; $34D2
	move.w #$108, D3	; $34D4
	or.w (-$4,A6), D3	; $34D8
	and.w D3, D0	; $34DC
	eor.w D3, D0	; $34DE
	bne.b *+$54	; $34E0
	jsr $3860.w	; $34E2
	bmi.w SlideCollision_Done	; $34E6
	move.w (-$3800,A4), D0	; $34EA
	move.w (-$8,A6), D1	; $34EE
	movea.w #$40DC, A0	; $34F2
	bsr.w ReadCollisionOffset	; $34F6
	tst.b D4	; $34FA
	bne.b *+$38	; $34FC
	move.w (-$2,A6), D4	; $34FE
	bpl.b *+$E	; $3502
	tst.w D0	; $3504
	beq.b *+$12	; $3506
	bpl.b *+$2C	; $3508
	cmp.w D4, D0	; $350A
	bcc.b *+$C	; $350C
	bra.b *+$26	; $350E
SlideCollision_X2:
	tst.w D0	; $3510
	bmi.b *+$22	; $3512
	sub.w D0, D4	; $3514
	bmi.b *+$1E	; $3516
SlideCollision_Apply:
	add.w D0, (-$3800,A4)	; $3518
	andi.b #$77, (-$3100,A4)	; $351C
	ori.b #$42, (-$3100,A4)	; $3522
	move.w D2, (-$30FE,A4)	; $3528
	clr.w (-$36FE,A4)	; $352C
	clr.w (-$35FE,A4)	; $3530
SlideCollision_Done:
	unlk A6	; $3534
	rts	; $3536
ReadCollisionOffset:
	move.w D1, -(SP)	; $3538
	move.w D2, D3	; $353A
	andi.w #$F0, D3	; $353C
	adda.w D3, A0	; $3540
	andi.w #$F, D1	; $3542
	move.b ($0,A0,D1.w), D1	; $3546
	cmpi.b #-$80, D1	; $354A
	seq D4	; $354E
	ext.w D1	; $3550
	btst.l #$0, D2	; $3552
	bne.b *+$C	; $3556
	andi.w #$F, D0	; $3558
	neg.w D0	; $355C
	add.w D1, D0	; $355E
	bra.b *+$A	; $3560
ReadCollisionOffset2:
	andi.w #$F, D0	; $3562
	sub.w D0, D1	; $3566
	move.w D1, D0	; $3568
ReadCollisionOffset_Done:
	move.w (SP)+, D1	; $356A
	rts	; $356C
SlideCheck_Collision:
	btst.b #$1, (RAM_word_FFFF966B).w	; $356E
	bne.b *+$6	; $3574
	jmp $39FA.w	; $3576
SlideCheck_Entry:
	move.l #-$1, (RAM_word_FFFF9EE8).w	; $357A
	bra.b *+$A	; $3582
CollideAndSlide_Init:
	move.l #$38E4, (RAM_word_FFFF9EE8).w	; $3584
CollideAndSlide:
	link A6, #-$14	; $358C
	move.w (-$3700,A4), D7	; $3590
	moveq #$0, D0	; $3594
	move.b (-$34FD,A4), D0	; $3596
	add.w D0, D7	; $359A
	move.w D7, (-$4,A6)	; $359C
	move.w D7, (-$6,A6)	; $35A0
	add.w (-$2DFE,A4), D0	; $35A4
	move.w D0, (-$2,A6)	; $35A8
	move.w D7, D1	; $35AC
	sub.w D0, D1	; $35AE
	move.w D1, (-$A,A6)	; $35B0
	btst.b #$1, (RAM_word_FFFF966B).w	; $35B4
	beq.w CollideAndSlide_Jump	; $35BA
	move.b (-$2EFF,A4), D0	; $35BE
	andi.b #-$76, D0	; $35C2
	subq.b #$2, D0	; $35C6
	bne.w CollideAndSlide_Right	; $35C8
	move.w (-$3800,A4), D6	; $35CC
	move.w (-$4,A6), D7	; $35D0
	lsr.w #$4, D6	; $35D4
	andi.w #-$10, D7	; $35D6
	asl.w #$2, D7	; $35DA
	move.w D7, (-$12,A6)	; $35DC
	movea.w #$0, A1	; $35E0
	move.b #$2, (-$10,A6)	; $35E4
	moveq #-$10, D2	; $35EA
	move.w (-$3800,A4), D0	; $35EC
	move.w (-$2E00,A4), D1	; $35F0
	and.w D2, D0	; $35F4
	and.w D2, D1	; $35F6
	sub.w D1, D0	; $35F8
	move.w D0, (-$14,A6)	; $35FA
	beq.b *+$4A	; $35FE
	bmi.b *+$4	; $3600
	addq.w #$1, A1	; $3602
CollideAndSlide_Scan:
	move.w (-$2EFE,A4), D0	; $3604
	bsr.w ReadTileAttr	; $3608
	moveq #$4, D1	; $360C
	move.b D0, D2	; $360E
	add.b D1, D2	; $3610
	andi.b #$7, D2	; $3612
	move.b D2, (-$E,A6)	; $3616
	sub.b D0, D1	; $361A
	andi.b #$7, D1	; $361C
	move.b D1, (-$C,A6)	; $3620
			dc.w	$41fa,$014c	; dc.w
	andi.w #$7, D0	; $3628
	move.b ($0,A0,D0.w), (-$10,A6)	; $362C
	move.w A1, D0	; $3632
	eori.w #$1, D0	; $3634
	movea.w D0, A1	; $3638
	cmpa.w (RAM_word_FFFF9EEE).w, A4	; $363A
	bne.b *+$A	; $363E
	btst.b #$0, (RAM_word_FFFF9F0B).w	; $3640
	bne.b *+$28	; $3646
CollideAndSlide_Check:
	btst.b #$0, (-$10,A6)	; $3648
	beq.b *+$4	; $364E
	bsr.b *+$44	; $3650
CollideAndSlide_Check2:
	btst.b #$1, (-$10,A6)	; $3652
	beq.b *+$4	; $3658
	bsr.b *+$7A	; $365A
CollideAndSlide_Check3:
	btst.b #$2, (-$10,A6)	; $365C
	beq.w CollideAndSlide_Jump	; $3662
	bsr.w CollideAndSlide_Left	; $3666
	bra.w CollideAndSlide_Jump	; $366A
CollideAndSlide_Alt:
	btst.b #$2, (-$10,A6)	; $366E
	beq.b *+$6	; $3674
	bsr.w CollideAndSlide_Left	; $3676
CollideAndSlide_Alt2:
	btst.b #$1, (-$10,A6)	; $367A
	beq.b *+$4	; $3680
	bsr.b *+$52	; $3682
CollideAndSlide_Alt3:
	btst.b #$0, (-$10,A6)	; $3684
	beq.w CollideAndSlide_Jump	; $368A
	bsr.b *+$6	; $368E
	bra.w CollideAndSlide_Jump	; $3690
CollideAndSlide_Up:
	move.w (-$12,A6), D7	; $3694
	addi.w #$40, D7	; $3698
	jsr $30DA.w	; $369C
	btst.l #$3, D2	; $36A0
	beq.w CollideAndSlide_Done	; $36A4
	move.w D2, D0	; $36A8
	bsr.w CompareTileAttrB	; $36AA
	bne.w CollideAndSlide_Done	; $36AE
	btst.l #$8, D2	; $36B2
	bne.b *+$12	; $36B6
	moveq #$F, D0	; $36B8
	and.w (-$6,A6), D0	; $36BA
	neg.w D0	; $36BE
	addi.w #$10, D0	; $36C0
	bra.w CollideAndSlide_Apply	; $36C4
CollideAndSlide_UpHit:
	bsr.w ReadTileSign	; $36C8
	addi.w #$10, D0	; $36CC
	bra.w CollideAndSlide_Apply	; $36D0
CollideAndSlide_Down:
	move.w (-$12,A6), D7	; $36D4
	jsr $30DA.w	; $36D8
	btst.l #$3, D2	; $36DC
	beq.b *+$6E	; $36E0
	move.w D2, D0	; $36E2
	tst.w (-$14,A6)	; $36E4
	beq.b *+$A	; $36E8
	bsr.w CompareTileAttrA	; $36EA
	bne.w CollideAndSlide_Done	; $36EE
CollideAndSlide_Down2:
	btst.l #$8, D2	; $36F2
	bne.b *+$E	; $36F6
	moveq #$F, D0	; $36F8
	and.w (-$6,A6), D0	; $36FA
	neg.w D0	; $36FE
	bra.w CollideAndSlide_Apply	; $3700
CollideAndSlide_DownHit:
	bsr.w ReadTileSign	; $3704
	bra.b *+$2C	; $3708
CollideAndSlide_Left:
	move.w (-$12,A6), D7	; $370A
	subi.w #$40, D7	; $370E
	jsr $30DA.w	; $3712
	move.w D2, D0	; $3716
	andi.w #$108, D0	; $3718
	eori.w #$108, D0	; $371C
	bne.w CollideAndSlide_Done	; $3720
	move.w D2, D0	; $3724
	bsr.w CompareTileAttrB	; $3726
	bne.b *+$24	; $372A
	bsr.w ReadTileSign	; $372C
	subi.w #$10, D0	; $3730
CollideAndSlide_Apply:
	andi.b #$77, (-$3100,A4)	; $3734
	ori.b #$2, (-$3100,A4)	; $373A
	move.b D1, (-$30FF,A4)	; $3740
	move.w D0, (-$2FFE,A4)	; $3744
	move.w D2, (-$30FE,A4)	; $3748
	unlk A6	; $374C
CollideAndSlide_Done:
	rts	; $374E
ReadTileAttr:
	andi.w #$F0, D0	; $3750
	lsr.w #$3, D0	; $3754
	addi.l #$418C, D0	; $3756
		dc.w	$1031,$0800	; move.b
	rts	; $3760
CompareTileAttrA:
	bsr.b ReadTileAttr	; $3762
	cmp.b (-$C,A6), D0	; $3764
	rts	; $3768
CompareTileAttrB:
	bsr.b ReadTileAttr	; $376A
	cmp.b (-$E,A6), D0	; $376C
	rts	; $3770
		dc.w	$0203,$0103	; andi.b
		dc.w	$0206,$0406	; andi.b
CollideAndSlide_Right:
	move.w (-$2,A6), D0	; $377A
	move.w (-$4,A6), D1	; $377E
	moveq #-$10, D2	; $3782
	and.w D2, D0	; $3784
	and.w D2, D1	; $3786
	sub.w D1, D0	; $3788
	bmi.b *+$4E	; $378A
CollideAndSlide_RightScan:
	move.w (-$3800,A4), D6	; $378C
	move.w (-$4,A6), D7	; $3790
	move.w D7, (-$6,A6)	; $3794
	jsr $30D2.w	; $3798
	btst.l #$3, D2	; $379C
	beq.w CollideAndSlide_Jump	; $37A0
	btst.l #$8, D2	; $37A4
	bne.b *+$16	; $37A8
	moveq #$F, D0	; $37AA
	and.w (-$6,A6), D0	; $37AC
	neg.w D0	; $37B0
	move.w D0, D3	; $37B2
	add.w (-$A,A6), D3	; $37B4
	bmi.w CollideAndSlide_Jump	; $37B8
	bra.b *+$64	; $37BC
CollideAndSlide_RightHit:
	bsr.w TileBehaviorDispatch	; $37BE
	bmi.w CollideAndSlide_Unlink	; $37C2
	bsr.w ReadTileSign	; $37C6
	move.w D0, D3	; $37CA
	beq.b *+$4	; $37CC
	bpl.b *+$6A	; $37CE
CollideAndSlide_Right2:
	add.w (-$A,A6), D3	; $37D0
	bmi.b *+$64	; $37D4
	bra.b *+$4A	; $37D6
CollideAndSlide_Right3:
	move.w (-$3800,A4), D6	; $37D8
	move.w (-$2,A6), D7	; $37DC
	move.w D7, (-$6,A6)	; $37E0
	jsr $30D2.w	; $37E4
	btst.l #$3, D2	; $37E8
	beq.w CollideAndSlide_RightScan	; $37EC
	btst.l #$8, D2	; $37F0
	bne.b *+$C	; $37F4
	moveq #$F, D0	; $37F6
	and.w (-$6,A6), D0	; $37F8
	neg.w D0	; $37FC
	bra.b *+$E	; $37FE
CollideAndSlide_Right4:
	bsr.w TileBehaviorDispatch	; $3800
	bmi.w CollideAndSlide_RightScan	; $3804
	bsr.w ReadTileSign	; $3808
CollideAndSlide_Right5:
	sub.w (-$A,A6), D0	; $380C
	move.w D0, D3	; $3810
	beq.b *+$6	; $3812
	bpl.w CollideAndSlide_RightScan	; $3814
CollideAndSlide_Right6:
	add.w (-$A,A6), D3	; $3818
	bmi.w CollideAndSlide_RightScan	; $381C
CollideAndSlide_Store:
	move.w D0, (-$2FFE,A4)	; $3820
	move.b D1, (-$30FF,A4)	; $3824
	move.w D2, (-$30FE,A4)	; $3828
	andi.b #$77, (-$3100,A4)	; $382C
	ori.b #$2, (-$3100,A4)	; $3832
CollideAndSlide_Unlink:
	unlk A6	; $3838
	rts	; $383A
ReadTileSign:
	move.w D2, D0	; $383C
	andi.w #$F0, D0	; $383E
	movea.w #$403C, A0	; $3842
	adda.w D0, A0	; $3846
	moveq #$F, D0	; $3848
	and.w (-$3800,A4), D0	; $384A
	move.b ($0,A0,D0.w), D0	; $384E
	ext.w D0	; $3852
	moveq #$F, D3	; $3854
	and.w (-$6,A6), D3	; $3856
	neg.w D3	; $385A
	add.w D3, D0	; $385C
	rts	; $385E
TileBehaviorDispatch:
	move.w D2, D0	; $3860
	andi.w #$F0, D0	; $3862
	lsr.w #$3, D0	; $3866
			dc.w	$41fa,$0008	; dc.w
	adda.w	($0,A0,D0.w), A0		; $386C
	jmp	(A0)				; $3870
StatGateTable:					; loc_0003872
	dc.w	$0016,$001A,$001A,$0026,$0026,$0032,$003C,$0046	; $3872
	dc.w	$0046,$0054,$0054			; $3882
TrapSpin_3888:
	nop					; $3888
	bra.b	TrapSpin_3888				; $388A
	move.w (-$35FE,A4), D0	; $388C
	add.w D0, D0	; $3890
	add.w (-$3600,A4), D0	; $3892
	rts	; $3896
	move.w (-$35FE,A4), D0	; $3898
	add.w D0, D0	; $389C
	sub.w (-$3600,A4), D0	; $389E
	rts	; $38A2
	move.w (-$35FE,A4), D0	; $38A4
	add.w (-$3600,A4), D0	; $38A8
	rts	; $38AC
	move.w (-$35FE,A4), D0	; $38AE
	sub.w (-$3600,A4), D0	; $38B2
	rts	; $38B6
	move.w (-$3600,A4), D0	; $38B8
	add.w D0, D0	; $38BC
	move.w (-$35FE,A4), D3	; $38BE
	add.w D0, D3	; $38C2
	rts	; $38C4
	move.w (-$3600,A4), D0	; $38C6
	add.w D0, D0	; $38CA
	move.w (-$35FE,A4), D3	; $38CC
	sub.w D0, D3	; $38D0
	rts	; $38D2
CollideAndSlide_Jump:
	tst.l (RAM_word_FFFF9EE8).w	; $38D4
	bmi.b *+$8	; $38D8
	movea.l (RAM_word_FFFF9EE8).w, A0	; $38DA
	jmp (A0)	; $38DE
CollideAndSlide_End:
	unlk A6	; $38E0
	rts	; $38E2
	jsr $39DA.w	; $38E4
	move.w D0, (-$8,A6)	; $38E8
	move.w (-$4,A6), D7	; $38EC
	lsr.w #$4, D6	; $38F0
	andi.w #-$10, D7	; $38F2
	asl.w #$2, D7	; $38F6
SlideScan:
	jsr $30DA.w	; $38F8
	move.w D2, D0	; $38FC
	andi.w #$108, D0	; $38FE
	subq.w #$8, D0	; $3902
	bne.b *+$1E	; $3904
	moveq #$F, D0	; $3906
	and.w (-$4,A6), D0	; $3908
	neg.w D0	; $390C
	move.b (-$2EFF,A4), D3	; $390E
	andi.b #-$76, D3	; $3912
	subq.b #$2, D3	; $3916
	beq.b *+$14	; $3918
	move.w D0, D3	; $391A
	add.w (-$A,A6), D3	; $391C
	bpl.b *+$C	; $3920
SlideScan_Next:
	addq.w #$1, D6	; $3922
	subq.w #$1, (-$8,A6)	; $3924
	bpl.b SlideScan	; $3928
	bra.b *+$1A	; $392A
SlideScan_Hit:
	move.w D0, (-$2FFE,A4)	; $392C
	move.b D1, (-$30FF,A4)	; $3930
	move.w D2, (-$30FE,A4)	; $3934
	andi.b #$77, (-$3100,A4)	; $3938
	ori.b #$2, (-$3100,A4)	; $393E
SlideScan_Done:
	unlk A6	; $3944
	rts	; $3946
SlideCheck_Status:
	move.b (-$3100,A4), D0	; $3948
	andi.b #-$76, D0	; $394C
	subi.b #-$7E, D0	; $3950
	beq.b *+$A	; $3954
	tst.w (-$35FE,A4)	; $3956
	bmi.w SlideUp	; $395A
SlideDown:
	link A6, #-$6	; $395E
	jsr $39DA.w	; $3962
	move.w D0, (-$6,A6)	; $3966
	move.w (-$3700,A4), D7	; $396A
	move.w D7, D0	; $396E
	sub.w (-$2DFE,A4), D0	; $3970
	move.w D0, (-$4,A6)	; $3974
	moveq #$0, D0	; $3978
	move.b (-$34FD,A4), D0	; $397A
	add.w D0, D7	; $397E
	move.w D7, (-$2,A6)	; $3980
	move.w D7, D0	; $3984
	lsr.w #$4, D6	; $3986
	andi.w #-$10, D7	; $3988
	asl.w #$2, D7	; $398C
SlideDown_Scan:
	jsr $30DA.w	; $398E
	btst.l #$3, D2	; $3992
	beq.b *+$1E	; $3996
	moveq #$F, D0	; $3998
	and.w (-$2,A6), D0	; $399A
	neg.w D0	; $399E
	move.b (-$2EFF,A4), D3	; $39A0
	andi.b #-$76, D3	; $39A4
	subq.b #$2, D3	; $39A8
	beq.b *+$14	; $39AA
	move.w D0, D3	; $39AC
	add.w (-$4,A6), D3	; $39AE
	bpl.b *+$C	; $39B2
SlideDown_Next:
	addq.w #$1, D6	; $39B4
	subq.w #$1, (-$6,A6)	; $39B6
	bpl.b SlideDown_Scan	; $39BA
	bra.b *+$1A	; $39BC
SlideDown_Hit:
	move.w D0, (-$2FFE,A4)	; $39BE
	move.b D1, (-$30FF,A4)	; $39C2
	move.w D2, (-$30FE,A4)	; $39C6
	andi.b #$77, (-$3100,A4)	; $39CA
	ori.b #$2, (-$3100,A4)	; $39D0
SlideDown_Done:
	unlk A6	; $39D6
	rts	; $39D8
GetXSpan:
	moveq #$0, D6	; $39DA
	move.b (-$34FE,A4), D6	; $39DC
	move.w D6, D0	; $39E0
	add.w (-$3800,A4), D0	; $39E2
	subq.w #$1, D0	; $39E6
	neg.w D6	; $39E8
	add.w (-$3800,A4), D6	; $39EA
	moveq #-$10, D1	; $39EE
	and.w D1, D0	; $39F0
	and.w D1, D6	; $39F2
	sub.w D6, D0	; $39F4
	lsr.w #$4, D0	; $39F6
	rts	; $39F8
SlideCheck_Entry2:
	tst.w (-$35FE,A4)	; $39FA
	bmi.b *+$4C	; $39FE
	move.w (-$3800,A4), D6	; $3A00
	moveq #$0, D7	; $3A04
	move.b (-$34FD,A4), D7	; $3A06
	add.w (-$3700,A4), D7	; $3A0A
	jsr $30D2.w	; $3A0E
	btst.l #$3, D2	; $3A12
	beq.b *+$34	; $3A16
	moveq #$0, D0	; $3A18
	move.b (-$34FD,A4), D0	; $3A1A
	move.w (-$3700,A4), D3	; $3A1E
	add.w D3, D0	; $3A22
	sub.w (-$2DFE,A4), D3	; $3A24
	andi.w #$F, D0	; $3A28
	neg.w D0	; $3A2C
	add.w D0, D3	; $3A2E
	bmi.b *+$1A	; $3A30
	andi.b #$77, (-$3100,A4)	; $3A32
	ori.b #$2, (-$3100,A4)	; $3A38
	move.w D0, (-$2FFE,A4)	; $3A3E
	move.b D1, (-$30FF,A4)	; $3A42
	move.w D2, (-$30FE,A4)	; $3A46
SlideDown_End:
	rts	; $3A4A
SlideUp_Entry:
	tst.w (-$35FE,A4)	; $3A4C
	bmi.b *+$4	; $3A50
	rts	; $3A52
SlideUp:
	link A6, #-$4	; $3A54
	moveq #$0, D7	; $3A58
	move.b (-$34FD,A4), D7	; $3A5A
	neg.w D7	; $3A5E
	add.w (-$3700,A4), D7	; $3A60
	move.w D7, (-$2,A6)	; $3A64
	jsr $39DA.w	; $3A68
	move.w D0, (-$4,A6)	; $3A6C
	lsr.w #$4, D6	; $3A70
	andi.w #-$10, D7	; $3A72
	asl.w #$2, D7	; $3A76
SlideUp_Scan:
	jsr $30DA.w	; $3A78
	move.w D2, D0	; $3A7C
	andi.w #$104, D0	; $3A7E
	subq.w #$4, D0	; $3A82
	bne.b *+$E	; $3A84
	move.w (-$2,A6), D0	; $3A86
	neg.w D0	; $3A8A
	andi.w #$F, D0	; $3A8C
	bra.b *+$C	; $3A90
SlideUp_Next:
	addq.w #$1, D6	; $3A92
	subq.w #$1, (-$4,A6)	; $3A94
	bpl.b SlideUp_Scan	; $3A98
	bra.b *+$12	; $3A9A
SlideUp_Hit:
	move.w D0, (-$2FFE,A4)	; $3A9C
	andi.b #$5F, (-$3100,A4)	; $3AA0
	ori.b #$A, (-$3100,A4)	; $3AA6
SlideUp_Done:
	unlk A6	; $3AAC
	rts	; $3AAE
SlideUp2_Entry:
	tst.w (-$35FE,A4)	; $3AB0
	bmi.b *+$4	; $3AB4
	rts	; $3AB6
SlideUp2:
	link A6, #-$2	; $3AB8
	moveq #$0, D7	; $3ABC
	move.b (-$34FD,A4), D7	; $3ABE
	neg.w D7	; $3AC2
	add.w (-$3700,A4), D7	; $3AC4
	move.w D7, (-$2,A6)	; $3AC8
	move.w (-$3800,A4), D6	; $3ACC
	jsr $30CE.w	; $3AD0
	move.w D2, D0	; $3AD4
	andi.w #$4, D0	; $3AD6
	subq.w #$4, D0	; $3ADA
	bne.b *+$1C	; $3ADC
	move.w (-$2,A6), D0	; $3ADE
	neg.w D0	; $3AE2
	andi.w #$F, D0	; $3AE4
	move.w D0, (-$2FFE,A4)	; $3AE8
	andi.b #$5F, (-$3100,A4)	; $3AEC
	ori.b #$A, (-$3100,A4)	; $3AF2
SlideUp2_Done:
	unlk A6	; $3AF8
	rts	; $3AFA
SlideCheck_Init2:
	btst.b #$6, (-$2F00,A4)	; $3AFC
	beq.b *+$4	; $3B02
	rts	; $3B04
SlideCheck_V:
	btst.b #$4, (RAM_word_FFFF966B).w	; $3B06
	beq.b *+$12	; $3B0C
	move.w A4, D0	; $3B0E
	cmp.w (RAM_word_FFFF9EEE).w, D0	; $3B10
	bne.b *+$A	; $3B14
	btst.b #$5, (-$2EFF,A4)	; $3B16
	bne.b *+$10	; $3B1C
SlideCheck_VTest:
	move.b (-$2EFF,A4), D0	; $3B1E
	andi.b #-$76, D0	; $3B22
	eori.b #-$7E, D0	; $3B26
	bne.b *+$14	; $3B2A
SlideCheck_VApply:
	movea.w (-$2D00,A4), A2	; $3B2C
	tst.w (-$6072,A2)	; $3B30
	bpl.b *+$A	; $3B34
	move.w (-$5FCA,A2), D0	; $3B36
	add.w D0, (-$3800,A4)	; $3B3A
SlideCheck_VX:
	moveq #$0, D0	; $3B3E
	movea.w D0, A2	; $3B40
	move.w D0, (-$3000,A4)	; $3B42
	move.b (-$34FE,A4), D0	; $3B46
	move.w (-$3800,A4), D4	; $3B4A
	move.w D4, D5	; $3B4E
	move.w D4, D6	; $3B50
	add.w D0, D5	; $3B52
	sub.w D0, D6	; $3B54
	sub.w (-$2E00,A4), D4	; $3B56
	moveq #$5, D7	; $3B5A
	tst.b (-$6072,A2)	; $3B5C
	bpl.b *+$4	; $3B60
	bsr.b *+$12	; $3B62
SlideCheck_VNext:
	addq.w #$4, A2	; $3B64
	dbf D7, $3B5C	; $3B66
	move.w (-$3000,A4), D0	; $3B6A
	add.w D0, (-$3800,A4)	; $3B6E
	rts	; $3B72
SlideCheck_VTest2:
	move.w (-$3700,A4), D0	; $3B74
	move.w (-$601C,A2), D1	; $3B78
	cmp.w D1, D0	; $3B7C
	bcc.b *+$4	; $3B7E
			dc.w	$c340	; dc.w
SlideCheck_VTest3:
	sub.w D1, D0	; $3B82
	moveq #$0, D1	; $3B84
	move.b (-$34FD,A4), D1	; $3B86
	subq.w #$1, D1	; $3B8A
	add.w (-$5F74,A2), D1	; $3B8C
	cmp.w D1, D0	; $3B90
	bhi.w SlideCheck_VDone	; $3B92
	move.w (-$5FCA,A2), D3	; $3B96
	sub.w D4, D3	; $3B9A
	beq.w SlideCheck_VDone	; $3B9C
	bpl.b *+$40	; $3BA0
	move.b (-$3100,A4), D0	; $3BA2
	andi.b #-$7B, D0	; $3BA6
	eori.b #-$7B, D0	; $3BAA
	beq.b *+$72	; $3BAE
	move.b (-$6071,A2), D1	; $3BB0
	bsr.w GetTileBehavior	; $3BB4
	moveq #$1, D0	; $3BB8
	and.w D0, D2	; $3BBA
	eor.w D0, D2	; $3BBC
	bne.b *+$62	; $3BBE
	move.w D5, D1	; $3BC0
	move.w (-$601E,A2), D0	; $3BC2
	sub.w (-$5F76,A2), D0	; $3BC6
	sub.w D1, D0	; $3BCA
	bpl.b *+$54	; $3BCC
	cmp.w D3, D0	; $3BCE
	bcs.b *+$50	; $3BD0
	cmp.w (-$3000,A4), D0	; $3BD2
	bge.b *+$4A	; $3BD6
	ori.b #-$7F, (-$3100,A4)	; $3BD8
	bra.b *+$3E	; $3BDE
SlideCheck_VTest4:
	move.b (-$3100,A4), D0	; $3BE0
	andi.b #-$7B, D0	; $3BE4
	eori.b #-$7F, D0	; $3BE8
	beq.b *+$34	; $3BEC
	move.b (-$6071,A2), D1	; $3BEE
	bsr.w GetTileBehavior	; $3BF2
	moveq #$2, D0	; $3BF6
	and.w D0, D2	; $3BF8
	eor.w D0, D2	; $3BFA
	bne.b *+$24	; $3BFC
	move.w D6, D1	; $3BFE
	move.w (-$601E,A2), D0	; $3C00
	add.w (-$5F76,A2), D0	; $3C04
	sub.w D1, D0	; $3C08
	bmi.b *+$16	; $3C0A
	cmp.w D3, D0	; $3C0C
	bhi.b *+$12	; $3C0E
	cmp.w (-$3000,A4), D0	; $3C10
	ble.b *+$C	; $3C14
	ori.b #-$7B, (-$3100,A4)	; $3C16
SlideCheck_VStore:
	move.w D0, (-$3000,A4)	; $3C1C
SlideCheck_VDone:
	rts	; $3C20
SlideCheck_Init3:
	btst.b #$6, (-$2F00,A4)	; $3C22
	beq.b *+$4	; $3C28
	rts	; $3C2A
SlideCheck_Init:
	move.w #-$1, (RAM_word_FFFF9EE4).w	; $3C2C
	btst.b #$4, (RAM_word_FFFF966B).w	; $3C32
	beq.b *+$1E	; $3C38
	move.w A4, D0	; $3C3A
	cmp.w (RAM_word_FFFF9EEE).w, D0	; $3C3C
	bne.b *+$16	; $3C40
	btst.b #$5, (-$2EFF,A4)	; $3C42
	beq.b *+$E	; $3C48
	movea.w (-$2D00,A4), A2	; $3C4A
	tst.b (-$6072,A2)	; $3C4E
	bpl.b *+$48	; $3C52
	bra.b *+$2A	; $3C54
SlideCheck_B:
	move.b (-$2EFF,A4), D0	; $3C56
	andi.b #-$76, D0	; $3C5A
	eori.b #-$7E, D0	; $3C5E
	bne.b *+$38	; $3C62
	movea.w (-$2D00,A4), A2	; $3C64
	tst.b (-$6072,A2)	; $3C68
	bpl.b *+$2E	; $3C6C
	bsr.w CheckEntityProximity	; $3C6E
	bcs.b *+$28	; $3C72
	move.w D1, (RAM_word_FFFF9EE4).w	; $3C74
	ori.b #-$7E, (-$3100,A4)	; $3C78
SlideCheck_ApplyB:
	move.w (-$5FC8,A2), D0	; $3C7E
	add.w D0, (-$3700,A4)	; $3C82
	move.b (-$6071,A2), D1	; $3C86
	jsr $30F4.w	; $3C8A
	move.w D2, (-$30FE,A4)	; $3C8E
	clr.w (-$35FE,A4)	; $3C92
	clr.w (-$36FE,A4)	; $3C96
SlideCheck_Y:
	moveq #$0, D0	; $3C9A
	movea.w D0, A2	; $3C9C
	move.w D0, (-$2FFE,A4)	; $3C9E
	move.b (-$34FD,A4), D0	; $3CA2
	move.w (-$3700,A4), D4	; $3CA6
	move.w D4, D5	; $3CAA
	move.w D5, D6	; $3CAC
	sub.w D0, D6	; $3CAE
	add.w D0, D5	; $3CB0
	sub.w (-$2DFE,A4), D4	; $3CB2
	moveq #$5, D7	; $3CB6
	tst.b (-$6072,A2)	; $3CB8
	bpl.b *+$1A	; $3CBC
	move.b (-$2EFF,A4), D0	; $3CBE
	andi.b #-$76, D0	; $3CC2
	eori.b #-$7E, D0	; $3CC6
	bne.b *+$A	; $3CCA
	move.w (-$2D00,A4), D0	; $3CCC
	sub.w A2, D0	; $3CD0
	beq.b *+$4	; $3CD2
SlideCheck_YScan:
	bsr.b *+$32	; $3CD4
SlideCheck_YNext:
	addq.w #$4, A2	; $3CD6
	dbf D7, $3CB8	; $3CD8
	move.w (-$2FFE,A4), D0	; $3CDC
	add.w D0, (-$3700,A4)	; $3CE0
	move.b (-$3100,A4), D0	; $3CE4
	andi.b #-$76, D0	; $3CE8
	eori.b #-$7E, D0	; $3CEC
	bne.b *+$14	; $3CF0
	movea.w (-$2D00,A4), A2	; $3CF2
	moveq #$1, D0	; $3CF6
	cmpa.w (RAM_word_FFFF9EEE).w, A4	; $3CF8
	beq.b *+$4	; $3CFC
	moveq #$2, D0	; $3CFE
SlideCheck_YSave:
	or.b D0, (-$6072,A2)	; $3D00
SlideCheck_YDone:
	rts	; $3D04
SlideCheck_YTest:
	bsr.w CheckEntityProximity	; $3D06
	bcs.w SlideCheck_End	; $3D0A
	move.w D1, (RAM_word_FFFF9EE6).w	; $3D0E
	move.w (-$5FC8,A2), D3	; $3D12
	sub.w D4, D3	; $3D16
	bmi.w SlideCheck_YTest2	; $3D18
	bne.w SlideCheck_YTest5	; $3D1C
	tst.w (RAM_word_FFFF9EE4).w	; $3D20
	bpl.w SlideCheck_YTest2	; $3D24
	move.b (-$2EFF,A4), D0	; $3D28
	andi.b #$A, D0	; $3D2C
	subq.b #$2, D0	; $3D30
	bne.w SlideCheck_End	; $3D32
SlideCheck_YTest2:
	move.b (-$3100,A4), D0	; $3D36
	andi.b #-$76, D0	; $3D3A
	eori.b #-$76, D0	; $3D3E
	beq.w SlideCheck_End	; $3D42
	move.b (-$6071,A2), D1	; $3D46
	bsr.w GetTileBehavior	; $3D4A
	moveq #$8, D0	; $3D4E
	and.w D0, D2	; $3D50
	eor.w D0, D2	; $3D52
	bne.w SlideCheck_End	; $3D54
	move.w D5, D1	; $3D58
	move.w (-$601C,A2), D0	; $3D5A
	sub.w (-$5F74,A2), D0	; $3D5E
	move.w D0, D2	; $3D62
	sub.w D1, D0	; $3D64
	bhi.w SlideCheck_End	; $3D66
	tst.w (RAM_word_FFFF9EE4).w	; $3D6A
	bmi.b *+$22	; $3D6E
	movea.w (-$2D00,A4), A0	; $3D70
	move.w (-$601C,A0), D1	; $3D74
	sub.w (-$5F74,A0), D1	; $3D78
	cmp.w D1, D2	; $3D7C
	bne.b *+$12	; $3D7E
	move.w (RAM_word_FFFF9EE6).w, D2	; $3D80
	moveq #$0, D1	; $3D84
	move.b (-$34FE,A4), D1	; $3D86
	sub.w D1, D2	; $3D8A
	bls.b *+$72	; $3D8C
	bra.b *+$6	; $3D8E
SlideCheck_YTest3:
	cmp.w D3, D0	; $3D90
	blt.b *+$6C	; $3D92
SlideCheck_YTest4:
	cmp.w (-$2FFE,A4), D0	; $3D94
	bgt.b *+$66	; $3D98
	ori.b #-$7E, (-$3100,A4)	; $3D9A
	clr.w (-$35FE,A4)	; $3DA0
	clr.w (-$36FE,A4)	; $3DA4
	bra.b *+$48	; $3DA8
SlideCheck_YTest5:
	move.b (-$6071,A2), D1	; $3DAA
	bsr.w GetTileBehavior	; $3DAE
	moveq #$4, D0	; $3DB2
	and.w D0, D2	; $3DB4
	eor.w D0, D2	; $3DB6
	bne.b *+$46	; $3DB8
	move.w D6, D1	; $3DBA
	move.w (-$601C,A2), D0	; $3DBC
	add.w (-$5F74,A2), D0	; $3DC0
	sub.w D1, D0	; $3DC4
	bmi.b *+$38	; $3DC6
	cmp.w D3, D0	; $3DC8
	bhi.b *+$34	; $3DCA
	move.b (-$3100,A4), D1	; $3DCC
	andi.w #$8A, D1	; $3DD0
	eori.w #$82, D1	; $3DD4
	beq.b *+$8	; $3DD8
	cmp.w (-$2FFE,A4), D0	; $3DDA
	blt.b *+$20	; $3DDE
SlideCheck_YApply:
	ori.b #-$76, (-$3100,A4)	; $3DE0
	tst.w (-$35FE,A4)	; $3DE6
	bpl.b *+$6	; $3DEA
	clr.w (-$35FE,A4)	; $3DEC
SlideCheck_YStore:
	move.w A2, D1	; $3DF0
	move.w D1, (-$2D00,A4)	; $3DF2
	move.w D0, (-$2FFE,A4)	; $3DF6
	clr.w (-$36FE,A4)	; $3DFA
SlideCheck_End:
	rts	; $3DFE
CheckEntityProximity:
	move.w (-$3800,A4), D0	; $3E00
	move.w (-$601E,A2), D1	; $3E04
	cmp.w D1, D0	; $3E08
	bcc.b *+$4	; $3E0A
			dc.w	$c340	; dc.w
CheckEntityProximity_Calc:
	sub.w D1, D0	; $3E0E
	moveq #$0, D1	; $3E10
	move.b (-$34FE,A4), D1	; $3E12
	subq.b #$1, D1	; $3E16
	add.w (-$5F76,A2), D1	; $3E18
	sub.w D0, D1	; $3E1C
	rts	; $3E1E
	andi.w #$F0, D1	; $3E20
	lsr.w #$4, D1	; $3E24
			dc.w	$41fa,$000a	; dc.w
	move.b ($0,A0,D1.w), D1	; $3E2A
	ext.w	D1				; $3E2E
	rts					; $3E30
GaugeFillTable:					; loc_0003E32
	dc.w	$00F8,$F808,$08F0,$10E8,$E818,$1800	; $3E32
			dc.w	$41fa,$0078	; dc.w
	btst.b #$0, (RAM_word_FFFF966B).w	; $3E42
	bne.b *+$12	; $3E48
	rts	; $3E4A
			dc.w	$41fa,$0092	; dc.w
	btst.b #$0, (RAM_word_FFFF966B).w	; $3E50
	bne.b *+$4	; $3E56
	rts	; $3E58
GaugeFill:
	move.w (RAM_word_FFFF9EE2).w, D0	; $3E5A
	move.w D0, D1	; $3E5E
	andi.w #-$1000, D1	; $3E60
	cmpi.w #-$5000, D1	; $3E64
	bne.b *+$4E	; $3E68
	andi.w #$F0, D0	; $3E6A
	lsr.w #$3, D0	; $3E6E
	move.w ($0,A0,D0.w), D1	; $3E70
	beq.b *+$24	; $3E74
	bmi.b *+$C	; $3E76
	cmpi.w #$180, (-$35FE,A4)	; $3E78
	bge.b *+$1A	; $3E7E
	bra.b *+$A	; $3E80
GaugeFill_Neg:
	cmpi.w #-$180, (-$35FE,A4)	; $3E82
	ble.b *+$10	; $3E88
GaugeFill_Add:
	tst.w D1	; $3E8A
	bmi.b *+$8	; $3E8C
	move.w D1, D2	; $3E8E
	add.w D1, D1	; $3E90
	add.w D2, D1	; $3E92
GaugeFill_X:
	add.w D1, (-$35FE,A4)	; $3E94
GaugeFill_X2:
	move.w ($8,A0,D0.w), D1	; $3E98
	beq.b *+$1A	; $3E9C
	bmi.b *+$C	; $3E9E
	cmpi.w #$180, (-$3600,A4)	; $3EA0
	bge.b *+$10	; $3EA6
	bra.b *+$A	; $3EA8
GaugeFill_XNeg:
	cmpi.w #-$180, (-$3600,A4)	; $3EAA
	ble.b *+$6	; $3EB0
GaugeFill_Store:
	add.w D1, (-$3600,A4)	; $3EB2
GaugeFill_Done:
	rts					; $3EB6
AngleDeltaTable:				; loc_0003EB8 - sine delta curve
	dc.w	$0000,$0003,$0005,$0007,$0008,$0007,$0005,$0003	; $3EB8
	dc.w	$0000,$FFFD,$FFFB,$FFF9,$FFF8,$FFF9,$FFFB,$FFFD	; $3EC8
	dc.w	$0000,$0003,$0005,$0007,$0000,$0018,$002D,$003B	; $3ED8
	dc.w	$0040,$003B,$002D,$0018,$0000,$FFE8,$FFD3,$FFC5	; $3EE8
	dc.w	$FFC0,$FFC5,$FFD3,$FFE8,$0000,$0018,$002D,$003B	; $3EF8
TileBehaviorCheck:
	btst.b	#$6, (-$2F00,A4)		; $3F08
	bne.b	*+$44				; $3F0E
	moveq	#$A, D0				; $3F10
	and.b	(-$2EFF,A4), D0		; $3F12
	subq.b #$2, D0	; $3F16
	bne.b *+$3A	; $3F18
	move.w (RAM_word_FFFF9EDE).w, D0	; $3F1A
	andi.w #-$FF8, D0	; $3F1E
	cmpi.w #$1008, D0	; $3F22
	beq.b *+$10	; $3F26
	move.w (-$30FE,A4), D1	; $3F28
	andi.w #-$FF8, D1	; $3F2C
	cmpi.w #$1008, D1	; $3F30
	bne.b *+$8	; $3F34
SlideAdjust:
	move.b (RAM_word_FFFF9EDA).w, D0	; $3F36
	bra.b *+$12	; $3F3A
SlideAdjust2:
	cmpi.w #$2008, D0	; $3F3C
	beq.b *+$8	; $3F40
	cmpi.w #$2008, D1	; $3F42
	bne.b *+$C	; $3F46
SlideAdjust3:
	move.b (RAM_word_FFFF9EDB).w, D0	; $3F48
SlideAdjust_Apply:
	ext.w D0	; $3F4C
	add.w D0, (-$3800,A4)	; $3F4E
SlideAdjust_Done:
	rts	; $3F52
	lea (-$68AC).w, A3	; $3F54
	move.w (-$3800,A4), D6	; $3F58
	moveq #$0, D7	; $3F5C
	move.b (-$34FD,A4), D7	; $3F5E
	add.w (-$3700,A4), D7	; $3F62
	jsr $30D2.w	; $3F66
	move.w D2, (RAM_word_FFFF9EDE).w	; $3F6A
	rts	; $3F6E
	lea (-$68AC).w, A3	; $3F70
	move.w (-$3800,A4), D6	; $3F74
	moveq #$0, D0	; $3F78
	move.b (-$34FD,A4), D0	; $3F7A
	move.w (-$3700,A4), D7	; $3F7E
	sub.w D0, D7	; $3F82
	jsr $30D2.w	; $3F84
	move.w D2, (RAM_word_FFFF9EDC).w	; $3F88
	rts	; $3F8C
	lea (-$68AC).w, A3	; $3F8E
	move.w (-$3800,A4), D6	; $3F92
	moveq #$0, D7	; $3F96
	move.b (-$34FD,A4), D7	; $3F98
	add.w (-$3700,A4), D7	; $3F9C
	subq.w #$1, D7	; $3FA0
	jsr $30D2.w	; $3FA2
	move.w D2, (RAM_word_FFFF9EE0).w	; $3FA6
	rts	; $3FAA
	lea (-$68AC).w, A3	; $3FAC
	move.w (-$3800,A4), D6	; $3FB0
	move.w (-$3700,A4), D7	; $3FB4
	jsr $30D2.w	; $3FB8
	move.w D2, (RAM_word_FFFF9EE2).w	; $3FBC
	rts	; $3FC0
AttackSpeedTable:			; loc_0003FC2
	dc.b	$00,$0a,$00,$2a,$00,$4a,$00,$64,$00,$6a,$00,$00,$00,$0f,$00,$0f	; $3FC2
	dc.b	$40,$00,$90,$0f,$70,$00,$10,$0f,$20,$0f,$02,$0f,$50,$00,$60,$00	; $3FD2
	dc.b	$80,$0f,$a0,$0f,$c0,$0f,$00,$04,$00,$0f,$00,$08,$01,$19,$01,$29	; $3FE2
	dc.b	$01,$3a,$01,$4a,$01,$59,$01,$6a,$40,$08,$01,$79,$01,$89,$01,$9a	; $3FF2
	dc.b	$01,$aa,$21,$19,$21,$29,$11,$3a,$11,$4a,$02,$08,$03,$19,$03,$29	; $4002
	dc.b	$03,$3a,$03,$4a,$03,$59,$03,$6a,$42,$08,$03,$79,$03,$89,$03,$9a	; $4012
	dc.b	$03,$aa,$90,$08,$30,$00,$30,$08,$d0,$08,$b0,$00,$b0,$10,$b0,$20	; $4022
	dc.b	$b0,$30,$b0,$40,$b0,$50,$b0,$60,$b0,$70,$b0,$80,$b0,$90,$b0,$a0	; $4032
	dc.b	$b0,$b0,$b0,$c0,$b0,$d0,$b0,$e0,$b0,$f0,$0f,$0f,$0e,$0e,$0d,$0d	; $4042
	dc.b	$0c,$0c,$0b,$0b,$0a,$0a,$09,$09,$08,$08,$07,$07,$06,$06,$05,$05	; $4052
	dc.b	$04,$04,$03,$03,$02,$02,$01,$01,$00,$00,$00,$00,$01,$01,$02,$02	; $4062
	dc.b	$03,$03,$04,$04,$05,$05,$06,$06,$07,$07,$08,$08,$09,$09,$0a,$0a	; $4072
	dc.b	$0b,$0b,$0c,$0c,$0d,$0d,$0e,$0e,$0f,$0f,$0f,$0e,$0d,$0c,$0b,$0a	; $4082