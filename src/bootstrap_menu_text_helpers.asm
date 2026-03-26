; ROM range: 0x001E20-0x00210F
; Recovered bootstrap menu-text helper island: one leading word, an adjacent longword
; value table, the mixed text/control string expander used by the inventory/shop UI,
; found-item / found-gold message builders, and a small follow-on metric/upload block.
; This is real decoded code/data pulled out of `init_000200_004b57.bin`, not a comment-only
; note. The longword table at 0x001E22 is a concrete source-owned candidate price/fee table.

MenuTextNumericPreludeWord_001E20:
	dc.w	$0032

MenuTextNumericValueTable_001E22:
	; Candidate service/item price values consumed by the same menu-text helper family.
	; Includes the proven 500000 value that matches the Charmstone quiz answer.
	dc.l	$0000001E
	dc.l	$00000014
	dc.l	$00001388
	dc.l	$000001F4
	dc.l	$000001F4
	dc.l	$000001F4
	dc.l	$000001F4
	dc.l	$000001F4
	dc.l	$000001F4
	dc.l	$00000064
	dc.l	$0001E240
	dc.l	$000009C4
	dc.l	$0007A120
	dc.l	$00000BB8
	dc.l	$0000000A
	dc.l	$00000032
	dc.l	$000000C8
	dc.l	$00001388

BuildInventoryMenuEntryTileRows_001E6A:
	clr.w	(InventoryMenuNestedTextStreamStackOffset_Short).w
	clr.w	(InventoryMenuEntryTextWidth_Short).w
	lea	(InventoryMenuEntryTileRow0Buffer_Short).w,a3
	moveq	#$0D,d3
	bsr.w	ResolveMenuTextControlStream_001ED0

BuildInventoryMenuEntryTileRows_NextByte_001E7C:
	move.b	(a2)+,d3
	bne.s	BuildInventoryMenuEntryTileRows_CheckControlFamily_001E92
	move.w	(InventoryMenuNestedTextStreamStackOffset_Short).w,d0
	bne.s	BuildInventoryMenuEntryTileRows_PopNestedStream_001E88
	rts

BuildInventoryMenuEntryTileRows_PopNestedStream_001E88:
	subq.w	#$4,d0
	movea.w	d0,a0
	movea.l	-$7300(a0),a2
	bra.s	BuildInventoryMenuEntryTileRows_NextByte_001E7C

BuildInventoryMenuEntryTileRows_CheckControlFamily_001E92:
	cmpi.b	#$10,d3
	bcc.s	BuildInventoryMenuEntryTileRows_StoreGlyph_001EB4
	cmpi.b	#$0C,d3
	dc.b	$65,$00,$FF,$FE

BuildInventoryMenuEntryTileRows_PushNestedStream_001EA0:
	move.b	(a2)+,d0
	movea.w	(InventoryMenuNestedTextStreamStackOffset_Short).w,a0
	move.l	a2,-$7300(a0)
	addq.w	#$4,a0
	move.w	a0,(InventoryMenuNestedTextStreamStackOffset_Short).w
	bsr.s	ResolveMenuTextControlStream_001ED0
	bra.s	BuildInventoryMenuEntryTileRows_NextByte_001E7C

BuildInventoryMenuEntryTileRows_StoreGlyph_001EB4:
	moveq	#$20,d2
	cmpi.b	#$FE,d3
	bcs.s	BuildInventoryMenuEntryTileRows_WriteGlyph_001EC4
	subi.b	#$40,d3
	move.b	d3,d2
	move.b	(a2)+,d3

BuildInventoryMenuEntryTileRows_WriteGlyph_001EC4:
	move.b	d3,$10(a3)
	move.b	d2,(a3)+
	addq.w	#$1,(InventoryMenuEntryTextWidth_Short).w
	bra.s	BuildInventoryMenuEntryTileRows_NextByte_001E7C

ResolveMenuTextControlStream_001ED0:
	andi.w	#$0003,d3
	lsl.w	#$2,d3
	movea.l	(MenuTextRootPointerTable_01CC10).l,a2
	movea.l	(a2,d3.w),a2
	andi.w	#$00FF,d0
	add.w	d0,d0
	adda.w	(a2,d0.w),a2
	rts

