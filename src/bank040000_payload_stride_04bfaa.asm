; ROM range: 0x04BFAA-0x04E5A9
; Eight consecutive 0x4C0-byte records inside the bank040000 local-target payload family.
;
; The flagged ROM-reference table at 0x041000 lands on each start in order, and the fixed
; stride is stable across the whole run. Keep the names structural until the shared loader
; proves whether these are maps, scripts, graphics metadata, or another resource family.

Bank040000_LocalTableTargetedPayloadFixedStrideFamily_04BFAA:
Bank040000_LocalTableTargetedPayloadFixedStrideRecord_04BFAA:
	incbin "data/rom/bank_040000_07ffff.bin",$00BFAA,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_04C46A:
	incbin "data/rom/bank_040000_07ffff.bin",$00C46A,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_04C92A:
	incbin "data/rom/bank_040000_07ffff.bin",$00C92A,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_04CDEA:
	incbin "data/rom/bank_040000_07ffff.bin",$00CDEA,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_04D2AA:
	incbin "data/rom/bank_040000_07ffff.bin",$00D2AA,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_04D76A:
	incbin "data/rom/bank_040000_07ffff.bin",$00D76A,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_04DC2A:
	incbin "data/rom/bank_040000_07ffff.bin",$00DC2A,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_04E0EA:
	incbin "data/rom/bank_040000_07ffff.bin",$00E0EA,$0004C0
