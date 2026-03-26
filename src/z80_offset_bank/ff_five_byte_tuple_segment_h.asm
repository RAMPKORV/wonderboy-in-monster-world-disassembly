; ROM range: 0x0A304B-0x0A34FF
; This run continues the same FF-terminated five-byte tuple family. Every record ends at
; a proven local $FF terminator, and every pre-terminator payload length remains a
; multiple of 5 bytes, so the source exposes each stable record start directly in ROM
; order while keeping the labels structural.

Bank080000_FFTerminatedFiveByteTupleRecord_0A304B:
	dc.b	$0E,$04,$0B,$F0,$F8
	dc.b	$09,$04,$17,$F8,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3056:
	dc.b	$0D,$04,$23,$F2,$00
	dc.b	$09,$04,$1D,$F2,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3061:
	dc.b	$0D,$04,$2B,$F0,$00
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3067:
	dc.b	$04,$02,$F6,$F9,$04
	dc.b	$09,$02,$F0,$F5,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3072:
	dc.b	$01,$02,$FE,$04,$F9
	dc.b	$06,$02,$F8,$F4,$F5
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A307D:
	dc.b	$05,$61,$80,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3083:
	dc.b	$0A,$61,$84,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3089:
	dc.b	$06,$61,$95,$00,$F8
	dc.b	$05,$61,$91,$F0,$00
	dc.b	$05,$61,$8D,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3099:
	dc.b	$0D,$61,$A0,$F4,$00
	dc.b	$05,$61,$9B,$EC,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A30A4:
	dc.b	$01,$61,$B0,$10,$00
	dc.b	$05,$61,$AC,$00,$00
	dc.b	$05,$61,$A8,$F0,$00
	dc.b	$05,$61,$8D,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A30B9:
	dc.b	$01,$61,$BA,$10,$00
	dc.b	$05,$61,$B6,$00,$00
	dc.b	$05,$61,$B2,$F0,$00
	dc.b	$05,$61,$9B,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A30CE:
	dc.b	$01,$60,$36,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A30D4:
	dc.b	$05,$60,$38,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A30DA:
	dc.b	$00,$60,$40,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A30E0:
	dc.b	$04,$60,$41,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A30E6:
	dc.b	$04,$60,$43,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A30EC:
	dc.b	$00,$60,$24,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A30F2:
	dc.b	$05,$07,$C8,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A30F8:
	dc.b	$05,$07,$CC,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A30FE:
	dc.b	$05,$20,$08,$F9,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3104:
	dc.b	$01,$20,$0C,$FD,$00
	dc.b	$05,$20,$08,$F9,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A310F:
	dc.b	$03,$20,$0C,$FD,$F8
	dc.b	$05,$20,$08,$F9,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A311A:
	dc.b	$01,$20,$0C,$FD,$10
	dc.b	$03,$20,$0C,$FD,$F0
	dc.b	$05,$20,$08,$F9,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A312A:
	dc.b	$04,$32,$62,$F8,$00
	dc.b	$04,$22,$62,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3135:
	dc.b	$05,$32,$64,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A313B:
	dc.b	$01,$3A,$60,$00,$F8
	dc.b	$01,$32,$60,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3146:
	dc.b	$05,$3A,$64,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A314C:
	dc.b	$04,$3A,$62,$F8,$00
	dc.b	$04,$2A,$62,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3157:
	dc.b	$05,$2A,$64,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A315D:
	dc.b	$01,$2A,$60,$00,$F8
	dc.b	$01,$22,$60,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3168:
	dc.b	$05,$22,$64,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A316E:
	dc.b	$00,$2A,$6B,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3174:
	dc.b	$00,$32,$69,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A317A:
	dc.b	$00,$32,$68,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3180:
	dc.b	$00,$32,$6A,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3186:
	dc.b	$00,$32,$6B,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A318C:
	dc.b	$00,$2A,$69,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3192:
	dc.b	$00,$2A,$68,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3198:
	dc.b	$00,$2A,$6A,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A319E:
	dc.b	$00,$24,$67,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31A4:
	dc.b	$00,$24,$68,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31AA:
	dc.b	$00,$24,$69,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31B0:
	dc.b	$09,$00,$09,$F4,$00
	dc.b	$0A,$00,$00,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31BB:
	dc.b	$00,$61,$33,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31C1:
	dc.b	$01,$60,$10,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31C7:
	dc.b	$02,$60,$10,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31CD:
	dc.b	$03,$60,$10,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31D3:
	dc.b	$00,$60,$10,$FC,$18
	dc.b	$03,$60,$10,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31DE:
	dc.b	$01,$60,$10,$FC,$18
	dc.b	$03,$60,$10,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31E9:
	dc.b	$02,$60,$10,$FC,$18
	dc.b	$03,$60,$10,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31F4:
	dc.b	$03,$60,$10,$FC,$18
	dc.b	$03,$60,$10,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A31FF:
	dc.b	$00,$60,$10,$FC,$38
	dc.b	$03,$60,$10,$FC,$18
	dc.b	$03,$60,$10,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A320F:
	dc.b	$01,$60,$10,$FC,$38
	dc.b	$03,$60,$10,$FC,$18
	dc.b	$03,$60,$10,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A321F:
	dc.b	$02,$60,$10,$FC,$38
	dc.b	$03,$60,$10,$FC,$18
	dc.b	$03,$60,$10,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A322F:
	dc.b	$03,$60,$10,$FC,$38
	dc.b	$03,$60,$10,$FC,$18
	dc.b	$03,$60,$10,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A323F:
	dc.b	$0D,$44,$0C,$F0,$08
	dc.b	$0E,$44,$00,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A324A:
	dc.b	$0D,$44,$0C,$F0,$08
	dc.b	$0E,$44,$14,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3255:
	dc.b	$0D,$44,$0C,$F0,$08
	dc.b	$0E,$44,$20,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3260:
	dc.b	$0D,$44,$0C,$F0,$08
	dc.b	$0E,$44,$2C,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A326B:
	dc.b	$0D,$44,$0C,$F0,$08
	dc.b	$0E,$44,$38,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3276:
	dc.b	$05,$44,$44,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A327C:
	dc.b	$00,$44,$48,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3282:
	dc.b	$00,$44,$49,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3288:
	dc.b	$00,$44,$4A,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A328E:
	dc.b	$00,$4C,$4B,$00,$FC
	dc.b	$00,$44,$4B,$F8,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3299:
	dc.b	$00,$4C,$4C,$00,$FC
	dc.b	$00,$44,$4C,$F8,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32A4:
	dc.b	$00,$44,$4D,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32AA:
	dc.b	$00,$44,$4E,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32B0:
	dc.b	$00,$44,$4F,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32B6:
	dc.b	$05,$02,$6C,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32BC:
	dc.b	$05,$12,$6C,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32C2:
	dc.b	$05,$1A,$6C,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32C8:
	dc.b	$01,$2C,$64,$00,$F8
	dc.b	$01,$24,$64,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32D3:
	dc.b	$01,$3C,$64,$00,$F8
	dc.b	$01,$34,$64,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32DE:
	dc.b	$00,$2C,$60,$00,$F8
	dc.b	$00,$24,$60,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32E9:
	dc.b	$00,$2C,$61,$00,$F8
	dc.b	$00,$24,$61,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32F4:
	dc.b	$00,$2C,$62,$00,$F8
	dc.b	$00,$24,$62,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A32FF:
	dc.b	$00,$2C,$63,$00,$F8
	dc.b	$00,$24,$63,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A330A:
	dc.b	$05,$23,$C0,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3310:
	dc.b	$05,$23,$C4,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3316:
	dc.b	$05,$3B,$D0,$00,$00
	dc.b	$05,$33,$D0,$F0,$00
	dc.b	$05,$2B,$D0,$00,$F0
	dc.b	$05,$23,$D0,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A332B:
	dc.b	$0D,$3B,$C8,$00,$00
	dc.b	$0D,$33,$C8,$E0,$00
	dc.b	$0D,$2B,$C8,$00,$F0
	dc.b	$0D,$23,$C8,$E0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3340:
	dc.b	$00,$3B,$D4,$00,$00
	dc.b	$00,$33,$D4,$F8,$00
	dc.b	$00,$2B,$D4,$00,$F8
	dc.b	$00,$23,$D4,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3355:
	dc.b	$04,$3B,$D5,$00,$00
	dc.b	$04,$33,$D5,$F0,$00
	dc.b	$04,$2B,$D5,$00,$F8
	dc.b	$04,$23,$D5,$F0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A336A:
	dc.b	$0C,$3B,$E0,$00,$00
	dc.b	$0C,$33,$E0,$E0,$00
	dc.b	$0C,$2B,$E0,$00,$F8
	dc.b	$0C,$23,$E0,$E0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A337F:
	dc.b	$04,$3B,$E4,$20,$00
	dc.b	$04,$33,$E4,$D0,$00
	dc.b	$04,$2B,$E4,$20,$F8
	dc.b	$04,$23,$E4,$D0,$F8
	dc.b	$0C,$3B,$E6,$00,$00
	dc.b	$0C,$33,$E6,$E0,$00
	dc.b	$0C,$2B,$E6,$00,$F8
	dc.b	$0C,$23,$E6,$E0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A33A8:
	dc.b	$0C,$3B,$F0,$20,$00
	dc.b	$0C,$33,$F0,$C0,$00
	dc.b	$0C,$2B,$F0,$20,$F8
	dc.b	$0C,$23,$F0,$C0,$F8
	dc.b	$0C,$3B,$F4,$00,$00
	dc.b	$0C,$33,$F4,$E0,$00
	dc.b	$0C,$2B,$F4,$00,$F8
	dc.b	$0C,$23,$F4,$E0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A33D1:
	dc.b	$0C,$3B,$F8,$20,$00
	dc.b	$0C,$33,$F8,$C0,$00
	dc.b	$0C,$2B,$F8,$20,$F8
	dc.b	$0C,$23,$F8,$C0,$F8
	dc.b	$0C,$3B,$FC,$00,$00
	dc.b	$0C,$33,$FC,$E0,$00
	dc.b	$0C,$2B,$FC,$00,$F8
	dc.b	$0C,$23,$FC,$E0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A33FA:
	dc.b	$08,$3B,$D7,$20,$00
	dc.b	$08,$33,$D7,$C8,$00
	dc.b	$08,$2B,$D7,$20,$F8
	dc.b	$08,$23,$D7,$C8,$F8
	dc.b	$0C,$3B,$DA,$00,$00
	dc.b	$0C,$33,$DA,$E0,$00
	dc.b	$0C,$2B,$DA,$00,$F8
	dc.b	$0C,$23,$DA,$E0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3423:
	dc.b	$00,$3B,$DE,$20,$00
	dc.b	$00,$33,$DE,$D8,$00
	dc.b	$00,$2B,$DE,$20,$F8
	dc.b	$00,$23,$DE,$D8,$F8
	dc.b	$0C,$3B,$BC,$00,$00
	dc.b	$0C,$33,$BC,$E0,$00
	dc.b	$0C,$2B,$BC,$00,$F8
	dc.b	$0C,$23,$BC,$E0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A344C:
	dc.b	$08,$3B,$EA,$00,$00
	dc.b	$08,$33,$EA,$E8,$00
	dc.b	$08,$2B,$EA,$00,$F8
	dc.b	$08,$23,$EA,$E8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3461:
	dc.b	$08,$3B,$ED,$00,$00
	dc.b	$08,$33,$ED,$E8,$00
	dc.b	$08,$2B,$ED,$00,$F8
	dc.b	$08,$23,$ED,$E8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3476:
	dc.b	$05,$1A,$70,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A347C:
	dc.b	$05,$1A,$74,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3482:
	dc.b	$05,$02,$70,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3488:
	dc.b	$05,$02,$74,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A348E:
	dc.b	$04,$00,$00,$F8,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3494:
	dc.b	$05,$00,$02,$F8,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A349A:
	dc.b	$05,$00,$06,$F8,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34A0:
	dc.b	$05,$00,$0A,$F8,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34A6:
	dc.b	$05,$00,$0E,$F8,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34AC:
	dc.b	$05,$00,$12,$F8,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34B2:
	dc.b	$05,$00,$16,$F8,$F6
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34B8:
	dc.b	$05,$00,$1A,$F8,$F6
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34BE:
	dc.b	$05,$00,$1E,$F8,$F6
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34C4:
	dc.b	$07,$00,$22,$F8,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34CA:
	dc.b	$07,$00,$2A,$F8,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34D0:
	dc.b	$07,$00,$32,$F8,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34D6:
	dc.b	$07,$00,$3A,$F8,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34DC:
	dc.b	$07,$00,$42,$F8,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34E2:
	dc.b	$07,$00,$4A,$F8,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34E8:
	dc.b	$0D,$40,$00,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34EE:
	dc.b	$0D,$40,$08,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34F4:
	dc.b	$0D,$40,$10,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A34FA:
	dc.b	$0D,$40,$18,$F0,$F0
	dc.b	$FF
