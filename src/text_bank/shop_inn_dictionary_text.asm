; ROM range: 0x021B80-0x02245F
; Mixed text-bearing region with shop/inn prompts, Ocarina door guidance, and a null-
; terminated dialogue dictionary. Control bytes are still only partly decoded, so keep
; them byte-explicit while naming the proven higher-level text owners.
; The equipment-shop offer at 0x021B80 is a template rather than an inline item list.
; Tracing the init-region text builder at 0x001E6A shows that $0C enters an indirect stream
; lookup rooted at 0x001CC10 entry 0 (= 0x0211CA): here $0C,$02 lands at 0x0211CC and
; $0C,$03 lands at 0x0228EA. The parallel inn prompt's $0C,$05 lands at 0x022BD0.
; Decimal price rendering itself is handled by the nearby formatter at 0x001F46.

Bank020000_EquipmentShopOfferText_021B80:
	dc.b	"You have a",$09,"discriminating eye.",$09,$05,$09,"That's",$09
	dc.b	$0C,$02,".",$09,$05,"It costs",$0C,$03
	dc.b	".",$05,$09,"Would you like to",$09,"purchase it?",$0C,$00

Bank020000_EquipmentShopOfferChoiceScript_021BDA:
	dc.b	$0B,$02,$03,$08,$00

Bank020000_EquipmentShopAcceptLeadIn_021BDF:
	dc.b	"'",$09,$03,$06,$0B,$03,$00

Bank020000_EquipmentShopThankYouText_021BE6:
	dc.b	"h",$0B,$07,$0B,$08,$FF,$0B,$09
	dc.b	$09,"Thank you very much.",$05,$00

Bank020000_EquipmentShopDeclineText_021C05:
	dc.b	$09,$03,$06,"You've decided",$09,"against it?",$09,"That's too bad."
	dc.b	$05,$09,$09,"Please stop in",$09,"again.",$09,$05
	dc.b	$00

Bank020000_EquipmentShopNotEnoughGoldText_021C4D:
	dc.b	$0B,$19,"5",$09,"I'm sorry,",$05,$09,"but you don't have"
	dc.b	$09,"enough money to",$09,"purchase this item.",$05,$09,$09,"Why don't you go"
	dc.b	$09,"get some money and",$09,"come back?",$05,$00

Bank020000_InnWelcomeAndStayPromptText_021CC6:
	dc.b	$0A,$02,$03,$06,$04,$02,"Welcome to my inn.",$05
	dc.b	$09,$09,"You can have a good",$09,"night's rest for",$02,$0C,$05
	dc.b	".",$05,$09,"Will you be staying",$09,"overnight?",$0C,$00

Bank020000_InnStayChoiceScript_021D2B:
	dc.b	$0B,$02,$03,$08,$FE,$D6,$09,$03
	dc.b	$06,$0B,$03,$00

Bank020000_InnStayAcceptedLeadIn_021D37:
	dc.b	$09,$0B,$07,$0B,$15,$06,$00

Bank020000_InnSavePromptText_021D3E:
	dc.b	"[",$09,"Oh, you don't have",$09,"enough GOLD?",$09,"That's OK.",$05
	dc.b	$09,$09,"I'll accept whatever",$09,"you can afford.",$05,$09,$09
	dc.b	$0B,$10,$0B,$15,"Do you wish to save",$09,"your adventure?",$0C
	dc.b	$00

Bank020000_InnSaveChoiceScript_021DBD:
	dc.b	$0B,$02,$03,$08,$00

Bank020000_InnSaveAcceptedText_021DC2:
	dc.b	$1A,$03,$06,$09,$0B,$0B,"Your game is saved.",$03
	dc.b	$06,$09,"Will you be",$09,"continuing your",$05,$09,"journey in the"
	dc.b	$09,"morning?",$0C,$00

Bank020000_InnContinueChoiceScript_021E14:
	dc.b	$0B,$02,$03,$08,$00

Bank020000_InnGoodNightText_021E19:
	dc.b	"'",$09,$03,$06,"Good night and",$09,"pleasant dreams.",$0B
	dc.b	$0D,$00

Bank020000_InnDeclineStayText_021E3F:
	dc.b	$09,$03,$06,"Oh well, maybe",$09,"another day.",$09,"Good night."
	dc.b	$0B,$0C,$00

Bank020000_OcarinaPracticeIntroText_021E6C:
	dc.b	$09,$09,$0B,$1C,$09,"OK, give it a try.",$0B,$1A
	dc.b	$FF,$00

Bank020000_OcarinaPracticePromptBang_021E87:
	dc.b	"!",$00

