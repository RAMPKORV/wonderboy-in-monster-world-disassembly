; ROM range: 0x0A08E6-0x0A0B25
; Conservative continuation of the prior four-tuple band at 0x0A07C6-0x0A08E5.
; The same 0x18-byte cadence continues for 24 more records here, so keep the labels
; structural until a consuming loader or decoder proves stronger semantics.

Bank080000_FourTupleRecord_0A08E6:
	dc.b	$00,$FC,$03,$01,$A0,$F6
	dc.b	$EC,$09,$01,$74,$F4,$00
	dc.b	$09,$01,$6E,$F4,$F0,$FF
	dc.b	$05,$00,$5C,$00,$FC,$03

Bank080000_FourTupleRecord_0A08FE:
	dc.b	$01,$A0,$F7,$EC,$09,$01
	dc.b	$7A,$F4,$00,$09,$01,$6E
	dc.b	$F4,$F0,$FF,$09,$01,$80
	dc.b	$F4,$00,$09,$01,$21,$F4

Bank080000_FourTupleRecord_0A0916:
	dc.b	$F0,$FF,$09,$01,$86,$F4
	dc.b	$00,$09,$01,$27,$F4,$F0
	dc.b	$FF,$05,$09,$5B,$00,$00
	dc.b	$05,$01,$5B,$F0,$00,$09

Bank080000_FourTupleRecord_0A092E:
	dc.b	$01,$1B,$F4,$F0,$FF,$0B
	dc.b	$01,$8C,$F4,$EF,$FF,$05
	dc.b	$00,$5C,$00,$FC,$03,$01
	dc.b	$A0,$F4,$EC,$04,$01,$13

Bank080000_FourTupleRecord_0A0946:
	dc.b	$F7,$08,$08,$01,$06,$F4
	dc.b	$00,$09,$01,$00,$F4,$F0
	dc.b	$FF,$05,$08,$5C,$F0,$FC
	dc.b	$03,$09,$A0,$04,$EC,$08

Bank080000_FourTupleRecord_0A095E:
	dc.b	$09,$09,$F4,$08,$08,$09
	dc.b	$06,$F4,$00,$09,$09,$00
	dc.b	$F4,$F0,$0C,$11,$9B,$EB
	dc.b	$00,$FF,$08,$01,$98,$EB

Bank080000_FourTupleRecord_0A0976:
	dc.b	$00,$05,$09,$5B,$00,$00
	dc.b	$05,$01,$5B,$F0,$00,$09
	dc.b	$01,$1B,$F4,$F0,$08,$11
	dc.b	$98,$EB,$FF,$FF,$0A,$00

Bank080000_FourTupleRecord_0A098E:
	dc.b	$00,$F4,$F8,$FF,$01,$00
	dc.b	$0D,$FC,$00,$03,$00,$09
	dc.b	$FC,$E0,$FF,$08,$09,$98
	dc.b	$FA,$00,$0B,$01,$39,$F6

Bank080000_FourTupleRecord_0A09A6:
	dc.b	$F0,$FF,$05,$01,$DC,$F2
	dc.b	$E9,$02,$01,$C4,$F2,$F9
	dc.b	$08,$01,$09,$F4,$08,$08
	dc.b	$01,$06,$F4,$00,$09,$01

Bank080000_FourTupleRecord_0A09BE:
	dc.b	$00,$F4,$F0,$FF,$05,$01
	dc.b	$DC,$F2,$E9,$02,$01,$C4
	dc.b	$F2,$F9,$08,$01,$0C,$F4
	dc.b	$08,$08,$01,$06,$F4,$00

Bank080000_FourTupleRecord_0A09D6:
	dc.b	$09,$01,$00,$F4,$F0,$FF
	dc.b	$05,$01,$DC,$F2,$E9,$02
	dc.b	$01,$C4,$F2,$F9,$04,$01
	dc.b	$0F,$F7,$08,$08,$01,$06

Bank080000_FourTupleRecord_0A09EE:
	dc.b	$F4,$00,$09,$01,$00,$F4
	dc.b	$F0,$FF,$05,$01,$DC,$F2
	dc.b	$E9,$02,$01,$C4,$F2,$F9
	dc.b	$04,$01,$11,$F7,$08,$08

