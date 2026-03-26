; ROM range: 0x0088C2-0x008C33
; Magic-menu status gauge, spell-bar refill helpers, tile upload tables, and the follow-on
; layout-width synthesis used by the same panel owner in `engine_menu_core.asm`.

MagicMenuStatusGaugeLargeScaleBundle_0088C2:
	dc.w	$000F
	dc.l	$FFE0FFF0
	dc.l	SelectMagicMenuStatusGaugeLargeScale_00893C

MagicMenuStatusGaugeSmallScaleBundle_0088CC:
	dc.w	$007F
	dc.l	$1F801F80
	dc.l	SelectMagicMenuStatusGaugeSmallScale_008950

DrawMagicMenuStatusGaugeRows_0088D6:
	move.w	#$0204,d7
	moveq	#MagicMenuStatusGaugeHeightRows-1,d5
	lea	(VDP_DATA_PORT).l,a0

DrawMagicMenuStatusGaugeRows_NextRow_0088E2:
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.w	d5,d6
	add.w	d6,d6
	move.w	(MagicMenuStatusGaugeFilledTileCount_Short).w,d0
	move.w	(MagicMenuStatusGaugeBodyTileCount_Short).w,d1

DrawMagicMenuStatusGaugeRows_WriteFilledTiles_0088F2:
	tst.w	d0
	beq.s	DrawMagicMenuStatusGaugeRows_CheckPartialTile_008900
	move.w	(a1,d6.w),(a0)
	subq.w	#$1,d0
	subq.w	#$1,d1
	bra.s	DrawMagicMenuStatusGaugeRows_WriteFilledTiles_0088F2

DrawMagicMenuStatusGaugeRows_CheckPartialTile_008900:
	tst.w	d2
	beq.s	DrawMagicMenuStatusGaugeRows_WriteBodyTiles_00890A
	move.w	(a2,d6.w),(a0)
	subq.w	#$1,d1

DrawMagicMenuStatusGaugeRows_WriteBodyTiles_00890A:
	tst.w	d1
	beq.s	DrawMagicMenuStatusGaugeRows_CheckTailPadding_008916
	subq.w	#$1,d1
	move.w	(a3,d6.w),(a0)
	bra.s	DrawMagicMenuStatusGaugeRows_WriteBodyTiles_00890A

DrawMagicMenuStatusGaugeRows_CheckTailPadding_008916:
	move.w	(MagicMenuStatusGaugeTailPadTileCount_Short).w,d0

DrawMagicMenuStatusGaugeRows_TestTailPadding_00891A:
	tst.w	d0
	beq.w	DrawMagicMenuStatusGaugeRows_AdvanceRow_008928

DrawMagicMenuStatusGaugeRows_WriteTailPadding_008920:
	subq.w	#$1,d0
	move.w	MagicMenuStatusGaugeTailTileTable_008936(pc,d6.w),(a0)
	bra.s	DrawMagicMenuStatusGaugeRows_TestTailPadding_00891A

DrawMagicMenuStatusGaugeRows_AdvanceRow_008928:
	addq.w	#$1,d7
	dbra	d5,DrawMagicMenuStatusGaugeRows_NextRow_0088E2
	move.w	#MagicMenuStatusGaugeAnimationTicks,(MagicMenuStatusGaugeAnimationCountdown_Short).w
	rts

MagicMenuStatusGaugeTailTileTable_008936:
	dc.w	$97B6,$8020,$87B6

SelectMagicMenuStatusGaugeLargeScale_00893C:
	lea	MagicMenuStatusGaugeLargeScaleFilledTileTable_00898E(pc),a1
	lea	MagicMenuStatusGaugeLargeScalePartialTileTable_00899A(pc),a2
	lea	MagicMenuStatusGaugeLargeScaleBodyTileTable_0089A6(pc),a3
	lea	MagicMenuStatusGaugeLargeScaleRemainderStep_0089B2(pc),a0
	moveq	#MagicMenuStatusGaugeAlternatePageShift,d2
	bra.s	SelectMagicMenuStatusGauge_008962

SelectMagicMenuStatusGaugeSmallScale_008950:
	lea	MagicMenuStatusGaugeSmallScaleFilledTileTable_008994(pc),a1
	lea	MagicMenuStatusGaugeSmallScalePartialTileTable_0089A0(pc),a2
	lea	MagicMenuStatusGaugeSmallScaleBodyTileTable_0089AC(pc),a3
	lea	MagicMenuStatusGaugeSmallScaleRemainderStep_0089B4(pc),a0
	moveq	#MagicMenuStatusGaugePageShift,d2

