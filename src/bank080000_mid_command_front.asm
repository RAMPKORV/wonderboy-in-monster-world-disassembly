; ROM range: 0x099A85-0x09A347
; Front command-owner slice inside the 0x098000-0x09F776 non-fill island.
;
; Keep this separate from the Z80-program front, pre-descriptor records, and later FF-terminated
; command windows so the mid-bank island reads in subsystem-sized steps instead of one oversized
; catch-all file. The bytes here now justify four structural owners in ROM order: a zero-fill
; gap at 0x099A85-0x099AFF, a 25-word command lead-in at 0x099B00, a mostly same-window
; offset table at 0x099B32, and a source-visible 0x099BB0-0x09A347 table-targeted command front
; whose longer targets are already split at proven local FF, FD, and FE boundaries.

Bank080000_ZeroFill_099A85:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; Later words in the following table point back into this lead-in, so keep it separate from
; the offset list instead of hiding the whole block behind one anonymous incbin. The bytes
; still only justify a structural word-band split, but that is enough to make the full
; 0x099B00-0x09A347 pre-window command front source-visible in ROM order.
Bank080000_CommandLeadIn_099B00:
	dc.w	$58A5,$B416,$A8B2,$AA4B,$ADA1,$B092,$BAFA,$BE7E
	dc.w	$C2A0,$C640,$CD90,$CFB3,$D25C,$D99A,$DDF7,$E111
	dc.w	$E636,$E4BB,$ECFA,$ED81,$EE5C,$EFB1,$EFAE,$F644
	dc.w	$CCB1

; The repeated big-endian words from 0x099B32 onward mostly land back inside this same
; bank-local command region, making this the clearest currently proven structure in the tail
; data block. One word ($F7FD) still falls outside the local range, so keep the entries
; literal instead of forcing stronger subsystem meaning. Those local targets now split the
; command body into a short prelude plus narrower ROM-order record slices instead of one
; monolithic trailing incbin.
Bank080000_CommandOffsetTable_099B32:
	dc.w	$9BD3,$9BF5,$9B17,$9C3F,$9C67,$9C8F,$9CB5,$9CDC
	dc.w	$9CFE,$9C1C,$9D48,$9D78,$9D94,$9D99,$9DBB,$9DE6
	dc.w	$9D05,$9E36,$9E58,$9E7A,$9EA1,$9ED2,$9EF1,$9E0B
	dc.w	$9F24,$9F41,$9F63,$9F93,$9FAA,$9FC1,$9FDA,$9FFA
	dc.w	$9F10,$A02B,$A047,$A05A,$A06B,$A089,$A093,$A0AD
	dc.w	$A0BB,$A0D6,$A0DE,$A0F9,$A01E,$A13C,$A149,$A16A
	dc.w	$A199,$A1BB,$A1D8,$A1D8,$A1F2,$A10E,$A22B,$A245
	dc.w	$A25E,$A26B,$A288,$A26A,$F7FD,$A22D,$A348

; The first table-local target lands at 0x099BD3, leaving a short unreferenced prelude at
; 0x099BB0-0x099BD2 between the offset table and the first proven record boundary.
Bank080000_CommandRecordPrelude_099BB0:
	; The prelude is not targeted by the offset table, but it still resolves into one standalone
	; lead byte, a tuple-led FF-terminated setup record, and one short FD-tagged bridge into the
	; first table-targeted command at 0x099BD3.
Bank080000_CommandLeadIn_099BB0:
	dc.b	$A3

Bank080000_CommandSubrecord_099BB1:
	dc.b	$50,$08,$B9,$9B,$09,$C6,$9B,$FF

Bank080000_CommandSubrecord_099BB9:
	dc.b	$F6,$02,$F7,$01,$F1,$10,$F4,$10,$F0,$01,$C8,$3C,$FF

Bank080000_CommandLeadOut_099BC6:
	dc.b	$F3,$20,$00,$F6,$02,$F7,$02,$E2,$02,$FA,$FD,$BD,$9B

Bank080000_CommandRecord_099BD3:
	; The earliest table-targeted front records follow the same repeated shape: one tuple-style
	; FF-terminated header, one compact FF-terminated control body, and one short FD-tagged
	; bridge into the next local target.
Bank080000_CommandSubrecord_099BD3:
	dc.b	$50,$08,$DB,$9B,$09,$E8,$9B,$FF

Bank080000_CommandSubrecord_099BDB:
	dc.b	$F6,$02,$F7,$01,$F1,$10,$F4,$10,$F0,$01,$C8,$3E,$FF

Bank080000_CommandLeadOut_099BE8:
	dc.b	$F3,$20,$00,$F6,$02,$F7,$02,$E2,$02,$FA,$FD,$DF,$9B

Bank080000_CommandRecord_099BF5:
	; The next target uses the same tuple-plus-control cadence, then leaves a short bridge into
	; the neighboring 0x099C1C table target.
Bank080000_CommandSubrecord_099BF5:
	dc.b	$50,$08,$FD,$9B,$09,$0A,$9C,$FF

