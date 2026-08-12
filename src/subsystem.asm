; ======================================================================
; src/subsystem.asm
; <What this region does>.
; Covers ROM $4C82-$5700.
; Verified bit-exact against the original ROM.
; ======================================================================
	move.b (RAM_word_FFFF8A4A).w, (RAM_SchedulerCursor).w	; $4C82
	jsr (A0)	; $4C88
	movea.w (RAM_CurrentTaskSlot).w, A5	; $4C8A
	lea ($80,A5), A5	; $4C8E
	addq.b #$1, (RAM_word_FFFF8A4A).w	; $4C92
	cmpi.b #$10, (RAM_word_FFFF8A4A).w	; $4C96
	bcs.b *+$A	; $4C9C
	clr.b (RAM_word_FFFF8A4A).w	; $4C9E
	lea (-$7DB8).w, A5	; $4CA2
RunTaskList_Done:
	rts	; $4CA6
	movea.w (RAM_CurrentTaskSlot).w, A5	; $4CA8
	clr.w (A5)	; $4CAC
	move.w D0, (RAM_word_FFFF8068).w	; $4CAE
	rts	; $4CB2
SubsystemTrap:
	nop	; $4CB4
	bra.b $4CB4	; $4CB6
	movea.l	#$4CC4, A1			; $4CB8
	jmp	$50E2.l				; $4CBE
TaskListData:					; loc_0004CC4
	dc.w	$4B73,$6D74	; $4CC4
	jsr	$364.w				; $4CC8
			dc.w	$43fa,$003e	; dc.w
	bsr.w $5106	; $4CD0
	jsr $400.w	; $4CD4
	bsr.w $513C	; $4CD8
	beq.b *+$10	; $4CDC
	bsr.w $5132	; $4CDE
	movea.l #$4D64, A1	; $4CE2
	bra.w $50D4	; $4CE8
TaskListDispatch:
	tst.b (RAM_word_FFFF80C8).w	; $4CEC
	bmi.b *+$1A	; $4CF0
	movea.l #$4F54, A1	; $4CF2
	tst.w (RAM_word_FFFF8068).w	; $4CF8
	bne.b *+$8	; $4CFC
	movea.l #$4D14, A1	; $4CFE
TaskListDispatch_Jump:
	jmp $50D4.l	; $4D04
TaskListDispatch_Done:
	rts	; $4D0A
TaskListData2:				; loc_0004D0C
	dc.w	$0000,$6F86,$0000,$0000,$4B74,$6D74	; $4D0C
	jsr $364.w	; $4D18
			dc.w	$43fa,$002c	; dc.w
	bsr.w $5106	; $4D20
	jsr $400.w	; $4D24
	bsr.w $513C	; $4D28
	bne.b *+$8	; $4D2C
	tst.b (RAM_word_FFFF80C8).w	; $4D2E
	bmi.b *+$16	; $4D32
SpawnKcolObject:
	movea.l #$5608, A0	; $4D34
	jsr $4A2.w	; $4D3A
	movea.l #$4D52, A1	; $4D3E
	bra.w $50E2	; $4D44
TaskListData2_Done:
	rts	; $4D48
	dc.w	$0000,$703E,$0000,$0000,$4B74,$6D33	; $4D4A
			dc.w	$43fa,$0004	; dc.w
	bra.b	*+$12				; $4D5A
	dc.w	$0000,$7136,$0000,$0000,$4B74,$6D32	; $4D5C
			dc.w	$43fa,$0032	; dc.w
TaskHandler_4D6C:
	bsr.w $5106	; $4D6C
	jsr $400.w	; $4D70
	bsr.w $513C	; $4D74
	beq.b *+$12	; $4D78
	moveq #$25, D0	; $4D7A
	jsr $366.w	; $4D7C
	movea.l #$4DA4, A1	; $4D80
	bra.w $50E2	; $4D86
TaskHandler_4D8A:
	tst.b (RAM_word_FFFF80C8).w	; $4D8A
	bmi.b *+$C	; $4D8E
	movea.l #$4DDE, A1	; $4D90
	bra.w $50D4	; $4D96
TaskHandler_4D8A_Done:
	rts	; $4D9A
	dc.w	$0000,$7158,$0000,$0000,$4B6D,$6E75	; $4D9C
			dc.w	$43fa,$002c	; dc.w
	bsr.w $5106	; $4DAC
	jsr $400.w	; $4DB0
	tst.b (RAM_word_FFFF80C8).w	; $4DB4
	bmi.b *+$1C	; $4DB8
	tst.w ($20,A5)	; $4DBA
	bpl.b *+$C	; $4DBE
	movea.l #$4DDE, A1	; $4DC0
	bra.w $50D4	; $4DC6
TaskHandler_4DCA:
	movea.l #$507C, A1	; $4DCA
	bra.w $50D4	; $4DD0
