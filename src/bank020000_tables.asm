; ROM range: 0x022460-0x022C5F
; The first post-dictionary bank020000 island is structurally dense rather than plain text.
; The front 0x60 bytes are six 0x10-byte same-bank reference descriptors, followed by a
; monotone offset table whose values fit a payload base at 0x0225D8. That payload is no
; longer one coarse blob either: after an 0x8A-byte lead-in, the same offset table fans out
; into mostly 6-byte short records with a smaller set of 8-byte variants before the later
; 0x02292C-0x022AEB repeated 0x10-byte descriptor band. The consuming driver is still open,
; so keep the labels structural.

Bank020000_SameBankReferenceDescriptor_022460:
	dc.l	$000267D2,$00026C78
	dc.w	$3635,$0E68
	dc.l	$000265FC

Bank020000_SameBankReferenceDescriptor_022470:
	dc.l	$0002BCDC,$0002BB72
	dc.w	$1718,$0804
	dc.l	$0002B2B8

Bank020000_SameBankReferenceDescriptor_022480:
	dc.l	$00037AB0,$00037D6E
	dc.w	$5354,$0402
	dc.l	$00037352

Bank020000_SameBankReferenceDescriptor_022490:
	dc.l	$00034822,$00034A12
	dc.w	$5657,$0000
	dc.l	$00033CF0

Bank020000_SameBankReferenceDescriptor_0224A0:
	dc.l	$0002A0B8,$0002AA88
	dc.w	$1211,$0EA6
	dc.l	$00029EF2

Bank020000_SameBankReferenceDescriptor_0224B0:
	dc.l	$0002985E,$000293DC
	dc.w	$1365,$0EC6
	dc.l	$00028318

Bank020000_IndexedPayloadOffsetTable_0224C0:
	dc.w	$008A,$0114,$011C,$0122,$0128,$012E,$0134,$013A
	dc.w	$0140,$0146,$014C,$0152,$0158,$015E,$0164,$016A
	dc.w	$0170,$0176,$017C,$0182,$0188,$0190,$0196,$019C
	dc.w	$01A4,$01AA,$01B0,$01B6,$01BC,$01C2,$01C8,$01CE
	dc.w	$01D4,$01DA,$01E2,$01E8,$01EE,$01F4,$01FA,$0200
	dc.w	$0206,$020C,$0212,$0218,$021E,$0224,$022A,$0230
	dc.w	$0236,$023C,$0242,$0248,$024E,$0254,$025A,$0260
	dc.w	$0260,$0266,$026C,$0272,$0278,$027E,$0284,$028A
	dc.w	$0290,$0296,$029C,$02A2,$02A8,$02AE,$02B4,$02BA
	dc.w	$02C0,$02C6,$02CC,$02D2,$02D8,$02DE,$02E4,$02EA
	dc.w	$02F0,$02F6,$02FC,$0302,$0308,$030E,$0314,$031A
	dc.w	$0320,$0328,$0330,$0338,$033E,$0344,$034C,$0352
	dc.w	$0358,$035E,$0364,$036A,$0370,$0378,$037E,$0384
	dc.w	$038A,$0390,$0396,$039C,$03A2,$03A8,$03B0,$03B6
	dc.w	$03BC,$03C2,$03C8,$03CE,$03D4,$03DA,$03E0,$03E6
	dc.w	$03EC,$03F2,$03F8,$03FE,$0404,$040A,$0410,$0416
	dc.w	$041C,$0422,$0428,$042E,$0434,$043A,$0440,$0446
	dc.w	$044C,$0452,$0458,$0000

Bank020000_IndexedPayloadPrelude_0225D8:
	incbin "data/rom/bank_020000_03ffff.bin",$0025D8,$00008A

