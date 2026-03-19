; ROM range: 0x0211CA-0x02135F
; This front-of-bank island is structured index data rather than more opaque prose. Four
; absolute longwords point at bank-local table families, followed by two bank-relative
; offset tables that target earlier text-bearing records in the same bank.

Bank020000_LocalTextTablePointerList_0211CA:
	dc.l	Bank020000_BankRelativeTextOffsetTableA_0211DA
	dc.l	Bank020000_InventoryNameOffsetTable_021720
	dc.l	Bank020000_WorldKeywordOffsetTable_021A06
	dc.l	Bank020000_OcarinaMelodyUnknownData_021FCA

; 52 live bank-relative offsets followed by 11 zero sentinels. Every nonzero word points
; back into 0x0201D0-0x020539, so keep the table structural until its consumer is proven.
Bank020000_BankRelativeTextOffsetTableA_0211DA:
	dc.w	$01D0,$01DD,$01E3,$01EA,$01F4,$01FB,$0205,$020C
	dc.w	$0213,$0227,$023B,$024F,$027C,$0287,$028F,$0295
	dc.w	$02C6,$02CE,$02D7,$02DD,$030B,$0313,$0320,$0329
	dc.w	$035E,$0363,$036A,$0372,$03B0,$03B8,$03C2,$03CF
	dc.w	$03F5,$03FC,$0404,$040D,$043A,$0443,$044B,$0454
	dc.w	$0475,$0480,$048C,$0499,$04CA,$04D7,$04E3,$04F0
	dc.w	$051D,$0527,$052F,$0539,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000

; This second bank-relative table is monotone apart from its leading zero sentinel and
; points back into a later 0x020E4C-0x021195 record band. The target records still mix text
; with undecoded control bytes, so keep the entries literal for now.
Bank020000_BankRelativeTextOffsetTableB_021258:
	dc.w	$0000,$0E4C,$0E53,$0E5A,$0E5E,$0E69,$0E72,$0E79
	dc.w	$0E84,$0E90,$0E95,$0E9E,$0EA5,$0EAC,$0EB2,$0EBB
	dc.w	$0EC0,$0EC5,$0ECA,$0ED2,$0ED8,$0EE0,$0EE8,$0EEC
	dc.w	$0EF4,$0EFB,$0F04,$0F0E,$0F17,$0F1D,$0F23,$0F2C
	dc.w	$0F32,$0F39,$0F3E,$0F44,$0F48,$0F4E,$0F53,$0F5B
	dc.w	$0F60,$0F66,$0F6A,$0F6F,$0F75,$0F7B,$0F81,$0F85
	dc.w	$0F8D,$0F91,$0F9A,$0F9F,$0FA4,$0FAB,$0FB2,$0FB9
	dc.w	$0FC1,$0FC5,$0FC9,$0FD0,$0FD5,$0FDB,$0FE2,$0FE7
	dc.w	$0FEE,$0FF2,$0FF7,$0FFD,$1003,$1008,$1013,$1018
	dc.w	$101C,$1023,$1028,$102D,$1038,$103E,$1044,$1049
	dc.w	$104D,$1056,$105A,$105F,$1065,$106A,$106F,$1076
	dc.w	$107F,$1084,$108A,$1094,$109C,$10A1,$10AB,$10B0
	dc.w	$10B5,$10BF,$10C4,$10C9,$10CE,$10D4,$10DA,$10DE
	dc.w	$10E7,$10F0,$10F5,$10FA,$10FF,$1104,$1108,$1110
	dc.w	$1114,$1118,$111D,$1123,$1127,$1130,$1137,$113D
	dc.w	$1146,$114F,$1158,$1161,$1167,$116E,$1177,$117D
	dc.w	$1184,$118A,$1191,$1195
