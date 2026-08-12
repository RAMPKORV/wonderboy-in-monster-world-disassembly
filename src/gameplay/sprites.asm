; ======================================================================
; src/gameplay/sprites.asm
; Sprite animation tables + entity sprite code
; Covers ROM $4092-$4900.
; Verified bit-exact against the original ROM.
; ======================================================================
SpriteAnimTable:				; loc_0004092
	dc.b	$09,$08,$07,$06,$05,$04,$03,$02,$01,$00,$00,$01,$02,$03,$04,$05	; $4092
	dc.b	$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f,$1e,$1c,$1a,$18,$16,$14	; $40A2
	dc.b	$12,$10,$0e,$0c,$0a,$08,$06,$04,$02,$00,$0e,$0c,$0a,$08,$06,$04	; $40B2
	dc.b	$02,$00,$fe,$fc,$fa,$f8,$f6,$f4,$f2,$f0,$00,$02,$04,$06,$08,$0a	; $40C2
	dc.b	$0c,$0e,$10,$12,$14,$16,$18,$1a,$1c,$1e,$f0,$f2,$f4,$f6,$f8,$fa	; $40D2
	dc.b	$fc,$fe,$00,$02,$04,$06,$08,$0a,$0c,$0e,$80,$80,$80,$80,$80,$80	; $40E2
	dc.b	$80,$80,$0d,$0b,$09,$07,$05,$03,$01,$ff,$0d,$0b,$09,$07,$05,$03	; $40F2
	dc.b	$01,$ff,$00,$00,$00,$00,$00,$00,$00,$00,$02,$04,$06,$08,$0a,$0c	; $4102
	dc.b	$0e,$10,$10,$10,$10,$10,$10,$10,$10,$10,$80,$80,$80,$80,$80,$80	; $4112
	dc.b	$80,$80,$02,$04,$06,$08,$0a,$0c,$0e,$10,$0e,$0d,$0c,$0b,$0a,$09	; $4122
	dc.b	$08,$07,$06,$05,$04,$03,$02,$01,$00,$ff,$01,$02,$03,$04,$05,$06	; $4132
	dc.b	$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f,$10,$0e,$0e,$0d,$0d,$0c,$0c	; $4142
	dc.b	$0b,$0b,$0a,$0a,$09,$09,$08,$08,$07,$07,$06,$06,$05,$05,$04,$04	; $4152
	dc.b	$03,$03,$02,$02,$01,$01,$00,$00,$ff,$ff,$01,$01,$02,$02,$03,$03	; $4162
	dc.b	$04,$04,$05,$05,$06,$06,$07,$07,$08,$08,$09,$09,$0a,$0a,$0b,$0b	; $4172
	dc.b	$0c,$0c,$0d,$0d,$0e,$0e,$0f,$0f,$10,$10,$05,$07,$03,$00,$04,$07	; $4182
	dc.b	$05,$00,$04,$01,$03,$07,$05,$01,$02,$07,$03,$06,$05,$02,$06,$01	; $4192
CopyEntityFields:
		dc.w	$394a,$d302	; move.w
		dc.w	$354c,$d302	; move.w
	dc.w	$C54C				; $41AA  ; EXG A4,A2
	move.b	#$80, (ENT_Flags,A4)		; $41AC
	jsr	$A36.w				; $41B2
	dc.w	$C54C				; $41B6  ; EXG A4,A2
	move.w	(-$3DFE,A4), (-$3DFE,A2)	; $41B8
	move.w (ENT_TreeIdx0,A4), (ENT_TreeIdx0,A2)	; $41BE
	move.w (ENT_X,A4), (ENT_X,A2)	; $41C4
	move.w (ENT_Y,A4), (ENT_Y,A2)	; $41CA
	move.l (ENT_Attack,A4), (ENT_Attack,A2)	; $41D0
	move.w (ENT_Gold,A4), (ENT_Gold,A2)	; $41D6
	move.w (ENT_Defense,A4), (ENT_Defense,A2)	; $41DC
	move.l (ENT_AttackRange,A4), (ENT_AttackRange,A2)	; $41E2
	move.w (-$2B00,A4), (-$2B00,A2)	; $41E8
	rts	; $41EE
	btst.b #$0, (RAM_word_FFFF966B).w	; $41F0
	beq.b *+$16	; $41F6
	moveq #$3F, D0	; $41F8
	and.w (RAM_word_FFFF965A).w, D0	; $41FA
	bne.b *+$E	; $41FE
	jsr $5D8.w	; $4200
	move.w D0, D1	; $4204
	andi.w #$3, D1	; $4206
	beq.b *+$12	; $420A
