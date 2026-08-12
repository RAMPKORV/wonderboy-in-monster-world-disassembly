; ======================================================================
; src/subsystem.asm
; <What this region does>.
; Covers ROM $4C82-$5700.
; Verified bit-exact against the original ROM.
; ======================================================================
	move.b ($FFFF8A4A).w, ($FFFF8A48).w	; $4C82
	jsr (A0)	; $4C88
	movea.w ($FFFF8A4C).w, A5	; $4C8A
	lea ($80,A5), A5	; $4C8E
	addq.b #$1, ($FFFF8A4A).w	; $4C92
	cmpi.b #$10, ($FFFF8A4A).w	; $4C96
	bcs.b *+$A	; $4C9C
	clr.b ($FFFF8A4A).w	; $4C9E
	lea (-$7DB8).w, A5	; $4CA2
loc_4CA6:
	rts	; $4CA6
	movea.w ($FFFF8A4C).w, A5	; $4CA8
	clr.w (A5)	; $4CAC
	move.w D0, ($FFFF8068).w	; $4CAE
	rts	; $4CB2
loc_4CB4:
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
loc_4CEC:
	tst.b ($FFFF80C8).w	; $4CEC
	bmi.b *+$1A	; $4CF0
	movea.l #$4F54, A1	; $4CF2
	tst.w ($FFFF8068).w	; $4CF8
	bne.b *+$8	; $4CFC
	movea.l #$4D14, A1	; $4CFE
loc_4D04:
	jmp $50D4.l	; $4D04
loc_4D0A:
	rts	; $4D0A
TaskListData2:				; loc_0004D0C
	dc.w	$0000,$6F86,$0000,$0000,$4B74,$6D74	; $4D0C
	jsr $364.w	; $4D18
			dc.w	$43fa,$002c	; dc.w
	bsr.w $5106	; $4D20
	jsr $400.w	; $4D24
	bsr.w $513C	; $4D28
	bne.b *+$8	; $4D2C
	tst.b ($FFFF80C8).w	; $4D2E
	bmi.b *+$16	; $4D32
loc_4D34:
	movea.l #$5608, A0	; $4D34
	jsr $4A2.w	; $4D3A
	movea.l #$4D52, A1	; $4D3E
	bra.w $50E2	; $4D44
loc_4D48:
	rts	; $4D48
	dc.w	$0000,$703E,$0000,$0000,$4B74,$6D33	; $4D4A
			dc.w	$43fa,$0004	; dc.w
	bra.b	*+$12				; $4D5A
	dc.w	$0000,$7136,$0000,$0000,$4B74,$6D32	; $4D5C
			dc.w	$43fa,$0032	; dc.w
loc_4D6C:
	bsr.w $5106	; $4D6C
	jsr $400.w	; $4D70
	bsr.w $513C	; $4D74
	beq.b *+$12	; $4D78
	moveq #$25, D0	; $4D7A
	jsr $366.w	; $4D7C
	movea.l #$4DA4, A1	; $4D80
	bra.w $50E2	; $4D86
loc_4D8A:
	tst.b ($FFFF80C8).w	; $4D8A
	bmi.b *+$C	; $4D8E
	movea.l #$4DDE, A1	; $4D90
	bra.w $50D4	; $4D96
loc_4D9A:
	rts	; $4D9A
	dc.w	$0000,$7158,$0000,$0000,$4B6D,$6E75	; $4D9C
			dc.w	$43fa,$002c	; dc.w
	bsr.w $5106	; $4DAC
	jsr $400.w	; $4DB0
	tst.b ($FFFF80C8).w	; $4DB4
	bmi.b *+$1C	; $4DB8
	tst.w ($20,A5)	; $4DBA
	bpl.b *+$C	; $4DBE
	movea.l #$4DDE, A1	; $4DC0
	bra.w $50D4	; $4DC6
loc_4DCA:
	movea.l #$507C, A1	; $4DCA
	bra.w $50D4	; $4DD0
