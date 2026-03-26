; ROM range: 0x021720-0x021B7F
; Inventory/equipment/magic/item name tables followed by a bank-local keyword/name table.
; The wrapped 0x01A0/0x0180 control bytes in the second string block are still only partly
; understood, so keep them explicit in source while using proven Wonder Boy names.
; Bank020000_LocalTextTablePointerList_0211CA points here directly, so this remains a proven
; bank-local inventory/equipment/item-name resource. However, the shop offer placeholder at
; 0x021B80 does not jump here directly: the traced $0C indirection first lands in the mixed
; 0x0211CA-derived control stream around 0x0211CC before continuing onward.

Bank020000_InventoryNameOffsetTable_021720:
	dc.w	InventoryName_Weapon_LegendSword_0217A2-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Weapon_Excalibur_0217AF-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Weapon_KnightSword_0217B9-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Weapon_Gradius_0217C6-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Weapon_BattleSpear_0217CE-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Weapon_Trident_0217DB-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Weapon_SmallSpear_0217E3-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Weapon_PygmySword_0217EF-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Armor_LegendArmor_0217FB-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Armor_FlameArmor_021808-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Armor_KnightArmor_021814-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Armor_SteelArmor_021821-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Armor_HardArmor_02182D-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Armor_ChainMail_021838-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Armor_LeatherArmor_021843-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Armor_PygmyArmor_021851-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Shield_LegendShield_02185D-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Shield_FlameShield_02186B-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Shield_KnightShield_021878-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Shield_SteelShield_021886-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Shield_HardShield_021893-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Shield_ShellShield_02189F-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Shield_WoodShield_0218AC-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Shield_PygmyShield_0218B8-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Boots_LegendBoots_0218C5-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Boots_CeramicBoots_0218D2-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Boots_OasisBoots_0218E0-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Boots_MarineBoots_0218EC-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Boots_LadderBoots_0218F9-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Boots_LeatherBoots_021906-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Boots_ClothBoots_021914-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Boots_PygmyBoots_021920-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Magic_FireStorm_02192C-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Magic_Quake_021937-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Magic_Thunder_02193D-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Magic_Power_021945-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Magic_Shield_02194B-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Magic_Return_021952-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Unknown_021959-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Magic_FireStorm_02192C-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_Ocarina_021960-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_Charmstone_021968-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_Elixir_021973-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_Medicine_02197A-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_Potion_021983-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_Holywater_02198A-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_HiPotion_021994-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_Ocarina_021960-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Unknown_02199E-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_Lamp_0219A3-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_Amulet_0219A8-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_SunKey_0219AF-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_MoonKey_0219B7-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_StarKey_0219C0-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_GoldGem_0219C9-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_BlueGem_0219D2-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_OldAxe_0219DB-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_FireUrn_0219E3-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_Bracelet_0219EC-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_RapidPad_0219F5-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Unknown_02199E-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Unknown_02199E-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Unknown_02199E-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Unknown_02199E-Bank020000_InventoryNameOffsetTable_021720
	dc.w	InventoryName_Item_Heart_0219FF-Bank020000_InventoryNameOffsetTable_021720

InventoryName_Weapon_LegendSword_0217A2:
	dc.b	"Legend Sword",$00
InventoryName_Weapon_Excalibur_0217AF:
	dc.b	"Excalibur",$00
InventoryName_Weapon_KnightSword_0217B9:
	dc.b	"Knight Sword",$00
InventoryName_Weapon_Gradius_0217C6:
	dc.b	"Gradius",$00
InventoryName_Weapon_BattleSpear_0217CE:
	dc.b	"Battle Spear",$00
InventoryName_Weapon_Trident_0217DB:
	dc.b	"Trident",$00
InventoryName_Weapon_SmallSpear_0217E3:
	dc.b	"Small Spear",$00
InventoryName_Weapon_PygmySword_0217EF:
	dc.b	"Pygmy Sword",$00
InventoryName_Armor_LegendArmor_0217FB:
	dc.b	"Legend Armor",$00
InventoryName_Armor_FlameArmor_021808:
	dc.b	"Flame Armor",$00
