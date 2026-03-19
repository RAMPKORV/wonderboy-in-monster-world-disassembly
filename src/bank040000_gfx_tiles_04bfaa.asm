; ROM range: 0x04BFAA-0x04E5A9
; Eight consecutive 0x4C0-byte planar tile blocks inside the bank040000 local-target payload
; family.
;
; Each record is exactly 38 Mega Drive 4bpp tiles (0x26 * 0x20 bytes), and row-level byte
; inspection shows the expected bitplane-style patterns rather than arbitrary control data.
; The flagged ROM-reference table at 0x041000 lands on each start in order, so the graphics
; ownership is strong even though the higher-level loader and asset purpose are still open.

Bank040000_LocalTableTargetedPlanarTileFamily_04BFAA:
Bank040000_LocalTableTargetedPlanarTileBlock_04BFAA:
	incbin "data/rom/bank_040000_07ffff.bin",$00BFAA,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_04C46A:
	incbin "data/rom/bank_040000_07ffff.bin",$00C46A,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_04C92A:
	incbin "data/rom/bank_040000_07ffff.bin",$00C92A,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_04CDEA:
	incbin "data/rom/bank_040000_07ffff.bin",$00CDEA,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_04D2AA:
	incbin "data/rom/bank_040000_07ffff.bin",$00D2AA,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_04D76A:
	incbin "data/rom/bank_040000_07ffff.bin",$00D76A,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_04DC2A:
	incbin "data/rom/bank_040000_07ffff.bin",$00DC2A,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_04E0EA:
	incbin "data/rom/bank_040000_07ffff.bin",$00E0EA,$0004C0