loc_4DD4:
	rts	; $4DD4
	dc.w	$0000,$71C2,$0000,$0000,$4B64,$796D	; $4DD6
	jsr $364.w	; $4DE2
	bsr.w $5124	; $4DE6
	move.b #-$80, ($FFFF8A50).w	; $4DEA
	lea ($4E64).l, A0	; $4DF0
	bsr.w $501C	; $4DF6
	moveq #$F, D0	; $4DFA
	lea $00FF3300, A0	; $4DFC
	lea ($4F14).l, A1	; $4E02
	move.l (A1)+, (A0)+	; $4E08
	dbf D0, $4E08	; $4E0A
			dc.w	$43fa,$004c	; dc.w
	bsr.w $5106	; $4E12
	ori.b #$1, ($FFFF8A51).w	; $4E16
	jsr $400.w	; $4E1C
	bsr.w $513C	; $4E20
	beq.b *+$12	; $4E24
	bsr.w $5132	; $4E26
	clr.b ($FFFF8A50).w	; $4E2A
	movea.l #$4D64, A1	; $4E2E
	bra.b *+$1C	; $4E34
loc_4E36:
	bsr.w $505C	; $4E36
	tst.b ($FFFF8A4E).w	; $4E3A
	beq.b *+$8	; $4E3E
	tst.b ($FFFF80C8).w	; $4E40
	bmi.b *+$16	; $4E44
loc_4E46:
	clr.b ($FFFF8A50).w	; $4E46
	movea.l #$4CC4, A1	; $4E4A
loc_4E50:
	andi.b #-$2, ($FFFF8A51).w	; $4E50
	bra.w $50D4	; $4E56
loc_4E5A:
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
loc_4F84:
	bsr.w $5842	; $4F84
	jsr $400.w	; $4F88
	jsr $1AD62.l	; $4F8C
	btst.b #$4, ($FFFF8C56).w	; $4F92
	bne.b *+$4	; $4F98
	rts	; $4F9A
loc_4F9C:
	movea.l #$4CC4, A1	; $4F9C
	bra.w $50D4	; $4FA2
	bsr.w $5842	; $4FA6
loc_4FAA:
	jsr	$400.w				; $4FAA
	btst.b #$4, ($FFFF8C56).w	; $4FAE
	beq.b	loc_4FAA			; $4FB4
	movea.l #$4CC4, A1	; $4FB6
	bra.w $50D4	; $4FBC
	dc.w	$0000,$4FC8,$0000,$0000,$4B65,$6473	; $4FC0
	clr.b ($FFFFA3A4).w	; $4FCC
loc_4FD0:
	jsr	$400.w				; $4FD0
	tst.b ($FFFFA3A4).w	; $4FD4
	beq.b	loc_4FD0			; $4FD8
	btst.b #$7, ($FFFF8A7C).w	; $4FDA
	beq.b $4FD0	; $4FE0
	move.l #$4FA6, ($FFFF8054).w	; $4FE2
	clr.w (A5)	; $4FEA
	rts	; $4FEC
	lea $00FF1400, A0	; $4FEE
	move.l A0, ($44,A5)	; $4FF4
	move.w #$3FF, D1	; $4FF8
	moveq #$0, D0	; $4FFC
	move.l D0, (A0)+	; $4FFE
	dbf D1, $4FFE	; $5000
	move.b D0, ($FFFF8A7A).w	; $5004
	move.b D0, ($FFFF8A7B).w	; $5008
	move.b D0, ($FFFF8A7C).w	; $500C
	move.l D0, ($FFFF8A52).w	; $5010
	rts	; $5014
	lea $00FF1400, A0	; $5016
loc_501C:
	move.w (A0)+, ($FFFF8A4E).w	; $501C
	move.l A0, ($44,A5)	; $5020
	clr.l ($FFFF8A52).w	; $5024
	clr.b ($FFFF8A7A).w	; $5028
	clr.b ($FFFF8A7B).w	; $502C
	clr.b ($FFFF8A7C).w	; $5030
	rts	; $5034
	movea.l ($44,A5), A0	; $5036
	move.b ($FFFF8A7A).w, D0	; $503A
	tst.b (A0)	; $503E
	beq.b *+$14	; $5040
	cmp.b ($1,A0), D0	; $5042
	bne.b *+$8	; $5046
	cmpi.b #-$1, (A0)	; $5048
	bne.b *+$C	; $504C