; The offset table at 0x0224C0 resolves to 139 unique payload starts between 0x022662 and
; 0x02292A. Most pointed records are 6 bytes (three words), with eight 8-byte variants and
; one duplicate offset ($0260) before the later 0x10-byte descriptor band begins.
Bank020000_IndexedPayloadShortRecordLeadIn_022662:
	dc.w	$2610,$1600,$0601,$0400,$700E,$0602,$1400,$160E
	dc.w	$0604,$0400,$040E,$0604,$0400,$1C0E,$0700,$0400
	dc.w	$4E10,$0703,$0808,$0510,$0701,$0808,$0920,$0709
	dc.w	$0400,$560A,$070A,$0400,$200E,$0E01,$1200,$3608
	dc.w	$0D00,$110B,$0400,$2014,$070B,$0400,$060E,$070B
	dc.w	$0400,$1810,$110D,$0400,$1412,$0A02,$0400,$1A3E
	dc.w	$0A03,$0400,$6410,$0A03,$0400,$B410,$0A03,$0400
	dc.w	$8C10,$0B00,$0400,$6210,$0B00,$0400,$0A10,$0B00
	dc.w	$0400,$B610,$0D07,$0400,$0610

Bank020000_IndexedPayloadExtendedShortRecord_0226EC:
	dc.w	$0B03,$0400,$060C,$0B03

Bank020000_IndexedPayloadShortRecord_0226F4:
	dc.w	$0400,$2614,$0B05

Bank020000_IndexedPayloadShortRecord_0226FA:
	dc.w	$040A,$5C12,$0B06

Bank020000_IndexedPayloadShortRecord_022700:
	dc.w	$0400,$0410,$0C02

Bank020000_IndexedPayloadShortRecord_022706:
	dc.w	$0404,$302A,$0C03

Bank020000_IndexedPayloadShortRecord_02270C:
	dc.w	$0404,$080E,$0C02

Bank020000_IndexedPayloadShortRecord_022712:
	dc.w	$0404,$1414,$0C04

Bank020000_IndexedPayloadShortRecord_022718:
	dc.w	$0404,$1A12,$0C04

Bank020000_IndexedPayloadShortRecord_02271E:
	dc.w	$0404,$060E,$0E01

Bank020000_IndexedPayloadShortRecord_022724:
	dc.w	$0400,$220A,$0E04

Bank020000_IndexedPayloadShortRecord_02272A:
	dc.w	$0400,$1C12,$0E04

Bank020000_IndexedPayloadShortRecord_022730:
	dc.w	$0400,$0412,$0F05

Bank020000_IndexedPayloadShortRecord_022736:
	dc.w	$0400,$340E,$0F0C

Bank020000_IndexedPayloadShortRecord_02273C:
	dc.w	$0400,$3C0C,$0F05

Bank020000_IndexedPayloadShortRecord_022742:
	dc.w	$0400,$6C0E,$0F0D

Bank020000_IndexedPayloadShortRecord_022748:
	dc.w	$0400,$1E10,$0F06

Bank020000_IndexedPayloadShortRecord_02274E:
	dc.w	$0404,$500C,$0F03

Bank020000_IndexedPayloadShortRecord_022754:
	dc.w	$0404,$0408,$0F0E

Bank020000_IndexedPayloadShortRecord_02275A:
	dc.w	$0400,$1210,$0F0F

Bank020000_IndexedPayloadExtendedShortRecord_022760:
	dc.w	$0400,$060E,$0F0F,$0400

Bank020000_IndexedPayloadShortRecord_022768:
	dc.w	$1810,$0B03,$0400

Bank020000_IndexedPayloadShortRecord_02276E:
	dc.w	$262A,$0B03,$0400

Bank020000_IndexedPayloadExtendedShortRecord_022774:
	dc.w	$322A,$0B03,$0400,$462A

Bank020000_IndexedPayloadShortRecord_02277C:
	dc.w	$0B03,$0400,$522A

Bank020000_IndexedPayloadShortRecord_022782:
	dc.w	$0B07,$0400,$0406

Bank020000_IndexedPayloadShortRecord_022788:
	dc.w	$0B07,$0400,$0410

Bank020000_IndexedPayloadShortRecord_02278E:
	dc.w	$0B07,$0400,$3C10

Bank020000_IndexedPayloadShortRecord_022794:
	dc.w	$0B07,$0400,$3A2C

