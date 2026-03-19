; ROM range: 0x09C008-0x09E027
; FF-terminated command-record window split into ROM-order slices at every proven
; local terminator. Labels stay structural until the tail-bank command decoder and
; owning subsystem are identified from control flow.

Bank080000_FFTerminatedCommandRecord_09C008:
	dc.b	$F4,$00,$C4,$FA,$C2,$F1,$09,$F5,$2B,$A2,$F5,$FE,$43,$A2,$F5,$FD
	dc.b	$43,$A2,$F5,$FE,$43,$FA,$F5,$FD,$A2,$43,$F5,$FE,$A2,$43,$F5,$FD
	dc.b	$A2,$43,$FA,$F5,$FE,$A2,$43,$F5,$FD,$A2,$43,$F5,$FE,$A2,$43,$FA
	dc.b	$F5,$FD,$A2,$F5,$FB,$43,$F5,$FE,$A2,$F5,$0C,$43,$FF

Bank080000_FFTerminatedCommandRecord_09C045:
	dc.b	$F4,$00,$C4,$FA,$C2,$F1,$0D,$F5,$2B,$9F,$42,$FA,$F5,$FB,$9F,$42
	dc.b	$FA,$F5,$FB,$9F,$42,$FA,$F5,$FB,$9F,$42,$FA,$C6,$F1,$0D,$F5,$F1
	dc.b	$A0,$43,$C4,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09C06A:
	dc.b	$F4,$00,$C5,$F1,$0C,$F5,$17,$A3,$48,$9C,$43,$C4,$A3,$48,$C5,$F5
	dc.b	$04,$A1,$46,$9A,$3F,$C4,$A1,$46,$C5,$F5,$04,$A0,$45,$99,$3E,$C4
	dc.b	$A0,$45,$C5,$F5,$04,$9F,$44,$98,$3D,$C4,$9F,$44,$FF

Bank080000_FFTerminatedCommandRecord_09C097:
	dc.b	$F4,$00,$C5,$F1,$0C,$F5,$17,$A3,$48,$9C,$43,$C4,$A3,$48,$C5,$A1
	dc.b	$46,$9A,$3F,$C4,$A1,$46,$C2,$A0,$45,$9E,$F5,$FE,$43,$9F,$44,$9E
	dc.b	$F5,$FD,$43,$9D,$42,$FA,$F5,$FE,$9C,$41,$F5,$FD,$99,$3E,$F5,$FE
	dc.b	$9A,$3F,$F5,$F8,$9B,$40,$F5,$FD,$9C,$41,$C5,$FA,$C4,$A3,$3E,$FF

; This bridge revisits the same compact local-control setup seen elsewhere in the middle command
; window, then drops into a dense repeated `0x4F/0x4E/0x4D/0x4C/0x4B/0x48` literal/high-byte pocket
; before a tiny pair of neighboring tails.
Bank080000_LocalControlSweepAndLiteralHighBytePocketCommandRecord_09C0D7:
Bank080000_FFTerminatedCommandRecord_09C0D7:
	dc.b	$F6,$00,$F7,$0E,$F0,$23,$D0,$F3,$BF,$D0,$08,$C0,$D0,$F3,$BF,$D0
	dc.b	$08,$C0,$D1,$45,$C0,$D0,$6A,$C0,$D1,$45,$C0,$D0,$97,$C0,$FD,$D7
	dc.b	$C0,$F4,$00,$C8,$F1,$0D,$F5,$17,$37,$C4,$FA,$C2,$F1,$10,$4F,$4E
	dc.b	$4D,$FA,$4C,$4B,$C8,$48,$FA,$CF,$FA,$C2,$48,$4A,$4B,$4C,$4D,$4E
	dc.b	$C0,$F5,$14,$4E,$4F,$4E,$4F,$F5,$FB,$4E,$4F,$4E,$4F,$F5,$FB,$4E
	dc.b	$4F,$4E,$4F,$F5,$FB,$4E,$4F,$4E,$4F,$F5,$FB,$4E,$4F,$4E,$F5,$FB
	dc.b	$4F,$4E,$4F,$4E,$F5,$FB,$4F,$4E,$4F,$F5,$FE,$4E,$4F,$F5,$FD,$4E
	dc.b	$4F,$4E,$F5,$FE,$4F,$FF

Bank080000_FFTerminatedCommandRecord_09C14D:
	dc.b	$F4,$00,$C9,$F1,$0D,$F5,$17,$37,$C6,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09C158:
	dc.b	$CA,$FA,$FF

; The next local-control pocket falls out of the same neighborhood into one short
; `0x00/0x05/0x0F` literal-control burst, then a follow-on family of closely related
; FF-terminated rows that keep the same compact `F4 00 C2/C4 F5 12` framing.
Bank080000_LocalControlSweepAndLiteralControlBurstCommandRecord_09C15B:
Bank080000_FFTerminatedCommandRecord_09C15B:
	dc.b	$F6,$00,$F7,$0E,$F0,$1F,$D0,$4D,$C1,$D2,$58,$C1,$D0,$F8,$C0,$D7
	dc.b	$58,$C1,$FD,$5B,$C1,$F4,$00,$C2,$F5,$12,$00,$FA,$00,$F5,$0A,$0F
	dc.b	$F5,$F6,$05,$FA,$F5,$0A,$0F,$0F,$F5,$F6,$00,$00,$F5,$0A,$0F,$0F
	dc.b	$0F,$0F,$F5,$EC,$05,$FA,$FF

Bank080000_LiteralControlPocketCommandFamily_09C192:
Bank080000_FFTerminatedCommandRecord_09C192:
	dc.b	$F4,$00,$C2,$F5,$12,$00,$FA,$00,$F5,$0A,$0F,$F5,$EC,$05,$FA,$F5
	dc.b	$14,$0F,$0F,$F5,$F6,$00,$00,$F5,$0A,$0F,$FA,$F5,$EC,$05,$FA,$05
	dc.b	$FA,$FF

Bank080000_FFTerminatedCommandRecord_09C1B4:
	dc.b	$F4,$00,$C2,$F5,$12,$00,$00,$F5,$14,$05,$05,$05,$FA,$F5,$F6,$05
	dc.b	$05,$05,$FA,$F5,$F6,$05,$05,$05,$F5,$F6,$05,$05,$05,$FF

Bank080000_FFTerminatedCommandRecord_09C1D2:
	dc.b	$F4,$00,$C4,$F5,$12,$00,$C2,$00,$F5,$0A,$0F,$0F,$FA,$0F,$0F,$F5
	dc.b	$F6,$00,$F5,$0A,$0F,$F5,$F6,$00,$F5,$0A,$0F,$F5,$EC,$05,$FA,$F5
	dc.b	$14,$0F,$0F,$C4,$F5,$F6,$00,$C2,$00,$F5,$0A,$0F,$0F,$FA,$0F,$0F
	dc.b	$F5,$F6,$00,$F5,$0A,$0F,$F5,$F6,$00,$F5,$F6,$05,$F5,$14,$0F,$0F
	dc.b	$F5,$EC,$05,$F5,$14,$0F,$FF

Bank080000_FFTerminatedCommandRecord_09C219:
	dc.b	$F4,$00,$C2,$F5,$12,$00,$F5,$0A,$0F,$0F,$FA,$0F,$0F,$F5,$EC,$05
	dc.b	$05,$F5,$0A,$00,$C4,$FA,$C2,$F5,$F6,$05,$C4,$FA,$C2,$05,$05,$FF

Bank080000_FFTerminatedCommandRecord_09C239:
	dc.b	$F4,$00,$C2,$F5,$12,$00,$00,$0D,$0D,$0D,$FA,$0E,$0E,$0D,$0D,$F5
	dc.b	$0A,$11,$C5,$FA,$C2,$F5,$F6,$0C,$FA,$FF

; This neighboring bridge stays in the same compact local-control neighborhood as 0x09C15B,
; but here the front alternates repeated D0/D1 same-window sweeps before handing off to a
; compact `F4 00` literal-row pocket around `0x30/0x2E/0x2B/0x31/0x34/0x35`.
Bank080000_AlternatingLocalControlAndLiteralRowCommandRecord_09C253:
Bank080000_FFTerminatedCommandRecord_09C253:
	dc.b	$F8,$D0,$70,$C1,$D0,$92,$C1,$D0,$70,$C1,$D0,$B4,$C1,$D0,$70,$C1
	dc.b	$D0,$92,$C1,$D0,$70,$C1,$D0,$B4,$C1,$D0,$D2,$C1,$D1,$19,$C2,$D0
	dc.b	$D2,$C1,$D0,$19,$C2,$D0,$39,$C2,$FD,$54,$C2,$88,$AA,$01,$4E,$BF
	dc.b	$CF,$BF,$D7,$C0,$5B,$C1,$53,$C2,$00,$00,$F4,$00,$CC,$F1,$0F,$F5
	dc.b	$0D,$30,$2E,$2B,$C6,$F1,$0D,$31,$CC,$F1,$0F,$30,$2E,$2B,$C6,$F1
	dc.b	$0D,$34,$CC,$F1,$0F,$30,$30,$30,$C6,$F1,$0D,$2E,$CC,$F1,$10,$35
	dc.b	$35,$35,$CD,$34,$CC,$31,$FF

; The next short run keeps the same compact `F4 00` framing while stepping through literal-row
; variations before narrowing into three tiny neighbors.
Bank080000_LiteralRowCommandFamily_09C2BA:
Bank080000_FFTerminatedCommandRecord_09C2BA:
	dc.b	$F4,$00,$CC,$F1,$0F,$F5,$0D,$30,$2E,$2B,$C6,$F1,$0D,$31,$CC,$F1
	dc.b	$0F,$30,$2E,$2B,$C6,$F1,$0D,$34,$C4,$F5,$0A,$30,$31,$C2,$F5,$F6
	dc.b	$2F,$30,$34,$2F,$C4,$FA,$32,$33,$34,$FF

Bank080000_FFTerminatedCommandRecord_09C2E4:
	dc.b	$F4,$00,$C4,$F1,$0D,$F5,$0D,$35,$29,$2D,$30,$33,$32,$33,$30,$FF

Bank080000_FFTerminatedCommandRecord_09C2F4:
	dc.b	$F4,$00,$CA,$F1,$10,$35,$C4,$F1,$0D,$F5,$0D,$33,$32,$31,$30,$2E
	dc.b	$2D,$2C,$2B,$FF

Bank080000_FFTerminatedCommandRecord_09C308:
	dc.b	$F4,$00,$C6,$F1,$0D,$F5,$0D,$29,$30,$31,$2E,$30,$2E,$2C,$2B,$2B
	dc.b	$29,$28,$25,$2B,$29,$28,$25,$FF

; This compact local-target setup mirrors the surrounding middle-window bridge shape, then tips
; into a short literal/high-byte row around `0x37/0x3D/0x48/0x44/0x46` before FF.
Bank080000_LocalTargetSetupAndLiteralHighByteRowCommandRecord_09C320:
Bank080000_FFTerminatedCommandRecord_09C320:
	dc.b	$F6,$00,$F7,$01,$F0,$07,$D1,$08,$C3,$D2,$8D,$C2,$D0,$BA,$C2,$D7
	dc.b	$E4,$C2,$D5,$E4,$C2,$D0,$F4,$C2,$FD,$20,$C3,$F4,$10,$C4,$F1,$0A
	dc.b	$F5,$12,$37,$3D,$48,$44,$37,$3D,$46,$43,$37,$3D,$48,$44,$37,$C7
	dc.b	$FA,$FF

Bank080000_FFTerminatedCommandRecord_09C352:
	dc.b	$F4,$10,$C6,$F1,$10,$F5,$0D,$54,$4F,$52,$E2,$F0,$58,$C6,$54,$4F
	dc.b	$52,$E2,$F0,$48,$FF

; These neighbors stay in the same `F4 10` neighborhood but collapse into short literal/high-byte
; pockets around `0x41/0x4D/0x4B/0x4A/0x48`, with the second record finishing on a tiny
; `0x52/0x51/0x4D/0x4B/0x4A/0x48` descent.
Bank080000_LiteralHighBytePocketCommandFamily_09C367:
Bank080000_FFTerminatedCommandRecord_09C367:
	dc.b	$F4,$10,$C4,$F1,$0F,$F5,$0F,$41,$C6,$FA,$C4,$4D,$C6,$FA,$C4,$4B
	dc.b	$FA,$FA,$4A,$C6,$FA,$C4,$48,$C2,$46,$45,$43,$41,$C4,$FA,$4D,$C6
	dc.b	$FA,$C4,$4B,$C8,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09C38D:
	dc.b	$F4,$10,$C4,$F1,$0F,$F5,$0F,$41,$C6,$FA,$C4,$4D,$C6,$FA,$C4,$4B
	dc.b	$FA,$FA,$4A,$C6,$FA,$C4,$48,$C2,$46,$45,$43,$41,$C4,$FA,$C7,$F1
	dc.b	$0D,$F5,$F9,$52,$51,$4D,$4B,$C6,$4A,$48,$FF

; This bridge returns to the denser local-control setup used elsewhere in the mid command body,
; then widens into a mixed literal descent around `0x54/0x4D/0x4F/0x50/.../0x3A` with one short
; `0x46` tail.
Bank080000_LocalControlSweepAndLiteralDescentCommandRecord_09C3B8:
Bank080000_FFTerminatedCommandRecord_09C3B8:
	dc.b	$F6,$00,$F7,$08,$F0,$0B,$F2,$00,$F4,$CA,$FA,$FA,$D0,$3B,$C3,$CA
	dc.b	$FA,$FA,$D0,$3B,$C3,$F0,$21,$D1,$52,$C3,$F7,$0C,$D0,$67,$C3,$CA
	dc.b	$FA,$D0,$67,$C3,$CA,$FA,$D0,$67,$C3,$CA,$FA,$D0,$8D,$C3,$FD,$B8
	dc.b	$C3,$F4,$08,$C4,$F1,$0A,$F5,$17,$54,$4D,$4F,$50,$FA,$4F,$4D,$49
	dc.b	$48,$43,$46,$41,$44,$3D,$3C,$3A,$CA,$FA,$CF,$FA,$C4,$46,$46,$F5
	dc.b	$F6,$46,$FF