RandomIdle_Done:
	rts	; $420C
	btst.b #$0, (RAM_word_FFFF966B).w	; $420E
	bne.b *+$4	; $4214
	rts	; $4216
IdleCheck:
	jsr $5D8.w	; $4218
IdleCheck_Setup:
	move.w #$204, D1	; $421C
	andi.w #$3, D0	; $4220
	beq.b *+$6	; $4224
	move.w #$210, D1	; $4226
IdleCheck_Scan:
	move.w D1, D0	; $422A
	moveq #$0, D1	; $422C
	move.b (ENT_ColW2,A4), D1	; $422E
	lsr.w #$1, D1	; $4232
	btst.b #$3, (ENT_Counter,A4)	; $4234
	beq.b *+$4	; $423A
	neg.w D1	; $423C
IdleCheck_X:
	add.w (ENT_X,A4), D1	; $423E
	moveq #$0, D2	; $4242
	move.b (ENT_ColH2,A4), D2	; $4244
	neg.w D2	; $4248
	add.w (ENT_Y,A4), D2	; $424A
	jmp SpawnPickup.l	; $424E
	bsr.b *+$8	; $4254
	jsr $AB4.w	; $4256
	rts	; $425A
DecelerateVelocity:
	move.w (ENT_VelX,A4), D1	; $425C
	asr.w #$4, D1	; $4260
	sub.w D1, (ENT_VelX,A4)	; $4262
	move.w (ENT_VelY,A4), D1	; $4266
	asr.w #$4, D1	; $426A
	sub.w D1, (ENT_VelY,A4)	; $426C
	jmp $B42.w	; $4270
	tst.w (ENT_VelY,A4)	; $4274
	bpl.b *+$4	; $4278
	neg.w D1	; $427A
DecelerateY:
	add.w D1, D0	; $427C
	cmp.w (ENT_Y,A4), D0	; $427E
	bcc.b *+$4	; $4282
	neg.w D2	; $4284
DecelerateY_Store:
	move.w D2, (-$33FE,A4)	; $4286
	rts	; $428A
	jsr $5D8.w	; $428C
	andi.w #$7, D0	; $4290
	add.w D2, D0	; $4294
	move.b ($0,A0,D0.w), D0	; $4296
	beq.b *+$E	; $429A
	bpl.b *+$8	; $429C
	jmp ApplyStatusEffect.l	; $429E
SetAnimId:
	move.b D0, (ENT_Anim,A4)	; $42A4
SetAnimId_Done:
	rts	; $42A8
	jsr CheckAnimTimer.w	; $42AA
	bne.b *+$12	; $42AE
	jsr FacePlayer.w	; $42B0
	tst.b (-$27FF,A4)	; $42B4
	beq.b *+$A	; $42B8
	subq.b #$1, (-$27FF,A4)	; $42BA
	beq.b *+$4	; $42BE
AnimTimer_Done:
	addq.w #$4, SP	; $42C0
AnimTimer_Return:
	rts	; $42C2
	jsr HelperAttack.w	; $42C4
	jmp UpdateHelperPos.w	; $42C8
	jsr UpdateHelper.w	; $42CC
	jmp UpdateHelperPos.w	; $42D0
	move.w #$1208, D6	; $42D4
	bra.b *+$6	; $42D8
	move.w #$120A, D6	; $42DA
PlaySound3F:
	moveq #$3F, D0	; $42DE
	jsr $366.w	; $42E0
	moveq #-$80, D1	; $42E4
	bra.b *+$4	; $42E6
	moveq #$0, D1	; $42E8