Bank020000_IndexedPayloadShortRecord_02279A:
	dc.w	$0B07,$0400,$302C

Bank020000_IndexedPayloadShortRecord_0227A0:
	dc.w	$0B07,$0400,$1A2C

Bank020000_IndexedPayloadShortRecord_0227A6:
	dc.w	$0B07,$0400,$122C

Bank020000_IndexedPayloadShortRecord_0227AC:
	dc.w	$0C05,$0808,$5312

Bank020000_IndexedPayloadExtendedShortRecord_0227B2:
	dc.w	$0D00,$0400,$1A08,$0D01

Bank020000_IndexedPayloadShortRecord_0227BA:
	dc.w	$0400,$3628,$0D01

Bank020000_IndexedPayloadShortRecord_0227C0:
	dc.w	$0400,$1040,$110C

Bank020000_IndexedPayloadShortRecord_0227C6:
	dc.w	$0400,$043C,$110C

Bank020000_IndexedPayloadShortRecord_0227CC:
	dc.w	$040A,$3C08,$1205

Bank020000_IndexedPayloadShortRecord_0227D2:
	dc.w	$0406,$1A10,$120B

Bank020000_IndexedPayloadShortRecord_0227D8:
	dc.w	$0406,$0410,$1201

Bank020000_IndexedPayloadShortRecord_0227DE:
	dc.w	$0406,$0610,$0200

Bank020000_IndexedPayloadShortRecord_0227E4:
	dc.w	$1200,$1412,$0300

Bank020000_IndexedPayloadShortRecord_0227EA:
	dc.w	$0500,$1200,$4A10

Bank020000_IndexedPayloadShortRecord_0227F0:
	dc.w	$1500,$0601,$1200

Bank020000_IndexedPayloadShortRecord_0227F6:
	dc.w	$2612,$0800,$0404

Bank020000_IndexedPayloadShortRecord_0227FC:
	dc.w	$1000,$110E,$1000

Bank020000_IndexedPayloadShortRecord_022802:
	dc.w	$1000,$0C12,$0C02

Bank020000_IndexedPayloadShortRecord_022808:
	dc.w	$1200,$1E1E,$1100

Bank020000_IndexedPayloadShortRecord_02280E:
	dc.w	$0200,$0000,$0212

Bank020000_IndexedPayloadShortRecord_022814:
	dc.w	$0B08,$0400,$3A14

Bank020000_IndexedPayloadShortRecord_02281A:
	dc.w	$0B08,$1000,$2008

Bank020000_IndexedPayloadShortRecord_022820:
	dc.w	$0C06,$1000,$100E

Bank020000_IndexedPayloadShortRecord_022826:
	dc.w	$110C,$0400,$1C1C

Bank020000_IndexedPayloadShortRecord_02282C:
	dc.w	$110D,$0400,$1812

Bank020000_IndexedPayloadShortRecord_022832:
	dc.w	$0C05,$0E00,$142A

Bank020000_IndexedPayloadShortRecord_022838:
	dc.w	$1B00,$0C09,$0400

Bank020000_IndexedPayloadShortRecord_02283E:
	dc.w	$1004,$0C09,$0400

Bank020000_IndexedPayloadShortRecord_022844:
	dc.w	$1012,$0400,$0400

Bank020000_IndexedPayloadShortRecord_02284A:
	dc.w	$5014,$0406,$0400

Bank020000_IndexedPayloadShortRecord_022850:
	dc.w	$062C,$0C08,$0400

Bank020000_IndexedPayloadShortRecord_022856:
	dc.w	$3C10,$0804,$0400

Bank020000_IndexedPayloadShortRecord_02285C:
	dc.w	$3E24,$0D08,$0400

Bank020000_IndexedPayloadShortRecord_022862:
	dc.w	$0608,$0D08,$0400

Bank020000_IndexedPayloadShortRecord_022868:
	dc.w	$5A24,$0D08,$0E0A

Bank020000_IndexedPayloadShortRecord_02286E:
	dc.w	$2E2C,$1C00,$0D08