loc_504E:
	addq.w #$2, A0	; $504E
	move.l A0, ($44,A5)	; $5050
loc_5054:
	move.b D0, ($1,A0)	; $5054
loc_5058:
	addq.b #$1, (A0)	; $5058
	rts	; $505A
loc_505C:
	move.b ($FFFF8A7A).w, ($FFFF8A7B).w	; $505C
	move.b ($FFFF8A4F).w, ($FFFF8A7A).w	; $5062
	subq.b #$1, ($FFFF8A4E).w	; $5068
	bne.b *+$E	; $506C
	movea.l ($44,A5), A0	; $506E
	move.w (A0)+, ($FFFF8A4E).w	; $5072
	move.l A0, ($44,A5)	; $5076
loc_507A:
	rts	; $507A
	dc.w	$4B67,$6D74			; $507C  (task entry marker)
	jsr $364.w	; $5080
	bsr.w $5124	; $5084
	clr.b ($FFFF8A50).w	; $5088
	clr.b ($FFFF9658).w	; $508C
			dc.w	$43fa,$003a	; dc.w
	bsr.w $5106	; $5094
	ori.b #$1, ($FFFF8A51).w	; $5098
	jsr $400.w	; $509E
	tst.b ($FFFF80C8).w	; $50A2
	bmi.b *+$24	; $50A6
	tst.b ($FFFF80C8).w	; $50A8
	bmi.b *+$1E	; $50AC
	movea.l #$4F54, A1	; $50AE
	tst.w ($FFFF8068).w	; $50B4
	bne.b *+$8	; $50B8
	movea.l #$4CC4, A1	; $50BA
loc_50C0:
	andi.b #-$2, ($FFFF8A51).w	; $50C0
	bra.w $50D4	; $50C6
loc_50CA:
	rts	; $50CA
	dc.w	$0000,$8EB0,$0000,$0000	; $50CC
	move.l	A1, -(SP)			; $50D4
	jsr	$559E.l				; $50D6
	jsr	$62A.w				; $50DC
	movea.l	(SP)+, A1			; $50E0
loc_50E2:
	move.l A1, -(SP)	; $50E2
	jsr VBlankTick.l	; $50E4
	movea.l (SP)+, A1	; $50EA
	lea (-$7FB8).w, A0	; $50EC
	move.l (A1)+, ($4,A0)	; $50F0
loc_50F4:
	move.l A1, ($C,A0)	; $50F4
	move.w D0, ($40,A0)	; $50F8
	move.w #-$8000, (A0)	; $50FC
	jmp ResetStack.l	; $5100
loc_5106:
	lea (-$7F38).w, A0	; $5106
loc_510A:
	move.l (A1)+, D0	; $510A
	beq.b *+$16	; $510C
	move.w #-$8000, (A0)	; $510E
	movea.l D0, A2	; $5112
	move.l (A2)+, ($4,A0)	; $5114
	move.l A2, ($C,A0)	; $5118
	lea ($80,A0), A0	; $511C
	bra.b $510A	; $5120
loc_5122:
	rts	; $5122
loc_5124:
	moveq #$6, D0	; $5124
	lea (-$666A).w, A0	; $5126
	clr.l (A0)+	; $512A
	dbf D0, $512A	; $512C
	rts	; $5130
loc_5132:
	jsr $364.w	; $5132
	moveq #$25, D0	; $5136
	jmp $366.w	; $5138
loc_513C:
	move.b ($FFFF8A7D).w, D0	; $513C
	bpl.b *+$16	; $5140
	lea (-$757F).w, A0	; $5142
	andi.b #$7F, D0	; $5146
	beq.b *+$6	; $514A
	lea (-$757C).w, A0	; $514C
loc_5150:
	btst.b #$7, (A0)	; $5150
	rts	; $5154
