; ROM range: 0x098000-0x09F776
; Conservative split of the first non-fill tail-bank island. The front block is strongly
; Z80/opcode-dense rather than plain 68k or obvious asset data, but its caller and exact
; subsystem owner are still unproven. The following slices are structurally clearer: a
; compact descriptor-header region, a packed layout/coordinate table, a small zero-fill
; gap, and a larger command region whose front bytes now split into a short lead-in plus a
; bank-local offset table before the denser command records.

Bank080000_Z80LikeCodeBlock_098000:
	incbin "data/rom/bank_080000_0bffff.bin",$018000,$001920

Bank080000_DescriptorHeaderRecords_099920:
	incbin "data/rom/bank_080000_0bffff.bin",$019920,$000060

Bank080000_PackedLayoutDescriptorTable_099980:
	incbin "data/rom/bank_080000_0bffff.bin",$019980,$000105

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
	incbin "data/rom/bank_080000_0bffff.bin",$019D05,$000043

Bank080000_CommandRecord_099D48:
	incbin "data/rom/bank_080000_0bffff.bin",$019D48,$000030

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
	incbin "data/rom/bank_080000_0bffff.bin",$01A10E,$00002E

Bank080000_CommandRecord_09A13C:
	incbin "data/rom/bank_080000_0bffff.bin",$01A13C,$00000D

Bank080000_CommandRecord_09A149:
	incbin "data/rom/bank_080000_0bffff.bin",$01A149,$000021

Bank080000_CommandRecord_09A16A:
	incbin "data/rom/bank_080000_0bffff.bin",$01A16A,$00002F

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
	incbin "data/rom/bank_080000_0bffff.bin",$01A288,$0000C0

Bank080000_CommandRecord_09A348:
	incbin "data/rom/bank_080000_0bffff.bin",$01A348,$00542F
