; ROM range: 0x05C5DA-0x05CA99
; Isolated 0x4C0-byte record inside the bank040000 local-target payload family.
;
; This one record appears before the larger 0x05D630-0x05FC2F stride run and uses the same
; stable size, so it is worth naming as its own structural island instead of leaving it buried
; among irregular slices.

Bank040000_LocalTableTargetedPayloadFixedStrideIsolatedRecord_05C5DA:
Bank040000_LocalTableTargetedPayloadFixedStrideRecord_05C5DA:
	incbin "data/rom/bank_040000_07ffff.bin",$01C5DA,$0004C0
