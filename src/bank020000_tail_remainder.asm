; ROM range: 0x03C6E0-0x03FFFF
; Header-like sub-block split inside the final bank020000 compressed/data tail.
;
; These boundaries are weaker than the earlier 0xFF7A/0xFF7B-terminated blocks, but they
; are still useful ROM-order structure: the bytes at 0x03C6E0, 0x03E846, 0x03EF4E,
; 0x03F4D1, and 0x03FE24 each begin with the same short header-like prefixes already seen
; at earlier proven block starts in this tail. Until a caller or decoder proves the exact
; format, keep the ownership conservative and the labels structural.

; --- Candidate block A (0x03C6E0-0x03E845, 8550 bytes) ---
; Starts with 0x0960..., which does not appear elsewhere in the earlier proven set.
Bank020000_TailHeaderLikeDataBlockA_03C6E0:
	incbin "data/rom/bank_020000_03ffff.bin",$01C6E0,$002166

; --- Candidate block B (0x03E846-0x03EF4D, 1800 bytes) ---
; Starts with 0x0F00..., matching one of the recurring block-header-like prefixes.
Bank020000_TailHeaderLikeDataBlockB_03E846:
	incbin "data/rom/bank_020000_03ffff.bin",$01E846,$000708

; --- Candidate block C (0x03EF4E-0x03F4D0, 1411 bytes) ---
; Starts with 0x0B60..., another recurring prefix already seen at earlier tail starts.
Bank020000_TailHeaderLikeDataBlockC_03EF4E:
	incbin "data/rom/bank_020000_03ffff.bin",$01EF4E,$000583

; --- Candidate block D (0x03F4D1-0x03FE23, 2387 bytes) ---
; Starts with 0x0F00... and runs to the next later header-like prefix.
Bank020000_TailHeaderLikeDataBlockD_03F4D1:
	incbin "data/rom/bank_020000_03ffff.bin",$01F4D1,$000953

; --- Candidate block E (0x03FE24-0x03FFFF, 476 bytes) ---
; Final short bank-end tail. Also starts with 0x0F00..., but no later internal boundary is
; currently better justified before the bank end.
Bank020000_TailHeaderLikeDataBlockE_03FE24:
	incbin "data/rom/bank_020000_03ffff.bin",$01FE24,$0001DC
