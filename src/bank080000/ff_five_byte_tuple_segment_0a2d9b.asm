; ROM range: 0x0A2D9B-0x0A303F
; This run continues the same FF-terminated five-byte tuple family. Every record ends at
; a proven local $FF terminator, and every pre-terminator payload length remains a
; multiple of 5 bytes, so the source exposes each stable record start directly in ROM
; order while keeping the labels structural.

Bank080000_FFTerminatedFiveByteTupleRecord_0A2D9B:
	dc.b	$00,$61,$18,$0C,$08
	dc.b	$0C,$61,$14,$EC,$08
	dc.b	$03,$61,$10,$0C,$E8
	dc.b	$0F,$61,$00,$EC,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2DB0:
	dc.b	$00,$61,$39,$0C,$08
	dc.b	$0C,$61,$35,$EC,$08
	dc.b	$0B,$61,$29,$04,$E8
	dc.b	$0F,$61,$19,$E4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2DC5:
	dc.b	$07,$61,$4A,$08,$F0
	dc.b	$0F,$61,$3A,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2DD0:
	dc.b	$0F,$61,$52,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2DD6:
	dc.b	$03,$61,$72,$0C,$F0
	dc.b	$0F,$61,$62,$EC,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2DE1:
	dc.b	$07,$61,$86,$08,$F0
	dc.b	$0F,$61,$76,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2DEC:
	dc.b	$07,$61,$9E,$08,$F0
	dc.b	$0F,$61,$8E,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2DF7:
	dc.b	$07,$61,$B6,$08,$F0
	dc.b	$0F,$61,$A6,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E02:
	dc.b	$03,$61,$CE,$0C,$F0
	dc.b	$0F,$61,$BE,$EC,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E0D:
	dc.b	$0F,$61,$D2,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E13:
	dc.b	$0D,$62,$10,$F0,$08
	dc.b	$0F,$62,$00,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E1E:
	dc.b	$0C,$62,$28,$F0,$0C
	dc.b	$0F,$62,$18,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E29:
	dc.b	$0F,$62,$2C,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E2F:
	dc.b	$05,$01,$E2,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E35:
	dc.b	$05,$01,$E6,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E3B:
	dc.b	$05,$19,$E2,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E41:
	dc.b	$05,$19,$E6,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E47:
	dc.b	$03,$60,$BB,$08,$F0
	dc.b	$0F,$60,$AB,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E52:
	dc.b	$09,$40,$10,$F2,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E58:
	dc.b	$01,$60,$78,$28,$30
	dc.b	$0A,$60,$6F,$18,$18
	dc.b	$0D,$60,$67,$F9,$18
	dc.b	$0A,$60,$5E,$18,$00
	dc.b	$0E,$60,$52,$F8,$00
	dc.b	$0E,$60,$46,$D8,$00
	dc.b	$0F,$60,$36,$F0,$E0
	dc.b	$0B,$60,$2A,$D8,$E0
	dc.b	$0B,$70,$20,$10,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E86:
	dc.b	$00,$40,$FC,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E8C:
	dc.b	$00,$58,$FC,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E92:
	dc.b	$05,$40,$FD,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E98:
	dc.b	$05,$58,$FD,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2E9E:
	dc.b	$09,$41,$01,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EA4:
	dc.b	$09,$41,$07,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EAA:
	dc.b	$0B,$40,$A0,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EB0:
	dc.b	$0B,$40,$AC,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EB6:
	dc.b	$0B,$40,$C4,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EBC:
	dc.b	$0B,$40,$B8,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EC2:
	dc.b	$0D,$60,$80,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EC8:
	dc.b	$0A,$60,$88,$F9,$F9
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2ECE:
	dc.b	$07,$61,$0E,$F9,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2ED4:
	dc.b	$0A,$68,$88,$EF,$F9
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EDA:
	dc.b	$0D,$68,$80,$E8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EE0:
	dc.b	$0A,$78,$88,$EF,$EF
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EE6:
	dc.b	$07,$71,$0E,$F9,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EEC:
	dc.b	$0A,$70,$88,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EF2:
	dc.b	$00,$60,$16,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2EF8:
	dc.b	$00,$68,$17,$00,$F8
	dc.b	$00,$78,$17,$00,$00
	dc.b	$00,$70,$17,$F8,$00
	dc.b	$00,$60,$17,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F0D:
	dc.b	$01,$60,$18,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F13:
	dc.b	$04,$60,$1A,$F8,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F19:
	dc.b	$05,$60,$1C,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F1F:
	dc.b	$07,$48,$91,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F25:
	dc.b	$05,$40,$99,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F2B:
	dc.b	$00,$60,$D0,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F31:
	dc.b	$05,$60,$D1,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F37:
	dc.b	$0A,$60,$D5,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F3D:
	dc.b	$0F,$60,$DE,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F43:
	dc.b	$05,$60,$F8,$00,$00
	dc.b	$05,$68,$F5,$00,$F0
	dc.b	$05,$68,$F1,$F0,$00
	dc.b	$05,$60,$EE,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F58:
	dc.b	$00,$41,$20,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F5E:
	dc.b	$00,$41,$21,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F64:
	dc.b	$05,$41,$22,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F6A:
	dc.b	$05,$41,$26,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F70:
	dc.b	$05,$41,$30,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F76:
	dc.b	$05,$41,$2A,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F7C:
	dc.b	$04,$41,$2E,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F82:
	dc.b	$09,$03,$09,$F3,$00
	dc.b	$0A,$03,$00,$F3,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F8D:
	dc.b	$0B,$03,$0F,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F93:
	dc.b	$01,$03,$1F,$FC,$08
	dc.b	$03,$03,$1B,$FC,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2F9E:
	dc.b	$07,$7B,$21,$EE,$E0
	dc.b	$07,$6B,$44,$EA,$00
	dc.b	$0F,$6B,$34,$FA,$00
	dc.b	$0B,$6B,$28,$FE,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2FB3:
	dc.b	$0E,$03,$4C,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2FB9:
	dc.b	$00,$64,$4F,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2FBF:
	dc.b	$04,$7C,$50,$F8,$00
	dc.b	$04,$64,$50,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2FCA:
	dc.b	$0A,$64,$52,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2FD0:
	dc.b	$0A,$64,$5B,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2FD6:
	dc.b	$0A,$64,$64,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2FDC:
	dc.b	$0A,$64,$6D,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2FE2:
	dc.b	$0D,$7C,$76,$F0,$00
	dc.b	$0D,$64,$76,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2FED:
	dc.b	$0D,$7C,$7E,$F0,$00
	dc.b	$0D,$64,$7E,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2FF8:
	dc.b	$0D,$7C,$86,$F0,$00
	dc.b	$0D,$64,$86,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3003:
	dc.b	$0D,$7C,$8E,$F0,$00
	dc.b	$0D,$64,$8E,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A300E:
	dc.b	$09,$03,$C9,$F3,$00
	dc.b	$0A,$03,$C0,$F3,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3019:
	dc.b	$0B,$03,$CF,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A301F:
	dc.b	$01,$03,$DF,$FC,$08
	dc.b	$03,$03,$DB,$FC,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A302A:
	dc.b	$0E,$03,$E7,$F0,$F8
	dc.b	$09,$03,$E1,$F8,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A3035:
	dc.b	$0E,$03,$F3,$F0,$F8
	dc.b	$09,$03,$E1,$F8,$E8
	dc.b	$FF
