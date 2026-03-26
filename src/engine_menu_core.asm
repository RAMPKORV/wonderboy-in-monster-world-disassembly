; ======================================================================
; src/engine_menu_core.asm
; ROM range: 0x005000-0x01FFFF - early engine and menu/core gameplay logic
; ======================================================================
; Early engine/core body kept mostly opaque until routine boundaries are mapped.
; The front of this file continues the task/input helper chain that begins at `0x004FEE`
; in `src/vblank_tasks.asm`. The `0x005016-0x00505C` helpers currently look like a compact
; input-sequence stream built from (duration,value) byte pairs in `0xFF1400`, reusing
; the selected-input mirror at `0x8A7A-0x8A7D` as playback state. The bootstrap
; display-setup stub at `0x005170-0x0051C5` and the controller-read helpers at
; `0x0051C6-0x005260` are now source-authored in ROM order. A later recovered clue at
; `0x00805A-0x0083CF` now strongly points at the inventory/equipment menu UI: the code
; repeat-gates selected input, blinks the main cursor plus scroll arrows, redraws the
; four-row visible window, and references the inline heading strings `SELECT`,
; `WEAPON`, `ARMOR`, `SHIELD`, `BOOTS`, `ITEM`, and `MAGIC`. The adjacent
; `0x0083D0-0x00861E` continuation now also looks like the same menu/status panel: it
; redraws the visible four-row list, formats decimal values, carries inline `AP`, `DP`,
; `SP`, and `GOLD` strings, and now also draws a likely level readout plus the live gold
; total. The newly source-authored upstream slice at `0x007924-0x007A43` now looks like
; the paired horizontal-toggle owner plus loop body for the adjacent magic/status submode:
; it watches the left/right bits in repeat-gated input `0x95D9`, flips bit 0 of `0x9606`,
; picks one of two top-row tile ids from the tiny table at `0x00799A`, and refreshes the
; nearby status graphics through `0x008620` / `0x00863C` while `0x95E0` / `0x95E4` act
; like a modal flag plus saved selection backup. An external text dump also confirms the
; localized spell names `FIRE STORM`, `QUAKE`, `THUNDER`, `POWER`, `SHIELD`, and `RETURN`,
; plus nearby Wonder Boy strings such as `Oasis Boots`, `Fire-Urn`, `Purapril`, `Childam`,
; `Shiela Purapril`, `Prince of the Devil World`, and `Bio-Mecha`; however, the explicit
; heading bytes at `0x0082C4-0x0082EC` still take precedence over flattened dump lines when
; the two disagree. The next recovered slice at `0x007A44-0x007BA9` now shows the same
; submode can commit one of two cached selector values back into an entry, redraw a small
; 12-slot grid of menu entries, and refresh a compact adjacent status panel whose scratch
; bytes live around `0x959C`, `0x95EE`, `0x95F0`, and `0x9654`. The newly source-authored
; continuation at `0x007BAA-0x007CA3` also proves the next rows are a six-spell magic-grid
; redraw: it stores localized row records for `FIRE STORM`, `QUAKE`, `THUNDER`, `POWER`,
; `SHIELD`, and `RETURN`, highlights the two spell ids mirrored in `0x9F10/0x9F11`, and
; reuses `0x95B7` / `0x95C8` as empty/filled tile counts for a paired two-row spell bar.
; The broader engine body still stays opaque around the higher-level owners that seed the
; category descriptor and status values. Raw ROM work on the next incbin-backed
; The next source-authored bridge at `0x00882C-0x0088C1` now normalizes a candidate
; magic/status id before clearing matching top-row assignments in `0x9F10/0x9F11`, then
; consumes the pending packed gauge target at `0x9628`, chooses one of two scale/table
; bundles, clamps against the current packed value at `0x9602/0x9604`, and dispatches into
; the now source-authored three-row tile-strip writer at `0x0088D6`. The later
; `0x008A04-0x008C33` continuation is now also source-authored as the same spell-bar refill,
; gauge-tile upload, and layout-width synthesis rooted in `0x95AA`, `0x95B8-0x95C3`, and
; `0x95F4/0x95F6`.
; The newly source-authored tail at `0x008C34-0x008C7F` snapshots the local magic-menu
; selection scratch, resets list/cursor/scroll state, and captures top-row selector bytes
; from `0x9F10/0x9F11` when they still point at the lower magic/status row. The exact
; game-facing stat meaning of the gauge itself still needs more evidence, so the remaining
; scale bundles and downstream render/upload path stay incbin-backed for now. The
; newly source-authored bridge at
; `0x007D9C-0x008059` now links that magic/status flow back into the generic visible-list
; inventory UI: it confirms visible entries, blinks the selected row, queues menu-text row
; transfers through `0x8A77`, shows an inline `PAUSE` prompt, and expands packed 32-tile row
; templates before the already-authored repeat helper resumes at `0x00805A`.

PrimeTaskAdvanceBuffers_00559E             equ $0000559E
ResetSecondaryTaskSlots_00062A             equ $0000062A
DecodePatchStream_00234C                   equ $0000234C
RunTaskHelper_0366                         equ $00000366
ResetVdpReg1LowFlags_0006BE                equ $000006BE
ClearVdpReg1Bit3_0006F6                    equ $000006F6
ClearBootstrapScratch_005398               equ $00005398
ClearTilemapRegionA_006910                 equ $00006910
ClearTilemapRegionB_006916                 equ $00006916
ClearFixedVramRegionAndResetFlags_00693E   equ $0000693E
ResetTilemapWorkBuffers_00696C             equ $0000696C
TaskDescriptor_006EA8                      equ $00006EA8
WriteNullTerminatedTileString_00786A       equ $0000786A
WriteNormalTileString_007870               equ $00007870
UploadMenuPatternStrip_0022A8              equ $000022A8
MeasureNullTerminatedTileStringWidth_01B004 equ $0001B004
MagicMenuStatusGraphicUploadCache_008C80     equ $00008C80
MenuRowTemplate_008C82                     equ $00008C82
MenuRowTemplate_008CA2                     equ $00008CA2
MenuRowTemplate_008CC2                     equ $00008CC2
MenuRowTemplate_008CE2                     equ $00008CE2
MenuRowTemplate_008D02                     equ $00008D02
MenuRowTemplate_008D22                     equ $00008D22
MenuRowTemplate_008D42                     equ $00008D42
MenuRowTemplate_008D62                     equ $00008D62
MenuRowTemplate_008D82                     equ $00008D82
MenuRowTemplate_008DA2                     equ $00008DA2
MenuRowTemplate_008DC2                     equ $00008DC2
MenuRowTemplate_008DE2                     equ $00008DE2
MenuRowTemplate_008E02                     equ $00008E02
PrepareMenuTilemapWrite_000A36             equ $00000A36
BuildMagicMenuTopRowTileOffset_00757A      equ $0000757A
RefreshInventoryMenuSelectionState_0076E8  equ $000076E8
UpdateInventoryMenuListCursor_ShowVisible_0081D6 equ UpdateInventoryMenuListCursor_ShowVisible
DrawInventoryMenuLevelDigits_008552        equ $00008552

	dbf	d1,ClearTaskScriptProgressBuffer_Loop
	move.b	d0,(TaskScriptProgressCurrent_Short).w
	move.b	d0,(TaskScriptProgressPrevious_Short).w
	move.b	d0,(TaskScriptProgressFlags_Short).w
	move.l	d0,(TaskScriptStateLong_Short).w
	rts

LoadSelectedInputPlaybackBuffer_005016:
LoadTaskScriptProgressBuffer_005016:
	lea	(TaskScriptProgressBuffer).l,a0

; Best-fit interpretation: this buffer stores repeated `dc.b duration,value` records.
; `move.w (a0)+,(SelectedInputPlaybackCountdown).w` latches one packed pair directly
; into `0x8A4E/0x8A4F`, `AppendSelectedInputPlaybackValue_005036` coalesces repeated
; values into the current byte pair, and `StepSelectedInputPlayback` feeds the low byte
; back into the selected-input mirror once per tick while live pad mirroring is gated.
AdvanceSelectedInputPlayback:
AdvanceTaskScript:
	move.w	(a0)+,(SelectedInputPlaybackCountdown_Short).w
	move.l	a0,VBlankTaskScriptPointerOffset(a5)
	clr.l	(TaskScriptStateLong_Short).w
	clr.b	(SelectedInputCurrent_Short).w
	clr.b	(SelectedInputPrevious_Short).w
	clr.b	(SelectedInputPressed_Short).w
	rts

AppendSelectedInputPlaybackValue_005036:
AppendTaskScriptProgressValue_005036:
	movea.l	VBlankTaskScriptPointerOffset(a5),a0
	move.b	(SelectedInputCurrent_Short).w,d0
	tst.b	(a0)
	beq.s	StoreTaskScriptProgressValue_005054
	cmp.b	$0001(a0),d0
	bne.s	AdvanceTaskScriptProgressCursor_00504E
	cmpi.b	#$FF,(a0)
	bne.s	IncrementTaskScriptProgressByte_005058

AdvanceTaskScriptProgressCursor_00504E:
	addq.w	#$2,a0
	move.l	a0,VBlankTaskScriptPointerOffset(a5)

StoreTaskScriptProgressValue_005054:
	move.b	d0,$0001(a0)

IncrementTaskScriptProgressByte_005058:
	addq.b	#$1,(a0)
	rts

StepSelectedInputPlayback:
StepTaskScript:
	move.b	(SelectedInputCurrent_Short).w,(SelectedInputPrevious_Short).w
	move.b	(SelectedInputPlaybackValue_Short).w,(SelectedInputCurrent_Short).w
	subq.b	#$1,(SelectedInputPlaybackCountdown_Short).w
	bne.s	StepTaskScript_Return
	movea.l	VBlankTaskScriptPointerOffset(a5),a0
	move.w	(a0)+,(SelectedInputPlaybackCountdown_Short).w
	move.l	a0,VBlankTaskScriptPointerOffset(a5)

StepTaskScript_Return:
	rts

TaskDescriptor_00507C:
	dc.l	$4B676D74

TaskAdvanceRoundRobinCb_005080:
	jsr	(RunTaskHelper_0364).w
	bsr.w	ClearTaskScriptScratch
	clr.b	(TaskScriptMode_Short).w
	clr.b	(TaskScriptAuxFlag_Short).w
	lea	TaskAdvanceSecondaryList_0050CC(pc),a1
	bsr.w	LoadSecondaryTaskDescriptorList
	ori.b	#$01,(TaskScriptFlags_Short).w
	jsr	(RunTaskHelper_0400).w
	tst.b	(SecondaryTaskSlots_Short).w
	bmi.s	TaskAdvanceRoundRobinCb_Return
	tst.b	(SecondaryTaskSlots_Short).w
	bmi.s	TaskAdvanceRoundRobinCb_Return
	movea.l	#TaskDescriptor_004F54,a1
	tst.w	(TaskCompletionResult_Short).w
	bne.s	TaskAdvanceRoundRobinCb_ClearFlagAndQueue
	movea.l	#InitImmDescPtr,a1

TaskAdvanceRoundRobinCb_ClearFlagAndQueue:
	andi.b	#$FE,(TaskScriptFlags_Short).w
	bra.w	QueueRoundRobinTaskDescriptor

TaskAdvanceRoundRobinCb_Return:
	rts

TaskAdvanceSecondaryList_0050CC:
	dc.l	$00008EB0
	dc.l	$00000000

QueueRoundRobinTaskDescriptor:
	move.l	a1,-(sp)
	jsr	(PrimeTaskAdvanceBuffers_00559E).l
	jsr	(ResetSecondaryTaskSlots_00062A).w
	movea.l	(sp)+,a1

QueueImmediateTaskDescriptor:
	move.l	a1,-(sp)
	jsr	(InitializeVBlankDispatchState).l
	movea.l	(sp)+,a1
	lea	(ImmediateTaskSlots_Short).w,a0
	move.l	(a1)+,VBlankTaskUserDataOffset(a0)
	move.l	a1,VBlankTaskCallbackOffset(a0)
	move.w	d0,VBlankTaskDelayOffset(a0)
	move.w	#$8000,(a0)
	jmp	(ResetDispatchStackAndRetry).l

LoadSecondaryTaskDescriptorList:
	lea	(SecondaryTaskSlots_Short).w,a0

LoadSecondaryTaskDescriptorList_Next:
	move.l	(a1)+,d0
	beq.s	LoadSecondaryTaskDescriptorList_Return
	move.w	#$8000,(a0)
	movea.l	d0,a2
	move.l	(a2)+,VBlankTaskUserDataOffset(a0)
	move.l	a2,VBlankTaskCallbackOffset(a0)
	lea	VBlankTaskSlotStride(a0),a0
	bra.s	LoadSecondaryTaskDescriptorList_Next

LoadSecondaryTaskDescriptorList_Return:
	rts

ClearTaskScriptScratch:
	moveq	#6,d0
	lea	(TaskScriptAuxScratchBuffer_Short).w,a0

ClearTaskScriptScratch_Loop:
	clr.l	(a0)+
	dbf	d0,ClearTaskScriptScratch_Loop
	rts

PlayTaskAdvanceSound:
	jsr	(RunTaskHelper_0364).w
	moveq	#$25,d0
	jmp	(RunTaskHelper_0366).w

