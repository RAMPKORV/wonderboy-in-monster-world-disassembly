; ROM range: 0x099200-0x09991F
; Pre-descriptor structural tail inside the 0x098000-0x09F776 non-fill island.
;
; The front 0x80 bytes tighten into two monotone byte bands, followed by 51 fixed 19-byte
; records at 0x099280-0x099648 whose third/fourth bytes are usually one of F0C0/D0C0/B0C0.
; The later bytes now tighten further too: a 30-record fixed 16-byte band at 0x099649,
; then a short 3-byte lead-in plus 20 fixed 5-byte records at 0x099829, before the local-
; offset word list, packed byte band, repeated 0x01F1 words, and final word trailer leading
; into the already split descriptor records at 0x099920.

Bank080000_PreDescriptorMonotoneByteBandA_099200:
	dc.b	$00,$00,$00,$00,$01,$01,$01,$02,$02,$03,$03,$04,$05,$05,$06,$07
	dc.b	$08,$09,$0A,$0B,$0D,$0F,$10,$12,$14,$18,$18,$1A,$1C,$1F,$21,$23
	dc.b	$26,$28,$2A,$2C,$2E,$30,$32,$34,$36,$38,$3A,$3C,$40,$41,$42,$43
	dc.b	$44,$45,$46,$47,$48,$49,$4A,$4B,$4B,$4B,$4C,$4C,$4D,$4D,$4E,$7F

Bank080000_PreDescriptorMonotoneByteBandB_099240:
	dc.b	$00,$00,$08,$08,$08,$10,$10,$18,$18,$18,$20,$20,$28,$28,$28,$30
	dc.b	$30,$30,$38,$38,$38,$38,$38,$40,$40,$40,$40,$40,$40,$48,$48,$48
	dc.b	$48,$48,$48,$48,$50,$50,$50,$50,$50,$50,$50,$50,$58,$58,$58,$58
	dc.b	$58,$58,$58,$58,$58,$60,$60,$60,$60,$60,$60,$60,$68,$68,$70,$78

Bank080000_PreDescriptorRecordBand_099280:
Bank080000_PreDescriptorRecord_099280:
	dc.b	$33,$0C,$F0,$C0,$21,$02,$05,$08,$01,$06
	dc.b	$24,$77,$05,$0C,$72,$06,$00,$F4,$00

Bank080000_PreDescriptorRecord_099293:
	dc.b	$00,$05,$F0,$C0,$18,$04,$07,$18,$03,$07
	dc.b	$13,$02,$07,$13,$01,$07,$00,$F4,$05

Bank080000_PreDescriptorRecord_0992A6:
	dc.b	$00,$3C,$F0,$C0,$14,$01,$08,$18,$02,$09
	dc.b	$1F,$01,$0A,$18,$02,$09,$00,$F4,$05

Bank080000_PreDescriptorRecord_0992B9:
	dc.b	$00,$05,$F0,$C0,$2B,$01,$07,$14,$08,$0B
	dc.b	$17,$04,$0B,$11,$01,$0B,$00,$F4,$00

Bank080000_PreDescriptorRecord_0992CC:
	dc.b	$00,$34,$F0,$C0,$1F,$3F,$0C,$0F,$01,$0D
	dc.b	$1F,$01,$0E,$16,$01,$0F,$00,$F4,$00

Bank080000_PreDescriptorRecord_0992DF:
	dc.b	$00,$34,$F0,$C0,$1A,$31,$10,$11,$52,$11
	dc.b	$20,$50,$12,$0B,$30,$11,$00,$F4,$05

Bank080000_PreDescriptorRecord_0992F2:
	dc.b	$00,$33,$F0,$C0,$16,$01,$13,$13,$02,$14
	dc.b	$1D,$01,$15,$05,$02,$16,$00,$E8,$00

Bank080000_PreDescriptorRecord_099305:
	dc.b	$00,$03,$F0,$C0,$26,$0A,$13,$25,$03,$17
	dc.b	$08,$02,$18,$0C,$01,$19,$00,$E8,$00

Bank080000_PreDescriptorRecord_099318:
	dc.b	$00,$38,$F0,$C0,$25,$02,$1A,$0B,$00,$1B
	dc.b	$0D,$00,$1C,$0C,$01,$1D,$00,$F4,$00

