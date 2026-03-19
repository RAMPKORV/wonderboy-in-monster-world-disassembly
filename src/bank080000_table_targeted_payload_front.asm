; ROM range: 0x0A3500-0x0A37AF
; Front source-authored slice of the 0x0A3500+ table-targeted back half.
;
; The nested offset tree already proved these starts, and the bytes here are compact enough
; to expose directly without forcing stronger subsystem meaning. The strongest current fit is
; structural: most records begin with a repeated FC/FB prefix, carry local 24-bit offsets back
; into the earlier 0x0A07C6-0x0A0D80 tuple families, and end in short FF/FD-terminated selector
; tails.

Bank080000_TableTargetedPayloadRecord_0A3500:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$00,$07,$C6

Bank080000_TableTargetedPayloadRecord_0A3509:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$FE,$06,$07,$E0,$06,$07,$FA,$06,$08,$14,$06,$09,$39,$FF

Bank080000_TableTargetedPayloadRecord_0A351D:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$00,$08,$2E

Bank080000_TableTargetedPayloadRecord_0A3526:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$01,$08,$43,$01,$08,$58,$01,$08,$68,$01,$08,$78,$01,$08,$88,$01,$08,$98,$F8,$04,$08,$98,$FD

Bank080000_TableTargetedPayloadRecord_0A3543:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$00,$08,$A8

Bank080000_TableTargetedPayloadRecord_0A354C:
	dc.b	$FC,$09,$08,$FB,$06,$06,$04,$08,$C8,$F8,$04,$08,$B8,$FD

Bank080000_TableTargetedPayloadRecord_0A355A:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$00,$08,$DD

Bank080000_TableTargetedPayloadRecord_0A3563:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$FE,$08,$08,$E3,$08,$08,$F8,$FF

Bank080000_TableTargetedPayloadRecord_0A3571:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$00,$09,$0D

Bank080000_TableTargetedPayloadRecord_0A357A:
	dc.b	$FC,$09,$08,$FB,$06,$0B,$00,$08,$B8

Bank080000_TableTargetedPayloadRecord_0A3583:
	dc.b	$FC,$09,$10,$FB,$06,$09,$00,$09,$33

Bank080000_TableTargetedPayloadRecord_0A358C:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$00,$09,$23

Bank080000_TableTargetedPayloadRecord_0A3595:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$00,$09,$18

Bank080000_TableTargetedPayloadRecord_0A359E:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$03,$07,$C6,$03,$09,$9D,$03,$09,$53,$F8,$02,$09,$72,$02,$09,$23,$FD

Bank080000_TableTargetedPayloadRecord_0A35B5:
	dc.b	$03,$09,$8C,$00,$09,$92

Bank080000_TableTargetedPayloadRecord_0A35BB:
	dc.b	$FC,$09,$10,$00,$09,$92,$00,$09,$8C

Bank080000_TableTargetedPayloadRecord_0A35C4:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$00,$09,$A8

Bank080000_TableTargetedPayloadRecord_0A35CD:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$FE,$06,$09,$C2,$06,$09,$DC,$06,$09,$F6,$06,$0B,$07,$FF

Bank080000_TableTargetedPayloadRecord_0A35E1:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$00,$0A,$10

Bank080000_TableTargetedPayloadRecord_0A35EA:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$04,$0A,$25,$01,$0A,$3A,$02,$0A,$4F,$F8,$01,$0A,$25,$FD

Bank080000_TableTargetedPayloadRecord_0A35FE:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$00,$0A,$64

Bank080000_TableTargetedPayloadRecord_0A3607:
	dc.b	$FC,$09,$08,$FB,$06,$06,$03,$0A,$89,$F8,$01,$0A,$74,$FD

Bank080000_TableTargetedPayloadRecord_0A3615:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$FE,$08,$0A,$9E,$08,$0A,$B3,$FF

Bank080000_TableTargetedPayloadRecord_0A3623:
	dc.b	$FC,$09,$08,$FB,$06,$0B,$00,$0A,$74

Bank080000_TableTargetedPayloadRecord_0A362C:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$FE,$03,$0A,$C8,$03,$0A,$DD,$02,$0A,$F2,$01,$0A,$F2,$FF

Bank080000_TableTargetedPayloadRecord_0A3640:
	dc.b	$FC,$09,$10,$FB,$06,$0B,$03,$09,$A8,$03,$09,$9D,$03,$0B,$21,$F8,$02,$0B,$40,$02,$09,$23,$FD

Bank080000_TableTargetedPayloadRecord_0A3657:
	dc.b	$FC,$08,$08,$FB,$06,$0B,$FE,$06,$0B,$55,$06,$0B,$60,$FF

Bank080000_TableTargetedPayloadRecord_0A3665:
	dc.b	$FC,$08,$08,$FB,$06,$0B,$02,$0B,$6B,$02,$0B,$71,$04,$0B,$7C,$03,$0B,$A5,$02,$0B,$C4,$03,$0B,$ED,$FD