loc_5156:
	moveq #-$80, D0	; $5156
	btst.b #$7, ($FFFF8A81).w	; $5158
	bne.b *+$C	; $515E
	btst.b #$7, ($FFFF8A84).w	; $5160
	beq.b *+$8	; $5166
	moveq #-$7F, D0	; $5168
loc_516A:
	move.b D0, ($FFFF8A7D).w	; $516A
loc_516E:
	rts	; $516E
loc_5170:
	jsr $6F6.w	; $5170
	bsr.w $6910	; $5174
	bsr.w $6916	; $5178
	bsr.w $693E	; $517C
	bsr.w $696C	; $5180
	bra.w $559E	; $5184
	jsr $6BE.w	; $5188
	bsr.b $5170	; $518C
	moveq #-$80, D0	; $518E
	move.w D0, ($FFFF8B34).w	; $5190
	move.w D0, ($FFFF8B36).w	; $5194
	move.w D0, ($FFFF8B38).w	; $5198
	move.w D0, ($FFFF8B3A).w	; $519C
	bsr.w $5398	; $51A0
	lea ($6EA8).l, A0	; $51A4
	jsr $4A2.w	; $51AA
	lea	($5608).l, A0			; $51AE
	jsr	$4A2.w				; $51B4
			dc.w	$41fa,$0006	; dc.w
	jmp	$234C.w				; $51BC
ControllerPatchData:				; loc_00051C0
	dc.b	$B0,$FB,$FB,$FB,$FF,$00,$33,$FC,$01,$00,$00,$A1,$11,$00	; $51C0
loc_51CE:
	btst.b	#$0, ($A11100).l		; $51CE
	bne.b	loc_51CE			; $51D6
	lea ($A10003).l, A0	; $51D8
	lea (-$7581).w, A1	; $51DE
	bsr.b *+$34	; $51E2
	lea ($A10005).l, A0	; $51E4
	lea (-$757E).w, A1	; $51EA
	bsr.b *+$28	; $51EE
	move.w #$0, ($A11100).l	; $51F0
	btst.b #$0, ($FFFF8A7D).w	; $51F8
	bne.b *+$6	; $51FE
	lea (-$7581).w, A1	; $5200
loc_5204:
	tst.b ($FFFF8A50).w	; $5204
	bmi.b *+$C	; $5208
	move.b ($FFFF8A7A).w, ($FFFF8A7B).w	; $520A
	move.b (A1), ($FFFF8A7A).w	; $5210
loc_5214:
	rts	; $5214
loc_5216:
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
loc_5250:
	move.b ($FFFF8A7A).w, D1	; $5250
	move.b ($FFFF8A7B).w, D0	; $5254
	eor.b D1, D0	; $5258
	and.b D1, D0	; $525A
	move.b D0, ($FFFF8A7C).w	; $525C
	rts	; $5260
	bsr.w $529E	; $5262
	bsr.w $5338	; $5266
	bsr.w $557E	; $526A
	bsr.w $51C6	; $526E
	bsr.b $5250	; $5272
	tst.b ($FFFF8A8B).w	; $5274
	beq.b *+$A	; $5278
	move.w #$3E7, D0	; $527A
	dbf D0, $527E	; $527E
loc_5282:
	bsr.w $5370	; $5282
	bclr.b #$1, ($FFFF8006).w	; $5286
	beq.b *+$10	; $528C
	move.w ($FFFF8A5C).w, D0	; $528E
	move.w D0, ($C00004).l	; $5292
	move.b D0, ($FFFF8A7E).w	; $5298
loc_529C:
	rts	; $529C
loc_529E:
	bclr.b #$3, ($FFFF8006).w	; $529E
	bne.b *+$4	; $52A4
	rts	; $52A6
loc_52A8:
	bsr.w $52DA	; $52A8
	move.l #$40000010, ($C00004).l	; $52AC
	moveq #$0, D0	; $52B6
	moveq #$0, D1	; $52B8
	moveq #$0, D2	; $52BA
	moveq #$28, D3	; $52BC
	lea (-$7574).w, A0	; $52BE
	lea (-$754C).w, A1	; $52C2
	btst.b #$2, ($FFFF8A5F).w	; $52C6
	beq.b *+$48	; $52CC
	move.w ($FFFF8ADC).w, D0	; $52CE
	move.w ($FFFF8ADE).w, D1	; $52D2
	moveq #$13, D2	; $52D6
	bra.b *+$38	; $52D8