Bank080000_PreDescriptorRecord_09932B:
	dc.b	$00,$09,$F0,$C0,$16,$0F,$1E,$30,$04,$1F
	dc.b	$20,$01,$20,$0C,$01,$21,$00,$E8,$00

Bank080000_PreDescriptorRecord_09933E:
	dc.b	$00,$3B,$F0,$C0,$01,$14,$22,$15,$03,$23
	dc.b	$08,$02,$24,$10,$01,$25,$00,$F4,$00

Bank080000_PreDescriptorRecord_099351:
	dc.b	$00,$3C,$F0,$C0,$28,$0E,$26,$15,$02,$27
	dc.b	$1E,$04,$28,$0C,$02,$29,$00,$F4,$00

Bank080000_PreDescriptorRecord_099364:
	dc.b	$00,$03,$F0,$C0,$0B,$02,$2A,$0D,$01,$2B
	dc.b	$23,$0B,$2A,$00,$01,$2C,$00,$00,$00

Bank080000_PreDescriptorRecord_099377:
	dc.b	$00,$3D,$F0,$C0,$10,$01,$2D,$00,$01,$2E
	dc.b	$03,$02,$2F,$07,$09,$2F,$00,$00,$00

Bank080000_PreDescriptorRecord_09938A:
	dc.b	$00,$2B,$F0,$C0,$1D,$61,$30,$20,$02,$30
	dc.b	$36,$23,$30,$00,$02,$31,$00,$00,$00

Bank080000_PreDescriptorRecord_09939D:
	dc.b	$00,$04,$F0,$C0,$16,$07,$32,$00,$05,$33
	dc.b	$20,$79,$32,$00,$71,$33,$00,$00,$00

Bank080000_PreDescriptorRecord_0993B0:
	dc.b	$00,$3C,$F0,$C0,$07,$0F,$34,$08,$00,$35
	dc.b	$16,$02,$36,$00,$00,$37,$00,$00,$00

Bank080000_PreDescriptorRecord_0993C3:
	dc.b	$00,$00,$F0,$C0,$2D,$02,$38,$1D,$0F,$39
	dc.b	$10,$03,$3A,$07,$01,$3B,$00,$00,$02

Bank080000_PreDescriptorRecord_0993D6:
	dc.b	$00,$3B,$F0,$C0,$05,$0C,$3C,$0A,$07,$3D
	dc.b	$1D,$79,$3E,$00,$72,$3F,$00,$00,$00

Bank080000_PreDescriptorRecord_0993E9:
	dc.b	$00,$39,$D0,$C0,$00,$01,$40,$7F,$00,$00
	dc.b	$2E,$79,$41,$0C,$78,$42,$00,$00,$00

Bank080000_PreDescriptorRecord_0993FC:
	dc.b	$00,$39,$B0,$C0,$00,$01,$40,$7F,$00,$00
	dc.b	$2C,$79,$41,$08,$78,$43,$00,$00,$00

Bank080000_PreDescriptorRecord_09940F:
	dc.b	$00,$3C,$F0,$C0,$28,$02,$44,$0C,$01,$45
	dc.b	$28,$72,$44,$18,$71,$45,$00,$00,$00

Bank080000_PreDescriptorRecord_099422:
	dc.b	$00,$04,$F0,$C0,$12,$14,$46,$16,$14,$47
	dc.b	$12,$08,$46,$16,$04,$47,$00,$00,$00

Bank080000_PreDescriptorRecord_099435:
	dc.b	$00,$04,$F0,$C0,$07,$06,$48,$03,$01,$49
	dc.b	$15,$01,$4A,$03,$00,$4B,$00,$00,$02

Bank080000_PreDescriptorRecord_099448:
	dc.b	$00,$3B,$F0,$C0,$00,$08,$4C,$20,$0F,$4D
	dc.b	$3D,$0F,$4E,$04,$0C,$4F,$00,$00,$00

Bank080000_PreDescriptorRecord_09945B:
	dc.b	$00,$3B,$F0,$C0,$00,$08,$4C,$20,$0F,$4D
	dc.b	$3D,$0F,$4E,$06,$0C,$50,$00,$00,$00

Bank080000_PreDescriptorRecord_09946E:
	dc.b	$00,$3B,$F0,$C0,$04,$03,$4C,$06,$01,$4D
	dc.b	$22,$04,$4E,$05,$00,$51,$00,$00,$00