PollSecondaryTaskStatus:
	move.b	(SecondaryTaskStatusSelector_Short).w,d0
	bpl.s	PollSecondaryTaskStatus_CheckForNewReadySource
	lea	(SecondaryTaskReadySlot0_Short).w,a0
	andi.b	#$7F,d0
	beq.s	PollSecondaryTaskStatus_TestReadyBit
	lea	(SecondaryTaskReadySlot1_Short).w,a0

PollSecondaryTaskStatus_TestReadyBit:
	btst	#SecondaryTaskReadyBit,(a0)
	rts

PollSecondaryTaskStatus_CheckForNewReadySource:
	moveq	#SecondaryTaskStatusSlot0,d0
	btst	#SecondaryTaskReadyBit,(SecondaryTaskReadySlot0_Short).w
	bne.s	PollSecondaryTaskStatus_LatchReadySource
	btst	#SecondaryTaskReadyBit,(SecondaryTaskReadySlot1_Short).w
	beq.s	PollSecondaryTaskStatus_Return
	moveq	#SecondaryTaskStatusSlot1,d0

PollSecondaryTaskStatus_LatchReadySource:
	move.b	d0,(SecondaryTaskStatusSelector_Short).w

PollSecondaryTaskStatus_Return:
	rts

BootstrapClearDisplayAndTaskBuffers_005170:
	jsr	(ClearVdpReg1Bit3_0006F6).w
	bsr.w	ClearTilemapRegionA_006910
	bsr.w	ClearTilemapRegionB_006916
	bsr.w	ClearFixedVramRegionAndResetFlags_00693E
	bsr.w	ResetTilemapWorkBuffers_00696C
	bra.w	PrimeTaskAdvanceBuffers_00559E

BootstrapRetirePendingTasksAndApplyPatch_005188:
	jsr	(ResetVdpReg1LowFlags_0006BE).w
	bsr.s	BootstrapClearDisplayAndTaskBuffers_005170
	moveq	#-$80,d0
	move.w	d0,(BootstrapPatchSlot0_Short).w
	move.w	d0,(BootstrapPatchSlot1_Short).w
	move.w	d0,(BootstrapPatchSlot2_Short).w
	move.w	d0,(BootstrapPatchSlot3_Short).w
	bsr.w	ClearBootstrapScratch_005398
	lea	(TaskDescriptor_006EA8).l,a0
	jsr	(RetireMatchingRoundRobinTasksByUserData).w
	lea	(TaskDescriptor_005608).l,a0
	jsr	(RetireMatchingRoundRobinTasksByUserData).w
	lea	BootstrapInlinePatchStream_0051C0(pc),a0
	jmp	(DecodePatchStream_00234C).w

; This six-byte command stream must remain inline here because the decoder above
; consumes it via PC-relative address.
BootstrapInlinePatchStream_0051C0:
	dc.b	$B0,$FB,$FB,$FB,$FF,$00

ReadControllerPortsAndLatchSelectedInput:
	move.w	#$0100,(Z80_BUS_REQUEST).l

.wait_for_z80_bus_ack:
	btst	#$0,(Z80_BUS_REQUEST).l
	bne.s	.wait_for_z80_bus_ack
	lea	(JOY1_DATA).l,a0
	lea	(Player1InputCurrent_Short).w,a1
	bsr.s	ReadControllerInputStateTriplet
	lea	(JOY2_DATA).l,a0
	lea	(Player2InputCurrent_Short).w,a1
	bsr.s	ReadControllerInputStateTriplet
	move.w	#$0000,(Z80_BUS_REQUEST).l
	btst	#$0,(SelectedInputSource_Short).w
	bne.s	.selected_pad_ready
	lea	(Player1InputCurrent_Short).w,a1

.selected_pad_ready:
	tst.b	(SelectedInputPlaybackMode_Short).w
	bmi.s	ReadControllerPortsAndLatchSelectedInput_Return
	move.b	(SelectedInputCurrent_Short).w,(SelectedInputPrevious_Short).w
	move.b	(a1),(SelectedInputCurrent_Short).w

ReadControllerPortsAndLatchSelectedInput_Return:
	rts

ReadControllerInputStateTriplet:
	move.b	(a1),$0001(a1)
	move.b	#$00,(a0)
	nop
	nop
	move.b	(a0),d0
	not.b	d0
	asl.b	#$2,d0
	andi.b	#$C0,d0
	move.b	d0,(a1)
	move.b	#$40,(a0)
	nop
	nop
	move.b	(a0),d0
	not.b	d0
	andi.b	#$3F,d0
	or.b	d0,(a1)
	move.b	(a1),d1
	move.b	$0001(a1),d0
	eor.b	d1,d0
	and.b	d1,d0
	move.b	d0,$0002(a1)
	rts

UpdateSelectedInputPressedState:
	move.b	(SelectedInputCurrent_Short).w,d1
	move.b	(SelectedInputPrevious_Short).w,d0
	eor.b	d1,d0
	and.b	d1,d0
	move.b	d0,(SelectedInputPressed_Short).w
	rts

; This later split stays in physical ROM order: the newly source-authored menu/status
; coverage now spans the upstream magic-submode owner at `0x007924-0x007A43`, the
; selected-input repeat helper at `0x00805A-0x0080A7`, the inventory/equipment UI and
; status drawing through `0x00861E`, and the adjacent magic/status panel through
; `0x00882A`.
CoreRegion_005261_007923:
	incbin "data/rom/core_005000_01ffff.bin",$0262,$26C2

HandleMagicMenuSubmodeLeftInput_007924:
	moveq	#$0C,d0
	and.b	(SelectedInputRepeatOutput_Short).w,d0
	beq.s	HandleMagicMenuSubmodeHorizontalInput_Return_00794C
	bsr.w	PlayInventoryMenuMoveSound_008BB0
	eori.w	#$0001,(InventoryMenuSelectionIndex_Short).w
	bra.s	RefreshMagicMenuSubmodeIndicator_Left_00794E

HandleMagicMenuSubmodeRightInput_007938:
	moveq	#$0C,d0
	and.b	(SelectedInputRepeatOutput_Short).w,d0
	beq.s	HandleMagicMenuSubmodeHorizontalInput_Return_00794C
	bsr.w	PlayInventoryMenuMoveSound_008BB0
	eori.w	#$0001,(InventoryMenuSelectionIndex_Short).w
	bra.s	RefreshMagicMenuSubmodeIndicator_Right_007952

HandleMagicMenuSubmodeHorizontalInput_Return_00794C:
	rts

RefreshMagicMenuSubmodeIndicator_Left_00794E:
	moveq	#$10,d6
	bra.s	RefreshMagicMenuSubmodeIndicator_007954

RefreshMagicMenuSubmodeIndicator_Right_007952:
	moveq	#$30,d6

RefreshMagicMenuSubmodeIndicator_007954:
	movea.w	#$000C,a4
	jsr	(PrepareMenuTilemapWrite_000A36).w
	bsr.w	BuildMagicMenuTopRowTileOffset_00757A
	move.w	MagicMenuSubmodeTopRowTileTable_00799A(pc,d0.w),-$3800(a4)
	move.w	d6,-$3700(a4)
	move.w	#$0004,-$3E00(a4)
	ori.b	#$40,-$3FFD(a4)
	move.w	#$FF01,-$3900(a4)
	clr.b	-$3CFD(a4)
	move.b	#$80,-$3FFE(a4)
	move.w	#$1602,-$3D00(a4)
	moveq	#$00,d0
	jsr	($07E8).w
	move.b	#$C0,-$4000(a4)
	rts

MagicMenuSubmodeTopRowTileTable_00799A:
	dc.w	$00B8,$00E8

RunMagicMenuSubmode_00799E:
	move.l	(sp)+,(MagicMenuSubmodeDispatchVector_Short).w

RunMagicMenuSubmodeLoop_0079A2:
	tst.b	(MagicMenuSubmodeModalFlag_Short).w
	beq.s	RunMagicMenuSubmodeLoop_UpdateInput
	move.w	(InventoryMenuSelectionIndex_Short).w,(MagicMenuSubmodeSavedSelectionIndex_Short).w
	clr.w	(InventoryMenuSelectionIndex_Short).w
	bsr.s	RefreshMagicMenuSubmodeIndicator_Left_00794E

RunMagicMenuSubmodeLoop_UpdateInput:
	bsr.w	UpdateSelectedInputUiRepeat_00805A
	bsr.w	PollMagicMenuSubmodeAction_007D7E
	beq.w	RunMagicMenuSubmodeLoop_HandleHorizontalInput
	clr.b	(MagicMenuSubmodeActionFlag_Short).w
	bra.s	RunMagicMenuSubmodeLoop_Exit

RunMagicMenuSubmodeLoop_HandleHorizontalInput:
	tst.b	(MagicMenuSubmodeModalFlag_Short).w
	beq.s	RunMagicMenuSubmodeLoop_HandleRightInput
	bsr.w	HandleMagicMenuSubmodeLeftInput_007924
	bra.s	RunMagicMenuSubmodeLoop_CheckExit

RunMagicMenuSubmodeLoop_HandleRightInput:
	bsr.w	HandleMagicMenuSubmodeRightInput_007938

RunMagicMenuSubmodeLoop_CheckExit:
	bne.s	RunMagicMenuSubmodeLoop_UpdateInput
	bsr.w	CheckMagicMenuSubmodeExit_007D8A
	beq.s	RunMagicMenuSubmodeLoop_UpdateInput
	moveq	#$00,d6
	clr.b	(MagicMenuSubmodeActionFlag_Short).w

RunMagicMenuSubmodeLoop_Exit:
	bsr.w	PlayInventoryMenuConfirmSound_008BAA
	movea.l	(MagicMenuSubmodeDispatchVector_Short).w,a0
	jmp	(a0)

OpenMagicMenuSubmode_0079EE:
	move.l	(sp)+,(MagicMenuSubmodeReturnVector_Short).w
	move.b	#$01,(MagicMenuSubmodeModalFlag_Short).w
	bsr.s	RunMagicMenuSubmode_00799E
	tst.w	d6
	bmi.s	OpenMagicMenuSubmode_Return
	movea.w	(InventoryMenuSelectionIndex_Short).w,a0
	move.b	-$60F0(a0),-$6A24(a0)
	move.b	(MagicMenuSubmodeSelectedValue_Short).w,-$60F0(a0)
	moveq	#$00,d0
	move.b	-$6A1E(a0),d0
	bmi.s	OpenMagicMenuSubmode_LoadFallbackGraphic
	add.w	d0,d0
	bsr.w	$7C44
	bra.s	OpenMagicMenuSubmode_StoreValue

OpenMagicMenuSubmode_LoadFallbackGraphic:
	bsr.w	$7C4A

OpenMagicMenuSubmode_StoreValue:
	move.b	(MagicMenuSubmodeSelectedValue_Short).w,-$6A1E(a0)
	tst.w	(InventoryMenuSelectionIndex_Short).w
	beq.s	OpenMagicMenuSubmode_DrawSlot0Graphic
	bsr.w	DrawMagicMenuStatusGraphics_AltEntrySlot1_00863C
	bra.s	OpenMagicMenuSubmode_Return

OpenMagicMenuSubmode_DrawSlot0Graphic:
	bsr.w	DrawMagicMenuStatusGraphics_008620

OpenMagicMenuSubmode_Return:
	move.w	(MagicMenuSubmodeSavedSelectionIndex_Short).w,(InventoryMenuSelectionIndex_Short).w
	movea.l	(MagicMenuSubmodeReturnVector_Short).w,a0
	jmp	(a0)

OpenMagicMenuStatusSelection_007A44:
	move.l	(sp)+,(MagicMenuSubmodeApplyReturnVector_Short).w
	move.b	#$01,(MagicMenuSubmodeModalFlag_Short).w
	bsr.w	RunMagicMenuSubmode_00799E
	tst.w	d6
	beq.s	OpenMagicMenuStatusSelection_ApplySelection
	moveq	#$00,d6
	bra.s	OpenMagicMenuStatusSelection_Finalize

OpenMagicMenuStatusSelection_ApplySelection:
	move.w	(MagicMenuStatusValue2_Short).w,d0
	tst.w	(MagicMenuSubmodeSavedSelectionIndex_Short).w
	beq.s	OpenMagicMenuStatusSelection_LoadCurrentEntry
	move.w	(MagicMenuStatusValue3_Short).w,d0

OpenMagicMenuStatusSelection_LoadCurrentEntry:
	movea.w	(InventoryMenuSelectionIndex_Short).w,a0
	move.b	-$60F0(a0),-$6A24(a0)
	addq.b	#$08,d0
	move.b	d0,-$60F0(a0)
	movea.w	(MagicMenuSubmodeSavedSelectionIndex_Short).w,a0
	adda.w	a0,a0
	move.w	-$6A12(a0),d1
	tst.w	(InventoryMenuSelectionIndex_Short).w
	bne.s	OpenMagicMenuStatusSelection_DrawSlot1Graphic
	bsr.w	DrawMagicMenuStatusGraphics_008620
	bra.s	OpenMagicMenuStatusSelection_SelectionApplied

OpenMagicMenuStatusSelection_DrawSlot1Graphic:
	bsr.w	DrawMagicMenuStatusGraphics_AltEntrySlot1_00863C