BuildFoundItemTextBuffer_001EEC:
	bsr.w	BuildInventoryMenuEntryTileRows_001E6A
	bsr.w	InitializeMenuTextOutputFrame_001FAC
	move.w	(InventoryMenuEntryTextWidth_Short).w,d0
	addi.w	#$0006,d0
	moveq	#$1C,d1
	sub.w	d0,d1
	andi.w	#$FFFE,d1
	lea	(MenuTextOutputFrameBuffer_Short).w,a2
	adda.w	d1,a2
	move.w	#$8020,d1
	move.w	d1,d0
	lea	MenuTextLiteral_FoundThe_001FE6(pc),a0
	bsr.w	AppendMenuTextLiteralToBuffer_001F8E
	lea	(InventoryMenuEntryTileRow0Buffer_Short).w,a0
	move.w	#$A000,d0
	move.w	(InventoryMenuEntryTextWidth_Short).w,d1
	beq.s	BuildFoundItemTextBuffer_Suffix_001F36

BuildFoundItemTextBuffer_CopyExpandedText_001F26:
	move.b	$10(a0),d0
	move.w	d0,$40(a2)
	move.b	(a0)+,d0
	move.w	d0,(a2)+
	subq.w	#$1,d1
	bne.s	BuildFoundItemTextBuffer_CopyExpandedText_001F26

BuildFoundItemTextBuffer_Suffix_001F36:
	move.w	#$8020,d1
	move.w	d1,d0
	lea	MenuTextLiteral_Period_001FFF(pc),a0
	bsr.w	AppendMenuTextLiteralToBuffer_001F8E
	rts

FormatFoundGoldTextBuffer_001F46:
	link	a6,#-$0C
	bsr.s	InitializeMenuTextOutputFrame_001FAC
	move.l	d0,d1
	lea	-$2(a6),a1
	movea.l	a1,a0
	bsr.w	$183E
	suba.l	a1,a0
	move.w	a0,d0
	addi.w	#$0005,d0
	moveq	#$1A,d1
	sub.w	d0,d1
	andi.w	#$FFFE,d1
	lea	(MenuTextOutputFrameBuffer_Short).w,a2
	adda.w	d1,a2
	move.w	#$8020,d1
	move.w	d1,d0
	lea	MenuTextLiteral_Found_001FF1(pc),a0
	bsr.w	AppendMenuTextLiteralToBuffer_001F8E
	movea.l	a1,a0
	bsr.w	AppendMenuTextLiteralToBuffer_001F8E
	lea	MenuTextLiteral_GoldSuffix_001FF8(pc),a0
	bsr.w	AppendMenuTextLiteralToBuffer_001F8E
	unlk	a6
	rts

AppendMenuTextLiteralToBuffer_001F8E:
	move.w	d1,d2

AppendMenuTextLiteralToBuffer_NextByte_001F90:
	move.b	(a0)+,d0
	beq.s	AppendMenuTextLiteralToBuffer_Return_001FAA
	cmpi.b	#$FE,d0
	bcs.s	AppendMenuTextLiteralToBuffer_WriteByte_001FA2
	move.b	d0,d2
	subi.b	#$40,d2
	bra.s	AppendMenuTextLiteralToBuffer_NextByte_001F90

AppendMenuTextLiteralToBuffer_WriteByte_001FA2:
	move.w	d0,$40(a2)
	move.w	d2,(a2)+
	bra.s	AppendMenuTextLiteralToBuffer_001F8E

AppendMenuTextLiteralToBuffer_Return_001FAA:
	rts

InitializeMenuTextOutputFrame_001FAC:
	lea	(MenuTextOutputFrameBuffer_Short).w,a0
	move.w	#$8020,d2
	move.w	#$87A1,d3
	dc.b	$61,$00,$00,$02	; bsr.w InitializeMenuTextOutputFrame_Fill_001FBC

InitializeMenuTextOutputFrame_Fill_001FBC:
	move.w	d3,(a0)+
	moveq	#$1D,d1

InitializeMenuTextOutputFrame_FillLoop_001FC0:
	move.w	d2,(a0)+
	dbra	d1,InitializeMenuTextOutputFrame_FillLoop_001FC0
	move.w	d3,(a0)+
	rts

ShowFoundGoldText_001FCA:
	bsr.w	FormatFoundGoldTextBuffer_001F46
	bra.s	UploadFoundTextBuffer_001FD4

ShowFoundItemText_001FD0:
	bsr.w	BuildFoundItemTextBuffer_001EEC

UploadFoundTextBuffer_001FD4:
	lea	(MenuTextOutputFrameBuffer_Short).w,a0
	jsr	($7EEE).l
	move.w	#$003C,(MenuTextDisplayTimeout_Short).w
	rts

MenuTextLiteral_FoundThe_001FE6:
	dc.b	"Found the ",$00

MenuTextLiteral_Found_001FF1:
	dc.b	"Found ",$00

