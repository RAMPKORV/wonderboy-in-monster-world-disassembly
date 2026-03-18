; ROM range: 0x0A3500-0x0A4C76
; Table-targeted payload record starts reached from the nested 0x0A0000-0x0A07C5 offset tree.
; The table evidence proves stable ROM-order boundaries across the back half of this island,
; so keep those targets explicit even though the higher-level loader and record semantics are
; still unresolved.

	include "src/bank080000_a3500_front.asm"

; 0x0A37B0-0x0A37FF tightens into a small structured cluster: twelve fixed 3-word
; records followed by two standalone local offsets before the next mixed record family.
Bank080000_TripleWordRecordBand_0A37B0:
Bank080000_TableTargetedPayloadRecord_0A37B0:
	dc.w	$FC08,$0800,$0D86

Bank080000_TableTargetedPayloadRecord_0A37B6:
	dc.w	$FC10,$0800,$0D91

Bank080000_TableTargetedPayloadRecord_0A37BC:
	dc.w	$FC18,$0800,$0D97

Bank080000_TableTargetedPayloadRecord_0A37C2:
	dc.w	$FC08,$0800,$0DA2

Bank080000_TableTargetedPayloadRecord_0A37C8:
	dc.w	$FC10,$0800,$0DAD

Bank080000_TableTargetedPayloadRecord_0A37CE:
	dc.w	$FC18,$0800,$0DB8

Bank080000_TableTargetedPayloadRecord_0A37D4:
	dc.w	$FC08,$0800,$0DC3

Bank080000_TableTargetedPayloadRecord_0A37DA:
	dc.w	$FC10,$0800,$0DCE

Bank080000_TableTargetedPayloadRecord_0A37E0:
	dc.w	$FC18,$0800,$0DD4

Bank080000_TableTargetedPayloadRecord_0A37E6:
	dc.w	$FC08,$0800,$0DDF

Bank080000_TableTargetedPayloadRecord_0A37EC:
	dc.w	$FC10,$0800,$0DEA

Bank080000_TableTargetedPayloadRecord_0A37F2:
	dc.w	$FC18,$0800,$0DF5

Bank080000_StandaloneLocalOffset_0A37F8:
Bank080000_TableTargetedPayloadRecord_0A37F8:
	dc.b	$00,$0E,$00

Bank080000_StandaloneLocalOffset_0A37FB:
Bank080000_TableTargetedPayloadRecord_0A37FB:
	dc.b	$00,$0E,$4C

; 0x0A37FE-0x0A3B76 tightens into another compact local-offset/control pocket rather than a
; long run of unrelated tiny slices. The recurring front prefixes (`FC .. .. FB .. ..`) and
; the repeated local 24-bit targets into the earlier 0x0A0E85-0x0A12E5 and 0x0A12EC+ data
; families are now explicit in source, while the higher-level owner stays unresolved.
Bank080000_TableTargetedPayloadRecord_0A37FE:
	dc.b	$FC,$0C,$0C,$FB,$0A,$0A,$00,$0E,$85

Bank080000_TableTargetedPayloadRecord_0A3807:
	dc.b	$08,$0E,$97,$08,$0E,$9D,$FF

Bank080000_TableTargetedPayloadRecord_0A380E:
	dc.b	$00,$0E,$97

Bank080000_TableTargetedPayloadRecord_0A3811:
	dc.b	$00,$0E,$85

Bank080000_TableTargetedPayloadRecord_0A3814:
	dc.b	$08,$0E,$85,$08,$0E,$8B,$FF

Bank080000_TableTargetedPayloadRecord_0A381B:
	dc.b	$08,$0E,$91,$02,$0E,$91,$F8,$08,$0E,$91,$00,$0E
	dc.b	$85

Bank080000_TableTargetedPayloadRecord_0A3828:
	dc.b	$FC,$08,$08,$FB,$06,$06,$00,$0E,$A3

Bank080000_TableTargetedPayloadRecord_0A3831:
	dc.b	$08,$0E,$AF,$08,$0E,$B5,$FF

Bank080000_TableTargetedPayloadRecord_0A3838:
	dc.b	$00,$0E,$AF

