; ROM range: 0x02053A-0x020E4B
; Dialogue/script text block continuing the NPC conversation records from the preceding
; text-record family at 0x0201D0-0x020539. Each entry is a null-terminated (0x00) record
; containing one or more 0x05-terminated dialogue strings. Control codes as in the front
; continuation region: 0x05=end, 0x09=newline, 0x0B NN=speaker/format cmd,
; 0x0C NN=dictionary word, 0x02=wrap, 0x03/0x04/0x06/0x07=undecoded, 0x0F NN=undecoded.
; Readable text fragments confirmed include: "Rumor [terribly] it [?]", "Forgive me",
; "Labyrinth", "I am [the] Prince of DarkWorld", "Gragg & Glagg!", "Ice Bomber!",
; "Tyrant [going]!", "Almighty Demon King!", "Gold Gem", "Gem doesn't fit!",
; "Bell Tower", "star crest", "Not too bad, eh?", "Some [magic].", "Well, [right] on in."

Bank020000_DialogueScriptMidBlock_02053A:
	incbin "data/rom/bank_020000_03ffff.bin",$00053A,$000025

Bank020000_DialogueScriptMidBlock_02055F:
	incbin "data/rom/bank_020000_03ffff.bin",$00055F,$000001

Bank020000_DialogueScriptMidBlock_020560:
	incbin "data/rom/bank_020000_03ffff.bin",$000560,$000003

Bank020000_DialogueScriptMidBlock_020563:
	incbin "data/rom/bank_020000_03ffff.bin",$000563,$000001

; "Is it true [that] [you] crossed [the] [safely] ?  That's incredible!"
Bank020000_DialogueScript_IsThatTrue_020564:
	incbin "data/rom/bank_020000_03ffff.bin",$000564,$000036

Bank020000_DialogueScriptMidBlock_02059A:
	incbin "data/rom/bank_020000_03ffff.bin",$00059A,$000001

; "I [that] [those] went to Ice [find]." / "Be [dc], [dc] careful." / "I worry [must] [you]."
Bank020000_DialogueScript_IceWarning_02059B:
	incbin "data/rom/bank_020000_03ffff.bin",$00059B,$00003F

Bank020000_DialogueScriptMidBlock_0205DA:
	incbin "data/rom/bank_020000_03ffff.bin",$0005DA,$000001

; "[look] [legendary]!" boss-defeat flash
Bank020000_DialogueScript_BossDefeatFlash_0205DB:
	incbin "data/rom/bank_020000_03ffff.bin",$0005DB,$00000D

Bank020000_DialogueScriptMidBlock_0205E8:
	incbin "data/rom/bank_020000_03ffff.bin",$0005E8,$000001

; "[look] [everything] [the] [?] begun to glow."
Bank020000_DialogueScript_BegunToGlow_0205E9:
	incbin "data/rom/bank_020000_03ffff.bin",$0005E9,$000020

Bank020000_DialogueScriptMidBlock_020609:
	incbin "data/rom/bank_020000_03ffff.bin",$000609,$000001

; "[look] seal is broken."
Bank020000_DialogueScript_SealBroken_02060A:
	incbin "data/rom/bank_020000_03ffff.bin",$00060A,$000018

Bank020000_DialogueScriptMidBlock_020622:
	incbin "data/rom/bank_020000_03ffff.bin",$000622,$000001

Bank020000_DialogueScriptMidBlock_020623:
	incbin "data/rom/bank_020000_03ffff.bin",$000623,$000005

Bank020000_DialogueScriptMidBlock_020628:
	incbin "data/rom/bank_020000_03ffff.bin",$000628,$000001

; "Forgive me, [princess] we seem to be sold [?]."
Bank020000_DialogueScript_ForgiveMe_020629:
	incbin "data/rom/bank_020000_03ffff.bin",$000629,$000032

Bank020000_DialogueScriptMidBlock_02065B:
	incbin "data/rom/bank_020000_03ffff.bin",$00065B,$000001

Bank020000_DialogueScriptMidBlock_02065C:
	incbin "data/rom/bank_020000_03ffff.bin",$00065C,$000003

Bank020000_DialogueScriptMidBlock_02065F:
	incbin "data/rom/bank_020000_03ffff.bin",$00065F,$000001

; "[long] [you] [some] coming." / "[magic] is [the] [?] / [...] known as Labyrinth."
Bank020000_DialogueScript_Labyrinth_020660:
	incbin "data/rom/bank_020000_03ffff.bin",$000660,$000037

