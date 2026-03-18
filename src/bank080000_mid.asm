; ROM range: 0x098000-0x09F776
; Conservative split of the first non-fill tail-bank island. The front 0x098000-0x0991FF
; span still begins with a strongly Z80/opcode-dense code body rather than plain 68k or
; obvious asset data, but it no longer stays monolithic: the final 0x185 bytes are now
; explicit as two odd-aligned little-endian word lookup tables and one trailing zero byte.
; The next 0x099200-0x09991F span is also split separately because it is structurally cleaner:
; monotone byte bands, a fixed 19-byte record family, smaller mixed/control tails, and a short
; local-offset/word trailer leading into the already split descriptor-header region plus the
; adjacent fixed-record layout band. The larger command region still keeps its front lead-in
; and bank-local offset table explicit before the denser command records, and the formerly
; monolithic trailing command body at 0x09A348-0x09F776 remains divided into three ROM-order
; source windows, each further split at every proven local 0xFF terminator so the
; command-record cadence is explicit even before the subsystem owner is clearer.

	include "src/bank080000_mid_z80.asm"

Bank080000_PreDescriptorStructuredData_099200:
	include "src/bank080000_mid_front.asm"

Bank080000_StructuredDescriptorAndLayoutRecords_099920:
	include "src/bank080000_mid_descriptors.asm"

Bank080000_ZeroFill_099A85:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; Later words in the following table point back into this lead-in, so keep it separate from
; the offset list instead of hiding the whole block behind one anonymous incbin.
Bank080000_CommandLeadIn_099B00:
	incbin "data/rom/bank_080000_0bffff.bin",$019B00,$000032

; The repeated big-endian words from 0x099B32 onward mostly land back inside this same
; bank-local command region, making this the clearest currently proven structure in the tail
; data block. One word ($F7FD) still falls outside the local range, so keep the entries
; literal instead of forcing stronger subsystem meaning. Those local targets now split the
; command body into a short prelude plus narrower ROM-order record slices instead of one
; monolithic trailing incbin.
Bank080000_CommandOffsetTable_099B32:
	dc.w	$9BD3,$9BF5,$9B17,$9C3F,$9C67,$9C8F,$9CB5,$9CDC
	dc.w	$9CFE,$9C1C,$9D48,$9D78,$9D94,$9D99,$9DBB,$9DE6
	dc.w	$9D05,$9E36,$9E58,$9E7A,$9EA1,$9ED2,$9EF1,$9E0B
	dc.w	$9F24,$9F41,$9F63,$9F93,$9FAA,$9FC1,$9FDA,$9FFA
	dc.w	$9F10,$A02B,$A047,$A05A,$A06B,$A089,$A093,$A0AD
	dc.w	$A0BB,$A0D6,$A0DE,$A0F9,$A01E,$A13C,$A149,$A16A
	dc.w	$A199,$A1BB,$A1D8,$A1D8,$A1F2,$A10E,$A22B,$A245
	dc.w	$A25E,$A26B,$A288,$A26A,$F7FD,$A22D,$A348

; The first table-local target lands at 0x099BD3, leaving a short unreferenced prelude at
; 0x099BB0-0x099BD2 between the offset table and the first proven record boundary.
Bank080000_CommandRecordPrelude_099BB0:
	incbin "data/rom/bank_080000_0bffff.bin",$019BB0,$000023

Bank080000_CommandRecord_099BD3:
	incbin "data/rom/bank_080000_0bffff.bin",$019BD3,$000022

Bank080000_CommandRecord_099BF5:
	incbin "data/rom/bank_080000_0bffff.bin",$019BF5,$000027

Bank080000_CommandRecord_099C1C:
	incbin "data/rom/bank_080000_0bffff.bin",$019C1C,$000023

Bank080000_CommandRecord_099C3F:
	incbin "data/rom/bank_080000_0bffff.bin",$019C3F,$000028

Bank080000_CommandRecord_099C67:
	incbin "data/rom/bank_080000_0bffff.bin",$019C67,$000028

Bank080000_CommandRecord_099C8F:
	incbin "data/rom/bank_080000_0bffff.bin",$019C8F,$000026

Bank080000_CommandRecord_099CB5:
	incbin "data/rom/bank_080000_0bffff.bin",$019CB5,$000027