Bank020000_IndexedPayloadShortRecord_022874:
	dc.w	$0400,$260C,$0D08

Bank020000_IndexedPayloadShortRecord_02287A:
	dc.w	$0400,$320C,$0D09

Bank020000_IndexedPayloadShortRecord_022880:
	dc.w	$0400,$080E,$0E01

Bank020000_IndexedPayloadShortRecord_022886:
	dc.w	$0400,$080E,$1207

Bank020000_IndexedPayloadShortRecord_02288C:
	dc.w	$0406,$0410,$1202

Bank020000_IndexedPayloadShortRecord_022892:
	dc.w	$0406,$0610,$1208

Bank020000_IndexedPayloadShortRecord_022898:
	dc.w	$0406,$200E,$1203

Bank020000_IndexedPayloadShortRecord_02289E:
	dc.w	$0406,$5A10,$1209

Bank020000_IndexedPayloadShortRecord_0228A4:
	dc.w	$0406,$0412,$1204

Bank020000_IndexedPayloadShortRecord_0228AA:
	dc.w	$0406,$5A10,$120A

Bank020000_IndexedPayloadShortRecord_0228B0:
	dc.w	$0406,$080E,$0708

Bank020000_IndexedPayloadShortRecord_0228B6:
	dc.w	$1400,$1E28,$070C

Bank020000_IndexedPayloadShortRecord_0228BC:
	dc.w	$1400,$1010,$0704

Bank020000_IndexedPayloadShortRecord_0228C2:
	dc.w	$1400,$2016,$070D

Bank020000_IndexedPayloadShortRecord_0228C8:
	dc.w	$1400,$1010,$0B03

Bank020000_IndexedPayloadShortRecord_0228CE:
	dc.w	$0400,$5E10,$1106

Bank020000_IndexedPayloadShortRecord_0228D4:
	dc.w	$0400,$6A10,$1106

Bank020000_IndexedPayloadShortRecord_0228DA:
	dc.w	$0400,$7A10,$1106

Bank020000_IndexedPayloadShortRecord_0228E0:
	dc.w	$0400,$7A08,$1107

Bank020000_IndexedPayloadShortRecord_0228E6:
	dc.w	$0400,$0610,$1107

Bank020000_IndexedPayloadShortRecord_0228EC:
	dc.w	$0400,$3810,$1105

Bank020000_IndexedPayloadShortRecord_0228F2:
	dc.w	$0400,$0628,$110E

Bank020000_IndexedPayloadExtendedShortRecord_0228F8:
	dc.w	$0400,$1004,$110E,$0400

Bank020000_IndexedPayloadExtendedShortRecord_022900:
	dc.w	$1012,$110F,$0400,$060E

Bank020000_IndexedPayloadExtendedShortRecord_022908:
	dc.w	$110F,$0400,$1810,$1106

Bank020000_IndexedPayloadShortRecord_022910:
	dc.w	$0400,$4210,$1110

Bank020000_IndexedPayloadShortRecord_022916:
	dc.w	$0400,$1004,$1110

Bank020000_IndexedPayloadExtendedShortRecord_02291C:
	dc.w	$0400,$1012,$1060,$1010

Bank020000_IndexedPayloadShortRecord_022924:
	dc.w	$1060,$0000,$0000

Bank020000_IndexedPayloadTerminatorWord_02292A:
	dc.w	$0000

Bank020000_RepeatedDescriptorRecord_02292C:
	dc.w	$0420,$0498,$1120,$1050,$4020,$0000,$01D0,$0000

Bank020000_RepeatedDescriptorRecord_02293C:
	dc.w	$0422,$04F4,$1260,$1040,$1020,$0000,$01DC,$0000

Bank020000_RepeatedDescriptorRecord_02294C:
	dc.w	$0424,$0528,$1030,$1000,$4070,$0000,$01F0,$0000

Bank020000_RepeatedDescriptorRecord_02295C:
	dc.w	$0426,$0556,$1110,$1000,$A060,$0000,$01FC,$0000