Bank020000_OcarinaPracticeFeedbackText_021E89:
	dc.b	"E",$09,$09,"That's awful!",$09,"Try again.",$06,$FF
	dc.b	$C7,$09,$09,"You're not even",$09,"close.",$09,"Once more."
	dc.b	$06,$FF,$A1,$09,$09,"There you go!",$09,"That's very good!"
	dc.b	$0B,$18,"(",$09,$09,$00

Bank020000_OcarinaPracticeGuideRow0_021EF4:
	dc.b	$0B,$19,$18,$10," ",$00

Bank020000_OcarinaPracticeGuideRow1_021EFA:
	dc.b	$0B,$19,$19,$11," ",$00

Bank020000_OcarinaPracticeGuideRow2_021F00:
	dc.b	$0B,$19,$1A,$12," ",$00

Bank020000_OcarinaPracticeScript_021F06:
	dc.b	$05,$0B,$22,$03,$08,$0B," ",$0B
	dc.b	"2",$02,$0B,$1F,$00

Bank020000_OcarinaPracticeScriptTail_021F13:
	dc.b	$0B,"2",$05,$03,$00

Bank020000_OcarinaPracticeMelodyScript_021F18:
	dc.b	$0B,$1E,$01,$02,$10," ",$0B,$1F
	dc.b	$01,$02," ",$11," ",$0B,$1F,$02
	dc.b	$02," ",$12," ",$0B,$1F,$03,$0B
	dc.b	"!",$0B,$18,$1E,$0B," ",$00

Bank020000_OcarinaFirstDoorHintText_021F37:
	dc.b	$09,$07,"This is the melody",$09,"for the first door.",$0B,$0A,$00

Bank020000_OcarinaSecondAndFinalDoorHintText_021F62:
	dc.b	$0B,$1B,$0C,$08,$0F,$02,"The next melody",$09
	dc.b	"opens the second",$09,"door.",$0B,$0A,$01,$0B,$1B
	dc.b	$0C,$09,$0F,$02,"The last melody",$09,"opens the final",$09
	dc.b	"door.",$0B,$0A,$02,$0B,$1B,$0C,$0A
	dc.b	$0F,$02,$08,$05,$09,$00

Bank020000_OcarinaEmptyTextRecord_021FC9:
	dc.b	$00

Bank020000_OcarinaMelodyUnknownData_021FCA:
	dc.b	$FB,$B4,$FC,$FC,$FE,$A2,$FF,"*"
	dc.b	$FF,"0",$FF,"6",$FF,"<",$FF,"m"
	dc.b	$00

Bank020000_OcarinaSingleSpaceText_021FDB:
	dc.b	" ",$00

Bank020000_OcarinaZeroPad_021FDD:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00

Bank020000_PyramidTransitionHintText_021FEA:
	dc.b	$05,$02,$02,"Jump from the top",$02,"of the Pyramid",$02,"and enter a new"
	dc.b	$02,"world.",$05,$00

Bank020000_DialogueDictionaryWordTable_022026:
Bank020000_DialogueDictionaryWord_022026:
	dc.b	"Alsedo",$00
Bank020000_DialogueDictionaryWord_02202D:
	dc.b	"Amulet",$00
Bank020000_DialogueDictionaryWord_022034:
	dc.b	"Axe",$00
Bank020000_DialogueDictionaryWord_022038:
	dc.b	"Blacksmith",$00
Bank020000_DialogueDictionaryWord_022043:
	dc.b	"Bracelet",$00
Bank020000_DialogueDictionaryWord_02204C:
	dc.b	"Castle",$00
Bank020000_DialogueDictionaryWord_022053:
	dc.b	"Charmstone",$00
Bank020000_DialogueDictionaryWord_02205E:
	dc.b	"Charmstones",$00
Bank020000_DialogueDictionaryWord_02206A:
	dc.b	"Come",$00
Bank020000_DialogueDictionaryWord_02206F:
	dc.b	"Continue",$00
Bank020000_DialogueDictionaryWord_022078:
	dc.b	"Desert",$00
Bank020000_DialogueDictionaryWord_02207F:
	dc.b	"Dragon",$00
Bank020000_DialogueDictionaryWord_022086:
	dc.b	"Elder",$00
Bank020000_DialogueDictionaryWord_02208C:
	dc.b	"Eleanora",$00
Bank020000_DialogueDictionaryWord_022095:
	dc.b	"Find",$00
Bank020000_DialogueDictionaryWord_02209A:
	dc.b	"Good",$00