Bank020000_DialogueScriptMidBlock_020697:
	incbin "data/rom/bank_020000_03ffff.bin",$000697,$000001

; "[long] [you] [some] [...] / [melodies] an excellent choice!"
Bank020000_DialogueScript_ExcellentChoice_020698:
	incbin "data/rom/bank_020000_03ffff.bin",$000698,$000028

Bank020000_DialogueScriptMidBlock_0206C0:
	incbin "data/rom/bank_020000_03ffff.bin",$0006C0,$000001

Bank020000_DialogueScriptMidBlock_0206C1:
	incbin "data/rom/bank_020000_03ffff.bin",$0006C1,$000005

Bank020000_DialogueScriptMidBlock_0206C6:
	incbin "data/rom/bank_020000_03ffff.bin",$0006C6,$000001

; "It [what] [was] I'm a [?] [?] to [close]! / Ha, ha, ha, ha..." / "Well, [right] on in."
Bank020000_DialogueScript_HaHaHa_0206C7:
	incbin "data/rom/bank_020000_03ffff.bin",$0006C7,$000033

Bank020000_DialogueScriptMidBlock_0206FA:
	incbin "data/rom/bank_020000_03ffff.bin",$0006FA,$000001

; "Well, [right] on in." / "[like] [?] [da]."
Bank020000_DialogueScript_WellRightOnIn_0206FB:
	incbin "data/rom/bank_020000_03ffff.bin",$0006FB,$00001B

Bank020000_DialogueScriptMidBlock_020716:
	incbin "data/rom/bank_020000_03ffff.bin",$000716,$000001

Bank020000_DialogueScriptMidBlock_020717:
	incbin "data/rom/bank_020000_03ffff.bin",$000717,$000005

Bank020000_DialogueScriptMidBlock_02071C:
	incbin "data/rom/bank_020000_03ffff.bin",$00071C,$000001

Bank020000_DialogueScriptMidBlock_02071D:
	incbin "data/rom/bank_020000_03ffff.bin",$00071D,$000004

Bank020000_DialogueScriptMidBlock_020721:
	incbin "data/rom/bank_020000_03ffff.bin",$000721,$000001

Bank020000_DialogueScriptMidBlock_020722:
	incbin "data/rom/bank_020000_03ffff.bin",$000722,$000005

Bank020000_DialogueScriptMidBlock_020727:
	incbin "data/rom/bank_020000_03ffff.bin",$000727,$000001

Bank020000_DialogueScriptMidBlock_020728:
	incbin "data/rom/bank_020000_03ffff.bin",$000728,$000001

Bank020000_DialogueScriptMidBlock_020729:
	incbin "data/rom/bank_020000_03ffff.bin",$000729,$000004

Bank020000_DialogueScriptMidBlock_02072D:
	incbin "data/rom/bank_020000_03ffff.bin",$00072D,$000001

; "[more]'re [the] [waiting] I've [that] so [?] [must]." multi-string NPC block
Bank020000_DialogueScript_IceCaveBlock_02072E:
	incbin "data/rom/bank_020000_03ffff.bin",$00072E,$000090

Bank020000_DialogueScriptMidBlock_0207BE:
	incbin "data/rom/bank_020000_03ffff.bin",$0007BE,$000001

; "[look] Old [enter], in its original form, is of no use to [you]."
Bank020000_DialogueScript_OldAxe_0207BF:
	incbin "data/rom/bank_020000_03ffff.bin",$0007BF,$00005A

Bank020000_DialogueScriptMidBlock_020819:
	incbin "data/rom/bank_020000_03ffff.bin",$000819,$000001

; "[more]'re finally starting to [well] [was] a [their]." multi-string story block
Bank020000_DialogueScript_StoryBlock_02081A:
	incbin "data/rom/bank_020000_03ffff.bin",$00081A,$0000BC

Bank020000_DialogueScriptMidBlock_0208D6:
	incbin "data/rom/bank_020000_03ffff.bin",$0008D6,$000001