Bank080000_CommandSubrecord_099BFD:
	dc.b	$F6,$02,$F7,$01,$F1,$10,$F4,$10,$F0,$01,$C8,$43,$FF

Bank080000_CommandLeadOut_099C0A:
	dc.b	$F3,$20,$00,$F6,$02,$F7,$02,$E2,$02,$FA,$FD,$01,$9C,$50,$08,$1F,$9C,$09

Bank080000_CommandRecord_099C1C:
	; This target returns to the same tuple-led framing before a denser literal row and another
	; short FD-tagged bridge.
Bank080000_CommandSubrecord_099C1C:
	dc.b	$32,$9C,$FF

Bank080000_CommandSubrecord_099C1F:
	dc.b	$F6,$02,$F7,$01,$F1,$10,$F4,$10,$F0,$01,$C8,$3E,$3C,$3E,$3C,$3E,$43,$3E,$FF

Bank080000_CommandLeadOut_099C32:
	dc.b	$F3,$20,$00,$F6,$02,$F7,$02,$E2,$02,$FA,$FD,$23,$9C

Bank080000_CommandRecord_099C3F:
	; The next pair both keep one short tuple-led header, one literal-heavy FF-terminated body,
	; and one local-target bridge.
Bank080000_CommandSubrecord_099C3F:
	dc.b	$50,$08,$47,$9C,$09,$5A,$9C,$FF

Bank080000_CommandSubrecord_099C47:
	dc.b	$F6,$02,$F7,$01,$F1,$10,$F4,$10,$F0,$01,$C8,$3C,$3E,$43,$3E,$43,$3C,$3E,$FF

Bank080000_CommandLeadOut_099C5A:
	dc.b	$F3,$20,$00,$F6,$02,$F7,$02,$E2,$02,$FA,$FD,$4B,$9C

Bank080000_CommandRecord_099C67:
	; This neighboring target matches the same framing while swapping in a different literal row.
Bank080000_CommandSubrecord_099C67:
	dc.b	$50,$08,$6F,$9C,$09,$82,$9C,$FF

Bank080000_CommandSubrecord_099C6F:
	dc.b	$F6,$02,$F7,$01,$F1,$10,$F4,$10,$F0,$01,$C8,$3C,$43,$43,$3C,$3E,$3C,$3E,$FF

Bank080000_CommandLeadOut_099C82:
	dc.b	$F3,$20,$00,$F6,$02,$F7,$02,$E2,$02,$FA,$FD,$73,$9C

Bank080000_CommandRecord_099C8F:
	; The repeated tuple shape narrows here into one compact control record with two E2-tagged
	; pockets before the local FF terminator.
Bank080000_CommandSubrecord_099C8F:
	dc.b	$10,$09,$94,$9C,$FF

Bank080000_CommandSubrecord_099C94:
	dc.b	$F0,$06,$F1,$0F,$F2,$00,$0C,$F4,$00,$F6,$02,$F7,$02,$E2,$03,$0C,$0E,$0D,$0C
	dc.b	$0E,$0D,$E2,$06,$FC,$0C,$FC,$10,$FC,$13,$FC,$17,$1A,$FF

Bank080000_CommandRecord_099CB5:
	; This neighboring target stays tuple-led but ends with a compact F5/FE trailer instead of an
	; FD-tagged bridge.
Bank080000_CommandSubrecord_099CB5:
	dc.b	$14,$08,$BA,$9C,$FF

Bank080000_CommandSubrecord_099CBA:
	dc.b	$F0,$00,$F1,$0F,$F2,$00,$1C,$F4,$0A,$F6,$02,$F7,$01,$E2,$06,$26,$E2,$03,$18,$DC
	dc.b	$E2,$03,$18,$FC,$14,$24,$20,$F3,$40,$01,$F5,$04,$FE,$FF

Bank080000_CommandRecord_099CDC:
	; The last fully self-contained target before 0x099D05 returns to one tuple header plus one
	; denser FF-terminated control body and a short F5/FE tail.
Bank080000_CommandSubrecord_099CDC:
	dc.b	$10,$09,$E1,$9C,$FF

Bank080000_CommandSubrecord_099CE1:
	dc.b	$F0,$0C,$F1,$0F,$F2,$00,$1F,$F4,$06,$F6,$02,$F7,$02,$DD,$E2,$03,$FC,$00,$FC,$0C
	dc.b	$FC,$02,$F3,$32,$02,$F5,$20,$FE,$FF

Bank080000_CommandRecord_099CFE:
	; This short tuple starts one last bridge: the trailing F6 02 bytes feed the following
	; 0x099D05 command target rather than forming a standalone body here.
Bank080000_CommandSubrecord_099CFE:
	dc.b	$14,$07,$03,$9D,$FF

Bank080000_CommandLeadIn_099D03:
	dc.b	$F6,$02

Bank080000_CommandRecord_099D05:
	; This table-targeted pocket tightens into smaller FF-terminated command slices instead of
	; one opaque 0x43-byte record.
