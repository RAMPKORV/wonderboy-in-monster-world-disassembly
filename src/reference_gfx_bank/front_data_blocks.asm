; ROM range: 0x040000-0x0409F9
; Front data island before the explicit 0x0409FA-0x040FFF fill run.
;
; This span is still opaque at the subsystem level, but it no longer needs to stay as one
; monolithic incbin. Several recurring header-like starts are now explicit in ROM order:
;   0x040100  starts with FFFF 000A
;   0x04025C  starts with FFFF 000E
;   0x040400  starts with 0000 0102 ... FFFF 001E
;   0x04053C  starts with 0000 0102 ... FFFF 000E
;   0x0406C4  starts with FFFF 000A
;   0x0408D4  starts with FFFF 000A
; Those signatures recur within the same front slice and mark cleaner boundaries than one
; bank-front blob, even though the loader and exact format are still unresolved.

; --- Front lead-in (0x040000-0x0400FF, 256 bytes) ---
; Unique bank-front prelude. Starts with 0x00040002 and a repeated 0xFE73 motif before the
; later recurring header-like families begin.
Bank040000_FrontHeaderLikeLeadIn_040000:
	incbin "data/rom/bank_040000_07ffff.bin",$000000,$000100

; --- Candidate block A (0x040100-0x04025B, 348 bytes) ---
; Starts with the recurring FFFF 000A header-like prefix.
Bank040000_FrontHeaderLikeDataBlockA_040100:
	incbin "data/rom/bank_040000_07ffff.bin",$000100,$00015C

; --- Candidate block B (0x04025C-0x0403FF, 420 bytes) ---
; Starts with the recurring FFFF 000E header-like prefix.
Bank040000_FrontHeaderLikeDataBlockB_04025C:
	incbin "data/rom/bank_040000_07ffff.bin",$00025C,$0001A4

; --- Candidate block C (0x040400-0x04053B, 316 bytes) ---
; Starts with a short 0000 0102 lead-in followed by the only current FFFF 001E variant.
Bank040000_FrontHeaderLikeDataBlockC_040400:
	incbin "data/rom/bank_040000_07ffff.bin",$000400,$00013C

; --- Candidate block D (0x04053C-0x0406C3, 392 bytes) ---
; Starts with the same 0000 0102 lead-in shape seen at 0x040400, then transitions into a
; second FFFF 000E-style block body.
Bank040000_FrontHeaderLikeDataBlockD_04053C:
	incbin "data/rom/bank_040000_07ffff.bin",$00053C,$000188

; --- Candidate block E (0x0406C4-0x0408D3, 528 bytes) ---
; Returns to the recurring FFFF 000A header-like prefix.
Bank040000_FrontHeaderLikeDataBlockE_0406C4:
	incbin "data/rom/bank_040000_07ffff.bin",$0006C4,$000210

; --- Candidate block F (0x0408D4-0x0409F9, 294 bytes) ---
; Final front-bank pocket before the explicit fill run. Also starts with FFFF 000A.
Bank040000_FrontHeaderLikeDataBlockF_0408D4:
	incbin "data/rom/bank_040000_07ffff.bin",$0008D4,$000126