TaskHandler_4DCA_Done:
	rts	; $4DD4
	dc.w	$0000,$71C2,$0000,$0000,$4B64,$796D	; $4DD6
	jsr $364.w	; $4DE2
	bsr.w $5124	; $4DE6
	move.b #-$80, (RAM_word_FFFF8A50).w	; $4DEA
	lea ($4E64).l, A0	; $4DF0
	bsr.w $501C	; $4DF6
	moveq #$F, D0	; $4DFA
	lea RAM_word_00FF3300, A0	; $4DFC
	lea ($4F14).l, A1	; $4E02
	move.l (A1)+, (A0)+	; $4E08
	dbf D0, $4E08	; $4E0A
			dc.w	$43fa,$004c	; dc.w
	bsr.w $5106	; $4E12
	ori.b #$1, (RAM_word_FFFF8A51).w	; $4E16
	jsr $400.w	; $4E1C
	bsr.w $513C	; $4E20
	beq.b *+$12	; $4E24
	bsr.w $5132	; $4E26
	clr.b (RAM_word_FFFF8A50).w	; $4E2A
	movea.l #$4D64, A1	; $4E2E
	bra.b *+$1C	; $4E34
TaskHandler_4E36:
	bsr.w $505C	; $4E36
	tst.b (RAM_word_FFFF8A4E).w	; $4E3A
	beq.b *+$8	; $4E3E
	tst.b (RAM_word_FFFF80C8).w	; $4E40
	bmi.b *+$16	; $4E44
TaskHandler_4E36_Next:
	clr.b (RAM_word_FFFF8A50).w	; $4E46
	movea.l #$4CC4, A1	; $4E4A
LoadTaskList_Reset:
	andi.b #-$2, (RAM_word_FFFF8A51).w	; $4E50
	bra.w $50D4	; $4E56
TaskHandler_4E36_Done:
	rts	; $4E5A
EquipmentInitData:			; loc_0004E5C
	dc.b	$00,$00,$8e,$b0,$00,$00,$00,$00,$1c,$00,$14,$08,$11,$00,$0d,$01	; $4E5C
	dc.b	$2f,$00,$05,$20,$0d,$00,$14,$08,$10,$28,$77,$08,$0b,$28,$1a,$08	; $4E6C
	dc.b	$0b,$10,$0a,$00,$13,$08,$01,$00,$0a,$10,$12,$00,$0f,$10,$0e,$00	; $4E7C
	dc.b	$0b,$08,$09,$10,$12,$00,$04,$08,$06,$00,$11,$08,$01,$00,$10,$10	; $4E8C
	dc.b	$07,$00,$1e,$08,$19,$00,$20,$08,$03,$00,$1e,$08,$0b,$00,$0d,$01	; $4E9C
	dc.b	$01,$05,$01,$01,$08,$00,$09,$04,$0c,$00,$10,$01,$18,$00,$6a,$04	; $4EAC
	dc.b	$12,$00,$0e,$01,$b8,$00,$06,$20,$73,$00,$07,$20,$59,$00,$06,$20	; $4EBC
	dc.b	$a0,$00,$06,$20,$69,$00,$06,$20,$1e,$00,$08,$80,$14,$00,$07,$20	; $4ECC
	dc.b	$09,$00,$07,$02,$09,$00,$07,$20,$0a,$00,$06,$10,$07,$00,$07,$10	; $4EDC
	dc.b	$0c,$00,$50,$08,$14,$00,$0e,$02,$1e,$00,$93,$08,$0b,$28,$32,$08	; $4EEC
	dc.b	$08,$18,$15,$08,$08,$28,$10,$08,$10,$00,$00,$00,$00,$00,$00,$00	; $4EFC
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$20,$20,$20,$00,$0f	; $4F0C
	dc.b	$f0,$00,$52,$00,$03,$30,$00,$00,$08,$40,$00,$60,$fa,$33,$00,$00	; $4F1C
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$00,$00,$00,$00,$00	; $4F2C
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00	; $4F3C
	dc.b	$00,$00,$00,$00,$16,$44,$00,$00,$4b,$65,$64,$6d	; $4F4C
			dc.w	$43fa,$0066	; dc.w
	bsr.w $5106	; $4F5C
	jmp $1AA3C.l	; $4F60
	move.w #$E10, ($40,A5)	; $4F66
	jsr $400.w	; $4F6C
	jsr $1AD62.l	; $4F70
	subq.w #$1, ($40,A5)	; $4F76
	beq.b *+$A	; $4F7A
	bsr.w $513C	; $4F7C
	bne.b *+$4	; $4F80
	rts	; $4F82
TaskHandler_4F84:
	bsr.w $5842	; $4F84
	jsr $400.w	; $4F88
	jsr $1AD62.l	; $4F8C
	btst.b #$4, (RAM_word_FFFF8C56).w	; $4F92
	bne.b *+$4	; $4F98
	rts	; $4F9A
TaskHandler_4F84_Next:
	movea.l #$4CC4, A1	; $4F9C
	bra.w $50D4	; $4FA2
	bsr.w $5842	; $4FA6