Bank080000_CommandSubrecord_099D05:
	dc.b	$F7,$04,$F0,$07,$F1,$0F,$F2,$80,$25,$F4,$00,$E2,$0C,$DB,$10,$1C
	dc.b	$F3,$00,$00,$F5,$0C,$FE,$FF

Bank080000_CommandSubrecord_099D1C:
	dc.b	$20,$07,$21,$9D,$FF

Bank080000_CommandSubrecord_099D21:
	dc.b	$F6,$02,$F7,$04,$F0,$07,$F1,$0F,$F2,$80,$09,$F4,$00,$E2,$05,$D9
	dc.b	$15,$0B,$F3,$00,$FC,$F5,$08,$FE,$F2,$80,$09,$F4,$00,$DB,$15,$15
	dc.b	$F3,$00,$FC,$F5,$04,$FE,$FF

Bank080000_CommandRecord_099D48:
	; The next adjacent table target follows the same pattern: a short FF-terminated lead-in
	; plus one larger FF-terminated continuation.
Bank080000_CommandSubrecord_099D48:
	dc.b	$20,$07,$4D,$9D,$FF

Bank080000_CommandSubrecord_099D4D:
	dc.b	$F6,$02,$F7,$04,$F0,$07,$F1,$0F,$F2,$80,$09,$F4,$00,$E2,$05,$D9
	dc.b	$15,$0B,$F3,$00,$FC,$F5,$08,$FE,$F2,$00,$08,$F4,$00,$F0,$01,$E2
	dc.b	$03,$D9,$DF,$FC,$10,$F3,$80,$01,$FE,$FE,$FF

Bank080000_CommandRecord_099D78:
	; This target splits cleanly into one short tuple-style lead-in, one compact control body,
	; and a tiny EF/F5 trailer instead of one opaque slice.
Bank080000_CommandSubrecord_099D78:
	dc.b	$20,$09,$7D,$9D,$FF

Bank080000_CommandSubrecord_099D7D:
	dc.b	$F6,$02,$F7,$02,$F0,$08,$F2,$80,$41,$F4,$00,$E2,$08,$DC,$10,$12
	dc.b	$F3,$FF

Bank080000_CommandSubrecord_099D8F:
	dc.b	$EF,$F5,$02,$FE,$FF

Bank080000_CommandRecord_099D94:
	dc.b	$70,$06,$A4,$9D,$FF

Bank080000_CommandRecord_099D99:
	; The neighboring target keeps the same short tuple preface before one larger control
	; continuation that ends at the local FF terminator.
Bank080000_CommandSubrecord_099D99:
	dc.b	$70,$06,$9E,$9D,$FF

Bank080000_CommandSubrecord_099D9E:
	dc.b	$F3,$00,$37,$FD,$A7,$9D,$F3,$00,$30,$F6,$00,$F7,$10,$F0,$0B,$F1
	dc.b	$0F,$F4,$00,$E2,$0C,$DB,$10,$F5,$18,$FE,$E2,$10,$FF

Bank080000_CommandRecord_099DBB:
	; This bridge is clearer as one tuple lead-in, two adjacent FF-terminated control records,
	; and one short FE/F5 trailer.
Bank080000_CommandSubrecord_099DBB:
	dc.b	$18,$07,$C0,$9D,$FF

Bank080000_CommandSubrecord_099DC0:
	dc.b	$F6,$02,$F7,$06,$F0,$09,$F1,$0F,$F2,$00,$33,$F4,$04,$E2,$07,$DE
	dc.b	$FC,$7F,$1C,$7C,$10,$F3,$00,$FF

Bank080000_CommandSubrecord_099DD8:
	dc.b	$FE,$DA,$FC,$7F,$1C,$7C,$10,$F3,$00,$FF

Bank080000_CommandSubrecord_099DE2:
	dc.b	$F5,$04,$FE,$FF

Bank080000_CommandRecord_099DE6:
	; This target and the next one interleave at proven local boundaries, so keep the tuple
	; bridge and the single-byte lead-in explicit instead of hiding them in raw slices.
Bank080000_CommandSubrecord_099DE6:
	dc.b	$18,$07,$EB,$9D,$FF

Bank080000_CommandSubrecord_099DEB:
	dc.b	$F6,$02,$F7,$06,$F0,$09,$F1,$0F,$F2,$00,$0C,$F4,$10,$E2,$03,$8F
	dc.b	$23,$FB,$FA,$84,$18,$E2,$03,$78,$0C,$FF

Bank080000_CommandSubrecord_099E05:
	dc.b	$18,$07,$0A,$9E,$FF

Bank080000_CommandLeadIn_099E0A:
	dc.b	$F6

Bank080000_CommandRecord_099E0B:
	; The following control run now stands as three compact FF-terminated pieces plus a short
	; FB/F5 tail rather than one 0x2B-byte blob.
Bank080000_CommandSubrecord_099E0B:
	dc.b	$02,$F7,$06,$F0,$00,$F1,$0E,$F2,$00,$18,$F4,$08,$DA,$C2,$84,$F3
	dc.b	$20,$00,$24,$F3,$E0,$FF