Bank080000_CommandRecord_099CDC:
	incbin "data/rom/bank_080000_0bffff.bin",$019CDC,$000022

Bank080000_CommandRecord_099CFE:
	incbin "data/rom/bank_080000_0bffff.bin",$019CFE,$000007

Bank080000_CommandRecord_099D05:
	; This table-targeted pocket tightens into smaller FF-terminated command slices instead of
	; one opaque 0x43-byte record.
Bank080000_CommandSubrecord_099D05:
	dc.b	$F7,$04,$F0,$07,$F1,$0F,$F2,$80,$25,$F4,$00,$E2,$0C,$DB,$10,$1C
	dc.b	$F3,$00,$00,$F5,$0C,$FE,$FF

Bank080000_CommandSubrecord_099D1C:
	dc.b	$20,$07,$21,$9D,$FF

Bank080000_CommandSubrecord_099D21:
	dc.b	$F6,$02,$F7,$04,$F0,$07,$F1,$0F,$F2,$80,$09,$F4,$00,$E2,$05,$D9
	dc.b	$15,$0B,$F3,$00,$FC,$F5,$08,$FE,$F2,$80,$09,$F4,$00,$DB,$15,$15
	dc.b	$F3,$00,$FC,$F5,$04,$FE,$FF

Bank080000_CommandRecord_099D48:
	; The next adjacent table target follows the same pattern: a short FF-terminated lead-in
	; plus one larger FF-terminated continuation.
Bank080000_CommandSubrecord_099D48:
	dc.b	$20,$07,$4D,$9D,$FF

Bank080000_CommandSubrecord_099D4D:
	dc.b	$F6,$02,$F7,$04,$F0,$07,$F1,$0F,$F2,$80,$09,$F4,$00,$E2,$05,$D9
	dc.b	$15,$0B,$F3,$00,$FC,$F5,$08,$FE,$F2,$00,$08,$F4,$00,$F0,$01,$E2
	dc.b	$03,$D9,$DF,$FC,$10,$F3,$80,$01,$FE,$FE,$FF

Bank080000_CommandRecord_099D78:
	incbin "data/rom/bank_080000_0bffff.bin",$019D78,$00001C

Bank080000_CommandRecord_099D94:
	incbin "data/rom/bank_080000_0bffff.bin",$019D94,$000005

Bank080000_CommandRecord_099D99:
	incbin "data/rom/bank_080000_0bffff.bin",$019D99,$000022

Bank080000_CommandRecord_099DBB:
	incbin "data/rom/bank_080000_0bffff.bin",$019DBB,$00002B

Bank080000_CommandRecord_099DE6:
	incbin "data/rom/bank_080000_0bffff.bin",$019DE6,$000025

Bank080000_CommandRecord_099E0B:
	incbin "data/rom/bank_080000_0bffff.bin",$019E0B,$00002B

Bank080000_CommandRecord_099E36:
	incbin "data/rom/bank_080000_0bffff.bin",$019E36,$000022

Bank080000_CommandRecord_099E58:
	incbin "data/rom/bank_080000_0bffff.bin",$019E58,$000022

Bank080000_CommandRecord_099E7A:
	incbin "data/rom/bank_080000_0bffff.bin",$019E7A,$000027

Bank080000_CommandRecord_099EA1:
	incbin "data/rom/bank_080000_0bffff.bin",$019EA1,$000031

Bank080000_CommandRecord_099ED2:
	incbin "data/rom/bank_080000_0bffff.bin",$019ED2,$00001F

Bank080000_CommandRecord_099EF1:
	incbin "data/rom/bank_080000_0bffff.bin",$019EF1,$00001F

Bank080000_CommandRecord_099F10:
	incbin "data/rom/bank_080000_0bffff.bin",$019F10,$000014

Bank080000_CommandRecord_099F24:
	incbin "data/rom/bank_080000_0bffff.bin",$019F24,$00001D

Bank080000_CommandRecord_099F41:
	incbin "data/rom/bank_080000_0bffff.bin",$019F41,$000022

Bank080000_CommandRecord_099F63:
	incbin "data/rom/bank_080000_0bffff.bin",$019F63,$000030

Bank080000_CommandRecord_099F93:
	incbin "data/rom/bank_080000_0bffff.bin",$019F93,$000017