WaitForFlag_4FAA:
	jsr	$400.w				; $4FAA
	btst.b #$4, (RAM_word_FFFF8C56).w	; $4FAE
	beq.b	WaitForFlag_4FAA			; $4FB4
	movea.l #$4CC4, A1	; $4FB6
	bra.w $50D4	; $4FBC
	dc.w	$0000,$4FC8,$0000,$0000,$4B65,$6473	; $4FC0
	clr.b (RAM_word_FFFFA3A4).w	; $4FCC
WaitForInput_4FD0:
	jsr	$400.w				; $4FD0
	tst.b (RAM_word_FFFFA3A4).w	; $4FD4
	beq.b	WaitForInput_4FD0			; $4FD8
	btst.b #$7, (RAM_InputSelectedNew).w	; $4FDA
	beq.b $4FD0	; $4FE0
	move.l #$4FA6, (RAM_word_FFFF8054).w	; $4FE2
	clr.w (A5)	; $4FEA
	rts	; $4FEC
	lea RAM_ScriptScratch, A0	; $4FEE
	move.l A0, ($44,A5)	; $4FF4
	move.w #$3FF, D1	; $4FF8
	moveq #$0, D0	; $4FFC
	move.l D0, (A0)+	; $4FFE
	dbf D1, $4FFE	; $5000
	move.b D0, (RAM_InputSelected).w	; $5004
	move.b D0, (RAM_InputSelectedPrev).w	; $5008
	move.b D0, (RAM_InputSelectedNew).w	; $500C
	move.l D0, (RAM_RNGState).w	; $5010
	rts	; $5014
	lea RAM_ScriptScratch, A0	; $5016
InitTaskSequence:
	move.w (A0)+, (RAM_word_FFFF8A4E).w	; $501C
	move.l A0, ($44,A5)	; $5020
	clr.l (RAM_RNGState).w	; $5024
	clr.b (RAM_InputSelected).w	; $5028
	clr.b (RAM_InputSelectedPrev).w	; $502C
	clr.b (RAM_InputSelectedNew).w	; $5030
	rts	; $5034
	movea.l ($44,A5), A0	; $5036
	move.b (RAM_InputSelected).w, D0	; $503A
	tst.b (A0)	; $503E
	beq.b *+$14	; $5040
	cmp.b ($1,A0), D0	; $5042
	bne.b *+$8	; $5046
	cmpi.b #-$1, (A0)	; $5048
	bne.b *+$C	; $504C
InputSequence_Next:
	addq.w #$2, A0	; $504E
	move.l A0, ($44,A5)	; $5050
InputSequence_Store:
	move.b D0, ($1,A0)	; $5054
InputSequence_Inc:
	addq.b #$1, (A0)	; $5058
	rts	; $505A
RunInputSequence:
	move.b (RAM_InputSelected).w, (RAM_InputSelectedPrev).w	; $505C
	move.b (RAM_word_FFFF8A4F).w, (RAM_InputSelected).w	; $5062
	subq.b #$1, (RAM_word_FFFF8A4E).w	; $5068
	bne.b *+$E	; $506C
	movea.l ($44,A5), A0	; $506E
	move.w (A0)+, (RAM_word_FFFF8A4E).w	; $5072
	move.l A0, ($44,A5)	; $5076
RunInputSequence_Done:
	rts	; $507A
	dc.w	$4B67,$6D74			; $507C  (task entry marker)
	jsr $364.w	; $5080
	bsr.w $5124	; $5084
	clr.b (RAM_word_FFFF8A50).w	; $5088
	clr.b (RAM_word_FFFF9658).w	; $508C
			dc.w	$43fa,$003a	; dc.w
	bsr.w $5106	; $5094
	ori.b #$1, (RAM_word_FFFF8A51).w	; $5098
	jsr $400.w	; $509E
	tst.b (RAM_word_FFFF80C8).w	; $50A2
	bmi.b *+$24	; $50A6
	tst.b (RAM_word_FFFF80C8).w	; $50A8
	bmi.b *+$1E	; $50AC
	movea.l #$4F54, A1	; $50AE
	tst.w (RAM_word_FFFF8068).w	; $50B4
	bne.b *+$8	; $50B8
	movea.l #$4CC4, A1	; $50BA
LoadTaskList_Clear:
	andi.b #-$2, (RAM_word_FFFF8A51).w	; $50C0
	bra.w $50D4	; $50C6
TaskHandler_Done:
	rts	; $50CA
	dc.w	$0000,$8EB0,$0000,$0000	; $50CC
	move.l	A1, -(SP)			; $50D4
	jsr	$559E.l				; $50D6
	jsr	$62A.w				; $50DC
	movea.l	(SP)+, A1			; $50E0
InstallTaskList:
	move.l A1, -(SP)	; $50E2
	jsr VBlankTick.l	; $50E4
	movea.l (SP)+, A1	; $50EA
	lea (-$7FB8).w, A0	; $50EC
	move.l (A1)+, ($4,A0)	; $50F0