Bank080000_CommandSubrecord_099E21:
	dc.b	$7F,$F3,$20,$00,$1F,$F3,$E0,$FF

Bank080000_CommandSubrecord_099E29:
	dc.b	$73,$F3,$20,$00,$13,$F3,$E0,$FF

Bank080000_CommandSubrecord_099E31:
	dc.b	$FB,$F5,$08,$FE,$FF

Bank080000_CommandRecord_099E36:
	; This pair returns to the familiar tuple-plus-control shape already seen throughout the
	; front command window.
Bank080000_CommandSubrecord_099E36:
	dc.b	$18,$08,$3B,$9E,$FF

Bank080000_CommandSubrecord_099E3B:
	dc.b	$F7,$10,$F4,$08,$F1,$0E,$F2,$00,$10,$F0,$13,$C0,$10,$20,$FA,$FA
	dc.b	$FA,$17,$27,$DB,$C0,$07,$17,$C2,$FA,$F5,$18,$FE,$FF

Bank080000_CommandRecord_099E58:
	; The neighboring target keeps one short tuple lead-in and one denser FF-terminated control
	; continuation around the recurring DA/DC FC 10 pocket.
Bank080000_CommandSubrecord_099E58:
	dc.b	$20,$06,$5D,$9E,$FF

Bank080000_CommandSubrecord_099E5D:
	dc.b	$F6,$02,$F7,$01,$F0,$0A,$F1,$0E,$C0,$F2,$00,$18,$F4,$0C,$DA,$FC
	dc.b	$10,$F3,$80,$02,$FE,$DC,$FC,$10,$F3,$80,$FE,$FE,$FF

Bank080000_CommandRecord_099E7A:
	; This later target also breaks into one tuple-style preface plus a longer control body with
	; one small E2-tagged local-offset pocket before FF.
Bank080000_CommandSubrecord_099E7A:
	dc.b	$50,$06,$7F,$9E,$FF

Bank080000_CommandSubrecord_099E7F:
	dc.b	$F7,$10,$F4,$00,$F1,$0E,$F2,$00,$18,$F0,$13,$C0,$10,$12,$FA,$E2
	dc.b	$04,$10,$DB,$C1,$17,$C2,$14,$F5,$20,$C1,$14,$F5,$E4,$F3,$00,$04
	dc.b	$FE,$FF

Bank080000_CommandRecord_099EA1:
	; The next front-table target begins with the same tuple pattern, then opens into a larger
	; literal/high-byte pocket that is more readable in source than as one 0x31-byte incbin.
Bank080000_CommandSubrecord_099EA1:
	dc.b	$52,$07,$A6,$9E,$FF

Bank080000_CommandSubrecord_099EA6:
	dc.b	$F6,$00,$F7,$06,$F0,$21,$F4,$00,$F2,$00,$F4,$C5,$F1,$10,$A3,$48
	dc.b	$C4,$54,$53,$51,$C5,$AD,$51,$AF,$53,$C3,$B1,$54,$AA,$4D,$B3,$56
	dc.b	$AC,$4F,$B4,$58,$AD,$51,$C5,$B4,$5B,$C4,$FA,$FF

Bank080000_CommandRecord_099ED2:
	; This compact bridge resolves into one tuple lead-in, one short control record, and one tiny
	; FC/F5 trailer.
Bank080000_CommandSubrecord_099ED2:
	dc.b	$20,$09,$D7,$9E,$FF

Bank080000_CommandSubrecord_099ED7:
	dc.b	$F6,$02,$F7,$02,$F4,$00,$F2,$00,$15,$F1,$10,$F0,$0B,$E2,$0D,$DA
	dc.b	$05,$0A,$FA,$F3,$FF

Bank080000_CommandSubrecord_099EEC:
	dc.b	$FC,$F5,$04,$FE,$FF

Bank080000_CommandRecord_099EF1:
	; The next target is another tuple-plus-control pair, followed immediately by the short tuple
	; that leads into the adjacent 0x099F10 record.
Bank080000_CommandSubrecord_099EF1:
	dc.b	$22,$08,$F6,$9E,$FF

Bank080000_CommandSubrecord_099EF6:
	dc.b	$F6,$00,$F7,$10,$F0,$2C,$F1,$0F,$F4,$00,$E2,$0C,$DB,$3A,$F5,$0F
	dc.b	$F3,$00,$F8,$FE,$FF

Bank080000_CommandSubrecord_099F0B:
	dc.b	$10,$09,$10,$9F,$FF

Bank080000_CommandRecord_099F10:
	dc.b	$F7,$02,$F2,$00,$40,$F0,$2D,$F4,$00,$E2,$08,$30,$DD,$E2,$0A,$30
	dc.b	$F5,$12,$FE,$FF

Bank080000_CommandRecord_099F24:
	; This target returns to the same tuple-led shape seen earlier: one FF-terminated control
	; body plus a tiny F5/FE trailer.