Bank080000_TableTargetedPayloadRecord_0A383B:
	dc.b	$08,$0E,$A3,$08,$0E,$A9,$FF

Bank080000_TableTargetedPayloadRecord_0A3842:
	dc.b	$00,$0E,$A9

Bank080000_TableTargetedPayloadRecord_0A3845:
	dc.b	$08,$0E,$91,$08,$0E,$97,$FF

Bank080000_TableTargetedPayloadRecord_0A384C:
	dc.b	$00,$0E,$91

Bank080000_TableTargetedPayloadRecord_0A384F:
	dc.b	$08,$0E,$85,$08,$0E,$8B,$FF

Bank080000_TableTargetedPayloadRecord_0A3856:
	dc.b	$FC,$0C,$0C,$FB,$0A,$0A,$00,$0E,$CD

Bank080000_TableTargetedPayloadRecord_0A385F:
	dc.b	$08,$0E,$D3,$08,$0E,$D9,$FF

Bank080000_TableTargetedPayloadRecord_0A3866:
	dc.b	$00,$0E,$D9

Bank080000_TableTargetedPayloadRecord_0A3869:
	dc.b	$00,$0E,$CD

Bank080000_TableTargetedPayloadRecord_0A386C:
	dc.b	$08,$0E,$BB,$08,$0E,$C1,$08,$0E,$C7,$FF

Bank080000_TableTargetedPayloadRecord_0A3876:
	dc.b	$00,$0E,$BB

Bank080000_TableTargetedPayloadRecord_0A3879:
	dc.b	$FC,$08,$08,$FB,$06,$06,$00,$0E,$FD

Bank080000_TableTargetedPayloadRecord_0A3882:
	dc.b	$08,$0E,$F1,$08,$0E,$F7,$FF

Bank080000_TableTargetedPayloadRecord_0A3889:
	dc.b	$00,$0E,$FD

Bank080000_TableTargetedPayloadRecord_0A388C:
	dc.b	$06,$0E,$DF,$06,$0E,$E5,$06,$0E,$EB,$FF

Bank080000_TableTargetedPayloadRecord_0A3896:
	dc.b	$00,$0E,$DF

Bank080000_TableTargetedPayloadRecord_0A3899:
	dc.b	$FC,$04,$04,$FB,$03,$03,$00,$0F,$03

Bank080000_TableTargetedPayloadRecord_0A38A2:
	dc.b	$08,$0F,$03,$08,$0F,$09,$FF

Bank080000_TableTargetedPayloadRecord_0A38A9:
	dc.b	$00,$0F,$09

Bank080000_TableTargetedPayloadRecord_0A38AC:
	dc.b	$00,$0F,$03

Bank080000_TableTargetedPayloadRecord_0A38AF:
	dc.b	$FC,$08,$08,$FB,$07,$07,$00,$0E,$FD

Bank080000_TableTargetedPayloadRecord_0A38B8:
	dc.b	$08,$0F,$0F,$08,$0E,$F7,$FF

Bank080000_TableTargetedPayloadRecord_0A38BF:
	dc.b	$00,$0E,$F7

Bank080000_TableTargetedPayloadRecord_0A38C2:
	dc.b	$08,$0E,$DF,$08,$0E,$E5,$08,$0E,$EB,$FF

Bank080000_TableTargetedPayloadRecord_0A38CC:
	dc.b	$FC,$08,$08,$FB,$07,$07,$00,$0E,$A3

Bank080000_TableTargetedPayloadRecord_0A38D5:
	dc.b	$08,$0E,$B5,$08,$0F,$15,$FF

Bank080000_TableTargetedPayloadRecord_0A38DC:
	dc.b	$00,$0E,$A3

Bank080000_TableTargetedPayloadRecord_0A38DF:
	dc.b	$08,$0E,$A3,$08,$0E,$A9,$08,$0E,$AF,$FF

Bank080000_TableTargetedPayloadRecord_0A38E9:
	dc.b	$FC,$08,$08,$FB,$07,$07,$00,$0E,$E5

Bank080000_TableTargetedPayloadRecord_0A38F2:
	dc.b	$08,$0E,$F1,$08,$0E,$F7,$FF