OpenMagicMenuStatusSelection_SelectionApplied:
	moveq	#-1,d6

OpenMagicMenuStatusSelection_Finalize:
	move.w	#InventoryMenuBlankTile,d2
	move.w	(MagicMenuSubmodeSavedSelectionIndex_Short).w,d0
	bsr.s	DrawMagicMenuSubmodeIndicatorTile_007AAA
	move.w	(MagicMenuSubmodeSavedSelectionIndex_Short).w,(InventoryMenuSelectionIndex_Short).w
	movea.l	(MagicMenuSubmodeApplyReturnVector_Short).w,a0
	jmp	(a0)

DrawMagicMenuSubmodeIndicatorTile_007AAA:
	add.w	d0,d0
	move.w	MagicMenuSubmodeIndicatorCoords_007ABC(pc,d0.w),d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.w	d2,(VDP_DATA_PORT).l
	rts

MagicMenuSubmodeIndicatorCoords_007ABC:
	dc.w	$1506,$1E06

DrawMagicMenuEntryGrid_007AC0:
	bsr.w	PrepareMagicMenuPanelRefresh_007FCE
	moveq	#$00,d2

DrawMagicMenuEntryGrid_NextEntry:
	movea.w	d2,a0
	move.b	-$6A74(a0),d4
	beq.s	DrawMagicMenuEntryGrid_AdvanceEntry
	move.w	d2,-(sp)
	move.w	d2,d0
	ori.w	#$0030,d0
	jsr	(BuildInventoryMenuEntryTileRows_001E6A).w
	move.w	(sp)+,d2
	tst.w	(InventoryMenuEntryTextWidth_Short).w
	beq.s	DrawMagicMenuEntryGrid_AdvanceEntry
	move.w	d2,d0
	add.w	d0,d0
	move.w	MagicMenuEntryGridCoords_007B0A(pc,d0.w),d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	lea	(InventoryMenuEntryTileRow0Buffer_Short).w,a1
	bsr.s	WriteInventoryMenuBufferedTextRow_007B70
	addq.w	#$1,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	lea	(InventoryMenuEntryTileRow1Buffer_Short).w,a1
	bsr.s	WriteInventoryMenuBufferedTextRow_007B70

DrawMagicMenuEntryGrid_AdvanceEntry:
	addq.w	#$1,d2
	cmpi.w	#MagicMenuStatusSelectionSlotCount,d2
	bcs.s	DrawMagicMenuEntryGrid_NextEntry
	bra.s	RefreshMagicMenuStatusPanel_007B22

MagicMenuEntryGridCoords_007B0A:
	dc.w	$0207,$0C07,$1607
	dc.w	$0209,$0C09,$1609
	dc.w	$020B,$0C0B,$160B
	dc.w	$020D,$0C0D,$160D

RefreshMagicMenuStatusPanel_007B22:
	lea	MagicMenuStatusPanelLiteralTileTable_007B9A(pc),a0
	lea	(MagicMenuStatusPanelScratchBase_Short).w,a2
	lea	MagicMenuStatusPanelCoords_007B92(pc),a3
	move.w	(a3)+,d7
	move.b	(a2)+,(InventoryMenuLevelScratch_Short).w
	bsr.w	DrawInventoryMenuLiteralTileQuad_008608
	move.w	(a3)+,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.w	#$0506,d7
	bsr.w	DrawInventoryMenuLevelDigits_008552
	bsr.s	DrawMagicMenuOptionalStatusIcon_007B86
	move.w	#$FFFF,(MagicMenuStatusValue3_Short).w
	subq.l	#$5,a2
	tst.b	(a2)
	beq.s	RefreshMagicMenuStatusPanel_CheckSecondIcon
	move.w	#$0004,(MagicMenuStatusValue3_Short).w

RefreshMagicMenuStatusPanel_CheckSecondIcon:
	bsr.s	DrawMagicMenuOptionalStatusIcon_007B86
	bsr.w	DrawInventoryMenuHeading_008272
	addq.l	#$6,a2
	move.b	(a2),d3
	ext.w	d3
	move.w	d3,(MagicMenuStatusValue2_Short).w
	bpl.w	DrawMagicMenuStatusGraphics_AltEntrySlot2_008666
	rts

WriteInventoryMenuBufferedTextRow_007B70:
	move.w	#InventoryMenuNormalEntryTileBase,d0
	move.w	(InventoryMenuEntryTextWidth_Short).w,d1

WriteInventoryMenuBufferedTextRow_Loop:
	move.b	(a1)+,d0
	move.w	d0,(VDP_DATA_PORT).l
	subq.w	#$1,d1
	bne.s	WriteInventoryMenuBufferedTextRow_Loop
	rts

DrawMagicMenuOptionalStatusIcon_007B86:
	move.w	(a3)+,d7
	tst.b	(a2)
	bne.w	DrawInventoryMenuLiteralTileQuad_008608
	addq.l	#$8,a0
	rts

MagicMenuStatusPanelCoords_007B92:
	dc.w	$0205,$0406,$0805,$1C05

MagicMenuStatusPanelLiteralTileTable_007B9A:
	dc.w	$87D0,$87D2,$87D1,$87D3
	dc.w	$87C0,$87C2,$87C1,$87C3

MagicMenuReturnIconTileQuad_007BAA:
	dc.w	$87C4,$87C6,$87C5,$87C7

DrawMagicMenuSpellGrid_007BB2:
	bsr.w	PrepareMagicMenuPanelRefresh_007FCE
	moveq	#$00,d4
	lea	MagicSpellRecordTable_007C0A(pc),a1

DrawMagicMenuSpellGrid_NextSpell:
	move.b	(a1)+,d7
	lsl.w	#$8,d7
	move.b	(a1)+,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	cmp.b	(MagicMenuStatusValue0_Short).w,d4
	beq.s	DrawMagicMenuSpellGrid_DrawSelectedSpell
	cmp.b	(MagicMenuStatusValue1_Short).w,d4
	beq.s	DrawMagicMenuSpellGrid_DrawSelectedSpell
	bsr.w	WriteNormalTileString_007870
	bra.s	DrawMagicMenuSpellGrid_StoreBarCounts

DrawMagicMenuSpellGrid_DrawSelectedSpell:
	bsr.w	WriteNullTerminatedTileString_00786A

DrawMagicMenuSpellGrid_StoreBarCounts:
	movea.w	d4,a0
	move.b	-$6A48(a0),(MagicMenuSpellBarFilledTileCountScratch_Short).w
	move.b	-$6A42(a0),d0
	sub.b	(MagicMenuSpellBarFilledTileCountScratch_Short).w,d0
	move.b	d0,(MagicMenuSpellBarEmptyTileCountScratch_Short).w
	bsr.s	DrawMagicMenuSpellBar_007C68
	addq.w	#$1,d4
	cmpi.w	#MagicSpellCount,d4
	bcs.s	DrawMagicMenuSpellGrid_NextSpell
	bra.w	DrawInventoryMenuHeading_008272

MagicSpellNameOffsetTable_007BFE:
	dc.w	MagicSpellRecord_FireStorm_007C0A-MagicSpellNameOffsetTable_007BFE
	dc.w	MagicSpellRecord_Quake_007C17-MagicSpellNameOffsetTable_007BFE
	dc.w	MagicSpellRecord_Thunder_007C1F-MagicSpellNameOffsetTable_007BFE
	dc.w	MagicSpellRecord_Power_007C29-MagicSpellNameOffsetTable_007BFE
	dc.w	MagicSpellRecord_Shield_007C31-MagicSpellNameOffsetTable_007BFE
	dc.w	MagicSpellRecord_Return_007C3A-MagicSpellNameOffsetTable_007BFE

MagicSpellRecordTable_007C0A:
MagicSpellRecord_FireStorm_007C0A:
	dc.b	$03,$06,"FIRE STORM",$00
MagicSpellRecord_Quake_007C17:
	dc.b	$12,$06,"QUAKE",$00
MagicSpellRecord_Thunder_007C1F:
	dc.b	$03,$09,"THUNDER",$00
MagicSpellRecord_Power_007C29:
	dc.b	$12,$09,"POWER",$00
MagicSpellRecord_Shield_007C31:
	dc.b	$03,$0C,"SHIELD",$00
MagicSpellRecord_Return_007C3A:
	dc.b	$12,$0C,"RETURN",$00
	dc.b	$00

RefreshMagicMenuSelectedSpellNames_007C44:
	bsr.s	PrepareMagicMenuSpellNameWrite_007C56
	bsr.w	WriteNormalTileString_007870
	move.w	(MagicMenuSubmodeSavedSelectionIndex_Short).w,d0
	add.w	d0,d0
	bsr.s	PrepareMagicMenuSpellNameWrite_007C56
	bra.w	WriteNullTerminatedTileString_00786A

PrepareMagicMenuSpellNameWrite_007C56:
	lea	MagicSpellNameOffsetTable_007BFE(pc),a1
	adda.w	0(a1,d0.w),a1
	move.b	(a1)+,d7
	lsl.w	#$8,d7
	move.b	(a1)+,d7
	bra.w	BuildInventoryMenuVramWriteCommand_0083B0

DrawMagicMenuSpellBar_007C68:
	moveq	#MagicMenuSpellBarRowCount-1,d3
	move.w	#$8700,d5

DrawMagicMenuSpellBar_NextRow:
	addq.w	#$1,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	tst.b	(MagicMenuSpellBarFilledTileCountScratch_Short).w
	beq.s	DrawMagicMenuSpellBar_DrawEmptyTiles
	move.b	MagicMenuSpellBarFilledTileIdTable_007CA0(pc,d3.w),d5
	move.b	(MagicMenuSpellBarFilledTileCountScratch_Short).w,d1
	bsr.s	WriteRepeatedMagicMenuSpellBarTile_007C9A

DrawMagicMenuSpellBar_DrawEmptyTiles:
	move.b	MagicMenuSpellBarEmptyTileIdTable_007CA2(pc,d3.w),d5
	move.b	(MagicMenuSpellBarEmptyTileCountScratch_Short).w,d1
	bsr.s	WriteRepeatedMagicMenuSpellBarTile_007C9A
	dbra	d3,DrawMagicMenuSpellBar_NextRow
	rts

WriteRepeatedMagicMenuSpellBarTile_007C94:
	move.w	d5,(VDP_DATA_PORT).l

WriteRepeatedMagicMenuSpellBarTile_007C9A:
	subq.b	#$1,d1
	bpl.s	WriteRepeatedMagicMenuSpellBarTile_007C94
	rts

MagicMenuSpellBarFilledTileIdTable_007CA0:
	dc.b	$99,$98

MagicMenuSpellBarEmptyTileIdTable_007CA2:
	dc.b	$BF,$BE

; Best-fit: this helper clears one of the two top-row magic/status slots if the currently
; highlighted six-choice value matches it. When the current page is not the raw six-spell
; page, the compared value instead comes from the paired status-value words at `0x95EE` /
; `0x95F0` plus the shared `+$08` bias already visible in `OpenMagicMenuStatusSelection_007A44`.
ClearAssignedMagicMenuValue_007CA4:
	move.w	(InventoryMenuSelectionIndex_Short).w,d1
	cmpi.w	#MagicMenuSpellPageStateSelector,(InventoryMenuCategoryDescriptorBase_Short).w
	beq.s	ClearAssignedMagicMenuValue_CheckSlots
	add.w	d1,d1
	movea.w	d1,a0
	move.w	-$6A12(a0),d1
	addq.w	#MagicMenuStatusValueBias,d1

ClearAssignedMagicMenuValue_CheckSlots:
	moveq	#MagicMenuTopRowSlotLastIndex,d2

ClearAssignedMagicMenuValue_CheckNextSlot:
	movea.w	d2,a0
	cmp.b	-$60F0(a0),d1
	bne.s	ClearAssignedMagicMenuValue_AdvanceSlot
	move.b	-$60F0(a0),-$6A24(a0)
	moveq	#-1,d0
	move.b	d0,-$60F0(a0)
	move.b	d0,-$6A1E(a0)
	cmpi.b	#MagicMenuStatusValueBias,d1
	bcc.s	ClearAssignedMagicMenuValue_RedrawSlot
	bsr.w	BuildMagicMenuTopRowTileOffset_00757A
	bsr.w	PrepareMagicMenuSpellNameWrite_007C56
	bsr.w	WriteNormalTileString_007870

ClearAssignedMagicMenuValue_RedrawSlot:
	tst.w	d2
	beq.s	ClearAssignedMagicMenuValue_DrawSlot0Graphic
	bsr.w	DrawMagicMenuStatusGraphics_AltEntrySlot1_00863C
	bra.s	ClearAssignedMagicMenuValue_ReturnSuccess

ClearAssignedMagicMenuValue_DrawSlot0Graphic:
	bsr.w	DrawMagicMenuStatusGraphics_008620

ClearAssignedMagicMenuValue_ReturnSuccess:
	moveq	#$00,d6
	rts

ClearAssignedMagicMenuValue_AdvanceSlot:
	dbra	d2,ClearAssignedMagicMenuValue_CheckNextSlot
	moveq	#-1,d6
	rts

HandleMagicMenuSixChoiceInput_007D00:
	moveq	#MagicMenuSixChoiceLastDirectionIndex,d2