Bank080000_FFTerminatedCommandRecord_09C40B:
	dc.b	$F4,$08,$C4,$F1,$0D,$F5,$17,$35,$F1,$10,$35,$41,$35,$3F,$3E,$3C
	dc.b	$C6,$F1,$0E,$35,$C4,$F1,$10,$35,$41,$35,$3F,$3E,$3D,$3C,$C7,$3B
	dc.b	$CF,$F1,$0E,$3C,$C7,$F1,$10,$3B,$C8,$37,$C4,$FA,$FF

; This neighboring setup pocket walks through several same-window local targets before dropping
; into a denser mixed high-byte family around `0x89/0x8B/0x90/0x91` and `0xA0/0xA3/0xA4/0xA6`.
Bank080000_LocalTargetSetupAndHighByteMixCommandRecord_09C438:
Bank080000_FFTerminatedCommandRecord_09C438:
	dc.b	$F6,$00,$F7,$08,$F0,$00,$D1,$E9,$C3,$CA,$DF,$FA,$FE,$CA,$DF,$FA
	dc.b	$FE,$CA,$DF,$FA,$FE,$FD,$38,$C4,$F4,$14,$C4,$F1,$0A,$F5,$19,$89
	dc.b	$35,$A4,$48,$90,$3C,$A4,$48,$91,$3D,$A4,$48,$8E,$3A,$A4,$48,$90
	dc.b	$3C,$A0,$46,$8E,$3A,$A0,$46,$8C,$38,$A0,$46,$8B,$37,$A0,$46,$37
	dc.b	$A6,$49,$35,$A6,$49,$34,$A3,$46,$31,$A3,$46,$FF

Bank080000_FFTerminatedCommandRecord_09C484:
	dc.b	$F4,$14,$C4,$F1,$0D,$F5,$18,$8B,$37,$A6,$49,$89,$35,$A6,$49,$88
	dc.b	$34,$A3,$46,$A3,$46,$A3,$46,$FF

Bank080000_FFTerminatedCommandRecord_09C49C:
	dc.b	$F4,$14,$C4,$F1,$0D,$F5,$18,$8B,$37,$A3,$A6,$49,$89,$35,$A3,$A6
	dc.b	$49,$88,$34,$F5,$F8,$97,$3D,$98,$3E,$99,$3F,$FF

; This longer continuation stays in the same compact command neighborhood but expands into one
; broader mixed literal/high-byte ladder around `0xA9/0x4C`, `0x9C/0x3D`, `0x99/0x3F`, and the
; recurring `0x43/0x41/0x40/0x97` literal pocket.
Bank080000_LiteralAndHighByteLadderCommandRecord_09C4B8:
Bank080000_FFTerminatedCommandRecord_09C4B8:
	dc.b	$F4,$0C,$CC,$FA,$F1,$0F,$F5,$1A,$A9,$4C,$47,$CD,$F1,$10,$4F,$CC
	dc.b	$A9,$4C,$C4,$F1,$0A,$47,$E2,$38,$FA,$CC,$F1,$0F,$9C,$3D,$E2,$50
	dc.b	$FA,$CC,$9C,$3D,$C6,$FA,$CC,$43,$41,$40,$97,$40,$43,$44,$CD,$F1
	dc.b	$10,$4C,$CC,$4A,$43,$41,$C4,$F1,$0A,$40,$FA,$CC,$F1,$0F,$99,$3F
	dc.b	$E2,$50,$FA,$CC,$99,$3F,$CD,$FA,$CC,$99,$3F,$F1,$10,$F5,$05,$54
	dc.b	$4C,$54,$CD,$FA,$CC,$F5,$FB,$A5,$47,$CD,$4F,$CC,$A9,$4C,$C4,$F1
	dc.b	$0A,$47,$E2,$38,$FA,$CC,$F1,$0F,$9C,$3D,$E2,$50,$FA,$CC,$9C,$3D
	dc.b	$CD,$FA,$CC,$9C,$3D,$43,$41,$40,$97,$40,$43,$44,$97,$40,$43,$44
	dc.b	$FA,$41,$C4,$F1,$0A,$40,$FA,$CC,$F1,$0F,$99,$3F,$F5,$F6,$97,$3C
	dc.b	$CB,$FA,$C4,$F1,$0D,$F5,$F6,$98,$3D,$C2,$8F,$34,$90,$35,$94,$37
	dc.b	$8F,$35,$92,$38,$FA,$C4,$99,$3E,$C6,$9B,$40,$FF

; This short pair keeps the same `F4 0C` framing but narrows into one repeated literal ladder
; around `0x41/0x46/0x48/0x4D`, then a second pass that tips into a descending `0x9A/0x99/0x98/...`
; high-byte tail.
Bank080000_LiteralLadderAndHighByteTailCommandFamily_09C564:
Bank080000_FFTerminatedCommandRecord_09C564:
	dc.b	$F4,$0C,$C4,$F1,$0D,$F5,$33,$41,$46,$48,$F5,$FB,$4D,$41,$46,$48
	dc.b	$F5,$EC,$4D,$41,$46,$48,$F5,$EC,$4D,$41,$46,$48,$4D,$FF

Bank080000_FFTerminatedCommandRecord_09C582:
	dc.b	$F4,$0C,$C4,$F1,$0D,$F5,$2E,$41,$46,$F5,$FB,$48,$4D,$F5,$FB,$41
	dc.b	$46,$F5,$FB,$48,$4D,$F5,$FB,$9A,$3F,$99,$3E,$F5,$FB,$98,$3D,$97
	dc.b	$3C,$95,$3A,$F5,$FB,$94,$39,$93,$38,$F5,$FB,$92,$37,$FF

; This last bridge in the pocket returns to a compact local-control setup, then repeats the same
; `0x60/0x10/0x05` literal-control burst across several short rows before the final FF.
Bank080000_LocalControlBurstCommandRecord_09C5B0:
Bank080000_FFTerminatedCommandRecord_09C5B0:
	dc.b	$F6,$00,$F7,$06,$F0,$23,$D0,$50,$C4,$D0,$84,$C4,$D0,$50,$C4,$D0
	dc.b	$9C,$C4,$D0,$B8,$C4,$CA,$FA,$FA,$D0,$64,$C5,$CA,$FA,$FA,$D0,$64
	dc.b	$C5,$CA,$FA,$FA,$D0,$64,$C5,$CA,$FA,$FA,$D0,$82,$C5,$FD,$B0,$C5
	dc.b	$F4,$04,$C4,$F5,$12,$60,$F5,$0A,$10,$F5,$EC,$05,$F5,$0A,$60,$F5
	dc.b	$0A,$10,$F5,$EC,$05,$F5,$0A,$60,$F5,$0A,$10,$F5,$EC,$05,$F5,$0A
	dc.b	$60,$F5,$0A,$10,$F5,$EC,$05,$F5,$0A,$60,$F5,$0A,$10,$F5,$EC,$05
	dc.b	$F5,$0A,$60,$F5,$0A,$10,$F5,$EC,$05,$F5,$0A,$60,$F5,$0A,$10,$C2
	dc.b	$F5,$EC,$05,$05,$C4,$F5,$0A,$60,$F5,$0A,$10,$F5,$EC,$05,$FF

; This short follow-on pocket keeps one compact `F4 04` header across four neighboring records,
; varying only the small `0x00/0x05/0x0D/0x0E/0x11/0x60/0x65` literal-control rows and the single
; `E2 A8` local-offset hop inside the last record.
Bank080000_LiteralControlPocketCommandFamily_09C62F:
Bank080000_FFTerminatedCommandRecord_09C62F:
	dc.b	$F4,$04,$CC,$F5,$12,$00,$CD,$FA,$C6,$05,$CC,$00,$FA,$00,$C6,$11
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09C640:
	dc.b	$F4,$04,$CC,$F5,$12,$00,$CD,$FA,$C6,$05,$CC,$60,$0E,$0E,$60,$0D
	dc.b	$65,$0D,$0C,$0C,$FF

Bank080000_FFTerminatedCommandRecord_09C655:
	dc.b	$F4,$04,$C2,$F5,$12,$00,$05,$C4,$05,$C2,$0D,$0D,$0C,$0C,$11,$FA
	dc.b	$05,$FA,$05,$C5,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09C66B:
	dc.b	$F4,$04,$C4,$F5,$12,$60,$F5,$F6,$05,$E2,$A8,$FA,$C6,$FA,$C2,$05
	dc.b	$05,$05,$FA,$05,$05,$05,$FA,$05,$FA,$05,$FA,$FF

; This broader bridge opens with another compact local-control setup, then cycles through a long
; repeated literal-row family rooted on `0x2B/0x29/0x27` before a short `0x32/0x30/0x2E` tail.
Bank080000_LocalControlAndLiteralRowCycleCommandRecord_09C687:
Bank080000_FFTerminatedCommandRecord_09C687:
	dc.b	$F8,$D3,$E0,$C5,$D2,$2F,$C6,$D0,$40,$C6,$D2,$2F,$C6,$D0,$55,$C6
	dc.b	$D6,$E0,$C5,$D0,$6B,$C6,$FD,$88,$C6,$88,$66,$02,$20,$C3,$B8,$C3
	dc.b	$38,$C4,$B0,$C5,$87,$C6,$00,$00,$F4,$00,$C2,$F1,$0C,$F5,$0D,$2B
	dc.b	$2B,$2B,$FA,$C4,$F1,$0D,$37,$C2,$F1,$0C,$2B,$2B,$FA,$2B,$2B,$FA
	dc.b	$C4,$F1,$0D,$37,$C2,$F1,$0C,$2B,$FA,$29,$29,$29,$FA,$C4,$F1,$0D
	dc.b	$35,$C2,$F1,$0C,$29,$29,$C6,$FA,$C2,$30,$32,$30,$32,$27,$27,$27
	dc.b	$FA,$C4,$F1,$0D,$33,$C2,$F1,$0C,$27,$27,$FA,$27,$27,$FA,$C4,$F1
	dc.b	$0D,$33,$C2,$F1,$0C,$27,$FA,$29,$29,$29,$FA,$C4,$F1,$0D,$35,$C2
	dc.b	$F1,$0C,$29,$29,$C4,$FA,$F1,$0D,$F5,$0A,$32,$32,$32,$C2,$F1,$0C
	dc.b	$F5,$F6,$2B,$2B,$2B,$FA,$C4,$F1,$0D,$37,$C2,$F1,$0C,$2B,$2B,$FA
	dc.b	$2B,$2B,$FA,$C4,$F1,$0D,$37,$C2,$F1,$0C,$2B,$FA,$29,$29,$29,$FA
	dc.b	$C4,$F1,$0D,$35,$C2,$F1,$0C,$29,$29,$C6,$FA,$C2,$30,$32,$30,$32
	dc.b	$27,$27,$27,$FA,$C4,$F1,$0D,$33,$C2,$F1,$0C,$27,$27,$FA,$27,$27
	dc.b	$FA,$C4,$F1,$0D,$33,$C2,$F1,$0C,$27,$FA,$29,$29,$29,$FA,$C4,$F1
	dc.b	$0D,$35,$C2,$F1,$0C,$29,$29,$C6,$F1,$0D,$F5,$0A,$27,$C4,$29,$FC
	dc.b	$F5,$F6,$2E,$FF

; These neighbors stay in the same compact `F4 00` literal-row neighborhood, first revisiting the
; broader `0x2E/0x32/0x2B/0x29` cycle and then collapsing it into a shorter row-pattern variant.
Bank080000_LiteralRowCycleCommandFamily_09C77B:
Bank080000_FFTerminatedCommandRecord_09C77B:
	dc.b	$F4,$00,$C6,$F1,$0D,$F5,$0D,$2E,$C4,$2E,$C2,$F1,$0C,$32,$32,$C4
	dc.b	$F1,$0D,$2B,$2D,$2E,$C7,$27,$C4,$27,$C6,$FA,$C4,$29,$2B,$C7,$2C
	dc.b	$C4,$2C,$C2,$F1,$0C,$30,$30,$C4,$F1,$0D,$29,$2B,$2C,$C7,$32,$C4
	dc.b	$32,$C6,$FA,$C4,$30,$2E,$2D,$C2,$F1,$0C,$2B,$2B,$2B,$FA,$C4,$F1
	dc.b	$0D,$37,$C2,$F1,$0C,$2B,$2B,$FA,$2B,$2B,$FA,$C4,$F1,$0D,$37,$C2
	dc.b	$F1,$0C,$2B,$FA,$29,$29,$29,$FA,$C4,$F1,$0D,$35,$C2,$F1,$0C,$29
	dc.b	$29,$C6,$FA,$C2,$30,$32,$30,$32,$27,$27,$27,$FA,$C4,$F1,$0D,$33
	dc.b	$C2,$F1,$0C,$27,$27,$FA,$27,$27,$FA,$C4,$F1,$0D,$33,$C2,$F1,$0C
	dc.b	$27,$FA,$32,$32,$FA,$3E,$3E,$FA,$3C,$3C,$FA,$30,$30,$FA,$C4,$F1
	dc.b	$0D,$2E,$2D,$FF

Bank080000_FFTerminatedCommandRecord_09C80F:
	dc.b	$F4,$00,$C5,$F1,$0C,$F5,$17,$2B,$C2,$2B,$C4,$F1,$0D,$37,$2B,$C2
	dc.b	$F1,$0C,$2B,$2B,$C4,$FA,$F1,$0D,$37,$2B,$C5,$F1,$0C,$29,$C2,$29
	dc.b	$C4,$F1,$0D,$35,$29,$C2,$F1,$0C,$29,$C5,$FA,$C4,$F1,$0D,$2E,$C7
	dc.b	$30,$C4,$2E,$C7,$30,$C6,$30,$C2,$F1,$0C,$F5,$F6,$32,$32,$FA,$3E
	dc.b	$3E,$FA,$3C,$3C,$FA,$30,$30,$FA,$C4,$F1,$0D,$2E,$2D,$FF

