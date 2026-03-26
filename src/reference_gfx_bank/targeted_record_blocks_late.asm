; ROM range: 0x04E5AA-0x05FC2F
; Continued local-target payload window reached from the same flagged ROM-reference
; table at 0x041000-0x0418AB. This span now calls out both the isolated 0x05C5DA 0x4C0-byte
; record and the later eight-record 0x05D630-0x05FC2F family.
;
; Those dedicated child modules now use graphics-oriented ownership because the repeated
; 0x4C0-byte records consistently parse as 38-tile 4bpp planar art blocks. The shared
; table/loader path is still unresolved, so the names stay at tile-family level rather than
; forcing a map, font, sprite-set, or UI-specific subsystem guess.

Bank040000_LocalTableTargetedPayloadRecord_04E5AA:
	incbin "data/rom/bank_040000_07ffff.bin",$00E5AA,$0001EC

Bank040000_LocalTableTargetedPayloadRecord_04E796:
	incbin "data/rom/bank_040000_07ffff.bin",$00E796,$0001C6

Bank040000_LocalTableTargetedPayloadRecord_04E95C:
	incbin "data/rom/bank_040000_07ffff.bin",$00E95C,$00023B

Bank040000_LocalTableTargetedPayloadRecord_04EB97:
	incbin "data/rom/bank_040000_07ffff.bin",$00EB97,$000199

Bank040000_LocalTableTargetedPayloadRecord_04ED30:
	incbin "data/rom/bank_040000_07ffff.bin",$00ED30,$00022C

Bank040000_LocalTableTargetedPayloadRecord_04EF5C:
	incbin "data/rom/bank_040000_07ffff.bin",$00EF5C,$0001CC

Bank040000_LocalTableTargetedPayloadRecord_04F128:
	incbin "data/rom/bank_040000_07ffff.bin",$00F128,$0001AA

Bank040000_LocalTableTargetedPayloadRecord_04F2D2:
	incbin "data/rom/bank_040000_07ffff.bin",$00F2D2,$000182

Bank040000_LocalTableTargetedPayloadRecord_04F454:
	incbin "data/rom/bank_040000_07ffff.bin",$00F454,$00018E

Bank040000_LocalTableTargetedPayloadRecord_04F5E2:
	incbin "data/rom/bank_040000_07ffff.bin",$00F5E2,$0001FA

Bank040000_LocalTableTargetedPayloadRecord_04F7DC:
	incbin "data/rom/bank_040000_07ffff.bin",$00F7DC,$000122

Bank040000_LocalTableTargetedPayloadRecord_04F8FE:
	incbin "data/rom/bank_040000_07ffff.bin",$00F8FE,$000215

Bank040000_LocalTableTargetedPayloadRecord_04FB13:
	incbin "data/rom/bank_040000_07ffff.bin",$00FB13,$00025E

Bank040000_LocalTableTargetedPayloadRecord_04FD71:
	incbin "data/rom/bank_040000_07ffff.bin",$00FD71,$000167

Bank040000_LocalTableTargetedPayloadRecord_04FED8:
	incbin "data/rom/bank_040000_07ffff.bin",$00FED8,$0001A8

Bank040000_LocalTableTargetedPayloadRecord_050080:
	incbin "data/rom/bank_040000_07ffff.bin",$010080,$0001B9

Bank040000_LocalTableTargetedPayloadRecord_050239:
	incbin "data/rom/bank_040000_07ffff.bin",$010239,$000182

Bank040000_LocalTableTargetedPayloadRecord_0503BB:
	incbin "data/rom/bank_040000_07ffff.bin",$0103BB,$0000FF

Bank040000_LocalTableTargetedPayloadRecord_0504BA:
	incbin "data/rom/bank_040000_07ffff.bin",$0104BA,$0000EB

Bank040000_LocalTableTargetedPayloadRecord_0505A5:
	incbin "data/rom/bank_040000_07ffff.bin",$0105A5,$0001E2

Bank040000_LocalTableTargetedPayloadRecord_050787:
	incbin "data/rom/bank_040000_07ffff.bin",$010787,$0001CD

