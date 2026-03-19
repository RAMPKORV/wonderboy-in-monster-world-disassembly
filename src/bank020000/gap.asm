; ROM range: 0x022DB8-0x023AB5
; Bridge slice between the earlier 0x022D6C-0x022DB7 FF00-terminated compact records and the
; later 0x023AB6-0x024537 FFFF-delimited word-record band. Most of this span still lacks a
; proven consumer, but the front of the tail is no longer fully opaque: it exposes two more
; FF00-terminated compact records, two standalone sentinels, and a short three-word lead-in
; before the remaining mixed payload resumes.

Bank020000_RecurringWordPatternBand_022DB8:
	incbin "data/rom/bank_020000_03ffff.bin",$002DB8,$0009FC

Bank020000_StandaloneFFFFSentinel_0237B4:
	dc.w	$FFFF

Bank020000_FF00TerminatedCompactWordRecord_0237B6:
	dc.w	$95C2,$002A,$0045,$C200,$2D00,$3701,$39C2,$00C4
	dc.w	$C400,$C0C2,$00C6,$FF00

Bank020000_FF00TerminatedCompactWordRecord_0237CE:
	dc.w	$0A00,$00E0,$21D8,$0100,$0100,$0112,$FF00

Bank020000_MixedLeadInWords_0237DC:
	dc.w	$00D0,$0008,$0000

Bank020000_StandaloneFFFFSentinel_0237E2:
	dc.w	$FFFF

Bank020000_PatternDenseMixedPayload_0237E4:
	incbin "data/rom/bank_020000_03ffff.bin",$0037E4,$0002D2
