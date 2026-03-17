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
	incbin "data/rom/bank_020000_03ffff.bin",$000000,$00000D

Bank020000_DialogueScriptFrontContinuation_02000D:
	incbin "data/rom/bank_020000_03ffff.bin",$00000D,$000001

Bank020000_DialogueScriptFrontContinuation_02000E:
	incbin "data/rom/bank_020000_03ffff.bin",$00000E,$000005

Bank020000_DialogueScriptFrontContinuation_020013:
	incbin "data/rom/bank_020000_03ffff.bin",$000013,$000001

Bank020000_DialogueScriptFrontContinuation_020014:
	incbin "data/rom/bank_020000_03ffff.bin",$000014,$000029

Bank020000_DialogueScriptFrontContinuation_02003D:
	incbin "data/rom/bank_020000_03ffff.bin",$00003D,$000001

Bank020000_DialogueScriptFrontContinuation_02003E:
	incbin "data/rom/bank_020000_03ffff.bin",$00003E,$000003

Bank020000_DialogueScriptFrontContinuation_020041:
	incbin "data/rom/bank_020000_03ffff.bin",$000041,$000001

Bank020000_DialogueScriptFrontContinuation_020042:
	incbin "data/rom/bank_020000_03ffff.bin",$000042,$00000E

Bank020000_DialogueScriptFrontContinuation_020050:
	incbin "data/rom/bank_020000_03ffff.bin",$000050,$000001

; "Make yourself at home."
Bank020000_DialogueScript_MakeYourselfAtHome_020051:
	incbin "data/rom/bank_020000_03ffff.bin",$000051,$000017

Bank020000_DialogueScriptFrontContinuation_020068:
	incbin "data/rom/bank_020000_03ffff.bin",$000068,$000001

Bank020000_DialogueScriptFrontContinuation_020069:
	incbin "data/rom/bank_020000_03ffff.bin",$000069,$000018

Bank020000_DialogueScriptFrontContinuation_020081:
	incbin "data/rom/bank_020000_03ffff.bin",$000081,$000001

; Multi-string NPC dialogue block: "So [you]'ve arrived.", "I'm so relieved.",
; "Tell [you] [what] I'm [store] do.", "I'm [store] ask [you] [...] questions -",
; "When [you]'ve answered [nothing] correctly, I'm [store] send [you] into a new world.",
; "Are [you] [?]?" and quiz-host final strings.
Bank020000_DialogueScriptNpcBlock_020082:
	incbin "data/rom/bank_020000_03ffff.bin",$000082,$000114

Bank020000_DialogueScriptFrontContinuation_020196:
	incbin "data/rom/bank_020000_03ffff.bin",$000196,$000001

; "[has] [?] first [?]." / "[has] [?] second [?]." / "[has] [?] third [?]."
Bank020000_DialogueScriptOrdinalStrings_020197:
	incbin "data/rom/bank_020000_03ffff.bin",$000197,$000039