Bank020000_RepeatedDescriptorRecord_02296C:
	dc.w	$0428,$05EE,$1280,$1010,$3050,$0000,$022A,$0000

Bank020000_RepeatedDescriptorRecord_02297C:
	dc.w	$042A,$069A,$1310,$1000,$7070,$0000,$0236,$0000

Bank020000_RepeatedDescriptorRecord_02298C:
	dc.w	$042C,$06EC,$1040,$1040,$3020,$0000,$0304,$0000

Bank020000_RepeatedDescriptorRecord_02299C:
	dc.w	$042E,$0792,$1110,$1050,$2020,$0000,$0310,$0000

Bank020000_RepeatedDescriptorRecord_0229AC:
	dc.w	$0430,$07CE,$11A0,$1050,$3020,$0000,$031C,$0000

Bank020000_RepeatedDescriptorRecord_0229BC:
	dc.w	$0432,$0802,$1240,$1050,$2020,$0000,$0336,$0000

Bank020000_RepeatedDescriptorRecord_0229CC:
	dc.w	$0434,$0836,$1060,$1000,$5020,$0000,$03C2,$0000

Bank020000_RepeatedDescriptorRecord_0229DC:
	dc.w	$0436,$086A,$1120,$1050,$6020,$0000,$03DC,$0000

Bank020000_RepeatedDescriptorRecord_0229EC:
	dc.w	$0438,$08AC,$1190,$1000,$4020,$0000,$03FC,$0000

Bank020000_RepeatedDescriptorRecord_0229FC:
	dc.w	$043A,$08EE,$1200,$1000,$4030,$0000,$0408,$0000

Bank020000_RepeatedDescriptorRecord_022A0C:
	dc.w	$043C,$0922,$1120,$1050,$6020,$0400,$036A,$0000

Bank020000_RepeatedDescriptorRecord_022A1C:
	dc.w	$043E,$0968,$1000,$1100,$2020,$0400,$0384,$0000

Bank020000_RepeatedDescriptorRecord_022A2C:
	dc.w	$0440,$09A4,$1080,$10B0,$5020,$0400,$039E,$0000

Bank020000_RepeatedDescriptorRecord_022A3C:
	dc.w	$0442,$09E0,$1180,$10B0,$5020,$0400,$03AA,$0000

Bank020000_RepeatedDescriptorRecord_022A4C:
	dc.w	$0444,$0A1C,$1090,$1040,$6020,$0000,$0258,$0000

Bank020000_RepeatedDescriptorRecord_022A5C:
	dc.w	$0446,$0A50,$11A0,$1040,$2020,$0000,$0272,$0000

Bank020000_RepeatedDescriptorRecord_022A6C:
	dc.w	$0448,$0AE8,$1230,$1040,$5020,$0000,$028C,$0000

Bank020000_RepeatedDescriptorRecord_022A7C:
	dc.w	$044A,$0B2A,$1110,$1040,$80B0,$0000,$0298,$0000

Bank020000_RepeatedDescriptorRecord_022A8C:
	dc.w	$044C,$0B66,$11C0,$10D0,$5050,$0000,$029A,$0000

Bank020000_RepeatedDescriptorRecord_022A9C:
	dc.w	$0454,$0C3A,$12A0,$10D0,$3010,$0000,$02E2,$0000

Bank020000_RepeatedDescriptorRecord_022AAC:
	dc.w	$0456,$0CB4,$1070,$1190,$5050,$0000,$02E4,$0000

Bank020000_RepeatedDescriptorRecord_022ABC:
	dc.w	$045E,$0CD4,$1240,$1020,$3030,$0000,$0356,$0000

Bank020000_RepeatedDescriptorRecord_022ACC:
	dc.w	$0460,$0D44,$1030,$10F0,$3040,$0000,$03B6,$0000

Bank020000_RepeatedDescriptorRecord_022ADC:
	dc.w	$0462,$0D82,$1010,$1120,$1020,$0000,$0414,$0000

Bank020000_SentinelRichDescriptorTail_022AEC:
	incbin "data/rom/bank_020000_03ffff.bin",$002AEC,$000174