loc_52DA:
	move.w ($FFFF8A6A).w, D0	; $52DA
	jsr $5A0.w	; $52DE
	moveq #$0, D0	; $52E2
	moveq #$0, D1	; $52E4
	moveq #$0, D2	; $52E6
	move.w #$200, D3	; $52E8
	lea $00FF2400, A0	; $52EC
	lea $00FF2600, A1	; $52F2
	moveq #$3, D4	; $52F8
	and.b ($FFFF8A5F).w, D4	; $52FA
	beq.b *+$16	; $52FE
	move.w #$FF, D2	; $5300
	move.w ($FFFF8AE0).w, D0	; $5304
	move.w ($FFFF8AE2).w, D1	; $5308
	and.w D2, D0	; $530C
	and.w D2, D1	; $530E
loc_5310:
	add.w D0, D0	; $5310
	add.w D1, D1	; $5312
loc_5314:
	lea ($C00000).l, A2	; $5314
	move.w ($0,A0,D0.w), (A2)	; $531A
	move.w ($0,A1,D1.w), (A2)	; $531E
	addq.w #$2, D0	; $5322
	cmp.w D3, D0	; $5324
	bcs.b *+$4	; $5326
	moveq #$0, D0	; $5328
loc_532A:
	addq.w #$2, D1	; $532A
	cmp.w D3, D0	; $532C
	bcs.b *+$4	; $532E
	moveq #$0, D1	; $5330
loc_5332:
	dbf D2, $531A	; $5332
	rts	; $5336
loc_5338:
	bclr.b #$2, ($FFFF8006).w	; $5338
	beq.b *+$30	; $533E
	move.w ($FFFF8A74).w, ($C00004).l	; $5340
	clr.w ($FFFF8AE4).w	; $5348
	move.w ($FFFF8A76).w, D0	; $534C
	move.w D0, ($C00004).l	; $5350
	moveq #$1F, D1	; $5356
	and.w D0, D1	; $5358
	beq.b *+$14	; $535A
	asl.w #$3, D1	; $535C
	addi.w #$60, D1	; $535E
	tst.b D0	; $5362
	bpl.b *+$6	; $5364
	addi.w #$20, D1	; $5366
loc_536A:
	move.w D1, ($FFFF8AE4).w	; $536A
loc_536E:
	rts	; $536E
loc_5370:
	bclr.b #$7, ($FFFF8C56).w	; $5370
	beq.b *+$20	; $5376
	move.l #-$40000000, ($C00004).l	; $5378
	lea (-$742A).w, A0	; $5382
	lea ($C00000).l, A1	; $5386
	move.w #$1F, D0	; $538C
	move.l (A0)+, (A1)	; $5390
	dbf D0, $5390	; $5392
loc_5396:
	rts	; $5396
loc_5398:
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
loc_53BC:
	andi.b #-$2, (-$4000,A4)	; $53BC
	move.b (-$4000,A4), D0	; $53C2
	andi.b #-$40, D0	; $53C6
	cmpi.b #-$40, D0	; $53CA
	bne.b *+$42	; $53CE
	bclr.b #$7, (-$3FFD,A4)	; $53D0
	bne.b *+$C	; $53D6
	jsr $80E.w	; $53D8
	andi.b #$7F, (-$3FFD,A4)	; $53DC
loc_53E2:
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
loc_5406:
	movea.w D1, A1	; $5406
	move.w A4, (-$38FE,A1)	; $5408
loc_540C:
	move.w A4, ($0,A0,D0.w)	; $540C