Bank080000_TableTargetedPayloadRecord_0A38F9:
	dc.b	$00,$0E,$F1

Bank080000_TableTargetedPayloadRecord_0A38FC:
	dc.b	$00,$0E,$E5

Bank080000_TableTargetedPayloadRecord_0A38FF:
	dc.b	$08,$0E,$DF,$08,$0E,$E5,$08,$0E,$EB,$08,$0E,$E5
	dc.b	$FF

Bank080000_TableTargetedPayloadRecord_0A390C:
	dc.b	$FC,$08,$08,$FB,$07,$07,$00,$0E,$DF

Bank080000_TableTargetedPayloadRecord_0A3915:
	dc.b	$FB,$08,$08,$00,$0E,$E5

Bank080000_TableTargetedPayloadRecord_0A391B:
	dc.b	$08,$0E,$DF,$08,$0E,$E5,$08,$0E,$EB,$08,$0E,$E5
	dc.b	$FF

Bank080000_TableTargetedPayloadRecord_0A3928:
	dc.b	$16,$0F,$1B,$FE,$08,$0E,$F1,$08,$0F,$1B,$FF

Bank080000_TableTargetedPayloadRecord_0A3933:
	dc.b	$FC,$04,$04,$FB,$03,$03,$FE,$08,$0F,$21,$08,$0F
	dc.b	$27,$FF

Bank080000_TableTargetedPayloadRecord_0A3941:
	dc.b	$FC,$14,$12,$FB,$10,$10,$00,$0F,$47

Bank080000_TableTargetedPayloadRecord_0A394A:
	dc.b	$00,$0F,$95

Bank080000_TableTargetedPayloadRecord_0A394D:
	dc.b	$00,$0F,$7B

Bank080000_TableTargetedPayloadRecord_0A3950:
	dc.b	$00,$0F,$47

Bank080000_TableTargetedPayloadRecord_0A3953:
	dc.b	$02,$0F,$2D,$02,$0F,$47,$02,$0F,$61,$02,$0F,$47
	dc.b	$FF

Bank080000_TableTargetedPayloadRecord_0A3960:
	dc.b	$04,$0F,$7B,$F8,$04,$0F,$7B,$08,$0F,$47,$FD

Bank080000_TableTargetedPayloadRecord_0A396B:
	dc.b	$FC,$0C,$0C,$FB,$0A,$0A,$00,$0F,$D9

Bank080000_TableTargetedPayloadRecord_0A3974:
	dc.b	$08,$0F,$CD,$08,$0F,$D3,$FF

Bank080000_TableTargetedPayloadRecord_0A397B:
	dc.b	$00,$0F,$D3

Bank080000_TableTargetedPayloadRecord_0A397E:
	dc.b	$00,$0F,$D9

Bank080000_TableTargetedPayloadRecord_0A3981:
	dc.b	$08,$0F,$AF,$08,$0F,$B5,$08,$0F,$BB,$FF

Bank080000_TableTargetedPayloadRecord_0A398B:
	dc.b	$00,$0F,$B5

Bank080000_TableTargetedPayloadRecord_0A398E:
	dc.b	$06,$0F,$C1,$04,$0F,$C7,$02,$0F,$C1,$FD

Bank080000_TableTargetedPayloadRecord_0A3998:
	dc.b	$08,$0F,$DF,$08,$0F,$E5,$FF

Bank080000_TableTargetedPayloadRecord_0A399F:
	dc.b	$FC,$0C,$0C,$FB,$0A,$0A,$00,$0F,$AF

Bank080000_TableTargetedPayloadRecord_0A39A8:
	dc.b	$08,$0F,$BB,$08,$0F,$C1,$FF

Bank080000_TableTargetedPayloadRecord_0A39AF:
	dc.b	$00,$0F,$BB

Bank080000_TableTargetedPayloadRecord_0A39B2:
	dc.b	$08,$0F,$AF,$08,$0F,$B5,$FF

Bank080000_TableTargetedPayloadRecord_0A39B9:
	dc.b	$08,$0F,$EB,$08,$0F,$F1,$FF

Bank080000_TableTargetedPayloadRecord_0A39C0:
	dc.b	$00,$0F,$EB