; This neighboring continuation returns to the same repeating literal-row cycle, but its back half
; replaces the earlier `0x27` pocket with `0x29/0x2E/0x30/0x3C/0x3A` rows before FF.
Bank080000_LiteralRowCycleAndTailVariantCommandRecord_09C85D:
Bank080000_FFTerminatedCommandRecord_09C85D:
	dc.b	$F4,$00,$C2,$F1,$0C,$F5,$0D,$2B,$2B,$2B,$FA,$C4,$F1,$0D,$37,$C2
	dc.b	$F1,$0C,$2B,$2B,$FA,$2B,$2B,$FA,$C4,$F1,$0D,$37,$C2,$F1,$0C,$2B
	dc.b	$FA,$29,$29,$29,$FA,$C4,$F1,$0D,$35,$C2,$F1,$0C,$29,$29,$C6,$FA
	dc.b	$C2,$30,$32,$30,$32,$27,$27,$27,$FA,$C4,$F1,$0D,$33,$C2,$F1,$0C
	dc.b	$27,$27,$FA,$27,$27,$FA,$C4,$F1,$0D,$33,$C2,$F1,$0C,$27,$FA,$29
	dc.b	$29,$29,$FA,$C4,$F1,$0D,$35,$C2,$F1,$0C,$29,$29,$C4,$FA,$F1,$0D
	dc.b	$F5,$0A,$32,$32,$32,$C2,$F1,$0C,$F5,$F6,$2B,$2B,$2B,$FA,$C4,$F1
	dc.b	$0D,$37,$C2,$F1,$0C,$2B,$2B,$FA,$2B,$2B,$FA,$C4,$F1,$0D,$37,$C2
	dc.b	$F1,$0C,$2B,$FA,$29,$29,$29,$FA,$C4,$F1,$0D,$35,$C2,$F1,$0C,$29
	dc.b	$29,$C6,$FA,$C2,$30,$32,$30,$32,$29,$29,$29,$FA,$C4,$F1,$0D,$35
	dc.b	$C2,$F1,$0C,$29,$29,$FA,$2E,$2E,$FA,$C4,$F1,$0D,$35,$C2,$F1,$0C
	dc.b	$2E,$FA,$30,$30,$FA,$3C,$3C,$FA,$3A,$3A,$FA,$2E,$2E,$FA,$C4,$F1
	dc.b	$0D,$2C,$2B,$FF

; This bridge shifts back to a compact local-target setup, then widens into a denser high-byte pair
; ladder rooted on `0x9E/0xA1/0x9F/0xA4/0xA5` with short `F5 EC` and `F5 0A` pivots.
Bank080000_LocalTargetSetupAndHighBytePairLadderCommandRecord_09C921:
Bank080000_FFTerminatedCommandRecord_09C921:
	dc.b	$F7,$01,$F0,$09,$D0,$AF,$C6,$D0,$7B,$C7,$D0,$5D,$C8,$D1,$0F,$C8
	dc.b	$FD,$21,$C9,$F4,$00,$CA,$F1,$10,$F5,$2B,$9E,$43,$A1,$45,$9F,$46
	dc.b	$CF,$A1,$48,$C2,$F5,$E2,$9E,$45,$FA,$9E,$45,$FA,$9E,$45,$FA,$CA
	dc.b	$F5,$1E,$9E,$43,$A1,$45,$9F,$46,$C8,$A1,$48,$C6,$F5,$EC,$9F,$43
	dc.b	$C4,$F5,$0A,$A1,$45,$CA,$A1,$46,$F5,$0A,$9F,$46,$A4,$48,$E2,$D8
	dc.b	$A5,$4A,$C7,$9E,$43,$CF,$A3,$4A,$C7,$A1,$45,$CF,$A5,$4A,$C7,$9F
	dc.b	$43,$CF,$A3,$4A,$C8,$F5,$F6,$A5,$4A,$9E,$45,$FF

; These next two records stay in the same compact `F4 00` high-byte neighborhood as 0x09C921,
; first collapsing into a shorter `0x9E/0xA1/0x9F` ladder with one `0xA8/0x40` cap, then widening
; into a denser repeated `0xA3/0xA1/0xA5` ladder with short `F5 0A`, `F5 EC`, and `F5 F6` pivots.
Bank080000_HighBytePairLadderCommandFamily_09C98D:
Bank080000_FFTerminatedCommandRecord_09C98D:
	dc.b	$F4,$00,$CA,$F1,$10,$F5,$2B,$9E,$43,$A1,$45,$9F,$46,$CF,$A1,$48
	dc.b	$C2,$F5,$E2,$9E,$45,$FA,$9E,$45,$FA,$9E,$45,$FA,$CA,$F5,$1E,$9E
	dc.b	$43,$A1,$45,$C8,$A1,$44,$A1,$46,$CA,$F1,$08,$A8,$40,$FF

Bank080000_FFTerminatedCommandRecord_09C9BB:
	dc.b	$F4,$00,$CF,$F1,$10,$F5,$21,$A3,$4A,$C2,$A3,$4A,$FA,$F5,$0A,$A3
	dc.b	$4A,$FA,$A3,$4A,$FA,$C7,$A1,$48,$C4,$A1,$48,$C6,$A1,$48,$C4,$F5
	dc.b	$EC,$A1,$46,$C7,$F5,$0A,$A3,$48,$C4,$A1,$46,$C7,$F5,$0A,$A3,$48
	dc.b	$C6,$A3,$4B,$CA,$F5,$F6,$A5,$4A,$CF,$A3,$4A,$C2,$F5,$0A,$A3,$4A
	dc.b	$FA,$A3,$4A,$FA,$A3,$4A,$FA,$C7,$A1,$48,$C4,$A1,$48,$C6,$A1,$48
	dc.b	$C4,$F5,$F6,$A1,$46,$C7,$F5,$F6,$A3,$48,$C4,$F5,$0A,$A1,$46,$C7
	dc.b	$F5,$0A,$A3,$48,$C6,$A3,$4B,$CA,$F5,$F6,$A5,$4A,$FF

; This broader bridge returns to a compact local-control sweep, then spends most of its body on a
; repeated literal/high-byte descent around `0x52/0x51/0x4F`, `0x4D/0x4E`, and later `0x54/0x56/0x57/0x59`
; bands before the shorter follow-on records at 0x09CB09 and 0x09CB42 tighten the same neighborhood.
Bank080000_LocalControlSweepAndLiteralHighByteDescentCommandRecord_09CA28:
Bank080000_FFTerminatedCommandRecord_09CA28:
	dc.b	$F7,$18,$F0,$0A,$D0,$34,$C9,$D0,$8D,$C9,$D0,$BB,$C9,$FD,$28,$CA
	dc.b	$F4,$06,$C2,$F1,$10,$F5,$17,$52,$51,$4F,$FA,$52,$51,$C6,$4F,$C4
	dc.b	$52,$52,$54,$C2,$52,$51,$4F,$FA,$52,$51,$C6,$4F,$C0,$4D,$4E,$C2
	dc.b	$4F,$C0,$4D,$4E,$C2,$4F,$C4,$4D,$C2,$4B,$4D,$4E,$4F,$50,$51,$52
	dc.b	$54,$C0,$55,$E2,$2A,$56,$C0,$55,$E2,$2A,$56,$CF,$54,$C6,$52,$C4
	dc.b	$51,$C2,$52,$51,$4F,$FA,$52,$51,$C6,$4F,$C4,$52,$52,$54,$C2,$52
	dc.b	$51,$4F,$FA,$52,$51,$C6,$4F,$C0,$4D,$4E,$C2,$4F,$C0,$4D,$4E,$C2
	dc.b	$4F,$C4,$4D,$C2,$4B,$4D,$4E,$4F,$50,$51,$52,$54,$C0,$55,$E2,$2A
	dc.b	$56,$C0,$55,$E2,$2A,$56,$C8,$54,$C6,$52,$C4,$54,$CF,$56,$C4,$52
	dc.b	$51,$4D,$C7,$4F,$C4,$4F,$4B,$4F,$FA,$56,$C9,$54,$C0,$57,$58,$C5
	dc.b	$59,$CF,$56,$C4,$56,$54,$52,$51,$C2,$52,$C4,$52,$C2,$4F,$C4,$4F
	dc.b	$C2,$52,$C5,$52,$C4,$51,$4F,$4D,$4A,$C2,$4D,$4A,$4D,$C5,$4A,$C4
	dc.b	$4D,$C2,$51,$4D,$51,$C5,$4D,$C2,$52,$C4,$52,$C2,$4F,$C4,$4F,$C2
	dc.b	$52,$C5,$52,$C4,$52,$51,$4F,$C0,$51,$53,$55,$E2,$4E,$56,$C8,$51
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09CB09:
	dc.b	$F4,$06,$CF,$F1,$10,$F5,$17,$4F,$C4,$4F,$51,$52,$C7,$56,$C2,$54
	dc.b	$52,$C6,$51,$C4,$56,$C7,$54,$C4,$56,$C7,$54,$C6,$51,$CA,$56,$CF
	dc.b	$4F,$C4,$4F,$51,$52,$C7,$56,$C2,$54,$52,$C6,$51,$C4,$56,$C7,$54
	dc.b	$C4,$52,$C7,$54,$C6,$57,$CA,$56,$FF

Bank080000_FFTerminatedCommandRecord_09CB42:
	dc.b	$F4,$06,$C2,$F1,$0C,$F5,$17,$52,$51,$4F,$52,$51,$4F,$52,$51,$4F
	dc.b	$52,$51,$4F,$C4,$F1,$0D,$54,$56,$C2,$F1,$0C,$52,$51,$4F,$52,$51
	dc.b	$4F,$52,$51,$C4,$F1,$10,$4D,$C7,$FA,$C4,$57,$57,$56,$54,$C2,$52
	dc.b	$51,$4F,$C4,$4D,$C2,$4B,$C4,$4A,$C2,$4A,$4D,$4A,$4D,$49,$4C,$48
	dc.b	$4B,$4F,$C5,$FA,$C0,$4F,$51,$C2,$52,$C4,$51,$C2,$F1,$0C,$52,$51
	dc.b	$4F,$52,$51,$4F,$52,$51,$4F,$52,$51,$4F,$C4,$F1,$0D,$54,$C2,$F1
	dc.b	$10,$56,$FA,$F1,$0C,$52,$51,$4F,$52,$51,$4F,$52,$51,$F1,$10,$4D
	dc.b	$E2,$54,$FA,$C4,$57,$57,$56,$54,$C2,$52,$50,$4F,$4D,$C4,$F1,$09
	dc.b	$4D,$F1,$10,$4E,$CF,$4F,$C4,$4D,$4D,$4E,$FF

; This short bridge keeps the same compact local-control front as the neighboring 0x09CA28 family,
; but the payload narrows into a tiny repeated `0x00/0x05` literal-control row before FF.
Bank080000_LocalControlSweepAndLiteralControlCommandRecord_09CBCD:
Bank080000_FFTerminatedCommandRecord_09CBCD:
	dc.b	$F7,$06,$F0,$0A,$F2,$00,$E8,$D0,$38,$CA,$D0,$42,$CB,$D0,$09,$CB
	dc.b	$FD,$CD,$CB,$F4,$00,$C4,$F5,$12,$00,$05,$00,$05,$00,$05,$00,$05
	dc.b	$FF

; The next short pair keeps the same compact `F4 00` framing while varying only the small
; `0x00/0x05/0x0D/0x0E` literal-control rows.
Bank080000_CompactLiteralControlCommandFamily_09CBEE:
Bank080000_FFTerminatedCommandRecord_09CBEE:
	dc.b	$F4,$00,$C4,$F5,$12,$00,$05,$00,$C2,$05,$0D,$0C,$0C,$C4,$05,$05
	dc.b	$05,$FF

Bank080000_FFTerminatedCommandRecord_09CC00:
	dc.b	$F4,$00,$C2,$F5,$12,$00,$FA,$05,$FA,$00,$FA,$05,$FA,$0E,$0E,$0D
	dc.b	$0D,$0C,$0C,$0C,$0C,$FF

; This broader bridge opens with repeated D2/D6 same-window steps, then falls into a short
; literal-row family around `0x2B/0x29/0x2E` before FF.
Bank080000_LocalControlAndLiteralRowCommandRecord_09CC16:
Bank080000_FFTerminatedCommandRecord_09CC16:
	dc.b	$F8,$D2,$E0,$CB,$D0,$EE,$CB,$D6,$E0,$CB,$D0,$00,$CC,$D2,$E0,$CB
	dc.b	$D0,$EE,$CB,$D2,$E0,$CB,$D0,$EE,$CB,$D2,$E0,$CB,$D0,$00,$CC,$D2
	dc.b	$E0,$CB,$D0,$EE,$CB,$D2,$E0,$CB,$D0,$EE,$CB,$FD,$17,$CC,$88,$CC
	dc.b	$01,$21,$C9,$28,$CA,$CD,$CB,$16,$CC,$00,$00,$F4,$00,$C4,$F1,$0D
	dc.b	$F5,$0A,$2B,$2B,$29,$29,$C8,$FA,$C4,$2B,$2B,$2E,$2E,$C8,$FA,$FF

; This neighboring setup record reuses one short local-target prelude, then widens into a
; mixed literal/high-byte pocket around `0x40/0x47/0x45/0x41/0x4A/0x43` with several
; `F5 0A/F5 14/F5 F6/F5 F1` pivots.
Bank080000_LocalTargetSetupAndLiteralHighBytePocketCommandRecord_09CC66:
Bank080000_FFTerminatedCommandRecord_09CC66:
	dc.b	$F6,$00,$F7,$01,$F0,$07,$D7,$51,$CC,$FD,$66,$CC,$F4,$0A,$C4,$FA
	dc.b	$C2,$F1,$09,$F5,$1A,$40,$FA,$F5,$EC,$47,$F5,$0A,$45,$C4,$FA,$C2
	dc.b	$F5,$0A,$41,$41,$C5,$FA,$C2,$4A,$C4,$FA,$C2,$40,$CE,$FA,$C2,$41
	dc.b	$F5,$EC,$40,$FA,$F5,$14,$43,$C7,$FA,$C2,$FA,$C0,$F5,$0F,$45,$FA
	dc.b	$F5,$F6,$47,$F5,$F1,$45,$F5,$F6,$47,$F5,$F6,$45,$CE,$FA,$C0,$F5
	dc.b	$2D,$43,$FA,$F5,$F6,$45,$F5,$F1,$43,$F5,$F6,$45,$F5,$F6,$43,$C6
	dc.b	$FA,$C0,$F5,$14,$41,$F5,$0A,$40,$F5,$0F,$41,$FA,$F5,$F1,$45,$C3
	dc.b	$FA,$C0,$41,$40,$C2,$FA,$C0,$40,$F5,$F6,$45,$F5,$F6,$47,$FA,$F5
	dc.b	$14,$41,$E2,$5A,$FA,$FF