Bank080000_CommandSubrecord_099F24:
	dc.b	$10,$09,$29,$9F,$FF

Bank080000_CommandSubrecord_099F29:
	dc.b	$F6,$02,$F7,$02,$F0,$0A,$F1,$0F,$F2,$00,$14,$F4,$00,$DF,$E2,$05
	dc.b	$10,$F3,$E0,$FF

Bank080000_CommandSubrecord_099F3D:
	dc.b	$F5,$03,$FE,$FF

Bank080000_CommandRecord_099F41:
	; The neighboring target adds one extra short FF-terminated tail after its main control run.
Bank080000_CommandSubrecord_099F41:
	dc.b	$40,$06,$46,$9F,$FF

Bank080000_CommandSubrecord_099F46:
	dc.b	$F7,$20,$F0,$17,$F1,$0F,$F2,$00,$18,$F4,$00,$DF,$DD,$E2,$07,$10
	dc.b	$F3,$E0,$FF

Bank080000_CommandSubrecord_099F59:
	dc.b	$F5,$03,$FE,$F4,$00,$F3,$78,$00,$FE,$FF

Bank080000_CommandRecord_099F63:
	; This later target stays as one tuple lead-in plus one longer FF-terminated control body.
Bank080000_CommandSubrecord_099F63:
	dc.b	$18,$08,$68,$9F,$FF

Bank080000_CommandSubrecord_099F68:
	dc.b	$F6,$00,$F7,$10,$F1,$0F,$F2,$00,$1C,$F4,$00,$F0,$09,$E2,$04,$DF
	dc.b	$FC,$10,$F3,$A0,$02,$FE,$E2,$03,$DB,$DC,$10,$FC,$F3,$80,$01,$FE
	dc.b	$DC,$FC,$10,$F3,$80,$FE,$FE,$F5,$14,$FE,$FF

Bank080000_CommandRecord_099F93:
	; Another short tuple-led record with one compact FF-terminated continuation.
Bank080000_CommandSubrecord_099F93:
	dc.b	$70,$08,$98,$9F,$FF

Bank080000_CommandSubrecord_099F98:
	dc.b	$F7,$10,$F1,$10,$F2,$00,$0C,$F0,$13,$C3,$20,$1B,$20,$1B,$20,$C6
	dc.b	$1B,$FF

Bank080000_CommandRecord_099FAA:
	; The next target keeps the same tuple-plus-control cadence around one wider literal/high-byte pocket.
Bank080000_CommandSubrecord_099FAA:
	dc.b	$70,$08,$AF,$9F,$FF

Bank080000_CommandSubrecord_099FAF:
	dc.b	$F7,$10,$F1,$10,$F2,$00,$28,$F4,$24,$F0,$10,$E2,$03,$DF,$10,$12
	dc.b	$FE,$FF

Bank080000_CommandRecord_099FC1:
	; This target narrows into one tuple lead-in plus one FF-terminated control continuation.
Bank080000_CommandSubrecord_099FC1:
	dc.b	$30,$06,$C6,$9F,$FF

Bank080000_CommandSubrecord_099FC6:
	dc.b	$F6,$02,$F7,$02,$F1,$10,$F2,$00,$0F,$F0,$07,$E2,$03,$DF,$14,$45
	dc.b	$F5,$04,$FE,$FF

Bank080000_CommandRecord_099FDA:
	; The neighboring target returns to one denser FF-terminated control body under the same tuple-style header.
Bank080000_CommandSubrecord_099FDA:
	dc.b	$28,$08,$DF,$9F,$FF

Bank080000_CommandSubrecord_099FDF:
	dc.b	$F7,$10,$F0,$2C,$F1,$0F,$C1,$F2,$00,$2C,$F4,$06,$DC,$FC,$10,$F3
	dc.b	$00,$FD,$FE,$DF,$FC,$10,$F3,$80,$FD,$FE,$FF

Bank080000_CommandRecord_099FFA:
	; This target ends on a compact FF-terminated body, then hands off to a tuple-led bridge for
	; the following 0x09A01E table target.
Bank080000_CommandSubrecord_099FFA:
	dc.b	$28,$08,$FF,$9F,$FF

Bank080000_CommandSubrecord_099FFF:
	dc.b	$F7,$30,$F0,$2E,$F1,$0F,$F4,$06,$E3,$80,$01,$74,$F3,$28,$00,$14
	dc.b	$FF

Bank080000_CommandSubrecord_09A010:
	dc.b	$14,$08,$15,$A0,$FF

Bank080000_CommandLeadIn_09A015:
	dc.b	$F7,$10,$F4,$04,$F2,$00,$0C,$F0,$2F

Bank080000_CommandRecord_09A01E:
	; The bridged target itself is one short FF-terminated control continuation.
Bank080000_CommandSubrecord_09A01E:
	dc.b	$C1,$18,$FA,$C2,$18,$DB,$C1,$18,$FA,$F5,$18,$FE,$FF