SpawnHelper:
	jsr SpawnMagicWave.l	; $42EA
	bmi.b *+$4E	; $42F0
	exg A2, A4	; $42F2
	jsr $A36.w	; $42F4
	move.b #-$80, (ENT_Flags,A4)	; $42F8
	move.b D1, (ENT_Counter,A4)	; $42FE
	move.w D6, (ENT_TreeIdx0,A4)	; $4302
	move.b #$A, (-$3CFD,A4)	; $4306
	move.w D4, D3	; $430C
	bsr.b *+$32	; $430E
	add.w (ENT_X,A2), D2	; $4310
	move.w D2, (ENT_X,A4)	; $4314
	move.w D5, D3	; $4318
	bsr.b *+$26	; $431A
	add.w (ENT_Y,A2), D2	; $431C
	move.w D2, (ENT_Y,A4)	; $4320
	move.w #$218, (ENT_HPTimer,A4)	; $4324
	moveq #$0, D0	; $432A
	jsr $7E8.w	; $432C
	st (ENT_Counter2,A4)	; $4330
	ori.b #$40, (ENT_Flags,A4)	; $4334
	exg A2, A4	; $433A
	moveq #$0, D0	; $433C
SpawnHelper_Done:
	rts	; $433E
RandomSigned:
	jsr $5D8.w	; $4340
	moveq #$0, D2	; $4344
	move.w D0, D2	; $4346
	divu.w D3, D2	; $4348
	swap D2	; $434A
	btst.l #$10, D0	; $434C
	beq.b *+$4	; $4350
	neg.w D2	; $4352
RandomSigned_Done:
	rts	; $4354
CheckAnimTimer:
	bsr.b *+$C	; $4356
	bne.b *+$8	; $4358
	moveq #$40, D0	; $435A
	jmp $B92.w	; $435C
CheckEntityState_Done:
	rts	; $4360
CheckEntityState:
	moveq #$A, D0	; $4362
	and.b (ENT_State,A4), D0	; $4364
	subq.b #$2, D0	; $4368
	rts	; $436A
	btst.b #$4, (ENT_PlayerFlags,A4)	; $436C
	beq.b *+$A	; $4372
	move.b D0, (ENT_Anim,A4)	; $4374
	addq.w #$4, SP	; $4378
	bra.b *+$E	; $437A
SetAnimId_Return:
	rts	; $437C
	btst.b #$4, (ENT_PlayerFlags,A4)	; $437E
	bne.b *+$4	; $4384
	rts	; $4386
FaceTarget:
	move.w (ENT_MaxVelX,A4), D0	; $4388
	add.w D0, D0	; $438C
	btst.b #$3, (ENT_Counter,A4)	; $438E
	bne.b *+$4	; $4394
	neg.w D0	; $4396
FaceTarget_Store:
	move.w D0, (ENT_VelX,A4)	; $4398
	rts	; $439C
CheckCollisionFlag:
	move.b (ENT_PlayerFlags,A4), D0	; $439E
	bmi.b *+$18	; $43A2
	move.b (-$21FF,A4), D1	; $43A4
	bpl.b *+$12	; $43A8
	andi.b #-$2, D0	; $43AA
	andi.b #$1, D1	; $43AE
	or.b D1, D0	; $43B2
	move.b D0, (ENT_PlayerFlags,A4)	; $43B4
	moveq #-$1, D0	; $43B8
CheckCollisionFlag_Done:
	rts	; $43BA
CheckCollisionFlag2:
	bsr.b $439E	; $43BC
	bmi.b *+$4	; $43BE
	rts	; $43C0
BounceHit:
	moveq #$2, D0	; $43C2
	addq.w #$4, SP	; $43C4
	jmp ApplyKnockback.l	; $43C6
	jsr $5D8.w	; $43CC
	andi.b #$7F, D0	; $43D0
	addi.w #$40, D0	; $43D4
	move.b D0, (-$2800,A4)	; $43D8
	rts	; $43DC
	jsr $5D8.w	; $43DE
	andi.w #$1F, D0	; $43E2
	addi.w #$20, D0	; $43E6
	move.b D0, (-$2800,A4)	; $43EA
	rts	; $43EE
	jsr $5D8.w	; $43F0
	andi.b #$1F, D0	; $43F4
	addi.b #$10, D0	; $43F8
	move.b D0, (-$27FF,A4)	; $43FC
	rts	; $4400
	jsr $5D8.w	; $4402
	andi.w #$3F, D0	; $4406
	addi.w #$40, D0	; $440A
	move.w D0, (-$31FE,A4)	; $440E
	rts	; $4412
	jsr $5D8.w	; $4414
	move.w D0, D1	; $4418
	andi.w #$7F, D0	; $441A
	addi.w #$80, D0	; $441E
	move.w D0, (-$31FE,A4)	; $4422
	rts	; $4426
	moveq #$41, D0	; $4428
	and.b (ENT_State,A4), D0	; $442A
	subq.b #$1, D0	; $442E
	bne.b *+$6	; $4430
	addq.w #$4, SP	; $4432
	bra.b *+$58	; $4434