Bank020000_DialogueDictionaryWord_02209F:
	dc.b	"Here",$00
Bank020000_DialogueDictionaryWord_0220A4:
	dc.b	"Lilypad",$00
Bank020000_DialogueDictionaryWord_0220AC:
	dc.b	"Looks",$00
Bank020000_DialogueDictionaryWord_0220B2:
	dc.b	"Maugham",$00
Bank020000_DialogueDictionaryWord_0220BA:
	dc.b	"Monster",$00
Bank020000_DialogueDictionaryWord_0220C2:
	dc.b	"Now",$00
Bank020000_DialogueDictionaryWord_0220C6:
	dc.b	"Ocarina",$00
Bank020000_DialogueDictionaryWord_0220CE:
	dc.b	"Please",$00
Bank020000_DialogueDictionaryWord_0220D5:
	dc.b	"Poseidon",$00
Bank020000_DialogueDictionaryWord_0220DE:
	dc.b	"Priscilla",$00
Bank020000_DialogueDictionaryWord_0220E8:
	dc.b	"Purapril",$00
Bank020000_DialogueDictionaryWord_0220F1:
	dc.b	"Pygmy",$00
Bank020000_DialogueDictionaryWord_0220F7:
	dc.b	"Queen",$00
Bank020000_DialogueDictionaryWord_0220FD:
	dc.b	"Remember",$00
Bank020000_DialogueDictionaryWord_022106:
	dc.b	"Shion",$00
Bank020000_DialogueDictionaryWord_02210C:
	dc.b	"Sphinx",$00
Bank020000_DialogueDictionaryWord_022113:
	dc.b	"Take",$00
Bank020000_DialogueDictionaryWord_022118:
	dc.b	"Thank",$00
Bank020000_DialogueDictionaryWord_02211E:
	dc.b	"The",$00
Bank020000_DialogueDictionaryWord_022122:
	dc.b	"There",$00
Bank020000_DialogueDictionaryWord_022128:
	dc.b	"This",$00
Bank020000_DialogueDictionaryWord_02212D:
	dc.b	"Welcome",$00
Bank020000_DialogueDictionaryWord_022135:
	dc.b	"What",$00
Bank020000_DialogueDictionaryWord_02213A:
	dc.b	"World",$00
Bank020000_DialogueDictionaryWord_022140:
	dc.b	"You",$00
Bank020000_DialogueDictionaryWord_022144:
	dc.b	"able",$00
Bank020000_DialogueDictionaryWord_022149:
	dc.b	"about",$00
Bank020000_DialogueDictionaryWord_02214F:
	dc.b	"again",$00
Bank020000_DialogueDictionaryWord_022155:
	dc.b	"ahead",$00
Bank020000_DialogueDictionaryWord_02215B:
	dc.b	"all",$00
Bank020000_DialogueDictionaryWord_02215F:
	dc.b	"already",$00
Bank020000_DialogueDictionaryWord_022167:
	dc.b	"and",$00
Bank020000_DialogueDictionaryWord_02216B:
	dc.b	"anything",$00
Bank020000_DialogueDictionaryWord_022174:
	dc.b	"back",$00
Bank020000_DialogueDictionaryWord_022179:
	dc.b	"been",$00
Bank020000_DialogueDictionaryWord_02217E:
	dc.b	"better",$00
Bank020000_DialogueDictionaryWord_022185:
	dc.b	"beyond",$00
Bank020000_DialogueDictionaryWord_02218C:
	dc.b	"bottom",$00
Bank020000_DialogueDictionaryWord_022193:
	dc.b	"brother",$00
Bank020000_DialogueDictionaryWord_02219B:
	dc.b	"but",$00
Bank020000_DialogueDictionaryWord_02219F:
	dc.b	"can",$00
Bank020000_DialogueDictionaryWord_0221A3:
	dc.b	"castle",$00
Bank020000_DialogueDictionaryWord_0221AA:
	dc.b	"cave",$00
Bank020000_DialogueDictionaryWord_0221AF:
	dc.b	"close",$00
Bank020000_DialogueDictionaryWord_0221B5:
	dc.b	"closed",$00
Bank020000_DialogueDictionaryWord_0221BC:
	dc.b	"come",$00
Bank020000_DialogueDictionaryWord_0221C1:
	dc.b	"desert",$00
Bank020000_DialogueDictionaryWord_0221C8:
	dc.b	"don",$00
Bank020000_DialogueDictionaryWord_0221CC:
	dc.b	"door",$00
Bank020000_DialogueDictionaryWord_0221D1:
	dc.b	"dwarf",$00
