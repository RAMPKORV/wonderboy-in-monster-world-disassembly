; ROM range: 0x0A4AEC-0x0A4C76
; Compact local-offset/control tail pocket within the 0x0A3500+ table-targeted family.
; The bytes stay structural for now, but the repeated FC/FB/FE prefix controls and the
; following local offset lists are clearer in source than as dozens of tiny incbins.

Bank080000_StandaloneLocalOffset_0A4AEC:
Bank080000_TableTargetedPayloadRecord_0A4AEC:
	dc.b	$00,$31,$9E

Bank080000_StandaloneLocalOffset_0A4AEF:
Bank080000_TableTargetedPayloadRecord_0A4AEF:
	dc.b	$00,$31,$A4

Bank080000_StandaloneLocalOffset_0A4AF2:
Bank080000_TableTargetedPayloadRecord_0A4AF2:
	dc.b	$00,$31,$AA

Bank080000_TableTargetedPayloadRecord_0A4AF5:
	dc.b	$FC,$08,$10,$FB,$04,$08,$00,$31,$B0

Bank080000_TableTargetedPayloadRecord_0A4AFE:
	dc.b	$06,$0E,$B5,$06,$0F,$15,$FF

Bank080000_TableTargetedPayloadRecord_0A4B05:
	dc.b	$00,$0E,$B5

Bank080000_TableTargetedPayloadRecord_0A4B08:
	dc.b	$06,$0E,$A3,$06,$0E,$A9,$06,$0E,$AF,$06,$0E,$A9,$FF

Bank080000_TableTargetedPayloadRecord_0A4B15:
	dc.b	$FC,$04,$04,$FB,$03,$03,$00,$15,$7B

Bank080000_TableTargetedPayloadRecord_0A4B1E:
	dc.b	$06,$15,$87,$06,$15,$8D,$FF

Bank080000_TableTargetedPayloadRecord_0A4B25:
	dc.b	$03,$15,$7B,$01,$15,$81,$03,$15,$87,$01,$15,$81,$FF

Bank080000_TableTargetedPayloadRecord_0A4B32:
	dc.b	$FC,$04,$04,$FB,$03,$03,$00,$31,$BB

Bank080000_TableTargetedPayloadRecord_0A4B3B:
	dc.b	$00,$31,$C1

Bank080000_TableTargetedPayloadRecord_0A4B3E:
	dc.b	$00,$31,$C7

Bank080000_TableTargetedPayloadRecord_0A4B41:
	dc.b	$00,$31,$CD

Bank080000_TableTargetedPayloadRecord_0A4B44:
	dc.b	$00,$31,$D3

Bank080000_TableTargetedPayloadRecord_0A4B47:
	dc.b	$00,$31,$DE

Bank080000_TableTargetedPayloadRecord_0A4B4A:
	dc.b	$00,$31,$E9

Bank080000_TableTargetedPayloadRecord_0A4B4D:
	dc.b	$00,$31,$F4

Bank080000_TableTargetedPayloadRecord_0A4B50:
	dc.b	$00,$31,$FF

Bank080000_TableTargetedPayloadRecord_0A4B53:
	dc.b	$00,$32,$0F

Bank080000_TableTargetedPayloadRecord_0A4B56:
	dc.b	$00,$32,$1F

Bank080000_TableTargetedPayloadRecord_0A4B59:
	dc.b	$00,$32,$2F

Bank080000_TableTargetedPayloadRecord_0A4B5C:
	dc.b	$03,$32,$82,$04,$32,$7C,$05,$32,$76,$00,$32,$3F

Bank080000_TableTargetedPayloadRecord_0A4B68:
	dc.b	$00,$32,$3F

Bank080000_TableTargetedPayloadRecord_0A4B6B:
	dc.b	$01,$32,$3F,$06,$32,$4A,$10,$32,$55,$04,$32,$60,$0A,$32,$6B
	dc.b	$04,$32,$60,$10,$32,$55,$06,$32,$4A,$00,$32,$3F

Bank080000_TableTargetedPayloadRecord_0A4B86:
	dc.b	$03,$32,$3F,$06,$32,$76,$04,$32,$7C,$02,$32,$82,$04,$32,$88
	dc.b	$04,$32,$8E,$04,$32,$99,$04,$32,$A4,$04,$32,$AA,$04,$32,$B0,$FD

Bank080000_TableTargetedPayloadRecord_0A4BA5:
	dc.b	$FB,$07,$07,$FE,$04,$32,$B6,$04,$32,$BC,$04,$32,$C2,$FF

Bank080000_TableTargetedPayloadRecord_0A4BB3:
	dc.b	$00,$32,$C8

Bank080000_TableTargetedPayloadRecord_0A4BB6:
	dc.b	$00,$32,$D3

Bank080000_TableTargetedPayloadRecord_0A4BB9:
	dc.b	$06,$32,$DE,$04,$32,$E9,$03,$32,$F4,$02,$32,$FF,$FD

Bank080000_TableTargetedPayloadRecord_0A4BC6:
	dc.b	$02,$32,$FF,$03,$32,$F4,$04,$32,$E9,$06,$32,$DE,$FD

Bank080000_TableTargetedPayloadRecord_0A4BD3:
	dc.b	$00,$33,$0A

Bank080000_TableTargetedPayloadRecord_0A4BD6:
	dc.b	$01,$33,$10,$07,$33,$16,$04,$33,$2B,$06,$33,$40,$02,$33,$55
	dc.b	$05,$33,$6A,$07,$33,$7F,$08,$33,$A8,$08,$33,$D1,$08,$33,$FA
	dc.b	$08,$34,$23,$06,$34,$4C,$02,$34,$61,$FD

Bank080000_TableTargetedPayloadRecord_0A4BFE:
	dc.b	$FB,$07,$07,$FE,$04,$34,$76,$04,$34,$7C,$04,$34,$82,$04,$34,$88,$FF

Bank080000_TableTargetedPayloadRecord_0A4C0F:
	dc.b	$FC,$04,$04,$FB,$01,$01,$FE,$06,$34,$8E,$06,$34,$94,$06,$34,$9A,$FF

Bank080000_TableTargetedPayloadRecord_0A4C20:
	dc.b	$FC,$04,$04,$FB,$02,$02,$FE,$06,$34,$A0,$06,$34,$A6,$06,$34,$AC,$FF

Bank080000_TableTargetedPayloadRecord_0A4C31:
	dc.b	$FC,$06,$06,$FB,$03,$03,$FE,$06,$34,$B2,$06,$34,$B8,$06,$34,$BE,$FF

Bank080000_TableTargetedPayloadRecord_0A4C42:
	dc.b	$FC,$08,$08,$FB,$04,$04,$FE,$06,$34,$C4,$06,$34,$CA,$06,$34,$D0,$FF

Bank080000_TableTargetedPayloadRecord_0A4C53:
	dc.b	$FC,$0A,$0A,$FB,$04,$05,$FE,$06,$34,$D6,$06,$34,$DC,$06,$34,$E2,$FF

Bank080000_TableTargetedPayloadRecord_0A4C64:
	dc.b	$FC,$10,$10,$FB,$07,$07,$FE,$02,$34,$E8,$02,$34,$EE,$02,$34,$F4
	dc.b	$02,$34,$FA