CheckState_Done:
	rts	; $4436
	moveq #$41, D0	; $4438
	and.b (ENT_State,A4), D0	; $443A
	subq.b #$1, D0	; $443E
	beq.b *+$4C	; $4440
	rts	; $4442
	btst.b #$2, (ENT_PlayerFlags,A4)	; $4444
	bne.b *+$4	; $444A
	rts	; $444C
CheckState_Ret:
	addq.w #$4, SP	; $444E
	bra.b *+$C	; $4450
	btst.b #$2, (ENT_PlayerFlags,A4)	; $4452
	bne.b *+$4	; $4458
	rts	; $445A
CheckFacing:
	btst.b #$0, (ENT_PlayerFlags,A4)	; $445C
	beq.b *+$A	; $4462
	andi.b #-$9, (ENT_Counter,A4)	; $4464
	bra.b *+$28	; $446A
SetFacingBit:
	ori.b #$8, (ENT_Counter,A4)	; $446C
	bra.b *+$20	; $4472
	btst.b #$2, (ENT_PlayerFlags,A4)	; $4474
	beq.b *+$6	; $447A
	addq.w #$4, SP	; $447C
	bra.b *+$E	; $447E
CheckFacing_Done:
	rts	; $4480
	btst.b #$2, (ENT_PlayerFlags,A4)	; $4482
	bne.b *+$4	; $4488
	rts	; $448A
FlipFacing:
	bchg.b #$3, (ENT_Counter,A4)	; $448C
ApplyFacingVelocity:
	move.w (ENT_MaxVelX,A4), D0	; $4492
	btst.b #$3, (ENT_Counter,A4)	; $4496
	beq.b *+$4	; $449C
	neg.w D0	; $449E
ApplyFacingVelocity_Store:
	move.w D0, (ENT_VelX,A4)	; $44A0
	rts	; $44A4
	tst.w (ENT_VelX,A4)	; $44A6
	bmi.b *+$A	; $44AA
	andi.b #-$9, (ENT_Counter,A4)	; $44AC
	rts	; $44B2
SetFacingRight:
	ori.b #$8, (ENT_Counter,A4)	; $44B4
	rts	; $44BA
	move.w (ENT_X,A2), D0	; $44BC
	sub.w (ENT_X,A4), D0	; $44C0
	ext.l D0	; $44C4
	lsl.w #$8, D0	; $44C6
	divs.w D1, D0	; $44C8
	move.w D0, (ENT_VelX,A4)	; $44CA
	rts	; $44CE
	bsr.b *+$6	; $44D0
	bra.w $4492	; $44D2
FacePlayer:
	movea.w (RAM_word_FFFFA11C).w, A2	; $44D6
	move.w (ENT_X,A2), D0	; $44DA
	sub.w (ENT_X,A4), D0	; $44DE
	bpl.b *+$A	; $44E2
	ori.b #$8, (ENT_Counter,A4)	; $44E4
	rts	; $44EA
FacePlayer_Left:
	andi.b #-$9, (ENT_Counter,A4)	; $44EC
	rts	; $44F2
	move.w (ENT_MaxVelY,A4), D0	; $44F4
	addi.w #$80, D0	; $44F8
	neg.w D0	; $44FC
	bra.b *+$A	; $44FE
	move.w (ENT_MaxVelY,A4), D0	; $4500
	lsr.w #$1, D0	; $4504
	neg.w D0	; $4506