Bank080000_CommandRecord_09A02B:
	; This pair splits into one main FF-terminated control run and one tiny FF-terminated tail.
Bank080000_CommandSubrecord_09A02B:
	dc.b	$22,$09,$30,$A0,$FF

Bank080000_CommandSubrecord_09A030:
	dc.b	$F6,$02,$F7,$02,$F2,$00,$00,$F4,$00,$F0,$04,$DB,$C0,$55,$44,$40
	dc.b	$F3,$FF

Bank080000_CommandSubrecord_09A042:
	dc.b	$F0,$F5,$04,$FE,$FF

Bank080000_CommandRecord_09A047:
	; The next target returns to one tuple lead-in plus one compact FF-terminated control body.
Bank080000_CommandSubrecord_09A047:
	dc.b	$28,$08,$4C,$A0,$FF

Bank080000_CommandSubrecord_09A04C:
	dc.b	$F7,$10,$F2,$00,$00,$F4,$04,$F0,$30,$C1,$58,$C4,$50,$FF

Bank080000_CommandRecord_09A05A:
	; This neighboring target keeps the same short tuple header before one FF-terminated continuation.
Bank080000_CommandSubrecord_09A05A:
	dc.b	$48,$08,$5F,$A0,$FF

Bank080000_CommandSubrecord_09A05F:
	dc.b	$F7,$10,$F2,$00,$00,$F4,$00,$F0,$31,$CA,$50,$FF

Bank080000_CommandRecord_09A06B:
	; The next front-table target is another tuple-plus-control record with one tiny FE/F5 tail.
Bank080000_CommandSubrecord_09A06B:
	dc.b	$40,$09,$70,$A0,$FF

Bank080000_CommandSubrecord_09A070:
	dc.b	$F6,$02,$F7,$02,$F2,$00,$20,$F0,$0D,$F1,$10,$F4,$08,$DA,$DF,$C4
	dc.b	$10,$F3,$40,$02,$F5,$01,$FE,$FE,$FF

Bank080000_CommandRecord_09A089:
	; This short bridge is clearer as one tuple lead-in plus a tiny FF-terminated setup body.
Bank080000_CommandSubrecord_09A089:
	dc.b	$40,$09,$8E,$A0,$FF

Bank080000_CommandSubrecord_09A08E:
	dc.b	$F6,$02,$F7,$02,$FF

Bank080000_CommandRecord_09A093:
	; The following target begins with a longer lead-in before one FF-terminated control record.
Bank080000_CommandSubrecord_09A093:
	dc.b	$30,$08,$F6,$9E,$06,$9B,$A0,$FF

Bank080000_CommandSubrecord_09A09B:
	dc.b	$F6,$02,$F7,$01,$F0,$0B,$F1,$10,$C3,$24,$DB,$C1,$20,$11,$F5,$08
	dc.b	$FE,$FF

Bank080000_CommandRecord_09A0AD:
	; This short target keeps the same tuple-led shape before one compact FF-terminated body.
Bank080000_CommandSubrecord_09A0AD:
	dc.b	$14,$08,$B2,$A0,$FF

Bank080000_CommandSubrecord_09A0B2:
	dc.b	$F7,$10,$F0,$32,$F1,$0F,$CA,$32,$FF

Bank080000_CommandRecord_09A0BB:
	; The neighboring target is one tuple lead-in plus a denser FF-terminated control continuation.
Bank080000_CommandSubrecord_09A0BB:
	dc.b	$14,$06,$C0,$A0,$FF

Bank080000_CommandSubrecord_09A0C0:
	dc.b	$F6,$02,$F7,$05,$F1,$10,$F2,$00,$0C,$F4,$08,$F0,$10,$E3,$00,$70
	dc.b	$70,$F3,$42,$00,$10,$FF

Bank080000_CommandRecord_09A0D6:
	; This short bridge ends on a local-target tail that feeds the following 0x09A0DE target.
Bank080000_CommandSubrecord_09A0D6:
	dc.b	$14,$06,$DB,$A0,$FF

Bank080000_CommandLeadOut_09A0DB:
	dc.b	$FD,$9B,$A0

Bank080000_CommandRecord_09A0DE:
	; The bridged target itself returns to one tuple-led FF-terminated control run.
Bank080000_CommandSubrecord_09A0DE:
	dc.b	$14,$07,$E3,$A0,$FF

Bank080000_CommandSubrecord_09A0E3:
	dc.b	$F6,$02,$F7,$04,$F1,$10,$F2,$00,$20,$F4,$08,$F0,$0B,$E2,$09,$38
	dc.b	$42,$32,$E2,$0C,$23,$FF

Bank080000_CommandRecord_09A0F9:
	; This later target leaves one tuple-led bridge in front of the already explicit 0x09A10E
	; compound record.
Bank080000_CommandSubrecord_09A0F9:
	dc.b	$44,$07,$FE,$A0,$FF

Bank080000_CommandLeadOut_09A0FE:
	dc.b	$F6,$02,$F7,$06,$F1,$10,$D9,$DF,$F2,$00,$18,$D0,$17,$A1,$F2,$00

