; ROM range: 0x05D630-0x05FC2F
; Eight consecutive 0x4C0-byte planar tile blocks inside the later bank040000 local-target
; payload run.
;
; The starts are monotone table targets from 0x041000, and each record again resolves cleanly
; to 38 4bpp tile slots. That is enough to treat this as a graphics family even before the
; consuming loader is identified.

Bank040000_LocalTableTargetedPlanarTileFamily_05D630:
Bank040000_LocalTableTargetedPlanarTileBlock_05D630:
	incbin "data/rom/bank_040000_07ffff.bin",$01D630,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_05DAF0:
	incbin "data/rom/bank_040000_07ffff.bin",$01DAF0,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_05DFB0:
	incbin "data/rom/bank_040000_07ffff.bin",$01DFB0,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_05E470:
	incbin "data/rom/bank_040000_07ffff.bin",$01E470,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_05E930:
	incbin "data/rom/bank_040000_07ffff.bin",$01E930,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_05EDF0:
	incbin "data/rom/bank_040000_07ffff.bin",$01EDF0,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_05F2B0:
	incbin "data/rom/bank_040000_07ffff.bin",$01F2B0,$0004C0

Bank040000_LocalTableTargetedPlanarTileBlock_05F770:
	incbin "data/rom/bank_040000_07ffff.bin",$01F770,$0004C0