SetJumpVelocity:
	andi.b #$75, (ENT_State,A4)	; $4508
	move.w D0, (ENT_VelY,A4)	; $450E
	rts	; $4512
	ori.b #$20, (ENT_Flags,A4)	; $4514
	ori.b #$40, (ENT_ScriptFlag,A4)	; $451A
	move.w #$2101, (ENT_Repeat,A4)	; $4520
	move.b #$1E, (-$2800,A4)	; $4526
	rts	; $452C
	move.w (ENT_MaxVelY,A4), D0	; $452E
	neg.w D0	; $4532
	bsr.w $4508	; $4534
	move.w #$200, D0	; $4538
ChasePlayer:
	move.w D0, D1	; $453C
	jsr CheckEntityState.w	; $453E
	beq.b *+$6	; $4542
	move.w #$100, D1	; $4544
ChasePlayer_Store:
	btst.b #$0, (ENT_PlayerFlags,A4)	; $4548
	bne.b *+$4	; $454E
	neg.w D1	; $4550
ChasePlayer_Done:
	move.w D1, (ENT_VelX,A4)	; $4552
	rts	; $4556
	move.w #$400, D0	; $4558
	bra.b $453C	; $455C
	movea.w (RAM_word_FFFFA11C).w, A2	; $455E
	moveq #$8, D0	; $4562
	move.w (ENT_X,A2), D1	; $4564
	sub.w (ENT_X,A4), D1	; $4568
	bcs.b *+$6	; $456C
	moveq #$0, D0	; $456E
	rts	; $4570
FacePlayer_XNeg:
	neg.w D1	; $4572
	rts	; $4574
	movea.w (RAM_word_FFFFA11C).w, A2	; $4576
GetYDelta:
	move.w (ENT_Y,A2), D1	; $457A
	sub.w (ENT_Y,A4), D1	; $457E
	rts	; $4582
	movea.w (RAM_word_FFFFA11C).w, A2	; $4584
	bsr.w $457A	; $4588
	bpl.b *+$4	; $458C
	neg.w D1	; $458E
GetYDelta_Done:
	rts	; $4590
	moveq #$41, D0	; $4592
	and.b (ENT_State,A4), D0	; $4594
	subq.b #$1, D0	; $4598
	bne.b *+$10	; $459A
	bsr.b *+$10	; $459C
	bne.b *+$C	; $459E
	addq.w #$4, SP	; $45A0
	moveq #$5, D0	; $45A2
	jmp ApplyStatusEffect.l	; $45A4
CheckWallAhead_Done:
	rts	; $45AA
CheckWallAhead:
	moveq #$0, D6	; $45AC
	move.b (ENT_ColW2,A4), D6	; $45AE
	addq.w #$1, D6	; $45B2
	btst.b #$3, (ENT_Counter,A4)	; $45B4
	beq.b *+$4	; $45BA
	neg.w D6	; $45BC
CheckWallAhead_X:
	add.w (ENT_X,A4), D6	; $45BE
	moveq #$0, D7	; $45C2
	move.b (ENT_ColH2,A4), D7	; $45C4
	add.w (ENT_Y,A4), D7	; $45C8
	subi.w #$30, D7	; $45CC
	jsr ReadTileSetup.w	; $45D0
	andi.w #$103, D2	; $45D4
	subq.w #$3, D2	; $45D8
	rts	; $45DA
	bsr.b *+$18	; $45DC
	bcs.b *+$8	; $45DE
	addq.w #$4, SP	; $45E0
	bra.w $448C	; $45E2
CheckObstacle_Done:
	rts	; $45E6
	bsr.b *+$C	; $45E8
	bcc.w $448C	; $45EA
	rts	; $45EE
	move.w #$80, D2	; $45F0
CheckObstacle:
	move.w (ENT_X,A4), D1	; $45F4
	btst.b #$3, (ENT_Counter,A4)	; $45F8
	bne.b *+$8	; $45FE
	add.w (ENT_AttackRange,A4), D2	; $4600
	bra.b *+$A	; $4604
CheckObstacle_Neg:
	neg.w D2	; $4606
	add.w (ENT_AttackRange,A4), D2	; $4608
			dc.w	$c541	; dc.w
