; ROM range: 0x021360-0x02171F
; Adjacent quiz/trivia resource block. The leading words are the tail of a larger offset
; table whose earlier entries still live in the preceding opaque slice, and the control
; bytes between the prompt text and the question strings are not decoded yet, so keep them
; byte-explicit while naming the proven question/answer text.

Bank020000_QuizPhraseOffsetTableTail_021360:
	dc.w	$119A,$119F,$11A6,$11AC,$11B1,$11BB,$11C4,$11CE
	dc.w	$11D4,$11DA,$11E0,$11EC,$11F2,$11F7,$1200,$1206
	dc.w	$120B,$120F,$1215,$121A,$121F,$1225,$122A,$1231
	dc.w	$1236,$1241,$1246,$124E,$1256,$125E,$1262,$1269
	dc.w	$126E,$1273,$1278,$127D,$1281

Bank020000_QuizPromptHeaderControl_0213AA:
	dc.b	$03,$00,$02,$04,$04

Bank020000_QuizYesNoText_0213AF:
	dc.b	"YES  NO",$00

Bank020000_QuizGoldLabelText_0213B7:
	dc.b	" GOLD",$00

Bank020000_QuizPromptAndQuestionControlData_0213BD:
	dc.b	$01,$A0,$0B,$06,$01,$80,$00,$04,$01,$0B,$04,$FF,$0B,$05,$0C,$01
	dc.b	$00,$95,$97,$8C,$98,$9B,$BD,$00,$04,$03,$0B,$0F,$FF,$0B,$05,$0C
	dc.b	$01,$00,$0A,$02,$03,$06,$04,$02,$00,$03,$06,$0A,$02,$05,$09,$00
	dc.b	$03,$10,$20,$0F,$04,$0F,$03,$0F,$04,$0F,$03,$0F,$04,$0F,$05,$0F
	dc.b	$04,$03,$06,$00,$03,$10,$20,$0F,$03,$0F,$04,$0F,$05,$0F,$04,$0F
	dc.b	$05,$0F,$03,$0F,$04,$03,$06,$00,$03,$10,$20,$0F,$03,$0F,$05,$0F
	dc.b	$05,$0F,$03,$0F,$04,$0F,$03,$0F,$04,$03,$06,$00

Bank020000_QuizQuestion01Text_021429:
	dc.b	"What's the first",$02,"type of magic you",$02,"acquired?",$00
Bank020000_QuizQuestion01Answer_FireStorm_021456:
	dc.b	"Fire Storm",$00
Bank020000_QuizQuestion01Answer_Tornado_021461:
	dc.b	"Tornado",$00
Bank020000_QuizQuestion01Answer_Quake_021469:
	dc.b	"Quake",$00

Bank020000_QuizQuestion02Text_02146F:
	dc.b	"What's the name",$02,"of the queen in",$02,"the elf village?",$00
Bank020000_QuizQuestion02Answer_Rosanna_0214A0:
	dc.b	"Rosanna",$00
Bank020000_QuizQuestion02Answer_Eleanora_0214A8:
	dc.b	"Eleanora",$00
Bank020000_QuizQuestion02Answer_Sonia_0214B1:
	dc.b	"Sonia",$00

Bank020000_QuizQuestion03Text_0214B7:
	dc.b	"Which of these",$02,"monsters did you",$02,"battle first?",$00
Bank020000_QuizQuestion03Answer_Myconid_0214E5:
	dc.b	"Myconid",$00
Bank020000_QuizQuestion03Answer_MechaDragon_0214ED:
	dc.b	"Mecha-Dragon",$00
Bank020000_QuizQuestion03Answer_Eleanora_0214FA:
	dc.b	"Eleanora",$00

Bank020000_QuizQuestion04Text_021503:
	dc.b	"After defeating",$02,"Gragg & Glagg,",$02,"what did you",$02,"receive?",$00
Bank020000_QuizQuestion04Answer_Lamp_021538:
	dc.b	"Lamp",$00
Bank020000_QuizQuestion04Answer_Amulet_02153D:
	dc.b	"Amulet",$00
Bank020000_QuizQuestion04Answer_Trident_021544:
	dc.b	"Trident",$00

; Quiz-only inline shop-item literals. These answer strings mention the Wanderer weapon
; shop inventory directly, but they are not yet proven to reference
; Bank020000_InventoryNameOffsetTable_021720 at runtime.
Bank020000_QuizQuestion05Text_02154C:
	dc.b	"Which of these",$02,"items is not sold",$02,"at the Wanderer",$02,"weapon shop?",$00
Bank020000_QuizQuestion05Answer_Trident_02158A:
	dc.b	"Trident",$00
Bank020000_QuizQuestion05Answer_Excalibur_021592:
	dc.b	"Excalibur",$00
Bank020000_QuizQuestion05Answer_SteelShield_02159C:
	dc.b	"Steel Shield",$00

Bank020000_QuizQuestion06Text_0215A9:
	dc.b	"What's the name",$02,"of the dwarf",$02,"village?",$00
Bank020000_QuizQuestion06Answer_Lilian_0215CF:
	dc.b	"Lilian",$00
Bank020000_QuizQuestion06Answer_Lilypad_0215D6:
	dc.b	"Lilypad",$00
Bank020000_QuizQuestion06Answer_Lollipop_0215DE:
	dc.b	"Lollipop",$00

Bank020000_QuizQuestion07Text_0215E7:
	dc.b	"Which key do",$02,"you need to",$02,"enter the",$02,"Pyramid ?",$00
Bank020000_QuizQuestion07Answer_StarKey_021614:
	dc.b	"Star Key",$00
Bank020000_QuizQuestion07Answer_SunKey_02161D:
	dc.b	"Sun Key",$00
Bank020000_QuizQuestion07Answer_MoonKey_021625:
	dc.b	"Moon Key",$00

; Quiz-only inline GOLD-formatted price literals. This is the only recovered explicit
; Charmstone pricing in source so far; no dedicated shop price table is yet proven.
Bank020000_QuizQuestion08Text_02162E:
	dc.b	"How much does a",$02,"Charmstone cost?",$00
Bank020000_QuizQuestion08Answer_50000Gold_02164F:
	dc.b	"50000 GOLD",$00
Bank020000_QuizQuestion08Answer_500000Gold_02165A:
	dc.b	"500000 GOLD",$00
Bank020000_QuizQuestion08Answer_5000000Gold_021666:
	dc.b	"5000000 GOLD",$00

Bank020000_QuizQuestion09Text_021673:
	dc.b	"What item helped",$02,"you to traverse",$02,"Maugham Desert?",$00
Bank020000_QuizQuestion09Answer_DesertBoots_0216A4:
	dc.b	"Desert Boots",$00
Bank020000_QuizQuestion09Answer_OasisBoots_0216B1:
	dc.b	"Oasis Boots",$00
Bank020000_QuizQuestion09Answer_PussnBoots_0216BD:
	dc.b	"Puss'n Boots",$00

Bank020000_QuizQuestion10Text_0216CA:
	dc.b	"Which of these",$02,"stores does not",$02,"sell weapons?",$00
Bank020000_QuizQuestion10Answer_Gooningle_0216F7:
	dc.b	"Gooningle",$00
Bank020000_QuizQuestion10Answer_Bacchus_021701:
	dc.b	"Bacchus",$00
Bank020000_QuizQuestion10Answer_Felissimo_021709:
	dc.b	"Felissimo",$00

Bank020000_QuizFinalPromptControl_021713:
	dc.b	$03,$00,$02,$04,$04

Bank020000_QuizFinalYesNoText_021718:
	dc.b	"YES  NO",$00
