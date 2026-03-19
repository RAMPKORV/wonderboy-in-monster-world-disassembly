; ======================================================================
; src/bank020000.asm
; ROM range: 0x020000-0x03FFFF - dialogue, text, tables, and compressed tail data
; ======================================================================
; Bank-local ownership skeleton for the first fully banked mid-ROM region.
; This bank still needs deeper code/text/table recovery, but the upstream quiz slice at
; 0x021360-0x02171F, the adjacent name/text region at 0x021720-0x02245F, the first
; post-dictionary descriptor/index island at 0x022460-0x022DB7, a later sentinel-
; delimited word-record band at 0x023AB6-0x024537, and the next front continuation at
; 0x024538-0x02482B are now split into ROM-order modules. The bridge between those two
; larger structured islands is also partially split at the first local FF00 / FFFF
; sentinels, so the bank is no longer a single opaque slice.

Bank020000_DialogueScriptContinuation_020000:
	include "src/bank020000/dialogue_front.asm"

Bank020000_BankRelativeTextRecordFamilyA_0201D0:
	include "src/bank020000/front_records_a.asm"

	include "src/bank020000/dialogue_mid.asm"

Bank020000_BankRelativeTextRecordFamilyB_020E4C:
	include "src/bank020000/front_records_b.asm"

Bank020000_BankRelativeTextIndexData_0211CA:
	include "src/bank020000/offsets.asm"

Bank020000_QuizText_021360:
	include "src/bank020000/quiz.asm"

Bank020000_ItemAndKeywordNames_021720:
	include "src/bank020000/names.asm"

Bank020000_ShopInnOcarinaAndDictionaryText_021B80:
	include "src/bank020000/text.asm"

Bank020000_StructuredDescriptorAndIndexData_022460:
	include "src/bank020000/tables.asm"

Bank020000_BridgeBetweenStructuredIslands_022DB8:
	include "src/bank020000/gap.asm"

Bank020000_SentinelDelimitedWordRecordBand_023AB6:
	include "src/bank020000/records.asm"

Bank020000_SentinelDelimitedWordRecordBandContinuation_024538:
	include "src/bank020000/tail_records.asm"

	include "src/bank020000/tail_blocks.asm"
