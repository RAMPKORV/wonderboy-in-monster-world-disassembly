; ROM range: 0x0A258B-0x0A2605
; This run continues the same FF-terminated five-byte tuple family. Every record ends at
; a proven local $FF terminator, and every pre-terminator payload length remains a
; multiple of 5 bytes, so the source exposes each stable record start directly in ROM
; order while keeping the labels structural.

Bank080000_FFTerminatedFiveByteTupleRecord_0A258B:
	incbin "data/rom/bank_080000_0bffff.bin",$02258B,$000024

Bank080000_FFTerminatedFiveByteTupleRecord_0A25AF:
	incbin "data/rom/bank_080000_0bffff.bin",$0225AF,$000038

Bank080000_FFTerminatedFiveByteTupleRecord_0A25E7:
	incbin "data/rom/bank_080000_0bffff.bin",$0225E7,$00001F