Bank040000_LocalTableTargetedPayloadRecord_050954:
	incbin "data/rom/bank_040000_07ffff.bin",$010954,$0001A6

Bank040000_LocalTableTargetedPayloadRecord_050AFA:
	incbin "data/rom/bank_040000_07ffff.bin",$010AFA,$0001D5

Bank040000_LocalTableTargetedPayloadRecord_050CCF:
	incbin "data/rom/bank_040000_07ffff.bin",$010CCF,$00016B

Bank040000_LocalTableTargetedPayloadRecord_050E3A:
	incbin "data/rom/bank_040000_07ffff.bin",$010E3A,$00018B

Bank040000_LocalTableTargetedPayloadRecord_050FC5:
	incbin "data/rom/bank_040000_07ffff.bin",$010FC5,$00022A

Bank040000_LocalTableTargetedPayloadRecord_0511EF:
	incbin "data/rom/bank_040000_07ffff.bin",$0111EF,$0001AC

Bank040000_LocalTableTargetedPayloadRecord_05139B:
	incbin "data/rom/bank_040000_07ffff.bin",$01139B,$00013F

Bank040000_LocalTableTargetedPayloadRecord_0514DA:
	incbin "data/rom/bank_040000_07ffff.bin",$0114DA,$000182

Bank040000_LocalTableTargetedPayloadRecord_05165C:
	incbin "data/rom/bank_040000_07ffff.bin",$01165C,$000146

Bank040000_LocalTableTargetedPayloadRecord_0517A2:
	incbin "data/rom/bank_040000_07ffff.bin",$0117A2,$0000FE

Bank040000_LocalTableTargetedPayloadRecord_0518A0:
	incbin "data/rom/bank_040000_07ffff.bin",$0118A0,$00017E

Bank040000_LocalTableTargetedPayloadRecord_051A1E:
	incbin "data/rom/bank_040000_07ffff.bin",$011A1E,$000273

Bank040000_LocalTableTargetedPayloadRecord_051C91:
	incbin "data/rom/bank_040000_07ffff.bin",$011C91,$0001AB

Bank040000_LocalTableTargetedPayloadRecord_051E3C:
	incbin "data/rom/bank_040000_07ffff.bin",$011E3C,$0001E1

Bank040000_LocalTableTargetedPayloadRecord_05201D:
	incbin "data/rom/bank_040000_07ffff.bin",$01201D,$00012D

Bank040000_LocalTableTargetedPayloadRecord_05214A:
	incbin "data/rom/bank_040000_07ffff.bin",$01214A,$0001BC

Bank040000_LocalTableTargetedPayloadRecord_052306:
	incbin "data/rom/bank_040000_07ffff.bin",$012306,$000122

Bank040000_LocalTableTargetedPayloadRecord_052428:
	incbin "data/rom/bank_040000_07ffff.bin",$012428,$0001BA

Bank040000_LocalTableTargetedPayloadRecord_0525E2:
	incbin "data/rom/bank_040000_07ffff.bin",$0125E2,$000176

Bank040000_LocalTableTargetedPayloadRecord_052758:
	incbin "data/rom/bank_040000_07ffff.bin",$012758,$0001C7

Bank040000_LocalTableTargetedPayloadRecord_05291F:
	incbin "data/rom/bank_040000_07ffff.bin",$01291F,$000156

Bank040000_LocalTableTargetedPayloadRecord_052A75:
	incbin "data/rom/bank_040000_07ffff.bin",$012A75,$000131

Bank040000_LocalTableTargetedPayloadRecord_052BA6:
	incbin "data/rom/bank_040000_07ffff.bin",$012BA6,$000126

Bank040000_LocalTableTargetedPayloadRecord_052CCC:
	incbin "data/rom/bank_040000_07ffff.bin",$012CCC,$000189

Bank040000_LocalTableTargetedPayloadRecord_052E55:
	incbin "data/rom/bank_040000_07ffff.bin",$012E55,$000141

Bank040000_LocalTableTargetedPayloadRecord_052F96:
	incbin "data/rom/bank_040000_07ffff.bin",$012F96,$000174

Bank040000_LocalTableTargetedPayloadRecord_05310A:
	incbin "data/rom/bank_040000_07ffff.bin",$01310A,$00013E