Bank020000_DialogueDictionaryWord_0221D7:
	dc.b	"enter",$00
Bank020000_DialogueDictionaryWord_0221DD:
	dc.b	"ever",$00
Bank020000_DialogueDictionaryWord_0221E2:
	dc.b	"everything",$00
Bank020000_DialogueDictionaryWord_0221ED:
	dc.b	"find",$00
Bank020000_DialogueDictionaryWord_0221F2:
	dc.b	"for",$00
Bank020000_DialogueDictionaryWord_0221F6:
	dc.b	"forget",$00
Bank020000_DialogueDictionaryWord_0221FD:
	dc.b	"four",$00
Bank020000_DialogueDictionaryWord_022202:
	dc.b	"from",$00
Bank020000_DialogueDictionaryWord_022207:
	dc.b	"generation",$00
Bank020000_DialogueDictionaryWord_022212:
	dc.b	"going",$00
Bank020000_DialogueDictionaryWord_022218:
	dc.b	"gonna",$00
Bank020000_DialogueDictionaryWord_02221E:
	dc.b	"good",$00
Bank020000_DialogueDictionaryWord_022223:
	dc.b	"got",$00
Bank020000_DialogueDictionaryWord_022227:
	dc.b	"grateful",$00
Bank020000_DialogueDictionaryWord_022230:
	dc.b	"has",$00
Bank020000_DialogueDictionaryWord_022234:
	dc.b	"have",$00
Bank020000_DialogueDictionaryWord_022239:
	dc.b	"heard",$00
Bank020000_DialogueDictionaryWord_02223F:
	dc.b	"help",$00
Bank020000_DialogueDictionaryWord_022244:
	dc.b	"hero",$00
Bank020000_DialogueDictionaryWord_022249:
	dc.b	"hidden",$00
Bank020000_DialogueDictionaryWord_022250:
	dc.b	"increase",$00
Bank020000_DialogueDictionaryWord_022259:
	dc.b	"item",$00
Bank020000_DialogueDictionaryWord_02225E:
	dc.b	"items",$00
Bank020000_DialogueDictionaryWord_022264:
	dc.b	"jellyfish",$00
Bank020000_DialogueDictionaryWord_02226E:
	dc.b	"journey",$00
Bank020000_DialogueDictionaryWord_022276:
	dc.b	"just",$00
Bank020000_DialogueDictionaryWord_02227B:
	dc.b	"kidnapped",$00
Bank020000_DialogueDictionaryWord_022285:
	dc.b	"know",$00
Bank020000_DialogueDictionaryWord_02228A:
	dc.b	"land",$00
Bank020000_DialogueDictionaryWord_02228F:
	dc.b	"legendary",$00
Bank020000_DialogueDictionaryWord_022299:
	dc.b	"like",$00
Bank020000_DialogueDictionaryWord_02229E:
	dc.b	"long",$00
Bank020000_DialogueDictionaryWord_0222A3:
	dc.b	"look",$00
Bank020000_DialogueDictionaryWord_0222A8:
	dc.b	"looks",$00
Bank020000_DialogueDictionaryWord_0222AE:
	dc.b	"magic",$00
Bank020000_DialogueDictionaryWord_0222B4:
	dc.b	"may",$00
Bank020000_DialogueDictionaryWord_0222B8:
	dc.b	"melodies",$00
Bank020000_DialogueDictionaryWord_0222C1:
	dc.b	"monsters",$00
Bank020000_DialogueDictionaryWord_0222CA:
	dc.b	"more",$00
Bank020000_DialogueDictionaryWord_0222CF:
	dc.b	"much",$00
Bank020000_DialogueDictionaryWord_0222D4:
	dc.b	"must",$00
Bank020000_DialogueDictionaryWord_0222D9:
	dc.b	"need",$00
Bank020000_DialogueDictionaryWord_0222DE:
	dc.b	"not",$00
Bank020000_DialogueDictionaryWord_0222E2:
	dc.b	"nothing",$00
Bank020000_DialogueDictionaryWord_0222EA:
	dc.b	"now",$00
Bank020000_DialogueDictionaryWord_0222EE:
	dc.b	"one",$00
Bank020000_DialogueDictionaryWord_0222F2:
	dc.b	"only",$00
Bank020000_DialogueDictionaryWord_0222F7:
	dc.b	"other",$00
Bank020000_DialogueDictionaryWord_0222FD:
	dc.b	"out",$00
Bank020000_DialogueDictionaryWord_022301:
	dc.b	"peaceful",$00
Bank020000_DialogueDictionaryWord_02230A:
	dc.b	"people",$00
