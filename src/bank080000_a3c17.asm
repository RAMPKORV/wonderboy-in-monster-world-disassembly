; ROM range: 0x0A3C17-0x0A43D4
; Continuation of the compact local-offset/control pocket inside the 0x0A3500+
; table-targeted payload family. These records stay structural: most use the same
; FC/FB/FE prefix bytes, short local-offset lists, and FF/FD terminators already
; proven nearby.

Bank080000_TableTargetedPayloadRecord_0A3C17:
	dc.b	$FC,$10,$14,$FB,$0E,$12,$00,$15,$45

Bank080000_TableTargetedPayloadRecord_0A3C20:
	dc.b	$08,$15,$65,$08,$15,$70,$FF

Bank080000_TableTargetedPayloadRecord_0A3C27:
	dc.b	$00,$15,$65

Bank080000_TableTargetedPayloadRecord_0A3C2A:
	dc.b	$00,$15,$45

Bank080000_TableTargetedPayloadRecord_0A3C2D:
	dc.b	$08,$15,$24,$08,$15,$2F,$08,$15,$3A,$FF

Bank080000_TableTargetedPayloadRecord_0A3C37:
	dc.b	$00,$15,$24

Bank080000_TableTargetedPayloadRecord_0A3C3A:
	dc.b	$06,$15,$55,$FD

Bank080000_TableTargetedPayloadRecord_0A3C3E:
	dc.b	$FC,$08,$08,$FB,$06,$06,$00,$15,$7B

Bank080000_TableTargetedPayloadRecord_0A3C47:
	dc.b	$08,$15,$87,$08,$15,$8D,$FF

Bank080000_TableTargetedPayloadRecord_0A3C4E:
	dc.b	$00,$15,$8D

Bank080000_TableTargetedPayloadRecord_0A3C51:
	dc.b	$00,$15,$7B

Bank080000_TableTargetedPayloadRecord_0A3C54:
	dc.b	$08,$15,$7B,$08,$15,$81,$FF

Bank080000_TableTargetedPayloadRecord_0A3C5B:
	dc.b	$FC,$0C,$0C,$FB,$0A,$0A,$00,$0F,$F1

Bank080000_TableTargetedPayloadRecord_0A3C64:
	dc.b	$08,$0F,$C1,$08,$0F,$EB,$FF

Bank080000_TableTargetedPayloadRecord_0A3C6B:
	dc.b	$00,$0F,$C1

Bank080000_TableTargetedPayloadRecord_0A3C6E:
	dc.b	$00,$0F,$F1

Bank080000_TableTargetedPayloadRecord_0A3C71:
	dc.b	$FC,$10,$14,$FB,$0E,$12,$00,$15,$B4

Bank080000_TableTargetedPayloadRecord_0A3C7A:
	dc.b	$08,$15,$EA,$08,$15,$DF,$FF

Bank080000_TableTargetedPayloadRecord_0A3C81:
	dc.b	$00,$15,$DF

Bank080000_TableTargetedPayloadRecord_0A3C84:
	dc.b	$00,$15,$B4

Bank080000_TableTargetedPayloadRecord_0A3C87:
	dc.b	$08,$15,$93,$08,$15,$9E,$08,$15,$A9,$FF

Bank080000_TableTargetedPayloadRecord_0A3C91:
	dc.b	$00,$15,$93

Bank080000_TableTargetedPayloadRecord_0A3C94:
	dc.b	$04,$15,$BF,$06,$15,$CF,$FD

Bank080000_TableTargetedPayloadRecord_0A3C9B:
	dc.b	$06,$15,$BF,$06,$15,$CF,$FF

Bank080000_TableTargetedPayloadRecord_0A3CA2:
	dc.b	$FC,$10,$0C,$FB,$0E,$0A,$04,$16,$13,$04,$16,$19,$04,$16,$13,$04
	dc.b	$16,$19,$08,$16,$1F,$08,$16,$25,$08,$15,$FB,$FD

Bank080000_TableTargetedPayloadRecord_0A3CBE:
	dc.b	$08,$16,$07,$08,$16,$0D,$FF

Bank080000_TableTargetedPayloadRecord_0A3CC5:
	dc.b	$00,$16,$07

Bank080000_TableTargetedPayloadRecord_0A3CC8:
	dc.b	$00,$15,$F5

Bank080000_TableTargetedPayloadRecord_0A3CCB:
	dc.b	$08,$15,$FB,$08,$16,$01,$FF