InstallTaskList_Slot:
	move.l A1, ($C,A0)	; $50F4
	move.w D0, ($40,A0)	; $50F8
	move.w #-$8000, (A0)	; $50FC
	jmp ResetStack.l	; $5100
InstallTaskDescriptors:
	lea (-$7F38).w, A0	; $5106
InstallTaskDescriptors_Loop:
	move.l (A1)+, D0	; $510A
	beq.b *+$16	; $510C
	move.w #-$8000, (A0)	; $510E
	movea.l D0, A2	; $5112
	move.l (A2)+, ($4,A0)	; $5114
	move.l A2, ($C,A0)	; $5118
	lea ($80,A0), A0	; $511C
	bra.b $510A	; $5120
InstallTaskDescriptors_Done:
	rts	; $5122
ClearTaskBuffer:
	moveq #$6, D0	; $5124
	lea (-$666A).w, A0	; $5126
	clr.l (A0)+	; $512A
	dbf D0, $512A	; $512C
	rts	; $5130
PlaySound25:
	jsr $364.w	; $5132
	moveq #$25, D0	; $5136
	jmp $366.w	; $5138
CheckStartPressed:
	move.b (RAM_InputSelected2).w, D0	; $513C
	bpl.b *+$16	; $5140
	lea (-$757F).w, A0	; $5142
	andi.b #$7F, D0	; $5146
	beq.b *+$6	; $514A
	lea (-$757C).w, A0	; $514C
CheckStartPressed_Test:
	btst.b #$7, (A0)	; $5150
	rts	; $5154
SetStartFlag:
	moveq #-$80, D0	; $5156
	btst.b #$7, (RAM_word_FFFF8A81).w	; $5158
	bne.b *+$C	; $515E
	btst.b #$7, (RAM_word_FFFF8A84).w	; $5160
	beq.b *+$8	; $5166
	moveq #-$7F, D0	; $5168
SetStartFlag_Store:
	move.b D0, (RAM_InputSelected2).w	; $516A
SetStartFlag_Done:
	rts	; $516E
InitSubsystems:
	jsr $6F6.w	; $5170
	bsr.w $6910	; $5174
	bsr.w $6916	; $5178
	bsr.w $693E	; $517C
	bsr.w $696C	; $5180
	bra.w $559E	; $5184
	jsr $6BE.w	; $5188
	bsr.b $5170	; $518C
	moveq #-$80, D0	; $518E
	move.w D0, (RAM_word_FFFF8B34).w	; $5190
	move.w D0, (RAM_word_FFFF8B36).w	; $5194
	move.w D0, (RAM_word_FFFF8B38).w	; $5198
	move.w D0, (RAM_word_FFFF8B3A).w	; $519C
	bsr.w $5398	; $51A0
	lea ($6EA8).l, A0	; $51A4
	jsr $4A2.w	; $51AA
	lea	($5608).l, A0			; $51AE
	jsr	$4A2.w				; $51B4
			dc.w	$41fa,$0006	; dc.w
	jmp	$234C.w				; $51BC
ControllerPatchData:				; loc_00051C0
	dc.b	$B0,$FB,$FB,$FB,$FF,$00,$33,$FC,$01,$00,$00,$A1,$11,$00	; $51C0
ReadControllers_WaitZ80:
	btst.b	#$0, ($A11100).l		; $51CE
	bne.b	ReadControllers_WaitZ80			; $51D6
	lea ($A10003).l, A0	; $51D8
	lea (-$7581).w, A1	; $51DE
	bsr.b *+$34	; $51E2
	lea ($A10005).l, A0	; $51E4
	lea (-$757E).w, A1	; $51EA
	bsr.b *+$28	; $51EE
	move.w #$0, ($A11100).l	; $51F0
	btst.b #$0, (RAM_InputSelected2).w	; $51F8
	bne.b *+$6	; $51FE
	lea (-$7581).w, A1	; $5200
UpdateInputLatch:
	tst.b (RAM_word_FFFF8A50).w	; $5204
	bmi.b *+$C	; $5208
	move.b (RAM_InputSelected).w, (RAM_InputSelectedPrev).w	; $520A
	move.b (A1), (RAM_InputSelected).w	; $5210
UpdateInputLatch_Done:
	rts	; $5214
ReadControllerPort:
	move.b (A1), ($1,A1)	; $5216
	move.b #$0, (A0)	; $521A
	nop	; $521E
	nop	; $5220
	move.b (A0), D0	; $5222
	not.b D0	; $5224
	asl.b #$2, D0	; $5226
	andi.b #-$40, D0	; $5228
	move.b D0, (A1)	; $522C
	move.b #$40, (A0)	; $522E
	nop	; $5232
	nop	; $5234
	move.b (A0), D0	; $5236
	not.b D0	; $5238
	andi.b #$3F, D0	; $523A
	or.b D0, (A1)	; $523E
	move.b (A1), D1	; $5240
	move.b ($1,A1), D0	; $5242
	eor.b D1, D0	; $5246
	and.b D1, D0	; $5248
	move.b D0, ($2,A1)	; $524A
	rts	; $524E