HandleMagicMenuSixChoiceInput_CheckDirection:
	move.b	MagicMenuSixChoiceDirectionBitTable_007D46(pc,d2.w),d0
	btst	d0,(SelectedInputRepeatOutput_Short).w
	bne.s	HandleMagicMenuSixChoiceInput_ApplyDirection
	dbra	d2,HandleMagicMenuSixChoiceInput_CheckDirection
	rts

HandleMagicMenuSixChoiceInput_ApplyDirection:
	bsr.w	PlayInventoryMenuMoveSound_008BB0
	move.w	(InventoryMenuSelectionIndex_Short).w,d0
	lsl.w	#$2,d0
	add.w	d0,d2
	move.b	MagicMenuSixChoiceSelectionTable_007D4A(pc,d2.w),d0
	move.w	d0,(InventoryMenuSelectionIndex_Short).w
	add.w	d0,d0
	tst.w	(InventoryMenuCategoryId_Short).w
	bne.s	HandleMagicMenuSixChoiceInput_UseDefaultCursorCoords
	move.w	MagicMenuSixChoiceCursorCoords_Alt_007D6E(pc,d0.w),(InventoryMenuListCursorTileX_Short).w
	subq.b	#$1,(InventoryMenuListCursorTileX_Short).w
	bra.w	UpdateInventoryMenuListCursor_ShowVisible_0081D6

HandleMagicMenuSixChoiceInput_UseDefaultCursorCoords:
	move.w	MagicMenuSixChoiceCursorCoords_Default_007D62(pc,d0.w),(InventoryMenuListCursorTileX_Short).w
	bra.w	UpdateInventoryMenuListCursor_ShowVisible_0081D6

MagicMenuSixChoiceDirectionBitTable_007D46:
	dc.b	$00,$01,$02,$03

MagicMenuSixChoiceSelectionTable_007D4A:
	dc.b	$04,$02,$01,$01
	dc.b	$05,$03,$00,$00
	dc.b	$00,$04,$03,$03
	dc.b	$01,$05,$02,$02
	dc.b	$02,$00,$05,$05
	dc.b	$03,$01,$04,$04

MagicMenuSixChoiceCursorCoords_Default_007D62:
	dc.w	$0206,$1106,$0209,$1109,$020C,$110C

MagicMenuSixChoiceCursorCoords_Alt_007D6E:
	dc.w	$0F07,$1807,$0F0A,$180A,$0F0D,$180D

PollMagicMenuPrimaryAction_007D7A:
	moveq	#-$80,d0
	bra.s	PollMagicMenuPressedMask_007D80

PollMagicMenuSubmodeAction_007D7E:
	moveq	#-$70,d0

PollMagicMenuPressedMask_007D80:
	and.b	(SelectedInputPressed_Short).w,d0
	beq.s	PollMagicMenuPressedMask_ClearResult_007D98
	moveq	#-1,d6
	rts

CheckMagicMenuSubmodeExit_007D8A:
	moveq	#MagicMenuSubmodeExitPressedMask,d0
	and.b	(SelectedInputPressed_Short).w,d0
	beq.w	PollMagicMenuPressedMask_ClearResult_007D98
	moveq	#-1,d6
	rts

PollMagicMenuPressedMask_ClearResult_007D98:
	moveq	#$00,d6
	rts

HandleInventoryMenuVisibleListInput_007D9C:
	bsr.w	UpdateInventoryMenuVisibleSelection_008212
	bsr.s	PollMagicMenuSubmodeAction_007D7E
	bne.s	HandleInventoryMenuVisibleListInput_RefreshSelectionState
	bsr.s	CheckMagicMenuSubmodeExit_007D8A
	beq.w	HandleInventoryMenuVisibleListInput_Return
	movea.w	(InventoryMenuSelectionIndex_Short).w,a0
	move.b	-$69F8(a0),d0
	andi.b	#InventoryMenuVisibleEntryIdMask,d0
	subq.b	#InventoryMenuPauseSentinelEntryId,d0
	beq.s	PlayInventoryMenuPauseSentinelSound_007E0A
	move.b	-$69F8(a0),d0
	bmi.s	HandleInventoryMenuVisibleListInput_Finalize
	movea.w	(InventoryMenuCategoryId_Short).w,a0
	move.b	-$6A33(a0),(InventoryMenuPreviousCategoryEntryId_Short).w
	move.b	d0,-$6A33(a0)
	lea	(InventoryMenuVisibleEntryIds_Short).w,a0
	move.w	(InventoryMenuVisibleEntryCount_Short).w,d1

HandleInventoryMenuVisibleListInput_MarkCurrentEntry:
	move.b	(a0),d2
	andi.b	#$7F,d2
	cmp.b	d0,d2
	bne.s	HandleInventoryMenuVisibleListInput_StoreEntry
	ori.b	#InventoryMenuVisibleEntryMarkedBit,d2

HandleInventoryMenuVisibleListInput_StoreEntry:
	move.b	d2,(a0)+
	subq.w	#$1,d1
	bne.s	HandleInventoryMenuVisibleListInput_MarkCurrentEntry

HandleInventoryMenuVisibleListInput_RefreshSelectionState:
	bsr.w	RefreshInventoryMenuSelectionState_0076E8
	bsr.w	RedrawInventoryMenuVisibleWindow_0083D0

HandleInventoryMenuVisibleListInput_Finalize:
	bsr.w	UpdateInventoryMenuScrollUpIndicator_ClearVisible
	clr.b	(InventoryMenuScrollUpIndicatorState_Short).w
	bsr.w	UpdateInventoryMenuScrollDownIndicator_ClearVisible
	clr.b	(InventoryMenuScrollDownIndicatorState_Short).w
	bsr.w	PlayInventoryMenuConfirmSound_008BAA
	moveq	#-1,d6
	rts

PlayInventoryMenuPauseSentinelSound_007E0A:
	moveq	#$35,d0
	jmp	(RunTaskHelper_0366).w

HandleInventoryMenuVisibleListInput_Return:
	rts

RunInventoryMenuVisibleEntryBlink_007E12:
	move.l	(sp)+,(InventoryMenuBlinkReturnVector_Short).w
	move.b	#InventoryMenuBlinkEffectTicks,(InventoryMenuArrowRefreshSuppressCounter_Short).w
	move.b	#InventoryMenuBlinkPhaseTicks,(InventoryMenuBlinkPhaseCountdown_Short).w
	clr.b	(InventoryMenuBlinkPhaseToggle_Short).w

RunInventoryMenuVisibleEntryBlink_Loop:
	jsr	(RunTaskHelper_0400).w
	moveq	#-$10,d0
	and.b	(SelectedInputPressed_Short).w,d0
	bne.s	RunInventoryMenuVisibleEntryBlink_Finish
	subq.b	#$1,(InventoryMenuBlinkPhaseCountdown_Short).w
	bne.s	RunInventoryMenuVisibleEntryBlink_CountDuration
	move.b	#InventoryMenuBlinkPhaseTicks,(InventoryMenuBlinkPhaseCountdown_Short).w
	bchg	#0,(InventoryMenuBlinkPhaseToggle_Short).w
	bne.s	RunInventoryMenuVisibleEntryBlink_RedrawWindow
	move.w	#$0F06,d7
	move.w	(InventoryMenuSelectionIndex_Short).w,d0
	sub.w	(InventoryMenuTopVisibleEntryIndex_Short).w,d0
	add.w	d0,d0
	add.w	d0,d7
	bsr.s	ClearInventoryMenuVisibleEntryRow_007E72
	addq.w	#$1,d7
	bsr.s	ClearInventoryMenuVisibleEntryRow_007E72
	bra.s	RunInventoryMenuVisibleEntryBlink_CountDuration

RunInventoryMenuVisibleEntryBlink_RedrawWindow:
	bsr.w	RedrawInventoryMenuVisibleWindow_0083D0

RunInventoryMenuVisibleEntryBlink_CountDuration:
	subq.b	#$1,(InventoryMenuArrowRefreshSuppressCounter_Short).w
	bcc.s	RunInventoryMenuVisibleEntryBlink_Loop

RunInventoryMenuVisibleEntryBlink_Finish:
	clr.b	(InventoryMenuArrowRefreshSuppressCounter_Short).w
	movea.l	(InventoryMenuBlinkReturnVector_Short).w,a0
	jmp	(a0)

ClearInventoryMenuVisibleEntryRow_007E72:
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	moveq	#InventoryMenuEntryDisplayWidth-1,d5
	bra.w	FillInventoryMenuTileRun_008762

DrawInventoryMenuStatusPanelBase_007E7C:
	bsr.w	UploadInventoryMenuPanelFillRows_007F98
	bsr.w	UploadInventoryMenuStatusRows_007FBA
	bsr.w	DrawInventoryMenuLevelDisplay_00853C
	bra.w	DrawInventoryMenuStatusLabels_0084C4

RunInventoryMenuPanelTransferForward_007E8C:
	move.l	(sp)+,(MenuTransferReturnVector_Short).w
	bsr.s	DrawInventoryMenuStatusPanelBase_007E7C
	move.b	#$09,(InventoryMenuTransferRowScratch_Short).w

RunInventoryMenuPanelTransferForward_Loop:
	bsr.w	UpdateSelectedInputUiRepeat_00805A
	move.b	(InventoryMenuTransferRowScratch_Short).w,(MenuTextTransferRowId_Short).w
	ori.b	#VBlankMenuTextTransferRequestMask,(VBlankDispatchFlags_Short).w
	addq.b	#$1,(InventoryMenuTransferRowScratch_Short).w
	cmpi.b	#$11,(InventoryMenuTransferRowScratch_Short).w
	bne.s	RunInventoryMenuPanelTransferForward_Loop
	movea.l	(MenuTransferReturnVector_Short).w,a0
	jmp	(a0)

RunInventoryMenuPanelTransferReverse_007EBA:
	move.l	(sp)+,(MenuTransferReturnVector_Short).w
	move.b	#$0F,(InventoryMenuTransferRowScratch_Short).w

RunInventoryMenuPanelTransferReverse_Loop:
	bsr.w	UpdateSelectedInputUiRepeat_00805A
	move.b	(InventoryMenuTransferRowScratch_Short).w,(MenuTextTransferRowId_Short).w
	ori.b	#VBlankMenuTextTransferRequestMask,(VBlankDispatchFlags_Short).w
	subq.b	#$1,(InventoryMenuTransferRowScratch_Short).w
	cmpi.b	#$07,(InventoryMenuTransferRowScratch_Short).w
	bne.s	RunInventoryMenuPanelTransferReverse_Loop
	bsr.w	UploadInventoryMenuFooterRows_007F76
	bsr.w	DrawInventoryMenuGoldDisplay_008596
	movea.l	(MenuTransferReturnVector_Short).w,a0
	jmp	(a0)

RequestInventoryMenuTransferRow0B_007EEE:
	bsr.w	UploadInventoryMenuRow0BPattern_007FF6
	move.b	#$0B,(MenuTextTransferRowId_Short).w
	ori.b	#VBlankMenuTextTransferRequestMask,(VBlankDispatchFlags_Short).w
	rts

RequestInventoryMenuTransferRow08_007F00:
	move.b	#$08,(MenuTextTransferRowId_Short).w
	ori.b	#VBlankMenuTextTransferRequestMask,(VBlankDispatchFlags_Short).w
	rts

ShowInventoryMenuPausePrompt_007F0E:
	move.l	(sp)+,(MenuTransferReturnVector_Short).w
	bsr.w	UploadInventoryMenuPauseRows_008000
	move.w	#$0E08,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	lea	InventoryMenuPauseText_007F4E(pc),a1
	bsr.w	WriteNormalTileString_007870
	move.b	#$0A,(MenuTextTransferRowId_Short).w
	ori.b	#VBlankMenuTextTransferRequestMask,(VBlankDispatchFlags_Short).w

ShowInventoryMenuPausePrompt_WaitForPrimaryAction:
	jsr	(RunTaskHelper_0400).w
	bsr.w	PollMagicMenuPrimaryAction_007D7A
	beq.s	ShowInventoryMenuPausePrompt_WaitForPrimaryAction
	move.b	#$08,(MenuTextTransferRowId_Short).w
	ori.b	#VBlankMenuTextTransferRequestMask,(VBlankDispatchFlags_Short).w
	movea.l	(MenuTransferReturnVector_Short).w,a0
	jmp	(a0)

InventoryMenuPauseText_007F4E:
	dc.b	"PAUSE",$00

UploadInventoryMenuPanelRows_007F54:
	lea	MenuRowTemplate_008CC2(pc),a0
	moveq	#$00,d1
	bsr.w	UploadPackedMenuTileRow_008024
	lea	MenuRowTemplate_008E02(pc),a0
	bsr.w	UploadPackedMenuTileRow_00802A
	lea	MenuRowTemplate_008D22(pc),a0
	bsr.w	UploadPackedMenuTileRow_00802A
	lea	MenuRowTemplate_008DE2(pc),a0
	bsr.w	UploadPackedMenuTileRow_00802A