CheckObstacle_Sub:
	sub.w D2, D1	; $460E
	rts	; $4610
	move.w #$80, D2	; $4612
	movea.w (RAM_word_FFFFA11C).w, A2	; $4616
	move.w (ENT_X,A2), D1	; $461A
	sub.w (ENT_AttackRange,A4), D1	; $461E
	bcc.b *+$4	; $4622
	neg.w D1	; $4624
CheckObstacle_Compare:
	cmp.w D2, D1	; $4626
	rts	; $4628
	bsr.b *+$1C	; $462A
	bpl.b *+$4	; $462C
	bsr.b *+$58	; $462E
CheckObstacle_Found:
	bne.b *+$8	; $4630
	addq.w #$4, SP	; $4632
	bra.w $448C	; $4634
CheckObstacle_Found_Done:
	rts	; $4638
	bsr.b *+$C	; $463A
	bpl.b *+$4	; $463C
	bsr.b *+$48	; $463E
CheckObstacle2:
	beq.w $448C	; $4640
	rts	; $4644
CheckEntityState2:
	move.b (ENT_State,A4), D0	; $4646
	andi.b #-$76, D0	; $464A
	cmpi.b #-$7E, D0	; $464E
	beq.b *+$6	; $4652
	moveq #-$1, D0	; $4654
	rts	; $4656
CheckPlatformEdge:
	movea.w (ENT_Object,A4), A0	; $4658
	move.w (-$601E,A0), D0	; $465C
	tst.w (ENT_VelX,A4)	; $4660
	beq.b *+$1E	; $4664
	bmi.b *+$E	; $4666
	add.w (-$5F76,A0), D0	; $4668
	cmp.w (ENT_X,A4), D0	; $466C
	bcc.b *+$12	; $4670
	bra.b *+$C	; $4672
CheckPlatformEdge_Left:
	sub.w (-$5F76,A0), D0	; $4674
	cmp.w (ENT_X,A4), D0	; $4678
	bcs.b *+$6	; $467C
CheckPlatformEdge_No:
	moveq #$0, D0	; $467E
	rts	; $4680
CheckPlatformEdge_Yes:
	moveq #$1, D0	; $4682
	rts	; $4684
CheckCollisionAhead:
	moveq #$0, D6	; $4686
	move.b (ENT_ColW2,A4), D6	; $4688
	tst.w (ENT_VelX,A4)	; $468C
	bne.b *+$6	; $4690
	moveq #$1, D0	; $4692
	rts	; $4694
CheckCollisionAhead_X:
	bpl.b *+$4	; $4696
	neg.w D6	; $4698
CheckCollisionAhead_Scan:
	add.w (ENT_X,A4), D6	; $469A
	moveq #$0, D7	; $469E
	move.b (ENT_ColH2,A4), D7	; $46A0
	add.w (ENT_Y,A4), D7	; $46A4
	lsr.w #$4, D6	; $46A8
	andi.w #-$10, D7	; $46AA
	asl.w #$2, D7	; $46AE
	lea (-$68AC).w, A3	; $46B0
	jsr ReadTileData.w	; $46B4
	btst.l #$3, D2	; $46B8
	rts	; $46BC
	moveq #$0, D0	; $46BE
	move.w (ENT_MaxVelX,A4), D0	; $46C0
	lsr.w #$2, D0	; $46C4
	btst.b #$3, (ENT_Counter,A4)	; $46C6
	beq.b *+$4	; $46CC
	neg.w D0	; $46CE
ApplyTurnVelocity:
	move.w D0, (ENT_AccelX,A4)	; $46D0
	rts	; $46D4
UpdateHelperPos:
	jsr $B44.w	; $46D6
UpdateHelperPos2:
	jsr ReadTileAtEntityPos3.w	; $46DA
	jsr ReadTileAtEntityPos2.w	; $46DE
	btst.b #$0, (ENT_Flags,A4)	; $46E2
	beq.b *+$8	; $46E8
	jsr DrawHelperSprite.l	; $46EA
HelperUpdate_Jump:
	jmp MonsterMoveE.w	; $46F0
UpdateHelper:
	movea.w (RAM_word_FFFF9EEE).w, A2	; $46F4
	btst.b #$6, (RAM_word_FFFF9F03).w	; $46F8
	beq.b *+$6	; $46FE
	bsr.b *+$42	; $4700
	bra.b *+$14	; $4702
