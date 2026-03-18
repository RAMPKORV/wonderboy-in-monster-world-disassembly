; ROM range: 0x04A70F-0x04E5A9
; Continued local-target payload window reached from the same flagged ROM-reference
; table at 0x041000-0x0418AB. This span now separates the irregular front records from
; the first long fixed-stride run at 0x04BFAA. The labels stay structural until a loader
; or decoder proves what resource family these records actually belong to.

Bank040000_LocalTableTargetedPayloadRecord_04A70F:
	incbin "data/rom/bank_040000_07ffff.bin",$00A70F,$000194

Bank040000_LocalTableTargetedPayloadRecord_04A8A3:
	incbin "data/rom/bank_040000_07ffff.bin",$00A8A3,$000146

Bank040000_LocalTableTargetedPayloadRecord_04A9E9:
	incbin "data/rom/bank_040000_07ffff.bin",$00A9E9,$0001AD

Bank040000_LocalTableTargetedPayloadRecord_04AB96:
	incbin "data/rom/bank_040000_07ffff.bin",$00AB96,$000145

Bank040000_LocalTableTargetedPayloadRecord_04ACDB:
	incbin "data/rom/bank_040000_07ffff.bin",$00ACDB,$0001D9

Bank040000_LocalTableTargetedPayloadRecord_04AEB4:
	incbin "data/rom/bank_040000_07ffff.bin",$00AEB4,$000250

Bank040000_LocalTableTargetedPayloadRecord_04B104:
	incbin "data/rom/bank_040000_07ffff.bin",$00B104,$0001CB

Bank040000_LocalTableTargetedPayloadRecord_04B2CF:
	incbin "data/rom/bank_040000_07ffff.bin",$00B2CF,$00019E

Bank040000_LocalTableTargetedPayloadRecord_04B46D:
	incbin "data/rom/bank_040000_07ffff.bin",$00B46D,$0001B0

Bank040000_LocalTableTargetedPayloadRecord_04B61D:
	incbin "data/rom/bank_040000_07ffff.bin",$00B61D,$00019F

Bank040000_LocalTableTargetedPayloadRecord_04B7BC:
	incbin "data/rom/bank_040000_07ffff.bin",$00B7BC,$000178

Bank040000_LocalTableTargetedPayloadRecord_04B934:
	incbin "data/rom/bank_040000_07ffff.bin",$00B934,$0002A3

Bank040000_LocalTableTargetedPayloadRecord_04BBD7:
	incbin "data/rom/bank_040000_07ffff.bin",$00BBD7,$00013A

Bank040000_LocalTableTargetedPayloadRecord_04BD11:
	incbin "data/rom/bank_040000_07ffff.bin",$00BD11,$000190

Bank040000_LocalTableTargetedPayloadRecord_04BEA1:
	incbin "data/rom/bank_040000_07ffff.bin",$00BEA1,$000109

	include "src/bank040000_payload_stride_04bfaa.asm"