; "To [sell] [the] [?], [...] [sell] [the] room on [the] [?]
;  side of [?] [search], [princess] in order to [sell], [you] [sell] [thank]
;  [the] following [this]: [the] [just] Sword / [just] Armor / [just] Shield [one] [just] Boots."
; Likely upstream shop-inventory/control script. The control bytes are still only partly
; decoded, but the mixed text/control payload is now source-authored instead of hiding in the
; ROM blob. The explicit item-name strings recovered so far live either in
; Bank020000_InventoryNameOffsetTable_021720 or as quiz-only inline literals in
; Bank020000_QuizQuestion05Text_02154C and nearby answers.
Bank020000_DialogueScript_ShopInventoryBlock_0208D7:
	dc.b	$0C,$06,"To ",$0C,$82," ",$0C,$D3," ",$0C,$DE,",",$09
	dc.b	$0C,$E6," ",$0C,$AA," ",$0C,$82," ",$0C,$D3,$09,"room on ",$0C,$D3," ",$0C,$B1,$05
	dc.b	$09,"side of ",$0C,$D8," ",$0C,$80,",",$09,$0C,$77," in order to",$09,$0C,$82,", ",$0C,$E6
	dc.b	" ",$0C,$AA," ",$0C,$91,$05,$09,$0C,$D3," following ",$0C,$98,":",$05,$09,$0C,$D3," ",$0C,$5B," Sw"
	dc.b	"ord,",$09
	dc.b	$0C,$5B," Armor,",$05,$09,$0C,$5B," Shield, ",$0C,$6F,$09,$0C,$5B," Boots.",$05,$09,$09,$0B,$27

Bank020000_DialogueScriptMidBlock_020973:
	dc.b	$00

Bank020000_DialogueScriptMidBlock_020974:
	dc.b	$A0

Bank020000_DialogueScriptMidBlock_020975:
	dc.b	$00

Bank020000_DialogueScriptMidBlock_020976:
	dc.b	$76

Bank020000_DialogueScriptMidBlock_020977:
	dc.b	$00

Bank020000_DialogueScriptMidBlock_020978:
	dc.b	$57

Bank020000_DialogueScriptMidBlock_020979:
	dc.b	$00

Bank020000_DialogueScriptMidBlock_02097A:
	dc.b	$30

Bank020000_DialogueScriptMidBlock_02097B:
	dc.b	$00

; "[more] [thank] satisfied [the] requirements." / "[more] [?] [sell]."
Bank020000_DialogueScript_EquipmentRequirements_02097C:
	dc.b	$02,$0C,$68," ",$0C,$91," satisfied",$09,$0C,$D3," requirements.",$09,$0C,$68," ",$0C,$A5," ",$0C,$82,".",$05

Bank020000_DialogueScriptMidBlock_0209A8:
	dc.b	$00

; "One of [the] [this] is missing." / "I [?] [?] [close]."
Bank020000_DialogueScript_ItemMissing_0209A9:
	dc.b	"One of ",$0C,$D3," ",$0C,$98," is",$09,"missing.",$05,$09,$0C,$49," ",$0C,$E7," ",$0C,$C0,".",$05

Bank020000_DialogueScriptMidBlock_0209CD:
	dc.b	$00

; "[more] [?] two [?] [this]." / "I [?] [?] [close]."
Bank020000_DialogueScript_TwoItems_0209CE:
	dc.b	$0C,$68," ",$0C,$AB," two ",$0C,$A8,$09,$0C,$98,".",$05,$09,$0C,$49," ",$0C,$E7," ",$0C,$C0,".",$05

Bank020000_DialogueScriptMidBlock_0209EA:
	dc.b	$00

; "[more] [?] [?] [?] of [the] [?] [you] [?]." / "I [?] [?] [close]."
Bank020000_DialogueScript_ThreeItems_0209EB:
	dc.b	$0C,$68," ",$0C,$91," ",$0C,$B0," ",$0C,$AF," of",$09,$0C,$D3," ",$0C,$88," ",$0C,$E6," ",$0C,$AB,".",$05
	dc.b	$09,$0C,$49," ",$0C,$E7," ",$0C,$C0,".",$05

Bank020000_DialogueScriptMidBlock_020A12:
	dc.b	$00

Bank020000_DialogueScript_AllItems_020A13:
	dc.b	$0C,$68," ",$0C,$91," yet to ",$0C,$85,$09,"even ",$0C,$AF," of ",$0C,$D3,$09,$0C,$98,".",$05
	dc.b	$09,$0C,$68," ",$0C,$AA," ",$0C,$85," ",$0C,$6D,$09,$0C,$88,".",$09,$05

Bank020000_DialogueScriptMidBlock_020A47:
	dc.b	$00

; "Gragg & Glagg!"
Bank020000_DialogueScript_GraggGlagg_020A48:
	dc.b	$07,$04,$02,"Gragg & Glagg!",$0B,$18,$1E,$05

Bank020000_DialogueScriptMidBlock_020A5D:
	dc.b	$00