Bank080000_TableTargetedPayloadRecord_0A3CD2:
	dc.b	$02,$15,$FB,$02,$16,$01,$02,$15,$FB,$02,$16,$01,$F8,$02,$16,$01
	dc.b	$FD

Bank080000_TableTargetedPayloadRecord_0A3CE3:
	dc.b	$04,$0F,$C1,$04,$0F,$EB,$04,$0F,$F1,$04,$0F,$EB,$FF

Bank080000_TableTargetedPayloadRecord_0A3CF0:
	dc.b	$04,$0F,$AF,$04,$0F,$B5,$04,$0F,$BB,$04,$0F,$B5,$FF

Bank080000_TableTargetedPayloadRecord_0A3CFD:
	dc.b	$FC,$0C,$10,$FB,$0A,$0E,$00,$0F,$FD

Bank080000_TableTargetedPayloadRecord_0A3D06:
	dc.b	$08,$16,$31,$08,$16,$37,$FF

Bank080000_TableTargetedPayloadRecord_0A3D0D:
	dc.b	$00,$0F,$FD

Bank080000_TableTargetedPayloadRecord_0A3D10:
	dc.b	$08,$0F,$F7,$08,$0F,$FD,$08,$10,$03,$FF

Bank080000_TableTargetedPayloadRecord_0A3D1A:
	dc.b	$00,$10,$03

Bank080000_TableTargetedPayloadRecord_0A3D1D:
	dc.b	$06,$10,$09,$04,$16,$2B,$02,$10,$09,$FD

Bank080000_TableTargetedPayloadRecord_0A3D27:
	dc.b	$08,$16,$3D,$08,$16,$43,$FF

Bank080000_TableTargetedPayloadRecord_0A3D2E:
	dc.b	$FC,$10,$10,$FB,$0E,$0E,$FE,$06,$16,$49,$06,$16,$4F,$06,$16,$55
	dc.b	$06,$16,$5B,$FF

Bank080000_TableTargetedPayloadRecord_0A3D42:
	dc.b	$FC,$08,$08,$FB,$06,$06,$FE,$08,$15,$7B,$08,$15,$81,$08,$15,$87
	dc.b	$08,$15,$8D,$FF

Bank080000_TableTargetedPayloadRecord_0A3D56:
	dc.b	$06,$15,$87,$06,$15,$8D,$FF

Bank080000_TableTargetedPayloadRecord_0A3D5D:
	dc.b	$00,$15,$87

Bank080000_TableTargetedPayloadRecord_0A3D60:
	dc.b	$08,$15,$7B,$08,$15,$81,$FF

Bank080000_TableTargetedPayloadRecord_0A3D67:
	dc.b	$FC,$0C,$10,$FB,$0A,$0E,$00,$16,$7F

Bank080000_TableTargetedPayloadRecord_0A3D70:
	dc.b	$08,$16,$73,$08,$16,$79,$FF

Bank080000_TableTargetedPayloadRecord_0A3D77:
	dc.b	$00,$16,$73

Bank080000_TableTargetedPayloadRecord_0A3D7A:
	dc.b	$00,$16,$7F

Bank080000_TableTargetedPayloadRecord_0A3D7D:
	dc.b	$08,$16,$61,$08,$16,$67,$08,$16,$6D,$FF

Bank080000_TableTargetedPayloadRecord_0A3D87:
	dc.b	$00,$16,$61

Bank080000_TableTargetedPayloadRecord_0A3D8A:
	dc.b	$00,$16,$73,$00,$16,$79

Bank080000_TableTargetedPayloadRecord_0A3D90:
	dc.b	$FC,$0C,$10,$FB,$0A,$0E,$00,$0F,$F7

Bank080000_TableTargetedPayloadRecord_0A3D99:
	dc.b	$0F,$10,$09,$0F,$10,$0F,$06,$16,$85,$06,$16,$8B,$06,$16,$91,$06
	dc.b	$16,$97,$FD

Bank080000_TableTargetedPayloadRecord_0A3DAC:
	dc.b	$00,$0F,$F7

Bank080000_TableTargetedPayloadRecord_0A3DAF:
	dc.b	$04,$0F,$F7,$04,$0F,$FD,$04,$10,$03,$04,$0F,$FD,$FF

Bank080000_TableTargetedPayloadRecord_0A3DBC:
	dc.b	$FC,$10,$10,$FB,$0E,$0E,$00,$16,$31

