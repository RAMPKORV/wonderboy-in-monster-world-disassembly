; ROM range: 0x020000-0x03FFFF
; Bank-local ownership skeleton for the first fully banked mid-ROM region.
; This bank still needs deeper code/text/table recovery, but the upstream quiz slice at
; 0x021360-0x02171F, the adjacent name/text region at 0x021720-0x02245F, the first
; post-dictionary descriptor/index island at 0x022460-0x022C5F, and a later sentinel-
; delimited word-record band at 0x023AB6-0x024537 are now split into ROM-order modules
; so the bank is no longer a single opaque slice.

Bank020000:
	incbin "data/rom/bank_020000_03ffff.bin",$000000,$0011CA

Bank020000_BankRelativeTextIndexData_0211CA:
	include "src/bank020000_offsets.asm"

Bank020000_QuizText_021360:
	include "src/bank020000_quiz.asm"

Bank020000_ItemAndKeywordNames_021720:
	include "src/bank020000_names.asm"

Bank020000_ShopInnOcarinaAndDictionaryText_021B80:
	include "src/bank020000_text.asm"

Bank020000_StructuredDescriptorAndIndexData_022460:
	include "src/bank020000_tables.asm"

Bank020000_AfterStructuredTextAndTables_022C60:
	incbin "data/rom/bank_020000_03ffff.bin",$002C60,$000E56

Bank020000_SentinelDelimitedWordRecordBand_023AB6:
	include "src/bank020000_records.asm"

Bank020000_AfterSentinelDelimitedWordRecordBand_024538:
	incbin "data/rom/bank_020000_03ffff.bin",$004538,$01BAC8
