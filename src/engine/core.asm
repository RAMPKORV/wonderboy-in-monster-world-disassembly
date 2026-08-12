; ======================================================================
; src/engine/core.asm
; Reset vector boot + Sega init, Z80 driver upload/mailbox, object-slot
; and task-queue management, RNG. Covers ROM $000200-$0005FE.
; Verified bit-exact against the original ROM.
; ======================================================================

; ======================================================================
; Boot (loc_000200)
; Standard Sega Genesis boot: TMSS unlock, VDP registers, Z80 bootstrap
; driver, RAM clear. Jumps to MainInit ($4A06) when done.
; ======================================================================
Boot:
	tst.l	($A10008).l			; $200
	bne.b	*+$8				; $206
	tst.w	($A1000C).l			; $208
SkipTMSS:
	bne.b	*+$7E				; $20E
	lea	BootInitTable(PC), A5		; $210
	movem.w	(A5)+, D5/D6/D7			; $214
	movem.l	(A5)+, A0/A1/A2/A3/A4		; $218
	move.b	(-$10FF,A1), D0			; $21C
	andi.b	#$F, D0				; $220
	beq.b	*+$A				; $224
	move.l	#$53454741, ($2F00,A1)		; $226  ; "SEGA" -> TMSS
SetupRegisters:
	move.w	(A4), D0			; $22E
	moveq	#$0, D0				; $230
	movea.l	D0, A6				; $232
	move.l	A6, USP				; $234
	moveq	#$17, D1			; $236
WriteVDPRegs:
	move.b	(A5)+, D5			; $238
	move.w	D5, (A4)			; $23A
	add.w	D7, D5				; $23C
	dbf	D1, WriteVDPRegs			; $23E
	move.l	(A5)+, (A4)			; $242
	move.w	D0, (A3)			; $244
	move.w	D7, (A1)			; $246
	move.w	D7, (A2)			; $248
WaitZ80Bus:
	btst.b	D0, (A1)			; $24A
	bne.b	WaitZ80Bus			; $24C
	moveq	#$25, D2			; $24E
CopyZ80Boot:
	move.b	(A5)+, (A0)+			; $250
	dbf	D2, CopyZ80Boot			; $252
	move.w	D0, (A2)			; $256
	move.w	D0, (A1)			; $258
	move.w	D7, (A2)			; $25A
ClearRAM:
	move.l	D0, -(A6)			; $25C
	dbf	D6, ClearRAM			; $25E
	move.l	(A5)+, (A4)			; $262
	move.l	(A5)+, (A4)			; $264
	moveq	#$1F, D3			; $266
ClearVDPData:
	move.l	D0, (A3)			; $268
	dbf	D3, ClearVDPData			; $26A
	move.l	(A5)+, (A4)			; $26E
	moveq	#$13, D4			; $270
ClearVDPData2:
	move.l	D0, (A3)			; $272
	dbf	D4, ClearVDPData2		; $274
	moveq	#$3, D5				; $278
SilencePSG:
	move.b	(A5)+, ($11,A3)			; $27A
	dbf	D5, SilencePSG			; $27E
	move.w	D0, (A2)			; $282
	movem.l	(A6), D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6	; $284
	move	#$2700, SR			; $288
	bra.b	*+$6E				; $28C