Bank080000_CommandRecord_099FAA:
	incbin "data/rom/bank_080000_0bffff.bin",$019FAA,$000017

Bank080000_CommandRecord_099FC1:
	incbin "data/rom/bank_080000_0bffff.bin",$019FC1,$000019

Bank080000_CommandRecord_099FDA:
	incbin "data/rom/bank_080000_0bffff.bin",$019FDA,$000020

Bank080000_CommandRecord_099FFA:
	incbin "data/rom/bank_080000_0bffff.bin",$019FFA,$000024

Bank080000_CommandRecord_09A01E:
	incbin "data/rom/bank_080000_0bffff.bin",$01A01E,$00000D

Bank080000_CommandRecord_09A02B:
	incbin "data/rom/bank_080000_0bffff.bin",$01A02B,$00001C

Bank080000_CommandRecord_09A047:
	incbin "data/rom/bank_080000_0bffff.bin",$01A047,$000013

Bank080000_CommandRecord_09A05A:
	incbin "data/rom/bank_080000_0bffff.bin",$01A05A,$000011

Bank080000_CommandRecord_09A06B:
	incbin "data/rom/bank_080000_0bffff.bin",$01A06B,$00001E

Bank080000_CommandRecord_09A089:
	incbin "data/rom/bank_080000_0bffff.bin",$01A089,$00000A

Bank080000_CommandRecord_09A093:
	incbin "data/rom/bank_080000_0bffff.bin",$01A093,$00001A

Bank080000_CommandRecord_09A0AD:
	incbin "data/rom/bank_080000_0bffff.bin",$01A0AD,$00000E

Bank080000_CommandRecord_09A0BB:
	incbin "data/rom/bank_080000_0bffff.bin",$01A0BB,$00001B

Bank080000_CommandRecord_09A0D6:
	incbin "data/rom/bank_080000_0bffff.bin",$01A0D6,$000008

Bank080000_CommandRecord_09A0DE:
	incbin "data/rom/bank_080000_0bffff.bin",$01A0DE,$00001B

Bank080000_CommandRecord_09A0F9:
	incbin "data/rom/bank_080000_0bffff.bin",$01A0F9,$000015

Bank080000_CommandRecord_09A10E:
	; 0x09A10E-0x09A13B is another compound command record with four FF-terminated slices and
	; one standalone FF byte made explicit.
Bank080000_CommandSubrecord_09A10E:
	dc.b	$0C,$D0,$17,$A1,$F5,$03,$FE,$FE,$FF

Bank080000_CommandSubrecord_09A117:
	dc.b	$F0,$04,$C2,$70,$17,$FF

Bank080000_CommandSentinel_09A11D:
Bank080000_CommandSubrecord_09A11D:
	dc.b	$FF

Bank080000_CommandSubrecord_09A11E:
	dc.b	$44,$07,$23,$A1,$FF

Bank080000_CommandSubrecord_09A123:
	dc.b	$F6,$02,$F7,$06,$F1,$10,$DC,$DF,$F2,$00,$18,$D0,$17,$A1,$F2,$00
	dc.b	$0C,$D0,$17,$A1,$F5,$01,$FE,$FE,$FF

Bank080000_CommandRecord_09A13C:
	incbin "data/rom/bank_080000_0bffff.bin",$01A13C,$00000D

Bank080000_CommandRecord_09A149:
	incbin "data/rom/bank_080000_0bffff.bin",$01A149,$000021

Bank080000_CommandRecord_09A16A:
	; This later target also resolves into a short FF-terminated stub plus three compact
	; follow-on slices.
Bank080000_CommandSubrecord_09A16A:
	dc.b	$1A,$07,$6F,$A1,$FF

Bank080000_CommandSubrecord_09A16F:
	dc.b	$F6,$02,$F7,$06,$F1,$0E,$F2,$00,$10,$F4,$04,$DA,$C1,$7C,$F3,$40
	dc.b	$00,$1C,$F3,$C0,$FF

Bank080000_CommandSubrecord_09A184:
	dc.b	$70,$F3,$40,$00,$10,$F3,$C0,$FF

Bank080000_CommandSubrecord_09A18C:
	dc.b	$68,$F3,$40,$00,$08,$F3,$C0,$FF

Bank080000_CommandSubrecord_09A194:
	dc.b	$FB,$F5,$0C,$FE,$FF