Bank020000_DialogueDictionaryWord_022311:
	dc.b	"place",$00
Bank020000_DialogueDictionaryWord_022317:
	dc.b	"practice",$00
Bank020000_DialogueDictionaryWord_022320:
	dc.b	"princess",$00
Bank020000_DialogueDictionaryWord_022329:
	dc.b	"probably",$00
Bank020000_DialogueDictionaryWord_022332:
	dc.b	"question",$00
Bank020000_DialogueDictionaryWord_02233B:
	dc.b	"ready",$00
Bank020000_DialogueDictionaryWord_022341:
	dc.b	"return",$00
Bank020000_DialogueDictionaryWord_022348:
	dc.b	"returned",$00
Bank020000_DialogueDictionaryWord_022351:
	dc.b	"right",$00
Bank020000_DialogueDictionaryWord_022357:
	dc.b	"safely",$00
Bank020000_DialogueDictionaryWord_02235E:
	dc.b	"saved",$00
Bank020000_DialogueDictionaryWord_022364:
	dc.b	"search",$00
Bank020000_DialogueDictionaryWord_02236B:
	dc.b	"see",$00
Bank020000_DialogueDictionaryWord_02236F:
	dc.b	"sell",$00
Bank020000_DialogueDictionaryWord_022374:
	dc.b	"shop",$00
Bank020000_DialogueDictionaryWord_022379:
	dc.b	"shrine",$00
Bank020000_DialogueDictionaryWord_022380:
	dc.b	"sleep",$00
Bank020000_DialogueDictionaryWord_022386:
	dc.b	"some",$00
Bank020000_DialogueDictionaryWord_02238B:
	dc.b	"something",$00
Bank020000_DialogueDictionaryWord_022395:
	dc.b	"sometime",$00
Bank020000_DialogueDictionaryWord_02239E:
	dc.b	"somewhere",$00
Bank020000_DialogueDictionaryWord_0223A8:
	dc.b	"sorry",$00
Bank020000_DialogueDictionaryWord_0223AE:
	dc.b	"stock",$00
Bank020000_DialogueDictionaryWord_0223B4:
	dc.b	"store",$00
Bank020000_DialogueDictionaryWord_0223BA:
	dc.b	"storekeeper",$00
Bank020000_DialogueDictionaryWord_0223C6:
	dc.b	"sword",$00
Bank020000_DialogueDictionaryWord_0223CC:
	dc.b	"take",$00
Bank020000_DialogueDictionaryWord_0223D1:
	dc.b	"terribly",$00
Bank020000_DialogueDictionaryWord_0223DA:
	dc.b	"thank",$00
Bank020000_DialogueDictionaryWord_0223E0:
	dc.b	"that",$00
Bank020000_DialogueDictionaryWord_0223E5:
	dc.b	"the",$00
Bank020000_DialogueDictionaryWord_0223E9:
	dc.b	"their",$00
Bank020000_DialogueDictionaryWord_0223EF:
	dc.b	"them",$00
Bank020000_DialogueDictionaryWord_0223F4:
	dc.b	"then",$00
Bank020000_DialogueDictionaryWord_0223F9:
	dc.b	"there",$00
Bank020000_DialogueDictionaryWord_0223FF:
	dc.b	"this",$00
Bank020000_DialogueDictionaryWord_022404:
	dc.b	"though",$00
Bank020000_DialogueDictionaryWord_02240B:
	dc.b	"time",$00
Bank020000_DialogueDictionaryWord_022410:
	dc.b	"underwater",$00
Bank020000_DialogueDictionaryWord_02241B:
	dc.b	"very",$00
Bank020000_DialogueDictionaryWord_022420:
	dc.b	"village",$00
Bank020000_DialogueDictionaryWord_022428:
	dc.b	"volcano",$00
Bank020000_DialogueDictionaryWord_022430:
	dc.b	"waiting",$00
Bank020000_DialogueDictionaryWord_022438:
	dc.b	"was",$00
Bank020000_DialogueDictionaryWord_02243C:
	dc.b	"weapon",$00
Bank020000_DialogueDictionaryWord_022443:
	dc.b	"well",$00
Bank020000_DialogueDictionaryWord_022448:
	dc.b	"what",$00
Bank020000_DialogueDictionaryWord_02244D:
	dc.b	"will",$00
Bank020000_DialogueDictionaryWord_022452:
	dc.b	"with",$00
Bank020000_DialogueDictionaryWord_022457:
	dc.b	"you",$00
Bank020000_DialogueDictionaryWord_02245B:
	dc.b	"your",$00
