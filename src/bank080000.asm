; ROM range: 0x080000-0x0BFFFF
; Tail-bank owner split around the largest confirmed 0xFF fill runs. These labels keep the
; padding/frontier map explicit while the non-fill slices are still being decomposed.

Bank080000:
	incbin "data/rom/bank_080000_0bffff.bin",$000000,$01622B

Bank080000_Fill_09622B_097FFF:
	incbin "data/rom/bank_080000_0bffff.bin",$01622B,$001DD5

Bank080000_MidData_098000_09F776:
	include "src/bank080000_mid.asm"

Bank080000_Fill_09F777_09FFFF:
	incbin "data/rom/bank_080000_0bffff.bin",$01F777,$000889

Bank080000_MidData_0A0000_0A4C76:
	include "src/bank080000_a0000.asm"

Bank080000_Fill_0A4C77_0BFFFF:
	incbin "data/rom/bank_080000_0bffff.bin",$024C77,$01B389