; This short bridge returns to a compact local-control sweep, then narrows into a literal-
; control burst around `0x6D/0x6C`, `0x0A`, `0x12`, `0x07`, and `0x08`.
Bank080000_LocalControlSweepAndLiteralControlBurstCommandRecord_09CCEC:
Bank080000_FFTerminatedCommandRecord_09CCEC:
	dc.b	$F6,$00,$F7,$02,$F2,$F0,$F4,$F0,$26,$CA,$DB,$FA,$FE,$D2,$72,$CC
	dc.b	$FD,$EC,$CC,$F4,$08,$C4,$F5,$08,$6D,$F5,$04,$0A,$F5,$0A,$6C,$F5
	dc.b	$F6,$09,$F5,$14,$6C,$F5,$EC,$0A,$C2,$F5,$1E,$6C,$F5,$EC,$12,$F5
	dc.b	$0A,$07,$C4,$F5,$E2,$6D,$F5,$1E,$07,$C2,$F5,$F6,$6C,$12,$F5,$0A
	dc.b	$08,$C4,$6C,$F5,$F6,$12,$F5,$14,$0C,$FF

; Two tiny neighboring terminators sit between the broader `0x09CCEC` burst and the next
; local-seeded literal-row pocket.
Bank080000_FFTerminatedCommandRecord_09CD36:
	dc.b	$F8,$D7,$FF

Bank080000_FFTerminatedCommandRecord_09CD39:
	dc.b	$CC,$D7,$FF

; This local-seeded bridge uses one short `CC/FD/88` prelude, then tips into a compact
; literal row around `0x30/0x36/0x3C`.
Bank080000_LocalSeededLiteralRowCommandRecord_09CD3C:
Bank080000_FFTerminatedCommandRecord_09CD3C:
	dc.b	$CC,$FD,$37,$CD,$88,$99,$01,$66,$CC,$EC,$CC,$36,$CD,$00,$00,$F4
	dc.b	$14,$C4,$F1,$08,$F5,$10,$30,$3C,$3C,$36,$3C,$3C,$FF

; The next short pair keeps one compact `F4 14` header while stepping through literal ladders
; around `0x49/0x43/0x44/0x46` and `0x48/0x43/0x45/0x4B`.
Bank080000_CompactLiteralLadderCommandFamily_09CD59:
Bank080000_FFTerminatedCommandRecord_09CD59:
	dc.b	$F4,$14,$C4,$F5,$10,$49,$43,$44,$46,$45,$44,$46,$45,$44,$46,$45
	dc.b	$44,$FF

Bank080000_FFTerminatedCommandRecord_09CD6B:
	dc.b	$F4,$14,$C4,$F5,$10,$48,$43,$45,$46,$45,$43,$48,$43,$45,$46,$45
	dc.b	$43,$4B,$43,$44,$46,$44,$43,$F5,$F6,$4A,$CF,$FA,$FF

; Two tiny tails close the local literal-ladder pocket before the next broader sweep.
Bank080000_FFTerminatedCommandRecord_09CD88:
	dc.b	$F4,$14,$C7,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09CD8D:
	dc.b	$C9,$FA,$FF

; This neighboring setup walk stays inside the same window with several D0/D1/D5/D7 targets,
; then collapses into one tiny literal cap at `0x43`.
Bank080000_LocalControlSweepAndLiteralCapCommandRecord_09CD90:
Bank080000_FFTerminatedCommandRecord_09CD90:
	dc.b	$F7,$30,$F0,$1C,$D0,$88,$CD,$D7,$4B,$CD,$D5,$4B,$CD,$D7,$8D,$CD
	dc.b	$D1,$8D,$CD,$D1,$59,$CD,$D0,$6B,$CD,$FD,$97,$CD,$F4,$14,$C6,$F1
	dc.b	$0D,$F5,$06,$43,$C4,$F1,$10,$43,$FF

; This follow-on family keeps the same compact `F4 14` neighborhood but widens into literal /
; high-byte ladders around `0x48/0x4A/0x4D/0x4F` plus one adjacent `0x41/0x3C` to `0x48`
; mixed climb.
Bank080000_LiteralAndHighByteLadderCommandFamily_09CDB9:
Bank080000_FFTerminatedCommandRecord_09CDB9:
	dc.b	$F4,$14,$C7,$F1,$0D,$F5,$06,$48,$C6,$48,$C4,$F1,$10,$48,$C7,$4A
	dc.b	$C6,$48,$C4,$4A,$C7,$4D,$C6,$4C,$C4,$4A,$C7,$4C,$48,$E2,$D8,$46
	dc.b	$C6,$45,$C4,$44,$CA,$43,$C4,$FA,$C7,$43,$F1,$0D,$4A,$C6,$4A,$C4
	dc.b	$F1,$10,$4A,$C7,$4D,$C6,$4C,$C4,$4A,$C7,$4F,$4C,$4A,$48,$E2,$D8
	dc.b	$46,$C6,$43,$C4,$4A,$C9,$48,$C4,$46,$45,$44,$43,$42,$41,$FF

Bank080000_FFTerminatedCommandRecord_09CE08:
	dc.b	$F4,$14,$C9,$F5,$06,$41,$C7,$3C,$41,$3F,$3E,$3D,$3C,$C4,$36,$37
	dc.b	$38,$39,$3A,$3B,$C9,$3C,$C4,$42,$43,$44,$45,$46,$47,$C9,$48,$FF

Bank080000_FFTerminatedCommandRecord_09CE28:
	dc.b	$F4,$14,$C9,$F5,$06,$3D,$C7,$38,$41,$3F,$3D,$3C,$3A,$C9,$A1,$3C
	dc.b	$A0,$3C,$9F,$3A,$C4,$F1,$0D,$9B,$3E,$C6,$FA,$43,$C4,$F1,$10,$43
	dc.b	$FF

; This compact local-control family drops into short low-byte ladders around `0x24/0x30/0x2E`
; and neighboring `0x22` / `0x27` rows under the same `F4 1A` framing.
Bank080000_LocalControlAndLowByteLadderCommandFamily_09CE49:
Bank080000_FFTerminatedCommandRecord_09CE49:
	dc.b	$F7,$0E,$F0,$29,$D0,$AC,$CD,$D0,$B9,$CD,$D0,$08,$CE,$D0,$28,$CE
	dc.b	$FD,$50,$CE,$F4,$1A,$C7,$F1,$10,$F5,$06,$24,$30,$2E,$C4,$2B,$2C
	dc.b	$2D,$FF

Bank080000_FFTerminatedCommandRecord_09CE6B:
	dc.b	$F4,$1A,$C7,$F1,$10,$F5,$06,$24,$C4,$2E,$2D,$2C,$C7,$2B,$C4,$F1
	dc.b	$0D,$2A,$2A,$2A,$FF

Bank080000_FFTerminatedCommandRecord_09CE80:
	dc.b	$F4,$1A,$C7,$F1,$10,$F5,$06,$24,$C4,$2E,$2D,$2C,$3A,$39,$38,$F1
	dc.b	$0D,$22,$22,$22,$FF

Bank080000_FFTerminatedCommandRecord_09CE95:
	dc.b	$F4,$1A,$C7,$F1,$10,$F5,$06,$26,$32,$30,$C4,$2D,$2E,$2F,$FF

Bank080000_FFTerminatedCommandRecord_09CEA4:
	dc.b	$F4,$1A,$C7,$F1,$0D,$F5,$06,$24,$22,$27,$26,$FF

; The next continuation stays in the same compact `F4 1A` neighborhood, first stepping through
; `0x29/0x33/0x32/0x31`, then a neighboring `0x25/0x31/0x30/0x2E` row, and finally a slightly
; broader `0x24/0x1C/0x1D/0x1F` pocket before a tiny cap.
Bank080000_LowByteLadderCommandFamily_09CEB0:
Bank080000_FFTerminatedCommandRecord_09CEB0:
	dc.b	$F4,$1A,$C7,$F1,$0D,$F5,$06,$29,$C4,$33,$32,$31,$C7,$30,$C4,$24
	dc.b	$24,$24,$FF

Bank080000_FFTerminatedCommandRecord_09CEC3:
	dc.b	$F4,$1A,$C7,$F1,$0D,$F5,$06,$25,$C4,$31,$30,$2E,$C7,$2C,$C4,$20
	dc.b	$20,$20,$FF

Bank080000_FFTerminatedCommandRecord_09CED6:
	dc.b	$F4,$1A,$C7,$F1,$0D,$F5,$06,$24,$C4,$1C,$1D,$1F,$C7,$24,$C4,$1C
	dc.b	$1D,$1F,$C7,$20,$C4,$27,$26,$24,$C7,$1F,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09CEF2:
	dc.b	$F4,$1A,$C7,$FA,$FF

; This broader bridge opens with a same-window local-target sweep, then falls into a literal /
; high-byte ladder around `0x3C/0x3A/0x39/0x38/0x37` plus a short `0x90/0x8E/0x93` tail.
Bank080000_LocalTargetSweepAndHighByteLadderCommandFamily_09CEF7:
Bank080000_FFTerminatedCommandRecord_09CEF7:
	dc.b	$F7,$01,$F0,$29,$D0,$F2,$CE,$D1,$5C,$CE,$D1,$6B,$CE,$D1,$5C,$CE
	dc.b	$D0,$80,$CE,$D0,$A4,$CE,$D3,$B0,$CE,$D1,$C3,$CE,$D0,$D6,$CE,$FD
	dc.b	$FE,$CE,$F4,$14,$C7,$F1,$10,$F5,$06,$3C,$C4,$3A,$39,$38,$C7,$37
	dc.b	$3C,$C4,$3A,$39,$3A,$39,$38,$39,$38,$37,$38,$37,$36,$37,$33,$34
	dc.b	$35,$36,$37,$38,$C9,$39,$C4,$3F,$40,$41,$42,$43,$44,$C9,$45,$FF

Bank080000_FFTerminatedCommandRecord_09CF47:
	dc.b	$F4,$14,$C7,$F1,$0D,$F5,$06,$90,$F1,$10,$37,$C4,$F1,$0D,$8E,$F1
	dc.b	$10,$35,$F1,$0D,$8E,$F1,$10,$35,$F1,$0D,$8E,$F1,$10,$35,$C7,$F1
	dc.b	$0D,$93,$F1,$10,$3A,$C4,$39,$38,$37,$FF

; Two tiny caps close the high-byte ladder pocket before the next broader local-control bridge.
Bank080000_FFTerminatedCommandRecord_09CF71:
	dc.b	$C7,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09CF74:
	dc.b	$C9,$FA,$FF

; This neighboring setup record returns to a compact local-control sweep, then widens into a
; literal-row family around `0x30/0x32/0x34/0x37/0x39/0x35/0x2B/0x2F` under the same `F4 F0`
; framing used by the following incbin-backed continuation.
Bank080000_LocalControlSweepAndLiteralRowCommandRecord_09CF77:
Bank080000_FFTerminatedCommandRecord_09CF77:
	dc.b	$F7,$30,$F0,$29,$D0,$71,$CF,$D7,$74,$CF,$D5,$74,$CF,$D0,$47,$CF
	dc.b	$D0,$19,$CF,$D7,$74,$CF,$FD,$7E,$CF,$88,$00,$02,$90,$CD,$49,$CE
	dc.b	$F7,$CE,$77,$CF,$00,$00,$F4,$F0,$CA,$F1,$10,$F5,$21,$30,$32,$C9
	dc.b	$34,$C6,$37,$C9,$39,$C6,$37,$CA,$35,$E2,$A8,$34,$C2,$35,$34,$CA
	dc.b	$32,$C9,$2B,$C6,$2F,$FF

; This next continuation keeps the same `F4 F0` neighborhood but broadens into a denser literal-row
; cycle around `0x30/0x37/0x3C/0x3E/0x40/0x41/0x2D/0x2B/0x28`.
Bank080000_LiteralRowCycleCommandRecord_09CFBD:
Bank080000_FFTerminatedCommandRecord_09CFBD:
	dc.b	$F4,$F0,$C4,$F1,$10,$F5,$21,$30,$F5,$05,$37,$3C,$3E,$FA,$C6,$40
	dc.b	$C4,$F5,$FB,$32,$29,$C2,$41,$C5,$FA,$C4,$2D,$2B,$C2,$F5,$0A,$40
	dc.b	$C5,$FA,$C2,$3E,$FA,$C4,$F5,$F6,$30,$F5,$0A,$37,$3C,$3E,$FA,$C6
	dc.b	$40,$C4,$F5,$F6,$32,$29,$C2,$41,$C5,$FA,$C4,$2D,$2B,$C2,$3E,$C5
	dc.b	$FA,$C2,$F5,$0A,$37,$FA,$C4,$F5,$F6,$28,$F5,$0A,$37,$3B,$3E,$FA
	dc.b	$C6,$40,$C4,$F5,$F6,$32,$29,$C2,$41,$C5,$FA,$C4,$2D,$2B,$C2,$F5
	dc.b	$0A,$2F,$C5,$FA,$C6,$F5,$F6,$30,$C4,$F5,$05,$37,$34,$32,$C6,$F5
	dc.b	$FB,$30,$2B,$FF

Bank080000_FFTerminatedCommandRecord_09D031:
	dc.b	$F4,$F0,$C4,$FA,$FF

