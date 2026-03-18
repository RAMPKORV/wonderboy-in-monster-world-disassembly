; ROM range: 0x06B192-0x06BB11
; Final short fixed-stride pair inside the bank040000 local-target payload family.
;
; These two starts keep the same 0x4C0-byte cadence seen earlier at 0x04BFAA and 0x05D630,
; so they are split into a dedicated ROM-order module instead of hiding inside the surrounding
; irregular record run.

Bank040000_LocalTableTargetedPayloadFixedStrideFamily_06B192:
Bank040000_LocalTableTargetedPayloadFixedStrideRecord_06B192:
	incbin "data/rom/bank_040000_07ffff.bin",$02B192,$0004C0

Bank040000_LocalTableTargetedPayloadFixedStrideRecord_06B652:
	incbin "data/rom/bank_040000_07ffff.bin",$02B652,$0004C0