Bank080000_TableTargetedPayloadRecord_0A3DC5:
	dc.b	$08,$16,$5B,$08,$16,$31,$FF

Bank080000_TableTargetedPayloadRecord_0A3DCC:
	dc.b	$00,$16,$5B

Bank080000_TableTargetedPayloadRecord_0A3DCF:
	dc.b	$00,$16,$49

Bank080000_TableTargetedPayloadRecord_0A3DD2:
	dc.b	$08,$16,$31,$04,$16,$5B,$FD

Bank080000_TableTargetedPayloadRecord_0A3DD9:
	dc.b	$06,$16,$49,$06,$16,$4F,$06,$16,$55,$FF

Bank080000_TableTargetedPayloadRecord_0A3DE3:
	dc.b	$FC,$20,$20,$FB,$1E,$1E,$FE,$04,$16,$9D,$04,$16,$B2,$04,$16,$C7
	dc.b	$04,$16,$DC,$FF

Bank080000_TableTargetedPayloadRecord_0A3DF7:
	dc.b	$06,$0F,$BB,$06,$0F,$C1,$FF

Bank080000_TableTargetedPayloadRecord_0A3DFE:
	dc.b	$08,$0F,$AF,$08,$0F,$B5,$FF

Bank080000_TableTargetedPayloadRecord_0A3E05:
	dc.b	$FC,$0C,$0C,$FB,$0A,$0A,$00,$16,$F7

Bank080000_TableTargetedPayloadRecord_0A3E0E:
	dc.b	$08,$0F,$F1,$08,$16,$F1,$FF

Bank080000_TableTargetedPayloadRecord_0A3E15:
	dc.b	$00,$16,$F7

Bank080000_TableTargetedPayloadRecord_0A3E18:
	dc.b	$00,$0F,$C1,$00,$0F,$EB

Bank080000_TableTargetedPayloadRecord_0A3E1E:
	dc.b	$04,$16,$F7,$F8,$04,$16,$F7,$FD

Bank080000_TableTargetedPayloadRecord_0A3E26:
	dc.b	$FC,$0C,$0C,$FB,$0A,$0A,$00,$0F,$D3

Bank080000_TableTargetedPayloadRecord_0A3E2F:
	dc.b	$06,$17,$03,$06,$0F,$CD,$FF

Bank080000_TableTargetedPayloadRecord_0A3E36:
	dc.b	$00,$0F,$CD

Bank080000_TableTargetedPayloadRecord_0A3E39:
	dc.b	$08,$0F,$B5,$04,$16,$FD,$FD

Bank080000_TableTargetedPayloadRecord_0A3E40:
	dc.b	$FC,$0C,$10,$FB,$0A,$0E,$00,$17,$09

Bank080000_TableTargetedPayloadRecord_0A3E49:
	dc.b	$FC,$0C,$0C,$FB,$0A,$0A,$FE,$06,$17,$0F,$06,$17,$15,$06,$17,$1B
	dc.b	$06,$17,$21,$FF

Bank080000_TableTargetedPayloadRecord_0A3E5D:
	dc.b	$FC,$08,$08,$FB,$06,$06,$00,$17,$27

Bank080000_TableTargetedPayloadRecord_0A3E66:
	dc.b	$FC,$04,$10,$FB,$02,$0E,$00,$17,$2D

Bank080000_TableTargetedPayloadRecord_0A3E6F:
	dc.b	$FC,$10,$04,$FB,$0E,$02,$00,$17,$33

Bank080000_TableTargetedPayloadRecord_0A3E78:
	dc.b	$00,$17,$39

Bank080000_TableTargetedPayloadRecord_0A3E7B:
	dc.b	$FC,$08,$10,$FB,$06,$0B,$50,$17,$3F,$06,$17,$45,$FF

Bank080000_TableTargetedPayloadRecord_0A3E88:
	dc.b	$FC,$07,$10,$FB,$06,$0B,$50,$17,$5B,$06,$17,$71,$FF

Bank080000_TableTargetedPayloadRecord_0A3E95:
	dc.b	$FC,$07,$10,$FB,$04,$0A,$FE,$0A,$17,$50,$0A,$17,$5B,$0A,$17,$66
	dc.b	$0A,$17,$71,$FF

Bank080000_TableTargetedPayloadRecord_0A3EA9:
	dc.b	$FC,$08,$10,$FB,$06,$0B,$50,$17,$81,$06,$17,$87,$50,$17,$81,$06
	dc.b	$17,$92,$FF