; This neighboring bridge reuses one short local-target sweep before narrowing into a compact
; `F4 20` literal-row family around `0x3C/0x37/0x3E/0x43`, followed by two adjacent row variants.
Bank080000_LocalTargetSetupAndLiteralRowCommandFamily_09D036:
Bank080000_FFTerminatedCommandRecord_09D036:
	dc.b	$F7,$01,$F0,$07,$D0,$31,$D0,$D0,$9D,$CF,$D0,$BD,$CF,$FD,$3D,$D0
	dc.b	$F4,$20,$C2,$F1,$08,$F5,$09,$3C,$37,$3C,$37,$3E,$37,$43,$37,$3C
	dc.b	$37,$3C,$37,$3E,$37,$43,$37,$FF

Bank080000_FFTerminatedCommandRecord_09D05E:
	dc.b	$F4,$20,$C2,$F1,$08,$F5,$09,$3E,$35,$3C,$35,$3E,$35,$43,$35,$3E
	dc.b	$35,$3C,$35,$3E,$35,$43,$35,$FF

Bank080000_FFTerminatedCommandRecord_09D076:
	dc.b	$F4,$20,$C2,$F1,$08,$F5,$09,$40,$37,$3E,$37,$40,$37,$3E,$37,$40
	dc.b	$37,$3E,$37,$40,$37,$3E,$37,$FF

Bank080000_FFTerminatedCommandRecord_09D08E:
	dc.b	$F4,$20,$CA,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09D093:
	dc.b	$F4,$20,$C4,$FA,$FF

; This broader setup pocket opens with another compact D0/D1/D6 same-window walk, then falls into
; one mixed literal-row family around `0x3C/0x3E/0x40/0x41/0x43/0x45/0x47/0x48`.
Bank080000_LocalControlSweepAndLiteralRowFamily_09D098:
Bank080000_FFTerminatedCommandRecord_09D098:
	dc.b	$F7,$0C,$F0,$26,$F2,$00,$0C,$D0,$93,$D0,$D0,$46,$D0,$D0,$5E,$D0
	dc.b	$D1,$46,$D0,$D0,$5E,$D0,$D0,$76,$D0,$D0,$5E,$D0,$D0,$76,$D0,$D6
	dc.b	$8E,$D0,$FD,$A2,$D0,$F4,$24,$C2,$F1,$0C,$F5,$FC,$3C,$3E,$FF

Bank080000_FFTerminatedCommandRecord_09D0C7:
	dc.b	$F4,$24,$C4,$F1,$0D,$F5,$FC,$40,$C6,$43,$C8,$40,$C2,$F1,$0C,$3C
	dc.b	$3E,$C4,$F1,$0D,$40,$C6,$43,$C8,$40,$C2,$F1,$0C,$3C,$3E,$C4,$F1
	dc.b	$0D,$40,$43,$43,$48,$CD,$F1,$10,$47,$45,$43,$E2,$A8,$F1,$0D,$40
	dc.b	$C2,$F1,$0C,$3E,$40,$C4,$F1,$0D,$41,$C6,$43,$C8,$3C,$C2,$F1,$0C
	dc.b	$3E,$40,$C4,$F1,$0D,$41,$C6,$43,$C8,$3B,$C2,$F1,$0C,$41,$40,$C7
	dc.b	$F1,$0D,$F5,$0A,$3E,$C4,$40,$41,$43,$45,$48,$C7,$F1,$10,$47,$C0
	dc.b	$FA,$46,$45,$44,$C7,$F1,$0D,$F5,$F6,$43,$C4,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09D134:
	dc.b	$F4,$24,$E2,$A8,$FA,$C2,$F1,$10,$F5,$06,$3C,$3E,$FF

Bank080000_FFTerminatedCommandRecord_09D141:
	dc.b	$F4,$24,$CA,$FA,$FF

; This next setup sweep changes neighborhood again: the front walks through E0/D0/D5/D1-tagged
; local targets before widening into a compact high-byte ladder around `0xAC/0xAA/0xA8/.../0xA1`.
Bank080000_LocalControlSweepAndHighByteLadderCommandRecord_09D146:
Bank080000_FFTerminatedCommandRecord_09D146:
	dc.b	$F7,$02,$F0,$29,$E0,$0A,$D0,$BD,$D0,$D0,$C7,$D0,$D5,$41,$D1,$D0
	dc.b	$34,$D1,$FD,$4F,$D1,$F4,$0E,$C7,$FA,$C4,$F1,$06,$F5,$21,$AC,$4F
	dc.b	$FA,$AA,$4D,$FA,$A8,$4C,$C7,$FA,$C4,$B1,$54,$AF,$53,$C2,$FA,$F1
	dc.b	$0C,$AD,$51,$C4,$FA,$F1,$06,$AC,$4F,$C7,$FA,$C4,$F1,$05,$A5,$48
	dc.b	$A7,$4A,$A8,$4C,$AA,$4D,$AC,$4F,$C7,$FA,$C4,$F1,$06,$B1,$54,$AF
	dc.b	$53,$C2,$FA,$F1,$0C,$AD,$51,$C4,$FA,$F1,$06,$AC,$4F,$C8,$FA,$C4
	dc.b	$AA,$4D,$C2,$FA,$C4,$A8,$4C,$C5,$FA,$C4,$FA,$A1,$45,$C7,$FA,$C4
	dc.b	$A3,$47,$FA,$A3,$48,$FF

Bank080000_FFTerminatedCommandRecord_09D1BC:
	dc.b	$F4,$0E,$CA,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09D1C1:
	dc.b	$F4,$0E,$C4,$FA,$FF

; This broader continuation returns to a compact local-control bridge, then spends most of its
; payload on repeated literal-row descents around `0x3C/0x3B/0x39/0x37/0x35/0x34/0x32/0x30`.
Bank080000_LocalControlSweepAndLiteralRowDescentCommandRecord_09D1C6:
Bank080000_FFTerminatedCommandRecord_09D1C6:
	dc.b	$F7,$0A,$F0,$0B,$F2,$00,$F4,$D0,$C1,$D1,$D7,$BC,$D1,$D0,$5B,$D1
	dc.b	$D0,$BC,$D1,$FD,$D0,$D1,$F4,$00,$CF,$FA,$C4,$F1,$10,$F5,$21,$3C
	dc.b	$3B,$39,$C9,$37,$C4,$32,$34,$C6,$35,$C4,$37,$39,$FA,$F5,$F6,$3C
	dc.b	$FA,$C6,$F5,$F6,$3B,$C4,$F5,$14,$37,$C8,$FA,$C4,$F5,$0A,$32,$F5
	dc.b	$F6,$34,$C6,$35,$C4,$F5,$F6,$37,$C2,$F5,$0A,$34,$C5,$FA,$C2,$32
	dc.b	$C5,$FA,$C7,$F5,$F6,$3B,$C4,$F5,$0A,$37,$C7,$FA,$C4,$32,$34,$C6
	dc.b	$35,$C4,$37,$34,$FA,$F5,$FB,$32,$FA,$CF,$F5,$FB,$30,$C8,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09D236:
	dc.b	$F4,$00,$CA,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09D23B:
	dc.b	$F4,$00,$C4,$FA,$FF

; This short bridge opens with a compact local-target walk, then narrows into literal-control
; bursts around `0x0F`, `0x71`, `0x0D`, and `0x0C` before the repeated-pair cluster at `0x09D294`.
Bank080000_LocalTargetSetupAndLiteralControlCommandFamily_09D240:
Bank080000_FFTerminatedCommandRecord_09D240:
	dc.b	$F7,$04,$F0,$00,$D0,$3B,$D2,$D6,$36,$D2,$D0,$DC,$D1,$FD,$47,$D2
	dc.b	$F4,$00,$C6,$F5,$1C,$0F,$0F,$0F,$F5,$F6,$71,$F5,$0A,$0F,$FF

Bank080000_FFTerminatedCommandRecord_09D25F:
	dc.b	$F4,$00,$C6,$F5,$1C,$0F,$C4,$0F,$F5,$0A,$0D,$0D,$FA,$F5,$F6,$0C
	dc.b	$C2,$F5,$F6,$0C,$F5,$F6,$0C,$FF

Bank080000_FFTerminatedCommandRecord_09D277:
	dc.b	$F4,$00,$C6,$F5,$1C,$0F,$C2,$F5,$F6,$71,$F5,$0A,$0F,$C5,$FA,$C6
	dc.b	$0F,$F5,$F6,$71,$F5,$0A,$0F,$FF

Bank080000_FFTerminatedCommandRecord_09D28F:
	dc.b	$F4,$00,$C4,$FA,$FF

; This local-control bridge narrows into the repeated pair-heavy `F4 FC` family that stays explicit
; through the next five neighboring records.
Bank080000_LocalControlBridgeAndRepeatedPairFamily_09D294:
Bank080000_FFTerminatedCommandRecord_09D294:
	dc.b	$F8,$D0,$8F,$D2,$D6,$50,$D2,$D0,$5F,$D2,$D0,$50,$D2,$D0,$77,$D2
	dc.b	$D0,$50,$D2,$D0,$77,$D2,$D1,$50,$D2,$D0,$5F,$D2,$FD,$98,$D2,$88
	dc.b	$34,$01,$36,$D0,$98,$D0,$46,$D1,$C6,$D1,$40,$D2,$94,$D2,$00,$00
	dc.b	$F4,$FC,$C6,$F1,$0D,$F5,$17,$30,$2B,$30,$2B,$FF

Bank080000_FFTerminatedCommandRecord_09D2D0:
	dc.b	$F4,$FC,$C6,$F1,$0D,$F5,$17,$32,$2D,$32,$2D,$2B,$32,$C4,$37,$37
	dc.b	$35,$32,$FF

Bank080000_FFTerminatedCommandRecord_09D2E3:
	dc.b	$F4,$FC,$C6,$F1,$0D,$F5,$17,$29,$30,$29,$30,$C4,$30,$3C,$30,$3B
	dc.b	$30,$39,$C2,$F1,$0C,$37,$37,$C4,$F1,$0D,$37,$FF

Bank080000_FFTerminatedCommandRecord_09D2FF:
	dc.b	$F4,$FC,$C4,$F1,$0D,$F5,$0D,$30,$30,$C2,$FA,$F1,$0C,$30,$FA,$30
	dc.b	$C4,$F1,$0D,$30,$FA,$C0,$F1,$10,$F5,$0A,$36,$E2,$2A,$37,$FF

Bank080000_FFTerminatedCommandRecord_09D31E:
	dc.b	$F4,$FC,$C6,$F1,$0D,$F5,$17,$30,$2B,$30,$C0,$F1,$10,$36,$E2,$2A
	dc.b	$37,$FF

Bank080000_FFTerminatedCommandRecord_09D330:
	dc.b	$F4,$FC,$C6,$F1,$10,$F5,$17,$29,$30,$C4,$2B,$FA,$C0,$31,$E2,$2A
	dc.b	$32,$FF

; This continuation keeps the repeated `F4 FC` pair-ladder neighborhood explicit a little longer:
; two broader `0x29/0x30/0x35/0x37/0x32/0x34` row cycles, one mixed repeated-pair bridge, and one
; shorter `0x30/0x2B/0x37/0x39/0x35` tail before the next local-target setup pocket.
Bank080000_RepeatedPairLadderCommandFamily_09D342:
Bank080000_FFTerminatedCommandRecord_09D342:
	dc.b	$F4,$FC,$C4,$F1,$0D,$F5,$17,$29,$FA,$30,$FA,$C2,$F1,$0C,$35,$35
	dc.b	$35,$C4,$F1,$0D,$35,$C2,$F1,$0C,$34,$C4,$F1,$0D,$32,$30,$FA,$2B
	dc.b	$FA,$C2,$F1,$0C,$30,$30,$30,$30,$FA,$2E,$C4,$F1,$0D,$2D,$FF

Bank080000_FFTerminatedCommandRecord_09D371:
	dc.b	$F4,$FC,$C4,$F1,$0D,$F5,$17,$2B,$FA,$32,$FA,$C2,$F1,$0C,$37,$37
	dc.b	$37,$C4,$F1,$0D,$37,$C2,$F1,$0C,$35,$C4,$F1,$0D,$32,$30,$FA,$2B
	dc.b	$FA,$C2,$F1,$0C,$30,$30,$30,$30,$FA,$32,$C4,$F1,$0D,$34,$32,$FA
	dc.b	$2D,$FA,$C2,$F1,$0C,$32,$32,$32,$C4,$F1,$0D,$32,$C2,$F1,$0C,$34
	dc.b	$C4,$F1,$0D,$35,$2B,$FA,$32,$FA,$C2,$F1,$0C,$37,$37,$37,$C4,$F1
	dc.b	$0D,$37,$C2,$F1,$0C,$35,$C4,$F1,$0D,$32,$FF

Bank080000_FFTerminatedCommandRecord_09D3CC:
	dc.b	$F4,$FC,$C2,$F1,$0C,$F5,$17,$30,$30,$C6,$FA,$C2,$34,$34,$2B,$2B
	dc.b	$C7,$FA,$C2,$32,$32,$C6,$FA,$C2,$30,$30,$2D,$2D,$C7,$FA,$C2,$30
	dc.b	$30,$C6,$FA,$C2,$34,$34,$2B,$2B,$C4,$F1,$0D,$37,$FA,$37,$C2,$F1
	dc.b	$0C,$2B,$2B,$C6,$FA,$C2,$32,$32,$37,$37,$FA,$37,$35,$34,$C4,$F1
	dc.b	$0D,$32,$FF

Bank080000_FFTerminatedCommandRecord_09D40F:
	dc.b	$F4,$FC,$C6,$F1,$0D,$F5,$17,$30,$2B,$30,$37,$32,$2D,$32,$39,$C5
	dc.b	$35,$30,$C4,$35,$C5,$37,$32,$C4,$37,$FF

; This short setup bridge returns to compact same-window D0/D1/D2-tagged targets, then hands off to the
; broader `F4 2C` high-byte family rooted on `0x9C/0x9B/0x99` and later `0xAC/0xAD/0xAF/0xB1` pairs.
Bank080000_LocalTargetSetupAndHighBytePairBridge_09D429:
Bank080000_FFTerminatedCommandRecord_09D429:
	dc.b	$F6,$00,$F7,$01,$F0,$09,$D0,$0F,$D4,$D0,$FF

