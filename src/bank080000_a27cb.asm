; ROM range: 0x0A27CB-0x0A2D85
; This run continues the same FF-terminated five-byte tuple family. Every record ends at
; a proven local $FF terminator, and every pre-terminator payload length remains a
; multiple of 5 bytes, so the source exposes each stable record start directly in ROM
; order while keeping the labels structural.
;
; This subsection is no longer a dense stack of record-local incbins. The bytes now show
; several locally coherent families directly in source: a short 0x61-page staircase front,
; a compact 0x20/0x00/0x10/0x18 page pocket around 0x0A280A-0x0A2877, repeated 0x68/0x69-page
; composite records through the middle, and a late 0x60/0x61-page ladder that leads into the
; already explicit anomaly bridge at 0x0A2D86.

Bank080000_FFTerminatedFiveByteTupleRecord_0A27CB:
	dc.b	$04,$61,$2D,$E0,$00
	dc.b	$04,$61,$2B,$E0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A27D6:
	dc.b	$04,$61,$2F,$E0,$08
	dc.b	$04,$61,$2D,$E0,$00
	dc.b	$04,$61,$2B,$E0,$F8
	dc.b	$04,$61,$29,$E0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A27EB:
	dc.b	$04,$61,$31,$E0,$10
	dc.b	$04,$61,$2F,$E0,$08
	dc.b	$04,$61,$2D,$E0,$00
	dc.b	$04,$61,$2B,$E0,$F8
	dc.b	$04,$61,$29,$E0,$F0
	dc.b	$04,$61,$27,$E0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A280A:
	dc.b	$08,$20,$48,$F4,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2810:
	dc.b	$09,$20,$4B,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2816:
	dc.b	$00,$00,$5A,$FC,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A281C:
	dc.b	$0A,$00,$5B,$F4,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2822:
	dc.b	$0B,$00,$64,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2828:
	dc.b	$0B,$00,$70,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A282E:
	dc.b	$01,$00,$7C,$FB,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2834:
	dc.b	$06,$08,$8E,$00,$F4
	dc.b	$06,$00,$8E,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A283F:
	dc.b	$0A,$00,$9A,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2845:
	dc.b	$09,$10,$94,$F4,$01
	dc.b	$09,$00,$94,$F4,$F1
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2850:
	dc.b	$0A,$10,$9A,$F4,$F5
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2856:
	dc.b	$06,$18,$8E,$00,$F4
	dc.b	$06,$10,$8E,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2861:
	dc.b	$0A,$18,$9A,$F4,$F5
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2867:
	dc.b	$09,$18,$94,$F4,$01
	dc.b	$09,$08,$94,$F4,$F1
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2872:
	dc.b	$0A,$08,$9A,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2878:
	dc.b	$00,$00,$A3,$FC,$F4
	dc.b	$06,$08,$8E,$00,$F4
	dc.b	$06,$00,$8E,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2888:
	dc.b	$01,$00,$A3,$FC,$F4
	dc.b	$06,$08,$8E,$00,$F4
	dc.b	$06,$00,$8E,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2898:
	dc.b	$02,$00,$A3,$FC,$F4
	dc.b	$06,$08,$8E,$00,$F4
	dc.b	$06,$00,$8E,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A28A8:
	dc.b	$05,$00,$B8,$03,$F4
	dc.b	$08,$00,$BC,$FB,$04
	dc.b	$05,$10,$B5,$EC,$F4
	dc.b	$08,$10,$B2,$EC,$04
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A28BD:
	dc.b	$09,$00,$AC,$00,$FD
	dc.b	$09,$00,$A6,$E9,$FD
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A28C8:
	dc.b	$0B,$68,$4A,$F2,$F2
	dc.b	$0F,$68,$3A,$0A,$F2
	dc.b	$05,$68,$36,$E9,$12
	dc.b	$07,$68,$26,$E2,$F2
	dc.b	$0D,$68,$2E,$F9,$12
	dc.b	$09,$60,$20,$E2,$E2
	dc.b	$0D,$68,$18,$FA,$E2
	dc.b	$0E,$68,$0B,$CA,$F9
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A28F1:
	dc.b	$0B,$68,$4A,$F2,$F2
	dc.b	$0F,$68,$3A,$0A,$F2
	dc.b	$05,$68,$36,$E9,$12
	dc.b	$07,$68,$26,$E2,$F2
	dc.b	$0D,$68,$2E,$F9,$12
	dc.b	$09,$60,$20,$E2,$E2
	dc.b	$0D,$68,$18,$FA,$E2
	dc.b	$0B,$68,$00,$D6,$F2
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A291A:
	dc.b	$05,$68,$56,$2A,$FC
	dc.b	$0B,$68,$6A,$F2,$F2
	dc.b	$0F,$68,$5A,$0A,$F2
	dc.b	$05,$68,$36,$E9,$12
	dc.b	$07,$68,$26,$E2,$F2
	dc.b	$0D,$68,$2E,$F9,$12
	dc.b	$09,$60,$20,$E2,$E2
	dc.b	$0D,$68,$18,$FA,$E2
	dc.b	$0E,$68,$0B,$CA,$F9
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2948:
	dc.b	$0D,$69,$63,$D2,$12
	dc.b	$0F,$68,$B2,$D2,$F2
	dc.b	$0F,$68,$A2,$D2,$D2
	dc.b	$0C,$68,$9E,$F2,$12
	dc.b	$0F,$68,$8E,$F2,$F2
	dc.b	$0F,$68,$7E,$F2,$D2
	dc.b	$07,$68,$76,$12,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A296C:
	dc.b	$08,$68,$E6,$E2,$12
	dc.b	$07,$68,$BA,$D2,$F2
	dc.b	$0D,$69,$63,$D2,$12
	dc.b	$0F,$68,$D2,$E2,$F2
	dc.b	$0F,$68,$A2,$D2,$D2
	dc.b	$0C,$68,$E2,$FA,$12
	dc.b	$0F,$68,$7E,$F2,$D2
	dc.b	$0F,$68,$C2,$02,$F2
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2995:
	dc.b	$09,$79,$2B,$D8,$14
	dc.b	$08,$69,$28,$CA,$08
	dc.b	$09,$69,$2B,$C9,$F2
	dc.b	$0A,$69,$1F,$D2,$DA
	dc.b	$06,$69,$1A,$E4,$CF
	dc.b	$06,$61,$1A,$0A,$D0
	dc.b	$02,$61,$17,$FA,$CE
	dc.b	$0D,$79,$8C,$FE,$0A
	dc.b	$09,$69,$86,$E6,$0A
	dc.b	$0B,$69,$7A,$E6,$EA
	dc.b	$0F,$69,$6A,$FE,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A29CD:
	dc.b	$00,$21,$31,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A29D3:
	dc.b	$05,$29,$32,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A29D9:
	dc.b	$0A,$29,$36,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A29DF:
	dc.b	$0A,$29,$3F,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A29E5:
	dc.b	$0A,$29,$48,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A29EB:
	dc.b	$0A,$29,$51,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A29F1:
	dc.b	$0A,$29,$5A,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A29F7:
	dc.b	$05,$69,$94,$0A,$F7
	dc.b	$0D,$69,$63,$D2,$12
	dc.b	$0F,$68,$B2,$D2,$F2
	dc.b	$0F,$68,$A2,$D2,$D2
	dc.b	$0C,$68,$9E,$F2,$12
	dc.b	$0F,$68,$8E,$F2,$F2
	dc.b	$0F,$68,$7E,$F2,$D2
	dc.b	$07,$68,$76,$12,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2A20:
	dc.b	$03,$68,$8E,$00,$E8
	dc.b	$04,$68,$68,$EA,$E0
	dc.b	$04,$68,$66,$FA,$E0
	dc.b	$07,$68,$5E,$DA,$C8
	dc.b	$03,$68,$86,$D8,$F8
	dc.b	$0F,$68,$6E,$E0,$E8
	dc.b	$05,$68,$7E,$D0,$E8
	dc.b	$0F,$68,$4E,$EA,$C0
	dc.b	$0B,$68,$42,$0A,$C8
	dc.b	$0C,$68,$2E,$08,$E8
	dc.b	$08,$68,$27,$08,$F0
	dc.b	$0D,$68,$1C,$08,$F8
	dc.b	$0E,$68,$10,$E0,$08
	dc.b	$00,$68,$0E,$00,$08
	dc.b	$01,$68,$0C,$00,$10
	dc.b	$0E,$68,$00,$08,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2A71:
	dc.b	$06,$68,$A6,$06,$08
	dc.b	$03,$68,$8E,$FE,$E8
	dc.b	$04,$68,$68,$E8,$E0
	dc.b	$04,$68,$66,$F8,$E0
	dc.b	$07,$68,$5E,$D8,$C8
	dc.b	$03,$68,$86,$D6,$F8
	dc.b	$0F,$68,$6E,$DE,$E8
	dc.b	$05,$68,$7E,$CE,$E8
	dc.b	$0F,$68,$4E,$E8,$C0
	dc.b	$0B,$68,$36,$08,$C8
	dc.b	$0C,$68,$32,$06,$E8
	dc.b	$0E,$68,$96,$06,$F0
	dc.b	$0E,$68,$10,$DE,$08
	dc.b	$00,$68,$0E,$FE,$08
	dc.b	$00,$68,$AD,$FE,$10
	dc.b	$05,$68,$A2,$16,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2AC2:
	dc.b	$07,$68,$D0,$C8,$F8
	dc.b	$06,$68,$CA,$D8,$00
	dc.b	$07,$68,$C2,$E8,$00
	dc.b	$03,$68,$BE,$F8,$00
	dc.b	$06,$68,$B8,$D8,$E8
	dc.b	$0A,$68,$AE,$E8,$E8
	dc.b	$03,$68,$92,$00,$E8
	dc.b	$04,$68,$6C,$EA,$E0
	dc.b	$04,$68,$6A,$FA,$E0
	dc.b	$07,$68,$5E,$DA,$C8
	dc.b	$0F,$68,$4E,$EA,$C0
	dc.b	$0B,$68,$42,$0A,$C8
	dc.b	$0C,$68,$2E,$08,$E8
	dc.b	$08,$68,$27,$08,$F0
	dc.b	$0D,$68,$1C,$08,$F8
	dc.b	$00,$68,$0F,$00,$08
	dc.b	$01,$68,$0C,$00,$10
	dc.b	$0E,$68,$00,$08,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2B1D:
	dc.b	$07,$68,$D0,$C8,$F8
	dc.b	$06,$68,$CA,$D8,$00
	dc.b	$07,$68,$C2,$E8,$00
	dc.b	$03,$68,$BE,$F8,$00
	dc.b	$06,$68,$B8,$D8,$E8
	dc.b	$0A,$68,$AE,$E8,$E8
	dc.b	$06,$68,$A6,$08,$08
	dc.b	$03,$68,$92,$00,$E8
	dc.b	$04,$68,$6C,$EA,$E0
	dc.b	$04,$68,$6A,$FA,$E0
	dc.b	$07,$68,$5E,$DA,$C8
	dc.b	$0F,$68,$4E,$EA,$C0
	dc.b	$0B,$68,$36,$0A,$C8
	dc.b	$0C,$68,$32,$08,$E8
	dc.b	$0E,$68,$96,$08,$F0
	dc.b	$00,$68,$0F,$00,$08
	dc.b	$00,$68,$AD,$00,$10
	dc.b	$05,$68,$A2,$18,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2B78:
	dc.b	$0F,$69,$08,$EA,$C0
	dc.b	$0C,$69,$02,$FA,$E0
	dc.b	$07,$68,$FA,$08,$E8
	dc.b	$01,$68,$EC,$D8,$F8
	dc.b	$03,$68,$EE,$00,$E8
	dc.b	$04,$69,$06,$EA,$E0
	dc.b	$07,$68,$5E,$DA,$C8
	dc.b	$01,$68,$88,$D8,$08
	dc.b	$0F,$68,$DC,$E0,$E8
	dc.b	$05,$68,$7E,$D0,$E8
	dc.b	$07,$68,$F2,$18,$E8
	dc.b	$0E,$68,$10,$E0,$08
	dc.b	$00,$68,$0E,$00,$08
	dc.b	$01,$68,$0C,$00,$10
	dc.b	$0E,$68,$00,$08,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2BC4:
	dc.b	$04,$69,$35,$F8,$E8
	dc.b	$03,$68,$5A,$EA,$C0
	dc.b	$02,$68,$8F,$00,$F0
	dc.b	$0C,$69,$31,$EA,$E0
	dc.b	$07,$68,$5E,$DA,$C8
	dc.b	$03,$68,$86,$D8,$F8
	dc.b	$0F,$68,$6E,$E0,$E8
	dc.b	$05,$68,$7E,$D0,$E8
	dc.b	$0A,$69,$28,$F2,$C8
	dc.b	$0B,$69,$1C,$0A,$C8
	dc.b	$08,$69,$18,$08,$E8
	dc.b	$08,$68,$27,$08,$F0
	dc.b	$0D,$68,$1C,$08,$F8
	dc.b	$0E,$68,$10,$E0,$08
	dc.b	$00,$68,$0E,$00,$08
	dc.b	$01,$68,$0C,$00,$10
	dc.b	$0E,$68,$00,$08,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2C1A:
	dc.b	$05,$69,$4B,$03,$B8
	dc.b	$01,$69,$49,$F2,$D0
	dc.b	$04,$69,$47,$EA,$E0
	dc.b	$0C,$69,$37,$F8,$E8
	dc.b	$03,$68,$5A,$EA,$C0
	dc.b	$02,$68,$8F,$00,$F0
	dc.b	$07,$68,$5E,$DA,$C8
	dc.b	$03,$68,$86,$D8,$F8
	dc.b	$0F,$68,$6E,$E0,$E8
	dc.b	$05,$68,$7E,$D0,$E8
	dc.b	$0B,$69,$3B,$FA,$C8
	dc.b	$08,$68,$27,$08,$F0
	dc.b	$0D,$68,$1C,$08,$F8
	dc.b	$0E,$68,$10,$E0,$08
	dc.b	$00,$68,$0E,$00,$08
	dc.b	$01,$68,$0C,$00,$10
	dc.b	$01,$68,$0C,$F8,$10
	dc.b	$0E,$68,$00,$08,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2C75:
	dc.b	$00,$61,$4F,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2C7B:
	dc.b	$04,$79,$50,$F8,$00
	dc.b	$04,$61,$50,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2C86:
	dc.b	$0A,$61,$52,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2C8C:
	dc.b	$0A,$61,$5B,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2C92:
	dc.b	$0A,$61,$64,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2C98:
	dc.b	$0A,$61,$6D,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2C9E:
	dc.b	$0D,$79,$76,$F0,$00
	dc.b	$0D,$61,$76,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2CA9:
	dc.b	$0D,$79,$7E,$F0,$00
	dc.b	$0D,$61,$7E,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2CB4:
	dc.b	$0D,$79,$86,$F0,$00
	dc.b	$0D,$61,$86,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2CBF:
	dc.b	$0D,$79,$8E,$F0,$00
	dc.b	$0D,$61,$8E,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2CCA:
	dc.b	$09,$00,$18,$F4,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2CD0:
	dc.b	$0A,$60,$30,$08,$00
	dc.b	$0B,$60,$24,$08,$E0
	dc.b	$0F,$60,$14,$E8,$00
	dc.b	$03,$60,$10,$E0,$00
	dc.b	$0E,$60,$04,$E8,$E8
	dc.b	$03,$60,$00,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2CEF:
	dc.b	$0B,$60,$68,$08,$00
	dc.b	$0B,$60,$5C,$08,$E0
	dc.b	$0F,$60,$4C,$E8,$00
	dc.b	$02,$60,$49,$E0,$00
	dc.b	$0E,$60,$3D,$E8,$E8
	dc.b	$03,$60,$39,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2D0E:
	dc.b	$0B,$60,$68,$08,$00
	dc.b	$0B,$60,$5C,$08,$E0
	dc.b	$0F,$60,$14,$E8,$00
	dc.b	$03,$60,$10,$E0,$00
	dc.b	$0E,$60,$04,$E8,$E8
	dc.b	$03,$60,$00,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2D2D:
	dc.b	$0F,$60,$80,$08,$F8
	dc.b	$0B,$60,$74,$08,$D8
	dc.b	$0F,$60,$14,$E8,$00
	dc.b	$03,$60,$10,$E0,$00
	dc.b	$0E,$60,$04,$E8,$E8
	dc.b	$03,$60,$00,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2D4C:
	dc.b	$0A,$60,$A2,$08,$00
	dc.b	$01,$60,$A0,$28,$F0
	dc.b	$0F,$60,$90,$08,$E0
	dc.b	$0F,$60,$14,$E8,$00
	dc.b	$03,$60,$10,$E0,$00
	dc.b	$0E,$60,$04,$E8,$E8
	dc.b	$03,$60,$00,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2D70:
	dc.b	$0F,$60,$C0,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A2D76:
	dc.b	$02,$60,$E4,$0C,$F8
	dc.b	$0C,$60,$E0,$EC,$08
	dc.b	$0F,$60,$D0,$EC,$E8
	dc.b	$FF