UploadInventoryMenuFooterRows_007F76:
	moveq	#$04,d1
	lea	MenuRowTemplate_008D22(pc),a0
	bsr.w	UploadPackedMenuTileRow_008024
	lea	MenuRowTemplate_008D22(pc),a0
	bsr.w	UploadPackedMenuTileRow_00802A
	lea	MenuRowTemplate_008DC2(pc),a0
	bsr.w	UploadPackedMenuTileRow_00802A
	lea	MenuRowTemplate_008D42(pc),a0
	bra.w	UploadPackedMenuTileRow_00802A

UploadInventoryMenuPanelFillRows_007F98:
	moveq	#$04,d1
	moveq	#$08,d3
	lea	MenuRowTemplate_008D02(pc),a0
	bsr.w	UploadPackedMenuTileRow_008024

UploadInventoryMenuPanelFillRows_Loop:
	lea	MenuRowTemplate_008D02(pc),a0
	bsr.w	UploadPackedMenuTileRow_00802A
	dbra	d3,UploadInventoryMenuPanelFillRows_Loop
	moveq	#$07,d1
	lea	MenuRowTemplate_008D62(pc),a0
	bsr.w	UploadPackedMenuTileRow_008024

UploadInventoryMenuStatusRows_007FBA:
	lea	MenuRowTemplate_008DA2(pc),a0
	moveq	#$0E,d1
	bsr.w	UploadPackedMenuTileRow_008024
	lea	MenuRowTemplate_008CE2(pc),a0
	moveq	#$0F,d1
	bra.w	UploadPackedMenuTileRow_008024

PrepareMagicMenuPanelRefresh_007FCE:
	moveq	#$04,d1
	moveq	#$08,d3
	lea	MenuRowTemplate_008C82(pc),a0
	bsr.w	UploadPackedMenuTileRow_008024

PrepareMagicMenuPanelRefresh_007FCE_Loop:
	lea	MenuRowTemplate_008C82(pc),a0
	bsr.w	UploadPackedMenuTileRow_00802A
	dbra	d3,PrepareMagicMenuPanelRefresh_007FCE_Loop
	lea	MenuRowTemplate_008D82(pc),a0
	bsr.w	UploadPackedMenuTileRow_00802A
	lea	MenuRowTemplate_008CA2(pc),a0
	bra.w	UploadPackedMenuTileRow_00802A

UploadInventoryMenuRow0BPattern_007FF6:
	moveq	#$08,d1
	bsr.s	UploadLiteralMenuTileRow_008010
	lea	MenuRowTemplate_008CA2(pc),a0
	bra.s	UploadPackedMenuTileRow_00802A

UploadInventoryMenuPauseRows_008000:
	lea	MenuRowTemplate_008D82(pc),a0
	moveq	#$08,d1
	bsr.s	UploadPackedMenuTileRow_008024
	moveq	#$09,d1
	lea	MenuRowTemplate_008CA2(pc),a0
	bra.s	UploadPackedMenuTileRow_008024

UploadLiteralMenuTileRow_008010:
	moveq	#$00,d0
	bsr.w	BuildInventoryMenuVramWriteCommandFromTileCoords_0083B8
	moveq	#$1F,d2

UploadLiteralMenuTileRow_Loop:
	move.l	(a0)+,(VDP_DATA_PORT).l
	dbra	d2,UploadLiteralMenuTileRow_Loop
	rts

UploadPackedMenuTileRow_008024:
	moveq	#$00,d0
	bsr.w	BuildInventoryMenuVramWriteCommandFromTileCoords_0083B8

UploadPackedMenuTileRow_00802A:
	moveq	#$1F,d2

UploadPackedMenuTileRow_Loop:
	moveq	#$00,d0
	move.b	(a0)+,d0
	move.w	d0,d1
	andi.b	#$0F,d0
	lsr.b	#$4,d1
	add.b	d1,d1
	or.w	PackedMenuTileBaseTable_00804A(pc,d1.w),d0
	move.w	d0,(VDP_DATA_PORT).l
	dbra	d2,UploadPackedMenuTileRow_Loop
	rts

PackedMenuTileBaseTable_00804A:
	dc.w	$87A0,$87B0,$8FA0,$8FB0,$97A0,$97B0,$9FA0,$9FB0

UpdateSelectedInputUiRepeat_00805A:
	move.l	(sp)+,(SelectedInputRepeatReturnVector_Short).w
	jsr	(RunTaskHelper_0400).w
	move.b	(SelectedInputPressed_Short).w,d0
	beq.s	UpdateSelectedInputUiRepeat_CheckHeldInput
	move.b	#$10,(SelectedInputRepeatCountdown_Short).w
	move.b	(SelectedInputCurrent_Short).w,(SelectedInputRepeatLatchedValue_Short).w
	bra.s	UpdateSelectedInputUiRepeat_StoreOutput

UpdateSelectedInputUiRepeat_CheckHeldInput:
	move.b	(SelectedInputCurrent_Short).w,d0
	beq.s	UpdateSelectedInputUiRepeat_StoreOutput
	cmp.b	(SelectedInputRepeatLatchedValue_Short).w,d0
	bne.s	UpdateSelectedInputUiRepeat_LatchHeldInput
	subq.b	#$1,(SelectedInputRepeatCountdown_Short).w
	bne.s	UpdateSelectedInputUiRepeat_LatchHeldInput
	move.b	#$08,(SelectedInputRepeatCountdown_Short).w
	bra.s	UpdateSelectedInputUiRepeat_StoreOutput

UpdateSelectedInputUiRepeat_LatchHeldInput:
	move.b	d0,(SelectedInputRepeatLatchedValue_Short).w
	moveq	#$00,d0

UpdateSelectedInputUiRepeat_StoreOutput:
	move.b	d0,(SelectedInputRepeatOutput_Short).w
	bsr.w	UpdateInventoryMenuListCursorBlink_0081A8
	bsr.s	UpdateInventoryMenuScrollUpIndicator_0080A8
	bsr.s	UpdateInventoryMenuScrollDownIndicator_0080FA
	movea.l	(SelectedInputRepeatReturnVector_Short).w,a0
	jmp	(a0)

UpdateInventoryMenuScrollUpIndicator_0080A8:
	btst	#InventoryMenuBlinkEnabledBit,(InventoryMenuScrollUpIndicatorState_Short).w
	beq.w	InventoryMenuBlink_Return_008210
	subq.b	#$1,(InventoryMenuScrollUpIndicatorCountdown_Short).w
	bne.w	InventoryMenuBlink_Return_008210
	btst	#InventoryMenuBlinkVisibleBit,(InventoryMenuScrollUpIndicatorState_Short).w
	bne.s	UpdateInventoryMenuScrollUpIndicator_ClearVisible
	bra.s	UpdateInventoryMenuScrollUpIndicator_ShowVisible

UpdateInventoryMenuScrollUpIndicator_ClearVisible:
	bclr	#InventoryMenuBlinkVisibleBit,(InventoryMenuScrollUpIndicatorState_Short).w
	beq.w	InventoryMenuBlink_Return_008210
	move.w	#InventoryMenuBlankTile,d6
	bra.s	UpdateInventoryMenuScrollUpIndicator_Draw

UpdateInventoryMenuScrollUpIndicator_ShowVisible:
	btst	#InventoryMenuBlinkVisibleBit,(InventoryMenuScrollUpIndicatorState_Short).w
	beq.s	UpdateInventoryMenuScrollUpIndicator_EnableVisible
	bsr.s	UpdateInventoryMenuScrollUpIndicator_ClearVisible

UpdateInventoryMenuScrollUpIndicator_EnableVisible:
	bset	#InventoryMenuBlinkVisibleBit,(InventoryMenuScrollUpIndicatorState_Short).w
	move.w	#InventoryMenuScrollUpTile,d6

UpdateInventoryMenuScrollUpIndicator_Draw:
	move.b	#InventoryMenuBlinkDelayTicks,(InventoryMenuScrollUpIndicatorCountdown_Short).w
	move.w	#$16,d4
	move.w	#$05,d5
	bra.w	WriteInventoryMenuTile_008200

UpdateInventoryMenuScrollDownIndicator_0080FA:
	btst	#InventoryMenuBlinkEnabledBit,(InventoryMenuScrollDownIndicatorState_Short).w
	beq.w	InventoryMenuBlink_Return_008210
	subq.b	#$1,(InventoryMenuScrollDownIndicatorCountdown_Short).w
	bne.w	InventoryMenuBlink_Return_008210
	btst	#InventoryMenuBlinkVisibleBit,(InventoryMenuScrollDownIndicatorState_Short).w
	bne.s	UpdateInventoryMenuScrollDownIndicator_ClearVisible
	bra.s	UpdateInventoryMenuScrollDownIndicator_ShowVisible

UpdateInventoryMenuScrollDownIndicator_ClearVisible:
	bclr	#InventoryMenuBlinkVisibleBit,(InventoryMenuScrollDownIndicatorState_Short).w
	beq.w	InventoryMenuBlink_Return_008210
	move.w	#InventoryMenuBlankTile,d6
	bra.s	UpdateInventoryMenuScrollDownIndicator_Draw

UpdateInventoryMenuScrollDownIndicator_ShowVisible:
	btst	#InventoryMenuBlinkVisibleBit,(InventoryMenuScrollDownIndicatorState_Short).w
	beq.s	UpdateInventoryMenuScrollDownIndicator_EnableVisible
	bsr.s	UpdateInventoryMenuScrollDownIndicator_ClearVisible

UpdateInventoryMenuScrollDownIndicator_EnableVisible:
	bset	#InventoryMenuBlinkVisibleBit,(InventoryMenuScrollDownIndicatorState_Short).w
	move.w	#InventoryMenuScrollDownTile,d6

UpdateInventoryMenuScrollDownIndicator_Draw:
	move.b	#InventoryMenuBlinkDelayTicks,(InventoryMenuScrollDownIndicatorCountdown_Short).w
	moveq	#$16,d4
	moveq	#$0E,d5
	bra.w	WriteInventoryMenuTile_008200

UpdateInventoryMenuAuxCursorBlink_008148:
	btst	#InventoryMenuBlinkEnabledBit,(InventoryMenuAuxCursorState_Short).w
	beq.w	InventoryMenuBlink_Return_008210
	subq.b	#$1,(InventoryMenuAuxCursorCountdown_Short).w
	bne.w	InventoryMenuBlink_Return_008210
	btst	#InventoryMenuBlinkVisibleBit,(InventoryMenuAuxCursorState_Short).w
	bne.s	UpdateInventoryMenuAuxCursor_ClearVisible
	bra.s	UpdateInventoryMenuAuxCursor_ShowVisible

UpdateInventoryMenuAuxCursor_ClearVisible:
	bclr	#InventoryMenuBlinkVisibleBit,(InventoryMenuAuxCursorState_Short).w
	beq.w	InventoryMenuBlink_Return_008210
	move.w	(InventoryMenuAuxCursorTileX_Short).w,d4
	move.w	(InventoryMenuAuxCursorTileY_Short).w,d5
	move.w	#InventoryMenuBlankTile,d6
	bra.s	UpdateInventoryMenuAuxCursor_Draw

UpdateInventoryMenuAuxCursor_ShowVisible:
	btst	#InventoryMenuBlinkVisibleBit,(InventoryMenuAuxCursorState_Short).w
	beq.s	UpdateInventoryMenuAuxCursor_EnableVisible
	bsr.s	UpdateInventoryMenuAuxCursor_ClearVisible

UpdateInventoryMenuAuxCursor_EnableVisible:
	bset	#InventoryMenuBlinkVisibleBit,(InventoryMenuAuxCursorState_Short).w
	move.w	(InventoryMenuAuxCursorSavedTileX_Short).w,d4
	move.w	(InventoryMenuAuxCursorSavedTileY_Short).w,d5
	move.w	d4,(InventoryMenuAuxCursorTileX_Short).w
	move.w	d5,(InventoryMenuAuxCursorTileY_Short).w
	move.w	#InventoryMenuCursorTile,d6

UpdateInventoryMenuAuxCursor_Draw:
	move.b	#InventoryMenuBlinkDelayTicks,(InventoryMenuAuxCursorCountdown_Short).w
	bra.s	WriteInventoryMenuTile_008200

UpdateInventoryMenuListCursorBlink_0081A8:
	btst	#InventoryMenuBlinkEnabledBit,(InventoryMenuListCursorState_Short).w
	beq.s	InventoryMenuBlink_Return_008210
	subq.b	#$1,(InventoryMenuListCursorCountdown_Short).w
	bne.s	InventoryMenuBlink_Return_008210
	btst	#InventoryMenuBlinkVisibleBit,(InventoryMenuListCursorState_Short).w
	bne.s	UpdateInventoryMenuListCursor_ClearVisible
	bra.s	UpdateInventoryMenuListCursor_ShowVisible

UpdateInventoryMenuListCursor_ClearVisible:
	bclr	#InventoryMenuBlinkVisibleBit,(InventoryMenuListCursorState_Short).w
	beq.s	InventoryMenuBlink_Return_008210
	move.b	(InventoryMenuListCursorSavedTileX_Short).w,d4
	move.b	(InventoryMenuListCursorSavedTileY_Short).w,d5
	move.w	#InventoryMenuBlankTile,d6
	bra.s	UpdateInventoryMenuListCursor_Draw

