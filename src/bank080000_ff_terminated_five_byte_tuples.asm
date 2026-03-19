; ROM range: 0x0A10AB-0x0A34FF
; FF-terminated five-byte tuple family inside the second non-fill tail-bank island.
;
; The middle tail-bank lead-in is no longer one monolithic blob. Most of this span breaks into
; FF-terminated records whose pre-terminator payload length is a multiple of 5 bytes. The few
; bridge pockets that do not fit that cadence are now explicit as short FF-terminated mixed
; records, and several former anomaly pockets also stand explicitly as isolated FF-terminated
; records whose tuples merely embed $FF in data fields. Keep the labels structural until the
; loader proves whether these tuples are layout, object, script, or another resource family.

Bank080000_FFTerminatedFiveByteTupleRecord_0A10AB:
	dc.b	$0B,$60,$0C,$F8,$F8
	dc.b	$0F,$60,$18,$D8,$F8
	dc.b	$0D,$60,$04,$F8,$E8
	dc.b	$0F,$60,$7E,$00,$F8
	dc.b	$0D,$60,$76,$00,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A10C5:
	dc.b	$0B,$60,$0C,$F8,$E8
	dc.b	$0F,$60,$18,$D8,$E8
	dc.b	$0D,$60,$04,$F8,$D8
	dc.b	$0F,$60,$66,$00,$F8
	dc.b	$0D,$60,$5E,$00,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A10DF:
	dc.b	$0B,$60,$0C,$00,$D8
	dc.b	$0F,$60,$18,$E0,$D8
	dc.b	$0D,$60,$04,$00,$C8
	dc.b	$0F,$60,$4E,$00,$F8
	dc.b	$09,$60,$48,$08,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A10F9:
	dc.b	$0B,$60,$0C,$00,$D8
	dc.b	$0F,$60,$28,$E0,$D8
	dc.b	$0D,$60,$04,$00,$C8
	dc.b	$0F,$60,$4E,$00,$F8
	dc.b	$09,$60,$48,$08,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1113:
	dc.b	$0B,$60,$0C,$00,$D8
	dc.b	$0F,$60,$38,$E0,$D8
	dc.b	$0D,$60,$04,$00,$C8
	dc.b	$0F,$60,$4E,$00,$F8
	dc.b	$09,$60,$48,$08,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A112D:
	dc.b	$0D,$00,$20,$F0,$08
	dc.b	$0F,$00,$10,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1138:
	dc.b	$04,$00,$0C,$FC,$F4
	dc.b	$0D,$00,$20,$F0,$08
	dc.b	$0F,$00,$10,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1148:
	dc.b	$0D,$00,$38,$F1,$08
	dc.b	$0F,$00,$28,$F1,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1153:
	dc.b	$02,$00,$08,$10,$EF
	dc.b	$0D,$00,$00,$F0,$08
	dc.b	$0F,$00,$40,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1163:
	dc.b	$00,$00,$0E,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1169:
	dc.b	$00,$00,$0F,$00,$00
	dc.b	$00,$08,$0F,$F9,$00
	dc.b	$00,$10,$0F,$00,$F9
	dc.b	$00,$18,$0F,$F9,$F9
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A117E:
	dc.b	$00,$08,$50,$F9,$00
	dc.b	$00,$00,$50,$00,$00
	dc.b	$00,$10,$50,$00,$F9
	dc.b	$00,$18,$50,$F9,$F9
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1193:
	dc.b	$05,$00,$51,$00,$00
	dc.b	$05,$08,$51,$F1,$00
	dc.b	$05,$10,$51,$00,$F1
	dc.b	$05,$18,$51,$F1,$F1
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A11A8:
	dc.b	$05,$00,$54,$00,$00
	dc.b	$05,$08,$54,$F1,$00
	dc.b	$05,$10,$54,$00,$F1
	dc.b	$05,$18,$54,$F1,$F1
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A11BD:
	dc.b	$05,$00,$58,$00,$00
	dc.b	$05,$08,$58,$F1,$00
	dc.b	$05,$10,$58,$00,$F1
	dc.b	$05,$18,$58,$F1,$F1
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A11D2:
	dc.b	$05,$00,$5C,$00,$00
	dc.b	$05,$08,$5C,$F1,$00
	dc.b	$05,$10,$5C,$00,$F1
	dc.b	$05,$18,$5C,$F1,$F1
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A11E7:
	dc.b	$0D,$00,$38,$F0,$08
	dc.b	$0F,$00,$60,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A11F2:
	dc.b	$01,$08,$C0,$00,$FD
	dc.b	$01,$00,$C0,$F8,$05
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A11FD:
	dc.b	$01,$08,$C0,$01,$F9
	dc.b	$01,$00,$C0,$F8,$00
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1208:
	dc.b	$01,$08,$C0,$03,$F5
	dc.b	$01,$00,$C0,$F7,$FB
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1213:
	dc.b	$01,$08,$C0,$04,$F3
	dc.b	$01,$00,$C0,$F6,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A121E:
	dc.b	$01,$08,$C0,$05,$F2
	dc.b	$01,$00,$C0,$F5,$F6
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1229:
	dc.b	$00,$00,$C2,$05,$F5
	dc.b	$01,$00,$C0,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1234:
	dc.b	$00,$00,$C2,$06,$F4
	dc.b	$00,$00,$C2,$F4,$F6
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A123F:
	dc.b	$00,$00,$C2,$06,$F6
	dc.b	$00,$00,$C2,$F3,$F5
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A124A:
	dc.b	$00,$00,$C2,$07,$F8
	dc.b	$00,$00,$C2,$F2,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1255:
	dc.b	$00,$00,$C2,$07,$F9
	dc.b	$00,$00,$C2,$F1,$F5
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1260:
	dc.b	$00,$00,$C2,$08,$FB
	dc.b	$00,$00,$C2,$F1,$F7
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A126B:
	dc.b	$00,$00,$C2,$08,$FE
	dc.b	$00,$00,$C2,$F0,$FA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1276:
	dc.b	$00,$00,$C3,$0A,$00
	dc.b	$00,$00,$C3,$F0,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1281:
	dc.b	$00,$00,$C3,$0A,$02
	dc.b	$00,$00,$C3,$F0,$FE
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A128C:
	dc.b	$00,$00,$C3,$0A,$05
	dc.b	$00,$00,$C3,$F0,$01
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1297:
	dc.b	$00,$00,$C4,$0B,$08
	dc.b	$00,$00,$C4,$F0,$03
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A12A2:
	dc.b	$00,$00,$C4,$0B,$0B
	dc.b	$00,$00,$C4,$F0,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A12AD:
	dc.b	$00,$00,$C5,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A12B3:
	dc.b	$00,$58,$D0,$00,$00
	dc.b	$00,$50,$D0,$F9,$00
	dc.b	$00,$48,$D0,$00,$F9
	dc.b	$00,$40,$D0,$F9,$F9
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A12C8:
	dc.b	$05,$00,$80,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A12CE:
	dc.b	$05,$00,$84,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A12D4:
	dc.b	$05,$00,$88,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A12DA:
	dc.b	$0A,$00,$8C,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A12E0:
	dc.b	$0A,$00,$95,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A12E6:
	dc.b	$05,$00,$18,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A12EC:
	dc.b	$01,$10,$07,$10,$00
	dc.b	$01,$00,$07,$10,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A12F7:
	dc.b	$01,$10,$0A,$10,$00
	dc.b	$01,$00,$0A,$10,$F0
	dc.b	$00,$10,$09,$08,$10
	dc.b	$00,$00,$09,$08,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A130C:
	dc.b	$01,$10,$0C,$0E,$03
	dc.b	$01,$00,$0C,$0E,$ED
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1317:
	dc.b	$01,$10,$10,$0E,$02
	dc.b	$04,$10,$0E,$02,$0E
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1322:
	dc.b	$01,$10,$15,$0F,$00,$08,$10,$12,$FF,$0F,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A132D:
	dc.b	$01,$10,$19,$10,$00
	dc.b	$04,$10,$17,$00,$10
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1338:
	dc.b	$04,$18,$00,$00,$10
	dc.b	$04,$10,$00,$F0,$10
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1343:
	dc.b	$00,$18,$02,$10,$08
	dc.b	$00,$10,$02,$E8,$08
	dc.b	$04,$18,$03,$00,$10
	dc.b	$04,$10,$03,$F0,$10
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1358:
	dc.b	$04,$18,$05,$03,$0E
	dc.b	$04,$10,$05,$ED,$0E
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1363:
	dc.b	$01,$18,$10,$EA,$02
	dc.b	$04,$18,$0E,$EE,$0E
	dc.b	$FF