Bank080000_PreDescriptorRecord_099481:
	dc.b	$00,$39,$F0,$C0,$10,$0D,$52,$25,$06,$52
	dc.b	$23,$01,$52,$00,$01,$53,$00,$00,$00

Bank080000_PreDescriptorRecord_099494:
	dc.b	$00,$14,$F0,$C0,$2A,$0D,$54,$10,$04,$55
	dc.b	$2C,$76,$54,$10,$71,$55,$00,$F4,$01

Bank080000_PreDescriptorRecord_0994A7:
	dc.b	$00,$0C,$F0,$C0,$2C,$03,$05,$10,$01,$56
	dc.b	$24,$7E,$05,$08,$48,$57,$00,$F4,$01

Bank080000_PreDescriptorRecord_0994BA:
	dc.b	$00,$39,$D0,$C0,$00,$01,$40,$7F,$00,$00
	dc.b	$2C,$79,$41,$08,$78,$43,$00,$00,$00

Bank080000_PreDescriptorRecord_0994CD:
	dc.b	$00,$0C,$F0,$C0,$22,$44,$58,$13,$43,$59
	dc.b	$1C,$72,$59,$10,$01,$5A,$00,$F4,$00

Bank080000_PreDescriptorRecord_0994E0:
	dc.b	$00,$14,$F0,$C0,$1A,$01,$5B,$10,$61,$5C
	dc.b	$1C,$67,$5D,$10,$01,$5E,$00,$F4,$00

Bank080000_PreDescriptorRecord_0994F3:
	dc.b	$00,$3C,$F0,$C0,$1C,$72,$5F,$13,$72,$60
	dc.b	$21,$34,$5F,$13,$32,$60,$00,$E8,$01

Bank080000_PreDescriptorRecord_099506:
	dc.b	$00,$22,$F0,$C0,$28,$75,$61,$32,$43,$62
	dc.b	$1A,$20,$61,$10,$30,$63,$00,$00,$01

Bank080000_PreDescriptorRecord_099519:
	dc.b	$00,$12,$F0,$C0,$20,$51,$64,$2B,$05,$65
	dc.b	$28,$30,$66,$0C,$30,$67,$00,$00,$00

Bank080000_PreDescriptorRecord_09952C:
	dc.b	$00,$3C,$F0,$C0,$2A,$3C,$68,$12,$21,$69
	dc.b	$20,$31,$68,$10,$71,$6A,$00,$F4,$00

Bank080000_PreDescriptorRecord_09953F:
	dc.b	$00,$12,$F0,$C0,$2F,$51,$64,$28,$05,$65
	dc.b	$24,$30,$66,$0F,$31,$6B,$00,$00,$00

Bank080000_PreDescriptorRecord_099552:
	dc.b	$00,$04,$F0,$C0,$07,$06,$48,$0C,$01,$49
	dc.b	$15,$01,$4A,$0C,$00,$4B,$00,$F4,$01

Bank080000_PreDescriptorRecord_099565:
	dc.b	$00,$28,$F0,$C0,$1F,$08,$6C,$22,$33,$6D
	dc.b	$28,$03,$5E,$0C,$01,$5C,$00,$F4,$01

Bank080000_PreDescriptorRecord_099578:
	dc.b	$00,$3A,$F0,$C0,$20,$34,$6E,$18,$62,$6F
	dc.b	$18,$34,$70,$12,$32,$71,$00,$E8,$05

Bank080000_PreDescriptorRecord_09958B:
	dc.b	$00,$3E,$F0,$C0,$24,$74,$72,$16,$01,$73
	dc.b	$0F,$71,$73,$0F,$02,$73,$00,$F4,$05

Bank080000_PreDescriptorRecord_09959E:
	dc.b	$00,$12,$F0,$C0,$2F,$51,$64,$28,$05,$65
	dc.b	$24,$30,$66,$0F,$31,$6B,$00,$00,$08

Bank080000_PreDescriptorRecord_0995B1:
	dc.b	$00,$3E,$F0,$C0,$24,$74,$72,$16,$01,$73
	dc.b	$0F,$71,$73,$0F,$02,$73,$00,$F4,$09

Bank080000_PreDescriptorRecord_0995C4:
	dc.b	$00,$3B,$F0,$C0,$01,$14,$22,$15,$03,$23
	dc.b	$08,$02,$24,$0C,$01,$25,$00,$F4,$0A