Bank080000_TableTargetedPayloadRecord_0A3EBC:
	dc.b	$FC,$07,$0C,$FB,$06,$07,$FE,$50,$17,$9D,$06,$17,$A3,$06,$17,$9D
	dc.b	$06,$17,$A3,$60,$17,$9D,$06,$17,$AE,$FF

Bank080000_TableTargetedPayloadRecord_0A3ED6:
	dc.b	$00,$17,$B9

Bank080000_TableTargetedPayloadRecord_0A3ED9:
	dc.b	$FC,$08,$10,$FB,$06,$0B,$50,$17,$D3,$06,$17,$D9,$50,$17,$D3,$06
	dc.b	$17,$E4,$FF

Bank080000_TableTargetedPayloadRecord_0A3EEC:
	dc.b	$FC,$07,$0C,$FB,$06,$07,$50,$17,$EF,$06,$17,$FA,$FF

Bank080000_TableTargetedPayloadRecord_0A3EF9:
	dc.b	$FC,$07,$10,$FB,$04,$0A,$FE,$08,$18,$0A,$08,$18,$15,$08,$18,$20
	dc.b	$08,$18,$15,$FF

Bank080000_TableTargetedPayloadRecord_0A3F0D:
	dc.b	$00,$18,$2B

Bank080000_TableTargetedPayloadRecord_0A3F10:
	dc.b	$FC,$08,$08,$FB,$05,$05,$00,$18,$31

Bank080000_TableTargetedPayloadRecord_0A3F19:
	dc.b	$FC,$08,$08,$FB,$05,$05,$00,$18,$37

Bank080000_TableTargetedPayloadRecord_0A3F22:
	dc.b	$FC,$20,$08,$FB,$1B,$06,$00,$18,$3D

Bank080000_TableTargetedPayloadRecord_0A3F2B:
	dc.b	$FC,$18,$08,$FB,$05,$14,$00,$18,$48

Bank080000_TableTargetedPayloadRecord_0A3F34:
	dc.b	$FC,$18,$08,$FB,$05,$14,$FE,$05,$18,$5D,$05,$18,$72,$FF

Bank080000_TableTargetedPayloadRecord_0A3F42:
	dc.b	$08,$18,$87,$08,$18,$92,$08,$18,$9D,$FF

Bank080000_TableTargetedPayloadRecord_0A3F4C:
	dc.b	$FB,$04,$04,$00,$0E,$DF

Bank080000_TableTargetedPayloadRecord_0A3F52:
	dc.b	$00,$18,$A8

Bank080000_TableTargetedPayloadRecord_0A3F55:
	dc.b	$00,$18,$B8

Bank080000_TableTargetedPayloadRecord_0A3F58:
	dc.b	$00,$18,$C8

Bank080000_TableTargetedPayloadRecord_0A3F5B:
	dc.b	$00,$18,$E7

Bank080000_TableTargetedPayloadRecord_0A3F5E:
	dc.b	$04,$18,$ED,$04,$18,$F3,$04,$18,$F9,$04,$18,$FF,$FD

Bank080000_TableTargetedPayloadRecord_0A3F6B:
	dc.b	$00,$19,$0F

Bank080000_TableTargetedPayloadRecord_0A3F6E:
	dc.b	$00,$19,$24

Bank080000_TableTargetedPayloadRecord_0A3F71:
	dc.b	$FC,$10,$08,$00,$19,$39

Bank080000_TableTargetedPayloadRecord_0A3F77:
	dc.b	$FC,$20,$08,$00,$19,$44

Bank080000_TableTargetedPayloadRecord_0A3F7D:
	dc.b	$FC,$30,$08,$00,$19,$4F

Bank080000_TableTargetedPayloadRecord_0A3F83:
	dc.b	$FC,$28,$08,$00,$19,$64

Bank080000_TableTargetedPayloadRecord_0A3F89:
	dc.b	$FC,$0A,$10,$FB,$06,$0A,$50,$19,$8D,$06,$19,$93,$06,$19,$8D,$06
	dc.b	$19,$93,$FF

Bank080000_TableTargetedPayloadRecord_0A3F9C:
	dc.b	$FC,$0A,$10,$FB,$06,$0B,$50,$19,$9E,$06,$19,$A4,$06,$19,$9E,$06
	dc.b	$19,$A4,$FF

Bank080000_TableTargetedPayloadRecord_0A3FAF:
	dc.b	$FC,$0A,$10,$FB,$06,$0B,$80,$19,$BF,$06,$19,$DF,$FF

