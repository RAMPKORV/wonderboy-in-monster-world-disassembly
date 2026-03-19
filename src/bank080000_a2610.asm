; ROM range: 0x0A2610-0x0A2764
; This run continues the same FF-terminated five-byte tuple family. Every record ends at
; a proven local $FF terminator, and every pre-terminator payload length remains a
; multiple of 5 bytes, so the source exposes each stable record start directly in ROM
; order while keeping the labels structural. This front subsection is now explicit through
; 0x0A275F, making the short paired rows, mirrored 0x08/0x28 variants, and the late
; 0x60/0x61-page clusters directly auditable in source before the larger neighboring run.

Bank080000_FFTerminatedFiveByteTupleRecord_0A2610:
	dc.b	$00,$43,$9C,$F2,$09
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2616:
	dc.b	$00,$40,$C4,$FE,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A261C:
	dc.b	$06,$08,$50,$00,$E8
	dc.b	$06,$00,$50,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2627:
	dc.b	$00,$08,$56,$00,$F4
	dc.b	$00,$00,$56,$F8,$F4
	dc.b	$06,$08,$50,$00,$E8
	dc.b	$06,$00,$50,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A263C:
	dc.b	$00,$08,$57,$00,$F4
	dc.b	$00,$00,$57,$F8,$F4
	dc.b	$06,$08,$50,$00,$E8
	dc.b	$06,$00,$50,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2651:
	dc.b	$09,$08,$3E,$F4,$00
	dc.b	$09,$08,$36,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A265C:
	dc.b	$09,$08,$44,$F4,$00
	dc.b	$09,$08,$36,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2667:
	dc.b	$04,$08,$3C,$F8,$F8
	dc.b	$09,$08,$44,$F4,$00
	dc.b	$09,$08,$36,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2677:
	dc.b	$09,$08,$4A,$F4,$00
	dc.b	$09,$08,$36,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2682:
	dc.b	$01,$08,$86,$00,$00
	dc.b	$01,$00,$86,$F8,$00
	dc.b	$09,$00,$80,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2692:
	dc.b	$0A,$00,$12,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2698:
	dc.b	$0A,$00,$1B,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A269E:
	dc.b	$06,$08,$0B,$00,$E8
	dc.b	$06,$00,$0B,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A26A9:
	dc.b	$00,$08,$11,$00,$F0
	dc.b	$00,$00,$11,$F8,$F0
	dc.b	$06,$08,$0B,$00,$E8
	dc.b	$06,$00,$0B,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A26BE:
	dc.b	$08,$00,$88,$F4,$08
	dc.b	$0A,$00,$00,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A26C9:
	dc.b	$09,$08,$2A,$F4,$00
	dc.b	$09,$08,$24,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A26D4:
	dc.b	$04,$08,$58,$FC,$FC
	dc.b	$09,$08,$2A,$F4,$00
	dc.b	$09,$08,$24,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A26E4:
	dc.b	$09,$08,$30,$F4,$00
	dc.b	$09,$08,$24,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A26EF:
	dc.b	$09,$28,$2A,$F4,$00
	dc.b	$09,$28,$24,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A26FA:
	dc.b	$04,$28,$58,$FC,$FC
	dc.b	$09,$28,$2A,$F4,$00
	dc.b	$09,$28,$24,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A270A:
	dc.b	$09,$28,$30,$F4,$00
	dc.b	$09,$28,$24,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2715:
	dc.b	$06,$08,$17,$00,$E8
	dc.b	$06,$00,$17,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2720:
	dc.b	$04,$00,$1D,$F8,$F0
	dc.b	$06,$08,$17,$00,$E8
	dc.b	$06,$00,$17,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2730:
	dc.b	$0E,$60,$EC,$00,$00
	dc.b	$0E,$60,$E0,$E0,$00
	dc.b	$0F,$60,$D0,$00,$E0
	dc.b	$0F,$60,$C0,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2745:
	dc.b	$0E,$61,$1B,$00,$08
	dc.b	$0E,$61,$0F,$E0,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2750:
	dc.b	$08,$61,$05,$08,$00
	dc.b	$08,$61,$02,$08,$F8
	dc.b	$0C,$60,$F8,$E8,$00
	dc.b	$0C,$60,$F8,$E8,$F8
	dc.b	$FF
