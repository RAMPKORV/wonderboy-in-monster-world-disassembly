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
Bank020000_DialogueScript_ShopInventoryBlock_0208D7:
	incbin "data/rom/bank_020000_03ffff.bin",$0008D7,$00009C

Bank020000_DialogueScriptMidBlock_020973:
	incbin "data/rom/bank_020000_03ffff.bin",$000973,$000001

Bank020000_DialogueScriptMidBlock_020974:
	incbin "data/rom/bank_020000_03ffff.bin",$000974,$000001

Bank020000_DialogueScriptMidBlock_020975:
	incbin "data/rom/bank_020000_03ffff.bin",$000975,$000001

Bank020000_DialogueScriptMidBlock_020976:
	incbin "data/rom/bank_020000_03ffff.bin",$000976,$000001

Bank020000_DialogueScriptMidBlock_020977:
	incbin "data/rom/bank_020000_03ffff.bin",$000977,$000001

Bank020000_DialogueScriptMidBlock_020978:
	incbin "data/rom/bank_020000_03ffff.bin",$000978,$000001

Bank020000_DialogueScriptMidBlock_020979:
	incbin "data/rom/bank_020000_03ffff.bin",$000979,$000001

Bank020000_DialogueScriptMidBlock_02097A:
	incbin "data/rom/bank_020000_03ffff.bin",$00097A,$000001

Bank020000_DialogueScriptMidBlock_02097B:
	incbin "data/rom/bank_020000_03ffff.bin",$00097B,$000001

; "[more] [thank] satisfied [the] requirements." / "[more] [?] [sell]."
Bank020000_DialogueScript_EquipmentRequirements_02097C:
	incbin "data/rom/bank_020000_03ffff.bin",$00097C,$00002C

Bank020000_DialogueScriptMidBlock_0209A8:
	incbin "data/rom/bank_020000_03ffff.bin",$0009A8,$000001

; "One of [the] [this] is missing." / "I [?] [?] [close]."
Bank020000_DialogueScript_ItemMissing_0209A9:
	incbin "data/rom/bank_020000_03ffff.bin",$0009A9,$000024

Bank020000_DialogueScriptMidBlock_0209CD:
	incbin "data/rom/bank_020000_03ffff.bin",$0009CD,$000001

; "[more] [?] two [?] [this]." / "I [?] [?] [close]."
Bank020000_DialogueScript_TwoItems_0209CE:
	incbin "data/rom/bank_020000_03ffff.bin",$0009CE,$00001C

Bank020000_DialogueScriptMidBlock_0209EA:
	incbin "data/rom/bank_020000_03ffff.bin",$0009EA,$000001

; "[more] [?] [?] [?] of [the] [?] [you] [?]." / "I [?] [?] [close]."
Bank020000_DialogueScript_ThreeItems_0209EB:
	incbin "data/rom/bank_020000_03ffff.bin",$0009EB,$000027

Bank020000_DialogueScriptMidBlock_020A12:
	incbin "data/rom/bank_020000_03ffff.bin",$000A12,$000001

Bank020000_DialogueScript_AllItems_020A13:
	incbin "data/rom/bank_020000_03ffff.bin",$000A13,$000034

Bank020000_DialogueScriptMidBlock_020A47:
	incbin "data/rom/bank_020000_03ffff.bin",$000A47,$000001

; "Gragg & Glagg!"
Bank020000_DialogueScript_GraggGlagg_020A48:
	incbin "data/rom/bank_020000_03ffff.bin",$000A48,$000015

Bank020000_DialogueScriptMidBlock_020A5D:
	incbin "data/rom/bank_020000_03ffff.bin",$000A5D,$000001

; "[look] Ice Bomber!"
Bank020000_DialogueScript_IceBomber_020A5E:
	incbin "data/rom/bank_020000_03ffff.bin",$000A5E,$000015

Bank020000_DialogueScriptMidBlock_020A73:
	incbin "data/rom/bank_020000_03ffff.bin",$000A73,$000001

; "[look] Tyrant [going]!"
Bank020000_DialogueScript_Tyrant_020A74:
	incbin "data/rom/bank_020000_03ffff.bin",$000A74,$000014

Bank020000_DialogueScriptMidBlock_020A88:
	incbin "data/rom/bank_020000_03ffff.bin",$000A88,$000001

; "[look] Almighty Demon King!"
Bank020000_DialogueScript_AlmightyDemonKing_020A89:
	incbin "data/rom/bank_020000_03ffff.bin",$000A89,$00001E

Bank020000_DialogueScriptMidBlock_020AA7:
	incbin "data/rom/bank_020000_03ffff.bin",$000AA7,$000001

; "I've [that] [?] [legendary] [just] in [the] Pyramid likes quizzes."
Bank020000_DialogueScript_PyramidQuizzes_020AA8:
	incbin "data/rom/bank_020000_03ffff.bin",$000AA8,$000030

Bank020000_DialogueScriptMidBlock_020AD8:
	incbin "data/rom/bank_020000_03ffff.bin",$000AD8,$000001

; "If [you] [thank] a certain special [there], [you] [probably] swim [?]."
Bank020000_DialogueScript_SpecialItem_020AD9:
	incbin "data/rom/bank_020000_03ffff.bin",$000AD9,$000030

