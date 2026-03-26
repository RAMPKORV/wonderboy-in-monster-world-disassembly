; ======================================================================
; src/text_bank.asm
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
	include "src/text_bank/dialogue_continuation.asm"

Bank020000_BankRelativeTextRecordFamilyA_0201D0:
	include "src/text_bank/text_record_group_a.asm"

	include "src/text_bank/dialogue_followup.asm"

Bank020000_BankRelativeTextRecordFamilyB_020E4C:
	include "src/text_bank/text_record_group_b.asm"

Bank020000_BankRelativeTextIndexData_0211CA:
	include "src/text_bank/text_pointer_tables.asm"

Bank020000_QuizText_021360:
	include "src/text_bank/quiz_text.asm"

Bank020000_ItemAndKeywordNames_021720:
	include "src/text_bank/inventory_and_world_names.asm"

Bank020000_ShopInnOcarinaAndDictionaryText_021B80:
	include "src/text_bank/shop_inn_dictionary_text.asm"

Bank020000_StructuredDescriptorAndIndexData_022460:
	include "src/text_bank/descriptor_and_index_data.asm"

Bank020000_BridgeBetweenStructuredIslands_022DB8:
	include "src/text_bank/interstitial_structured_data.asm"

Bank020000_SentinelDelimitedWordRecordBand_023AB6:
	include "src/text_bank/sentinel_word_records.asm"

Bank020000_SentinelDelimitedWordRecordBandContinuation_024538:
	include "src/text_bank/sentinel_word_records_tail.asm"

	include "src/text_bank/compressed_data_blocks.asm"
