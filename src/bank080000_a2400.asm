; ROM range: 0x0A2400-0x0A2585
; This run continues the same FF-terminated five-byte tuple family. Every record ends at
; a proven local $FF terminator, and every pre-terminator payload length remains a
; multiple of 5 bytes, so the source exposes each stable record start directly in ROM
; order while keeping the labels structural.
;
; The front half is no longer a thin wrapper around record-local incbins. The bytes now make
; a few repeated subfamilies directly auditable in source: paired 0x60/0x68 variants around
; tile pages 0x18/0x2E/0x37/0x49/0x4B, a compact 0x01-page cluster around 0xE0-0xFE, and a
; late 0x60/0x61-page ladder that leads into the already split 0x0A2586 bridge records.

Bank080000_FFTerminatedFiveByteTupleRecord_0A2400:
	dc.b	$09,$60,$18,$E8,$F8
	dc.b	$09,$68,$18,$00,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A240B:
	dc.b	$05,$48,$28,$04,$F8
	dc.b	$05,$40,$28,$EC,$F8
	dc.b	$09,$60,$18,$E8,$F8
	dc.b	$09,$68,$18,$00,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2420:
	dc.b	$04,$48,$2C,$02,$FE
	dc.b	$04,$40,$2C,$EE,$FE
	dc.b	$09,$60,$18,$E8,$F8
	dc.b	$09,$68,$18,$00,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2435:
	dc.b	$0A,$68,$2E,$00,$F0
	dc.b	$0A,$60,$2E,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2440:
	dc.b	$0A,$68,$37,$00,$F0
	dc.b	$0A,$60,$37,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A244B:
	dc.b	$01,$68,$49,$00,$F8
	dc.b	$01,$60,$49,$F8,$F8
	dc.b	$0A,$68,$2E,$00,$F0
	dc.b	$0A,$60,$2E,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2460:
	dc.b	$01,$68,$4B,$00,$F8
	dc.b	$01,$60,$4B,$F8,$F8
	dc.b	$0A,$68,$2E,$00,$F0
	dc.b	$0A,$60,$2E,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2475:
	dc.b	$03,$68,$40,$00,$F0
	dc.b	$03,$60,$40,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2480:
	dc.b	$00,$68,$46,$FC,$00
	dc.b	$01,$68,$44,$00,$F0
	dc.b	$01,$60,$44,$F8,$F0
	dc.b	$01,$68,$42,$00,$00
	dc.b	$01,$60,$42,$F8,$00
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A249A:
	dc.b	$05,$09,$F7,$FE,$FC
	dc.b	$09,$01,$EE,$F5,$F4
	dc.b	$08,$01,$E8,$F5,$04
	dc.b	$09,$01,$E0,$F2,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A24AF:
	dc.b	$05,$09,$F7,$FE,$FC
	dc.b	$08,$01,$F4,$F5,$04
	dc.b	$09,$01,$EE,$F5,$F4
	dc.b	$01,$01,$E6,$F5,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A24C4:
	dc.b	$09,$01,$EE,$F5,$F4
	dc.b	$08,$01,$E8,$F5,$04
	dc.b	$09,$01,$E0,$F2,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A24D4:
	dc.b	$08,$01,$F4,$F5,$04
	dc.b	$09,$01,$EE,$F5,$F4
	dc.b	$01,$01,$E6,$F5,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A24E4:
	dc.b	$08,$01,$ED,$F0,$00
	dc.b	$05,$01,$E0,$F8,$F1
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A24EF:
	dc.b	$08,$01,$EA,$F0,$00
	dc.b	$05,$01,$E0,$F8,$F1
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A24FA:
	dc.b	$05,$01,$E0,$F8,$F1
	dc.b	$04,$09,$FE,$F8,$FE
	dc.b	$04,$01,$FE,$F6,$FE
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A250A:
	dc.b	$06,$01,$E4,$F8,$F1
	dc.b	$08,$01,$ED,$F0,$00
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2515:
	dc.b	$00,$01,$F2,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A251B:
	dc.b	$05,$01,$F3,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2521:
	dc.b	$06,$09,$F7,$FB,$F3
	dc.b	$00,$09,$FD,$F3,$FB
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A252C:
	dc.b	$0B,$60,$B0,$08,$00
	dc.b	$0F,$60,$9C,$E8,$00
	dc.b	$0B,$60,$90,$08,$E0
	dc.b	$0F,$60,$80,$E8,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2541:
	dc.b	$0F,$60,$EC,$00,$00
	dc.b	$0F,$60,$DC,$E0,$00
	dc.b	$0F,$60,$CC,$00,$E0
	dc.b	$0F,$60,$BC,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2556:
	dc.b	$0F,$61,$2C,$00,$00
	dc.b	$0F,$61,$1C,$E0,$00
	dc.b	$0F,$61,$0C,$00,$E0
	dc.b	$0F,$60,$FC,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A256B:
	dc.b	$0F,$61,$6C,$00,$00
	dc.b	$0F,$61,$5C,$E0,$00
	dc.b	$0F,$61,$4C,$00,$E0
	dc.b	$0F,$61,$3C,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2580:
	dc.b	$0B,$43,$90,$F8,$F0
	dc.b	$FF
