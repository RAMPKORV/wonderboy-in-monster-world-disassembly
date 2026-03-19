; ROM range: 0x0A0B26-0x0A0C82
; Front mixed lead-in between the earlier four-tuple band and the later fixed-width
; FF-terminated 6-byte record families.
;
; This pocket does not hold one clean tuple width, but most of the span still breaks into
; short FF-terminated structural records. The final 10 bytes at 0x0A0C79-0x0A0C82 still do
; not fit that cadence, but they are now at least source-visible as one unresolved tail byte
; band instead of a tiny raw gap.

Bank080000_FFTerminatedMixedLeadInRecord_0A0B26:
	dc.b	$02,$09,$C4,$06,$F9,$08,$09,$09,$F4,$08,$08,$09,$06,$F4,$00,$09
	dc.b	$09,$00,$F4,$F0,$0C,$11,$9B,$EE,$00,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0B40:
	dc.b	$08,$01,$98,$EE,$00,$05,$09,$5B,$00,$00,$05,$01,$5B,$F0,$00,$09
	dc.b	$01,$1B,$F4,$F0,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0B55:
	dc.b	$00,$01,$FA,$07,$FD,$05,$01,$E0,$F7,$F8,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0B60:
	dc.b	$00,$01,$FA,$07,$FD,$05,$01,$E4,$F7,$F8,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0B6B:
	dc.b	$05,$01,$E8,$F8,$F8,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0B71:
	dc.b	$00,$01,$FB,$F9,$FB,$05,$01,$E8,$F8,$F8,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0B7C:
	dc.b	$00,$01,$FB,$0C,$0D,$00,$01,$FB,$10,$06,$00,$01,$FB,$0C,$00,$00
	dc.b	$01,$F8,$F8,$04,$00,$01,$FB,$02,$09,$00,$01,$FB,$04,$00,$05,$01
	dc.b	$E0,$F7,$F8,$00,$11,$FA,$07,$04,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0BA5:
	dc.b	$05,$19,$FC,$0E,$02,$05,$11,$FC,$FE,$02,$05,$09,$FC,$0E,$F2,$05
	dc.b	$01,$FC,$FE,$F2,$00,$01,$F9,$08,$FE,$05,$01,$EC,$F8,$F8,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0BC4:
	dc.b	$00,$01,$F8,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0BC8:
	dc.b	$08,$00,$01,$F8,$0E,$0E,$00,$01,$F8,$1A,$05,$00,$01,$F8,$18,$F4
	dc.b	$00,$01,$F8,$0C,$EC,$00,$01,$F8,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0BE1:
	dc.b	$F2,$00,$01,$F9,$08,$FE,$05,$01,$EC,$F8,$F8,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0BED:
	dc.b	$00,$01,$F9,$08,$FE,$05,$01,$EC,$F8,$F8,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0BF8:
	dc.b	$00,$08,$D0,$09,$01,$05,$01,$F0,$F8,$F8,$00,$11,$FA,$05,$02,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C08:
	dc.b	$05,$01,$F4,$F8,$F8,$00,$01,$FA,$06,$FB,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C13:
	dc.b	$04,$01,$E4,$F8,$00,$05,$01,$E0,$F8,$F6,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C1E:
	dc.b	$04,$01,$E6,$F8,$00,$05,$01,$E0,$F8,$F6,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C29:
	dc.b	$08,$01,$E8,$F6,$00,$05,$01,$E0,$F8,$F6,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C34:
	dc.b	$05,$01,$ED,$F9,$F6,$04,$01,$EB,$F8,$00,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C3F:
	dc.b	$05,$01,$F1,$F6,$F6,$04,$01,$EB,$F8,$00,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C4A:
	dc.b	$00,$01,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C4D:
	dc.b	$07,$F4,$00,$01,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C52:
	dc.b	$F2,$00,$00,$01,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C57:
	dc.b	$F0,$F7,$01,$01,$FD,$00,$F8,$05,$01,$F9,$F0,$F8,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C64:
	dc.b	$00,$01,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C67:
	dc.b	$FA,$F3,$00,$01,$FF

Bank080000_FFTerminatedMixedLeadInRecord_0A0C6C:
	dc.b	$0A,$FC,$01,$09,$FD,$F8,$F8,$05,$09,$F9,$00,$F8,$FF

Bank080000_MixedLeadInTailBytes_0A0C79:
	dc.b	$05,$01,$E0,$F8,$F6,$05,$09,$F5,$00,$FB
