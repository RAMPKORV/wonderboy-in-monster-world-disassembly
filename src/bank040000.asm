; ======================================================================
; src/bank040000.asm
; ROM range: 0x040000-0x07FFFF - late-ROM tables, payloads, and graphics slices
; ======================================================================
; Late-ROM bank split into bank-local slices. The first confirmed structure here was a
; long 0xFF fill run at 0x0409FA-0x040FFF; the next proven cluster at 0x041000-0x041BFF is
; now explicit as a flagged ROM-reference table island with two smaller 0xFF fill gaps, and
; the first four chunks of its local-target payload family are split further at
; 0x041C00-0x07FF66, leaving only a tiny trailing bank remainder.

Bank040000_FrontHeaderLikeData_040000:
	include "src/bank040000/front_blocks.asm"

Bank040000_Fill_0409FA_040FFF:
	incbin "data/rom/bank_040000_07ffff.bin",$0009FA,$000606

Bank040000_FlaggedRomReferenceTables_041000:
	include "src/bank040000/tables.asm"

Bank040000_LocalTableTargetedPayloadFront_041C00:
	include "src/bank040000/payload_front.asm"

Bank040000_LocalTableTargetedPayloadMid_04A70F:
	include "src/bank040000/payload_mid.asm"

Bank040000_LocalTableTargetedPayloadLate_04E5AA:
	include "src/bank040000/payload_late.asm"

Bank040000_LocalTableTargetedPayloadTail_05FC30:
	include "src/bank040000/payload_tail.asm"

Bank040000_TinyTrailingBankRemainder_07FF67:
	incbin "data/rom/bank_040000_07ffff.bin",$03FF67,$000099