MenuTextLiteral_GoldSuffix_001FF8:
	dc.b	" GOLD.",$00

MenuTextLiteral_Period_001FFF:
	dc.b	".",$00

	dc.b	$00

LoadMenuTextMetricTuple_002002:
	jsr	($276C).w
	moveq	#$00,d0
	move.b	(a1)+,d0
	subq.w	#$1,d0
	move.w	d0,(MenuTextMetricBaseX_Short).w
	move.w	d0,(MenuTextMetricCursorX_Short).w
	moveq	#$00,d0
	move.b	(a1)+,d0
	add.w	d0,d0
	subq.w	#$1,d0
	move.w	d0,(MenuTextMetricBaseY_Short).w
	move.w	d0,(MenuTextMetricCursorY_Short).w
	moveq	#$00,d0
	move.b	(a1)+,d0
	move.w	d0,(MenuTextMetricWidth_Short).w
	move.b	(a1)+,d0
	move.w	d0,(MenuTextMetricHeight_Short).w
	move.b	#$80,(MenuTextMetricFlags_Short).w
	rts

NormalizeMenuTextMetricValue_00203A:
	tst.b	(MenuTextMetricNormalizeFlag_Short).w
	beq.s	NormalizeMenuTextMetricValue_Return_00204E
	moveq	#$00,d1
	move.b	d0,d1
	lsl.w	#$2,d1
	add.w	d0,d1
	exg	d0,d1
	moveq	#$06,d1
	divu	d1,d0

NormalizeMenuTextMetricValue_Return_00204E:
	rts

UploadMenuTextBufferRect_002050:
	move.w	d7,d1
	add.w	(MenuTextMetricCursorY_Short).w,d1
	andi.w	#$001F,d1
	lsl.w	#$6,d1
	move.w	d6,d2
	add.w	(MenuTextMetricCursorX_Short).w,d2
	andi.w	#$003F,d2
	add.w	d2,d1
	add.w	d1,d1
	ori.w	#$4000,d1
	swap	d1
	move.w	#$0003,d1
	move.l	d1,($C00004).l
	move.w	d0,($C00000).l
	rts

CopyMenuTextBufferRect_002082:
	move.l	a2,-(sp)
	lea	($C00000).l,a0
	lea	$0004(a0),a1
	move.w	(MenuTextUploadTileStride_Short).w,d4
	lsl.w	#$7,d4
	move.w	(MenuTextUploadHeight_Short).w,d7
	move.w	(MenuTextRectRowCount_Short).w,d6

CopyMenuTextBufferRect_RowLoop_00209C:
	move.w	d7,d3
	add.w	(MenuTextMetricCursorY_Short).w,d3
	andi.w	#$001F,d3
	lsl.w	#$7,d3
	move.w	(MenuTextUploadWidth_Short).w,d2
	add.w	(MenuTextMetricCursorX_Short).w,d2
	add.w	d2,d2
	ori.w	#$4000,d2
	move.w	(MenuTextRectColumnCount_Short).w,d5
	move.w	d2,d1
	lea	(MenuTextUploadScratchBuffer_Short).w,a2

CopyMenuTextBufferRect_ReadLoop_0020C0:
	andi.w	#$007E,d2

CopyMenuTextBufferRect_WaitReady_0020C4:
	move.w	(a1),d0
	btst	#$09,d0
	beq.s	CopyMenuTextBufferRect_WaitReady_0020C4
	move.w	d3,d0
	add.w	d4,d0
	or.w	d2,d0
	andi.w	#$0FFE,d0
	swap	d0
	move.w	#$0003,d0
	move.l	d0,(a1)
	move.w	(a0),(a2)+
	addq.w	#$2,d2
	subq.w	#$1,d5
	bne.s	CopyMenuTextBufferRect_ReadLoop_0020C0
	move.w	(MenuTextRectColumnCount_Short).w,d5
	lea	(MenuTextUploadScratchBuffer_Short).w,a2

CopyMenuTextBufferRect_WriteLoop_0020EE:
	andi.w	#$407E,d1
	move.w	d3,d0
	or.w	d1,d0
	swap	d0
	move.w	#$0003,d0
	move.l	d0,(a1)
	move.w	(a2)+,(a0)
	addq.w	#$2,d1
	subq.w	#$1,d5
	bne.s	CopyMenuTextBufferRect_WriteLoop_0020EE
	addq.w	#$1,d7
	subq.w	#$1,d6
	bne.s	CopyMenuTextBufferRect_RowLoop_00209C
	movea.l	(sp)+,a2
	rts