; "[look] Ice Bomber!"
Bank020000_DialogueScript_IceBomber_020A5E:
	dc.b	$07,$04,$01,$0C,$62," Ice Bomber!",$0B,$18,$1E,$05

Bank020000_DialogueScriptMidBlock_020A73:
	dc.b	$00

; "[look] Tyrant [going]!"
Bank020000_DialogueScript_Tyrant_020A74:
	dc.b	$07,$04,$04,$0C,$62," Tyrant ",$0C,$4B,"!",$0B,$18,$1E,$05

Bank020000_DialogueScriptMidBlock_020A88:
	dc.b	$00

; "[look] Almighty Demon King!"
Bank020000_DialogueScript_AlmightyDemonKing_020A89:
	dc.b	$07,$04,$01,$0C,$62," Almighty Demon King!",$0B,$18,$1E,$05

Bank020000_DialogueScriptMidBlock_020AA7:
	dc.b	$00

; "I've [that] [?] [legendary] [just] in [the] Pyramid likes quizzes."
Bank020000_DialogueScript_PyramidQuizzes_020AA8:
	dc.b	$0C,$06,"I've ",$0C,$92," ",$0C,$D2," ",$0C,$D3,$09,$0C,$5F," in ",$0C,$D3," Pyramid",$09
	dc.b	"likes quizzes.",$05

Bank020000_DialogueScriptMidBlock_020AD8:
	dc.b	$00

; "If [you] [thank] a certain special [there], [you] [probably] swim [?]."
Bank020000_DialogueScript_SpecialItem_020AD9:
	dc.b	$0C,$06,"If ",$0C,$E6," ",$0C,$91," a certain",$09,"special ",$0C,$97,", ",$0C,$E6," ",$0C,$78,$09
	dc.b	"swim ",$0C,$DB,".",$05

Bank020000_DialogueScriptMidBlock_020B09:
	dc.b	$00

; "[look] star crest on [the] Bell Tower is [the] same as [the] [?]..."
Bank020000_DialogueScript_BellTower_020B0A:
	dc.b	$0C,$06,$0C,$62," star crest on",$09,$0C,$D8," Bell Tower is",$09,$0C,$D3," same as ",$0C,$D3,$05,$09
	dc.b	"insignia on ",$0C,$D3,$09,$0C,$E1," of ",$0C,$D3,$09,$0C,$9F," ",$0C,$94,".",$05,$09,$09,$0C,$62
	dc.b	" ",$0C,$B7," told me",$09,$0C,$D8," a ",$0C,$A1," ",$0C,$DA," ago.",$09,$05

Bank020000_DialogueScriptMidBlock_020B7D:
	dc.b	$00

Bank020000_DialogueScriptMidBlock_020B7E:
	dc.b	$0C,$06,$0B,$17,$05

Bank020000_DialogueScriptMidBlock_020B83:
	dc.b	$00

; "[Shion]'re [?] strong." / "I hope [?] day I'll be so strong."
Bank020000_DialogueScript_Strong_020B84:
	dc.b	$38,$0C,$68,"'re ",$0C,$DC," strong.",$05,$09,$09,"I hope ",$0C,$AF," day I'll",$09,"be so strong.",$09,$05

Bank020000_DialogueScriptMidBlock_020BBA:
	dc.b	$00

; "It is said [that] [?]'s a [?] at [the] [place] of [the] sea..."
Bank020000_DialogueScript_SeaShrineHint_020BBB:
	dc.b	"It is said ",$0C,$D2,$09,$0C,$D7,"'s a ",$0C,$C4," at",$09,$0C,$D3," ",$0C,$75," of ",$0C,$D3,$05
	dc.b	$09,$09,"sea, ",$0C,$77," no ",$0C,$AF,"'s",$09,$0C,$83," ",$0C,$72," ",$0C,$69," to",$09,$0C,$85," ",$0C,$D3
	dc.b	" entrance.",$05

Bank020000_DialogueScriptMidBlock_020C10:
	dc.b	$00

; "I am [the] Prince of DarkWorld, [one] [you] be [the]..." (boss pre-battle speech)
Bank020000_DialogueScript_DarkWorldPrince_020C11:
	dc.b	$0C,$06,$07,"I am ",$0C,$D3," Prince of",$09,"DarkWorld, ",$0C,$6F," ",$0C,$E6,$09,$0C,$AA," be ",$0C,$D3,$05
	dc.b	$09,$0C,$9F," ",$0C,$94,".",$05,$09,$09,"I ",$0C,$E0," under ",$0C,$D3,$09,"control of Biomeka,",$09
	dc.b	"a deadly creature",$05,$09,$0C,$89," outer space, ",$0C,$77,$09,"I'm alright ",$0C,$AE,".",$05
	dc.b	$09,$09,$0C,$61," ",$0C,$E6," ",$0C,$86," coming",$09,"to my aid....",$08,$09,$05