; ======================================================================
; BootInitTable (loc_00028E)
; VDP register values, Z80 bootstrap driver, VDP commands, PSG silence.
; Loaded by Boot via A5 (PC-relative from $210).
; ======================================================================
BootInitTable:
	dc.w	$8000				; $28E  first VDP reg (reg 0 = $04)
	dc.w	$3FFF				; $290  RAM clear count (0x4000 longs)
	dc.w	$0100				; $292  VDP register increment
	dc.l	$00A00000			; $294  A0 = Z80 RAM base
	dc.l	$00A11100			; $298  A1 = Z80 bus request
	dc.l	$00A11200			; $29C  A2 = Z80 reset
	dc.l	$00C00000			; $2A0  A3 = VDP data port
	dc.l	$00C00004			; $2A4  A4 = VDP control port
	dc.b	$04,$14,$30,$3C,$07,$6C,$00,$00	; $2A8  VDP reg values 0-7
	dc.b	$00,$00,$FF,$00,$81,$37,$00,$01	; $2B0  VDP reg values 8-15
	dc.b	$01,$00,$00,$FF,$FF,$00,$00,$80	; $2B8  VDP reg values 16-23
	dc.b	$40,$00,$00,$80,$AF,$01,$D9,$1F	; $2C0  Z80 bootstrap driver
	dc.b	$11,$27,$00,$21,$26,$00,$F9,$77	; $2C8
	dc.b	$ED,$B0,$DD,$E1,$FD,$E1,$ED,$47	; $2D0
	dc.b	$ED,$4F,$D1,$E1,$F1,$08,$D9,$C1	; $2D8
	dc.b	$D1,$E1,$F1,$F9,$F3,$ED		; $2E0
	dc.l	$5636E9E9			; $2E6  VDP command
	dc.l	$81048F02			; $2EA  VDP command
	dc.l	$C0000000			; $2EE  VDP command (CRAM write)
	dc.b	$40,$00,$00,$10			; $2F2  PSG silence
	dc.b	$9F,$BF,$DF,$FF			; $2F6  unused (PSG volume-off)

; ======================================================================
; PostBoot (loc_0002FA)
; Final boot check, then enter the main init.
; ======================================================================
PostBoot:
	tst.w	($C00004).l			; $2FA
	jmp MainInit.l				; $300  ; -> MainInit

; ======================================================================
; WriteZ80Driver (loc_000306)
; Copies the Z80 sound driver from ROM $98000 into Z80 RAM $A00000.
; Driver length is a 16-bit little-endian prefix at $98006.
; ======================================================================
WriteZ80Driver:
	move.w	#$0, (RAM_word_FFFF8000).w		; $306
	move.w	#$100, ($A11100).l		; $30C
	bsr.b	*+$36				; $314  ; -> Z80ResetPulse
WaitZ80Bus2:
	btst.b	#$0, ($A11100).l		; $316
	bne.b	WaitZ80Bus2			; $31E
	movea.l	#$98000, A0			; $320
	move.b	($7,A0), D0			; $326
	lsl.w	#$8, D0				; $32A
	move.b	($6,A0), D0			; $32C
	subq.w	#1, D0				; $330
	lea	($A00000).l, A1			; $332
CopyDriver:
	move.b	(A0)+, (A1)+			; $338
	dbf	D0, CopyDriver			; $33A
	bsr.b	*+$C				; $33E  ; -> Z80ResetPulse
	move.w	#$0, ($A11100).l		; $340
	rts					; $348

; ======================================================================
; Z80ResetPulse (loc_00034A)
; Asserts and releases the Z80 reset line (with a save/restore delay).
; ======================================================================
Z80ResetPulse:
	move.w	#$0, ($A11200).l		; $34A
	movem.l	A2/A1/A0/D7/D6/D5/D4/D3/D2/D1/D0, -(SP)	; $352
	movem.l	(SP)+, D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2	; $356
	move.w	#$100, ($A11200).l		; $35A
	rts					; $362

; ======================================================================
; SendZ80Command (loc_000364)
; Writes command byte D0 into the Z80 mailbox at
; $A01C30 + (($1C2E + $1C2F) & $F) in Z80 RAM.
; ======================================================================
SendZ80Command:
	moveq	#-1, D0				; $364
	nop					; $366
	lea	($A00000).l, A0			; $368
SendZ80CmdRetry:
	move.w	#$100, ($A11100).l		; $36E
WaitZ80Bus3:
	btst.b	#$0, ($A11100).l		; $376
	bne.b	WaitZ80Bus3			; $37E
	tst.b	($1C00,A0)			; $380
	beq.b	*+$12				; $384
	move.w	#$0, ($A11100).l		; $386
	moveq	#$1F, D1			; $38E
DelayZ80Release:
	dbf	D1, DelayZ80Release		; $390
	bra.b	SendZ80CmdRetry			; $394
WriteZ80Mailbox:
	move.b	($1C2E,A0), D1			; $396
	add.b	($1C2F,A0), D1			; $39A
	andi.w	#$F, D1				; $39E
	addi.w	#$1C30, D1			; $3A2
	move.b	D0, ($0,A0,D1.w)		; $3A6
	addq.b	#1, ($1C2F,A0)			; $3AA
	move.w	#$0, ($A11100).l		; $3AE
	rts					; $3B6