Bank080000_FourTupleRecord_0A0A06:
	dc.b	$01,$06,$F4,$00,$09,$01
	dc.b	$00,$F4,$F0,$FF,$05,$01
	dc.b	$DC,$F2,$E9,$02,$01,$C4
	dc.b	$F2,$F9,$09,$01,$15,$F4

Bank080000_FourTupleRecord_0A0A1E:
	dc.b	$00,$09,$01,$00,$F4,$F0
	dc.b	$FF,$04,$01,$DA,$06,$00
	dc.b	$08,$01,$D7,$F0,$00,$05
	dc.b	$01,$64,$F8,$00,$09,$01

Bank080000_FourTupleRecord_0A0A36:
	dc.b	$4B,$F4,$F0,$FF,$04,$01
	dc.b	$DA,$0E,$00,$08,$01,$D4
	dc.b	$F8,$FF,$09,$01,$68,$F3
	dc.b	$00,$09,$01,$4B,$F5,$F0

Bank080000_FourTupleRecord_0A0A4E:
	dc.b	$FF,$04,$01,$DA,$15,$00
	dc.b	$08,$01,$D1,$FF,$FF,$09
	dc.b	$01,$68,$F3,$00,$09,$01
	dc.b	$4B,$F5,$F0,$FF,$06,$09

Bank080000_FourTupleRecord_0A0A66:
	dc.b	$CB,$EB,$F3,$05,$09,$C7
	dc.b	$EB,$E3,$0B,$01,$2D,$F4
	dc.b	$F0,$FF,$04,$01,$DA,$0A
	dc.b	$01,$08,$01,$D4,$F4,$00

Bank080000_FourTupleRecord_0A0A7E:
	dc.b	$05,$01,$51,$EE,$F8,$06
	dc.b	$01,$55,$FE,$F0,$FF,$04
	dc.b	$01,$DA,$16,$00,$08,$01
	dc.b	$D1,$00,$FF,$05,$01,$51

Bank080000_FourTupleRecord_0A0A96:
	dc.b	$EE,$F8,$06,$01,$55,$FE
	dc.b	$F0,$FF,$05,$01,$C7,$F6
	dc.b	$E6,$06,$01,$CB,$F6,$F6
	dc.b	$09,$01,$74,$F4,$00,$09

Bank080000_FourTupleRecord_0A0AAE:
	dc.b	$01,$6E,$F4,$F0,$FF,$05
	dc.b	$01,$C7,$F7,$E6,$06,$01
	dc.b	$CB,$F7,$F6,$09,$01,$7A
	dc.b	$F4,$00,$09,$01,$6E,$F4

Bank080000_FourTupleRecord_0A0AC6:
	dc.b	$F0,$FF,$07,$01,$A4,$03
	dc.b	$FD,$05,$01,$A0,$03,$ED
	dc.b	$05,$01,$64,$F8,$00,$09
	dc.b	$01,$4B,$F4,$F0,$FF,$07

Bank080000_FourTupleRecord_0A0ADE:
	dc.b	$01,$B0,$03,$FD,$05,$01
	dc.b	$AC,$03,$ED,$05,$01,$64
	dc.b	$F8,$00,$09,$01,$4B,$F4
	dc.b	$F0,$FF,$07,$01,$BC,$03

Bank080000_FourTupleRecord_0A0AF6:
	dc.b	$FD,$05,$01,$B8,$03,$ED
	dc.b	$05,$01,$64,$F8,$00,$09
	dc.b	$01,$4B,$F4,$F0,$FF,$05
	dc.b	$01,$DC,$F2,$E9,$02,$01

Bank080000_FourTupleRecord_0A0B0E:
	dc.b	$C4,$F2,$F9,$04,$01,$13
	dc.b	$F7,$08,$08,$01,$06,$F4
	dc.b	$00,$09,$01,$00,$F4,$F0
	dc.b	$FF,$05,$09,$DC,$FE,$E9