SelectMagicMenuStatusGauge_008962:
	move.w	(MagicMenuStatusGaugePackedValue_Short).w,d0
	lsr.w	d2,d0
	move.w	d0,(MagicMenuStatusGaugeBodyTileCount_Short).w
	move.w	#MagicMenuStatusGaugeMaxWidth,d4
	sub.w	d0,d4
	move.w	d4,(MagicMenuStatusGaugeTailPadTileCount_Short).w
	move.w	(MagicMenuStatusGaugeRemainderValue_Short).w,d2
	moveq	#$00,d1

SelectMagicMenuStatusGauge_CountFilledTiles_00897C:
	sub.w	(a0),d2
	bcs.s	SelectMagicMenuStatusGauge_StoreFillCounts_008984
	addq.w	#$1,d1
	bra.s	SelectMagicMenuStatusGauge_CountFilledTiles_00897C

SelectMagicMenuStatusGauge_StoreFillCounts_008984:
	move.w	d1,(MagicMenuStatusGaugeFilledTileCount_Short).w
	add.w	(a0),d2
	bra.w	DrawMagicMenuStatusGaugeRows_0088D6

MagicMenuStatusGaugeLargeScaleFilledTileTable_00898E:
	dc.w	$97B6,$87B2,$87B6

MagicMenuStatusGaugeSmallScaleFilledTileTable_008994:
	dc.w	$979D,$879A,$879D

MagicMenuStatusGaugeLargeScalePartialTileTable_00899A:
	dc.w	$97B6,$87B3,$87B6

MagicMenuStatusGaugeSmallScalePartialTileTable_0089A0:
	dc.w	$979E,$879B,$879E

MagicMenuStatusGaugeLargeScaleBodyTileTable_0089A6:
	dc.w	$97B6,$87B4,$87B6

MagicMenuStatusGaugeSmallScaleBodyTileTable_0089AC:
	dc.w	$979F,$879C,$879F

MagicMenuStatusGaugeLargeScaleRemainderStep_0089B2:
	dc.w	$0020

MagicMenuStatusGaugeSmallScaleRemainderStep_0089B4:
	dc.w	$0100

AdvanceMagicMenuStatusGaugeAnimation_0089B6:
	lea	(VDP_DATA_PORT).l,a0
	lea	MagicMenuStatusGaugeAnimationRowFillLongs_0089EC.l,a1
	lea	MagicMenuStatusGaugeAnimationRowEdgeTiles_0089F8.l,a2
	move.w	#$0104,d7
	moveq	#MagicMenuStatusGaugeHeightRows-1,d2

AdvanceMagicMenuStatusGaugeAnimation_NextRow_0089CE:
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.w	(a2)+,(a0)
	move.l	(a1)+,d4
	moveq	#MagicMenuStatusGaugeTileRowWidth-1,d3

AdvanceMagicMenuStatusGaugeAnimation_FillRow_0089D8:
	move.l	d4,(a0)
	dbra	d3,AdvanceMagicMenuStatusGaugeAnimation_FillRow_0089D8
	move.w	(a2)+,(a0)
	addq.w	#$1,d7
	dbra	d2,AdvanceMagicMenuStatusGaugeAnimation_NextRow_0089CE
	clr.l	(MagicMenuStatusGaugePackedValue_Short).w
	rts

MagicMenuStatusGaugeAnimationRowFillLongs_0089EC:
	dc.l	$87B687B6
	dc.l	$80208020
	dc.l	$97B697B6

MagicMenuStatusGaugeAnimationRowEdgeTiles_0089F8:
	dc.w	$878F,$8F8F,$878E,$8F8E,$978F,$9F8F

UpdateMagicMenuSpellBarFillAndCapacity_008A04:
	movea.w	d0,a0
	move.b	-$6A42(a0),d1
	move.b	d1,d2
	add.b	MagicSpellBarGrowthBaseTable_008A34(pc,a0.l),d1
	cmpi.w	#MagicSpellCount-1,d0
	bcs.s	UpdateMagicMenuSpellBarFillAndCapacity_ClampGrowth_008A1A
	moveq	#$01,d1
	bra.s	UpdateMagicMenuSpellBarFillAndCapacity_StoreDelta_008A22

UpdateMagicMenuSpellBarFillAndCapacity_ClampGrowth_008A1A:
	cmpi.b	#MagicMenuStatusGaugeMaxFillValue,d1
	bcs.s	UpdateMagicMenuSpellBarFillAndCapacity_StoreDelta_008A22
	moveq	#MagicMenuStatusGaugeMaxFillValue,d1