Bank080000_PreDescriptorRecord_0995D7:
	dc.b	$00,$3C,$F0,$C0,$15,$03,$34,$06,$06,$35
	dc.b	$16,$0B,$36,$02,$01,$37,$00,$00,$00

Bank080000_PreDescriptorRecord_0995EA:
	dc.b	$00,$30,$F0,$C0,$10,$30,$74,$04,$31,$75
	dc.b	$20,$31,$75,$04,$31,$39,$00,$0C,$00

Bank080000_PreDescriptorRecord_0995FD:
	dc.b	$00,$04,$F0,$C0,$1C,$06,$48,$04,$01,$76
	dc.b	$15,$01,$4A,$04,$00,$76,$00,$F4,$0A

Bank080000_PreDescriptorRecord_099610:
	dc.b	$00,$33,$F0,$C0,$16,$01,$13,$13,$02,$14
	dc.b	$1D,$01,$15,$05,$02,$16,$00,$00,$0B

Bank080000_PreDescriptorRecord_099623:
	dc.b	$00,$33,$F0,$C0,$16,$01,$13,$23,$02,$14
	dc.b	$1D,$0F,$15,$00,$0F,$16,$00,$00,$0C

Bank080000_PreDescriptorRecord_099636:
	dc.b	$00,$38,$F0,$C0,$00,$07,$57,$00,$03,$44
	dc.b	$00,$01,$57,$08,$00,$52,$00,$00,$0A

Bank080000_PreDescriptorFixedSixteenByteRecordBand_099649:
Bank080000_PreDescriptorFixedSixteenByteRecord_099649:
	dc.b	$00,$5F,$00,$00,$00,$00,$1F,$04
	dc.b	$04,$35,$1F,$12,$04,$64,$1F,$18

Bank080000_PreDescriptorFixedSixteenByteRecord_099659:
	dc.b	$00,$2E,$00,$00,$00,$00,$1F,$04
	dc.b	$04,$35,$1F,$12,$04,$64,$1F,$18

Bank080000_PreDescriptorFixedSixteenByteRecord_099669:
	dc.b	$00,$2E,$1A,$12,$00,$29,$1D,$80
	dc.b	$00,$4B,$1F,$87,$00,$99,$50,$0E

Bank080000_PreDescriptorFixedSixteenByteRecord_099679:
	dc.b	$00,$18,$1F,$11,$04,$8B,$1B,$08
	dc.b	$0C,$87,$1E,$07,$04,$47,$1E,$0B

Bank080000_PreDescriptorFixedSixteenByteRecord_099689:
	dc.b	$00,$F8,$1F,$1F,$00,$03,$11,$1F
	dc.b	$00,$07,$11,$1F,$00,$0F,$97,$0F

Bank080000_PreDescriptorFixedSixteenByteRecord_099699:
	dc.b	$00,$C0,$97,$11,$11,$4E,$5F,$07
	dc.b	$07,$BF,$1F,$18,$09,$29,$5F,$0F

Bank080000_PreDescriptorFixedSixteenByteRecord_0996A9:
	dc.b	$02,$96,$9B,$15,$04,$76,$1F,$1C
	dc.b	$06,$08,$5A,$0D,$03,$5C,$58,$17

Bank080000_PreDescriptorFixedSixteenByteRecord_0996B9:
	dc.b	$0E,$3A,$9E,$17,$07,$58,$9E,$0D
	dc.b	$0C,$37,$5F,$18,$00,$FF,$1F,$0B

Bank080000_PreDescriptorFixedSixteenByteRecord_0996C9:
	dc.b	$00,$FF,$5F,$07,$02,$88,$1F,$09
	dc.b	$02,$88,$17,$97,$03,$77,$1F,$87

Bank080000_PreDescriptorFixedSixteenByteRecord_0996D9:
	dc.b	$01,$94,$5B,$94,$01,$74,$1F,$97
	dc.b	$01,$08,$56,$0D,$03,$5C,$94,$17

Bank080000_PreDescriptorFixedSixteenByteRecord_0996E9:
	dc.b	$0E,$0A,$9E,$0F,$05,$67,$5B,$0C
	dc.b	$0A,$36,$1F,$17,$0F,$0D,$5F,$17

Bank080000_PreDescriptorFixedSixteenByteRecord_0996F9:
	dc.b	$0F,$2E,$5F,$0D,$0D,$2A,$97,$0F
	dc.b	$04,$48,$1D,$01,$01,$18,$1D,$01