UpdateInventoryMenuListCursor_ShowVisible:
	btst	#InventoryMenuBlinkVisibleBit,(InventoryMenuListCursorState_Short).w
	beq.s	UpdateInventoryMenuListCursor_EnableVisible
	bsr.s	UpdateInventoryMenuListCursor_ClearVisible

UpdateInventoryMenuListCursor_EnableVisible:
	bset	#InventoryMenuBlinkVisibleBit,(InventoryMenuListCursorState_Short).w
	move.b	(InventoryMenuListCursorTileX_Short).w,d4
	move.b	(InventoryMenuListCursorTileY_Short).w,d5
	move.b	d4,(InventoryMenuListCursorSavedTileX_Short).w
	move.b	d5,(InventoryMenuListCursorSavedTileY_Short).w
	move.w	#InventoryMenuCursorTile,d6

UpdateInventoryMenuListCursor_Draw:
	move.b	#InventoryMenuBlinkDelayTicks,(InventoryMenuListCursorCountdown_Short).w

WriteInventoryMenuTile_008200:
	move.b	d4,d7
	lsl.w	#$8,d7
	move.b	d5,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.w	d6,(VDP_DATA_PORT).l

InventoryMenuBlink_Return_008210:
	rts

UpdateInventoryMenuVisibleSelection_008212:
	move.w	(InventoryMenuSelectionIndex_Short).w,d3
	btst	#InventoryMenuBlinkEnabledBit,(SelectedInputRepeatOutput_Short).w
	beq.s	UpdateInventoryMenuVisibleSelection_CheckDown
	subq.w	#$1,d3
	bmi.s	UpdateInventoryMenuVisibleSelection_Return
	bra.s	UpdateInventoryMenuVisibleSelection_StoreIndex

UpdateInventoryMenuVisibleSelection_CheckDown:
	btst	#InventoryMenuBlinkVisibleBit,(SelectedInputRepeatOutput_Short).w
	beq.s	UpdateInventoryMenuVisibleSelection_Return
	addq.w	#$1,d3
	cmp.w	(InventoryMenuVisibleEntryCount_Short).w,d3
	bcc.s	UpdateInventoryMenuVisibleSelection_Return

UpdateInventoryMenuVisibleSelection_StoreIndex:
	move.w	d3,(InventoryMenuSelectionIndex_Short).w
	move.w	d3,d0
	sub.w	(InventoryMenuTopVisibleEntryIndex_Short).w,d0
	bcc.s	UpdateInventoryMenuVisibleSelection_CheckWindowBottom
	move.w	d3,(InventoryMenuTopVisibleEntryIndex_Short).w
	bra.s	UpdateInventoryMenuVisibleSelection_RedrawWindow

UpdateInventoryMenuVisibleSelection_CheckWindowBottom:
	cmpi.w	#InventoryMenuVisibleRowCount,d0
	bcs.s	UpdateInventoryMenuVisibleSelection_UpdateCursorY
	move.w	d3,d0
	subq.w	#$3,d0
	move.w	d0,(InventoryMenuTopVisibleEntryIndex_Short).w

UpdateInventoryMenuVisibleSelection_RedrawWindow:
	bsr.w	RedrawInventoryMenuVisibleWindow_0083D0

UpdateInventoryMenuVisibleSelection_UpdateCursorY:
	move.w	(InventoryMenuSelectionIndex_Short).w,d3
	sub.w	(InventoryMenuTopVisibleEntryIndex_Short).w,d3
	add.w	d3,d3
	addq.w	#$7,d3
	move.b	d3,(InventoryMenuListCursorTileY_Short).w
	bsr.w	UpdateInventoryMenuListCursor_ShowVisible
	bra.w	PlayInventoryMenuMoveSound_008BB0

UpdateInventoryMenuVisibleSelection_Return:
	rts

DrawInventoryMenuHeading_008272:
	move.w	(InventoryMenuCategoryId_Short).w,d0
	add.w	d0,d0
	lea	InventoryMenuHeadingOffsetTable_0082B6(pc),a1
	adda.w	0(a1,d0.w),a1
	moveq	#$0,d1
	cmpi.w	#$0A,d0
	bmi.s	DrawInventoryMenuHeading_LoadCoords
	moveq	#$2,d1

DrawInventoryMenuHeading_LoadCoords:
	move.w	InventoryMenuHeadingCoordsTable_0082B2(pc,d1.w),d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	lea	(VDP_DATA_PORT).l,a0
	move.l	#$87AE87AF,(a0)
	move.w	#InventoryMenuBlankTile,(a0)
	bsr.w	WriteNullTerminatedTileString_00786A
	move.w	#InventoryMenuBlankTile,(a0)
	move.l	#$8FAF8FAE,(a0)
	rts

InventoryMenuHeadingCoordsTable_0082B2:
	dc.w	InventoryMenuHeadingCoordsWide
	dc.w	InventoryMenuHeadingCoordsNarrow

InventoryMenuHeadingOffsetTable_0082B6:
	dc.w	InventoryMenuHeadingText_Select-InventoryMenuHeadingOffsetTable_0082B6
	dc.w	InventoryMenuHeadingText_Weapon-InventoryMenuHeadingOffsetTable_0082B6
	dc.w	InventoryMenuHeadingText_Armor-InventoryMenuHeadingOffsetTable_0082B6
	dc.w	InventoryMenuHeadingText_Shield-InventoryMenuHeadingOffsetTable_0082B6
	dc.w	InventoryMenuHeadingText_Boots-InventoryMenuHeadingOffsetTable_0082B6
	dc.w	InventoryMenuHeadingText_Item-InventoryMenuHeadingOffsetTable_0082B6
	dc.w	InventoryMenuHeadingText_Magic-InventoryMenuHeadingOffsetTable_0082B6

InventoryMenuHeadingText_Select:
	dc.b	"SELECT",$00
InventoryMenuHeadingText_Weapon:
	dc.b	"WEAPON",$00
InventoryMenuHeadingText_Armor:
	dc.b	"ARMOR ",$00
InventoryMenuHeadingText_Shield:
	dc.b	"SHIELD",$00
InventoryMenuHeadingText_Boots:
	dc.b	"BOOTS ",$00
InventoryMenuHeadingText_Item:
	dc.b	"ITEM",$00
InventoryMenuHeadingText_Magic:
	dc.b	"MAGIC",$00
	dc.b	$00,$00

BuildInventoryMenuVisibleEntryList_0082F4:
	movea.w	(InventoryMenuCategoryDescriptorBase_Short).w,a0
	move.b	-$6A36(a0),d1
	move.b	-$6A32(a0),d3
	moveq	#$00,d2
	moveq	#$00,d0
	lea	(InventoryMenuVisibleEntryIds_Short).w,a0

BuildInventoryMenuVisibleEntryList_Next:
	btst	#InventoryMenuBlinkEnabledBit,d1
	beq.s	BuildInventoryMenuVisibleEntryList_AdvanceBit
	addq.w	#$1,d2
	move.b	d0,(a0)
	cmp.b	d0,d3
	bne.s	BuildInventoryMenuVisibleEntryList_NextSlot
	ori.b	#$80,(a0)

BuildInventoryMenuVisibleEntryList_NextSlot:
	addq.w	#$1,a0

BuildInventoryMenuVisibleEntryList_AdvanceBit:
	addq.b	#$1,d0
	lsr.b	#$1,d1
	bne.s	BuildInventoryMenuVisibleEntryList_Next
	move.w	d2,(InventoryMenuVisibleEntryCount_Short).w

InventoryMenuRefreshScrollIndicators_008326:
	tst.w	(InventoryMenuTopVisibleEntryIndex_Short).w
	bne.s	BuildInventoryMenuVisibleEntryList_CheckDownArrow
	btst	#InventoryMenuBlinkEnabledBit,(InventoryMenuScrollUpIndicatorState_Short).w
	beq.s	BuildInventoryMenuVisibleEntryList_CheckDownArrowBase
	bsr.w	UpdateInventoryMenuScrollUpIndicator_ClearVisible
	clr.b	(InventoryMenuScrollUpIndicatorState_Short).w
	bra.s	BuildInventoryMenuVisibleEntryList_CheckDownArrowBase

BuildInventoryMenuVisibleEntryList_CheckDownArrow:
	bset	#InventoryMenuBlinkEnabledBit,(InventoryMenuScrollUpIndicatorState_Short).w
	bne.s	BuildInventoryMenuVisibleEntryList_CheckDownArrowBase
	bsr.s	CheckInventoryMenuCanScrollDown_0083A4
	beq.s	BuildInventoryMenuVisibleEntryList_HideDownArrow
	bset	#InventoryMenuBlinkEnabledBit,(InventoryMenuScrollDownIndicatorState_Short).w
	move.b	#InventoryMenuBlinkDelayTicks,(InventoryMenuScrollDownIndicatorCountdown_Short).w
	bsr.w	UpdateInventoryMenuScrollDownIndicator_ShowVisible
	bra.w	UpdateInventoryMenuScrollUpIndicator_ShowVisible

BuildInventoryMenuVisibleEntryList_HideDownArrow:
	bsr.w	UpdateInventoryMenuScrollDownIndicator_ClearVisible
	clr.b	(InventoryMenuScrollDownIndicatorState_Short).w
	bra.w	UpdateInventoryMenuScrollUpIndicator_ShowVisible

BuildInventoryMenuVisibleEntryList_CheckDownArrowBase:
	bsr.s	CheckInventoryMenuCanScrollDown_0083A4
	bcs.s	BuildInventoryMenuVisibleEntryList_EnableDownArrow
	btst	#InventoryMenuBlinkEnabledBit,(InventoryMenuScrollDownIndicatorState_Short).w
	beq.s	BuildInventoryMenuVisibleEntryList_Return
	bsr.w	UpdateInventoryMenuScrollDownIndicator_ClearVisible
	clr.b	(InventoryMenuScrollDownIndicatorState_Short).w
	bra.s	BuildInventoryMenuVisibleEntryList_Return

BuildInventoryMenuVisibleEntryList_EnableDownArrow:
	bset	#InventoryMenuBlinkEnabledBit,(InventoryMenuScrollDownIndicatorState_Short).w
	bne.s	BuildInventoryMenuVisibleEntryList_Return
	bsr.w	UpdateInventoryMenuScrollDownIndicator_ShowVisible
	tst.w	(InventoryMenuTopVisibleEntryIndex_Short).w
	beq.s	BuildInventoryMenuVisibleEntryList_Return
	bset	#InventoryMenuBlinkEnabledBit,(InventoryMenuScrollUpIndicatorState_Short).w
	move.b	#InventoryMenuBlinkDelayTicks,(InventoryMenuScrollUpIndicatorCountdown_Short).w
	bra.w	UpdateInventoryMenuScrollUpIndicator_ShowVisible

BuildInventoryMenuVisibleEntryList_Return:
	rts

CheckInventoryMenuCanScrollDown_0083A4:
	move.w	(InventoryMenuTopVisibleEntryIndex_Short).w,d0
	addq.w	#InventoryMenuVisibleRowCount,d0
	cmp.w	(InventoryMenuVisibleEntryCount_Short).w,d0
	rts

BuildInventoryMenuVramWriteCommand_0083B0:
	move.w	d7,d0
	moveq	#$00,d1
	move.b	d0,d1
	lsr.w	#$8,d0

BuildInventoryMenuVramWriteCommandFromTileCoords_0083B8:
	lsl.w	#$5,d1
	or.w	d1,d0
	add.w	d0,d0
	ori.w	#$5800,d0
	swap	d0
	move.w	#$0003,d0
	move.l	d0,(VDP_CONTROL_PORT).l
	rts

RedrawInventoryMenuVisibleWindow_0083D0:
	link	a6,#-$0C
	move.w	#$0F06,d7
	move.w	(InventoryMenuVisibleEntryCount_Short).w,d0
	move.w	(InventoryMenuTopVisibleEntryIndex_Short).w,d2
	sub.w	d2,d0
	moveq	#InventoryMenuVisibleRowCount,d1
	cmp.w	d1,d0
	bcs.s	RedrawInventoryMenuVisibleWindow_ClampVisibleRows
	move.w	d1,d0

RedrawInventoryMenuVisibleWindow_ClampVisibleRows:
	move.w	d0,-$02(a6)
	sub.w	d0,d1
	move.w	d1,-$04(a6)
	lea	(InventoryMenuVisibleEntryIds_Short).w,a0
	adda.w	d2,a0
	move.w	a0,-$06(a6)

RedrawInventoryMenuVisibleWindow_NextEntry:
	movea.w	-$06(a6),a0
	move.w	#InventoryMenuNormalEntryTileBase,d1
	move.b	(a0)+,d0
	bpl.s	RedrawInventoryMenuVisibleWindow_StoreTileBase
	move.w	#InventoryMenuSelectedEntryTileBase,d1
	move.w	a0,-$06(a6)