InventoryName_Armor_KnightArmor_021814:
	dc.b	"Knight Armor",$00
InventoryName_Armor_SteelArmor_021821:
	dc.b	"Steel Armor",$00
InventoryName_Armor_HardArmor_02182D:
	dc.b	"Hard Armor",$00
InventoryName_Armor_ChainMail_021838:
	dc.b	"Chain mail",$00
InventoryName_Armor_LeatherArmor_021843:
	dc.b	"Leather Armor",$00
InventoryName_Armor_PygmyArmor_021851:
	dc.b	"Pygmy Armor",$00
InventoryName_Shield_LegendShield_02185D:
	dc.b	"Legend Shield",$00
InventoryName_Shield_FlameShield_02186B:
	dc.b	"Flame Shield",$00
InventoryName_Shield_KnightShield_021878:
	dc.b	"Knight Shield",$00
InventoryName_Shield_SteelShield_021886:
	dc.b	"Steel Shield",$00
InventoryName_Shield_HardShield_021893:
	dc.b	"Hard Shield",$00
InventoryName_Shield_ShellShield_02189F:
	dc.b	"Shell Shield",$00
InventoryName_Shield_WoodShield_0218AC:
	dc.b	"Wood Shield",$00
InventoryName_Shield_PygmyShield_0218B8:
	dc.b	"Pygmy Shield",$00
InventoryName_Boots_LegendBoots_0218C5:
	dc.b	"Legend Boots",$00
InventoryName_Boots_CeramicBoots_0218D2:
	dc.b	"Ceramic Boots",$00
InventoryName_Boots_OasisBoots_0218E0:
	dc.b	"Oasis Boots",$00
InventoryName_Boots_MarineBoots_0218EC:
	dc.b	"Marine Boots",$00
InventoryName_Boots_LadderBoots_0218F9:
	dc.b	"Ladder Boots",$00
InventoryName_Boots_LeatherBoots_021906:
	dc.b	"Leather Boots",$00
InventoryName_Boots_ClothBoots_021914:
	dc.b	"Cloth Boots",$00
InventoryName_Boots_PygmyBoots_021920:
	dc.b	"Pygmy Boots",$00
InventoryName_Magic_FireStorm_02192C:
	dc.b	"Fire Storm",$00
InventoryName_Magic_Quake_021937:
	dc.b	"Quake",$00
InventoryName_Magic_Thunder_02193D:
	dc.b	"Thunder",$00
InventoryName_Magic_Power_021945:
	dc.b	"Power",$00
InventoryName_Magic_Shield_02194B:
	dc.b	"Shield",$00
InventoryName_Magic_Return_021952:
	dc.b	"Return",$00
InventoryName_Unknown_021959:
	dc.b	$AF,$AE,$93,$A9,$B3,$A4,$00
InventoryName_Item_Ocarina_021960:
	dc.b	"Ocarina",$00
InventoryName_Item_Charmstone_021968:
	dc.b	"Charmstone",$00
InventoryName_Item_Elixir_021973:
	dc.b	"Elixir",$00
InventoryName_Item_Medicine_02197A:
	dc.b	"Medicine",$00
InventoryName_Item_Potion_021983:
	dc.b	"Potion",$00
InventoryName_Item_Holywater_02198A:
	dc.b	"Holywater",$00
InventoryName_Item_HiPotion_021994:
	dc.b	"Hi-Potion",$00
InventoryName_Unknown_02199E:
	dc.b	$FB,$CF,$FE,$E4,$00
InventoryName_Item_Lamp_0219A3:
	dc.b	"Lamp",$00
InventoryName_Item_Amulet_0219A8:
	dc.b	"Amulet",$00
InventoryName_Item_SunKey_0219AF:
	dc.b	"Sun-Key",$00
InventoryName_Item_MoonKey_0219B7:
	dc.b	"Moon-Key",$00
InventoryName_Item_StarKey_0219C0:
	dc.b	"Star-Key",$00
InventoryName_Item_GoldGem_0219C9:
	dc.b	"Gold-Gem",$00