Bank080000_CommandRecord_09A10E:
	; 0x09A10E-0x09A13B is another compound command record with four FF-terminated slices and
	; one standalone FF byte made explicit.
Bank080000_CommandSubrecord_09A10E:
	dc.b	$0C,$D0,$17,$A1,$F5,$03,$FE,$FE,$FF

Bank080000_CommandSubrecord_09A117:
	dc.b	$F0,$04,$C2,$70,$17,$FF

Bank080000_CommandSentinel_09A11D:
Bank080000_CommandSubrecord_09A11D:
	dc.b	$FF

Bank080000_CommandSubrecord_09A11E:
	dc.b	$44,$07,$23,$A1,$FF

Bank080000_CommandSubrecord_09A123:
	dc.b	$F6,$02,$F7,$06,$F1,$10,$DC,$DF,$F2,$00,$18,$D0,$17,$A1,$F2,$00
	dc.b	$0C,$D0,$17,$A1,$F5,$01,$FE,$FE,$FF

; These two adjacent front-table targets are a little more structured than a pair of raw slices:
; both begin with the same short tuple-style lead-in, while the first leaves one compact
; non-terminated local-target tail and the second settles into one FF-terminated control record.
Bank080000_CommandRecord_09A13C:
Bank080000_CommandSubrecord_09A13C:
	dc.b	$12,$08,$41,$A1,$FF

Bank080000_CommandLeadOut_09A141:
	dc.b	$F7,$10,$F2,$00,$2F,$FD,$15,$9F

Bank080000_CommandRecord_09A149:
Bank080000_CommandSubrecord_09A149:
	dc.b	$1C,$07,$4E,$A1,$FF

Bank080000_CommandSubrecord_09A14E:
	dc.b	$F7,$10,$F1,$10,$F2,$00,$34,$F4,$0C,$F0,$2C,$DF,$FC,$C0,$20,$F5
	dc.b	$FF,$FE,$DF,$FC,$20,$F5,$08,$F3,$00,$00,$FE,$FF

Bank080000_CommandRecord_09A16A:
	; This later target also resolves into a short FF-terminated stub plus three compact
	; follow-on slices.
Bank080000_CommandSubrecord_09A16A:
	dc.b	$1A,$07,$6F,$A1,$FF

Bank080000_CommandSubrecord_09A16F:
	dc.b	$F6,$02,$F7,$06,$F1,$0E,$F2,$00,$10,$F4,$04,$DA,$C1,$7C,$F3,$40
	dc.b	$00,$1C,$F3,$C0,$FF

Bank080000_CommandSubrecord_09A184:
	dc.b	$70,$F3,$40,$00,$10,$F3,$C0,$FF

Bank080000_CommandSubrecord_09A18C:
	dc.b	$68,$F3,$40,$00,$08,$F3,$C0,$FF

Bank080000_CommandSubrecord_09A194:
	dc.b	$FB,$F5,$0C,$FE,$FF

; The remaining front-table targets at 0x09A199-0x09A287 also break cleanly at local FF
; terminators. A short two-byte lead-in at 0x09A22B and one standalone FF byte at 0x09A26A
; remain explicit because they sit between the same compact command slices.
Bank080000_CommandRecord_09A199:
Bank080000_CommandSubrecord_09A199:
	dc.b	$18,$08,$9E,$A1,$FF

Bank080000_CommandSubrecord_09A19E:
	dc.b	$F7,$10,$F4,$08,$F1,$0F,$F2,$00,$10,$F0,$13,$C0,$14,$34,$FA,$1B
	dc.b	$27,$C0,$30,$20,$FA,$FA,$C1,$30,$38,$24,$15,$34,$FF

Bank080000_CommandRecord_09A1BB:
Bank080000_CommandSubrecord_09A1BB:
	dc.b	$10,$09,$C0,$A1,$FF

Bank080000_CommandSubrecord_09A1C0:
	dc.b	$F0,$0C,$F1,$0F,$F2,$80,$25,$F4,$08,$F6,$02,$F7,$02,$E2,$05,$DD
	dc.b	$32,$3F,$38,$28,$F5,$10,$FE,$FF

Bank080000_CommandRecord_09A1D8:
Bank080000_CommandSubrecord_09A1D8:
	dc.b	$14,$09,$DD,$A1,$FF

Bank080000_CommandSubrecord_09A1DD:
	dc.b	$F6,$02,$F7,$01,$F0,$04,$F1,$10,$C3,$5F,$DB,$C1,$51,$53,$F5,$08
	dc.b	$F3,$FF

Bank080000_CommandSubrecord_09A1EF:
	dc.b	$FC,$FE,$FF

Bank080000_CommandRecord_09A1F2:
Bank080000_CommandSubrecord_09A1F2:
	dc.b	$20,$09,$F7,$A1,$FF