Bank080000_FFTerminatedCommandRecord_09D434:
	dc.b	$D2,$D0,$C4,$D2,$D0,$1E,$D3,$D0,$D0,$D2,$D0,$E3,$D2,$D0,$D0,$D2
	dc.b	$D0,$C4,$D2,$D0,$1E,$D3,$D0,$D0,$D2,$D0,$E3,$D2,$D0,$30,$D3,$D0
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09D455:
	dc.b	$D2,$D1,$42,$D3,$D0,$71,$D3,$D0,$CC,$D3,$D0,$0F,$D4,$D0,$FF

Bank080000_FFTerminatedCommandRecord_09D464:
	dc.b	$D2,$FD,$35,$D4,$F4,$2C,$C4,$F1,$0A,$F5,$F7,$9C,$40,$9C,$40,$C2
	dc.b	$F1,$09,$9B,$40,$9B,$40,$FA,$99,$40,$FA,$99,$40,$FA,$9B,$40,$C4
	dc.b	$F1,$0A,$9B,$40,$FA,$FF

; The following pocket keeps the same compact `F4 2C` framing while alternating short high-byte-pair
; descents, one mixed `0x99/0xA0/0x9E` bridge, and a later `0x95/0x97/0x9C` to `0xAC/0xAA/.../0xA3` tail.
Bank080000_HighBytePairAndTailCommandFamily_09D48A:
Bank080000_FFTerminatedCommandRecord_09D48A:
	dc.b	$F4,$2C,$C4,$F1,$0A,$F5,$F7,$9E,$41,$9E,$41,$C2,$F1,$09,$9C,$41
	dc.b	$9C,$41,$FA,$9B,$41,$FA,$9B,$41,$FA,$9C,$41,$C4,$F1,$0A,$9C,$41
	dc.b	$99,$41,$9E,$41,$9E,$41,$C2,$F1,$09,$9C,$41,$9C,$41,$FA,$9B,$41
	dc.b	$FA,$F1,$10,$9B,$41,$F1,$0C,$F5,$FB,$AC,$4F,$AD,$51,$AF,$53,$B1
	dc.b	$54,$AF,$53,$AD,$51,$FF

Bank080000_FFTerminatedCommandRecord_09D4D0:
	dc.b	$F4,$2C,$C4,$F1,$0A,$F5,$F7,$99,$41,$99,$41,$C2,$F1,$09,$A0,$39
	dc.b	$A0,$39,$FA,$9E,$39,$FA,$9E,$39,$FA,$A0,$39,$C4,$F1,$0A,$A0,$39
	dc.b	$9C,$39,$A0,$43,$C2,$F1,$09,$37,$C4,$F1,$0A,$9E,$41,$C2,$FA,$F1
	dc.b	$09,$37,$37,$C4,$F1,$0A,$9C,$40,$C2,$F1,$09,$37,$C4,$F1,$0D,$9B
	dc.b	$3E,$C5,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09D514:
	dc.b	$F4,$2C,$C4,$F1,$0A,$F5,$F7,$9C,$40,$9C,$40,$C2,$FA,$F1,$09,$9C
	dc.b	$40,$FA,$9C,$40,$C4,$F1,$0A,$9C,$40,$C7,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09D530:
	dc.b	$F4,$2C,$C4,$F1,$0A,$F5,$F7,$9C,$40,$9C,$40,$C2,$F1,$09,$9B,$40
	dc.b	$9B,$40,$FA,$99,$40,$FA,$99,$40,$FA,$9B,$40,$C4,$F1,$0A,$9B,$40
	dc.b	$97,$40,$FF

Bank080000_FFTerminatedCommandRecord_09D553:
	dc.b	$F4,$2C,$C4,$F1,$0D,$F5,$F7,$95,$3C,$95,$3C,$C2,$FA,$F1,$0C,$95
	dc.b	$3C,$FA,$95,$3C,$C4,$F1,$0D,$97,$3E,$FA,$9C,$40,$FA,$F1,$0A,$9C
	dc.b	$37,$9C,$37,$C2,$FA,$F1,$09,$9C,$37,$FA,$9C,$37,$C4,$F1,$0A,$9C
	dc.b	$37,$C2,$F1,$0C,$AC,$4F,$AA,$4D,$A8,$4C,$A6,$4A,$A5,$48,$A3,$46
	dc.b	$FF

; Two tiny neighboring records close this `F4 2C` neighborhood with short literal ladders before the
; already explicit high-byte descent family at `0x09D5BF`.
Bank080000_CompactLiteralLadderCommandPair_09D594:
Bank080000_FFTerminatedCommandRecord_09D594:
	dc.b	$F4,$2C,$C4,$F1,$08,$F5,$ED,$45,$48,$4D,$C2,$45,$48,$FA,$4D,$FA
	dc.b	$45,$C4,$48,$4D,$FF

Bank080000_FFTerminatedCommandRecord_09D5A9:
	dc.b	$F4,$2C,$C4,$F1,$08,$F5,$ED,$43,$48,$4C,$C2,$43,$48,$FA,$4C,$48
	dc.b	$FA,$4C,$4C,$C4,$43,$FF

; This front pocket keeps one compact `F4 2C` header across adjacent records while stepping
; down short 0x9E/0x9C/0x9B high-byte pairs rooted on the same 0x41 anchor.
Bank080000_HighBytePairDescentCommandFamily_09D5BF:
Bank080000_FFTerminatedCommandRecord_09D5BF:
	dc.b	$F4,$2C,$C4,$F1,$0A,$F5,$F7,$9E,$41,$9E,$41,$C2,$F1,$09,$9C,$41
	dc.b	$9C,$41,$FA,$9B,$41,$FA,$9B,$41,$FA,$F1,$0C,$9B,$41,$C6,$F1,$0D
	dc.b	$9C,$41,$FF

; The next adjacent pair keeps the same compact framing but narrows into short literal ladders
; around `0x43/0x47/0x4A/0x4D/0x4F` instead of staying in the high-byte family.
Bank080000_CompactLiteralLadderCommandPair_09D5E2:
Bank080000_FFTerminatedCommandRecord_09D5E2:
	dc.b	$F4,$2C,$C4,$F1,$08,$F5,$ED,$43,$47,$4A,$C2,$43,$47,$FA,$4A,$FA
	dc.b	$43,$C4,$F1,$03,$47,$F1,$08,$4D,$FF

Bank080000_FFTerminatedCommandRecord_09D5FB:
	dc.b	$F4,$2C,$C4,$F1,$08,$F5,$F7,$43,$4A,$4F,$C2,$4A,$C4,$47,$C2,$43
	dc.b	$C4,$47,$4A,$43,$FF

Bank080000_FFTerminatedCommandRecord_09D610:
	dc.b	$F4,$2C,$C4,$F1,$0A,$F5,$F7,$9E,$41,$9E,$41,$C2,$F1,$09,$9C,$41
	dc.b	$9C,$41,$FA,$9B,$41,$FA,$9B,$41,$FA,$9C,$41,$C4,$F1,$0A,$9C,$41
	dc.b	$99,$41,$FF

; This short follow-on starts in the same `F4 2C` neighborhood, then tips from the
; `0x9E/0x9C/0x9B` front into a compact `0xAC/0xAD/0xAF/0xB1` high-byte tail before one final
; literal descent.
Bank080000_HighByteTailAndLiteralDescentCommandPair_09D633:
Bank080000_FFTerminatedCommandRecord_09D633:
	dc.b	$F4,$2C,$C4,$F1,$0D,$F5,$F7,$9E,$43,$C2,$F1,$0C,$9E,$43,$9C,$43
	dc.b	$FA,$9C,$43,$FA,$9B,$43,$C4,$FA,$C2,$F5,$F6,$AC,$4F,$AD,$51,$AF
	dc.b	$53,$B1,$54,$AF,$53,$AD,$51,$FF

Bank080000_FFTerminatedCommandRecord_09D65B:
	dc.b	$F4,$2C,$C4,$FA,$F1,$08,$F5,$ED,$4D,$4C,$4A,$48,$47,$45,$43,$FF

; This longer bridge returns to the denser local-target style: repeated D0/D1 walks through the
; same window, then a short literal cap around `0x43` closes the record.
Bank080000_LocalTargetSweepAndLiteralCapCommandRecord_09D66B:
Bank080000_FFTerminatedCommandRecord_09D66B:
	dc.b	$F7,$0C,$F0,$03,$D0,$30,$D5,$D1,$10,$D6,$D0,$14,$D5,$D0,$30,$D5
	dc.b	$D0,$68,$D4,$D0,$10,$D6,$D0,$BF,$D5,$D0,$D0,$D4,$D0,$8A,$D4,$D0
	dc.b	$30,$D5,$D0,$68,$D4,$D0,$10,$D6,$D0,$BF,$D5,$D0,$D0,$D4,$D0,$53
	dc.b	$D5,$D0,$94,$D5,$D0,$A9,$D5,$D0,$94,$D5,$D0,$5B,$D6,$D0,$E2,$D5
	dc.b	$D0,$A9,$D5,$D0,$94,$D5,$D0,$FB,$D5,$D0,$30,$D5,$D0,$10,$D6,$D0
	dc.b	$30,$D5,$D0,$33,$D6,$D0,$30,$D5,$D1,$10,$D6,$D0,$14,$D5,$FD,$78
	dc.b	$D6,$F4,$0C,$C9,$FA,$C5,$F1,$10,$F5,$0D,$43,$C2,$FA,$FF

; This neighboring family keeps the same compact `F4 0C` framing while widening into longer
; literal/high-byte ladders around `0x43/0x45/0x47/0x48/0x4A/0x4C/0x4D/0x4F/0x51`.
Bank080000_LiteralAndHighByteLadderCommandFamily_09D6D9:
Bank080000_FFTerminatedCommandRecord_09D6D9:
	dc.b	$F4,$0C,$C4,$F1,$10,$F5,$0D,$48,$C2,$FA,$48,$C7,$FA,$C2,$43,$FA
	dc.b	$48,$FA,$4A,$FA,$C4,$4C,$C2,$4D,$4C,$FA,$4C,$4A,$FA,$4A,$FA,$4A
	dc.b	$48,$FA,$48,$C4,$47,$C7,$45,$C4,$4C,$C7,$4A,$C4,$48,$47,$C2,$48
	dc.b	$47,$FA,$47,$C4,$45,$43,$FA,$C5,$43,$C2,$FA,$C4,$4A,$C2,$FA,$4A
	dc.b	$C7,$FA,$C2,$4A,$FA,$4C,$FA,$4D,$FA,$C4,$4F,$C2,$43,$C4,$4C,$C2
	dc.b	$4A,$4C,$FA,$C4,$4A,$C2,$43,$C4,$4A,$C2,$43,$48,$47,$FF

Bank080000_FFTerminatedCommandRecord_09D737:
	dc.b	$F4,$0C,$C5,$F1,$10,$F5,$0D,$45,$47,$C4,$48,$C5,$4A,$4C,$C4,$48
	dc.b	$C7,$4A,$C4,$FA,$C8,$F5,$0A,$43,$FF

Bank080000_FFTerminatedCommandRecord_09D750:
	dc.b	$F4,$0C,$C5,$F1,$10,$F5,$0D,$45,$48,$C4,$4C,$4A,$FA,$C6,$4C,$C2
	dc.b	$48,$FA,$48,$C4,$FA,$C2,$48,$FA,$48,$48,$E2,$54,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09D76E:
	dc.b	$F4,$0C,$C5,$F1,$10,$F5,$0D,$51,$C4,$4D,$C2,$FA,$C4,$48,$C2,$FA
	dc.b	$45,$FA,$45,$C4,$4D,$51,$C5,$4F,$C4,$4C,$C2,$FA,$C4,$48,$C6,$FA
	dc.b	$47,$C5,$51,$C4,$4D,$C2,$FA,$C4,$48,$C2,$FA,$45,$FA,$45,$C4,$4D
	dc.b	$51,$C8,$4F,$FA,$C5,$4D,$C4,$4A,$C2,$FA,$C4,$47,$C2,$FA,$43,$FA
	dc.b	$43,$C4,$4A,$4D,$C5,$4C,$C2,$4F,$C4,$FA,$48,$C6,$FA,$47,$C5,$45
	dc.b	$47,$C4,$48,$C2,$4A,$FA,$C4,$45,$47,$48,$C7,$4A,$C2,$47,$45,$C4
	dc.b	$43,$FA,$C6,$43,$FF

; This short continuation keeps the same `F4 0C` neighborhood but collapses into one compact
; literal/high-byte pocket with brief `F5 EC` and `F5 0A` pivots.
Bank080000_LiteralHighBytePocketCommandRecord_09D7D3:
Bank080000_FFTerminatedCommandRecord_09D7D3:
	dc.b	$F4,$0C,$C4,$F1,$0D,$F5,$03,$48,$C2,$F1,$0C,$48,$48,$FA,$F1,$10
	dc.b	$F5,$14,$48,$C8,$4C,$C4,$F5,$EC,$43,$F1,$0D,$4A,$C2,$F1,$0C,$4A
	dc.b	$4A,$FA,$F1,$10,$4A,$C8,$4D,$C2,$4C,$4D,$FF

; The next pair keeps the same compact control header while alternating literal and high-byte
; pockets across `0x4F/0x4C/0x4A/0x48/0x47/0x43`.
Bank080000_LiteralHighBytePocketCommandFamily_09D7FE:
Bank080000_FFTerminatedCommandRecord_09D7FE:
	dc.b	$F4,$0C,$C2,$F1,$10,$F5,$0D,$4F,$FA,$F5,$F6,$4C,$C4,$4D,$C2,$4A
	dc.b	$F5,$0A,$4C,$FA,$F5,$F6,$48,$C4,$4A,$C2,$47,$48,$FA,$45,$FA,$47
	dc.b	$FA,$47,$48,$FA,$48,$C7,$F5,$0A,$4A,$C6,$43,$FF