Bank080000_FFTerminatedMixedBridgeRecord_0A136E:
	dc.b	$08,$18,$12,$E9,$0F,$01,$18,$15,$E9,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1378:
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1379:
	dc.b	$01,$18,$19,$E8,$00
	dc.b	$04,$18,$17,$F0,$10
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1384:
	dc.b	$01,$18,$07,$E8,$00
	dc.b	$01,$08,$07,$E8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A138F:
	dc.b	$00,$18,$09,$F0,$10
	dc.b	$01,$18,$0A,$E8,$00
	dc.b	$01,$08,$0A,$E8,$F0
	dc.b	$00,$08,$09,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A13A4:
	dc.b	$01,$18,$0C,$EA,$03
	dc.b	$01,$08,$0C,$EA,$ED
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A13AF:
	dc.b	$01,$08,$10,$EA,$EE
	dc.b	$04,$08,$0E,$EE,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A13BA:
	dc.b	$01,$08,$15,$E9,$F1
	dc.b	$08,$08,$12,$E9,$E9
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A13C5:
	dc.b	$01,$08,$19,$E8,$F0
	dc.b	$04,$08,$17,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A13D0:
	dc.b	$04,$08,$00,$00,$E8
	dc.b	$04,$00,$00,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A13DB:
	dc.b	$00,$08,$02,$10,$F0
	dc.b	$00,$00,$02,$E8,$F0
	dc.b	$04,$08,$03,$00,$E8
	dc.b	$04,$00,$03,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A13F0:
	dc.b	$04,$08,$05,$03,$EA
	dc.b	$04,$00,$05,$ED,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A13FB:
	dc.b	$01,$00,$10,$0E,$EE
	dc.b	$04,$00,$0E,$02,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1406:
	dc.b	$01,$00,$15,$0F,$F0,$08,$00,$12,$FF,$E9,$FF