; ======================================================================
; FrameWait (loc_0003B8)
; Main-loop frame sync. When bit 6 of $FF8A5D is set, waits for the
; VBlank flag ($FF8006 bit 0) and the end of VBlank, then polls $5262.
; ======================================================================
FrameWait:
	addq.l	#1, (RAM_word_FFFF8002).w		; $3B8
	addq.l	#1, (RAM_word_FFFF8A56).w		; $3BC
	move.b	(RAM_word_FFFF8A5D).w, D0		; $3C0
	move.b	(RAM_word_FFFF8A7E).w, D1		; $3C4
	eor.b	D0, D1				; $3C8
	andi.b	#$40, D1			; $3CA
	bne.b	*+$8				; $3CE
	andi.b	#$40, D0			; $3D0
	beq.b	*+$2A				; $3D4
WaitVBlankFlag:
	andi.b	#$FE, (RAM_VBlankFlag).w		; $3D6
WaitVBlankSet:
	btst.b	#$0, (RAM_VBlankFlag).w		; $3DC
	beq.b	WaitVBlankSet			; $3E2
	jsr	$5262.l				; $3E4
WaitVBlankEnd:
	btst.b	#$6, (RAM_word_FFFF8A5D).w		; $3EA
	beq.b	*+$E				; $3F0
	move.w	($C00004).l, D0			; $3F2
	andi.w	#$8, D0				; $3F8
	bne.b	WaitVBlankEnd			; $3FC
	rts					; $3FE

; ======================================================================
; ScheduleTaskContinuation (loc_000400)
; Stores the caller's return address in the current task slot's +$0C
; callback field so the task resumes there on the next dispatch pass.
; ======================================================================
ScheduleTaskContinuation:
	movea.w	(RAM_CurrentTaskSlot).w, A5		; $400
	movea.l	(SP)+, A0			; $404
	move.l	A0, ($C,A5)			; $406
	rts					; $40A

; ======================================================================
; WaitForVDPIdle (loc_00040C)
; When bit 6 of $FF8A5D is set, waits until the VDP leaves active
; display, then syncs on the HV counter to a stable scanline.
; ======================================================================
WaitForVDPIdle:
	btst.b	#$6, (RAM_word_FFFF8A5D).w		; $40C
	bne.b	*+$4				; $412
	rts					; $414
WaitScanline:
	move.w	($C00004).l, D0			; $416
	andi.w	#$8, D0				; $41C
	bne.b	ScheduleTaskContinuation	; $420
	move.w	($C00008).l, D0			; $422
	andi.w	#$FF00, D0			; $428
WaitScanline2:
	move.w	D0, D2				; $42C
	move.w	($C00008).l, D0			; $42E
	andi.w	#$FF00, D0			; $434
	cmp.w	D0, D2				; $438
	bne.b	WaitScanline2			; $43A
	cmpi.w	#$D000, D2			; $43C
	bcc.b	ScheduleTaskContinuation	; $440
	rts					; $442

; ======================================================================
; SpawnObject (loc_000444)
; Finds a free slot in the round-robin object table at $FF8248 and
; initializes it. In: A1 = object data (long ID at (A1), callback after).
; Out: D0 = slot index (or 0 if none free).
; ======================================================================
SpawnObject:
	lea	(-$7DB8).w, A0			; $444
	moveq	#$F, D0				; $448
FindFreeObjectSlot:
	tst.w	(A0)				; $44A
	bpl.b	*+$12				; $44C
	lea	($80,A0), A0			; $44E
	dbf	D0, FindFreeObjectSlot		; $452
	moveq	#$0, D0				; $456
	jmp SubsystemTrap.l				; $458
InitObjectSlot:
	move.b	#$80, (A0)			; $45E
	move.l	(A1)+, ($4,A0)			; $462
	move.l	A1, ($C,A0)			; $466
	clr.b	($1,A0)				; $46A
	clr.l	($8,A0)				; $46E
	neg.w	D0				; $472
	addi.w	#$F, D0				; $474
	rts					; $478

