; ROM range: 0x0A0C83-0x0A10AA
; Narrower structural split inside the still-mixed 0x0A0B26-0x0A34FF lead-in. Several
; subranges here resolve into regular 6-byte records whose final byte is always $FF, with
; small inter-band gaps that still look more heterogeneous. The higher-level owner and
; field semantics are still open, so keep the naming at record-band level.

Bank080000_FFTerminatedSixByteRecordBand_0A0C83:
	dc.b	$05,$01,$F5,$F0,$FB,$FF
	dc.b	$09,$01,$00,$F4,$F8,$FF
	dc.b	$09,$01,$06,$F4,$F8,$FF
	dc.b	$09,$01,$0C,$F4,$F8,$FF
	dc.b	$0A,$01,$30,$F5,$F0,$FF
	dc.b	$0A,$01,$39,$EF,$F0,$FF
	dc.b	$0E,$01,$42,$EF,$F0,$FF
	dc.b	$0A,$01,$4D,$F7,$F0,$FF
	dc.b	$0A,$01,$56,$F7,$F0,$FF
	dc.b	$05,$01,$1E,$F8,$F8,$FF
	dc.b	$09,$01,$12,$F2,$F8,$FF
	dc.b	$09,$01,$22,$F4,$F8,$FF
	dc.b	$05,$01,$28,$F8,$F8,$FF
	dc.b	$05,$01,$2C,$F8,$F8,$FF
	dc.b	$09,$09,$18,$F5,$F8,$FF
	dc.b	$09,$01,$60,$F4,$F8,$FF
	dc.b	$09,$00,$0F,$F4,$F8,$FF
	dc.b	$03,$00,$15,$FC,$E8,$FF
	dc.b	$0F,$22,$A0,$F0,$F0,$FF
	dc.b	$0B,$22,$B0,$F8,$F0,$FF
	dc.b	$03,$22,$BC,$08,$F0,$FF
	dc.b	$0F,$02,$C0,$F0,$F0,$FF
	dc.b	$0F,$02,$A0,$F0,$F0,$FF
	dc.b	$0B,$02,$B0,$F8,$F0,$FF
	dc.b	$03,$02,$BC,$08,$F0,$FF

Bank080000_MixedPayloadGap_0A0D19:
	incbin "data/rom/bank_080000_0bffff.bin",$020D19,$000026

Bank080000_FFTerminatedSixByteRecordBand_0A0D3F:
	dc.b	$07,$02,$B8,$F0,$F0,$FF
	dc.b	$05,$22,$D0,$F8,$F8,$FF
	dc.b	$05,$22,$D4,$F8,$F8,$FF
	dc.b	$01,$22,$D8,$00,$F8,$FF
	dc.b	$0F,$03,$80,$F0,$F0,$FF
	dc.b	$0B,$03,$90,$F8,$F0,$FF
	dc.b	$03,$03,$9C,$08,$F0,$FF
	dc.b	$07,$22,$A0,$F8,$F0,$FF
	dc.b	$07,$22,$A8,$F8,$F0,$FF

Bank080000_MixedPayloadGap_0A0D75:
	incbin "data/rom/bank_080000_0bffff.bin",$020D75,$000110

Bank080000_FFTerminatedSixByteRecordBand_0A0E85:
	dc.b	$0A,$20,$00,$F4,$F4,$FF
	dc.b	$0A,$20,$09,$F4,$F4,$FF
	dc.b	$0A,$20,$12,$F4,$F4,$FF
	dc.b	$0A,$20,$1B,$F4,$F4,$FF
	dc.b	$0A,$20,$24,$F4,$F4,$FF
	dc.b	$05,$20,$00,$F8,$F8,$FF
	dc.b	$05,$20,$04,$F8,$F8,$FF
	dc.b	$05,$20,$08,$F8,$F8,$FF
	dc.b	$05,$20,$0C,$F8,$F8,$FF
	dc.b	$0A,$00,$00,$F4,$F4,$FF
	dc.b	$0A,$00,$09,$F4,$F4,$FF
	dc.b	$0A,$00,$12,$F4,$F4,$FF
	dc.b	$0A,$00,$1B,$F4,$F4,$FF
	dc.b	$0A,$00,$24,$F4,$F4,$FF
	dc.b	$0A,$00,$2D,$F4,$F4,$FF
	dc.b	$05,$00,$00,$F8,$F8,$FF
	dc.b	$05,$00,$04,$F8,$F8,$FF
	dc.b	$05,$00,$08,$F8,$F8,$FF
	dc.b	$05,$00,$0C,$F8,$F8,$FF
	dc.b	$05,$00,$10,$F8,$F8,$FF
	dc.b	$05,$00,$14,$F8,$F8,$FF
	dc.b	$00,$00,$18,$FC,$FC,$FF
	dc.b	$00,$00,$19,$FC,$FC,$FF
	dc.b	$05,$00,$0C,$F8,$F6,$FF
	dc.b	$05,$20,$10,$F8,$F8,$FF
	dc.b	$09,$00,$10,$F4,$F8,$FF
	dc.b	$00,$60,$4C,$FC,$FC,$FF
	dc.b	$00,$60,$4D,$FC,$FC,$FF