Bank080000_TableTargetedPayloadRecord_0A39C3:
	dc.b	$00,$0F,$AF

Bank080000_TableTargetedPayloadRecord_0A39C6:
	dc.b	$08,$0F,$BB,$F8,$0C,$0F,$C1,$08,$0F,$AF,$FD

Bank080000_TableTargetedPayloadRecord_0A39D1:
	dc.b	$FC,$0C,$10,$FB,$0A,$0E,$00,$10,$09

Bank080000_TableTargetedPayloadRecord_0A39DA:
	dc.b	$08,$10,$15,$08,$10,$1B,$FF

Bank080000_TableTargetedPayloadRecord_0A39E1:
	dc.b	$00,$10,$15

Bank080000_TableTargetedPayloadRecord_0A39E4:
	dc.b	$00,$10,$09

Bank080000_TableTargetedPayloadRecord_0A39E7:
	dc.b	$06,$0F,$F7,$06,$0F,$FD,$06,$10,$03,$FF

Bank080000_TableTargetedPayloadRecord_0A39F1:
	dc.b	$08,$10,$0F,$F8,$04,$10,$0F,$04,$10,$09,$FD

Bank080000_TableTargetedPayloadRecord_0A39FC:
	dc.b	$FC,$0C,$0C,$FB,$0A,$0A,$00,$0E,$BB

Bank080000_TableTargetedPayloadRecord_0A3A05:
	dc.b	$08,$10,$21,$08,$10,$27,$FF

Bank080000_TableTargetedPayloadRecord_0A3A0C:
	dc.b	$00,$10,$21

Bank080000_TableTargetedPayloadRecord_0A3A0F:
	dc.b	$04,$0E,$CD,$F8,$04,$0E,$D3,$04,$0E,$D9,$04,$0E
	dc.b	$BB,$FD

Bank080000_TableTargetedPayloadRecord_0A3A1D:
	dc.b	$FC,$08,$08,$FB,$06,$06,$00,$10,$2D

Bank080000_TableTargetedPayloadRecord_0A3A26:
	dc.b	$06,$10,$33,$04,$10,$39,$FD

Bank080000_TableTargetedPayloadRecord_0A3A2D:
	dc.b	$FC,$06,$06,$FB,$03,$03,$06,$10,$3F,$06,$10,$45
	dc.b	$06,$10,$4B,$06,$10,$51,$FF

Bank080000_TableTargetedPayloadRecord_0A3A40:
	dc.b	$FC,$08,$08,$FB,$05,$05,$06,$10,$57,$06,$10,$5D
	dc.b	$06,$10,$63,$06,$10,$69,$FF

Bank080000_TableTargetedPayloadRecord_0A3A53:
	dc.b	$FC,$08,$08,$FB,$05,$05,$00,$10,$6F

Bank080000_TableTargetedPayloadRecord_0A3A5C:
	dc.b	$FC,$08,$08,$FB,$05,$05,$03,$10,$75,$03,$10,$7B
	dc.b	$FD

Bank080000_TableTargetedPayloadRecord_0A3A69:
	dc.b	$FC,$10,$10,$FB,$06,$08,$00,$10,$81

Bank080000_TableTargetedPayloadRecord_0A3A72:
	dc.b	$FC,$10,$10,$FB,$08,$06,$03,$10,$87,$03,$10,$8D
	dc.b	$FD

Bank080000_TableTargetedPayloadRecord_0A3A7F:
	dc.b	$FC,$04,$04,$FB,$04,$04,$00,$10,$93

Bank080000_TableTargetedPayloadRecord_0A3A88:
	dc.b	$FC,$07,$07,$FB,$05,$05,$00,$10,$99

Bank080000_TableTargetedPayloadRecord_0A3A91:
	dc.b	$03,$10,$9F,$03,$10,$A5,$03,$10,$9F,$03,$10,$A5
	dc.b	$FD

Bank080000_TableTargetedPayloadRecord_0A3A9E:
	dc.b	$00,$10,$AB

Bank080000_TableTargetedPayloadRecord_0A3AA1:
	dc.b	$06,$10,$C5,$00,$10,$DF