Bank080000_FFTerminatedCommandRecord_09D82A:
	dc.b	$F4,$0C,$C2,$F1,$10,$F5,$0D,$4F,$FA,$F5,$F6,$4C,$C4,$4D,$C2,$FA
	dc.b	$4A,$F5,$0A,$4C,$FA,$F5,$F6,$48,$F5,$0A,$4A,$FA,$4A,$FA,$C4,$4C
	dc.b	$C2,$48,$FA,$48,$C4,$FA,$C2,$48,$FA,$48,$48,$C5,$FA,$43,$C2,$FA
	dc.b	$FF

; This local-control family returns to the recurring `0x60/0x65` burst neighborhood, mixing
; short `0x0B/0x08/0x0D/0x07/0x13/0x14/0x15` literal-control rows while the first record keeps a
; longer D0/D2/D6 setup prelude.
Bank080000_LocalControlBurstCommandFamily_09D85B:
Bank080000_FFTerminatedCommandRecord_09D85B:
	dc.b	$F7,$02,$F0,$29,$CA,$FA,$FA,$FA,$D0,$CC,$D6,$D0,$D9,$D6,$D0,$37
	dc.b	$D7,$D0,$D9,$D6,$D0,$50,$D7,$F0,$02,$D0,$6E,$D7,$F0,$29,$D0,$D3
	dc.b	$D7,$D0,$FE,$D7,$D0,$D3,$D7,$D0,$2A,$D8,$FD,$66,$D8,$F4,$00,$C2
	dc.b	$F5,$12,$60,$0B,$08,$0B,$08,$65,$08,$0A,$0A,$07,$60,$07,$C4,$0B
	dc.b	$C2,$0B,$C4,$65,$0A,$C2,$07,$07,$FF

Bank080000_FFTerminatedCommandRecord_09D8A4:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$0B,$08,$0B,$08,$0D,$0D,$0C,$07,$60,$07
	dc.b	$C4,$14,$C2,$14,$C4,$14,$15,$FF

Bank080000_FFTerminatedCommandRecord_09D8BC:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$0B,$08,$65,$0B,$08,$60,$08,$0A,$65,$0A
	dc.b	$07,$60,$07,$0B,$05,$0B,$60,$0A,$FA,$65,$07,$07,$FF

Bank080000_FFTerminatedCommandRecord_09D8D9:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$0B,$08,$0B,$08,$0D,$0D,$0C,$07,$60,$07
	dc.b	$F5,$F6,$13,$FA,$13,$13,$FA,$13,$F5,$0A,$07,$FF

Bank080000_FFTerminatedCommandRecord_09D8F5:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$0B,$08,$65,$0B,$08,$60,$08,$0A,$65,$0A
	dc.b	$07,$60,$07,$F5,$FB,$13,$F5,$05,$05,$F5,$F6,$13,$F5,$0A,$60,$F5
	dc.b	$F6,$13,$FA,$F5,$0A,$65,$F5,$F6,$13,$F5,$0A,$07,$FF

; This final bridge in the run alternates compact D2/D6/D0 local-control steps, then hands off
; to the same repeated `F4 10` pair-ladder family that begins at `0x09D981`.
Bank080000_AlternatingLocalControlAndPairLadderCommandRecord_09D922:
Bank080000_FFTerminatedCommandRecord_09D922:
	dc.b	$F8,$D2,$88,$D8,$D0,$A4,$D8,$D2,$88,$D8,$D0,$A4,$D8,$D2,$88,$D8
	dc.b	$D0,$A4,$D8,$D6,$88,$D8,$D0,$A4,$D8,$D0,$BC,$D8,$D0,$F5,$D8,$D2
	dc.b	$BC,$D8,$D0,$A4,$D8,$D0,$BC,$D8,$D0,$D9,$D8,$D2,$88,$D8,$D0,$D9
	dc.b	$D8,$D2,$88,$D8,$D0,$A4,$D8,$FD,$29,$D9,$88,$AA,$01,$29,$D4,$6B
	dc.b	$D6,$5B,$D8,$22,$D9,$00,$00,$F4,$10,$C4,$F1,$0D,$F5,$FC,$28,$30
	dc.b	$28,$2F,$28,$2D,$28,$2B,$28,$2B,$28,$2D,$28,$2F,$28,$2D,$FF

; This local cluster repeats the same compact F4/F1/F5 framing across four adjacent 0x18-byte
; records, then tapers into two shorter FF-terminated continuations with the same pair-heavy
; payload style. Keep the family explicit instead of hiding it behind six raw slices.
Bank080000_RepeatedTwentyFourByteCommandRecordCluster_09D981:
Bank080000_FFTerminatedCommandRecord_09D981:
	dc.b	$F4,$10,$C4,$F1,$0D,$F5,$FC,$28,$30,$28,$2F,$28,$2D,$28,$2B,$28
	dc.b	$2B,$28,$2D,$28,$2F,$28,$2D,$FF

Bank080000_FFTerminatedCommandRecord_09D999:
	dc.b	$F4,$10,$C4,$F1,$0D,$F5,$FC,$26,$2F,$26,$2D,$26,$2B,$26,$2A,$26
	dc.b	$28,$26,$2A,$26,$2B,$26,$28,$FF

Bank080000_FFTerminatedCommandRecord_09D9B1:
	dc.b	$F4,$10,$C4,$F1,$0D,$F5,$FC,$26,$2F,$26,$2D,$26,$2B,$26,$2A,$FF

Bank080000_FFTerminatedCommandRecord_09D9C1:
	dc.b	$F4,$10,$C4,$F1,$0D,$F5,$FC,$2F,$2D,$2B,$2A,$2F,$36,$2F,$34,$2F
	dc.b	$2D,$2B,$29,$2F,$3B,$2F,$3B,$FF

Bank080000_FFTerminatedCommandRecord_09D9D9:
	dc.b	$F4,$10,$C4,$F1,$0D,$F5,$FC,$2B,$2D,$2B,$2F,$2B,$2D,$2B,$2F,$2A
	dc.b	$2B,$2A,$2D,$2A,$2B,$2A,$2B,$FF

Bank080000_FFTerminatedCommandRecord_09D9F1:
	dc.b	$F4,$10,$CD,$F1,$10,$F5,$FC,$2D,$2B,$2D,$34,$32,$30,$FF

; This neighboring record starts with a compact local-control setup, walks several local
; D0/D2/CA/FD targets inside the same window, and then drops into a short literal/control
; pocket built around 0x47/0x45/0x4A/0x48 before the final FF terminator.
Bank080000_LocalTargetSetupAndLiteralPocketCommandRecord_09D9FF:
Bank080000_FFTerminatedCommandRecord_09D9FF:
	dc.b	$F6,$00,$F7,$01,$F0,$08,$D0,$69,$D9,$D5,$69,$D9,$D0,$99,$D9,$D0
	dc.b	$B1,$D9,$D0,$F1,$D9,$D2,$C1,$D9,$D0,$D9,$D9,$D2,$C1,$D9,$D0,$D9
	dc.b	$D9,$CA,$FA,$FA,$FA,$D0,$F1,$D9,$FD,$08,$DA,$F4,$03,$C9,$F1,$10
	dc.b	$F5,$17,$47,$C6,$45,$C9,$4A,$C6,$48,$C7,$47,$43,$45,$41,$C6,$43
	dc.b	$41,$CA,$40,$FF

; This neighboring run keeps the same compact F4/F1/F5 framing but resolves into a short
; 0xBx/0x5x pair-ladder family, tiny literal-control pivots, and one longer mixed literal /
; high-byte continuation before the next local-target setup record at 0x09DB5B.
Bank080000_HighBytePairAndLiteralCommandFamily_09DA43:
Bank080000_FFTerminatedCommandRecord_09DA43:
	dc.b	$F4,$03,$C4,$FA,$C2,$F1,$10,$F5,$2B,$B3,$58,$C5,$FA,$C2,$F5,$F1
	dc.b	$B1,$56,$C5,$FA,$C2,$F5,$F1,$AF,$54,$C5,$FA,$C2,$F5,$0A,$AD,$53
	dc.b	$FA,$FF

Bank080000_FFTerminatedCommandRecord_09DA65:
	dc.b	$F4,$03,$C9,$FA,$C6,$F1,$10,$F5,$17,$40,$FF

Bank080000_FFTerminatedCommandRecord_09DA70:
	dc.b	$F4,$03,$CD,$F1,$10,$F5,$2B,$AC,$51,$F5,$F6,$AB,$4F,$F5,$F6,$AA
	dc.b	$4E,$F5,$F6,$A8,$4C,$F5,$0A,$A6,$4A,$F5,$0A,$A5,$49,$FF

Bank080000_FFTerminatedCommandRecord_09DA8E:
	dc.b	$F4,$03,$C9,$F1,$10,$F5,$17,$47,$C6,$45,$C9,$4A,$C6,$48,$C7,$47
	dc.b	$4C,$47,$43,$C6,$45,$43,$CA,$42,$FF

Bank080000_FFTerminatedCommandRecord_09DAA7:
	dc.b	$F4,$03,$C4,$FA,$C2,$F1,$10,$F5,$2B,$A3,$48,$C5,$FA,$C2,$F5,$F1
	dc.b	$A5,$4A,$C5,$FA,$C2,$F5,$F1,$A7,$4C,$C5,$FA,$C2,$F5,$0A,$A8,$4E
	dc.b	$FA,$FF

Bank080000_FFTerminatedCommandRecord_09DAC9:
	dc.b	$F4,$03,$CA,$F1,$10,$F5,$26,$47,$46,$4A,$CF,$49,$C2,$F5,$E7,$A9
	dc.b	$4E,$FA,$C4,$F5,$14,$49,$C2,$F5,$EC,$A8,$4D,$FA,$CA,$F5,$19,$47
	dc.b	$CF,$46,$C2,$F5,$E7,$A6,$4A,$F5,$14,$46,$F5,$EC,$A6,$4A,$F5,$14
	dc.b	$46,$F5,$EC,$A5,$49,$F5,$14,$46,$C6,$F5,$F6,$9E,$43,$F5,$05,$9D
	dc.b	$42,$F5,$05,$9C,$41,$9B,$40,$F5,$F6,$AA,$4F,$F5,$05,$A9,$4E,$F5
	dc.b	$05,$A8,$4D,$A5,$4A,$FF

Bank080000_FFTerminatedCommandRecord_09DB1F:
	dc.b	$F4,$03,$C4,$FA,$C2,$F1,$10,$F5,$2B,$B3,$58,$C5,$FA,$C2,$F5,$F1
	dc.b	$B1,$56,$C5,$FA,$C2,$F5,$F1,$AF,$54,$FA,$C4,$F5,$0A,$C6,$40,$FF

Bank080000_FFTerminatedCommandRecord_09DB3F:
	dc.b	$F4,$03,$E3,$38,$01,$F1,$10,$F5,$21,$A7,$4C,$C4,$F1,$0D,$F5,$EC
	dc.b	$A8,$4D,$FA,$E2,$D8,$F1,$10,$F5,$14,$A7,$4C,$FF

; This short bridge starts with another compact setup/local-target sweep, this time reusing
; E0/E1-tagged local steps before ending in a three-repeat literal row.
Bank080000_LocalTargetSetupAndLiteralRowCommandRecord_09DB5B:
Bank080000_FFTerminatedCommandRecord_09DB5B:
	dc.b	$F6,$00,$F7,$0E,$F2,$00,$F4,$F0,$0A,$CA,$FA,$E0,$10,$D0,$65,$DA
	dc.b	$E0,$10,$D0,$2A,$DA,$E1,$D0,$43,$DA,$CA,$FA,$D0,$1F,$DB,$E0,$10
	dc.b	$D0,$8E,$DA,$E1,$D0,$A7,$DA,$CA,$FA,$D0,$70,$DA,$D1,$C9,$DA,$D0
	dc.b	$3F,$DB,$D0,$70,$DA,$FD,$6B,$DB,$F4,$02,$C4,$F1,$0D,$F5,$26,$45
	dc.b	$40,$43,$45,$40,$43,$45,$40,$FF

; Two neighboring compact rows keep the same F4/C4/F1/F5 framing while narrowing into
; short literal runs plus one tiny C2/F1 pivot before the next repeated-shape cluster.
Bank080000_CompactLiteralRowCommandFamily_09DBA3:
Bank080000_FFTerminatedCommandRecord_09DBA3:
	dc.b	$F4,$02,$C4,$FA,$F1,$0D,$F5,$26,$40,$43,$40,$45,$40,$45,$47,$FF

Bank080000_FFTerminatedCommandRecord_09DBB3:
	dc.b	$F4,$02,$C4,$FA,$F1,$0D,$F5,$26,$40,$45,$40,$C2,$F1,$0C,$47,$45
	dc.b	$43,$3E,$F5,$F6,$3C,$3E,$40,$41,$FF

; A second repeated-shape cluster appears here with the same compact control framing and two
; adjacent 0x18-byte records followed by shorter FF-terminated continuations.
Bank080000_RepeatedTwentyFourByteCommandRecordCluster_09DBCC:
Bank080000_FFTerminatedCommandRecord_09DBCC:
	dc.b	$F4,$02,$C4,$FA,$F1,$10,$F5,$17,$B3,$58,$B6,$5B,$B9,$5F,$B6,$5B
	dc.b	$B8,$5D,$C2,$58,$56,$51,$4D,$FF

Bank080000_FFTerminatedCommandRecord_09DBE4:
	dc.b	$F4,$02,$C4,$FA,$F1,$10,$F5,$17,$B1,$56,$B4,$5A,$B8,$5D,$B4,$5A
	dc.b	$B6,$5B,$C2,$56,$54,$4F,$4E,$FF

Bank080000_FFTerminatedCommandRecord_09DBFC:
	dc.b	$F4,$02,$C4,$FA,$F1,$0D,$F5,$26,$3E,$42,$3E,$43,$3E,$45,$47,$FF

Bank080000_FFTerminatedCommandRecord_09DC0C:
	dc.b	$F4,$FA,$C4,$F1,$08,$F5,$1E,$4E,$47,$49,$4A,$4E,$47,$49,$4A,$4E
	dc.b	$46,$49,$4A,$4E,$46,$49,$4A,$FF