UpdateMagicMenuSpellBarFillAndCapacity_StoreDelta_008A22:
	move.b	d1,d3
	sub.b	d2,d3
	move.b	d3,(MagicMenuSpellBarFillDeltaScratch_Short).w
	move.b	d1,-$6A42(a0)
	add.b	d3,-$6A48(a0)
	rts

MagicSpellBarGrowthBaseTable_008A34:
	dc.b	$03,$03,$03,$02,$02,$01

TryAdvanceMagicMenuSpellBarFill_008A3A:
	move.b	(MagicMenuStatusValue0_Short).w,d0
	bmi.s	TryAdvanceMagicMenuSpellBarFill_CheckSecondSlot_008A46
	cmpi.b	#MagicMenuStatusGaugePageSelectionCutoff,d0
	bcs.s	TryAdvanceMagicMenuSpellBarFill_UpdateSlot_008A52

TryAdvanceMagicMenuSpellBarFill_CheckSecondSlot_008A46:
	move.b	(MagicMenuStatusValue1_Short).w,d0
	bmi.s	TryAdvanceMagicMenuSpellBarFill_CheckAllSpellBars_008A60
	cmpi.b	#MagicMenuStatusGaugePageSelectionCutoff,d0
	bcc.s	TryAdvanceMagicMenuSpellBarFill_CheckAllSpellBars_008A60

TryAdvanceMagicMenuSpellBarFill_UpdateSlot_008A52:
	movea.w	d0,a0
	move.b	-$6A48(a0),d1
	move.b	-$6A42(a0),d2
	bsr.s	TryIncreaseMagicMenuSpellBarFill_008A88
	bmi.s	TryAdvanceMagicMenuSpellBarFill_Return_008A86

TryAdvanceMagicMenuSpellBarFill_CheckAllSpellBars_008A60:
	moveq	#$00,d0

TryAdvanceMagicMenuSpellBarFill_CheckSpellBar_008A62:
	movea.w	d0,a0
	move.b	-$6A48(a0),d1
	move.b	-$6A42(a0),d2
	beq.s	TryAdvanceMagicMenuSpellBarFill_NextSpellBar_008A7E
	cmp.b	d1,d2
	beq.s	TryAdvanceMagicMenuSpellBarFill_NextSpellBar_008A7E
	bra.s	TryAdvanceMagicMenuSpellBarFill_RestoreBaseAndGrow_008A7C

TryAdvanceMagicMenuSpellBarFill_ReloadGrowthBase_008A74:
	move.b	MagicSpellBarGrowthBaseTable_008A34(pc,a0.l),d2
	move.b	d2,-$6A42(a0)

TryAdvanceMagicMenuSpellBarFill_RestoreBaseAndGrow_008A7C:
	bra.s	TryIncreaseMagicMenuSpellBarFill_008A88

TryAdvanceMagicMenuSpellBarFill_NextSpellBar_008A7E:
	addq.w	#$1,d0
	cmpi.w	#MagicSpellCount,d0
	bcs.s	TryAdvanceMagicMenuSpellBarFill_CheckSpellBar_008A62

TryAdvanceMagicMenuSpellBarFill_Return_008A86:
	rts

TryIncreaseMagicMenuSpellBarFill_008A88:
	add.b	MagicSpellBarGrowthStepTable_008A9C(pc,a0.l),d1
	cmp.b	d1,d2
	bcs.s	TryIncreaseMagicMenuSpellBarFill_Fail_008A98
	move.b	d1,-$6A48(a0)
	moveq	#-1,d3
	rts

TryIncreaseMagicMenuSpellBarFill_Fail_008A98:
	moveq	#$00,d3
	rts

MagicSpellBarGrowthStepTable_008A9C:
	dc.b	$01,$01,$01,$01,$01,$01

BuildMagicMenuStatusGaugeTileIdBuffer_008AA2:
	movea.w	(MagicMenuStatusGaugeSourcePointer_Short).w,a4
	move.b	-$2600(a4),d0
	move.b	-$25FF(a4),d1
	lsr.b	#$6,d1
	beq.s	BuildMagicMenuStatusGaugeTileIdBuffer_InitCounters_008AB4
	addq.b	#$1,d0

