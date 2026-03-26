; ROM range: 0x01CC10-0x01CC4F
; Sixteen-entry absolute root-pointer table consumed by ResolveMenuTextControlStream_001ED0.
; The first and fourth roots now point at already split bank020000 tables; the remaining
; roots still land inside not-yet-authored bank020000 regions and stay absolute for now.

MenuTextRootPointerTable_01CC10:
	dc.l	$000211CA
	dc.l	$0001DD94
	dc.l	$0001DD74
	dc.l	$00022460
	dc.l	$00023794
	dc.l	$00023AB6
	dc.l	$00026538
	dc.l	$00027786
	dc.l	$00028154
	dc.l	$00029E5A
	dc.l	$0002B108
	dc.l	$0002C6B8
	dc.l	$00024130
	dc.l	$0002E4C6
	dc.l	$0003058A
	dc.l	$00032170