Bank080000_TableTargetedPayloadRecord_0A3FBC:
	dc.b	$FC,$0A,$10,$FB,$04,$0A,$FE,$0A,$19,$AF,$0A,$19,$BF,$0A,$19,$CF
	dc.b	$0A,$19,$DF,$FF

Bank080000_TableTargetedPayloadRecord_0A3FD0:
	dc.b	$FC,$0A,$10,$FB,$06,$0B,$50,$19,$F4,$06,$19,$FA,$FF

Bank080000_TableTargetedPayloadRecord_0A3FDD:
	dc.b	$FC,$0A,$10,$FB,$06,$0B,$70,$1A,$15,$06,$1A,$35,$FF

Bank080000_TableTargetedPayloadRecord_0A3FEA:
	dc.b	$FC,$0A,$10,$FB,$04,$0A,$FE,$0A,$1A,$05,$0A,$1A,$15,$0A,$1A,$25
	dc.b	$0A,$1A,$35,$FF

Bank080000_TableTargetedPayloadRecord_0A3FFE:
	dc.b	$FC,$0A,$10,$FB,$06,$0B,$50,$1A,$4A,$06,$1A,$50,$06,$1A,$4A,$06
	dc.b	$1A,$50,$FF

Bank080000_TableTargetedPayloadRecord_0A4011:
	dc.b	$FC,$0A,$10,$FB,$06,$0B,$01,$1A,$6B,$01,$1A,$8B,$FF

Bank080000_TableTargetedPayloadRecord_0A401E:
	dc.b	$FC,$0A,$10,$FB,$04,$0A,$FE,$0A,$1A,$5B,$0A,$1A,$6B,$0A,$1A,$7B
	dc.b	$0A,$1A,$8B,$FF

Bank080000_TableTargetedPayloadRecord_0A4032:
	dc.b	$FC,$0B,$0B,$FB,$07,$08,$00,$1A,$A0

Bank080000_TableTargetedPayloadRecord_0A403B:
	dc.b	$FC,$0B,$0B,$FB,$07,$08,$00,$1A,$A6

Bank080000_TableTargetedPayloadRecord_0A4044:
	dc.b	$FC,$08,$10,$FB,$04,$0B,$50,$1A,$AC,$06,$1A,$B2,$FF

Bank080000_TableTargetedPayloadRecord_0A4051:
	dc.b	$FC,$08,$08,$FB,$04,$0B,$50,$1A,$C8,$06,$1A,$DE,$FF

Bank080000_TableTargetedPayloadRecord_0A405E:
	dc.b	$FC,$08,$08,$FB,$04,$0B,$FE,$0A,$1A,$BD,$0A,$1A,$C8,$0A,$1A,$D3
	dc.b	$0A,$1A,$DE,$FF

Bank080000_TableTargetedPayloadRecord_0A4072:
	dc.b	$FC,$08,$10,$FB,$04,$0B,$50,$1A,$EE,$06,$1A,$F4,$FF

Bank080000_TableTargetedPayloadRecord_0A407F:
	dc.b	$FC,$08,$08,$FB,$04,$0B,$50,$1B,$0A,$05,$1B,$20,$FF

Bank080000_TableTargetedPayloadRecord_0A408C:
	dc.b	$FC,$08,$08,$FB,$04,$0B,$FE,$0A,$1A,$FF,$0A,$1B,$0A,$0A,$1B,$15
	dc.b	$0A,$1B,$20,$FF

Bank080000_TableTargetedPayloadRecord_0A40A0:
	dc.b	$FC,$08,$10,$FB,$04,$0B,$50,$1B,$30,$07,$1B,$36,$FF

Bank080000_TableTargetedPayloadRecord_0A40AD:
	dc.b	$FC,$08,$08,$FB,$04,$0B,$50,$1B,$4C,$06,$1B,$62,$FF

Bank080000_TableTargetedPayloadRecord_0A40BA:
	dc.b	$FC,$08,$08,$FB,$04,$0B,$FE,$0A,$1B,$41,$0A,$1B,$4C,$0A,$1B,$57
	dc.b	$0A,$1B,$62,$FF

Bank080000_TableTargetedPayloadRecord_0A40CE:
	dc.b	$FC,$08,$10,$FB,$04,$0B,$50,$1B,$72,$06,$1B,$8A,$06,$1B,$72,$06
	dc.b	$1B,$8A,$FF

