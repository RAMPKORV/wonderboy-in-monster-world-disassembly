; ROM range: 0x020000-0x0201CF
; Dialogue/script text continuation from the core region. This region carries the tail
; of NPC dialogue strings that begin in core_005000_01ffff (the last bytes of the core
; binary end mid-word at 0x01FFFF and resume here at 0x020000). Each record is a
; null-terminated (0x00) chunk of dialogue bytes. Control codes: 0x05=end-of-string,
; 0x09=newline, 0x0B NN=speaker/format command, 0x0C NN=dictionary word lookup,
; 0x02=wrap, 0x03/0x04/0x06/0x07=undecoded controls, 0x0F NN=undecoded 2-byte op.
; The dictionary word table (168 words, indices 0x00-0xA7) is at 0x022026. Indices
; 0xA8-0xFF reference a second word table not yet located.

Bank020000_DialogueScriptFrontContinuation_020000:
	dc.b	"n a",$09,"deep ",$0C,$C5,".",$05

Bank020000_DialogueScriptFrontContinuation_02000D:
	dc.b	$00

Bank020000_DialogueScriptFrontContinuation_02000E:
	dc.b	$0C,$06,$0B,$11,$10

Bank020000_DialogueScriptFrontContinuation_020013:
	dc.b	$00

Bank020000_DialogueScriptFrontContinuation_020014:
	dc.b	$2B,$0B,$13,$10,$0C,$62," ",$0C,$B7," ",$0C,$90,$09,$0C,$BC," ",$0C,$BE,".",$05,$09,$09
	dc.b	"I'm so relieved.",$09,$09,$05

Bank020000_DialogueScriptFrontContinuation_02003D:
	dc.b	$00

Bank020000_DialogueScriptFrontContinuation_02003E:
	dc.b	$0B,$12,$5B

Bank020000_DialogueScriptFrontContinuation_020041:
	dc.b	$00

Bank020000_DialogueScriptFrontContinuation_020042:
	dc.b	$10,$0C,$62," ",$0C,$B7," is",$09,$0C,$DF,".",$05

Bank020000_DialogueScriptFrontContinuation_020050:
	dc.b	$00

; "Make yourself at home."
Bank020000_DialogueScript_MakeYourselfAtHome_020051:
	dc.b	"Make yourself at",$09,"home.",$05

Bank020000_DialogueScriptFrontContinuation_020068:
	dc.b	$00

Bank020000_DialogueScriptFrontContinuation_020069:
	dc.b	$04,$02,$0C,$62," ",$0C,$80," ",$0C,$90," ",$0C,$72,$02,$04,$02,"sealed.",$05

Bank020000_DialogueScriptFrontContinuation_020081:
	dc.b	$00

; Multi-string NPC dialogue block: "So [you]'ve arrived.", "I'm so relieved.",
; "Tell [you] [what] I'm [store] do.", "I'm [store] ask [you] [...] questions -",
; "When [you]'ve answered [nothing] correctly, I'm [store] send [you] into a new world.",
; "Are [you] [?]?" and quiz-host final strings.
Bank020000_DialogueScriptNpcBlock_020082:
	dc.b	$0B,$23,$03,$06,$07,"So ",$0C,$E6,"'ve",$02,"arrived.",$05,$0B,$20,"As ",$0C,$E6," ",$0C,$A5," ",$0C,$91
	dc.b	$02,"guessed, I'm ",$0C,$D3,$02,$0C,$5F,".",$05,$0B,$20,"I've ",$0C,$8E," ",$0C,$D8,$02,"thing ",$0C,$86,$02
	dc.b	"quizzes,",$05,$02,$0C,$77," ",$0C,$D6," ",$0C,$E6,"'ve",$02,$0C,$B8," ",$0C,$92,$02,$0C,$D2," by ",$0C,$AE
	dc.b	".",$05,$0B,$20,"Tell ",$0C,$E6," ",$0C,$E3," I'm",$02,$0C,$8C," do.",$05,$0B,$20,"I'm ",$0C,$8C," ask ",$0C,$E6
	dc.b	$02,$0C,$C6," questions -",$02,"5, to be exact.",$05,$0B,$20,"When ",$0C,$E6,"'ve",$02,"answered ",$0C,$D5
	dc.b	" ",$0C,$6D,$02,"correctly, I'm",$02,$0C,$8C," send ",$0C,$E6,$02,"into a new world.",$05,$0B,$20,"Are ",$0C,$E6
	dc.b	" ",$0C,$BA,"?",$05,$0B,$20,$03

Bank020000_DialogueScriptFrontContinuation_020196:
	dc.b	$00

; "[has] [?] first [?]." / "[has] [?] second [?]." / "[has] [?] third [?]."
Bank020000_DialogueScriptOrdinalStrings_020197:
	dc.b	$0C,$50,"'s ",$0C,$D3," first",$02,$0C,$B9,".",$0F,$06,$0C,$50,"'s ",$0C,$D3," second",$02,$0C,$B9,".",$0F,$06
	dc.b	$0C,$50,"'s ",$0C,$D3," third",$02,$0C,$B9,".",$0F
