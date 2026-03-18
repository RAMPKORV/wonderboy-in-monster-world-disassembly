; ROM range: 0x098000-0x0991FF
; Front slice inside the 0x098000-0x09F776 non-fill tail-bank island.
;
; The front 0x107B bytes remain a strongly opcode-dense Z80-like code body, but the
; tail is no longer left inside the same monolithic incbin. The final 0x185 bytes tighten
; into two odd-aligned little-endian word lookup tables followed by one trailing zero byte.
;
; The first table at 0x09907B-0x09913C rises from 0x028E to 0x051C across 97 entries,
; while the second at 0x09913D-0x0991FE falls from 0x0349 to 0x01A4 across another 97
; entries. Keep the names structural until the Z80-side consumer is proven.

Bank080000_Z80LikeCodeBlock_098000:
Bank080000_Z80LikeCodeBody_098000:
	incbin "data/rom/bank_080000_0bffff.bin",$018000,$00107B

Bank080000_Z80LikeOddAlignedAscendingWordTable_09907B:
	dc.b	$8E,$02,$93,$02,$97,$02,$9C,$02,$A1,$02,$A6,$02,$AB,$02,$B0,$02
	dc.b	$B5,$02,$BA,$02,$BF,$02,$C4,$02,$C9,$02,$CE,$02,$D4,$02,$D9,$02
	dc.b	$DE,$02,$E3,$02,$E9,$02,$EE,$02,$F4,$02,$F9,$02,$FF,$02,$04,$03
	dc.b	$0A,$03,$0F,$03,$15,$03,$1B,$03,$20,$03,$26,$03,$2C,$03,$32,$03
	dc.b	$38,$03,$3E,$03,$44,$03,$4A,$03,$50,$03,$56,$03,$5C,$03,$63,$03
	dc.b	$69,$03,$6F,$03,$76,$03,$7C,$03,$83,$03,$89,$03,$90,$03,$96,$03
	dc.b	$9D,$03,$A4,$03,$AA,$03,$B1,$03,$B8,$03,$BF,$03,$C6,$03,$CD,$03
	dc.b	$D4,$03,$DB,$03,$E2,$03,$E9,$03,$F1,$03,$F8,$03,$FF,$03,$07,$04
	dc.b	$0E,$04,$16,$04,$1D,$04,$25,$04,$2D,$04,$34,$04,$3C,$04,$44,$04
	dc.b	$4C,$04,$54,$04,$5C,$04,$64,$04,$6C,$04,$74,$04,$7D,$04,$85,$04
	dc.b	$8D,$04,$96,$04,$9E,$04,$A7,$04,$AF,$04,$B8,$04,$C1,$04,$CA,$04
	dc.b	$D3,$04,$DB,$04,$E4,$04,$EE,$04,$F7,$04,$00,$05,$09,$05,$13,$05
	dc.b	$1C,$05

Bank080000_Z80LikeOddAlignedDescendingWordTable_09913D:
	dc.b	$49,$03,$43,$03,$3D,$03,$37,$03,$31,$03,$2B,$03,$26,$03,$20,$03
	dc.b	$1A,$03,$14,$03,$0F,$03,$09,$03,$03,$03,$FE,$02,$F8,$02,$F3,$02
	dc.b	$ED,$02,$E8,$02,$E3,$02,$DD,$02,$D8,$02,$D3,$02,$CE,$02,$C8,$02
	dc.b	$C3,$02,$BE,$02,$B9,$02,$B4,$02,$AF,$02,$AA,$02,$A5,$02,$A0,$02
	dc.b	$9C,$02,$97,$02,$92,$02,$8D,$02,$89,$02,$84,$02,$7F,$02,$7B,$02
	dc.b	$76,$02,$72,$02,$6D,$02,$69,$02,$64,$02,$60,$02,$5B,$02,$57,$02
	dc.b	$53,$02,$4E,$02,$4A,$02,$46,$02,$42,$02,$3E,$02,$39,$02,$35,$02
	dc.b	$31,$02,$2D,$02,$29,$02,$25,$02,$21,$02,$1D,$02,$19,$02,$16,$02
	dc.b	$12,$02,$0E,$02,$0A,$02,$06,$02,$03,$02,$FF,$01,$FB,$01,$F8,$01
	dc.b	$F4,$01,$F0,$01,$ED,$01,$E9,$01,$E6,$01,$E2,$01,$DF,$01,$DB,$01
	dc.b	$D8,$01,$D5,$01,$D1,$01,$CE,$01,$CA,$01,$C7,$01,$C4,$01,$C1,$01
	dc.b	$BD,$01,$BA,$01,$B7,$01,$B4,$01,$B1,$01,$AE,$01,$AB,$01,$A7,$01
	dc.b	$A4,$01

Bank080000_Z80LikeLookupTableTailByte_0991FF:
	dc.b	$00