Bank020000_DialogueScriptMidBlock_020B09:
	incbin "data/rom/bank_020000_03ffff.bin",$000B09,$000001

; "[look] star crest on [the] Bell Tower is [the] same as [the] [?]..."
Bank020000_DialogueScript_BellTower_020B0A:
	incbin "data/rom/bank_020000_03ffff.bin",$000B0A,$000073

Bank020000_DialogueScriptMidBlock_020B7D:
	incbin "data/rom/bank_020000_03ffff.bin",$000B7D,$000001

Bank020000_DialogueScriptMidBlock_020B7E:
	incbin "data/rom/bank_020000_03ffff.bin",$000B7E,$000005

Bank020000_DialogueScriptMidBlock_020B83:
	incbin "data/rom/bank_020000_03ffff.bin",$000B83,$000001

; "[Shion]'re [?] strong." / "I hope [?] day I'll be so strong."
Bank020000_DialogueScript_Strong_020B84:
	incbin "data/rom/bank_020000_03ffff.bin",$000B84,$000036

Bank020000_DialogueScriptMidBlock_020BBA:
	incbin "data/rom/bank_020000_03ffff.bin",$000BBA,$000001

; "It is said [that] [?]'s a [?] at [the] [place] of [the] sea..."
Bank020000_DialogueScript_SeaShrineHint_020BBB:
	incbin "data/rom/bank_020000_03ffff.bin",$000BBB,$000055

Bank020000_DialogueScriptMidBlock_020C10:
	incbin "data/rom/bank_020000_03ffff.bin",$000C10,$000001

; "I am [the] Prince of DarkWorld, [one] [you] be [the]..." (boss pre-battle speech)
Bank020000_DialogueScript_DarkWorldPrince_020C11:
	incbin "data/rom/bank_020000_03ffff.bin",$000C11,$0000B3

Bank020000_DialogueScriptMidBlock_020CC4:
	incbin "data/rom/bank_020000_03ffff.bin",$000CC4,$000001

; "Some [magic]." / "Is [that] [the] best [you] [probably] do?" / "Well, watch [?]!"
Bank020000_DialogueScript_SomeMagic_020CC5:
	incbin "data/rom/bank_020000_03ffff.bin",$000CC5,$000036

Bank020000_DialogueScriptMidBlock_020CFB:
	incbin "data/rom/bank_020000_03ffff.bin",$000CFB,$000001

; "Not too bad, eh?" / "[Shion], let's [close] if [you]'ve [sword] [?] it takes."
Bank020000_DialogueScript_NotTooBad_020CFC:
	incbin "data/rom/bank_020000_03ffff.bin",$000CFC,$00003D

Bank020000_DialogueScriptMidBlock_020D39:
	incbin "data/rom/bank_020000_03ffff.bin",$000D39,$000001

; "[more]'re really [stock] to go, aren't [you]..." multi-string farewell block
Bank020000_DialogueScript_FarewellBlock_020D3A:
	incbin "data/rom/bank_020000_03ffff.bin",$000D3A,$000091

Bank020000_DialogueScriptMidBlock_020DCB:
	incbin "data/rom/bank_020000_03ffff.bin",$000DCB,$000001

Bank020000_DialogueScriptMidBlock_020DCC:
	incbin "data/rom/bank_020000_03ffff.bin",$000DCC,$000008

Bank020000_DialogueScriptMidBlock_020DD4:
	incbin "data/rom/bank_020000_03ffff.bin",$000DD4,$000001

Bank020000_DialogueScriptMidBlock_020DD5:
	incbin "data/rom/bank_020000_03ffff.bin",$000DD5,$000004

Bank020000_DialogueScriptMidBlock_020DD9:
	incbin "data/rom/bank_020000_03ffff.bin",$000DD9,$000001

; "[Charmstone].c's a convenient [?] slot...."
Bank020000_DialogueScript_ConvenientSlot_020DDA:
	incbin "data/rom/bank_020000_03ffff.bin",$000DDA,$00001E

Bank020000_DialogueScriptMidBlock_020DF8:
	incbin "data/rom/bank_020000_03ffff.bin",$000DF8,$000001

; "[?] [R] [Sphinx] inserts [the] [?] Gold Gem."
Bank020000_DialogueScript_InsertGoldGem_020DF9:
	incbin "data/rom/bank_020000_03ffff.bin",$000DF9,$000022

Bank020000_DialogueScriptMidBlock_020E1B:
	incbin "data/rom/bank_020000_03ffff.bin",$000E1B,$000001

; "[look] Gem doesn't fit!"
Bank020000_DialogueScript_GemDoesntFit_020E1C:
	incbin "data/rom/bank_020000_03ffff.bin",$000E1C,$000014

Bank020000_DialogueScriptMidBlock_020E30:
	incbin "data/rom/bank_020000_03ffff.bin",$000E30,$000001

Bank020000_DialogueScriptMidBlock_020E31:
	incbin "data/rom/bank_020000_03ffff.bin",$000E31,$000008

Bank020000_DialogueScriptMidBlock_020E39:
	incbin "data/rom/bank_020000_03ffff.bin",$000E39,$000001

; Tail fragment: "[?][R][Sphinx] ins[erts...]" (continues into front_records_b)
Bank020000_DialogueScriptMidBlock_020E3A:
	incbin "data/rom/bank_020000_03ffff.bin",$000E3A,$000012
