; ROM range: 0x05D630-0x05FC2F
; Eight consecutive 0x4C0-byte records inside the later bank040000 local-target payload run.
;
; The starts are monotone table targets from 0x041000, and the shared stride makes this a clear
; structural family even before the consuming loader is known.

Bank040000_LocalTableTargetedPayloadFixedStrideFamily_05D630:
Bank040000_LocalTableTargetedPayloadFixedStrideRecord_05D630:
	incbin "data/rom/bank_040000_07ffff.bin",$01D630,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_05DAF0:
	incbin "data/rom/bank_040000_07ffff.bin",$01DAF0,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_05DFB0:
	incbin "data/rom/bank_040000_07ffff.bin",$01DFB0,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_05E470:
	incbin "data/rom/bank_040000_07ffff.bin",$01E470,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_05E930:
	incbin "data/rom/bank_040000_07ffff.bin",$01E930,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_05EDF0:
	incbin "data/rom/bank_040000_07ffff.bin",$01EDF0,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_05F2B0:
	incbin "data/rom/bank_040000_07ffff.bin",$01F2B0,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_05F770:
	incbin "data/rom/bank_040000_07ffff.bin",$01F770,$0004C0