ComputeNewPresses:
	move.b (RAM_InputSelected).w, D1	; $5250
	move.b (RAM_InputSelectedPrev).w, D0	; $5254
	eor.b D1, D0	; $5258
	and.b D1, D0	; $525A
	move.b D0, (RAM_InputSelectedNew).w	; $525C
	rts	; $5260
	bsr.w $529E	; $5262
	bsr.w $5338	; $5266
	bsr.w $557E	; $526A
	bsr.w $51C6	; $526E
	bsr.b $5250	; $5272
	tst.b (RAM_word_FFFF8A8B).w	; $5274
	beq.b *+$A	; $5278
	move.w #$3E7, D0	; $527A
	dbf D0, $527E	; $527E
VBlankScrollWrite:
	bsr.w $5370	; $5282
	bclr.b #$1, (RAM_VBlankFlag).w	; $5286
	beq.b *+$10	; $528C
	move.w (RAM_word_FFFF8A5C).w, D0	; $528E
	move.w D0, ($C00004).l	; $5292
	move.b D0, (RAM_word_FFFF8A7E).w	; $5298
VBlankScrollWrite_Done:
	rts	; $529C
VBlankPlaneWrite:
	bclr.b #$3, (RAM_VBlankFlag).w	; $529E
	bne.b *+$4	; $52A4
	rts	; $52A6
VBlankPaletteWrite:
	bsr.w $52DA	; $52A8
	move.l #$40000010, ($C00004).l	; $52AC
	moveq #$0, D0	; $52B6
	moveq #$0, D1	; $52B8
	moveq #$0, D2	; $52BA
	moveq #$28, D3	; $52BC
	lea (-$7574).w, A0	; $52BE
	lea (-$754C).w, A1	; $52C2
	btst.b #$2, (RAM_word_FFFF8A5F).w	; $52C6
	beq.b *+$48	; $52CC
	move.w (RAM_word_FFFF8ADC).w, D0	; $52CE
	move.w (RAM_word_FFFF8ADE).w, D1	; $52D2
	moveq #$13, D2	; $52D6
	bra.b *+$38	; $52D8
WriteScrollRegisters:
	move.w (RAM_BgColor_Addr).w, D0	; $52DA
	jsr $5A0.w	; $52DE
	moveq #$0, D0	; $52E2
	moveq #$0, D1	; $52E4
	moveq #$0, D2	; $52E6
	move.w #$200, D3	; $52E8
	lea RAM_word_00FF2400, A0	; $52EC
	lea RAM_word_00FF2600, A1	; $52F2
	moveq #$3, D4	; $52F8
	and.b (RAM_word_FFFF8A5F).w, D4	; $52FA
	beq.b *+$16	; $52FE
	move.w #$FF, D2	; $5300
	move.w (RAM_word_FFFF8AE0).w, D0	; $5304
	move.w (RAM_word_FFFF8AE2).w, D1	; $5308
	and.w D2, D0	; $530C
	and.w D2, D1	; $530E
WriteScrollRegisters_AddX:
	add.w D0, D0	; $5310
	add.w D1, D1	; $5312
WriteScrollRegisters_Loop:
	lea ($C00000).l, A2	; $5314
	move.w ($0,A0,D0.w), (A2)	; $531A
	move.w ($0,A1,D1.w), (A2)	; $531E
	addq.w #$2, D0	; $5322
	cmp.w D3, D0	; $5324
	bcs.b *+$4	; $5326
	moveq #$0, D0	; $5328
WriteScrollRegisters_AddY:
	addq.w #$2, D1	; $532A
	cmp.w D3, D0	; $532C
	bcs.b *+$4	; $532E
	moveq #$0, D1	; $5330
WriteScrollRegisters_Done:
	dbf D2, $531A	; $5332
	rts	; $5336
VBlankWindowWrite:
	bclr.b #$2, (RAM_VBlankFlag).w	; $5338
	beq.b *+$30	; $533E
	move.w (RAM_word_FFFF8A74).w, ($C00004).l	; $5340
	clr.w (RAM_word_FFFF8AE4).w	; $5348
	move.w (RAM_word_FFFF8A76).w, D0	; $534C
	move.w D0, ($C00004).l	; $5350
	moveq #$1F, D1	; $5356
	and.w D0, D1	; $5358
	beq.b *+$14	; $535A
	asl.w #$3, D1	; $535C
	addi.w #$60, D1	; $535E
	tst.b D0	; $5362
	bpl.b *+$6	; $5364
	addi.w #$20, D1	; $5366
VBlankWindowWrite_Store:
	move.w D1, (RAM_word_FFFF8AE4).w	; $536A
VBlankWindowWrite_Done:
	rts	; $536E