; ======================================================================
; FindOrSpawnObject (loc_00047A)
; Returns 1 if an object whose ID is (A1) already exists, else spawns it.
; ======================================================================
FindOrSpawnObject:
	moveq	#$0, D0				; $47A
	lea	(-$7DB8).w, A0			; $47C
	moveq	#$F, D1				; $480
	move.l	(A1), D2			; $482
CheckObjectSlot:
	tst.b	(A0)				; $484
	bpl.b	*+$8				; $486
	cmp.l	($4,A0), D2			; $488
	beq.b	*+$12				; $48C
NextObjectSlot:
	lea	($80,A0), A0			; $48E
	dbf	D1, CheckObjectSlot		; $492
	jsr	SpawnObject.w			; $496
	moveq	#$0, D0				; $49A
	rts					; $49C
ObjectExists:
	moveq	#$1, D0				; $49E
	rts					; $4A0

; ======================================================================
; ApplyToObjectsWithID (loc_0004A2)
; Runs RunObjectTask once for every live object whose ID equals (A0).
; ======================================================================
ApplyToObjectsWithID:
	move.l	(A0), D2			; $4A2
	move.b	(RAM_SchedulerCursor).w, D0		; $4A4
	move.w	D0, -(SP)			; $4A8
	lea	(-$7DB8).w, A1			; $4AA
	move.w	#$F, D1				; $4AE
CheckObjectByID:
	tst.b	(A1)				; $4B2
	bpl.b	*+$22				; $4B4
	cmp.l	($4,A1), D2			; $4B6
	bne.b	*+$1C				; $4BA
	move.w	D1, -(SP)			; $4BC
	move.l	D2, -(SP)			; $4BE
	move.w	A1, -(SP)			; $4C0
	neg.w	D1				; $4C2
	addi.w	#$F, D1				; $4C4
	move.b	D1, (RAM_SchedulerCursor).w		; $4C8
	bsr.w	RunObjectTask			; $4CC
	movea.w	(SP)+, A1			; $4D0
	move.l	(SP)+, D2			; $4D2
	move.w	(SP)+, D1			; $4D4
NextObjectByID:
	lea	($80,A1), A1			; $4D6
	dbf	D1, CheckObjectByID		; $4DA
	move.w	(SP)+, D0			; $4DE
	move.b	D0, (RAM_SchedulerCursor).w		; $4E0
	rts					; $4E4

; ======================================================================
; RunObjectTask (loc_0004E6)
; Calls the object slot's update function at +$8 (indexed by $FF8A48),
; then clears the slot and removes it from the task queue ($582).
; ======================================================================
RunObjectTask:
	move.l	A5, -(SP)			; $4E6
	moveq	#$0, D0				; $4E8
	move.b	(RAM_SchedulerCursor).w, D0		; $4EA
	asl.w	#$7, D0				; $4EE
	addi.w	#-$7DB8, D0			; $4F0
	movea.w	D0, A5				; $4F4
	move.l	($8,A5), D0			; $4F6
	beq.b	*+$6				; $4FA
	movea.l	D0, A0				; $4FC
	jsr	(A0)				; $4FE
RunObjectTaskEnd:
	movea.l	(SP)+, A5			; $500
	moveq	#$0, D0				; $502
	move.b	(RAM_SchedulerCursor).w, D0		; $504
	asl.w	#$7, D0				; $508
	addi.w	#-$7DB8, D0			; $50A
	movea.w	D0, A0				; $50E
	clr.b	(A0)				; $510
	bra.b	*+$70				; $512  ; -> DequeueObjectTask

; ======================================================================
; EnqueueObjectTask (loc_000514)
; Adds the object indexed by $FF8A48 to the task queue at $FF8008 and
; links it into the immediate task slots (a 64-byte block at $FF0C00+).
; ======================================================================
EnqueueObjectTask:
	move.b	(RAM_SchedulerCursor).w, D0		; $514
	lea	(-$7FF8).w, A1			; $518
	moveq	#$1F, D1			; $51C
FindFreeQueueEntry:
	tst.b	(A1)				; $51E
	bpl.b	*+$10				; $520
	addq.w	#2, A1				; $522
	dbf	D1, FindFreeQueueEntry		; $524
	moveq	#$1, D0				; $528
	jmp SubsystemTrap.l				; $52A