Bank080000_PreDescriptorFixedSixteenByteRecord_099709:
	dc.b	$01,$28,$19,$03,$00,$22,$0D,$05
	dc.b	$00,$27,$1F,$07,$00,$A0,$1F,$0F

Bank080000_PreDescriptorFixedSixteenByteRecord_099719:
	dc.b	$04,$37,$1F,$16,$04,$18,$1A,$11
	dc.b	$11,$9C,$1D,$12,$13,$98,$1B,$0F

Bank080000_PreDescriptorFixedSixteenByteRecord_099729:
	dc.b	$0F,$29,$1F,$0E,$0C,$5B,$1B,$09
	dc.b	$06,$74,$9F,$0D,$04,$54,$18,$0F

Bank080000_PreDescriptorFixedSixteenByteRecord_099739:
	dc.b	$0B,$36,$1F,$18,$1B,$7F,$1F,$02
	dc.b	$01,$2D,$1F,$07,$00,$A7,$1A,$12

Bank080000_PreDescriptorFixedSixteenByteRecord_099749:
	dc.b	$16,$3D,$1F,$18,$1B,$7F,$1F,$07
	dc.b	$00,$A7,$1D,$10,$00,$8D,$1F,$12

Bank080000_PreDescriptorFixedSixteenByteRecord_099759:
	dc.b	$12,$5D,$1F,$0C,$0C,$DF,$1F,$14
	dc.b	$1A,$DD,$1F,$09,$02,$CB,$1F,$10

Bank080000_PreDescriptorFixedSixteenByteRecord_099769:
	dc.b	$14,$DB,$1F,$1B,$07,$89,$1F,$13
	dc.b	$11,$39,$1F,$11,$02,$25,$1F,$11

Bank080000_PreDescriptorFixedSixteenByteRecord_099779:
	dc.b	$0B,$45,$1F,$1F,$00,$16,$1F,$1F
	dc.b	$04,$16,$1F,$1C,$00,$06,$5F,$11

Bank080000_PreDescriptorFixedSixteenByteRecord_099789:
	dc.b	$04,$D8,$5F,$14,$0B,$18,$5F,$10
	dc.b	$10,$5D,$1F,$0C,$0A,$1F,$1B,$15

Bank080000_PreDescriptorFixedSixteenByteRecord_099799:
	dc.b	$17,$CF,$59,$0F,$0E,$79,$57,$10
	dc.b	$08,$47,$1D,$11,$02,$46,$5F,$12

Bank080000_PreDescriptorFixedSixteenByteRecord_0997A9:
	dc.b	$02,$96,$1F,$1F,$05,$56,$12,$11
	dc.b	$08,$27,$12,$10,$07,$07,$59,$1C

Bank080000_PreDescriptorFixedSixteenByteRecord_0997B9:
	dc.b	$00,$E6,$5F,$0C,$00,$E6,$5F,$03
	dc.b	$00,$E6,$1F,$0E,$00,$E7,$1F,$01

Bank080000_PreDescriptorFixedSixteenByteRecord_0997C9:
	dc.b	$01,$14,$10,$03,$01,$26,$12,$04
	dc.b	$03,$25,$0D,$08,$00,$37,$10,$08

Bank080000_PreDescriptorFixedSixteenByteRecord_0997D9:
	dc.b	$00,$06,$58,$01,$03,$05,$DB,$05
	dc.b	$01,$05,$96,$01,$01,$D6,$96,$0A

Bank080000_PreDescriptorFixedSixteenByteRecord_0997E9:
	dc.b	$01,$36,$9A,$04,$09,$25,$9A,$0C
	dc.b	$08,$26,$96,$09,$07,$27,$4F,$01

Bank080000_PreDescriptorFixedSixteenByteRecord_0997F9:
	dc.b	$05,$D6,$5F,$09,$00,$06,$5F,$0A
	dc.b	$00,$09,$1F,$14,$06,$05,$1F,$10

Bank080000_PreDescriptorFixedSixteenByteRecord_099809:
	dc.b	$00,$09,$1F,$05,$05,$86,$5C,$1A
	dc.b	$00,$06,$1F,$00,$06,$04,$0F,$08

Bank080000_PreDescriptorFixedSixteenByteRecord_099819:
	dc.b	$08,$07,$1F,$08,$08,$3E,$1F,$05
	dc.b	$06,$2E,$1F,$0C,$14,$45,$11,$4F