HelperUpdate_Check:
	bsr.b *+$26	; $4704
	bne.b *+$8	; $4706
	jsr $C36.w	; $4708
	bne.b *+$A	; $470C
HelperUpdate_Link:
	jsr $E64.w	; $470E
	jsr $D6E.w	; $4712
HelperUpdate_Link2:
	bsr.b *+$14	; $4716
	bne.b *+$8	; $4718
	jsr $C3E.w	; $471A
	bne.b *+$A	; $471E
HelperUpdate_Link3:
	jsr $D76.w	; $4720
	bra.w $4948	; $4724
HelperUpdate_Done:
	rts	; $4728
GetFacingDir:
	moveq #$0, D0	; $472A
	move.w (ENT_X,A2), D1	; $472C
	sub.w (ENT_X,A4), D1	; $4730
	bcc.b *+$4	; $4734
	moveq #$8, D0	; $4736
GetFacingDir_Calc:
	moveq #$8, D1	; $4738
	and.b (ENT_Counter,A4), D1	; $473A
	eor.b D1, D0	; $473E
	rts	; $4740
CheckHitPlayer:
	jsr $D2C.w	; $4742
	jsr $C36.w	; $4746
	tst.b (ENT_PlayerFlags,A4)	; $474A
	beq.b *+$28	; $474E
	move.w (ENT_X,A4), D0	; $4750
	sub.w (ENT_X,A2), D0	; $4754
	move.w (ENT_Y,A4), D1	; $4758
	sub.w (ENT_Y,A2), D1	; $475C
	jsr Atan2Fast1.w	; $4760
	rol.w #$3, D3	; $4764
	bset.b D3, (RAM_word_FFFF9F13).w	; $4766
	ori.b #-$80, (ENT_PlayerFlags,A4)	; $476A
	move.w #$0, (ENT_Damage,A4)	; $4770
CheckHitPlayer_Done:
	rts	; $4776
HelperHitCheck:
	movea.w (RAM_word_FFFF9EEE).w, A2	; $4778
	btst.b #$6, (RAM_word_FFFF9F03).w	; $477C
	beq.b *+$8	; $4782
	bsr.b $4742	; $4784
	bra.w $4948	; $4786
HitPlayer_No:
	jsr $E64.w	; $478A
	bra.w $4948	; $478E
HelperAttack:
	movea.w (RAM_word_FFFF9EEE).w, A2	; $4792
	btst.b #$6, (RAM_word_FFFF9F03).w	; $4796
	beq.b *+$6	; $479C
	bsr.b $4742	; $479E
	bra.b *+$6	; $47A0
HitPlayer_Link:
	jsr $E64.w	; $47A2
HitPlayer_Link2:
	jsr $D76.w	; $47A6
	bra.w $4948	; $47AA
HelperAttack2:
	movea.w (RAM_word_FFFF9EEE).w, A2	; $47AE
	btst.b #$6, (RAM_word_FFFF9F03).w	; $47B2
	beq.b *+$A	; $47B8
	bsr.w $4742	; $47BA
	bra.w $4948	; $47BE
HitPlayer_Alt:
	jsr $D2C.w	; $47C2
	bne.w $4948	; $47C6
	jsr $E64.w	; $47CA
	bra.w $4948	; $47CE
	st (RAM_word_FFFFA14A).w	; $47D2
	movea.w (RAM_word_FFFFA11A).w, A2	; $47D6
	moveq #$F, D2	; $47DA
	tst.b (ENT_Flags,A2)	; $47DC
	bpl.b *+$2C	; $47E0
	cmpi.b #$2, (ENT_HPTimer,A2)	; $47E2
	bhi.b *+$24	; $47E8
	beq.b *+$A	; $47EA
	btst.b #$6, (ENT_Flags,A2)	; $47EC
	bne.b *+$8	; $47F2
IdleAnim_Next:
	clr.w (ENT_Flags,A2)	; $47F4
	bra.b *+$14	; $47F8
IdleAnim_Set:
	moveq #$7F, D0	; $47FA
	and.b (ENT_Anim,A2), D0	; $47FC
	cmpi.b #$1, D0	; $4800
	beq.b *+$8	; $4804
	move.b #$1, (ENT_Anim,A2)	; $4806