Bank080000_TableTargetedPayloadRecord_0A40E1:
	dc.b	$FC,$08,$10,$FB,$04,$0B,$FE,$0A,$1B,$78,$0A,$1B,$7E,$0A,$1B,$84
	dc.b	$0A,$1B,$7E,$FF

Bank080000_TableTargetedPayloadRecord_0A40F5:
	dc.b	$FC,$08,$0B,$FB,$04,$08,$50,$0E,$BB,$06,$1B,$9A,$06,$0E,$BB,$06
	dc.b	$1B,$9A,$FF

Bank080000_TableTargetedPayloadRecord_0A4108:
	dc.b	$00,$1B,$A5

Bank080000_TableTargetedPayloadRecord_0A410B:
	dc.b	$FC,$09,$0B,$FB,$04,$0B,$50,$1B,$AB,$06,$1B,$AB,$FF

Bank080000_TableTargetedPayloadRecord_0A4118:
	dc.b	$FC,$0A,$10,$FB,$04,$0B,$00,$1B,$B6

Bank080000_TableTargetedPayloadRecord_0A4121:
	dc.b	$00,$1B,$C1

Bank080000_TableTargetedPayloadRecord_0A4124:
	dc.b	$FC,$10,$0C,$FB,$0E,$0A,$00,$15,$F5

Bank080000_TableTargetedPayloadRecord_0A412D:
	dc.b	$06,$16,$07,$06,$16,$0D,$FF

Bank080000_TableTargetedPayloadRecord_0A4134:
	dc.b	$04,$15,$F5,$04,$15,$FB,$04,$16,$01,$FF

Bank080000_TableTargetedPayloadRecord_0A413E:
	dc.b	$FC,$0C,$10,$FB,$0A,$0E,$00,$10,$0F

Bank080000_TableTargetedPayloadRecord_0A4147:
	dc.b	$08,$10,$09,$08,$10,$0F,$FF

Bank080000_TableTargetedPayloadRecord_0A414E:
	dc.b	$00,$10,$0F

Bank080000_TableTargetedPayloadRecord_0A4151:
	dc.b	$08,$0F,$F1,$08,$16,$F1,$FF

Bank080000_TableTargetedPayloadRecord_0A4158:
	dc.b	$00,$16,$F1

Bank080000_TableTargetedPayloadRecord_0A415B:
	dc.b	$06,$0F,$AF,$06,$0F,$B5,$06,$0F,$BB,$FF

Bank080000_TableTargetedPayloadRecord_0A4165:
	dc.b	$06,$0F,$AF,$06,$0F,$C1,$06,$0F,$EB,$FF

Bank080000_TableTargetedPayloadRecord_0A416F:
	dc.b	$FC,$10,$10,$FB,$0E,$0E,$00,$16,$49

Bank080000_TableTargetedPayloadRecord_0A4178:
	dc.b	$08,$1B,$C7,$08,$1B,$CD,$FF

Bank080000_TableTargetedPayloadRecord_0A417F:
	dc.b	$00,$1B,$C7

Bank080000_TableTargetedPayloadRecord_0A4182:
	dc.b	$08,$16,$49,$08,$16,$4F,$08,$16,$55,$FF

Bank080000_TableTargetedPayloadRecord_0A418C:
	dc.b	$00,$16,$55

Bank080000_TableTargetedPayloadRecord_0A418F:
	dc.b	$04,$16,$49,$08,$16,$5B,$FD

Bank080000_TableTargetedPayloadRecord_0A4196:
	dc.b	$FC,$10,$10,$FB,$0E,$0E,$00,$16,$4F

Bank080000_TableTargetedPayloadRecord_0A419F:
	dc.b	$08,$16,$5B,$08,$1B,$C7,$FF

Bank080000_TableTargetedPayloadRecord_0A41A6:
	dc.b	$00,$16,$4F

Bank080000_TableTargetedPayloadRecord_0A41A9:
	dc.b	$08,$16,$49,$08,$16,$4F,$08,$16,$55,$FF

Bank080000_TableTargetedPayloadRecord_0A41B3:
	dc.b	$FC,$10,$14,$FB,$0E,$12,$00,$1B,$F4

Bank080000_TableTargetedPayloadRecord_0A41BC:
	dc.b	$08,$1C,$1F,$08,$1C,$2A,$FF

Bank080000_TableTargetedPayloadRecord_0A41C3:
	dc.b	$00,$1C,$1F

Bank080000_TableTargetedPayloadRecord_0A41C6:
	dc.b	$00,$1B,$F4

