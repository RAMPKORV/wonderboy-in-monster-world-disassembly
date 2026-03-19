; ROM range: 0x0A1D4F-0x0A23F5
; This run continues the same FF-terminated five-byte tuple family. Every record ends at
; a proven local $FF terminator, and every pre-terminator payload length remains a
; multiple of 5 bytes, so the source exposes each stable record start directly in ROM
; order while keeping the labels structural.

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D4F:
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D50:
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D51:
	dc.b	$00,$02,$55,$00,$00,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D57:
	dc.b	$05,$04,$04,$F8,$F8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D5D:
	dc.b	$00,$04,$0D,$FC,$10,$01,$04,$08,$FC,$00,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D68:
	dc.b	$00,$04,$0D,$FC,$10,$02,$04,$08,$FC,$F8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D73:
	dc.b	$00,$04,$0D,$FC,$10,$03,$04,$08,$FC,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D7E:
	dc.b	$01,$04,$0C,$FC,$08,$03,$04,$08,$FC,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D89:
	dc.b	$05,$42,$F0,$F8,$20,$05,$42,$F0,$F8,$F0,$05,$42,$F4,$F8,$30,$05
	dc.b	$42,$F4,$F8,$D0,$05,$42,$F8,$F8,$00,$05,$42,$F8,$F8,$E0,$05,$42
	dc.b	$FC,$F8,$10,$05,$42,$FC,$F8,$C0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1DB2:
	dc.b	$05,$42,$FC,$F8,$20,$05,$42,$FC,$F8,$F0,$05,$42,$F8,$F8,$30,$05
	dc.b	$42,$F8,$F8,$D0,$05,$42,$F4,$F8,$00,$05,$42,$F4,$F8,$E0,$05,$42
	dc.b	$F0,$F8,$10,$05,$42,$F0,$F8,$C0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1DDB:
	dc.b	$05,$42,$F8,$F8,$20,$05,$42,$F8,$F8,$F0,$05,$42,$FC,$F8,$30,$05
	dc.b	$42,$FC,$F8,$D0,$05,$42,$F0,$F8,$00,$05,$42,$F0,$F8,$E0,$05,$42
	dc.b	$F4,$F8,$10,$05,$42,$F4,$F8,$C0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E04:
	dc.b	$06,$28,$6F,$00,$E8,$06,$20,$6F,$F1,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E0F:
	dc.b	$05,$28,$77,$00,$E8,$05,$20,$77,$F1,$E8,$06,$28,$6F,$00,$E8,$06
	dc.b	$20,$6F,$F1,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E24:
	dc.b	$08,$20,$88,$F4,$08,$0A,$20,$7F,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E2F:
	dc.b	$05,$20,$7B,$FC,$F0,$08,$20,$88,$F4,$08,$0A,$20,$7F,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E3F:
	dc.b	$08,$20,$8B,$F4,$08,$0A,$20,$7F,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E4A:
	dc.b	$08,$20,$8E,$F4,$08,$0A,$20,$7F,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E55:
	dc.b	$08,$20,$91,$F4,$08,$0A,$20,$7F,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E60:
	dc.b	$06,$28,$25,$00,$E8,$06,$20,$25,$F1,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E6B:
	dc.b	$05,$28,$2D,$00,$E8,$05,$20,$2D,$F1,$E8,$06,$28,$25,$00,$E8,$06
	dc.b	$20,$25,$F1,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E80:
	dc.b	$08,$20,$3E,$F4,$08,$0A,$20,$35,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E8B:
	dc.b	$05,$20,$31,$FC,$F0,$08,$20,$3E,$F4,$08,$0A,$20,$35,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1E9B:
	dc.b	$08,$20,$41,$F4,$08,$0A,$20,$35,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1EA6:
	dc.b	$08,$20,$44,$F4,$08,$0A,$20,$35,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1EB1:
	dc.b	$08,$20,$47,$F4,$08,$0A,$20,$35,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1EBC:
	dc.b	$04,$28,$2B,$00,$08,$04,$20,$2B,$F1,$08,$06,$28,$25,$00,$F0,$06
	dc.b	$20,$25,$F1,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1ED1:
	dc.b	$06,$28,$4A,$00,$E8,$06,$20,$4A,$F1,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1EDC:
	dc.b	$01,$28,$54,$00,$E8,$01,$20,$54,$F9,$E8,$06,$28,$4A,$00,$E8,$06
	dc.b	$20,$4A,$F1,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1EF1:
	dc.b	$08,$20,$63,$F4,$08,$0A,$20,$5A,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1EFC:
	dc.b	$05,$20,$56,$FC,$F0,$08,$20,$63,$F4,$08,$0A,$20,$5A,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F0C:
	dc.b	$08,$20,$66,$F4,$08,$0A,$20,$5A,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F17:
	dc.b	$08,$20,$69,$F4,$08,$0A,$20,$5A,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F22:
	dc.b	$08,$20,$6C,$F4,$08,$0A,$20,$5A,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F2D:
	dc.b	$04,$28,$50,$00,$08,$04,$20,$50,$F1,$08,$06,$28,$4A,$00,$F0,$06
	dc.b	$20,$4A,$F1,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F42:
	dc.b	$06,$28,$00,$00,$E8,$06,$20,$00,$F1,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F4D:
	dc.b	$05,$28,$08,$00,$E8,$05,$20,$08,$F1,$E8,$06,$28,$00,$00,$E8,$06
	dc.b	$20,$00,$F1,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F62:
	dc.b	$08,$20,$19,$F4,$08,$0A,$20,$10,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F6D:
	dc.b	$05,$20,$0C,$FC,$F0,$08,$20,$19,$F4,$08,$0A,$20,$10,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F7D:
	dc.b	$08,$20,$1C,$F4,$08,$0A,$20,$10,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F88:
	dc.b	$08,$20,$1F,$F4,$08,$0A,$20,$10,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F93:
	dc.b	$08,$20,$22,$F4,$08,$0A,$20,$10,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1F9E:
	dc.b	$04,$28,$06,$00,$08,$04,$20,$06,$F1,$08,$06,$28,$00,$00,$F0,$06
	dc.b	$20,$00,$F1,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1FB3:
	dc.b	$0F,$60,$60,$E0,$00,$0F,$60,$70,$00,$00,$0F,$60,$50,$00,$E0,$0F
	dc.b	$60,$40,$E0,$E0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1FC8:
	dc.b	$0F,$61,$30,$00,$00,$0F,$61,$20,$E0,$00,$0F,$61,$10,$00,$E0,$0F
	dc.b	$61,$00,$E0,$E0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1FDD:
	dc.b	$0E,$60,$3C,$00,$08,$0F,$60,$2C,$E0,$08,$0F,$60,$1C,$00,$E8,$0F
	dc.b	$60,$0C,$E0,$E8,$05,$60,$06,$00,$D8,$0D,$60,$00,$E8,$D8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1FFC:
	dc.b	$0B,$60,$9E,$00,$08,$0F,$60,$8E,$E0,$08,$0B,$60,$82,$00,$E8,$0F
	dc.b	$60,$72,$E0,$E8,$01,$60,$70,$08,$D8,$0D,$60,$68,$E8,$D8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A201B:
	dc.b	$0F,$61,$4A,$00,$08,$0F,$61,$3A,$E0,$08,$0F,$60,$1C,$00,$E8,$0F
	dc.b	$60,$0C,$E0,$E8,$05,$60,$06,$00,$D8,$0D,$60,$00,$E8,$D8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A203A:
	dc.b	$09,$60,$EA,$04,$18,$0D,$60,$E2,$E4,$18,$0F,$60,$D2,$FC,$F8,$0F
	dc.b	$60,$C2,$DC,$F8,$07,$60,$BA,$04,$D8,$0F,$60,$AA,$E4,$D8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2059:
	dc.b	$01,$61,$38,$20,$10,$0E,$61,$2C,$00,$10,$0E,$61,$20,$E0,$10,$0F
	dc.b	$61,$10,$00,$F0,$0F,$61,$00,$E1,$F0,$02,$60,$FC,$18,$D8,$0E,$60
	dc.b	$F0,$F8,$D8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A207D:
	dc.b	$0F,$61,$A0,$00,$08,$0F,$61,$90,$E0,$08,$0D,$61,$88,$00,$F8,$0D
	dc.b	$61,$80,$E0,$F8,$0F,$61,$70,$00,$D8,$0F,$61,$60,$E0,$D8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A209C:
	dc.b	$0D,$20,$08,$F0,$00,$0D,$20,$00,$F0,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20A7:
	dc.b	$0D,$20,$10,$F0,$00,$0D,$20,$00,$F0,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20B2:
	dc.b	$0F,$20,$18,$F0,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20B8:
	dc.b	$0D,$20,$40,$F0,$00,$0D,$20,$00,$F0,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20C3:
	dc.b	$0F,$20,$28,$F0,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20C9:
	dc.b	$0D,$20,$38,$F0,$00,$0D,$20,$00,$F0,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20D4:
	dc.b	$0F,$20,$48,$F0,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20DA:
	dc.b	$0F,$20,$58,$F0,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20E0:
	dc.b	$0F,$20,$68,$F0,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20E6:
	dc.b	$0F,$60,$48,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20EC:
	dc.b	$0B,$60,$58,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20F2:
	dc.b	$0B,$60,$64,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A20F8:
	dc.b	$0C,$60,$3C,$00,$18,$0C,$60,$38,$E0,$18,$0F,$60,$28,$00,$F8,$0F
	dc.b	$60,$18,$E0,$F8,$0E,$60,$0C,$00,$E0,$0E,$60,$00,$E0,$E0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2117:
	dc.b	$0C,$60,$64,$00,$18,$0C,$60,$60,$E0,$18,$0F,$60,$50,$00,$F8,$0F
	dc.b	$60,$40,$E0,$F8,$0E,$60,$0C,$00,$E0,$0E,$60,$00,$E0,$E0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2136:
	dc.b	$0C,$60,$8C,$00,$18,$0C,$60,$88,$E0,$18,$0F,$60,$78,$00,$F8,$0F
	dc.b	$60,$68,$E0,$F8,$0E,$60,$0C,$00,$E0,$0E,$60,$00,$E0,$E0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2155:
	dc.b	$0F,$60,$C0,$00,$00,$0F,$60,$B0,$E0,$00,$0F,$60,$A0,$00,$E0,$0F
	dc.b	$60,$90,$E0,$E0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A216A:
	dc.b	$0F,$61,$00,$00,$00,$0F,$60,$F0,$E0,$00,$0F,$60,$E0,$00,$E0,$0F
	dc.b	$60,$D0,$E0,$E0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A217F:
	dc.b	$0F,$61,$40,$00,$00,$0F,$61,$30,$E0,$00,$0F,$61,$20,$00,$E0,$0F
	dc.b	$61,$10,$E0,$E0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2194:
	dc.b	$0C,$61,$94,$00,$18,$0C,$61,$90,$E0,$18,$0F,$61,$80,$00,$F8,$0F
	dc.b	$61,$70,$E0,$F8,$0F,$61,$60,$00,$D8,$0F,$61,$50,$E0,$D8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A21B3:
	dc.b	$0A,$60,$70,$F4,$F4,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A21B9:
	dc.b	$0A,$70,$70,$F4,$F4,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A21BF:
	dc.b	$0A,$00,$15,$F4,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A21C5:
	dc.b	$0A,$00,$20,$F4,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A21CB:
	dc.b	$09,$00,$45,$F4,$00,$0A,$00,$38,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A21D6:
	dc.b	$09,$00,$4B,$F4,$00,$0A,$00,$38,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A21E1:
	dc.b	$09,$00,$51,$F4,$00,$0A,$00,$38,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A21EC:
	dc.b	$04,$00,$41,$FC,$F8,$09,$00,$4B,$F4,$00,$0A,$00,$38,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A21FC:
	dc.b	$0A,$08,$69,$F4,$F8,$0A,$00,$60,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2207:
	dc.b	$0D,$02,$E8,$F0,$F8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A220D:
	dc.b	$00,$00,$0D,$FC,$F9,$02,$00,$1B,$F0,$F8,$05,$00,$17,$EC,$E8,$09
	dc.b	$00,$06,$F4,$00,$09,$00,$00,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2227:
	dc.b	$00,$00,$0E,$FC,$F9,$02,$00,$1B,$F0,$F8,$05,$00,$17,$EC,$E8,$09
	dc.b	$00,$06,$F4,$00,$09,$00,$00,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2241:
	dc.b	$09,$00,$06,$F6,$00,$09,$00,$00,$F6,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A224C:
	dc.b	$04,$00,$1E,$F6,$F8,$09,$00,$06,$F6,$00,$09,$00,$00,$F6,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A225C:
	dc.b	$09,$00,$0C,$F6,$00,$09,$00,$00,$F6,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2267:
	dc.b	$09,$00,$12,$F6,$00,$09,$00,$00,$F6,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2272:
	dc.b	$09,$00,$18,$F6,$00,$09,$00,$00,$F6,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A227D:
	dc.b	$06,$00,$16,$08,$04,$05,$00,$12,$08,$F4,$04,$00,$10,$F0,$E4,$0F
	dc.b	$00,$00,$E8,$EC,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2292:
	dc.b	$01,$08,$74,$FC,$F0,$01,$00,$74,$FC,$00,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A229D:
	dc.b	$01,$00,$74,$FC,$F0,$01,$08,$74,$FC,$00,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A22A8:
	dc.b	$09,$00,$4F,$F4,$00,$09,$00,$49,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A22B3:
	dc.b	$09,$00,$55,$F4,$00,$09,$00,$49,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A22BE:
	dc.b	$09,$00,$5B,$F4,$00,$09,$00,$49,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A22C9:
	dc.b	$04,$00,$61,$FC,$F8,$09,$00,$55,$F4,$00,$09,$00,$49,$F4,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A22D9:
	dc.b	$01,$08,$9E,$00,$00,$01,$00,$9E,$F8,$00,$05,$08,$9A,$00,$F0,$05
	dc.b	$00,$9A,$F0,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A22EE:
	dc.b	$0A,$00,$0C,$F4,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A22F4:
	dc.b	$04,$00,$15,$F8,$F0,$0A,$00,$0C,$F4,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A22FF:
	dc.b	$05,$22,$56,$F8,$F8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2305:
	dc.b	$05,$04,$34,$F8,$F8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A230B:
	dc.b	$00,$04,$2D,$FC,$10,$01,$04,$28,$FC,$00,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2316:
	dc.b	$00,$04,$2D,$FC,$10,$02,$04,$28,$FC,$F8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2321:
	dc.b	$00,$04,$2D,$FC,$10,$03,$04,$28,$FC,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A232C:
	dc.b	$01,$04,$2C,$FC,$08,$03,$04,$08,$FC,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2337:
	dc.b	$0F,$60,$38,$00,$00,$0F,$60,$28,$E0,$00,$0F,$60,$18,$00,$E0,$0F
	dc.b	$60,$08,$E0,$E0,$0C,$60,$04,$00,$D8,$0C,$60,$00,$E0,$D8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2356:
	dc.b	$0C,$68,$72,$00,$10,$0C,$60,$72,$E0,$10,$04,$60,$58,$F0,$F7,$0F
	dc.b	$68,$48,$E0,$F0,$0F,$60,$48,$00,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2370:
	dc.b	$0D,$68,$66,$CA,$F0,$0D,$60,$66,$18,$F0,$0E,$68,$5A,$DA,$00,$0E
	dc.b	$60,$5A,$08,$00,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2385:
	dc.b	$03,$60,$6E,$FC,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A238B:
	dc.b	$05,$04,$34,$F8,$F8,$00,$04,$2D,$FC,$10,$01,$04,$28,$FC,$00,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A239B:
	dc.b	$05,$04,$34,$F8,$F8,$00,$04,$2D,$FC,$18,$02,$04,$28,$FC,$00,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A23AB:
	dc.b	$05,$04,$34,$F8,$F8,$00,$04,$2D,$FC,$20,$03,$04,$28,$FC,$00,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A23BB:
	dc.b	$05,$04,$34,$F8,$F8,$01,$04,$2C,$FC,$20,$03,$04,$28,$FC,$00,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A23CB:
	dc.b	$09,$60,$06,$00,$F8,$09,$60,$00,$E8,$F8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A23D6:
	dc.b	$09,$60,$12,$00,$F8,$09,$60,$0C,$E8,$F8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A23E1:
	dc.b	$04,$40,$24,$07,$FE,$04,$40,$24,$F0,$FE,$09,$68,$1E,$00,$F8,$09
	dc.b	$60,$1E,$E8,$F8,$FF