IdleAnim_Next2:
	addq.w #$4, A2	; $480C
	dbf D2, $47DC	; $480E
	rts	; $4812
KillEntity:
	clr.w (ENT_Flags,A4)	; $4814
	move.w (-$2B00,A4), D0	; $4818
	bmi.b *+$E	; $481C
	movea.w D0, A0	; $481E
	tst.b (-$5DB4,A0)	; $4820
	bmi.b *+$6	; $4824
	addq.b #$1, (-$5DB1,A0)	; $4826
IdleAnim_Done:
	rts	; $482A
	addq.w #$1, (RAM_word_FFFFA148).w	; $482C
	move.w (-$2B00,A4), D0	; $4830
	bmi.b *+$6A	; $4834
	movea.w D0, A3	; $4836
	move.b (-$5DB2,A3), D0	; $4838
	addq.b #$1, D0	; $483C
	move.b D0, (-$5DB2,A3)	; $483E
	cmp.b (-$5DB4,A3), D0	; $4842
	bne.b *+$24	; $4846
	move.b (-$5CC1,A3), D0	; $4848
	tst.b (-$5CC2,A3)	; $484C
	bmi.b *+$12	; $4850
	bne.b *+$C	; $4852
	jsr GetMonsterFlagAddr2.w	; $4854
	bset.b D0, ($0,A0,D1.w)	; $4858
	bra.b *+$6	; $485C
KillEntity_ClearFlag:
	jsr SetMonsterFlag.w	; $485E
KillEntity_Reward:
	moveq #$0, D0	; $4862
	move.w (-$5CC4,A3), D0	; $4864
	bpl.b *+$3C	; $4868
KillEntity_Drop:
	tst.b (RAM_word_FFFFA14A).w	; $486A
	bmi.b *+$30	; $486E
	lea ($1C170).l, A0	; $4870
	moveq #$0, D1	; $4876
	move.b (ENT_HP,A4), D1	; $4878
	add.w D1, D1	; $487C
	adda.w D1, A0	; $487E
	jsr $5D8.w	; $4880
	moveq #$2, D1	; $4884
	lsr.w #$1, D0	; $4886
	bcs.b *+$C	; $4888
	lsr.w #$1, D0	; $488A
	bcs.b *+$8	; $488C
	addq.w #$1, A0	; $488E
	dbf D1, $4886	; $4890
KillEntity_DropItem:
	moveq #$0, D0	; $4894
	move.b (A0), D0	; $4896
	cmpi.b #-$1, D0	; $4898
	bne.b *+$E	; $489C
KillEntity_Done:
	clr.w (ENT_Flags,A4)	; $489E
	rts	; $48A2
KillEntity_NoDrop:
	cmpi.w #$FE, D0	; $48A4
	beq.b $489E	; $48A8
KillEntity_SpawnDrop:
	tst.b D0	; $48AA
	bpl.b *+$6	; $48AC
	addi.w #$F80, D0	; $48AE
KillEntity_Item:
	clr.b (-$27FF,A4)	; $48B2
	move.w (ENT_X,A4), D1	; $48B6
	move.w (ENT_Y,A4), D2	; $48BA
	jmp SpawnPickup.l	; $48BE
	btst.b #$0, (ENT_Flags,A4)	; $48C4
	bne.b $490E	; $48CA
	btst.b #$0, (-$3200,A4)	; $48CC
	bne.b $490E	; $48D2
	btst.b #$5, (RAM_word_FFFF966B).w	; $48D4
	bne.b $490E	; $48DA
	moveq #$6, D0	; $48DC
	and.b (-$3200,A4), D0	; $48DE
	beq.b *+$6	; $48E2
	subq.b #$6, D0	; $48E4
	bne.b $4902	; $48E6
IdleCheck_Scan2:
	moveq #$40, D2	; $48E8
	move.w (ENT_X,A4), D0	; $48EA
	jsr $BD0.w	; $48EE
	bmi.b $4908	; $48F2
	moveq #$30, D2	; $48F4
	move.w (ENT_Y,A4), D0	; $48F6
	jsr $BFE.w	; $48FA
	bmi.b $4908	; $48FE
