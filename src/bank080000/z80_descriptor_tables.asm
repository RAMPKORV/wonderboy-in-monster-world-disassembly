; ROM range: 0x099920-0x099A84
; Front structured band inside the 0x098000-0x09F776 non-fill island.
;
; The first 0x60 bytes at 0x099920-0x09997F tighten cleanly into sixteen fixed 6-byte
; records. The following 0xF5 bytes at 0x099980-0x099A74 tighten into forty-nine fixed
; 5-byte records, followed by a 16-byte tail at 0x099A75-0x099A84. The bytes strongly
; support stable record cadence, but the consuming loader and field semantics are still
; unresolved, so keep the names structural.

Bank080000_DescriptorHeaderRecordBand_099920:
Bank080000_DescriptorHeaderRecord_099920:
	dc.b	$04,$00,$00,$08,$FF,$FF

Bank080000_DescriptorHeaderRecord_099926:
	dc.b	$FC,$10,$FF,$26,$19,$40

Bank080000_DescriptorHeaderRecord_09992C:
	dc.b	$F8,$FF,$FA,$12,$F0,$FF

Bank080000_DescriptorHeaderRecord_099932:
	dc.b	$04,$12,$00,$04,$22,$00

Bank080000_DescriptorHeaderRecord_099938:
	dc.b	$04,$32,$00,$35,$42,$00

Bank080000_DescriptorHeaderRecord_09993E:
	dc.b	$FA,$01,$1F,$00,$01,$22

Bank080000_DescriptorHeaderRecord_099944:
	dc.b	$05,$01,$11,$02,$01,$22

Bank080000_DescriptorHeaderRecord_09994A:
	dc.b	$FF,$01,$30,$03,$01,$30

Bank080000_DescriptorHeaderRecord_099950:
	dc.b	$FF,$FA,$05,$00,$00,$F9

Bank080000_DescriptorHeaderRecord_099956:
	dc.b	$02,$FD,$04,$0C,$FF,$FF

Bank080000_DescriptorHeaderRecord_09995C:
	dc.b	$0C,$01,$00,$FE,$FD,$04

Bank080000_DescriptorHeaderRecord_099962:
	dc.b	$0C,$FF,$FF,$0C,$01,$00

Bank080000_DescriptorHeaderRecord_099968:
	dc.b	$FE,$F9,$01,$FD,$04,$18

Bank080000_DescriptorHeaderRecord_09996E:
	dc.b	$FE,$FF,$18,$02,$00,$FE

Bank080000_DescriptorHeaderRecord_099974:
	dc.b	$18,$FD,$FF,$18,$03,$00

Bank080000_DescriptorHeaderRecord_09997A:
	dc.b	$FF,$74,$19,$01,$E0,$FE

Bank080000_PackedLayoutDescriptorRecordTable_099980:
Bank080000_PackedLayoutDescriptorRecord_099980:
	dc.b	$01,$10,$07,$01,$10

Bank080000_PackedLayoutDescriptorRecord_099985:
	dc.b	$FA,$01,$B0,$01,$01

Bank080000_PackedLayoutDescriptorRecord_09998A:
	dc.b	$D0,$FE,$01,$00,$06

Bank080000_PackedLayoutDescriptorRecord_09998F:
	dc.b	$01,$D0,$F4,$01,$50

Bank080000_PackedLayoutDescriptorRecord_099994:
	dc.b	$FE,$01,$B0,$04,$01

Bank080000_PackedLayoutDescriptorRecord_099999:
	dc.b	$00,$FC,$FF,$7D,$19

Bank080000_PackedLayoutDescriptorRecord_09999E:
	dc.b	$F8,$03,$FF,$F8,$03

Bank080000_PackedLayoutDescriptorRecord_0999A3:
	dc.b	$FF,$FF,$9E,$19,$F9

Bank080000_PackedLayoutDescriptorRecord_0999A8:
	dc.b	$04,$01,$00,$0C,$01

Bank080000_PackedLayoutDescriptorRecord_0999AD:
	dc.b	$00,$F4,$FF,$A9,$19

Bank080000_PackedLayoutDescriptorRecord_0999B2:
	dc.b	$FB,$80,$FE,$0C,$20

Bank080000_PackedLayoutDescriptorRecord_0999B7:
	dc.b	$00,$20,$00,$00,$FF

Bank080000_PackedLayoutDescriptorRecord_0999BC:
	dc.b	$60,$19,$F8,$05,$F0

Bank080000_PackedLayoutDescriptorRecord_0999C1:
	dc.b	$F8,$05,$F0,$FF,$BE