Bank080000_CommandSubrecord_09A1F7:
	dc.b	$F6,$02,$F7,$02,$F0,$0C,$F4,$00,$F1,$10,$C1,$50,$DD,$C1,$45,$53
	dc.b	$F5,$08,$F3,$FF

Bank080000_CommandSubrecord_09A20B:
	dc.b	$01,$FE,$FF

Bank080000_CommandSubrecord_09A20E:
	dc.b	$28,$06,$13,$A2,$FF

Bank080000_CommandSubrecord_09A213:
	dc.b	$F0,$0C,$F1,$0F,$F2,$80,$25,$F4,$00,$F6,$02,$F7,$01,$E2,$08,$DA
	dc.b	$32,$30,$33,$08,$F5,$18,$FE,$FF

Bank080000_CommandLeadIn_09A22B:
	dc.b	$14,$07

Bank080000_CommandRecord_09A22D:
Bank080000_CommandSubrecord_09A22D:
	dc.b	$30,$A2,$FF

Bank080000_CommandSubrecord_09A230:
	dc.b	$F6,$02,$F7,$02,$F4,$04,$F0,$07,$F1,$0D,$DA,$C0,$74,$34,$FA,$2A
	dc.b	$36,$F5,$2C,$FE,$FF

Bank080000_CommandRecord_09A245:
Bank080000_CommandSubrecord_09A245:
	dc.b	$2C,$06,$4A,$A2,$FF

Bank080000_CommandSubrecord_09A24A:
	dc.b	$F6,$02,$F7,$02,$F0,$0D,$F1,$0D,$DA,$C0,$31,$28,$FA,$FA,$1E,$2A
	dc.b	$F5,$18,$FE,$FF

Bank080000_CommandRecord_09A25E:
Bank080000_CommandSubrecord_09A25E:
	dc.b	$14,$06,$63,$A2,$FF

Bank080000_CommandSubrecord_09A263:
	dc.b	$F7,$30,$CA,$F0,$1F,$84,$28

Bank080000_CommandSentinel_09A26A:
Bank080000_CommandSubrecord_09A26A:
	dc.b	$FF

Bank080000_CommandRecord_09A26B:
Bank080000_CommandSubrecord_09A26B:
	dc.b	$28,$08,$70,$A2,$FF

Bank080000_CommandSubrecord_09A270:
	dc.b	$F7,$30,$F0,$2E,$F1,$0F,$F4,$1C,$E2,$25,$DF,$FC,$7F,$F3,$28,$00
	dc.b	$1F,$F3,$DC,$FF

Bank080000_CommandSubrecord_09A284:
	dc.b	$F5,$0C,$FE,$FF

Bank080000_CommandRecord_09A288:
	; The last front command-table target before 0x09A348 is a larger FF-terminated compound
	; pocket rather than one indivisible 0xC0-byte blob.
Bank080000_CommandSubrecord_09A288:
	dc.b	$78,$06,$93,$A2,$07,$AA,$A2,$08,$D2,$A2,$FF

Bank080000_CommandSubrecord_09A293:
	dc.b	$F0,$24,$F7,$30,$F4,$00,$C7,$F1,$0D,$F5,$1C,$32,$9C,$3E,$37,$99
	dc.b	$3A,$32,$3E,$C4,$99,$3B,$FF

Bank080000_CommandSubrecord_09A2AA:
	dc.b	$F0,$1F,$F7,$01,$F4,$00,$C3,$F1,$0C,$F5,$1C,$52,$53,$54,$4F,$50
	dc.b	$51,$52,$4D,$4E,$4F,$50,$4C,$4B,$4D,$4E,$48,$3F,$40,$41,$3D,$3E
	dc.b	$3A,$3B,$3D,$39,$38,$35,$CE,$FF

Bank080000_CommandSubrecord_09A2D2:
	dc.b	$F0,$04,$F7,$0E,$F4,$00,$C5,$F1,$0D,$F5,$1C,$9E,$43,$9E,$42,$9E
	dc.b	$42,$9C,$41,$9C,$41,$9B,$40,$9B,$40,$9A,$3F,$97,$3E,$A3,$48,$94
	dc.b	$3B,$AA,$4F,$94,$3B,$B1,$B6,$58,$C6,$FA,$FF

Bank080000_CommandSubrecord_09A2FD:
	dc.b	$88,$00,$03,$04,$A3,$00,$00,$F7,$01,$DA,$D0,$12,$9F,$C3,$FA,$FE
	dc.b	$D0,$43,$A1,$C5,$FA,$D1,$43,$A1,$C4,$FA,$D0,$12,$9F,$D0,$43,$A1
	dc.b	$C4,$FA,$D1,$12,$9F,$C6,$FA,$D0,$43,$A1,$D0,$12,$9F,$FD,$04,$A3
	dc.b	$70,$06,$32,$A3,$FF

Bank080000_CommandSubrecord_09A332:
	dc.b	$F7,$3F,$F0,$27,$F4,$02,$F1,$0E,$C2,$50,$54,$57,$F5,$1C,$DB,$50
	dc.b	$54,$57,$F5,$0E,$FE,$FF
