; ======================================================================
; src/vblank_tasks.asm
; ROM range: 0x004B58-0x004FFF - VBlank dispatch and task scheduling
; ======================================================================
; The front of this block is source-authored where interrupt/task-dispatch behavior is
; understood. The clean-state bootstrap playback stream and scratch seed at
; `0x004E64-0x004F53` are now also source-authored; only the still-unmapped gaps remain in
; ROM-order form elsewhere.

RunTaskHelper_0364                      equ $00000364
RunTaskHelper_0366                      equ $00000366
RunTaskHelper_0400                      equ $00000400
PrimeTaskAdvanceReady_005842            equ $00005842
TaskSetupJump_01AA3C                    equ $0001AA3C
TaskAdvanceWorker_01AD62                equ $0001AD62
RetireMatchingRoundRobinTasksByUserData equ $000004A2
TaskDescriptor_005608                   equ $00005608
InitImmDescPtr                          equ $00004CC4
SecondImmDescPtr                        equ $00004D14
ThirdImmDescPtr                         equ $00004D52
FourthImmDescPtr                        equ $00004D64
CleanImmDescPtr                         equ $00004DA4
CleanStateDescPtr                       equ $00004DDE

DefaultInterruptHandler:
	nop
	bra.s	DefaultInterruptHandler

VBlankHandler:
	addq.b	#$1,(VBlankTickCounter_Short).l
	ori.b	#$01,(VBlankDispatchFlags_Short).w
	rte

InitializeVBlankDispatchState:
	clr.b	(ImmediateTaskCursor_Short).w
	dc.b	$61,$12
	dc.b	$61,$24
	moveq	#$00,d0
	lea	(VBlankDispatchFlags_Short+$0002).w,a0
	moveq	#$1F,d1

.clear_dispatch_words:
	move.w	d0,(a0)+
	dbf	d1,.clear_dispatch_words
	rts

ClearImmediateTaskSlotStates:
	moveq	#$00,d0
	lea	(ImmediateTaskSlots_Short).w,a0
	moveq	#VBlankTaskSlotCount_Immediate-1,d1

.clear_immediate_slots:
	move.w	d0,(a0)
	lea	VBlankTaskSlotStride(a0),a0
	dbf	d1,.clear_immediate_slots
	rts

RetireRoundRobinTaskSlots:
	lea	(RoundRobinTaskSlots_Short).w,a0
	moveq	#VBlankTaskSlotCount_RoundRobin-1,d1

.retire_round_robin_loop:
	tst.w	(a0)
	dc.b	$6A,$12
	move.w	a0,-(sp)
	move.w	d1,-(sp)
	move.l	VBlankTaskUserDataOffset(a0),d2
	jsr	($04A4).w
	move.w	(sp)+,d1
	movea.w	(sp)+,a0
	clr.w	(a0)

.skip_retire:
	lea	VBlankTaskSlotStride(a0),a0
	dbf	d1,.retire_round_robin_loop
	rts

PrimeImmediateTaskCursor:
	move.b	#VBlankTaskStateActiveBit,(ImmediateTaskCursor_Short).w

ProcessImmediateTaskSlots:
	lea	(ImmediateTaskSlots_Short).w,a5

.process_immediate_slot:
	move.b	(a5),d0
	andi.b	#$80,d0
	beq.s	.skip_immediate_callback
	move.w	a5,(CurrentTaskSlotPointer_Short).w
	movea.l	VBlankTaskCallbackOffset(a5),a0
	jsr	(a0)
	movea.w	(CurrentTaskSlotPointer_Short).w,a5

.skip_immediate_callback:
	lea	VBlankTaskSlotStride(a5),a5
	addq.b	#$1,(ImmediateTaskCursor_Short).w
	cmpi.b	#ImmediateTaskCursorLimit,(ImmediateTaskCursor_Short).w
	bcs.s	.process_immediate_slot
	dc.b	$61,$00,$07,$BC
	bsr.s	DispatchTimedRoundRobinTasks

DispatchTail:
	dc.b	$61,$00,$B7,$C4
	bra.s	PrimeImmediateTaskCursor

ResetDispatchStackAndRetry:
	movea.l	#SystemStackTop,a7
	bra.s	DispatchTail