BuildMagicMenuStatusGaugeTileIdBuffer_InitCounters_008AB4:
	moveq	#$00,d3
	moveq	#$00,d4
	move.b	d0,d2
	cmpi.b	#MagicMenuStatusGaugePageSelectionCutoff,d0
	bls.s	BuildMagicMenuStatusGaugeTileIdBuffer_AccumulateFilledCount_008AD0
	subq.b	#MagicMenuStatusGaugePageSelectionCutoff,d0
	move.b	d0,d3
	move.b	d0,d4
	addq.b	#$1,d4
	add.b	d0,d0
	addq.b	#$1,d0
	exg	d0,d2
	sub.b	d2,d0

BuildMagicMenuStatusGaugeTileIdBuffer_AccumulateFilledCount_008AD0:
	add.b	d0,d4
	tst.b	d1
	beq.s	BuildMagicMenuStatusGaugeTileIdBuffer_FillLeadingTiles_008AD8
	subq.b	#$1,d0

BuildMagicMenuStatusGaugeTileIdBuffer_FillLeadingTiles_008AD8:
	lea	(MagicMenuStatusGaugeTileIdBuffer_Short).w,a0
	tst.b	d3
	beq.s	BuildMagicMenuStatusGaugeTileIdBuffer_FillCenterTiles_008AF2
	move.b	#$18,(a0)+
	bra.s	BuildMagicMenuStatusGaugeTileIdBuffer_FillLeadingLoop_008AEA

BuildMagicMenuStatusGaugeTileIdBuffer_FillLeadingTileAlt_008AE6:
	move.b	#$1C,(a0)+

BuildMagicMenuStatusGaugeTileIdBuffer_FillLeadingLoop_008AEA:
	subq.b	#$1,d3
	bne.s	BuildMagicMenuStatusGaugeTileIdBuffer_FillLeadingTileAlt_008AE6
	move.b	#$20,(a0)+

BuildMagicMenuStatusGaugeTileIdBuffer_FillCenterTiles_008AF2:
	tst.b	d0
	beq.s	BuildMagicMenuStatusGaugeTileIdBuffer_WriteRemainderTile_008AFE

BuildMagicMenuStatusGaugeTileIdBuffer_FillCenterLoop_008AF6:
	move.b	#$14,(a0)+
	subq.b	#$1,d0
	bne.s	BuildMagicMenuStatusGaugeTileIdBuffer_FillCenterLoop_008AF6

BuildMagicMenuStatusGaugeTileIdBuffer_WriteRemainderTile_008AFE:
	tst.b	d1
	beq.s	BuildMagicMenuStatusGaugeTileIdBuffer_FillPlayerLevelTiles_008B08
	lsl.b	#$2,d1
	addq.b	#$4,d1
	move.b	d1,(a0)+

BuildMagicMenuStatusGaugeTileIdBuffer_FillPlayerLevelTiles_008B08:
	move.b	(PlayerLevel_Short).w,d0
	cmpi.b	#MagicMenuStatusGaugePageSelectionCutoff,d0
	bls.s	BuildMagicMenuStatusGaugeTileIdBuffer_SubtractUsedTiles_008B14
	moveq	#MagicMenuStatusGaugePageSelectionCutoff,d0

BuildMagicMenuStatusGaugeTileIdBuffer_SubtractUsedTiles_008B14:
	sub.b	d4,d0
	bls.s	BuildMagicMenuStatusGaugeTileIdBuffer_PadBuffer_008B22
	add.b	d0,d4

BuildMagicMenuStatusGaugeTileIdBuffer_FillPlayerLevelLoop_008B1A:
	move.b	#$04,(a0)+
	subq.b	#$1,d0
	bne.s	BuildMagicMenuStatusGaugeTileIdBuffer_FillPlayerLevelLoop_008B1A

BuildMagicMenuStatusGaugeTileIdBuffer_PadBuffer_008B22:
	subq.b	#MagicMenuStatusGaugeTileRowWidth,d4
	bcc.s	UploadMagicMenuStatusGaugeTileRows_008B2E
	neg.b	d4

BuildMagicMenuStatusGaugeTileIdBuffer_PadLoop_008B28:
	clr.b	(a0)+
	subq.b	#$1,d4
	bne.s	BuildMagicMenuStatusGaugeTileIdBuffer_PadLoop_008B28

UploadMagicMenuStatusGaugeTileRows_008B2E:
	lea	(VDP_DATA_PORT).l,a3
	move.l	#$58440003,$0004(a3)
	lea	MagicMenuStatusGaugeUpperTileLongLookup_008B62(pc),a1
	bsr.s	UploadMagicMenuStatusGaugeTileRow_008B4E
	move.l	#$58840003,$0004(a3)
	lea	MagicMenuStatusGaugeLowerTileLongLookup_008B86(pc),a1