Bank080000_TableTargetedPayloadRecord_0A3AA7:
	dc.b	$05,$10,$DF,$05,$10,$F9,$05,$11,$13,$05,$10,$F9
	dc.b	$00,$10,$DF

Bank080000_TableTargetedPayloadRecord_0A3AB6:
	dc.b	$00,$10,$DF

Bank080000_TableTargetedPayloadRecord_0A3AB9:
	dc.b	$FC,$0A,$10,$FB,$06,$0B,$50,$11,$2D,$06,$11,$38
	dc.b	$FF

Bank080000_TableTargetedPayloadRecord_0A3AC6:
	dc.b	$FC,$0A,$10,$FB,$06,$0B,$06,$11,$48,$12,$11,$53
	dc.b	$00,$11,$2D

Bank080000_TableTargetedPayloadRecord_0A3AD5:
	dc.b	$03,$11,$63,$04,$11,$69,$05,$11,$7E,$F9,$04,$11
	dc.b	$93,$04,$11,$A8,$04,$11,$BD,$04,$11,$D2,$FD

Bank080000_TableTargetedPayloadRecord_0A3AEC:
	dc.b	$FC,$0A,$10,$FB,$06,$0B,$00,$11,$E7

Bank080000_TableTargetedPayloadRecord_0A3AF5:
	dc.b	$FC,$10,$10,$FB,$08,$08,$01,$11,$F2,$01,$11,$FD
	dc.b	$01,$12,$08,$01,$12,$13,$02,$12,$1E,$03,$12,$29
	dc.b	$02,$12,$34,$01,$12,$3F,$01,$12,$4A,$01,$12,$55
	dc.b	$01,$12,$60,$01,$12,$6B,$01,$12,$76,$01,$12,$81
	dc.b	$01,$12,$8C,$01,$12,$97,$01,$12,$A2,$FD

Bank080000_TableTargetedPayloadRecord_0A3B2F:
	dc.b	$FC,$04,$04,$FB,$02,$02,$00,$12,$AD

Bank080000_TableTargetedPayloadRecord_0A3B38:
	dc.b	$06,$12,$B3,$FD

Bank080000_TableTargetedPayloadRecord_0A3B3C:
	dc.b	$06,$12,$C8,$06,$12,$CE,$06,$12,$D4,$FD

Bank080000_TableTargetedPayloadRecord_0A3B46:
	dc.b	$04,$12,$C8,$04,$12,$CE,$04,$12,$DA,$04,$12,$E0
	dc.b	$FD

Bank080000_TableTargetedPayloadRecord_0A3B53:
	dc.b	$FC,$07,$07,$FB,$04,$04,$FE,$02,$0E,$DF,$02,$0E
	dc.b	$E5,$02,$0E,$EB,$02,$0E,$F1,$FF

Bank080000_TableTargetedPayloadRecord_0A3B67:
	dc.b	$FC,$07,$07,$02,$0E,$F7,$02,$0E,$FD,$02,$12,$E6
	dc.b	$02,$0E,$F1,$FD

; 0x0A3B77-0x0A3C16 is a regular run of records with three local 24-bit offsets and a
; trailing $FD byte. The pointed starts land back in the 0x0A12EC-0x0A1519 tuple family.
Bank080000_LocalOffsetTripletRecordBand_0A3B77:
Bank080000_TableTargetedPayloadRecord_0A3B77:
	dc.b	$02,$12,$EC,$02,$12,$F7,$02,$13,$0C,$FD

Bank080000_TableTargetedPayloadRecord_0A3B81:
	dc.b	$02,$13,$17,$02,$13,$22,$02,$13,$2D,$FD

Bank080000_TableTargetedPayloadRecord_0A3B8B:
	dc.b	$02,$13,$38,$02,$13,$43,$02,$13,$58,$FD

Bank080000_TableTargetedPayloadRecord_0A3B95:
	dc.b	$02,$13,$63,$02,$13,$6E,$02,$13,$79,$FD

Bank080000_TableTargetedPayloadRecord_0A3B9F:
	dc.b	$02,$13,$84,$02,$13,$8F,$02,$13,$A4,$FD

Bank080000_TableTargetedPayloadRecord_0A3BA9:
	dc.b	$02,$13,$AF,$02,$13,$BA,$02,$13,$C5,$FD