Bank080000_TableTargetedPayloadRecord_0A41C9:
	dc.b	$08,$1B,$D3,$08,$1B,$DE,$08,$1B,$E9,$FF

Bank080000_TableTargetedPayloadRecord_0A41D3:
	dc.b	$00,$1B,$D3

Bank080000_TableTargetedPayloadRecord_0A41D6:
	dc.b	$04,$1B,$FF,$04,$1C,$0F,$FD

Bank080000_TableTargetedPayloadRecord_0A41DD:
	dc.b	$FC,$10,$20,$00,$1C,$35

Bank080000_TableTargetedPayloadRecord_0A41E3:
	dc.b	$FC,$0B,$10,$FB,$06,$0D,$70,$1C,$4F,$07,$1C,$64,$FF

Bank080000_TableTargetedPayloadRecord_0A41F0:
	dc.b	$FC,$10,$18,$FB,$0A,$0E,$05,$1C,$7E,$05,$1C,$89,$05,$1C,$99,$05
	dc.b	$1C,$A9,$FF

Bank080000_TableTargetedPayloadRecord_0A4203:
	dc.b	$FC,$10,$18,$05,$1C,$B9,$05,$1C,$C4,$05,$1C,$CF,$05,$1C,$DA,$FD

Bank080000_TableTargetedPayloadRecord_0A4213:
	dc.b	$FC,$10,$18,$00,$1C,$DA

Bank080000_TableTargetedPayloadRecord_0A4219:
	dc.b	$FC,$07,$07,$FB,$05,$05,$00,$1C,$E5

Bank080000_TableTargetedPayloadRecord_0A4222:
	dc.b	$FC,$07,$07,$FB,$05,$05,$00,$1C,$EB

Bank080000_TableTargetedPayloadRecord_0A422B:
	dc.b	$FC,$0A,$10,$FB,$06,$0B,$50,$1C,$FC,$06,$1D,$12,$FF

Bank080000_TableTargetedPayloadRecord_0A4238:
	dc.b	$0A,$1C,$F1,$0A,$1C,$FC,$0A,$1D,$07,$0A,$1D,$12,$FF

Bank080000_TableTargetedPayloadRecord_0A4245:
	dc.b	$FC,$0A,$10,$FB,$06,$0B,$00,$1D,$22

Bank080000_TableTargetedPayloadRecord_0A424E:
	dc.b	$02,$1D,$2D,$02,$1D,$33,$02,$1D,$39,$02,$1D,$3F,$01,$1D,$45,$01
	dc.b	$1D,$4B,$01,$1D,$51,$FD

Bank080000_TableTargetedPayloadRecord_0A4264:
	dc.b	$FC,$08,$08,$00,$1D,$57

Bank080000_TableTargetedPayloadRecord_0A426A:
	dc.b	$00,$1D,$5D

Bank080000_TableTargetedPayloadRecord_0A426D:
	dc.b	$00,$1D,$68

Bank080000_TableTargetedPayloadRecord_0A4270:
	dc.b	$00,$1D,$73

Bank080000_TableTargetedPayloadRecord_0A4273:
	dc.b	$00,$1D,$7E

Bank080000_TableTargetedPayloadRecord_0A4276:
	dc.b	$03,$1D,$89,$03,$1D,$B2,$03,$1D,$DB,$FF

Bank080000_TableTargetedPayloadRecord_0A4280:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$80,$1E,$04,$07,$1E,$0F,$FF

Bank080000_TableTargetedPayloadRecord_0A428D:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$80,$1E,$24,$07,$1E,$2F,$FF

Bank080000_TableTargetedPayloadRecord_0A429A:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$0A,$1E,$3F,$0A,$1E,$4A,$0A,$1E,$55,$FF

Bank080000_TableTargetedPayloadRecord_0A42AA:
	dc.b	$00,$1E,$24

Bank080000_TableTargetedPayloadRecord_0A42AD:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$80,$1E,$60,$07,$1E,$6B,$FF

Bank080000_TableTargetedPayloadRecord_0A42BA:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$80,$1E,$80,$07,$1E,$8B,$FF

Bank080000_TableTargetedPayloadRecord_0A42C7:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$0A,$1E,$9B,$0A,$1E,$A6,$0A,$1E,$B1,$FF

Bank080000_TableTargetedPayloadRecord_0A42D7:
	dc.b	$00,$1E,$BC