RedrawInventoryMenuVisibleWindow_StoreTileBase:
	move.w	d1,-$08(a6)
	andi.w	#InventoryMenuVisibleEntrySelectedBit,d0
	move.w	a0,-$06(a6)
	move.w	(InventoryMenuCategoryId_Short).w,d1
	subq.w	#$1,d1
	lsl.w	#$3,d1
	add.w	d1,d0
	jsr	(BuildInventoryMenuEntryTileRows_001E6A).w
	moveq	#$00,d0
	moveq	#InventoryMenuEntryDisplayWidth,d1
	sub.w	(InventoryMenuEntryTextWidth_Short).w,d1
	lsr.w	#$1,d1
	addx.w	d1,d0
	move.w	d1,-$0A(a6)
	move.w	d0,-$0C(a6)
	lea	(VDP_DATA_PORT).l,a1
	lea	(InventoryMenuEntryTileRow0Buffer_Short).w,a0
	bsr.s	DrawInventoryMenuBufferedRow_008476
	lea	(InventoryMenuEntryTileRow1Buffer_Short).w,a0
	bsr.s	DrawInventoryMenuBufferedRow_008476
	subq.w	#$1,-$02(a6)
	bne.s	RedrawInventoryMenuVisibleWindow_NextEntry
	tst.w	-$04(a6)
	beq.s	RedrawInventoryMenuVisibleWindow_Finalize

RedrawInventoryMenuVisibleWindow_ClearRemainingRows:
	bsr.s	ClearInventoryMenuRow_0084AE
	bsr.s	ClearInventoryMenuRow_0084AE
	subq.w	#$1,-$04(a6)
	bne.s	RedrawInventoryMenuVisibleWindow_ClearRemainingRows

RedrawInventoryMenuVisibleWindow_Finalize:
	unlk	a6
	tst.b	(InventoryMenuSkipArrowRefreshFlag_Short).w
	bne.s	RedrawInventoryMenuVisibleWindow_Return
	bra.w	InventoryMenuRefreshScrollIndicators_008326

RedrawInventoryMenuVisibleWindow_Return:
	rts

DrawInventoryMenuBufferedRow_008476:
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.w	-$0A(a6),d0
	beq.s	DrawInventoryMenuBufferedRow_WriteEntryTiles

DrawInventoryMenuBufferedRow_LeftPad:
	move.w	#InventoryMenuBlankTile,d1

DrawInventoryMenuBufferedRow_LeftPad_Loop:
	move.w	d1,(a1)
	subq.w	#$1,d0
	bne.s	DrawInventoryMenuBufferedRow_LeftPad_Loop

DrawInventoryMenuBufferedRow_WriteEntryTiles:
	move.w	-$08(a6),d1
	move.w	(InventoryMenuEntryTextWidth_Short).w,d0

DrawInventoryMenuBufferedRow_WriteEntryTiles_Loop:
	move.b	(a0)+,d1
	move.w	d1,(a1)
	subq.w	#$1,d0
	bne.s	DrawInventoryMenuBufferedRow_WriteEntryTiles_Loop
	move.w	-$0C(a6),d0
	beq.s	DrawInventoryMenuBufferedRow_AdvanceLine

DrawInventoryMenuBufferedRow_RightPad:
	move.w	#InventoryMenuBlankTile,d1

DrawInventoryMenuBufferedRow_RightPad_Loop:
	move.w	d1,(a1)
	subq.w	#$1,d0
	bne.s	DrawInventoryMenuBufferedRow_RightPad_Loop

DrawInventoryMenuBufferedRow_AdvanceLine:
	addq.w	#$1,d7
	rts

ClearInventoryMenuRow_0084AE:
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	moveq	#$00,d0
	move.w	#InventoryMenuBlankTile,d1

ClearInventoryMenuRow_Loop_0084B8:
	move.w	d1,(VDP_DATA_PORT).l
	dbf	d0,ClearInventoryMenuRow_Loop_0084B8
	rts

DrawInventoryMenuStatusLabels_0084C4:
	move.w	#$0209,d7
	lea	InventoryMenuStatusLabelTable_0084DE(pc),a1
	moveq	#$02,d3

DrawInventoryMenuStatusLabels_Loop:
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	bsr.w	WriteNullTerminatedTileString_00786A
	addq.b	#$2,d7
	dbf	d3,DrawInventoryMenuStatusLabels_Loop
	rts

InventoryMenuStatusLabelTable_0084DE:
	dc.b	"AP",$00
	dc.b	"DP",$00
	dc.b	"SP",$00
InventoryMenuGoldLabelText_0084E7:
	dc.b	"GOLD",$00

FormatDecimalValueToDigitScratch_0084EC:
	lea	(DecimalDigitScratchBuffer_Short).w,a0
	moveq	#$00,d3
	cmpi.l	#DecimalDisplayClampMax,d0
	bcs.s	FormatDecimalValueToDigitScratch_DivideLoop
	move.l	#DecimalDisplayClampMax,d0

FormatDecimalValueToDigitScratch_DivideLoop:
	bsr.s	DivideLongBy10_008522
	addq.b	#$1,d3
	move.b	d1,(a0)+
	tst.l	d0
	bne.s	FormatDecimalValueToDigitScratch_DivideLoop
	rts

WriteRightAlignedDecimalDigits_00850C:
	subq.w	#$1,d3

WriteRightAlignedDecimalDigits_Loop:
	moveq	#$00,d0
	move.b	-(a0),d0
	addi.w	#HudDigitTileBase,d0
	move.w	d0,(VDP_DATA_PORT).l
	dbf	d3,WriteRightAlignedDecimalDigits_Loop
	rts

DivideLongBy10_008522:
	moveq	#$00,d1
	moveq	#$1F,d2

DivideLongBy10_Loop:
	add.l	d0,d0
	addx.w	d1,d1
	cmpi.w	#$0A,d1
	bcs.s	DivideLongBy10_NextBit
	subi.w	#$0A,d1
	addq.w	#$1,d0

DivideLongBy10_NextBit:
	dbf	d2,DivideLongBy10_Loop
	rts

DrawInventoryMenuLevelDisplay_00853C:
	bsr.w	DrawInventoryMenuStatusGraphicSet_0085CC
	move.w	#$0606,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.b	(PlayerLevel_Short).w,(InventoryMenuLevelScratch_Short).w
	move.w	#$0706,d7
	move.w	#InventoryMenuLevelMarkerTile,(VDP_DATA_PORT).l
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.w	#HudDigitTileBase,d2
	moveq	#$00,d3
	move.b	(InventoryMenuLevelScratch_Short).w,d3
	moveq	#$00,d4
	lea	(VDP_DATA_PORT).l,a1

DrawInventoryMenuLevelDisplay_CountTens:
	subi.w	#$0A,d3
	bcs.s	DrawInventoryMenuLevelDisplay_DrawDigits
	addq.w	#$1,d4
	bra.s	DrawInventoryMenuLevelDisplay_CountTens

DrawInventoryMenuLevelDisplay_DrawDigits:
	addi.w	#$0A,d3
	tst.w	d4
	beq.s	DrawInventoryMenuLevelDisplay_OneDigit
	or.w	d2,d4
	move.w	d4,(a1)
	or.w	d2,d3
	move.w	d3,(a1)
	rts

DrawInventoryMenuLevelDisplay_OneDigit:
	or.w	d2,d3
	move.w	d3,(a1)
	move.w	#InventoryMenuBlankTile,(a1)
	rts

DrawInventoryMenuGoldDisplay_008596:
	moveq	#$06,d3
	move.w	#$1605,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	lea	InventoryMenuGoldLabelText_0084E7(pc),a1
	bsr.w	WriteNullTerminatedTileString_00786A
	move.w	#$1806,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	moveq	#$06,d5
	bsr.w	FillInventoryMenuTileRun_008762
	move.l	(PlayerGoldAmount_Short).w,d0
	bsr.w	FormatDecimalValueToDigitScratch_0084EC
	moveq	#$1E,d0
	sub.w	d3,d0
	moveq	#$06,d1
	bsr.w	BuildInventoryMenuVramWriteCommandFromTileCoords_0083B8
	bra.w	WriteRightAlignedDecimalDigits_00850C

DrawInventoryMenuStatusGraphicSet_0085CC:
	moveq	#$02,d0
	move.w	InventoryMenuStatusGraphicCoordsTable_0085EC(pc,d0.w),d7
	lea	InventoryMenuStatusGraphicTileTable_0085DC(pc),a0
	lsl.w	#$2,d0
	adda.w	d0,a0
	bra.s	DrawInventoryMenuLiteralTileQuad_008608

InventoryMenuStatusGraphicTileTable_0085DC:
	dc.l	$87B78FB7
	dc.l	$97B79FB7
	dc.l	$87808784
	dc.l	$87908F90

InventoryMenuStatusGraphicCoordsTable_0085EC:
	dc.w	$1901
	dc.w	$0305

DrawInventoryMenuTileQuad_0085F0:
	lea	(VDP_DATA_PORT).l,a1
	bsr.s	DrawInventoryMenuTilePair_0085FC
	addq.w	#$1,d7
	subq.w	#$1,d6

DrawInventoryMenuTilePair_0085FC:
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.w	d6,(a1)
	addq.w	#$2,d6
	move.w	d6,(a1)
	rts

DrawInventoryMenuLiteralTileQuad_008608:
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.l	(a0)+,(VDP_DATA_PORT).l
	addq.w	#$1,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.l	(a0)+,(VDP_DATA_PORT).l
	rts

DrawMagicMenuStatusGraphics_008620:
	move.w	#$1601,d7
	move.w	#$87E0,d6
	moveq	#$00,d0
	moveq	#$00,d3
	move.b	(MagicMenuStatusValue0_Short).w,d3
	cmp.b	(MagicMenuStatusGraphicCache0_Short).w,d3
	dc.b	$67,$20	; beq.s DrawMagicMenuStatusGraphics_SelectGraphic
	move.w	#$FC00,d0
	dc.b	$60,$1A	; bra.s DrawMagicMenuStatusGraphics_SelectGraphic

DrawMagicMenuStatusGraphics_AltEntrySlot1_00863C:
	move.w	#$1C01,d7
	move.w	#$87E4,d6
	moveq	#$00,d0
	moveq	#$00,d3
	move.b	(MagicMenuStatusValue1_Short).w,d3
	cmp.b	(MagicMenuStatusGraphicCache1_Short).w,d3
	dc.b	$67,$04	; beq.s DrawMagicMenuStatusGraphics_SelectGraphic
	move.w	#$FC80,d0

DrawMagicMenuStatusGraphics_SelectGraphic:
	cmpi.b	#$FF,d3
	dc.b	$67,$46	; beq.s DrawMagicMenuStatusGraphics_UploadAndDraw
	cmpi.w	#$08,d3
	dc.b	$65,$32	; bcs.s DrawMagicMenuStatusGraphics_SelectLowGraphic
	subq.w	#$8,d3
	dc.b	$60,$12	; bra.s DrawMagicMenuStatusGraphics_SelectAfterSlot2Load

DrawMagicMenuStatusGraphics_AltEntrySlot2_008666:
	move.w	#$1605,d7
	move.w	#$FD00,d0
	move.w	#$87E8,d6
	move.w	(MagicMenuStatusValue2_Short).w,d3
	dc.b	$6B,$2A	; bmi.s DrawMagicMenuStatusGraphics_UploadAndDraw

DrawMagicMenuStatusGraphics_SelectAfterSlot2Load:
DrawMagicMenuStatusGraphics_SelectHighGraphic:
	cmpi.w	#$04,d3
	dc.b	$67,$08	; beq.s DrawMagicMenuStatusGraphics_DrawReturnIcon
	lea	MagicMenuStatusGraphicPatternIdTableHigh_008690(pc),a1
	adda.w	d3,a1
	dc.b	$60,$20	; bra.s DrawMagicMenuStatusGraphics_UploadAndDraw

DrawMagicMenuStatusGraphics_DrawReturnIcon:
	lea	($7BAA).l,a0
	bra.w	DrawInventoryMenuLiteralTileQuad_008608

MagicMenuStatusGraphicPatternIdTableHigh_008690:
	dc.b	$28,$2C,$30,$34

DrawMagicMenuStatusGraphics_SelectLowGraphic:
	lea	MagicMenuStatusGraphicPatternIdTableLow_00869C(pc),a1
	adda.w	d3,a1
	dc.b	$60,$0A	; bra.s DrawMagicMenuStatusGraphics_UploadAndDraw

MagicMenuStatusGraphicPatternIdTableLow_00869C:
	dc.b	$C4,$CC,$C0,$C8,$D0,$D4

DrawMagicMenuStatusGraphics_UploadAndDraw:
	lea	MagicMenuStatusGraphicUploadCache_008C80(pc),a1
	tst.w	d0
	dc.b	$67,$0E	; beq.s DrawMagicMenuStatusGraphics_DrawTileQuad
	moveq	#$00,d1
	move.w	#$2000,d1
	add.b	(a1),d1
	moveq	#$20,d2
	jsr	(UploadMenuPatternStrip_0022A8).w

DrawMagicMenuStatusGraphics_DrawTileQuad:
	bra.w	DrawInventoryMenuTileQuad_0085F0

LoadMagicMenuStatusLayoutConfig_0086BC:
	lea	MagicMenuStatusLayoutLockedRecord_00874A(pc),a0
	btst	#MagicMenuStatusLayoutLockedBit,(MagicMenuStatusLayoutFlags_Short).w
	bne.s	LoadMagicMenuStatusLayoutConfig_StoreRecord
	lea	MagicMenuStatusLayoutPageRecordTable_008750(pc),a0
	btst	#0,(MagicMenuSpellPageFlag_Short).w
	beq.s	LoadMagicMenuStatusLayoutConfig_SelectIndexedRecord
	cmpi.b	#$03,(MagicMenuStatusLayoutRecordIndex_Short).w
	bne.s	LoadMagicMenuStatusLayoutConfig_SkipPageAdvance
	addq.w	#$6,a0