Bank080000_TableTargetedPayloadRecord_0A367E:
	dc.b	$FC,$08,$08,$FB,$06,$0B,$FE,$06,$0B,$F8,$06,$0C,$08,$FF

Bank080000_TableTargetedPayloadRecord_0A368C:
	dc.b	$FC,$08,$08,$FB,$06,$0B,$00,$0C,$13,$FF

Bank080000_TableTargetedPayloadRecord_0A3696:
	dc.b	$08,$0C,$1E,$08,$0C,$29,$FF

Bank080000_TableTargetedPayloadRecord_0A369D:
	dc.b	$00,$0C,$79

Bank080000_TableTargetedPayloadRecord_0A36A0:
	dc.b	$06,$0C,$4A,$06,$0C,$64,$FF

Bank080000_TableTargetedPayloadRecord_0A36A7:
	dc.b	$02,$0C,$34,$F9,$08,$0C,$3F,$FD

; The next short run reuses the same compact prefix pattern but flips to an `FB 04 03`
; selector family whose local targets cluster in the 0x0A0C89-0x0A0D80 tuple band.
Bank080000_TableTargetedPayloadRecord_0A36AF:
	dc.b	$FC,$08,$08,$FB,$04,$03,$00,$0C,$89

Bank080000_TableTargetedPayloadRecord_0A36B8:
	dc.b	$FC,$08,$08,$FB,$04,$03,$FE,$06,$0C,$89,$06,$0C,$8F,$FF

Bank080000_TableTargetedPayloadRecord_0A36C6:
	dc.b	$FC,$08,$08,$FB,$04,$03,$00,$0C,$95

Bank080000_TableTargetedPayloadRecord_0A36CF:
	dc.b	$FC,$08,$08,$FB,$04,$03,$01,$0C,$9B,$01,$0C,$A1,$01,$0C,$A7,$01,$0C,$AD,$01,$0C,$B3,$03,$0C,$B9,$F8,$04,$0C,$89,$FD

Bank080000_TableTargetedPayloadRecord_0A36EC:
	dc.b	$FC,$08,$08,$FB,$04,$03,$00,$0C,$BF

Bank080000_TableTargetedPayloadRecord_0A36F5:
	dc.b	$FC,$08,$08,$FB,$04,$03,$10,$0C,$89,$FD

Bank080000_TableTargetedPayloadRecord_0A36FF:
	dc.b	$FC,$08,$08,$FB,$04,$03,$00,$0C,$C5

Bank080000_TableTargetedPayloadRecord_0A3708:
	dc.b	$FC,$08,$08,$FB,$04,$03,$00,$0C,$CB

Bank080000_TableTargetedPayloadRecord_0A3711:
	dc.b	$FC,$08,$08,$FB,$04,$03,$00,$0C,$DD

Bank080000_TableTargetedPayloadRecord_0A371A:
	dc.b	$FC,$08,$08,$FB,$04,$03,$00,$0C,$D7

Bank080000_TableTargetedPayloadRecord_0A3723:
	dc.b	$FC,$08,$08,$FB,$04,$03,$00,$0C,$D1

Bank080000_TableTargetedPayloadRecord_0A372C:
	dc.b	$03,$0C,$E3,$00,$0C,$E9

Bank080000_TableTargetedPayloadRecord_0A3732:
	dc.b	$FC,$08,$08,$00,$0C,$E9,$00,$0C,$E3

Bank080000_TableTargetedPayloadRecord_0A373B:
	dc.b	$06,$0C,$EF,$06,$0C,$F5,$0A,$0C,$FB,$FD,$06,$0C,$F5,$04,$0C,$EF,$FD

Bank080000_TableTargetedPayloadRecord_0A374C:
	dc.b	$00,$0D,$01

Bank080000_TableTargetedPayloadRecord_0A374F:
	dc.b	$06,$0D,$07,$06,$0D,$0D,$0A,$0D,$13,$FD,$06,$0D,$0D,$04,$0D,$07,$FD

Bank080000_TableTargetedPayloadRecord_0A3760:
	dc.b	$04,$0D,$19,$04,$0D,$24,$04,$0D,$2F,$0A,$0D,$3A,$FD,$04,$0D,$2F,$03,$0D,$24,$03,$0D,$19,$FD

Bank080000_TableTargetedPayloadRecord_0A3777:
	dc.b	$06,$0D,$45,$06,$0D,$4B,$0A,$0D,$51,$FD,$06,$0D,$4B,$04,$0D,$45,$FD

Bank080000_TableTargetedPayloadRecord_0A3788:
	dc.b	$06,$0D,$57,$06,$0D,$5D,$0A,$0D,$63,$FD,$06,$0D,$5D,$04,$0D,$57,$FD

Bank080000_TableTargetedPayloadRecord_0A3799:
	dc.b	$04,$0D,$69,$04,$0D,$6F,$04,$0D,$75,$0A,$0D,$80,$FD,$02,$0D,$75,$01,$0D,$6F,$01,$0D,$69,$FD