UploadMagicMenuStatusGaugeTileRow_008B4E:
	lea	(MagicMenuStatusGaugeTileIdBuffer_Short).w,a2
	moveq	#MagicMenuStatusGaugeTileRowWidth-1,d1
	moveq	#$00,d0

UploadMagicMenuStatusGaugeTileRow_Loop_008B56:
	move.b	(a2)+,d0
	move.l	(a1,d0.w),(a3)
	dbra	d1,UploadMagicMenuStatusGaugeTileRow_Loop_008B56
	rts

MagicMenuStatusGaugeUpperTileLongLookup_008B62:
	dc.l	$80208020
	dc.l	$87808784
	dc.l	$87818784
	dc.l	$87828784
	dc.l	$87828785
	dc.l	$87828783
	dc.l	$87828782
	dc.l	$87828782
	dc.l	$87828783

MagicMenuStatusGaugeLowerTileLongLookup_008B86:
	dc.l	$80208020
	dc.l	$87908F90
	dc.l	$87918F90
	dc.l	$87928F90
	dc.l	$87928795
	dc.l	$87928F92
	dc.l	$87928793
	dc.l	$87938793
	dc.l	$87938F92

PlayInventoryMenuConfirmSound_008BAA:
	moveq	#$26,d0
	jmp	(RunTaskHelper_0366).w

PlayInventoryMenuMoveSound_008BB0:
	moveq	#$25,d0
	jmp	(RunTaskHelper_0366).w

UpdateMagicMenuStatusLayoutWidths_008BB6:
	andi.b	#$DF,(MagicMenuStatusLayoutFlags_Short).w
	move.w	#$0060,(MagicMenuStatusGaugeWidthSlot0_Short).w
	move.w	#$0080,(MagicMenuStatusGaugeWidthSlot1_Short).w
	btst	#MagicMenuStatusLayoutLockedBit,(MagicMenuStatusLayoutFlags_Short).w
	bne.s	UpdateMagicMenuStatusLayoutWidths_Return_008C1C
	lea	(MagicMenuStatusSelectionScratchBuffer_Short).w,a0
	move.b	(a0),d5
	moveq	#$00,d2
	move.w	d2,(MagicMenuStatusGaugeWidthSlot1_Short).w

UpdateMagicMenuStatusLayoutWidths_NextSelection_008BDC:
	moveq	#$00,d0
	move.b	(a0)+,d0
	bmi.s	UpdateMagicMenuStatusLayoutWidths_AdvanceOffset_008C06
	add.w	d2,d0
	moveq	#$00,d3
	move.b	MagicMenuStatusWidthLookupTable_008C1E(pc,d0.w),d3
	lsl.w	#$4,d3
	tst.w	d2
	bne.s	UpdateMagicMenuStatusLayoutWidths_AccumulateSlot1_008BF6
	move.w	d3,(MagicMenuStatusGaugeWidthSlot0_Short).w
	bra.s	UpdateMagicMenuStatusLayoutWidths_AdvanceOffset_008C06

UpdateMagicMenuStatusLayoutWidths_AccumulateSlot1_008BF6:
	cmpi.b	#MagicMenuSpellPageStateSelector-1,d5
	bcs.s	UpdateMagicMenuStatusLayoutWidths_AddWidth_008C02
	cmpi.w	#$000E,d2
	beq.s	UpdateMagicMenuStatusLayoutWidths_CheckPageFlag_008C0E

UpdateMagicMenuStatusLayoutWidths_AddWidth_008C02:
	add.w	d3,(MagicMenuStatusGaugeWidthSlot1_Short).w

UpdateMagicMenuStatusLayoutWidths_AdvanceOffset_008C06:
	addq.w	#MagicMenuStatusGaugeSelectionValueOffset-3,d2
	cmpi.w	#$0015,d2
	bne.s	UpdateMagicMenuStatusLayoutWidths_NextSelection_008BDC

UpdateMagicMenuStatusLayoutWidths_CheckPageFlag_008C0E:
	cmpi.b	#MagicMenuSpellPageStateSelector,(MagicMenuStatusSelectionScratchBuffer_Short).w
	bne.s	UpdateMagicMenuStatusLayoutWidths_Return_008C1C
	ori.b	#$20,(MagicMenuStatusLayoutFlags_Short).w

UpdateMagicMenuStatusLayoutWidths_Return_008C1C:
	rts

MagicMenuStatusWidthLookupTable_008C1E:
	dc.b	$20,$10,$08,$02,$18,$08,$04,$0C,$0A,$08,$06
	dc.b	$04,$02,$01,$07,$06,$05,$04,$03,$02,$01,$00