Bank040000_LocalTableTargetedPayloadRecord_053248:
	incbin "data/rom/bank_040000_07ffff.bin",$013248,$000169

Bank040000_LocalTableTargetedPayloadRecord_0533B1:
	incbin "data/rom/bank_040000_07ffff.bin",$0133B1,$00019B

Bank040000_LocalTableTargetedPayloadRecord_05354C:
	incbin "data/rom/bank_040000_07ffff.bin",$01354C,$000194

Bank040000_LocalTableTargetedPayloadRecord_0536E0:
	incbin "data/rom/bank_040000_07ffff.bin",$0136E0,$00017B

Bank040000_LocalTableTargetedPayloadRecord_05385B:
	incbin "data/rom/bank_040000_07ffff.bin",$01385B,$00012C

Bank040000_LocalTableTargetedPayloadRecord_053987:
	incbin "data/rom/bank_040000_07ffff.bin",$013987,$000177

Bank040000_LocalTableTargetedPayloadRecord_053AFE:
	incbin "data/rom/bank_040000_07ffff.bin",$013AFE,$000249

Bank040000_LocalTableTargetedPayloadRecord_053D47:
	incbin "data/rom/bank_040000_07ffff.bin",$013D47,$000207

Bank040000_LocalTableTargetedPayloadRecord_053F4E:
	incbin "data/rom/bank_040000_07ffff.bin",$013F4E,$000163

Bank040000_LocalTableTargetedPayloadRecord_0540B1:
	incbin "data/rom/bank_040000_07ffff.bin",$0140B1,$00011C

Bank040000_LocalTableTargetedPayloadRecord_0541CD:
	incbin "data/rom/bank_040000_07ffff.bin",$0141CD,$000199

Bank040000_LocalTableTargetedPayloadRecord_054366:
	incbin "data/rom/bank_040000_07ffff.bin",$014366,$000145

Bank040000_LocalTableTargetedPayloadRecord_0544AB:
	incbin "data/rom/bank_040000_07ffff.bin",$0144AB,$000150

Bank040000_LocalTableTargetedPayloadRecord_0545FB:
	incbin "data/rom/bank_040000_07ffff.bin",$0145FB,$0001EC

Bank040000_LocalTableTargetedPayloadRecord_0547E7:
	incbin "data/rom/bank_040000_07ffff.bin",$0147E7,$000221

Bank040000_LocalTableTargetedPayloadRecord_054A08:
	incbin "data/rom/bank_040000_07ffff.bin",$014A08,$000216

Bank040000_LocalTableTargetedPayloadRecord_054C1E:
	incbin "data/rom/bank_040000_07ffff.bin",$014C1E,$0001A5

Bank040000_LocalTableTargetedPayloadRecord_054DC3:
	incbin "data/rom/bank_040000_07ffff.bin",$014DC3,$00025E

Bank040000_LocalTableTargetedPayloadRecord_055021:
	incbin "data/rom/bank_040000_07ffff.bin",$015021,$000256

Bank040000_LocalTableTargetedPayloadRecord_055277:
	incbin "data/rom/bank_040000_07ffff.bin",$015277,$00021D

Bank040000_LocalTableTargetedPayloadRecord_055494:
	incbin "data/rom/bank_040000_07ffff.bin",$015494,$000180

Bank040000_LocalTableTargetedPayloadRecord_055614:
	incbin "data/rom/bank_040000_07ffff.bin",$015614,$000167

Bank040000_LocalTableTargetedPayloadRecord_05577B:
	incbin "data/rom/bank_040000_07ffff.bin",$01577B,$00011F

Bank040000_LocalTableTargetedPayloadRecord_05589A:
	incbin "data/rom/bank_040000_07ffff.bin",$01589A,$000153

Bank040000_LocalTableTargetedPayloadRecord_0559ED:
	incbin "data/rom/bank_040000_07ffff.bin",$0159ED,$0000F6

Bank040000_LocalTableTargetedPayloadRecord_055AE3:
	incbin "data/rom/bank_040000_07ffff.bin",$015AE3,$0000E7

