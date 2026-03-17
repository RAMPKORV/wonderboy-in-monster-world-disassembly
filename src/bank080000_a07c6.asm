; ROM range: 0x0A07C6-0x0A08E5
; The first payload band after the 0x0A0000 offset-table tree has a regular 0x18-byte
; cadence. Each entry is four 6-byte tuples, but the tuple semantics and consuming loader
; are still unproven, so keep the labels structural.

Bank080000_FourTupleRecord_0A07C6:
	dc.b	$05,$00,$5C,$00,$FC,$03
	dc.b	$01,$A0,$F4,$EC,$08,$01
	dc.b	$09,$F4,$08,$08,$01,$06
	dc.b	$F4,$00,$09,$01,$00,$F4

Bank080000_FourTupleRecord_0A07DE:
	dc.b	$F0,$FF,$05,$00,$5C,$00
	dc.b	$FC,$03,$01,$A0,$F4,$EC
	dc.b	$08,$01,$0C,$F4,$08,$08
	dc.b	$01,$06,$F4,$00,$09,$01

Bank080000_FourTupleRecord_0A07F6:
	dc.b	$00,$F4,$F0,$FF,$05,$00
	dc.b	$5C,$00,$FC,$03,$01,$A0
	dc.b	$F4,$EC,$04,$01,$0F,$F7
	dc.b	$08,$08,$01,$06,$F4,$00

Bank080000_FourTupleRecord_0A080E:
	dc.b	$09,$01,$00,$F4,$F0,$FF
	dc.b	$05,$00,$5C,$00,$FC,$03
	dc.b	$01,$A0,$F4,$EC,$04,$01
	dc.b	$11,$F7,$08,$08,$01,$06

Bank080000_FourTupleRecord_0A0826:
	dc.b	$F4,$00,$09,$01,$00,$F4
	dc.b	$F0,$FF,$05,$00,$5C,$00
	dc.b	$FC,$03,$01,$A0,$F4,$EC
	dc.b	$09,$01,$15,$F4,$00,$09

Bank080000_FourTupleRecord_0A083E:
	dc.b	$01,$00,$F4,$F0,$FF,$05
	dc.b	$00,$5C,$00,$FE,$07,$01
	dc.b	$A4,$F0,$E8,$05,$01,$60
	dc.b	$F8,$00,$09,$01,$45,$F4

Bank080000_FourTupleRecord_0A0856:
	dc.b	$F0,$FF,$07,$01,$C2,$F8
	dc.b	$E4,$05,$01,$64,$F8,$00
	dc.b	$09,$01,$4B,$F4,$F0,$FF
	dc.b	$0B,$01,$AC,$00,$E5,$09

Bank080000_FourTupleRecord_0A086E:
	dc.b	$01,$68,$F3,$00,$09,$01
	dc.b	$4B,$F5,$F0,$FF,$0E,$01
	dc.b	$CA,$01,$F0,$09,$01,$68
	dc.b	$F3,$00,$09,$01,$4B,$F5

Bank080000_FourTupleRecord_0A0886:
	dc.b	$F0,$FF,$09,$01,$BC,$02
	dc.b	$01,$09,$01,$68,$F3,$00
	dc.b	$09,$01,$4B,$F5,$F0,$FF
	dc.b	$05,$01,$B8,$02,$01,$09

Bank080000_FourTupleRecord_0A089E:
	dc.b	$01,$68,$F3,$00,$09,$01
	dc.b	$4B,$F5,$F0,$FF,$05,$00
	dc.b	$5C,$03,$F9,$07,$01,$A4
	dc.b	$ED,$E8,$0B,$01,$2D,$F4

Bank080000_FourTupleRecord_0A08B6:
	dc.b	$F0,$FF,$0C,$01,$DB,$F8
	dc.b	$00,$05,$01,$51,$EE,$F8
	dc.b	$06,$01,$55,$FE,$F0,$FF
	dc.b	$00,$01,$DA,$1E,$00,$0C

Bank080000_FourTupleRecord_0A08CE:
	dc.b	$01,$D6,$FE,$00,$05,$01
	dc.b	$51,$EE,$F8,$06,$01,$55
	dc.b	$FE,$F0,$FF,$0B,$01,$39
	dc.b	$F6,$F0,$FF,$05,$00,$5C