; The whole 0x0A10AB-0x0A34FF window now belongs to one proven record family, but the larger
; loader-owned subfamilies inside it are still unresolved. Keep the child segments in ROM order
; and let their filenames stay address-stamped until stronger ownership than local subdivision is
; proven.
Bank080000_FFTerminatedFiveByteTupleSegment_0A1411:
	include "src/bank080000_a1411.asm"

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D3F:
	dc.b	$00,$02,$52,$FF,$FF,$FF,$00,$02,$53,$FF,$FF,$FF,$00,$02,$54,$FF

Bank080000_FFTerminatedFiveByteTupleSegment_0A1D4F:
	include "src/bank080000_a1d4f.asm"

Bank080000_FFTerminatedMixedBridgeRecord_0A23F6:
	dc.b	$04,$48,$26,$03,$FF,$04,$40,$26,$ED,$FF

Bank080000_FFTerminatedFiveByteTupleSegment_0A2400:
	include "src/bank080000_a2400.asm"

Bank080000_FFTerminatedMixedBridgeRecord_0A2586:
	dc.b	$00,$43,$9C,$F0,$FF

Bank080000_FFTerminatedFiveByteTupleSegment_0A258B:
	include "src/bank080000_a258b.asm"

Bank080000_FFTerminatedMixedBridgeRecord_0A2606:
	dc.b	$00,$43,$9D,$06,$07,$00,$43,$9E,$F5,$FF

Bank080000_FFTerminatedFiveByteTupleSegment_0A2610:
	include "src/bank080000_a2610.asm"

Bank080000_FFTerminatedFiveByteTupleRecord_0A2765:
	dc.b	$08,$61,$08,$08,$08,$08,$61,$05,$08,$00,$08,$61,$02,$08,$F8,$08
	dc.b	$60,$FF,$08,$F0,$0C,$60,$F8,$E8,$08,$0C,$60,$F8,$E8,$F0,$0C,$60
	dc.b	$F8,$E8,$00,$0C,$60,$F8,$E8,$F8,$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A278E:
	dc.b	$08,$61,$0B,$08,$10,$08,$61,$08,$08,$08,$08,$61,$05,$08,$00,$08
	dc.b	$61,$02,$08,$F8,$08,$60,$FF,$08,$F0,$08,$60,$FC,$08,$E8,$0C,$60
	dc.b	$F8,$E8,$10,$0C,$60,$F8,$E8,$E8,$0C,$60,$F8,$E8,$08,$0C,$60,$F8
	dc.b	$E8,$F0,$0C,$60,$F8,$E8,$00,$0C,$60,$F8,$E8,$F8,$FF

Bank080000_FFTerminatedFiveByteTupleSegment_0A27CB:
	include "src/bank080000_a27cb.asm"

Bank080000_FFTerminatedFiveByteTupleRecord_0A2D86:
	dc.b	$00,$60,$FF,$0C,$08,$0C,$60,$FB,$EC,$08,$03,$60,$F7,$0C,$E8,$0F
	dc.b	$60,$E7,$EC,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleSegment_0A2D9B:
	include "src/bank080000_a2d9b.asm"

Bank080000_FFTerminatedFiveByteTupleRecord_0A3040:
	dc.b	$0E,$03,$FF,$F0,$F8,$09,$03,$E1,$F8,$E8,$FF

Bank080000_FFTerminatedFiveByteTupleSegment_0A304B:
	include "src/bank080000_a304b.asm"