LoadMagicMenuStatusLayoutConfig_SkipPageAdvance:
	bra.s	LoadMagicMenuStatusLayoutConfig_StoreRecord

LoadMagicMenuStatusLayoutConfig_SelectIndexedRecord:
	moveq	#$00,d0
	move.b	(MagicMenuStatusLayoutRecordIndex_Short).w,d0
	move.w	d0,d1
	add.w	d0,d0
	add.w	d1,d0
	add.w	d0,d0
	lea	MagicMenuStatusLayoutRecordTable_008720(pc,d0.w),a0

LoadMagicMenuStatusLayoutConfig_StoreRecord:
	moveq	#$00,d0
	move.b	(a0)+,d0
	swap	d0
	move.b	(a0)+,d0
	move.l	d0,(MagicMenuStatusLayoutConfigLong0_Short).w
	move.b	(a0)+,d0
	ext.w	d0
	asl.w	#$4,d0
	move.w	d0,(MagicMenuStatusLayoutConfigWord1_Short).w
	moveq	#$00,d0
	move.b	(a0)+,d0
	move.w	d0,(MagicMenuStatusLayoutConfigWord2_Short).w
	moveq	#$00,d0
	move.b	(a0)+,d0
	swap	d0
	move.b	(a0)+,d0
	lsl.l	#$4,d0
	move.l	d0,(MagicMenuStatusLayoutConfigLong3_Short).w
	rts

; Best-fit: when the spell-page flag is clear, these seven 6-byte records line up with the
; same seven heading/category ids that draw `SELECT`, `WEAPON`, `ARMOR`, `SHIELD`, `BOOTS`,
; `ITEM`, and `MAGIC`; with the page flag set, the smaller table below overrides that flow.
MagicMenuStatusLayoutRecordTable_008720:
	dc.b	$20,$40,$B9,$02,$20,$40
	dc.b	$1C,$40,$BA,$01,$1C,$40
	dc.b	$18,$40,$B9,$01,$18,$40
	dc.b	$18,$40,$B6,$01,$18,$40
	dc.b	$14,$40,$B6,$02,$14,$40
	dc.b	$14,$40,$B8,$01,$14,$40
	dc.b	$10,$40,$B8,$01,$10,$40

MagicMenuStatusLayoutLockedRecord_00874A:
	dc.b	$1C,$40,$B3,$01,$1C,$40

MagicMenuStatusLayoutPageRecordTable_008750:
	dc.b	$08,$08,$F4,$01,$10,$10
	dc.b	$18,$10,$EC,$01,$18,$18

FillInventoryMenuTileRun_Clear_00875C:
	move.w	#$0000,d4
	bra.s	FillInventoryMenuTileRun_WriteLoop_00876C

FillInventoryMenuTileRun_008762:
	move.w	#InventoryMenuBlankTile,d4
	bra.s	FillInventoryMenuTileRun_WriteLoop_00876C

FillInventoryMenuTileRun_SetHighTileBit_008768:
	ori.w	#$8000,d4

FillInventoryMenuTileRun_WriteLoop_00876C:
	move.w	d4,(VDP_DATA_PORT).l
	subq.w	#$1,d5
	bne.s	FillInventoryMenuTileRun_WriteLoop_00876C
	rts

; The offset table at `0x007BFE` resolves to the localized magic names
; `FIRE STORM`, `QUAKE`, `THUNDER`, `POWER`, `SHIELD`, and `RETURN`.
DrawMagicMenuSpellName_008778:
	movea.w	d0,a0
	subq.b	#$1,-$6A48(a0)
	dc.b	$66,$04	; bne.s DrawMagicMenuSpellName_LoadString
	bsr.w	NormalizeAndClearMagicMenuTopRowSelection_00882C

DrawMagicMenuSpellName_LoadString:
	lea	MagicSpellNameOffsetTable_007BFE(pc),a1
	add.w	d0,d0
	adda.w	0(a1,d0.w),a1
	addq.w	#$2,a1
	move.w	#$1501,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	jsr	(MeasureNullTerminatedTileStringWidth_01B004).l
	moveq	#$0A,d0
	sub.w	(MagicMenuSpellNameWidth_Short).w,d0
	dc.b	$66,$06	; bne.s DrawMagicMenuSpellName_PadThenDraw
	bsr.w	WriteNullTerminatedTileString_00786A
	bra.s	DrawMagicMenuSpellName_ClearSecondRow

DrawMagicMenuSpellName_PadThenDraw:
	lsr.w	#$1,d0
	moveq	#$00,d5
	addx.w	d0,d5
	bsr.s	FillInventoryMenuTileRun_008762
	bsr.w	WriteNullTerminatedTileString_00786A
	tst.w	d0
	dc.b	$67,$04	; beq.s DrawMagicMenuSpellName_ClearSecondRow
	move.w	d0,d5
	bsr.s	FillInventoryMenuTileRun_008762

DrawMagicMenuSpellName_ClearSecondRow:
	move.w	#$1502,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	moveq	#$0A,d5
	bra.w	FillInventoryMenuTileRun_008762

DrawMagicMenuMeter_0087CE:
	tst.w	d0
	dc.b	$67,$58	; beq.s DrawMagicMenuMeter_Return
	cmpi.w	#$2000,d0
	dc.b	$65,$04	; bcs.s DrawMagicMenuMeter_StoreTarget
	move.w	#$2000,d0

DrawMagicMenuMeter_StoreTarget:
	move.w	d0,d2
	move.w	#$1602,d7
	bsr.w	BuildInventoryMenuVramWriteCommand_0083B0
	move.w	d2,d0
	andi.w	#$FF00,d0
	cmp.w	(MagicMenuMeterCache_Short).w,d0
	dc.b	$67,$38	; beq.s DrawMagicMenuMeter_Return
	move.w	d0,(MagicMenuMeterCache_Short).w
	move.w	#$879A,d1
	moveq	#$07,d2
	move.w	#$0400,d3

DrawMagicMenuMeter_FillLoop:
	sub.w	d3,d0
	dc.b	$65,$0A	; bcs.s DrawMagicMenuMeter_SelectPartialTile
	move.w	d1,(VDP_DATA_PORT).l
	subq.w	#$1,d2
	bra.s	DrawMagicMenuMeter_FillLoop

DrawMagicMenuMeter_SelectPartialTile:
	add.w	d3,d0
	lsr.w	#$1,d3
	addq.w	#$1,d1
	cmpi.w	#$0200,d3
	dc.b	$64,$E6	; bcc.s DrawMagicMenuMeter_FillLoop
	tst.w	d2
	dc.b	$6B,$0C	; bmi.s DrawMagicMenuMeter_Return

DrawMagicMenuMeter_ClearRemainder:
	move.w	#$879C,(VDP_DATA_PORT).l
	dbra	d2,DrawMagicMenuMeter_ClearRemainder

DrawMagicMenuMeter_Return:
	rts

NormalizeAndClearMagicMenuTopRowSelection_00882C:
	cmpi.b	#$28,d0
	bne.s	NormalizeAndClearMagicMenuTopRowSelection_CheckUpperRange_008836
	moveq	#$0C,d0
	bra.s	NormalizeAndClearMagicMenuTopRowSelection_CheckSlots_008840

NormalizeAndClearMagicMenuTopRowSelection_CheckUpperRange_008836:
	cmpi.b	#$2B,d0
	bcs.s	NormalizeAndClearMagicMenuTopRowSelection_CheckSlots_008840
	subi.b	#$23,d0

NormalizeAndClearMagicMenuTopRowSelection_CheckSlots_008840:
	moveq	#MagicMenuTopRowSlotLastIndex,d1

NormalizeAndClearMagicMenuTopRowSelection_CheckSlot_008842:
	movea.w	d1,a0
	cmp.b	-$60F0(a0),d0
	bne.s	NormalizeAndClearMagicMenuTopRowSelection_NextSlot_008854
	st.b	-$60F0(a0)
	move.b	d0,-$6A24(a0)
	rts

NormalizeAndClearMagicMenuTopRowSelection_NextSlot_008854:
	dbra	d1,NormalizeAndClearMagicMenuTopRowSelection_CheckSlot_008842
	rts

ProcessPendingMagicMenuStatusGauge_00885A:
	move.l	(MagicMenuStatusGaugePendingValue_Short).w,d0
	beq.s	ProcessPendingMagicMenuStatusGauge_UpdateAnimationOnly_0088A4
	clr.l	(MagicMenuStatusGaugePendingValue_Short).w
	lea	MagicMenuStatusGaugeSmallScaleBundle_0088CC(pc),a0
	swap	d0
	cmpi.w	#MagicMenuStatusGaugeClampValue,d0
	bcc.s	ProcessPendingMagicMenuStatusGauge_PrepareTarget_00887E
	cmpi.w	#MagicMenuStatusGaugeHalfClampValue,d0
	bcs.s	ProcessPendingMagicMenuStatusGauge_SelectSmallScale_00887A
	move.w	#MagicMenuStatusGaugeHalfClampValue,d0

ProcessPendingMagicMenuStatusGauge_SelectSmallScale_00887A:
	suba.w	#MagicMenuStatusGaugeScaleBundleStride,a0

ProcessPendingMagicMenuStatusGauge_PrepareTarget_00887E:
	swap	d0
	move.w	(a0)+,d1
	move.w	d0,d2
	and.w	d1,d2
	beq.s	ProcessPendingMagicMenuStatusGauge_MaskTarget_00888C
	addq.w	#$1,d1
	add.w	d1,d0

ProcessPendingMagicMenuStatusGauge_MaskTarget_00888C:
	and.l	(a0)+,d0
	move.w	#MagicMenuStatusGaugeAnimationTicks,(MagicMenuStatusGaugeAnimationCountdown_Short).w
	cmp.l	(MagicMenuStatusGaugePackedValue_Short).w,d0
	beq.s	ProcessPendingMagicMenuStatusGauge_UpdateAnimationOnly_0088A4
	bsr.s	ClampMagicMenuStatusGaugeValue_0088B4
	move.l	d0,(MagicMenuStatusGaugePackedValue_Short).w
	movea.l	(a0),a1
	jmp	(a1)

ProcessPendingMagicMenuStatusGauge_UpdateAnimationOnly_0088A4:
	tst.w	(MagicMenuStatusGaugeAnimationCountdown_Short).w
	beq.s	ProcessPendingMagicMenuStatusGauge_Return_0088B2
	subq.w	#$1,(MagicMenuStatusGaugeAnimationCountdown_Short).w
	beq.w	AdvanceMagicMenuStatusGaugeAnimation_0089B6

ProcessPendingMagicMenuStatusGauge_Return_0088B2:
	rts

ClampMagicMenuStatusGaugeValue_0088B4:
	swap	d0
	move.w	d0,d1
	swap	d0
	cmp.w	d0,d1
	bcc.s	ClampMagicMenuStatusGaugeValue_Return_0088C0
	move.w	d1,d0

ClampMagicMenuStatusGaugeValue_Return_0088C0:
	rts

	include "src/magic_menu_status_gauge.asm"

InitializeMagicMenuSelectionState_008C34:
	move.l	(MagicMenuStatusSelectionScratchBuffer_Short).w,(MagicMenuStatusSelectionScratchSnapshot_Short).w
	clr.b	(InventoryMenuSkipArrowRefreshFlag_Short).w
	clr.b	(InventoryMenuListCursorState_Short).w
	clr.b	(InventoryMenuScrollUpIndicatorState_Short).w
	clr.b	(InventoryMenuScrollDownIndicatorState_Short).w
	clr.w	(InventoryMenuCategoryId_Short).w
	clr.w	(InventoryMenuSelectionIndex_Short).w
	clr.w	(InventoryMenuTopVisibleEntryIndex_Short).w
	moveq	#-1,d1
	move.b	d1,(MagicMenuValidTopRowSelection0_Short).w
	moveq	#$00,d0
	move.b	(MagicMenuStatusValue0_Short).w,d0
	cmpi.b	#MagicMenuStatusTopRowSelectionCutoff,d0
	bcc.s	InitializeMagicMenuSelectionState_ResetSlot1_008C6C
	move.b	d0,(MagicMenuValidTopRowSelection0_Short).w

InitializeMagicMenuSelectionState_ResetSlot1_008C6C:
	move.b	d1,(MagicMenuValidTopRowSelection1_Short).w
	move.b	(MagicMenuStatusValue1_Short).w,d0
	cmpi.b	#MagicMenuStatusTopRowSelectionCutoff,d0
	bcc.s	InitializeMagicMenuSelectionState_Return_008C7E
	move.b	d0,(MagicMenuValidTopRowSelection1_Short).w

InitializeMagicMenuSelectionState_Return_008C7E:
	rts

CoreRegion_008C80_01CC0F:
	incbin "data/rom/core_005000_01ffff.bin",$3C80,$13F90

	include "src/menu_text_root_pointers.asm"

CoreRegion_01CC50_01FFFF:
	incbin "data/rom/core_005000_01ffff.bin",$17C50,$33B0