Bank080000_FFTerminatedCommandRecord_09DC24:
	dc.b	$F4,$FA,$C4,$F1,$08,$F5,$1E,$4C,$45,$47,$49,$4C,$45,$47,$49,$4C
	dc.b	$45,$46,$49,$4C,$45,$46,$49,$FF

Bank080000_FFTerminatedCommandRecord_09DC3C:
	dc.b	$F4,$02,$C4,$F1,$0D,$F5,$1E,$4A,$49,$4A,$48,$4E,$4A,$43,$42,$FF

Bank080000_FFTerminatedCommandRecord_09DC4C:
	dc.b	$F4,$02,$CD,$F1,$10,$F5,$26,$51,$50,$4A,$56,$50,$4A,$FF

; Another longer local-control record reuses the same compact setup bytes seen elsewhere in
; this window, first walking a dense D0/D1 local-target ladder and then ending with a short
; F4/C2 literal-control pocket around the recurring 0x60/0x0F family.
Bank080000_LocalTargetLadderAndLiteralPocketCommandRecord_09DC5A:
Bank080000_FFTerminatedCommandRecord_09DC5A:
	dc.b	$F6,$00,$F7,$0E,$F0,$26,$D0,$93,$DB,$D0,$A3,$DB,$D0,$93,$DB,$D0
	dc.b	$A3,$DB,$D0,$93,$DB,$D0,$B3,$DB,$D0,$CC,$DB,$D0,$A3,$DB,$D0,$CC
	dc.b	$DB,$D0,$B3,$DB,$D0,$93,$DB,$D0,$A3,$DB,$D0,$93,$DB,$D0,$B3,$DB
	dc.b	$D0,$E4,$DB,$D0,$FC,$DB,$D0,$E4,$DB,$D0,$4C,$DC,$F0,$1C,$D0,$0C
	dc.b	$DC,$D0,$24,$DC,$D0,$0C,$DC,$D1,$3C,$DC,$D0,$0C,$DC,$D0,$24,$DC
	dc.b	$D0,$0C,$DC,$D1,$3C,$DC,$F0,$26,$D0,$93,$DB,$D0,$A3,$DB,$D0,$93
	dc.b	$DB,$D0,$B3,$DB,$FD,$66,$DC,$F4,$04,$C2,$F5,$12,$60,$0F,$C5,$FA
	dc.b	$C4,$05,$0D,$C6,$0C,$C2,$60,$05,$FA,$0F,$FA,$FF

; This next pocket keeps the same local neighborhood but narrows into one short 0x05/0x0D
; literal-control pair family, two adjacent 0x60/0x65/0x6C/0x6D burst records, a compact
; local-target sweep, and three neighboring pair-ladder continuations before the local
; setup record at 0x09DE58.
Bank080000_LiteralBurstAndPairLadderCommandFamily_09DCD6:
Bank080000_FFTerminatedCommandRecord_09DCD6:
	dc.b	$F4,$04,$CC,$F5,$12,$05,$FA,$05,$05,$F5,$F6,$0D,$0C,$05,$FA,$05
	dc.b	$05,$11,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09DCEA:
	dc.b	$F4,$04,$C2,$F5,$12,$00,$C5,$FA,$C2,$05,$FA,$F5,$F6,$0D,$FA,$0C
	dc.b	$0D,$0C,$FA,$F5,$0A,$05,$05,$F5,$F6,$05,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09DD06:
	dc.b	$F4,$04,$C2,$F5,$12,$60,$F5,$14,$0F,$FA,$65,$0F,$65,$0F,$F5,$EC
	dc.b	$00,$FA,$F5,$0A,$65,$F5,$F6,$6D,$F5,$14,$10,$F5,$F6,$05,$F5,$F6
	dc.b	$6C,$F5,$14,$0F,$FA,$F5,$EC,$05,$05,$60,$05,$05,$F5,$F6,$05,$FA
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09DD37:
	dc.b	$F4,$04,$C2,$F5,$12,$60,$F5,$14,$0F,$FA,$0F,$0F,$F5,$EC,$65,$F5
	dc.b	$14,$10,$FA,$6F,$F5,$EC,$0D,$F5,$14,$0F,$F5,$EC,$6C,$F5,$14,$0F
	dc.b	$FA,$F5,$EC,$60,$F5,$14,$10,$FA,$F5,$EC,$71,$F5,$14,$0F,$FA,$0F
	dc.b	$FA,$FF

Bank080000_FFTerminatedCommandRecord_09DD69:
	dc.b	$F8,$D1,$C1,$DC,$D4,$C1,$DC,$D0,$06,$DD,$D3,$C1,$DC,$D0,$EA,$DC
	dc.b	$D1,$C1,$DC,$D0,$06,$DD,$D0,$C1,$DC,$D0,$D6,$DC,$D5,$37,$DD,$D1
	dc.b	$06,$DD,$D6,$37,$DD,$D0,$06,$DD,$D2,$C1,$DC,$D0,$D6,$DC,$FD,$6D
	dc.b	$DD,$88,$11,$02,$FF

Bank080000_FFTerminatedCommandRecord_09DD9E:
	dc.b	$D9,$5B,$DB,$5A,$DC,$69,$DD,$00,$00,$F4,$F8,$C4,$F1,$0D,$F5,$17
	dc.b	$2D,$C6,$FA,$C4,$2D,$2D,$C6,$FA,$C4,$2D,$FA,$2D,$FA,$2D,$2D,$C7
	dc.b	$FA,$C4,$2B,$C6,$FA,$C4,$2B,$2B,$C6,$FA,$C4,$2B,$FA,$2B,$FA,$2B
	dc.b	$2B,$FA,$C2,$32,$30,$2F,$2E,$FF

Bank080000_FFTerminatedCommandRecord_09DDD6:
	dc.b	$F4,$F8,$C4,$F1,$0D,$F5,$17,$28,$28,$2F,$2F,$28,$2F,$30,$C7,$32
	dc.b	$C6,$32,$32,$32,$C4,$28,$28,$2F,$2F,$28,$2F,$30,$C7,$2D,$C6,$2D
	dc.b	$2D,$2D,$C4,$28,$28,$2F,$2F,$28,$2F,$30,$C7,$32,$C6,$32,$32,$32
	dc.b	$C4,$28,$28,$2F,$2F,$28,$2F,$30,$C7,$2D,$C6,$2D,$2D,$C2,$32,$30
	dc.b	$2F,$2E,$FF

Bank080000_FFTerminatedCommandRecord_09DE19:
	dc.b	$F4,$F8,$C2,$F1,$0D,$F5,$17,$39,$37,$35,$34,$32,$30,$2F,$2E,$FF

Bank080000_FFTerminatedCommandRecord_09DE29:
	dc.b	$F4,$F8,$C4,$F1,$0D,$F5,$17,$2D,$2B,$39,$34,$2D,$2B,$39,$34,$FF

Bank080000_FFTerminatedCommandRecord_09DE39:
	dc.b	$F4,$F8,$C4,$F1,$0D,$F5,$17,$2D,$2B,$39,$C2,$F1,$10,$3E,$40,$FA
	dc.b	$3C,$3B,$C4,$F1,$0D,$30,$C2,$32,$F5,$0A,$40,$F5,$EC,$2B,$FF

; This nearby bridge reuses the same compact local-target setup shape seen elsewhere in the
; middle command window, then resolves into one short repeated literal row around the
; 0x39/0x3B/0x3C/0x40/0x43 family before FF.
Bank080000_LocalTargetSetupAndLiteralRowCommandRecord_09DE58:
Bank080000_FFTerminatedCommandRecord_09DE58:
	dc.b	$F6,$00,$F7,$01,$F0,$09,$D0,$19,$DE,$D1,$A7,$DD,$D0,$D6,$DD,$D2
	dc.b	$29,$DE,$D0,$39,$DE,$D2,$29,$DE,$D0,$39,$DE,$D0,$D6,$DD,$FD,$61
	dc.b	$DE,$F4,$00,$C2,$F1,$0D,$F5,$21,$39,$3B,$3C,$39,$3B,$40,$3B,$39
	dc.b	$43,$3B,$40,$3B,$3E,$3B,$3C,$3B,$FF

; This nearby singleton keeps the same F4/F1/F5 framing as the two repeated-shape clusters above,
; but its byte-pair payload does not extend into a larger neighboring family yet.
Bank080000_FFTerminatedCommandRecord_09DE91:
	dc.b	$F4,$00,$C2,$F1,$0D,$F5,$21,$3C,$40,$45,$40,$43,$48,$4E,$43,$4C
	dc.b	$48,$43,$40,$3E,$3C,$4C,$47,$FF

Bank080000_FFTerminatedCommandRecord_09DEA9:
	dc.b	$C8,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09DEAC:
	dc.b	$CA,$FA,$FF

; This later record follows the same overall shape: a compact local-target setup prelude,
; then a repeated 0x99/0xA5/0xA6/0xA7 byte-pair ladder with short F5/FB and C2 tails before
; the final FF terminator.
Bank080000_LocalTargetSetupAndHighBytePairLadderCommandRecord_09DEAF:
Bank080000_FFTerminatedCommandRecord_09DEAF:
	dc.b	$F6,$00,$F7,$12,$F0,$26,$D0,$A9,$DE,$D7,$AC,$DE,$D7,$AC,$DE,$D2
	dc.b	$79,$DE,$D0,$91,$DE,$D2,$79,$DE,$D0,$91,$DE,$D7,$AC,$DE,$FD,$B8
	dc.b	$DE,$F4,$08,$C4,$F1,$0D,$F5,$2B,$99,$40,$A5,$4A,$A6,$4B,$A7,$4C
	dc.b	$F5,$F6,$99,$40,$A5,$4A,$A6,$4B,$A7,$4C,$F5,$F6,$99,$40,$A5,$4A
	dc.b	$A6,$4B,$A7,$4C,$99,$40,$F5,$F6,$A5,$4A,$A6,$4B,$A7,$4C,$DA,$F5
	dc.b	$05,$A5,$4A,$A3,$48,$FE,$F5,$05,$99,$3E,$99,$3E,$F5,$F6,$A5,$4A
	dc.b	$A3,$48,$A5,$4A,$A3,$48,$F5,$05,$A5,$4A,$A3,$48,$C2,$F5,$FB,$A0
	dc.b	$47,$9E,$45,$F5,$FB,$9C,$43,$F5,$FB,$9B,$41,$FF

; These adjacent continuations keep the same compact F4/F1/F5 framing but narrow into a
; repeated 0x9x/0xAx high-byte ladder around one recurring `B4 59` anchor, then a shorter
; descending high-byte tail across the same neighborhood.
Bank080000_HighBytePairLadderAndAnchorCommandFamily_09DF2B:
Bank080000_FFTerminatedCommandRecord_09DF2B:
	dc.b	$F4,$08,$CF,$F1,$0F,$F5,$17,$9B,$40,$C4,$F1,$0D,$9B,$40,$9C,$41
	dc.b	$E2,$A8,$9E,$43,$C2,$B4,$59,$B4,$59,$C4,$B4,$59,$CF,$F1,$0F,$9B
	dc.b	$40,$C4,$F1,$0D,$9B,$40,$9A,$3F,$E2,$A8,$99,$3E,$C4,$A3,$48,$A5
	dc.b	$4A,$CF,$F1,$0F,$A7,$4C,$C4,$F1,$0D,$A7,$4C,$A8,$4D,$E2,$A8,$AA
	dc.b	$4F,$C2,$B4,$59,$B4,$59,$C4,$B4,$59,$CF,$F1,$0F,$A7,$4C,$C4,$F1
	dc.b	$0D,$A7,$4C,$A6,$4B,$C7,$A5,$4A,$C6,$A3,$48,$A1,$47,$C2,$9E,$43
	dc.b	$9C,$41,$9B,$40,$9A,$3F,$FF

Bank080000_FFTerminatedCommandRecord_09DF92:
	dc.b	$F4,$08,$C2,$F1,$0D,$F5,$21,$A7,$4D,$A5,$4C,$F5,$FB,$A3,$4A,$A1
	dc.b	$48,$F5,$FB,$A0,$47,$F5,$FB,$9E,$45,$F5,$FB,$9C,$43,$F5,$FB,$9B
	dc.b	$41,$FF

; This adjacent pair keeps the same compact `F4 08` framing as the nearby high-byte ladder family,
; but the first record stays in short `0xAC/0xAB/0xAA` to `0xA7/0xA5/0xA4/0xA3/0xA0` pair sweeps while the
; second tips into a denser descending `0xA7/0xA5/0xA3/0xA1/0xA0/0x9E/0x9C/0x9B` tail.
Bank080000_HighBytePairLadderCommandFamily_09DFB4:
Bank080000_FFTerminatedCommandRecord_09DFB4:
	dc.b	$F4,$08,$C4,$F1,$0D,$F5,$30,$AC,$51,$9E,$43,$F5,$FB,$A0,$45,$AB
	dc.b	$50,$AA,$4F,$F5,$FB,$9E,$43,$A8,$4D,$F5,$FB,$A7,$4C,$F5,$FB,$9C
	dc.b	$41,$F5,$FB,$A3,$48,$A4,$4A,$F5,$FB,$A7,$4C,$A5,$4A,$F5,$FB,$A4
	dc.b	$49,$F5,$FB,$A3,$48,$F5,$FB,$A0,$45,$FF

Bank080000_FFTerminatedCommandRecord_09DFEE:
	dc.b	$F4,$08,$C4,$F1,$0D,$F5,$30,$AC,$51,$9E,$43,$F5,$FB,$A0,$45,$AB
	dc.b	$50,$AA,$4F,$F5,$FB,$9E,$43,$A8,$4D,$F5,$FB,$A7,$4C,$F5,$FB,$9C
	dc.b	$41,$48,$A4,$4A,$F5,$FB,$A5,$4A,$C2,$A7,$4D,$A5,$4C,$A3,$4A,$A1
	dc.b	$48,$A0,$47,$9E,$45,$9C,$43,$9B,$41,$FF
