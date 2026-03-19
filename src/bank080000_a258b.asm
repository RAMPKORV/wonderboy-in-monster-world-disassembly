; ROM range: 0x0A258B-0x0A2605
; This run continues the same FF-terminated five-byte tuple family. Every record ends at
; a proven local $FF terminator, and every pre-terminator payload length remains a
; multiple of 5 bytes, so the source exposes each stable record start directly in ROM
; order while keeping the labels structural. The three records here are now byte-visible
; too: the front two stay inside the recurring $43-page pocket, and the short tail record
; closes the same local neighborhood immediately before the next mixed bridge.

Bank080000_FFTerminatedFiveByteTupleRecord_0A258B:
	dc.b	$06,$43,$CC,$08,$F1
	dc.b	$05,$43,$D8,$FC,$01
	dc.b	$05,$43,$C8,$02,$EA
	dc.b	$00,$43,$9C,$02,$E4
	dc.b	$05,$43,$C0,$F4,$E7
	dc.b	$06,$43,$D2,$EE,$F4
	dc.b	$04,$43,$DC,$F4,$09
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A25AF:
	dc.b	$00,$43,$9D,$F3,$00
	dc.b	$00,$43,$9C,$0D,$03
	dc.b	$00,$4B,$DF,$EA,$05
	dc.b	$00,$43,$9C,$FA,$E7
	dc.b	$05,$43,$C4,$08,$F3
	dc.b	$00,$43,$DE,$09,$09
	dc.b	$00,$43,$DF,$00,$E9
	dc.b	$00,$53,$DE,$FA,$00
	dc.b	$00,$43,$DE,$F0,$E8
	dc.b	$04,$43,$DC,$ED,$F5
	dc.b	$04,$43,$DC,$F4,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A25E7:
	dc.b	$00,$43,$9C,$03,$FA
	dc.b	$00,$43,$9D,$FD,$EC
	dc.b	$00,$43,$DF,$EF,$08
	dc.b	$00,$43,$9E,$F6,$00
	dc.b	$05,$43,$C4,$09,$06
	dc.b	$00,$53,$DE,$FA,$05
	dc.b	$FF