Bank080000_TableTargetedPayloadRecord_0A42DA:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$80,$1E,$D1,$07,$1E,$DC,$FF

Bank080000_TableTargetedPayloadRecord_0A42E7:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$80,$1E,$F1,$07,$1E,$FC,$FF

Bank080000_TableTargetedPayloadRecord_0A42F4:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$0A,$1F,$0C,$0A,$1F,$17,$0A,$1F,$22,$FF

Bank080000_TableTargetedPayloadRecord_0A4304:
	dc.b	$00,$1F,$2D

Bank080000_TableTargetedPayloadRecord_0A4307:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$80,$1F,$42,$07,$1F,$4D,$FF

Bank080000_TableTargetedPayloadRecord_0A4314:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$80,$1F,$62,$07,$1F,$6D,$FF

Bank080000_TableTargetedPayloadRecord_0A4321:
	dc.b	$FC,$0C,$10,$FB,$08,$0B,$0A,$1F,$7D,$0A,$1F,$88,$0A,$1F,$93,$FF

Bank080000_TableTargetedPayloadRecord_0A4331:
	dc.b	$00,$1F,$9E

Bank080000_TableTargetedPayloadRecord_0A4334:
	dc.b	$FC,$20,$20,$FB,$18,$18,$00,$1F,$B3

Bank080000_TableTargetedPayloadRecord_0A433D:
	dc.b	$08,$16,$DC,$08,$1F,$C8,$FF

Bank080000_TableTargetedPayloadRecord_0A4344:
	dc.b	$00,$1F,$C8

Bank080000_TableTargetedPayloadRecord_0A4347:
	dc.b	$00,$1F,$B3

Bank080000_TableTargetedPayloadRecord_0A434A:
	dc.b	$08,$16,$9D,$08,$1F,$B3,$08,$16,$C7,$FF

Bank080000_TableTargetedPayloadRecord_0A4354:
	dc.b	$00,$16,$C7

Bank080000_TableTargetedPayloadRecord_0A4357:
	dc.b	$06,$16,$C7,$06,$16,$9D,$06,$16,$9D,$08,$16,$C7

Bank080000_TableTargetedPayloadRecord_0A4363:
	dc.b	$FC,$20,$28,$FB,$1E,$26,$00,$20,$3A

Bank080000_TableTargetedPayloadRecord_0A436C:
	dc.b	$08,$20,$7D,$08,$20,$3A,$FF

Bank080000_TableTargetedPayloadRecord_0A4373:
	dc.b	$00,$20,$7D

Bank080000_TableTargetedPayloadRecord_0A4376:
	dc.b	$00,$20,$3A

Bank080000_TableTargetedPayloadRecord_0A4379:
	dc.b	$08,$1F,$DD,$08,$1F,$FC,$08,$20,$1B,$FF

Bank080000_TableTargetedPayloadRecord_0A4383:
	dc.b	$00,$1F,$DD

Bank080000_TableTargetedPayloadRecord_0A4386:
	dc.b	$06,$20,$59,$06,$20,$3A,$FD

Bank080000_TableTargetedPayloadRecord_0A438D:
	dc.b	$FC,$10,$10,$FB,$0E,$0E,$00,$20,$B8

Bank080000_TableTargetedPayloadRecord_0A4396:
	dc.b	$08,$20,$DA,$08,$20,$E0,$FF

Bank080000_TableTargetedPayloadRecord_0A439D:
	dc.b	$00,$20,$D4

Bank080000_TableTargetedPayloadRecord_0A43A0:
	dc.b	$00,$20,$B8

Bank080000_TableTargetedPayloadRecord_0A43A3:
	dc.b	$08,$20,$9C,$08,$20,$A7,$08,$20,$B2,$FF

Bank080000_TableTargetedPayloadRecord_0A43AD:
	dc.b	$00,$20,$9C

Bank080000_TableTargetedPayloadRecord_0A43B0:
	dc.b	$08,$20,$C3,$F8,$08,$20,$C9,$00,$20,$B8

Bank080000_TableTargetedPayloadRecord_0A43BA:
	dc.b	$FC,$0C,$10,$FB,$0A,$0E,$FE,$04,$10,$09,$04,$10,$0F,$04,$10,$15
	dc.b	$FF

Bank080000_TableTargetedPayloadRecord_0A43CB:
	dc.b	$08,$20,$EC,$08,$20,$F2,$FF

Bank080000_TableTargetedPayloadRecord_0A43D2:
	dc.b	$00,$20,$F2