UploadPaletteCRAM:
	bclr.b #$7, (RAM_word_FFFF8C56).w	; $5370
	beq.b *+$20	; $5376
	move.l #-$40000000, ($C00004).l	; $5378
	lea (-$742A).w, A0	; $5382
	lea ($C00000).l, A1	; $5386
	move.w #$1F, D0	; $538C
	move.l (A0)+, (A1)	; $5390
	dbf D0, $5390	; $5392
UploadPaletteCRAM_Done:
	rts	; $5396
ClearEntitySlots:
	moveq #$0, D0	; $5398
	movea.w D0, A4	; $539A
	moveq #$3F, D1	; $539C
	move.b D0, (-$4000,A4)	; $539E
	addq.w #$4, A4	; $53A2
	dbf D1, $539E	; $53A4
	rts	; $53A8
	lea (-$7518).w, A0	; $53AA
	moveq #-$1, D0	; $53AE
	moveq #$F, D1	; $53B0
	move.l D0, (A0)+	; $53B2
	dbf D1, $53B2	; $53B4
	movea.w #$0, A4	; $53B8
EntitySlotMaintain:
	andi.b #-$2, (-$4000,A4)	; $53BC
	move.b (-$4000,A4), D0	; $53C2
	andi.b #-$40, D0	; $53C6
	cmpi.b #-$40, D0	; $53CA
	bne.b *+$42	; $53CE
	bclr.b #$7, (-$3FFD,A4)	; $53D0
	bne.b *+$C	; $53D6
	jsr $80E.w	; $53D8
	andi.b #$7F, (-$3FFD,A4)	; $53DC
EntitySlotMaintain_Check:
	btst.b #$2, (-$3FFD,A4)	; $53E2
	bne.b *+$28	; $53E8
	move.w #-$1, (-$38FE,A4)	; $53EA
	move.b (-$3CFD,A4), D0	; $53F0
	ext.w D0	; $53F4
	lea (-$7518).w, A0	; $53F6
	move.w ($0,A0,D0.w), D1	; $53FA
	bpl.b *+$8	; $53FE
	move.w A4, ($20,A0,D0.w)	; $5400
	bra.b *+$8	; $5404
EntitySlotMaintain_Link:
	movea.w D1, A1	; $5406
	move.w A4, (-$38FE,A1)	; $5408
EntitySlotMaintain_Store:
	move.w A4, ($0,A0,D0.w)	; $540C
EntitySlotMaintain_Next:
	addq.w #$4, A4	; $5410
	cmpa.w #$100, A4	; $5412
	bcs.b $53BC	; $5416
	move.w #$180, (RAM_word_FFFF8B2E).w	; $5418
	move.w #$80, (RAM_word_FFFF8B28).w	; $541E
	move.w #$160, (RAM_word_FFFF8B2A).w	; $5424
	move.b #$0, (RAM_word_FFFF8B30).w	; $542A
	move.b #$40, (RAM_word_FFFF8B31).w	; $5430
	lea RAM_word_00FF2800, A3	; $5436
	lea (-$74F8).w, A2	; $543C
	move.b #$2, (RAM_word_FFFF8B32).w	; $5440
	move.b #$10, (RAM_word_FFFF8B33).w	; $5446
BuildSpriteAttrs:
	move.w (A2)+, D0	; $544C
	bmi.b *+$E	; $544E
BuildSpriteAttrs_Entity:
	movea.w D0, A4	; $5450
	bsr.b *+$72	; $5452
	beq.b *+$66	; $5454
	move.w (-$38FE,A4), D0	; $5456
	bpl.b	BuildSpriteAttrs_Entity			; $545A
BuildSpriteAttrs_Count:
	subq.b #$1, (RAM_word_FFFF8B32).w	; $545C
	bne.b *+$48	; $5460
	cmpi.b #$3, (RAM_word_FFFF8B31).w	; $5462
	bcs.b *+$46	; $5468
	move.w (RAM_word_FFFF8AE4).w, D0	; $546A
	beq.b *+$3A	; $546E
	move.w D0, D2	; $5470
	swap D0	; $5472
	move.w #$300, D0	; $5474
	move.b (RAM_word_FFFF8B30).w, D0	; $5478
	addq.b #$1, D0	; $547C
	move.l D0, (A3)+	; $547E
	moveq #$10, D1	; $5480
	move.l D1, (A3)+	; $5482
	addq.b #$1, D0	; $5484
	move.l D0, (A3)+	; $5486
	moveq #$0, D1	; $5488
	move.l D1, (A3)+	; $548A
	move.b D0, (RAM_word_FFFF8B30).w	; $548C
	subq.b #$2, (RAM_word_FFFF8B31).w	; $5490
	tst.b (RAM_word_FFFF8A77).w	; $5494
	bmi.b *+$C	; $5498
	addi.w #$20, D2	; $549A
	move.w D2, (RAM_word_FFFF8B28).w	; $549E
	bra.b *+$6	; $54A2