Bank080000_TableTargetedPayloadRecord_0A3BB3:
	dc.b	$02,$13,$D0,$02,$13,$DB,$02,$13,$F0,$FD

Bank080000_TableTargetedPayloadRecord_0A3BBD:
	dc.b	$02,$13,$FB,$02,$14,$06,$02,$14,$11,$FD

Bank080000_TableTargetedPayloadRecord_0A3BC7:
	dc.b	$02,$14,$1C,$02,$14,$27,$02,$14,$32,$FD

Bank080000_TableTargetedPayloadRecord_0A3BD1:
	dc.b	$02,$14,$3D,$02,$14,$48,$02,$14,$53,$FD

Bank080000_TableTargetedPayloadRecord_0A3BDB:
	dc.b	$02,$14,$5E,$02,$14,$69,$02,$14,$74,$FD

Bank080000_TableTargetedPayloadRecord_0A3BE5:
	dc.b	$02,$14,$7F,$02,$14,$8A,$02,$14,$95,$FD

Bank080000_TableTargetedPayloadRecord_0A3BEF:
	dc.b	$02,$14,$A0,$02,$14,$AB,$02,$14,$B6,$FD

Bank080000_TableTargetedPayloadRecord_0A3BF9:
	dc.b	$02,$14,$C1,$02,$14,$CC,$02,$14,$D7,$FD

Bank080000_TableTargetedPayloadRecord_0A3C03:
	dc.b	$02,$14,$E2,$02,$14,$ED,$02,$14,$F8,$FD

Bank080000_TableTargetedPayloadRecord_0A3C0D:
	dc.b	$02,$15,$03,$02,$15,$0E,$02,$15,$19,$FD

; 0x0A3C17-0x0A4AA2 continues the same compact local-offset/control family. The record
; starts are still table-proven from the front offset tree, but the bytes read more
; cleanly when grouped into three ROM-order source modules instead of hundreds of tiny
; inline incbins.
	include "src/bank080000_a3c17.asm"
	include "src/bank080000_a43d5.asm"
	include "src/bank080000_a47d9.asm"


; 0x0A4AA3-0x0A4AEB exposes a compact self-referencing group: eight 3-word records are
; followed immediately by an FF-terminated local-offset list that names those same starts.
Bank080000_TripleWordRecordBand_0A4AA3:
Bank080000_TableTargetedPayloadRecord_0A4AA3:
	dc.w	$FB04,$0400,$316E

Bank080000_TableTargetedPayloadRecord_0A4AA9:
	dc.w	$FB04,$0400,$3174

Bank080000_TableTargetedPayloadRecord_0A4AAF:
	dc.w	$FB04,$0400,$317A

Bank080000_TableTargetedPayloadRecord_0A4AB5:
	dc.w	$FB04,$0400,$3180

Bank080000_TableTargetedPayloadRecord_0A4ABB:
	dc.w	$FB04,$0400,$3186

Bank080000_TableTargetedPayloadRecord_0A4AC1:
	dc.w	$FB04,$0400,$318C

Bank080000_TableTargetedPayloadRecord_0A4AC7:
	dc.w	$FB04,$0400,$3192

Bank080000_TableTargetedPayloadRecord_0A4ACD:
	dc.w	$FB04,$0400,$3198

Bank080000_LocalOffsetListWithFFTerminator_0A4AD3:
Bank080000_TableTargetedPayloadRecord_0A4AD3:
	dc.b	$02,$31,$6E,$02,$31,$74,$02,$31,$7A,$02,$31,$80
	dc.b	$02,$31,$86,$02,$31,$8C,$02,$31,$92,$02,$31,$98,$FF

; 0x0A4AEC-0x0A4C76 continues the same compact local-offset/control family instead of a
; long tail of tiny opaque slices. The front begins with three standalone local offsets,
; then repeats the same FC/FB/FE-prefixed control shape plus short FF/FD-terminated local
; offset lists that reach back into earlier 0x0A0E85+, 0x0A157B+, 0x0A319E+, 0x0A323F+,
; and 0x0A3476+ families.
	include "src/bank080000_a4aec.asm"