Bank020000_DialogueScriptMidBlock_020CC4:
	dc.b	$00

; "Some [magic]." / "Is [that] [the] best [you] [probably] do?" / "Well, watch [?]!"
Bank020000_DialogueScript_SomeMagic_020CC5:
	dc.b	$0C,$06,$07,"Some ",$0C,$94,".",$09,"Is ",$0C,$D2," ",$0C,$D3," best ",$0C,$E6,$09,$0C,$78," do?",$05
	dc.b	$09,$09,"Well, watch ",$0C,$D8,"!",$05

Bank020000_DialogueScriptMidBlock_020CFB:
	dc.b	$00

; "Not too bad, eh?" / "[Shion], let's [close] if [you]'ve [sword] [?] it takes."
Bank020000_DialogueScript_NotTooBad_020CFC:
	dc.b	$0C,$06,$07,"Not too bad, eh?",$09,$0C,$55,", let's ",$0C,$C1," if",$09,$0C,$E6,"'ve ",$0C,$8E," ",$0C,$E3," it",$05
	dc.b	$09,"takes.",$0B,$28,$05

Bank020000_DialogueScriptMidBlock_020D39:
	dc.b	$00

; "[more]'re really [stock] to go, aren't [you]..." multi-string farewell block
Bank020000_DialogueScript_FarewellBlock_020D3A:
	dc.b	$0C,$06,$0C,$68,"'re really ",$0C,$8B,$09,"to go,aren't ",$0C,$E6,"...",$05,$09,$09,"Can't ",$0C,$E6
	dc.b	" stay ",$0C,$E5,$09,"me?",$09,$05,$09,"No, ",$0C,$E6,"'re ",$0C,$D3,$09,$0C,$9F," ",$0C,$94,".",$09,$05
	dc.b	$09,$0C,$68," ",$0C,$AA," go.",$09,$05,$09,"Be sure to ",$0C,$7D,$09,$0C,$71," ",$0C,$BE,".",$05,$09,$09
	dc.b	"I'll be ",$0C,$DF," ",$0C,$BD,$09,"here ",$0C,$86," ",$0C,$E6,".",$05

Bank020000_DialogueScriptMidBlock_020DCB:
	dc.b	$00

Bank020000_DialogueScriptMidBlock_020DCC:
	dc.b	$03,$06,$04,$01,$07,$0B,$17,$36

Bank020000_DialogueScriptMidBlock_020DD4:
	dc.b	$00

Bank020000_DialogueScriptMidBlock_020DD5:
	dc.b	$25,$0B,$17,$37

Bank020000_DialogueScriptMidBlock_020DD9:
	dc.b	$00

; "[Charmstone].c's a convenient [?] slot...."
Bank020000_DialogueScript_ConvenientSlot_020DDA:
	dc.b	"C",$0C,$63,"'s a convenient",$02,$04,$01,"slot....",$05

Bank020000_DialogueScriptMidBlock_020DF8:
	dc.b	$00

; "[?] [R] [Sphinx] inserts [the] [?] Gold Gem."
Bank020000_DialogueScript_InsertGoldGem_020DF9:
	dc.b	$0B,$14,$52,$0C,$5E," inserts ",$0C,$D3,$02,$04,$01,"Gold Gem.",$0B,$0A,$36,$0B,$29,$05

Bank020000_DialogueScriptMidBlock_020E1B:
	dc.b	$00

; "[look] Gem doesn't fit!"
Bank020000_DialogueScript_GemDoesntFit_020E1C:
	dc.b	$0C,$62," Gem doesn't fit!",$05

Bank020000_DialogueScriptMidBlock_020E30:
	dc.b	$00

Bank020000_DialogueScriptMidBlock_020E31:
	dc.b	$03,$06,$04,$01,$07,$0B,$17,$37

Bank020000_DialogueScriptMidBlock_020E39:
	dc.b	$00

; Tail fragment: "[?][R][Sphinx] ins[erts...]" (continues into front_records_b)
Bank020000_DialogueScriptMidBlock_020E3A:
	dc.b	$0A,$0B,$17,$36,$FF,$DE,$06,$FF,$9A,$0B,$14,$53,$0C,$5E," ins"