QueueObject:
	neg.w	D1				; $530
	addi.w	#$1F, D1			; $532
	asl.l	#$6, D1				; $536
	addi.l	#RAM_ObjectRAM, D1			; $538
	movea.l	D1, A0				; $53E
	move.b	#$80, (A1)			; $540
	lea	(-$7DB8).w, A2			; $544
	move.b	D0, ($1,A1)			; $548
	bpl.b	*+$6				; $54C
	lea	(-$7FB8).w, A2			; $54E
LinkToTaskSlots:
	andi.w	#$7F, D0			; $552
	asl.w	#$7, D0				; $556
	adda.w	D0, A2				; $558
	lea	($10,A2), A1			; $55A
	moveq	#$0, D0				; $55E
	move.b	($1,A2), D0			; $560
	move.b	D0, D1				; $564
	asl.w	#$2, D0				; $566
	adda.w	D0, A1				; $568
	move.l	A0, (A1)			; $56A
	addq.b	#1, D1				; $56C
	cmpi.b	#$4, D1				; $56E
	bls.b	*+$A				; $572
	moveq	#$1, D0				; $574
	jmp SubsystemTrap.l				; $576
QueueEntryDone:
	move.b	D1, ($1,A2)			; $57C
	rts					; $580

; ======================================================================
; DequeueObjectTask (loc_000582)
; Removes the object indexed by $FF8A48 from the task queue at $FF8008.
; ======================================================================
DequeueObjectTask:
	move.b	(RAM_SchedulerCursor).w, D0		; $582
	lea	(-$7FF8).w, A0			; $586
	moveq	#$1F, D1			; $58A
FindQueuedObject:
	tst.b	(A0)				; $58C
	bpl.b	*+$A				; $58E
	cmp.b	($1,A0), D0			; $590
	bne.b	*+$4				; $594
	clr.b	(A0)				; $596
NextQueueEntry:
	addq.w	#2, A0				; $598
	dbf	D1, FindQueuedObject		; $59A
	rts					; $59E

; ======================================================================
; CalcVRAMAddress (loc_0005A0)
; Builds a VDP VRAM-write command word from an address in D0 and
; writes it to the VDP control port.
; ======================================================================
CalcVRAMAddress:
	asl.l	#$2, D0				; $5A0
	lsr.w	#$2, D0				; $5A2
	ori.w	#$4000, D0			; $5A4
	swap	D0				; $5A8
	andi.w	#$3, D0				; $5AA
	move.l	D0, ($C00004).l			; $5AE
	rts					; $5B4

; ======================================================================
; TileToVRAMAddress (loc_0005B6)
; Converts tile coordinates (D0, D1) into a VRAM tile index.
; ======================================================================
TileToVRAMAddress:
	addq.w	#4, D2				; $5B6
	and.w	(RAM_ScrollPixelY).w, D2		; $5B8
	lsr.w	#$3, D2				; $5BC
	addq.w	#4, D3				; $5BE
	and.w	(RAM_ScrollPixelX).w, D3		; $5C0
	lsr.w	#$3, D3				; $5C4
	add.w	D2, D0				; $5C6
	add.w	D3, D1				; $5C8
	add.w	D0, D0				; $5CA
	add.w	D1, D1				; $5CC
	move.b	(RAM_ScrollPlaneBase).w, D2		; $5CE
	asl.w	D2, D1				; $5D2
	add.w	D1, D0				; $5D4
	rts					; $5D6

; ======================================================================
; RandomNumber (loc_0005D8)
; 32-bit LCG: state = state * 0xA + ... ; returns D1. State at $FF8A52.
; ======================================================================
RandomNumber:
	move.l	(RAM_RNGState).w, D1		; $5D8
	bne.b	*+$8				; $5DC
	move.l	#$2A6D365A, D1			; $5DE
UpdateRNG:
	move.l	D1, D0				; $5E4
	asl.l	#$2, D1				; $5E6
	add.l	D0, D1				; $5E8
	asl.l	#$3, D1				; $5EA
	add.l	D0, D1				; $5EC
	move.w	D1, D0				; $5EE
	swap	D1				; $5F0
	add.w	D1, D0				; $5F2
	move.w	D0, D1				; $5F4
	swap	D1				; $5F6
	move.l	D1, (RAM_RNGState).w		; $5F8
	rts					; $5FC