Bank080000_PreDescriptorCompactRecordLeadIn_099829:
	dc.b	$01,$01,$00

Bank080000_PreDescriptorCompactFiveByteRecordBand_09982C:
Bank080000_PreDescriptorCompactFiveByteRecord_09982C:
	dc.b	$00,$00,$60,$11,$15

Bank080000_PreDescriptorCompactFiveByteRecord_099831:
	dc.b	$01,$01,$00,$68,$18

Bank080000_PreDescriptorCompactFiveByteRecord_099836:
	dc.b	$08,$01,$00,$00,$60

Bank080000_PreDescriptorCompactFiveByteRecord_09983B:
	dc.b	$03,$01,$05,$00,$00

Bank080000_PreDescriptorCompactFiveByteRecord_099840:
	dc.b	$70,$02,$05,$02,$00

Bank080000_PreDescriptorCompactFiveByteRecord_099845:
	dc.b	$00,$7F,$05,$01,$01

Bank080000_PreDescriptorCompactFiveByteRecord_09984A:
	dc.b	$00,$00,$68,$01,$01

Bank080000_PreDescriptorCompactFiveByteRecord_09984F:
	dc.b	$01,$03,$00,$68,$01

Bank080000_PreDescriptorCompactFiveByteRecord_099854:
	dc.b	$01,$02,$04,$00,$68

Bank080000_PreDescriptorCompactFiveByteRecord_099859:
	dc.b	$01,$01,$02,$06,$00

Bank080000_PreDescriptorCompactFiveByteRecord_09985E:
	dc.b	$68,$01,$08,$06,$00

Bank080000_PreDescriptorCompactFiveByteRecord_099863:
	dc.b	$00,$68,$01,$08,$03

Bank080000_PreDescriptorCompactFiveByteRecord_099868:
	dc.b	$07,$00,$60,$03,$02

Bank080000_PreDescriptorCompactFiveByteRecord_09986D:
	dc.b	$06,$0A,$00,$68,$01

Bank080000_PreDescriptorCompactFiveByteRecord_099872:
	dc.b	$04,$03,$0A,$00,$68

Bank080000_PreDescriptorCompactFiveByteRecord_099877:
	dc.b	$01,$01,$00,$0B,$00

Bank080000_PreDescriptorCompactFiveByteRecord_09987C:
	dc.b	$68,$01,$04,$00,$0A

Bank080000_PreDescriptorCompactFiveByteRecord_099881:
	dc.b	$00,$68,$01,$11,$03

Bank080000_PreDescriptorCompactFiveByteRecord_099886:
	dc.b	$03,$00,$68,$01,$11

Bank080000_PreDescriptorCompactFiveByteRecord_09988B:
	dc.b	$07,$0D,$00,$08,$9F

Bank080000_PreDescriptorLocalOffsetWordBand_099890:
	dc.w	$18AD,$18B6,$18C6,$18DA,$18E2,$18F3,$18F7,$1807

Bank080000_PreDescriptorPackedByteBand_0998A0:
	dc.b	$15,$25,$35,$45,$5F,$6F,$7F,$8F,$9F,$AF,$BF,$CF,$D0,$32,$22,$12
	dc.b	$08,$14,$24,$34,$44,$50,$03,$13,$23,$31,$41,$51,$61,$71,$81,$91
	dc.b	$A1,$B1,$C1,$D1,$E1,$F0,$41,$31,$21,$11,$08,$1F,$1F,$2F,$2F,$3F
	dc.b	$3F,$4F,$5F,$6F,$7F,$8F,$9F,$AF,$BF,$C0

Bank080000_PreDescriptorZeroFill_0998DA:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00

Bank080000_PreDescriptorRepeatedWordBand_0998E2:
	dc.w	$01F1,$01F1,$01F1,$01F1,$01F1,$01F1,$01F1,$01F1

Bank080000_PreDescriptorByteTrailer_0998F2:
	dc.b	$00,$03,$13,$23,$30,$A2,$92,$84,$74,$68,$58,$48,$38,$20

Bank080000_PreDescriptorWordTail_099900:
	dc.w	$0E1D,$191E,$192B,$192F,$193F,$1952,$197D,$199E
	dc.w	$19A7,$19B2,$19BE,$19C7,$19CD,$19D3,$1900

Bank080000_PreDescriptorWordTrailer_09991E:
	dc.w	$F904