BuildSpriteAttrs_StoreY:
	move.w D2, (RAM_word_FFFF8B2A).w	; $54A4
BuildSpriteAttrs_Countdown:
	subq.b #$1, (RAM_word_FFFF8B33).w	; $54A8
	bne.b $544C	; $54AC
BuildSpriteAttrs_End:
	tst.b (RAM_word_FFFF8B30).w	; $54AE
	bne.b *+$8	; $54B2
	moveq #$0, D0	; $54B4
	move.l D0, (A3)	; $54B6
	bra.b *+$6	; $54B8
BuildSpriteAttrs_Clear:
	clr.b (-$5,A3)	; $54BA
BuildSpriteAttrs_Done:
	move.l A3, (RAM_word_FFFF8B52).w	; $54BE
	rts	; $54C2
BuildSpriteEntry:
	lea (-$74CC).w, A0	; $54C4
	adda.w (-$3E00,A4), A0	; $54C8
	move.w (-$3800,A4), D2	; $54CC
	sub.w (A0)+, D2	; $54D0
	move.w (-$3700,A4), D3	; $54D2
	sub.w (A0)+, D3	; $54D6
	move.w (-$3FFE,A4), D1	; $54D8
	andi.w #-$800, D1	; $54DC
	moveq #$0, D0	; $54E0
	btst.b #$3, (-$3FFD,A4)	; $54E2
	bne.b *+$6	; $54E8
	move.w (-$3DFE,A4), D0	; $54EA
BuildSpriteEntry_Store:
	move.w D0, (RAM_word_FFFF8B50).w	; $54EE
	movea.l (-$3F00,A4), A0	; $54F2
BuildSpriteEntry_Loop:
	move.b (A0)+, D6	; $54F6
	bmi.w $557C	; $54F8
	ext.w D6	; $54FC
	move.b (A0)+, D5	; $54FE
	lsl.w #$8, D5	; $5500
	move.b (A0)+, D5	; $5502
	eor.w D1, D5	; $5504
	add.w (RAM_word_FFFF8B50).w, D5	; $5506
	swap D5	; $550A
	move.b (A0)+, D5	; $550C
	move.b (A0)+, D4	; $550E
	add.w D6, D6	; $5510
	move.w D6, D0	; $5512
	andi.w #$18, D0	; $5514
	addq.w #$8, D0	; $5518
	ext.w D5	; $551A
	btst.l #$B, D1	; $551C
	beq.b *+$6	; $5520
	neg.w D5	; $5522
	sub.w D0, D5	; $5524
BuildSpriteEntry_X:
	add.w D2, D5	; $5526
	cmp.w (RAM_word_FFFF8B2E).w, D5	; $5528
	bcc.b $54F6	; $552C
	add.w D5, D0	; $552E
	cmpi.w #$80, D0	; $5530
	bcs.b $54F6	; $5534
	lsl.w #$2, D6	; $5536
	move.w D6, D0	; $5538
	andi.w #$18, D0	; $553A
	addq.w #$8, D0	; $553E
	ext.w D4	; $5540
	btst.l #$C, D1	; $5542
	beq.b *+$6	; $5546
	neg.w D4	; $5548
	sub.w D0, D4	; $554A
BuildSpriteEntry_Y:
	add.w D3, D4	; $554C
	cmp.w (RAM_word_FFFF8B2A).w, D4	; $554E
	bcc.b $54F6	; $5552
	add.w D4, D0	; $5554
	cmp.w (RAM_word_FFFF8B28).w, D0	; $5556
	bcs.b $54F6	; $555A
	move.w D4, (A3)+	; $555C
	lsl.w #$5, D6	; $555E
	move.b (RAM_word_FFFF8B30).w, D6	; $5560
	addq.b #$1, D6	; $5564
	move.b D6, (RAM_word_FFFF8B30).w	; $5566
	move.w D6, (A3)+	; $556A
	move.l D5, (A3)+	; $556C
	ori.b #$1, (-$4000,A4)	; $556E
	subq.b #$1, (RAM_word_FFFF8B31).w	; $5574
	bne.w $54F6	; $5578
BuildSpriteEntry_Done:
	rts	; $557C
UploadSpriteTable:
	lea ($C00000).l, A1	; $557E
	move.l #$50000003, ($4,A1)	; $5584
	lea RAM_word_00FF2800, A0	; $558C
	move.w #$9F, D0	; $5592
	move.l (A0)+, (A1)	; $5596
	dbf D0, $5596	; $5598
	rts	; $559C
ClearScrollBuffers:
	moveq #$0, D1	; $559E
	lea (-$74AA).w, A0	; $55A0
	lea (-$742A).w, A1	; $55A4
	moveq #$1F, D0	; $55A8
	move.l D1, (A0)+	; $55AA
	move.l D1, (A1)+	; $55AC
	dbf D0, $55AA	; $55AE
	ori.b #-$80, (RAM_word_FFFF8C56).w	; $55B2
	rts	; $55B8
