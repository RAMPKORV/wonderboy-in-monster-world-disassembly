; ROM range: 0x0A0C83-0x0A10AA
; Narrower structural split inside the still-mixed 0x0A0B26-0x0A34FF lead-in. Several
; subranges here resolve into regular 6-byte records whose final byte is always $FF, with
; small inter-band gaps that are no longer opaque either: the first and last ones break
; into neighboring FF-terminated tuple records plus short non-terminated tails, while the
; middle pocket is itself another compact FF-terminated record family with one trailing
; singleton $FF marker. The higher-level owner and field semantics are still open, so keep
; the naming at record-band level.

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
Bank080000_FFTerminatedMixedRecord_0A0D19:
	dc.b	$07,$0A,$A0,$00,$F0,$07,$02,$A0,$F0,$F0,$FF

Bank080000_FFTerminatedMixedRecord_0A0D24:
	dc.b	$07,$0A,$A8,$00,$F0,$07,$02,$A8,$F0,$F0,$FF

Bank080000_FFTerminatedMixedRecord_0A0D2F:
	dc.b	$07,$0A,$B0,$00,$F0,$07,$02,$B0,$F0,$F0,$FF

Bank080000_MixedPayloadTail_0A0D3A:
	dc.b	$07,$0A,$B8,$00,$F0

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
Bank080000_FFTerminatedMixedRecord_0A0D75:
	dc.b	$03,$22,$B0,$F8,$F0,$0F,$22,$C0,$00,$F0,$FF

Bank080000_FFTerminatedMixedRecord_0A0D80:
	dc.b	$0F,$22,$B0,$F8,$F0,$FF

Bank080000_FFTerminatedMixedRecord_0A0D86:
	dc.b	$01,$22,$E6,$00,$F8,$01,$22,$E0,$F8,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0D91:
	dc.b	$0D,$22,$E0,$F0,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0D97:
	dc.b	$09,$22,$E2,$00,$F8,$09,$22,$E0,$E8,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0DA2:
	dc.b	$01,$22,$EE,$00,$F8,$01,$22,$E8,$F8,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0DAD:
	dc.b	$05,$22,$EC,$00,$F8,$05,$22,$E8,$F0,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0DB8:
	dc.b	$09,$22,$EA,$00,$F8,$09,$22,$E8,$E8,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0DC3:
	dc.b	$01,$42,$E6,$00,$F8,$01,$42,$E0,$F8,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0DCE:
	dc.b	$0D,$42,$E0,$F0,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0DD4:
	dc.b	$09,$42,$E2,$00,$F8,$09,$42,$E0,$E8,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0DDF:
	dc.b	$01,$42,$EE,$00,$F8,$01,$42,$E8,$F8,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0DEA:
	dc.b	$05,$42,$EC,$00,$F8,$05,$42,$E8,$F0,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0DF5:
	dc.b	$09,$42,$EA,$00,$F8,$09,$42,$E8,$E8,$F8,$FF

Bank080000_FFTerminatedMixedRecord_0A0E00:
	dc.b	$04,$63,$84,$68,$13,$04,$63,$84,$2E,$FB,$09,$62,$F6,$50,$10,$0D
	dc.b	$62,$EE,$30,$10,$09,$62,$E8,$B8,$10,$0D,$62,$E0,$98,$10,$0F,$63
	dc.b	$74,$10,$00,$0F,$63,$64,$F0,$00,$0F,$63,$54,$D0,$00,$07,$63,$4C
	dc.b	$48,$E0,$0F,$63,$3C,$28,$E0,$0F,$63,$2C,$08,$E0,$0F,$63,$1C,$E8
	dc.b	$E0,$0F,$63,$0C,$C8,$E0,$0F,$62,$FC,$A8,$E0,$FF

Bank080000_FFTerminatedMixedRecord_0A0E4C:
	dc.b	$00,$63,$BD,$4C,$0C,$0C,$63,$B9,$2C,$0C,$05,$63,$B5,$1C,$08,$0D
	dc.b	$63,$AD,$FC,$08,$0D,$63,$A5,$DC,$08,$05,$62,$DB,$CD,$09,$0D,$62
	dc.b	$D3,$AD,$09,$09,$62,$C9,$14,$F8,$09,$62,$C3,$14,$E8,$0F,$61,$F0
	dc.b	$F4,$E8,$0F,$61,$E0,$D4,$E8,$FF

Bank080000_FFTerminatedMixedRecord_0A0E84:
	dc.b	$FF

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
Bank080000_FFTerminatedMixedRecord_0A0F2D:
	dc.b	$0C,$60,$14,$F0,$EC,$03,$60,$18,$E8,$F4,$0B,$60,$08,$F0,$F4,$05
	dc.b	$60,$04,$08,$04,$05,$60,$00,$08,$F4,$FF

Bank080000_FFTerminatedMixedRecord_0A0F47:
	dc.b	$0C,$60,$14,$F0,$EC,$03,$60,$1C,$E8,$F4,$0B,$60,$08,$F0,$F4,$05
	dc.b	$60,$04,$08,$04,$05,$60,$00,$08,$F4,$FF

Bank080000_FFTerminatedMixedRecord_0A0F61:
	dc.b	$0C,$60,$14,$F0,$EC,$03,$60,$20,$E8,$F4,$0B,$60,$08,$F0,$F4,$05
	dc.b	$60,$04,$08,$04,$05,$60,$00,$08,$F4,$FF

Bank080000_FFTerminatedMixedRecord_0A0F7B:
	dc.b	$0C,$60,$14,$F0,$EC,$03,$60,$1C,$E8,$F4,$0B,$60,$08,$F0,$F4,$05
	dc.b	$60,$28,$08,$04,$05,$60,$24,$08,$F4,$FF

Bank080000_MixedPayloadTail_0A0F95:
	dc.b	$0C,$60,$38,$F0,$EC,$03,$60,$1C,$E8,$F4,$0B,$60,$2C,$F0,$F4,$05
	dc.b	$60,$28,$08,$04

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