DispatchTimedRoundRobinTasks:
	btst	#VBlankTimedDispatchFlagBit,(TaskDispatchTimingFlags_Short).w
	beq.s	DispatchRoundRobinTasksFallback
	cmpi.b	#VBlankTimedDispatchTickLimit,(VBlankTickCounter_Short).w
	bcc.s	DispatchRoundRobinTasksFallback
	moveq	#$00,d0
	move.b	(RoundRobinTaskIndex_Short).w,d0
	asl.w	#7,d0
	addi.w	#RoundRobinTaskSlots_Short,d0
	movea.w	d0,a5
	move.b	#VBlankDispatchBudgetReset,(TaskDispatchBudget_Short).w

.wait_vdp_fifo:
	move.w	(VDP_CONTROL_PORT).l,d0
	andi.w	#$0008,d0
	bne.s	.dispatch_budget_done

.wait_hv_counter_stable:
	move.w	(VDP_HV_COUNTER).l,d0
	andi.w	#$FF00,d0

.sample_hv_counter_pair:
	move.w	d0,d2
	move.w	(VDP_HV_COUNTER).l,d0
	andi.w	#$FF00,d0
	cmp.w	d0,d2
	bne.s	.sample_hv_counter_pair
	cmpi.w	#$D000,d2
	bcc.s	.dispatch_budget_done
	bsr.s	DispatchNextRoundRobinTask
	subq.b	#$1,(TaskDispatchBudget_Short).w
	bne.s	.wait_vdp_fifo

.dispatch_budget_done:
	rts

DispatchRoundRobinTasksFallback:
	move.b	#VBlankDispatchBudgetReset,(TaskDispatchBudget_Short).w
	lea	(RoundRobinTaskSlots_Short).w,a5

.dispatch_fallback_loop:
	bsr.s	DispatchNextRoundRobinTask
	subq.b	#$1,(TaskDispatchBudget_Short).w
	bne.s	.dispatch_fallback_loop
	rts

DispatchNextRoundRobinTask:
	clr.b	(VBlankTickCounter_Short).w
	move.b	(a5),d0
	andi.b	#$80,d0
	beq.s	.skip_round_robin_callback
	move.w	a5,(CurrentTaskSlotPointer_Short).w
	movea.l	VBlankTaskCallbackOffset(a5),a0
	move.b	(RoundRobinTaskIndex_Short).w,(ImmediateTaskCursor_Short).w
	jsr	(a0)
	movea.w	(CurrentTaskSlotPointer_Short).w,a5

.skip_round_robin_callback:
	lea	VBlankTaskSlotStride(a5),a5
	addq.b	#$1,(RoundRobinTaskIndex_Short).w
	cmpi.b	#VBlankTaskSlotCount_RoundRobin,(RoundRobinTaskIndex_Short).w
	bcs.s	.return
	clr.b	(RoundRobinTaskIndex_Short).w
	lea	(RoundRobinTaskSlots_Short).w,a5

.return:
	rts

CompleteCurrentTaskSlotWithResult:
	movea.w	(CurrentTaskSlotPointer_Short).w,a5
	clr.w	(a5)
	move.w	d0,(TaskCompletionResult_Short).w
	rts

VBlankDispatchIdleLoop:
	nop
	bra.s	VBlankDispatchIdleLoop

QueueInitialImmediateTask:
	movea.l	#InitImmDescPtr,a1
	jmp	(QueueImmediateTaskDescriptor).l

InitImmDesc:
	dc.l	$4B736D74

InitImmCb:
	jsr	(RunTaskHelper_0364).w
	lea	InitImmList(pc),a1
	bsr.w	LoadSecondaryTaskDescriptorList
	jsr	(RunTaskHelper_0400).w
	bsr.w	PollSecondaryTaskStatus
	beq.s	InitImmCb_CheckSecondary
	bsr.w	PlayTaskAdvanceSound
	movea.l	#FourthImmDescPtr,a1
	bra.w	QueueRoundRobinTaskDescriptor