CopyScrollBuffers:
	lea (-$74AA).w, A0	; $55BA
	lea (-$742A).w, A1	; $55BE
	move.w #$1F, D0	; $55C2
	move.l (A0)+, (A1)+	; $55C6
	dbf D0, $55C6	; $55C8
	andi.b #$3F, (RAM_word_FFFF8C56).w	; $55CC
	ori.b #-$7F, (RAM_word_FFFF8C56).w	; $55D2
	rts	; $55D8
	moveq #$0, D0	; $55DA
	move.b D0, (RAM_word_FFFF8C56).w	; $55DC
	lea (-$73A8).l, A0	; $55E0
	moveq #$0, D1	; $55E6
	move.w D0, (A0)	; $55E8
	lea ($10,A0), A0	; $55EA
	dbf D1, $55E8	; $55EE
	lea (-$7398).l, A0	; $55F2
	moveq #$0, D1	; $55F8
	move.w D0, (A0)	; $55FA
	addq.w #$6, A0	; $55FC
	dbf D1, $55F2	; $55FE
	move.b D0, (RAM_word_FFFF8C57).w	; $5602
	rts	; $5606
	dc.b	"Kcol"				; $5608  (name string)
	btst.b #$2, (RAM_word_FFFF8C56).w	; $560C
	bne.b *+$44	; $5612
	bsr.w $56BE	; $5614
	btst.b #$5, (RAM_word_FFFF8C56).w	; $5618
	beq.b *+$20	; $561E
	btst.b #$3, (RAM_word_FFFF8C56).w	; $5620
	beq.b *+$8	; $5626
	bsr.w $58D6	; $5628
	bra.b *+$6	; $562C
SceneUpdate:
	bsr.w $5892	; $562E
SceneUpdate_Check:
	bclr.b #$1, (RAM_word_FFFF8C56).w	; $5632
	bne.b *+$6	; $5638
	bsr.w $5916	; $563A
SceneUpdate_Count:
	tst.b (RAM_word_FFFF8C57).w	; $563E
	bne.b *+$C	; $5642
	moveq #$41, D0	; $5644
	and.b (RAM_word_FFFF8C56).w, D0	; $5646
	subq.b #$1, D0	; $564A
	beq.b *+$6	; $564C
SceneUpdate_Copy:
	bsr.w $55BA	; $564E
SceneUpdate_Next:
	bra.w $579A	; $5652
SceneUpdate_Done:
	rts	; $5656
	lea (-$73A8).w, A2	; $5658
	moveq #$0, D1	; $565C
	tst.b (A2)	; $565E
	bpl.b *+$12	; $5660
	lea ($10,A2), A2	; $5662
	dbf D1, $565E	; $5666
	moveq #$3, D0	; $566A
	jmp $4CB4.l	; $566C
SpawnObjectById:
	lea ($643C).l, A0	; $5672
SpawnObjectById_Store:
	move.l ($0,A0,D0.w), ($2,A2)	; $5678
	lea ($5608).l, A1	; $567E
	jsr $47A.w	; $5684
	move.l #$569C, ($8,A0)	; $5688
	move.w #$0, ($6,A2)	; $5690
	move.w #-$7FFF, (A2)	; $5696
	rts	; $569A
	lea (-$73A8).w, A0	; $569C
	moveq #$0, D0	; $56A0
	clr.b (A0)	; $56A2
	lea ($10,A0), A0	; $56A4
	dbf D0, $56A2	; $56A8
	lea (-$7398).l, A0	; $56AC
	moveq #$0, D0	; $56B2
	clr.b (A0)	; $56B4
	addq.w #$6, A0	; $56B6
	dbf D0, $56B4	; $56B8
	rts	; $56BC
ScanObjectSlots:
	moveq #$0, D0	; $56BE
	lea (-$73A8).w, A0	; $56C0
	tst.b (A0)	; $56C4
	bmi.b *+$C	; $56C6
ScanObjectSlots_Next:
	lea	($10,A0), A0			; $56C8
	dbf D0, $56C4	; $56CC
	rts	; $56D0
ScanObjectSlots_Tick:
	subq.b #$1, ($1,A0)	; $56D2
	bne.b	ScanObjectSlots_Next			; $56D6
	movea.l ($2,A0), A1	; $56D8
	move.w ($6,A0), D1	; $56DC
	move.b ($0,A1,D1.w), D2	; $56E0
	bpl.b *+$6	; $56E4
	clr.w (A0)	; $56E6
	bra.b ScanObjectSlots_Next	; $56E8
ScanObjectSlots_Next2:
	bne.b $5704	; $56EA
	moveq #$0, D2	; $56EC
	move.b ($1,A1,D1.w), D2	; $56EE
	addq.w #$2, D1	; $56F2
	asl.w #$2, D2	; $56F4
	lea ($5756).l, A2	; $56F6
	movea.l ($0,A2,D2.w), A2	; $56FC