Bank080000_PackedLayoutDescriptorRecord_0999C6:
	dc.b	$19,$35,$00,$FF,$FF

Bank080000_PackedLayoutDescriptorRecord_0999CB:
	dc.b	$C7,$19,$65,$90,$FF

Bank080000_PackedLayoutDescriptorRecord_0999D0:
	dc.b	$FF,$CD,$19,$85,$03

Bank080000_PackedLayoutDescriptorRecord_0999D5:
	dc.b	$00,$FA,$03,$DE,$19

Bank080000_PackedLayoutDescriptorRecord_0999DA:
	dc.b	$DF,$19,$E8,$19,$00

Bank080000_PackedLayoutDescriptorRecord_0999DF:
	dc.b	$F9,$04,$04,$FF,$FC

Bank080000_PackedLayoutDescriptorRecord_0999E4:
	dc.b	$0A,$FF,$E3,$19,$F9

Bank080000_PackedLayoutDescriptorRecord_0999E9:
	dc.b	$02,$10,$FF,$FC,$20

Bank080000_PackedLayoutDescriptorRecord_0999EE:
	dc.b	$FF,$EC,$19,$00,$20

Bank080000_PackedLayoutDescriptorRecord_0999F3:
	dc.b	$17,$10,$00,$04,$00

Bank080000_PackedLayoutDescriptorRecord_0999F8:
	dc.b	$10,$1B,$50,$00,$48

Bank080000_PackedLayoutDescriptorRecord_0999FD:
	dc.b	$00,$10,$0C,$10,$00

Bank080000_PackedLayoutDescriptorRecord_099A02:
	dc.b	$1C,$00,$20,$0C,$10

Bank080000_PackedLayoutDescriptorRecord_099A07:
	dc.b	$00,$20,$00,$10,$0C

Bank080000_PackedLayoutDescriptorRecord_099A0C:
	dc.b	$10,$00,$24,$00,$20

Bank080000_PackedLayoutDescriptorRecord_099A11:
	dc.b	$10,$10,$00,$0E,$00

Bank080000_PackedLayoutDescriptorRecord_099A16:
	dc.b	$20,$12,$10,$00,$03

Bank080000_PackedLayoutDescriptorRecord_099A1B:
	dc.b	$00,$10,$13,$09,$00

Bank080000_PackedLayoutDescriptorRecord_099A20:
	dc.b	$07,$00,$10,$14,$90

Bank080000_PackedLayoutDescriptorRecord_099A25:
	dc.b	$00,$0E,$00,$20,$15

Bank080000_PackedLayoutDescriptorRecord_099A2A:
	dc.b	$50,$00,$54,$00,$10

Bank080000_PackedLayoutDescriptorRecord_099A2F:
	dc.b	$16,$50,$00,$48,$00

Bank080000_PackedLayoutDescriptorRecord_099A34:
	dc.b	$10,$16,$10,$00,$54

Bank080000_PackedLayoutDescriptorRecord_099A39:
	dc.b	$00,$20,$17,$50,$00

Bank080000_PackedLayoutDescriptorRecord_099A3E:
	dc.b	$14,$00,$20,$17,$10

Bank080000_PackedLayoutDescriptorRecord_099A43:
	dc.b	$00,$1A,$00,$20,$17

Bank080000_PackedLayoutDescriptorRecord_099A48:
	dc.b	$90,$00,$22,$00,$10

Bank080000_PackedLayoutDescriptorRecord_099A4D:
	dc.b	$18,$8A,$00,$47,$00

Bank080000_PackedLayoutDescriptorRecord_099A52:
	dc.b	$10,$19,$8E,$00,$47

Bank080000_PackedLayoutDescriptorRecord_099A57:
	dc.b	$00,$20,$1A,$10,$00

Bank080000_PackedLayoutDescriptorRecord_099A5C:
	dc.b	$12,$00,$10,$1E,$50

Bank080000_PackedLayoutDescriptorRecord_099A61:
	dc.b	$00,$09,$00,$10,$2A

Bank080000_PackedLayoutDescriptorRecord_099A66:
	dc.b	$50,$00,$5F,$00,$20

Bank080000_PackedLayoutDescriptorRecord_099A6B:
	dc.b	$11,$90,$00,$0F,$00

Bank080000_PackedLayoutDescriptorRecord_099A70:
	dc.b	$20,$11,$50,$00,$08

Bank080000_PackedLayoutDescriptorTail_099A75:
	dc.b	$FF,$11,$01,$9B,$81,$12,$4B,$16,$28,$18,$8F,$18,$01,$19,$D8,$19