Bank080000_CommandRecord_09A199:
	incbin "data/rom/bank_080000_0bffff.bin",$01A199,$000022

Bank080000_CommandRecord_09A1BB:
	incbin "data/rom/bank_080000_0bffff.bin",$01A1BB,$00001D

Bank080000_CommandRecord_09A1D8:
	incbin "data/rom/bank_080000_0bffff.bin",$01A1D8,$00001A

Bank080000_CommandRecord_09A1F2:
	incbin "data/rom/bank_080000_0bffff.bin",$01A1F2,$000039

Bank080000_CommandRecord_09A22B:
	incbin "data/rom/bank_080000_0bffff.bin",$01A22B,$000002

Bank080000_CommandRecord_09A22D:
	incbin "data/rom/bank_080000_0bffff.bin",$01A22D,$000018

Bank080000_CommandRecord_09A245:
	incbin "data/rom/bank_080000_0bffff.bin",$01A245,$000019

Bank080000_CommandRecord_09A25E:
	incbin "data/rom/bank_080000_0bffff.bin",$01A25E,$00000C

Bank080000_CommandRecord_09A26A:
	incbin "data/rom/bank_080000_0bffff.bin",$01A26A,$000001

Bank080000_CommandRecord_09A26B:
	incbin "data/rom/bank_080000_0bffff.bin",$01A26B,$00001D

Bank080000_CommandRecord_09A288:
	; The last front command-table target before 0x09A348 is a larger FF-terminated compound
	; pocket rather than one indivisible 0xC0-byte blob.
Bank080000_CommandSubrecord_09A288:
	dc.b	$78,$06,$93,$A2,$07,$AA,$A2,$08,$D2,$A2,$FF

Bank080000_CommandSubrecord_09A293:
	dc.b	$F0,$24,$F7,$30,$F4,$00,$C7,$F1,$0D,$F5,$1C,$32,$9C,$3E,$37,$99
	dc.b	$3A,$32,$3E,$C4,$99,$3B,$FF

Bank080000_CommandSubrecord_09A2AA:
	dc.b	$F0,$1F,$F7,$01,$F4,$00,$C3,$F1,$0C,$F5,$1C,$52,$53,$54,$4F,$50
	dc.b	$51,$52,$4D,$4E,$4F,$50,$4C,$4B,$4D,$4E,$48,$3F,$40,$41,$3D,$3E
	dc.b	$3A,$3B,$3D,$39,$38,$35,$CE,$FF

Bank080000_CommandSubrecord_09A2D2:
	dc.b	$F0,$04,$F7,$0E,$F4,$00,$C5,$F1,$0D,$F5,$1C,$9E,$43,$9E,$42,$9E
	dc.b	$42,$9C,$41,$9C,$41,$9B,$40,$9B,$40,$9A,$3F,$97,$3E,$A3,$48,$94
	dc.b	$3B,$AA,$4F,$94,$3B,$B1,$B6,$58,$C6,$FA,$FF

Bank080000_CommandSubrecord_09A2FD:
	dc.b	$88,$00,$03,$04,$A3,$00,$00,$F7,$01,$DA,$D0,$12,$9F,$C3,$FA,$FE
	dc.b	$D0,$43,$A1,$C5,$FA,$D1,$43,$A1,$C4,$FA,$D0,$12,$9F,$D0,$43,$A1
	dc.b	$C4,$FA,$D1,$12,$9F,$C6,$FA,$D0,$43,$A1,$D0,$12,$9F,$FD,$04,$A3
	dc.b	$70,$06,$32,$A3,$FF

Bank080000_CommandSubrecord_09A332:
	dc.b	$F7,$3F,$F0,$27,$F4,$02,$F1,$0E,$C2,$50,$54,$57,$F5,$1C,$DB,$50
	dc.b	$54,$57,$F5,$0E,$FE,$FF

Bank080000_FFTerminatedCommandRecordWindowFront_09A348:
	include "src/bank080000_mid_command_tail_front.asm"

Bank080000_FFTerminatedCommandRecordWindowMid_09C008:
	include "src/bank080000_mid_command_tail_mid.asm"

Bank080000_FFTerminatedCommandRecordWindowTail_09E028:
	include "src/bank080000_mid_command_tail_tail.asm"