Bank040000_LocalTableTargetedPayloadRecord_055BCA:
	incbin "data/rom/bank_040000_07ffff.bin",$015BCA,$0001B6

Bank040000_LocalTableTargetedPayloadRecord_055D80:
	incbin "data/rom/bank_040000_07ffff.bin",$015D80,$000177

Bank040000_LocalTableTargetedPayloadRecord_055EF7:
	incbin "data/rom/bank_040000_07ffff.bin",$015EF7,$00013B

Bank040000_LocalTableTargetedPayloadRecord_056032:
	incbin "data/rom/bank_040000_07ffff.bin",$016032,$000118

Bank040000_LocalTableTargetedPayloadRecord_05614A:
	incbin "data/rom/bank_040000_07ffff.bin",$01614A,$0001B6

Bank040000_LocalTableTargetedPayloadRecord_056300:
	incbin "data/rom/bank_040000_07ffff.bin",$016300,$000176

Bank040000_LocalTableTargetedPayloadRecord_056476:
	incbin "data/rom/bank_040000_07ffff.bin",$016476,$000213

Bank040000_LocalTableTargetedPayloadRecord_056689:
	incbin "data/rom/bank_040000_07ffff.bin",$016689,$00016B

Bank040000_LocalTableTargetedPayloadRecord_0567F4:
	incbin "data/rom/bank_040000_07ffff.bin",$0167F4,$00018D

Bank040000_LocalTableTargetedPayloadRecord_056981:
	incbin "data/rom/bank_040000_07ffff.bin",$016981,$000205

Bank040000_LocalTableTargetedPayloadRecord_056B86:
	incbin "data/rom/bank_040000_07ffff.bin",$016B86,$000285

Bank040000_LocalTableTargetedPayloadRecord_056E0B:
	incbin "data/rom/bank_040000_07ffff.bin",$016E0B,$00010C

Bank040000_LocalTableTargetedPayloadRecord_056F17:
	incbin "data/rom/bank_040000_07ffff.bin",$016F17,$000141

Bank040000_LocalTableTargetedPayloadRecord_057058:
	incbin "data/rom/bank_040000_07ffff.bin",$017058,$00019D

Bank040000_LocalTableTargetedPayloadRecord_0571F5:
	incbin "data/rom/bank_040000_07ffff.bin",$0171F5,$000167

Bank040000_LocalTableTargetedPayloadRecord_05735C:
	incbin "data/rom/bank_040000_07ffff.bin",$01735C,$00012F

Bank040000_LocalTableTargetedPayloadRecord_05748B:
	incbin "data/rom/bank_040000_07ffff.bin",$01748B,$0000F7

Bank040000_LocalTableTargetedPayloadRecord_057582:
	incbin "data/rom/bank_040000_07ffff.bin",$017582,$00014D

Bank040000_LocalTableTargetedPayloadRecord_0576CF:
	incbin "data/rom/bank_040000_07ffff.bin",$0176CF,$0001CA

Bank040000_LocalTableTargetedPayloadRecord_057899:
	incbin "data/rom/bank_040000_07ffff.bin",$017899,$000168

Bank040000_LocalTableTargetedPayloadRecord_057A01:
	incbin "data/rom/bank_040000_07ffff.bin",$017A01,$0001C2

Bank040000_LocalTableTargetedPayloadRecord_057BC3:
	incbin "data/rom/bank_040000_07ffff.bin",$017BC3,$000202

Bank040000_LocalTableTargetedPayloadRecord_057DC5:
	incbin "data/rom/bank_040000_07ffff.bin",$017DC5,$00015B

Bank040000_LocalTableTargetedPayloadRecord_057F20:
	incbin "data/rom/bank_040000_07ffff.bin",$017F20,$000165

Bank040000_LocalTableTargetedPayloadRecord_058085:
	incbin "data/rom/bank_040000_07ffff.bin",$018085,$000191

Bank040000_LocalTableTargetedPayloadRecord_058216:
	incbin "data/rom/bank_040000_07ffff.bin",$018216,$000096

Bank040000_LocalTableTargetedPayloadRecord_0582AC:
	incbin "data/rom/bank_040000_07ffff.bin",$0182AC,$0001F5