loc_5410:
	addq.w #$4, A4	; $5410
	cmpa.w #$100, A4	; $5412
	bcs.b $53BC	; $5416
	move.w #$180, ($FFFF8B2E).w	; $5418
	move.w #$80, ($FFFF8B28).w	; $541E
	move.w #$160, ($FFFF8B2A).w	; $5424
	move.b #$0, ($FFFF8B30).w	; $542A
	move.b #$40, ($FFFF8B31).w	; $5430
	lea $00FF2800, A3	; $5436
	lea (-$74F8).w, A2	; $543C
	move.b #$2, ($FFFF8B32).w	; $5440
	move.b #$10, ($FFFF8B33).w	; $5446
loc_544C:
	move.w (A2)+, D0	; $544C
	bmi.b *+$E	; $544E
loc_5450:
	movea.w D0, A4	; $5450
	bsr.b *+$72	; $5452
	beq.b *+$66	; $5454
	move.w (-$38FE,A4), D0	; $5456
	bpl.b	loc_5450			; $545A
loc_545C:
	subq.b #$1, ($FFFF8B32).w	; $545C
	bne.b *+$48	; $5460
	cmpi.b #$3, ($FFFF8B31).w	; $5462
	bcs.b *+$46	; $5468
	move.w ($FFFF8AE4).w, D0	; $546A
	beq.b *+$3A	; $546E
	move.w D0, D2	; $5470
	swap D0	; $5472
	move.w #$300, D0	; $5474
	move.b ($FFFF8B30).w, D0	; $5478
	addq.b #$1, D0	; $547C
	move.l D0, (A3)+	; $547E
	moveq #$10, D1	; $5480
	move.l D1, (A3)+	; $5482
	addq.b #$1, D0	; $5484
	move.l D0, (A3)+	; $5486
	moveq #$0, D1	; $5488
	move.l D1, (A3)+	; $548A
	move.b D0, ($FFFF8B30).w	; $548C
	subq.b #$2, ($FFFF8B31).w	; $5490
	tst.b ($FFFF8A77).w	; $5494
	bmi.b *+$C	; $5498
	addi.w #$20, D2	; $549A
	move.w D2, ($FFFF8B28).w	; $549E
	bra.b *+$6	; $54A2
loc_54A4:
	move.w D2, ($FFFF8B2A).w	; $54A4
loc_54A8:
	subq.b #$1, ($FFFF8B33).w	; $54A8
	bne.b $544C	; $54AC
loc_54AE:
	tst.b ($FFFF8B30).w	; $54AE
	bne.b *+$8	; $54B2
	moveq #$0, D0	; $54B4
	move.l D0, (A3)	; $54B6
	bra.b *+$6	; $54B8
loc_54BA:
	clr.b (-$5,A3)	; $54BA
loc_54BE:
	move.l A3, ($FFFF8B52).w	; $54BE
	rts	; $54C2
loc_54C4:
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
loc_54EE:
	move.w D0, ($FFFF8B50).w	; $54EE
	movea.l (-$3F00,A4), A0	; $54F2
loc_54F6:
	move.b (A0)+, D6	; $54F6
	bmi.w $557C	; $54F8
	ext.w D6	; $54FC
	move.b (A0)+, D5	; $54FE
	lsl.w #$8, D5	; $5500
	move.b (A0)+, D5	; $5502
	eor.w D1, D5	; $5504
	add.w ($FFFF8B50).w, D5	; $5506
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
loc_5526:
	add.w D2, D5	; $5526
	cmp.w ($FFFF8B2E).w, D5	; $5528
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
loc_554C:
	add.w D3, D4	; $554C
	cmp.w ($FFFF8B2A).w, D4	; $554E
	bcc.b $54F6	; $5552
	add.w D4, D0	; $5554
	cmp.w ($FFFF8B28).w, D0	; $5556
	bcs.b $54F6	; $555A
	move.w D4, (A3)+	; $555C
	lsl.w #$5, D6	; $555E
	move.b ($FFFF8B30).w, D6	; $5560
	addq.b #$1, D6	; $5564
	move.b D6, ($FFFF8B30).w	; $5566
	move.w D6, (A3)+	; $556A
	move.l D5, (A3)+	; $556C
	ori.b #$1, (-$4000,A4)	; $556E
	subq.b #$1, ($FFFF8B31).w	; $5574
	bne.w $54F6	; $5578
loc_557C:
	rts	; $557C