Bank080000_MixedPayloadGap_0A0F2D:
	incbin "data/rom/bank_080000_0bffff.bin",$020F2D,$00007C

Bank080000_FFTerminatedSixByteRecordBand_0A0FA9:
	dc.b	$05,$60,$24,$08,$F4,$FF
	dc.b	$0A,$60,$00,$F4,$F4,$FF
	dc.b	$0A,$60,$09,$F4,$F4,$FF
	dc.b	$0A,$60,$12,$F4,$F4,$FF
	dc.b	$0A,$60,$1B,$F4,$F4,$FF
	dc.b	$0E,$60,$24,$F8,$F4,$FF
	dc.b	$0A,$60,$30,$F4,$F4,$FF
	dc.b	$0A,$60,$39,$F4,$F4,$FF
	dc.b	$0A,$60,$42,$F4,$F4,$FF
	dc.b	$0A,$60,$4B,$F4,$F4,$FF
	dc.b	$0A,$60,$54,$F4,$F4,$FF
	dc.b	$0A,$60,$24,$F4,$F4,$FF
	dc.b	$0A,$60,$2D,$F4,$F4,$FF
	dc.b	$0B,$60,$00,$F4,$F0,$FF
	dc.b	$0B,$60,$0C,$F4,$F0,$FF
	dc.b	$0B,$60,$18,$F4,$F0,$FF
	dc.b	$0B,$60,$24,$F4,$F0,$FF
	dc.b	$0B,$60,$30,$F4,$F0,$FF
	dc.b	$0B,$60,$3C,$F4,$F0,$FF
	dc.b	$0B,$60,$48,$F4,$F0,$FF
	dc.b	$0A,$00,$36,$F4,$F4,$FF
	dc.b	$0A,$00,$3F,$F4,$F4,$FF
	dc.b	$05,$60,$54,$F8,$F8,$FF
	dc.b	$05,$60,$58,$F8,$F8,$FF
	dc.b	$05,$60,$5C,$F8,$F8,$FF
	dc.b	$05,$02,$00,$FB,$F8,$FF
	dc.b	$01,$02,$04,$FC,$F8,$FF
	dc.b	$01,$02,$06,$FE,$F8,$FF
	dc.b	$01,$0A,$04,$FC,$F8,$FF
	dc.b	$05,$02,$08,$F8,$F8,$FF
	dc.b	$05,$02,$0C,$F8,$F8,$FF
	dc.b	$01,$02,$10,$FC,$F8,$FF
	dc.b	$05,$0A,$0C,$F8,$F8,$FF
	dc.b	$05,$02,$1A,$F9,$F8,$FF
	dc.b	$05,$02,$16,$F9,$F8,$FF
	dc.b	$05,$02,$12,$F9,$F8,$FF
	dc.b	$0B,$02,$36,$F6,$F0,$FF
	dc.b	$0B,$02,$2A,$F4,$F0,$FF
	dc.b	$0E,$02,$1E,$F2,$F8,$FF
	dc.b	$00,$02,$46,$FC,$FD,$FF
	dc.b	$05,$02,$42,$F8,$F8,$FF
	dc.b	$04,$07,$BC,$F8,$F8,$FF
	dc.b	$05,$07,$B8,$F8,$F0,$FF
