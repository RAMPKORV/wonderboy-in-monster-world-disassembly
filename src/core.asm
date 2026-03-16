; ROM range: 0x005000-0x01FFFF
; Early engine/core body kept mostly opaque until routine boundaries are mapped.
; The front of this file continues the task/input helper chain that begins at `0x004FEE`
; in `src/vblank.asm`. The `0x005016-0x00505C` helpers currently look like a compact
; input-sequence stream built from (duration,value) byte pairs in `0xFF1400`, reusing
; the selected-input mirror at `0x8A7A-0x8A7D` as playback state. The bootstrap
; display-setup stub at `0x005170-0x0051C5` and the controller-read helpers at
; `0x0051C6-0x005260` are now source-authored in ROM order; the broader engine body
; still stays opaque after that point.

PrimeTaskAdvanceBuffers_00559E             equ $0000559E
ResetSecondaryTaskSlots_00062A             equ $0000062A
DecodePatchStream_00234C                   equ $0000234C
ResetVdpReg1LowFlags_0006BE                equ $000006BE
ClearVdpReg1Bit3_0006F6                    equ $000006F6
ClearBootstrapScratch_005398               equ $00005398
ClearTilemapRegionA_006910                 equ $00006910
ClearTilemapRegionB_006916                 equ $00006916
ClearFixedVramRegionAndResetFlags_00693E   equ $0000693E
ResetTilemapWorkBuffers_00696C             equ $0000696C
TaskDescriptor_006EA8                      equ $00006EA8

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

CoreRegion:
	incbin "data/rom/core_005000_01ffff.bin",$0262,$01AD9E