loc_557E:
	lea ($C00000).l, A1	; $557E
	move.l #$50000003, ($4,A1)	; $5584
	lea $00FF2800, A0	; $558C
	move.w #$9F, D0	; $5592
	move.l (A0)+, (A1)	; $5596
	dbf D0, $5596	; $5598
	rts	; $559C
loc_559E:
	moveq #$0, D1	; $559E
	lea (-$74AA).w, A0	; $55A0
	lea (-$742A).w, A1	; $55A4
	moveq #$1F, D0	; $55A8
	move.l D1, (A0)+	; $55AA
	move.l D1, (A1)+	; $55AC
	dbf D0, $55AA	; $55AE
	ori.b #-$80, ($FFFF8C56).w	; $55B2
	rts	; $55B8
loc_55BA:
	lea (-$74AA).w, A0	; $55BA
	lea (-$742A).w, A1	; $55BE
	move.w #$1F, D0	; $55C2
	move.l (A0)+, (A1)+	; $55C6
	dbf D0, $55C6	; $55C8
	andi.b #$3F, ($FFFF8C56).w	; $55CC
	ori.b #-$7F, ($FFFF8C56).w	; $55D2
	rts	; $55D8
	moveq #$0, D0	; $55DA
	move.b D0, ($FFFF8C56).w	; $55DC
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
	move.b D0, ($FFFF8C57).w	; $5602
	rts	; $5606
	dc.b	"Kcol"				; $5608  (name string)
	btst.b #$2, ($FFFF8C56).w	; $560C
	bne.b *+$44	; $5612
	bsr.w $56BE	; $5614
	btst.b #$5, ($FFFF8C56).w	; $5618
	beq.b *+$20	; $561E
	btst.b #$3, ($FFFF8C56).w	; $5620
	beq.b *+$8	; $5626
	bsr.w $58D6	; $5628
	bra.b *+$6	; $562C
loc_562E:
	bsr.w $5892	; $562E
loc_5632:
	bclr.b #$1, ($FFFF8C56).w	; $5632
	bne.b *+$6	; $5638
	bsr.w $5916	; $563A
loc_563E:
	tst.b ($FFFF8C57).w	; $563E
	bne.b *+$C	; $5642
	moveq #$41, D0	; $5644
	and.b ($FFFF8C56).w, D0	; $5646
	subq.b #$1, D0	; $564A
	beq.b *+$6	; $564C
loc_564E:
	bsr.w $55BA	; $564E
loc_5652:
	bra.w $579A	; $5652
loc_5656:
	rts	; $5656
	lea (-$73A8).w, A2	; $5658
	moveq #$0, D1	; $565C
	tst.b (A2)	; $565E
	bpl.b *+$12	; $5660
	lea ($10,A2), A2	; $5662
	dbf D1, $565E	; $5666
	moveq #$3, D0	; $566A
	jmp $4CB4.l	; $566C
loc_5672:
	lea ($643C).l, A0	; $5672
loc_5678:
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
loc_56BE:
	moveq #$0, D0	; $56BE
	lea (-$73A8).w, A0	; $56C0
	tst.b (A0)	; $56C4
	bmi.b *+$C	; $56C6
loc_56C8:
	lea	($10,A0), A0			; $56C8
	dbf D0, $56C4	; $56CC
	rts	; $56D0
loc_56D2:
	subq.b #$1, ($1,A0)	; $56D2
	bne.b	loc_56C8			; $56D6
	movea.l ($2,A0), A1	; $56D8
	move.w ($6,A0), D1	; $56DC
	move.b ($0,A1,D1.w), D2	; $56E0
	bpl.b *+$6	; $56E4
	clr.w (A0)	; $56E6
	bra.b $56C8	; $56E8
loc_56EA:
	bne.b $5704	; $56EA
	moveq #$0, D2	; $56EC
	move.b ($1,A1,D1.w), D2	; $56EE
	addq.w #$2, D1	; $56F2
	asl.w #$2, D2	; $56F4
	lea ($5756).l, A2	; $56F6
	movea.l ($0,A2,D2.w), A2	; $56FC