InitImmCb_CheckSecondary:
	tst.b	(SecondaryTaskSlots_Short).w
	bmi.s	InitImmCb_Return
	movea.l	#TaskDescriptor_004F54,a1
	tst.w	(TaskCompletionResult_Short).w
	bne.s	InitImmCb_QueueFollowup
	movea.l	#SecondImmDescPtr,a1

InitImmCb_QueueFollowup:
	jmp	(QueueRoundRobinTaskDescriptor).l

InitImmCb_Return:
	rts

InitImmList:
	dc.l	$00006F86
	dc.l	$00000000

SecondImmDesc:
	dc.l	$4B746D74

SecondImmCb:
	jsr	(RunTaskHelper_0364).w
	lea	SecondImmList(pc),a1
	bsr.w	LoadSecondaryTaskDescriptorList
	jsr	(RunTaskHelper_0400).w
	bsr.w	PollSecondaryTaskStatus
	bne.s	SecondImmCb_RetireMatch
	tst.b	(SecondaryTaskSlots_Short).w
	bmi.s	SecondImmCb_Return

SecondImmCb_RetireMatch:
	movea.l	#TaskDescriptor_005608,a0
	jsr	(RetireMatchingRoundRobinTasksByUserData).w
	movea.l	#ThirdImmDescPtr,a1
	bra.w	QueueImmediateTaskDescriptor

SecondImmCb_Return:
	rts

SecondImmList:
	dc.l	$0000703E
	dc.l	$00000000

ThirdImmDesc:
	dc.l	$4B746D33

ThirdImmCb:
	lea	ThirdImmList(pc),a1
	bra.s	QueueStage3

ThirdImmList:
	dc.l	$00007136
	dc.l	$00000000

FourthImmDesc:
	dc.l	$4B746D32

FourthImmCb:
	lea	FourthImmList(pc),a1

QueueStage3:
	bsr.w	LoadSecondaryTaskDescriptorList
	jsr	(RunTaskHelper_0400).w
	bsr.w	PollSecondaryTaskStatus
	beq.s	QueueStage3_CheckSecondary
	moveq	#$25,d0
	jsr	(RunTaskHelper_0366).w
	movea.l	#CleanImmDescPtr,a1
	bra.w	QueueImmediateTaskDescriptor

QueueStage3_CheckSecondary:
	tst.b	(SecondaryTaskSlots_Short).w
	bmi.s	QueueStage3_Return
	movea.l	#CleanStateDescPtr,a1
	bra.w	QueueRoundRobinTaskDescriptor

QueueStage3_Return:
	rts

FourthImmList:
	dc.l	$00007158
	dc.l	$00000000

CleanImmDesc:
	dc.l	$4B6D6E75

CleanImmCb:
	lea	CleanImmList(pc),a1
	bsr.w	LoadSecondaryTaskDescriptorList
	jsr	(RunTaskHelper_0400).w
	tst.b	(SecondaryTaskSlots_Short).w
	bmi.s	CleanImmCb_Return
	tst.w	$0020(a5)
	bpl.s	CleanImmCb_QueueGameplay
	movea.l	#CleanStateDescPtr,a1
	bra.w	QueueRoundRobinTaskDescriptor

CleanImmCb_QueueGameplay:
	movea.l	#TaskDescriptor_00507C,a1
	bra.w	QueueRoundRobinTaskDescriptor

CleanImmCb_Return:
	rts

CleanImmList:
	dc.l	$000071C2
	dc.l	$00000000

CleanStateDesc:
	dc.l	$4B64796D

CleanStateCb:
	jsr	(RunTaskHelper_0364).w
	bsr.w	ClearTaskScriptScratch
	move.b	#$80,(TaskScriptMode_Short).w
	lea	CleanStatePlaybackStream_004E64.l,a0
	bsr.w	AdvanceTaskScript
	moveq	#$0F,d0
	lea	(TaskScriptScratchBuffer).l,a0
	lea	CleanStateScratchSeed_004F14.l,a1