Bank040000_LocalTableTargetedPayloadRecord_0584A1:
	incbin "data/rom/bank_040000_07ffff.bin",$0184A1,$000205

Bank040000_LocalTableTargetedPayloadRecord_0586A6:
	incbin "data/rom/bank_040000_07ffff.bin",$0186A6,$0001AC

Bank040000_LocalTableTargetedPayloadRecord_058852:
	incbin "data/rom/bank_040000_07ffff.bin",$018852,$000254

Bank040000_LocalTableTargetedPayloadRecord_058AA6:
	incbin "data/rom/bank_040000_07ffff.bin",$018AA6,$000203

Bank040000_LocalTableTargetedPayloadRecord_058CA9:
	incbin "data/rom/bank_040000_07ffff.bin",$018CA9,$0001F3

Bank040000_LocalTableTargetedPayloadRecord_058E9C:
	incbin "data/rom/bank_040000_07ffff.bin",$018E9C,$0001CF

Bank040000_LocalTableTargetedPayloadRecord_05906B:
	incbin "data/rom/bank_040000_07ffff.bin",$01906B,$0002BC

Bank040000_LocalTableTargetedPayloadRecord_059327:
	incbin "data/rom/bank_040000_07ffff.bin",$019327,$000165

Bank040000_LocalTableTargetedPayloadRecord_05948C:
	incbin "data/rom/bank_040000_07ffff.bin",$01948C,$0001AA

Bank040000_LocalTableTargetedPayloadRecord_059636:
	incbin "data/rom/bank_040000_07ffff.bin",$019636,$0000B9

Bank040000_LocalTableTargetedPayloadRecord_0596EF:
	incbin "data/rom/bank_040000_07ffff.bin",$0196EF,$0000DF

Bank040000_LocalTableTargetedPayloadRecord_0597CE:
	incbin "data/rom/bank_040000_07ffff.bin",$0197CE,$00022A

Bank040000_LocalTableTargetedPayloadRecord_0599F8:
	incbin "data/rom/bank_040000_07ffff.bin",$0199F8,$0000EA

Bank040000_LocalTableTargetedPayloadRecord_059AE2:
	incbin "data/rom/bank_040000_07ffff.bin",$019AE2,$000177

Bank040000_LocalTableTargetedPayloadRecord_059C59:
	incbin "data/rom/bank_040000_07ffff.bin",$019C59,$000206

Bank040000_LocalTableTargetedPayloadRecord_059E5F:
	incbin "data/rom/bank_040000_07ffff.bin",$019E5F,$000120

Bank040000_LocalTableTargetedPayloadRecord_059F7F:
	incbin "data/rom/bank_040000_07ffff.bin",$019F7F,$00009C

Bank040000_LocalTableTargetedPayloadRecord_05A01B:
	incbin "data/rom/bank_040000_07ffff.bin",$01A01B,$000179

Bank040000_LocalTableTargetedPayloadRecord_05A194:
	incbin "data/rom/bank_040000_07ffff.bin",$01A194,$000138

Bank040000_LocalTableTargetedPayloadRecord_05A2CC:
	incbin "data/rom/bank_040000_07ffff.bin",$01A2CC,$00012B

Bank040000_LocalTableTargetedPayloadRecord_05A3F7:
	incbin "data/rom/bank_040000_07ffff.bin",$01A3F7,$00018D

Bank040000_LocalTableTargetedPayloadRecord_05A584:
	incbin "data/rom/bank_040000_07ffff.bin",$01A584,$0001C0

Bank040000_LocalTableTargetedPayloadRecord_05A744:
	incbin "data/rom/bank_040000_07ffff.bin",$01A744,$0001B7

Bank040000_LocalTableTargetedPayloadRecord_05A8FB:
	incbin "data/rom/bank_040000_07ffff.bin",$01A8FB,$0001E9

Bank040000_LocalTableTargetedPayloadRecord_05AAE4:
	incbin "data/rom/bank_040000_07ffff.bin",$01AAE4,$000209

Bank040000_LocalTableTargetedPayloadRecord_05ACED:
	incbin "data/rom/bank_040000_07ffff.bin",$01ACED,$000180