InventoryName_Item_BlueGem_0219D2:
	dc.b	"Blue-Gem",$00
InventoryName_Item_OldAxe_0219DB:
	dc.b	"Old Axe",$00
InventoryName_Item_FireUrn_0219E3:
	dc.b	"Fire-Urn",$00
InventoryName_Item_Bracelet_0219EC:
	dc.b	"Bracelet",$00
InventoryName_Item_RapidPad_0219F5:
	dc.b	"Rapid Pad",$00
InventoryName_Item_Heart_0219FF:
	dc.b	"Heart",$00
	dc.b	$00

Bank020000_WorldKeywordOffsetTable_021A06:
	dc.w	WorldKeywordName_Shion_021A5C-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Alsedo_021A62-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_MaughamDesert_021A6D-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Lilypad_021A80-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Begonia_021A8C-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Unknown_021AA4-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Purapril_021AAF-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_IceCapital_021ABC-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_CastleOfIllusion_021ACC-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Childam_021A98-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Eleanora_021AE3-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Myconid_021AF0-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Monster_021AFC-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Priscilla_021B04-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Poseidon_021B12-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_ShielaPurapril_021B1F-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Sphinx_021B33-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Hotta_021B3E-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_PrinceOfTheDevilWorld_021B48-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_BioMecha_021B66-Bank020000_WorldKeywordOffsetTable_021A06
	dc.w	WorldKeywordName_Shabo_021B74-Bank020000_WorldKeywordOffsetTable_021A06

WorldKeywordName_Shion_021A5C:
	dc.b	"Shion",$00
WorldKeywordName_Alsedo_021A62:
	dc.b	$01,$A0,"Alsedo",$01,$80,$00
WorldKeywordName_MaughamDesert_021A6D:
	dc.b	$01,$A0,"Maugham Desert",$01,$80,$00
WorldKeywordName_Lilypad_021A80:
	dc.b	$01,$A0,"Lilypad",$01,$80,$00
WorldKeywordName_Begonia_021A8C:
	dc.b	$01,$A0,"Begonia",$01,$80,$00
WorldKeywordName_Childam_021A98:
	dc.b	$01,$A0,"Childam",$01,$80,$00
WorldKeywordName_Unknown_021AA4:
	dc.b	$01,$A0,$FF,$EA,$D2,$D1,$FA,$DD,$01,$80,$00
WorldKeywordName_Purapril_021AAF:
	dc.b	$01,$A0,"Purapril",$01,$80,$00
WorldKeywordName_IceCapital_021ABC:
	dc.b	$01,$A0,"Ice Capital",$01,$80,$00
WorldKeywordName_CastleOfIllusion_021ACC:
	dc.b	$01,$A0,"Castle of Illusion",$01,$80,$00
WorldKeywordName_Eleanora_021AE3:
	dc.b	$01,$A0,"Eleanora",$01,$80,$00
WorldKeywordName_Myconid_021AF0:
	dc.b	$01,$A0,"Myconid",$01,$80,$00
WorldKeywordName_Monster_021AFC:
	dc.b	"Monster",$00
WorldKeywordName_Priscilla_021B04:
	dc.b	$01,$A0,"Priscilla",$01,$80,$00
WorldKeywordName_Poseidon_021B12:
	dc.b	$01,$A0,"Poseidon",$01,$80,$00
WorldKeywordName_ShielaPurapril_021B1F:
	dc.b	$01,$A0,"Shiela Purapril",$01,$80,$00
WorldKeywordName_Sphinx_021B33:
	dc.b	$01,$A0,"Sphinx",$01,$80,$00
WorldKeywordName_Hotta_021B3E:
	dc.b	$01,$A0,"Hotta",$01,$80,$00
WorldKeywordName_PrinceOfTheDevilWorld_021B48:
	dc.b	$01,$A0,"Prince of the Devil World",$01,$80,$00
WorldKeywordName_BioMecha_021B66:
	dc.b	$01,$A0,"Bio-Mecha",$01,$80,$00
WorldKeywordName_Shabo_021B74:
	dc.b	$01,$A0,"Shabo",$01,$80,$00,$0C,$06