CleanStateCb_CopyScriptData:
	move.l	(a1)+,(a0)+
	dbf	d0,CleanStateCb_CopyScriptData
	lea	TaskScriptCbList(pc),a1
	bsr.w	LoadSecondaryTaskDescriptorList
	ori.b	#$01,(TaskScriptFlags_Short).w
	jsr	(RunTaskHelper_0400).w
	bsr.w	PollSecondaryTaskStatus
	beq.s	CleanStateCb_AdvanceState
	bsr.w	PlayTaskAdvanceSound
	clr.b	(TaskScriptMode_Short).w
	movea.l	#FourthImmDescPtr,a1
	bra.s	CleanStateCb_ClearFlagAndQueue

CleanStateCb_AdvanceState:
	bsr.w	StepTaskScript
	tst.b	(TaskScriptCountdown_Short).w
	beq.s	CleanStateCb_ResetMode
	tst.b	(SecondaryTaskSlots_Short).w
	bmi.s	CleanStateCb_Return

CleanStateCb_ResetMode:
	clr.b	(TaskScriptMode_Short).w
	movea.l	#InitImmDescPtr,a1

CleanStateCb_ClearFlagAndQueue:
	andi.b	#$FE,(TaskScriptFlags_Short).w
	bra.w	QueueRoundRobinTaskDescriptor

CleanStateCb_Return:
	rts

TaskScriptCbList:
	dc.l	$00008EB0
	dc.l	$00000000

	include "src/vblank_clean_state_script.asm"

TaskDescriptor_004F54:
	dc.l	$4B65646D

LoadSecondaryTaskListCb_004F58:
	lea	TaskSecondaryList_004FC0(pc),a1
	bsr.w	LoadSecondaryTaskDescriptorList
	jmp	(TaskSetupJump_01AA3C).l

TaskDelayPollCb_004F66:
	move.w	#TaskAdvanceDelayTicks,VBlankTaskDelayOffset(a5)
	jsr	(RunTaskHelper_0400).w
	jsr	(TaskAdvanceWorker_01AD62).l
	subq.w	#$1,VBlankTaskDelayOffset(a5)
	beq.s	QueueInitialTaskWhenReadyCb_004F84
	bsr.w	PollSecondaryTaskStatus
	bne.s	QueueInitialTaskWhenReadyCb_004F84
	rts

QueueInitialTaskWhenReadyCb_004F84:
	bsr.w	PrimeTaskAdvanceReady_005842
	jsr	(RunTaskHelper_0400).w
	jsr	(TaskAdvanceWorker_01AD62).l
	btst	#TaskAdvanceReadyFlagBit,(TaskAdvanceReadyFlags_Short).w
	bne.s	QueueInitialTaskFromRoundRobin_004F9C
	rts

QueueInitialTaskFromRoundRobin_004F9C:
	movea.l	#InitImmDescPtr,a1
	bra.w	QueueRoundRobinTaskDescriptor

WaitTaskAdvanceReadyCb_004FA6:
	bsr.w	PrimeTaskAdvanceReady_005842

.wait_task_ready:
	jsr	(RunTaskHelper_0400).w
	btst	#TaskAdvanceReadyFlagBit,(TaskAdvanceReadyFlags_Short).w
	beq.s	.wait_task_ready
	movea.l	#InitImmDescPtr,a1
	bra.w	QueueRoundRobinTaskDescriptor

TaskSecondaryList_004FC0:
	dc.l	$00004FC8
	dc.l	$00000000

TaskDescriptor_004FC8:
	dc.l	$4B656473

AsyncTaskReadyGateCb_004FCC:
	clr.b	(AsyncTaskReadyByte_Short).w

.wait_async_ready:
	jsr	(RunTaskHelper_0400).w
	tst.b	(AsyncTaskReadyByte_Short).w
	beq.s	.wait_async_ready
	btst	#TaskScriptProgressReadyBit,(TaskScriptProgressFlags_Short).w
	beq.s	.wait_async_ready
	move.l	#WaitTaskAdvanceReadyCb_004FA6,(ImmediateTaskSlot0Callback_Short).w
	clr.w	(a5)
	rts

ClearTaskScriptProgressBuffer:
	lea	(TaskScriptProgressBuffer).l,a0
	move.l	a0,VBlankTaskScriptPointerOffset(a5)
	move.w	#$03FF,d1
	moveq	#$00,d0

ClearTaskScriptProgressBuffer_Loop:
	move.l	d0,(a0)+