Bank040000_LocalTableTargetedPayloadRecord_05AE6D:
	incbin "data/rom/bank_040000_07ffff.bin",$01AE6D,$000202

Bank040000_LocalTableTargetedPayloadRecord_05B06F:
	incbin "data/rom/bank_040000_07ffff.bin",$01B06F,$00024F

Bank040000_LocalTableTargetedPayloadRecord_05B2BE:
	incbin "data/rom/bank_040000_07ffff.bin",$01B2BE,$00023A

Bank040000_LocalTableTargetedPayloadRecord_05B4F8:
	incbin "data/rom/bank_040000_07ffff.bin",$01B4F8,$000105

Bank040000_LocalTableTargetedPayloadRecord_05B5FD:
	incbin "data/rom/bank_040000_07ffff.bin",$01B5FD,$00014E

Bank040000_LocalTableTargetedPayloadRecord_05B74B:
	incbin "data/rom/bank_040000_07ffff.bin",$01B74B,$0000FA

Bank040000_LocalTableTargetedPayloadRecord_05B845:
	incbin "data/rom/bank_040000_07ffff.bin",$01B845,$00011A

Bank040000_LocalTableTargetedPayloadRecord_05B95F:
	incbin "data/rom/bank_040000_07ffff.bin",$01B95F,$00008B

Bank040000_LocalTableTargetedPayloadRecord_05B9EA:
	incbin "data/rom/bank_040000_07ffff.bin",$01B9EA,$000166

Bank040000_LocalTableTargetedPayloadRecord_05BB50:
	incbin "data/rom/bank_040000_07ffff.bin",$01BB50,$0000CA

Bank040000_LocalTableTargetedPayloadRecord_05BC1A:
	incbin "data/rom/bank_040000_07ffff.bin",$01BC1A,$00016B

Bank040000_LocalTableTargetedPayloadRecord_05BD85:
	incbin "data/rom/bank_040000_07ffff.bin",$01BD85,$0001DA

Bank040000_LocalTableTargetedPayloadRecord_05BF5F:
	incbin "data/rom/bank_040000_07ffff.bin",$01BF5F,$000205

Bank040000_LocalTableTargetedPayloadRecord_05C164:
	incbin "data/rom/bank_040000_07ffff.bin",$01C164,$0001E6

Bank040000_LocalTableTargetedPayloadRecord_05C34A:
	incbin "data/rom/bank_040000_07ffff.bin",$01C34A,$000290

	include "src/reference_gfx_bank/planar_tile_block_05c5da.asm"

Bank040000_LocalTableTargetedPayloadRecord_05CA9A:
	incbin "data/rom/bank_040000_07ffff.bin",$01CA9A,$000170

Bank040000_LocalTableTargetedPayloadRecord_05CC0A:
	incbin "data/rom/bank_040000_07ffff.bin",$01CC0A,$000118

Bank040000_LocalTableTargetedPayloadRecord_05CD22:
	incbin "data/rom/bank_040000_07ffff.bin",$01CD22,$0000EC

Bank040000_LocalTableTargetedPayloadRecord_05CE0E:
	incbin "data/rom/bank_040000_07ffff.bin",$01CE0E,$0000C5

Bank040000_LocalTableTargetedPayloadRecord_05CED3:
	incbin "data/rom/bank_040000_07ffff.bin",$01CED3,$000182

Bank040000_LocalTableTargetedPayloadRecord_05D055:
	incbin "data/rom/bank_040000_07ffff.bin",$01D055,$000194

Bank040000_LocalTableTargetedPayloadRecord_05D1E9:
	incbin "data/rom/bank_040000_07ffff.bin",$01D1E9,$0001D4

Bank040000_LocalTableTargetedPayloadRecord_05D3BD:
	incbin "data/rom/bank_040000_07ffff.bin",$01D3BD,$0000BE

Bank040000_LocalTableTargetedPayloadRecord_05D47B:
	incbin "data/rom/bank_040000_07ffff.bin",$01D47B,$0001B5

	include "src/reference_gfx_bank/planar_tile_family_05d630.asm"
