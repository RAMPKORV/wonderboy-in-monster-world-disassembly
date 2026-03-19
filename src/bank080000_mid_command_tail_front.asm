; ROM range: 0x09A348-0x09C007
; FF-terminated command-record window split into ROM-order slices at every proven
; local terminator. Labels stay structural until the tail-bank command decoder and
; owning subsystem are identified from control flow.

; This tiny lead-in begins with one short tuple before the first true command records settle into
; the same local-control and repeated byte-pair vocabulary that dominates the rest of the front window.
Bank080000_LeadInTupleCommandRecord_09A348:
Bank080000_FFTerminatedCommandRecord_09A348:
	dc.b	$2C,$06,$4D,$A3,$FF

; The next short record keeps only the compact setup/control prelude before handing off to the first
; repeated `F4 25` byte-pair pocket.
Bank080000_LocalControlPreludeCommandRecord_09A34D:
Bank080000_FFTerminatedCommandRecord_09A34D:
	dc.b	$F6,$02,$F7,$02,$F0,$0E,$F1,$0D,$DB,$C0,$27,$30,$FA,$FA,$22,$18
	dc.b	$F5,$08,$FE,$FF

; The first front-window pocket already matches the later `F4 25` family, first as a broader
; `0x97/0x99/0x95` high-byte sweep and then as a neighboring `0xA0/0x9A/0xA1/0x9C` follow-on.
Bank080000_HighBytePairLeadInCommandFamily_09A361:
Bank080000_FFTerminatedCommandRecord_09A361:
	dc.b	$F4,$25,$CA,$F1,$0D,$F5,$06,$97,$F1,$0B,$40,$C8,$95,$3E,$A0,$37
	dc.b	$C9,$F1,$0D,$F5,$FB,$99,$41,$C6,$F5,$0F,$97,$3F,$C8,$F1,$0B,$F5
	dc.b	$F1,$97,$3E,$F5,$0A,$99,$3D,$CA,$F1,$0D,$F5,$FB,$95,$3E,$C8,$97
	dc.b	$3C,$F5,$05,$A2,$39,$CA,$F5,$FB,$9D,$41,$FF

Bank080000_FFTerminatedCommandRecord_09A39C:
	dc.b	$F4,$25,$CA,$F1,$0F,$F5,$06,$A0,$43,$C6,$F1,$0D,$9A,$41,$C4,$A1
	dc.b	$45,$A0,$43,$FA,$9C,$40,$FA,$F5,$14,$9C,$40,$CA,$F1,$0F,$F5,$EC
	dc.b	$A0,$43,$C6,$F1,$0D,$9A,$41,$C4,$A1,$45,$A0,$43,$FA,$F5,$0A,$9D
	dc.b	$41,$9C,$40,$99,$3C,$FF

; These short tails keep the same `F4 25 C8` neighborhood but narrow into compact `0x9E/0xA0`
; pair endings before the longer repeated-byte-pair record at `0x09A3EC`.
Bank080000_HighBytePairLeadInTailCommandFamily_09A3D2:
Bank080000_FFTerminatedCommandRecord_09A3D2:
	dc.b	$F4,$25,$C8,$F1,$0D,$F5,$06,$9E,$3A,$A0,$3A,$FF

Bank080000_FFTerminatedCommandRecord_09A3DE:
	dc.b	$F4,$25,$C8,$F1,$0D,$F5,$01,$9E,$3A,$F5,$FB,$A0,$3A,$FF

; This longer FF-terminated record keeps the same compact command framing as nearby triplets,
; but its payload expands into a larger repeated byte-pair sweep before the terminator.
Bank080000_RepeatedBytePairCommandRecord_09A3EC:
Bank080000_FFTerminatedCommandRecord_09A3EC:
	dc.b	$F4,$25,$C4,$F1,$0D,$F5,$06,$A0,$45,$3E,$3C,$F5,$05,$A0,$45,$3E
	dc.b	$3C,$F5,$05,$A0,$45,$3E,$F5,$FB,$A1,$45,$F5,$FB,$48,$F5,$05,$A1
	dc.b	$45,$C6,$F5,$FB,$9F,$43,$C4,$48,$F5,$05,$43,$F5,$05,$41,$F5,$FB
	dc.b	$A1,$45,$40,$A1,$45,$C6,$F5,$FB,$9E,$41,$C4,$F5,$05,$40,$F5,$FB
	dc.b	$41,$F5,$FB,$43,$F5,$05,$9E,$41,$40,$45,$C6,$F5,$05,$A0,$43,$C4
	dc.b	$F5,$05,$9E,$41,$9C,$40,$3C,$F5,$F6,$A0,$45,$3E,$3C,$F5,$05,$9F
	dc.b	$45,$3E,$3C,$F5,$05,$9E,$45,$3C,$F1,$10,$F5,$F6,$9A,$F1,$0D,$35
	dc.b	$3D,$41,$C6,$F5,$FB,$9E,$43,$C4,$F5,$05,$41,$F5,$05,$40,$3E,$F5
	dc.b	$05,$99,$3C,$C7,$F5,$F6,$9C,$43,$C4,$F5,$0A,$98,$3A,$C7,$F5,$F6
	dc.b	$9C,$42,$C4,$F5,$05,$9D,$41,$F5,$05,$3C,$F5,$FB,$9D,$41,$C6,$F5
	dc.b	$FB,$A0,$43,$C4,$9D,$41,$9C,$40,$99,$3C,$FF

Bank080000_FFTerminatedCommandRecord_09A497:
	; This neighboring record opens with the same compact setup/control prelude seen elsewhere
	; in the command family, then settles into a repeated byte-pair sweep before the final FF.
	dc.b	$F6,$00,$F7,$06,$F0,$04,$D0,$9C,$A3,$D0,$61,$A3,$D0,$D2,$A3,$D0
	dc.b	$61,$A3,$D0,$DE,$A3,$D0,$EC,$A3,$FD,$A0,$A4,$F4,$15,$C4,$F1,$10
	dc.b	$F5,$10,$29,$30,$35,$CF,$3C,$C4,$2B,$32,$35,$3C,$2D,$34,$35,$3C
	dc.b	$26,$2D,$35,$CF,$F1,$0D,$3C,$C4,$F1,$10,$28,$2E,$35,$3C,$2D,$31
	dc.b	$35,$3C,$2E,$32,$35,$CF,$3C,$C4,$2D,$34,$35,$3C,$32,$34,$36,$3C
	dc.b	$2A,$31,$36,$CF,$F5,$FB,$3C,$C4,$2B,$32,$35,$3C,$F5,$FB,$30,$34
	dc.b	$37,$3C,$FF

; This neighboring pocket stays in the same `F4 15` literal-row family as 0x09A497, first
; collapsing into a short `0x29/0x30/0x35/0x3C` burst, then widening into a denser row cycle
; around `0x2D/0x34/0x39/0x3B` and a tiny `0x2A/0x31/0x36/0x3C` cap before a local-seeded
; literal/high-byte bridge.
Bank080000_LiteralRowCycleCommandFamily_09A4FA:
Bank080000_FFTerminatedCommandRecord_09A4FA:
	dc.b	$F4,$15,$C4,$F1,$10,$F5,$10,$29,$30,$35,$CF,$3C,$C4,$2B,$32,$35
	dc.b	$3C,$2D,$34,$35,$3C,$FF

Bank080000_FFTerminatedCommandRecord_09A510:
	dc.b	$F4,$15,$C4,$F1,$10,$F5,$10,$2D,$34,$39,$3B,$3C,$39,$3B,$37,$32
	dc.b	$35,$39,$35,$30,$33,$39,$35,$2E,$32,$35,$C7,$32,$C4,$2E,$2D,$2B
	dc.b	$32,$35,$C6,$30,$2E,$C4,$2B,$29,$34,$35,$3C,$2C,$34,$37,$3C,$2A
	dc.b	$35,$3A,$C6,$2B,$C4,$32,$35,$37,$2D,$34,$37,$3C,$2C,$33,$36,$3C
	dc.b	$2A,$31,$35,$C6,$30,$C4,$2E,$34,$37,$FF

Bank080000_FFTerminatedCommandRecord_09A55A:
	dc.b	$F4,$15,$C4,$F1,$10,$F5,$10,$2A,$31,$36,$CF,$3C,$FF

; The following bridge leaves the row-family pocket and returns to the compact local-seeded
; command shape, ending on a short `0x48/0x4A` literal pair with one local-offset hop.
Bank080000_LocalSeededLiteralHighByteBridgeCommandRecord_09A567:
Bank080000_FFTerminatedCommandRecord_09A567:
	dc.b	$F6,$00,$F7,$01,$F0,$04,$D1,$FA,$A4,$D1,$B2,$A4,$D0,$10,$A5,$FD
	dc.b	$70,$A5,$F4,$02,$E4,$68,$01,$C4,$FA,$FA,$E4,$64,$01,$FA,$FA,$E4
	dc.b	$62,$01,$FA,$FA,$E4,$65,$01,$F1,$10,$F5,$0B,$48,$E4,$68,$01,$4A
	dc.b	$E4,$77,$01,$FF

Bank080000_FFTerminatedCommandRecord_09A59B:
	; The repeated F1/F5 framing here matches the nearby explicit repeated-byte-pair records,
	; but with a denser alternation between C4/C6/C8-style markers and short FA/FB tails.
	dc.b	$F4,$02,$C8,$F1,$10,$F5,$10,$45,$C4,$FA,$F1,$0D,$F5,$0A,$45,$F5
	dc.b	$FB,$45,$F5,$FB,$45,$F1,$10,$45,$C6,$43,$C7,$F5,$05,$41,$C4,$F5
	dc.b	$F6,$48,$4A,$C8,$F5,$05,$45,$C4,$FA,$F1,$0D,$F5,$0A,$45,$F5,$FB
	dc.b	$45,$F5,$FB,$45,$F1,$10,$45,$C6,$43,$41,$F1,$0D,$F5,$05,$48,$C4
	dc.b	$F1,$10,$48,$C8,$F5,$FB,$46,$C4,$FA,$F1,$0D,$46,$F1,$10,$46,$F1
	dc.b	$0D,$F5,$05,$45,$F1,$10,$F5,$F6,$46,$F5,$0A,$45,$FA,$F5,$FB,$43
	dc.b	$FA,$C6,$F1,$0D,$F5,$FB,$48,$C4,$F1,$10,$F5,$05,$48,$C8,$46,$C4
	dc.b	$FA,$46,$F5,$05,$45,$F5,$FB,$46,$FF

; This short follow-on keeps the same `F4 02` neighborhood as 0x09A59B, first as a compact
; `0x48/0x4A/0x4C` literal ladder and then as a tiny `0x49/0x48/0x46` descent.
Bank080000_CompactLiteralLadderCommandFamily_09A614:
Bank080000_FFTerminatedCommandRecord_09A614:
	dc.b	$F4,$02,$C4,$F1,$0D,$F5,$1A,$48,$48,$F5,$FB,$4A,$4A,$F5,$FB,$4C
	dc.b	$FA,$F1,$10,$F5,$FB,$48,$4A,$FF

Bank080000_FFTerminatedCommandRecord_09A62C:
	dc.b	$F4,$02,$C6,$F1,$10,$F5,$10,$49,$C4,$48,$C7,$46,$C6,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09A63B:
	; This larger record keeps the same local setup bytes and repeated byte-pair body, but it
	; also carries a denser front control pocket with multiple same-window target-like triples.
	dc.b	$F6,$00,$F7,$08,$F0,$1C,$CA,$FA,$FA,$FA,$D0,$79,$A5,$D0,$9B,$A5
	dc.b	$D0,$14,$A6,$D0,$9B,$A5,$D0,$2C,$A6,$CA,$DE,$FA,$FE,$FD,$45,$A6
	dc.b	$F4,$11,$C9,$FA,$C4,$F1,$10,$F5,$10,$45,$F5,$FB,$46,$C8,$F5,$FB
	dc.b	$48,$40,$F5,$05,$41,$C4,$FA,$F5,$F6,$41,$F5,$05,$40,$3E,$C6,$3A
	dc.b	$C4,$FA,$F5,$05,$3A,$FA,$F5,$05,$43,$F5,$FB,$45,$F5,$FB,$46,$F5
	dc.b	$FB,$4A,$F5,$05,$48,$45,$C7,$F5,$05,$48,$C4,$45,$F5,$FB,$46,$C8
	dc.b	$48,$4C,$C4,$F5,$FB,$4D,$F5,$05,$4C,$FA,$F5,$05,$4A,$FA,$F5,$05
	dc.b	$4A,$F5,$FB,$4C,$F5,$FB,$4D,$4F,$F5,$0A,$4A,$F5,$FB,$4C,$F5,$FB
	dc.b	$4D,$4F,$F5,$0A,$4A,$F5,$FB,$4C,$F5,$FB,$4D,$C5,$F5,$FB,$51,$C2
	dc.b	$FA,$C4,$F5,$05,$51,$C7,$F5,$05,$4F,$C6,$FA,$FF

; This run returns to the same compact local-control plus literal-control neighborhood seen later
; in the tail window, but here the payload leans heavily on `0x60/0x61/0x00/0x05/0x0F/0x01` bursts.
Bank080000_LiteralControlBurstCommandFamily_09A6D7:
Bank080000_FFTerminatedCommandRecord_09A6D7:
	dc.b	$F6,$00,$F7,$08,$F0,$01,$CA,$DB,$FA,$FE,$CA,$DB,$FA,$FE,$DF,$FA
	dc.b	$FE,$FA,$FA,$FA,$D0,$5B,$A6,$FD,$E1,$A6,$F4,$00,$C4,$F5,$12,$60
	dc.b	$F5,$14,$01,$FA,$01,$FA,$01,$FA,$01,$01,$F5,$EC,$00,$F5,$14,$01
	dc.b	$F5,$EC,$05,$F5,$14,$01,$F5,$EC,$60,$F5,$14,$01,$FA,$F5,$EC,$05
	dc.b	$FA,$60,$F5,$14,$01,$FA,$01,$FA,$01,$01,$FA,$01,$F5,$EC,$00,$F5
	dc.b	$14,$01,$05,$01,$F5,$EC,$60,$F5,$14,$01,$05,$F5,$F6,$05,$C2,$F5
	dc.b	$F6,$05,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09A73B:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$F5,$14,$01,$FA,$F5,$F6,$0F,$FA,$C4,$F5
	dc.b	$0A,$61,$F5,$EC,$05,$F5,$0A,$0F,$C2,$F5,$0A,$01,$C5,$FA,$C6,$61
	dc.b	$F5,$EC,$05,$C4,$00,$C2,$F5,$14,$01,$FA,$C4,$F5,$EC,$05,$C2,$F5
	dc.b	$14,$01,$FA,$F5,$EC,$60,$F5,$14,$01,$C5,$FA,$C6,$F5,$EC,$05,$FF

Bank080000_FFTerminatedCommandRecord_09A77B:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$F5,$14,$01,$FA,$C4,$F5,$F6,$0F,$F5,$0A
	dc.b	$61,$F5,$EC,$05,$F5,$0A,$0F,$C2,$F5,$0A,$01,$FA,$01,$FA,$C4,$61
	dc.b	$F5,$EC,$05,$C2,$01,$FA,$C4,$00,$C2,$F5,$14,$01,$FA,$C4,$F5,$EC
	dc.b	$05,$C2,$F5,$14,$01,$FA,$F5,$EC,$60,$F5,$14,$61,$F5,$EC,$05,$05
	dc.b	$C4,$05,$05,$05,$FF

Bank080000_FFTerminatedCommandRecord_09A7C0:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$F5,$14,$01,$FA,$0F,$FA,$C4,$61,$F5,$EC
	dc.b	$05,$F5,$14,$0F,$C2,$01,$FA,$C4,$0F,$61,$F5,$EC,$05,$F5,$14,$0F
	dc.b	$F5,$EC,$00,$F5,$14,$0F,$F5,$EC,$05,$F5,$14,$0F,$C2,$F5,$EC,$60
	dc.b	$F5,$14,$01,$FA,$C4,$0F,$F5,$EC,$05,$F5,$14,$0F,$FF

; This bridge returns to the denser local-target style before handing off to a compact `F4 F8`
; literal-pair family rooted on `0x29/0x28/0x35/0x2F/0x36/0x37`.
Bank080000_LocalTargetSweepAndLiteralPairCommandFamily_09A7FD:
Bank080000_FFTerminatedCommandRecord_09A7FD:
	dc.b	$F8,$D0,$F1,$A6,$D0,$F1,$A6,$D0,$3B,$A7,$D0,$7B,$A7,$D2,$C0,$A7
	dc.b	$D0,$7B,$A7,$D3,$C0,$A7,$FD,$01,$A8,$88,$77,$01,$97,$A4,$67,$A5
	dc.b	$3B,$A6,$D7,$A6,$FD,$A7,$00,$00,$F4,$F8,$C4,$F1,$0D,$F5,$17,$29
	dc.b	$29,$28,$C8,$FA,$C4,$35,$29,$29,$28,$C6,$FA,$C4,$35,$29,$35,$FF

Bank080000_FFTerminatedCommandRecord_09A83D:
	dc.b	$F4,$F8,$C4,$F1,$0D,$F5,$17,$28,$34,$28,$C8,$FA,$C4,$2F,$28,$34
	dc.b	$C6,$FA,$C0,$F1,$10,$36,$E2,$1E,$37,$C2,$FA,$C4,$F1,$0D,$28,$2F
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09A85E:
	dc.b	$F4,$F8,$C4,$F1,$0D,$F5,$17,$28,$28,$C9,$FA,$C4,$F1,$10,$30,$C7
	dc.b	$2F,$C4,$2D,$FA,$2B,$FA,$FF

; This neighboring pocket revisits the same local-control sweep framing as 0x09A6D7, then widens
; into a longer `F4 11` literal/high-byte run around `0x43/0x41/0x40/0x3C/0x39/0x45/0x48/0x4A/0x4C`.
Bank080000_LocalControlAndLiteralHighByteLadderCommandRecord_09A875:
Bank080000_FFTerminatedCommandRecord_09A875:
	dc.b	$F6,$00,$F7,$01,$F0,$09,$CA,$DB,$FA,$FE,$CA,$DB,$FA,$FE,$DB,$FA
	dc.b	$FE,$D0,$25,$A8,$D0,$3D,$A8,$D0,$25,$A8,$D0,$5E,$A8,$CA,$DF,$FA
	dc.b	$FE,$FD,$7F,$A8,$F4,$11,$C4,$F1,$0A,$F5,$FC,$43,$FA,$F5,$0F,$43
	dc.b	$FA,$F5,$05,$43,$FA,$F5,$F6,$43,$F5,$F6,$43,$C6,$FA,$C4,$F5,$0A
	dc.b	$41,$F5,$05,$40,$C6,$FA,$C4,$F5,$F1,$43,$45,$C9,$F1,$0B,$F5,$0A
	dc.b	$43,$C4,$FA,$F1,$0A,$F5,$0A,$3C,$FA,$F5,$EC,$39,$38,$F5,$05,$39
	dc.b	$3C,$F5,$05,$39,$F5,$FB,$43,$F5,$05,$40,$C6,$F5,$F6,$41,$C7,$FA
	dc.b	$C4,$F5,$0F,$41,$F5,$FB,$45,$F5,$FB,$48,$C6,$F5,$FB,$4C,$C4,$F5
	dc.b	$0A,$4A,$C6,$48,$C4,$FA,$C6,$4A,$C8,$F1,$0B,$F5,$F6,$47,$FA,$FF

; These adjacent records keep the same compact `F4 11` front but narrow into shorter `0x4C/0x4D/0x4F/0x51`
; literal ladders, then a denser local-control bridge revisits the same neighborhood with small E2/E3 hops.
Bank080000_LiteralLadderAndLocalControlCommandFamily_09A905:
Bank080000_FFTerminatedCommandRecord_09A905:
	dc.b	$F4,$11,$C8,$FA,$C4,$F1,$0D,$F5,$06,$4C,$F5,$0A,$4D,$F5,$0A,$4F
	dc.b	$51,$F5,$F4,$4C,$F5,$08,$4D,$F5,$0C,$4F,$51,$F5,$FC,$4C,$F5,$04
	dc.b	$4D,$F5,$04,$4F,$51,$FF

Bank080000_FFTerminatedCommandRecord_09A92B:
	dc.b	$F6,$00,$F7,$09,$F0,$27,$CA,$D9,$FA,$FE,$FA,$FA,$D0,$05,$A9,$CA
	dc.b	$FA,$FA,$D0,$05,$A9,$CA,$DF,$FA,$FE,$FA,$FA,$D0,$99,$A8,$FD,$35
	dc.b	$A9,$F4,$00,$C4,$F1,$10,$F5,$21,$4C,$4D,$F5,$FB,$4F,$F5,$FB,$51
	dc.b	$CA,$F5,$0A,$4C,$C4,$4A,$C7,$48,$C4,$F5,$F6,$4F,$E3,$08,$01,$F5
	dc.b	$05,$4A,$C6,$F5,$FB,$48,$F5,$0A,$47,$C4,$4C,$4D,$F5,$FB,$4F,$F5
	dc.b	$FB,$51,$E2,$F0,$F5,$0A,$4C,$C6,$F5,$F6,$54,$C4,$53,$C6,$FA,$E3
	dc.b	$38,$01,$F5,$0A,$4F,$FF

Bank080000_FFTerminatedCommandRecord_09A991:
	dc.b	$F6,$00,$F7,$08,$F0,$02,$CA,$DB,$FA,$FE,$D1,$4C,$A9,$CA,$DF,$FA
	dc.b	$FE,$FD,$9B,$A9,$F4,$05,$C6,$FA,$C4,$F1,$10,$F5,$21,$39,$35,$C8
	dc.b	$FA,$C6,$FA,$C4,$40,$3C,$C6,$FA,$C4,$4C,$48,$FA,$48,$FA,$43,$FA
	dc.b	$41,$FA,$40,$FA,$37,$FA,$34,$FA,$30,$FA,$2F,$FF

Bank080000_FFTerminatedCommandRecord_09A9CD:
	dc.b	$F4,$05,$C4,$F1,$10,$F5,$21,$47,$FA,$4A,$45,$FA,$4A,$45,$4A,$FF

Bank080000_FFTerminatedCommandRecord_09A9DD:
	dc.b	$F4,$05,$C4,$F1,$10,$F5,$21,$47,$FA,$4A,$43,$FA,$4A,$43,$4A,$FF

; This longer follow-on keeps the same compact local-control front but then steps through an
; explicit E4-tagged local-offset ladder with eight short 4-byte literal rows.
Bank080000_LocalControlAndLocalOffsetLadderCommandRecord_09A9ED:
Bank080000_FFTerminatedCommandRecord_09A9ED:
	dc.b	$F6,$00,$F7,$06,$F0,$1D,$CA,$DB,$FA,$FE,$CA,$DB,$FA,$FE,$D1,$CD
	dc.b	$A9,$D1,$DD,$A9,$D1,$CD,$A9,$D1,$DD,$A9,$D1,$CD,$A9,$D1,$DD,$A9
	dc.b	$D1,$CD,$A9,$D1,$DD,$A9,$D1,$CD,$A9,$D1,$DD,$A9,$FD,$F7,$A9,$F4
	dc.b	$05,$C4,$F1,$10,$F5,$21,$E4,$DD,$01,$29,$30,$3C,$39,$E4,$DA,$01
	dc.b	$41,$3C,$45,$3C,$E4,$D7,$01,$48,$41,$45,$41,$E4,$D4,$01,$4D,$48
	dc.b	$54,$51,$E4,$D0,$01,$53,$4C,$4F,$47,$E4,$D4,$01,$4C,$45,$48,$43
	dc.b	$E4,$D7,$01,$40,$3B,$3E,$37,$E4,$DA,$01,$3B,$34,$37,$28,$FF

; This neighboring bridge returns to the compact local-control framing, then narrows into two
; short `F4 08` literal-control rows around `0x00/0x0C/0x05/0x60` before the next repeated
; high-byte pair pocket.
Bank080000_LocalControlSweepAndLiteralControlCommandFamily_09AA5C:
Bank080000_FFTerminatedCommandRecord_09AA5C:
	dc.b	$F6,$00,$F7,$16,$F0,$1D,$D6,$1C,$AA,$FD,$62,$AA,$F4,$08,$C4,$F5
	dc.b	$12,$00,$C7,$FA,$C4,$0C,$FA,$05,$00,$00,$C7,$FA,$C4,$0C,$0C,$05
	dc.b	$0C,$FF

Bank080000_FFTerminatedCommandRecord_09AA7E:
	dc.b	$F4,$08,$C4,$F5,$12,$0C,$C6,$FA,$C4,$00,$C6,$FA,$C4,$0C,$FA,$FA
	dc.b	$00,$C6,$FA,$C2,$60,$0D,$0D,$0D,$CE,$FA,$FF

; The next pocket shifts back into the repeated high-byte pair neighborhood already seen around
; `0x8D/0x39`, `0x8C/0x38`, and `0x88/0x34`, first behind a compact local-control prelude and
; then as a denser follow-on ladder that grows into the neighboring `0x93/0x3F` plus `0x94/0x40`
; sweep before the explicit 0x18-byte triplet.
Bank080000_LocalControlSweepAndHighBytePairCommandFamily_09AA99:
Bank080000_FFTerminatedCommandRecord_09AA99:
	dc.b	$F8,$CA,$DB,$FA,$FE,$CA,$DB,$FA,$FE,$DB,$FA,$FE,$D2,$68,$AA,$D0
	dc.b	$7E,$AA,$CA,$DF,$FA,$FE,$FD,$9E,$AA,$88,$DD,$01,$75,$A8,$2B,$A9
	dc.b	$91,$A9,$ED,$A9,$5C,$AA,$99,$AA,$00,$00,$F4,$00,$F2,$00,$F4,$C6
	dc.b	$F1,$0D,$F5,$17,$8D,$39,$8C,$38,$88,$34,$8D,$39,$8C,$38,$88,$34
	dc.b	$87,$33,$88,$34,$FF

Bank080000_HighBytePairLadderCommandRecord_09AADE:
Bank080000_FFTerminatedCommandRecord_09AADE:
	dc.b	$F4,$00,$C6,$F1,$0D,$F5,$17,$8D,$39,$8C,$38,$88,$34,$8D,$39,$C4
	dc.b	$8F,$3B,$8C,$38,$8D,$39,$88,$34,$C0,$F1,$10,$93,$3F,$94,$40,$F5
	dc.b	$05,$93,$3F,$94,$40,$F5,$05,$93,$3F,$F5,$05,$94,$40,$93,$3F,$F5
	dc.b	$FB,$94,$40,$93,$3F,$F5,$FB,$94,$40,$93,$3F,$F5,$FB,$94,$40,$93
	dc.b	$3F,$F5,$FB,$94,$40,$93,$3F,$F5,$FB,$94,$40,$FF

; Three adjacent 0x18-byte records share the same compact F4/F1/F5 header shape followed by
; repeated tile-like byte pairs, so keep the family explicit instead of hiding it in raw slices.
Bank080000_RepeatedTwentyFourByteCommandRecordTriplet_09AB2A:
Bank080000_FFTerminatedCommandRecord_09AB2A:
	dc.b	$F4,$00,$C6,$F1,$0D,$F5,$17,$92,$3E,$91,$3D,$8D,$39,$92,$3E,$91
	dc.b	$3D,$8D,$39,$8C,$38,$8D,$39,$FF

Bank080000_FFTerminatedCommandRecord_09AB42:
	dc.b	$F4,$00,$C4,$F1,$0A,$F5,$17,$8D,$39,$8C,$38,$A5,$4C,$A5,$4C,$8D
	dc.b	$39,$8C,$38,$A7,$4D,$A7,$4D,$FF

Bank080000_FFTerminatedCommandRecord_09AB5A:
	dc.b	$F4,$00,$C4,$F1,$0A,$F5,$17,$8F,$3B,$8E,$3A,$A7,$4E,$A7,$4E,$8F
	dc.b	$3B,$8E,$3A,$A9,$4F,$A9,$4F,$FF

Bank080000_FFTerminatedCommandRecord_09AB72:
	; This short continuation keeps the same F4/F1/F5 framing as the preceding 0x18-byte triplet
	; family, but expands into one compact follow-on repeated byte-pair sweep.
	dc.b	$F4,$00,$C4,$F1,$0A,$F5,$17,$8F,$3B,$8E,$3A,$A7,$4E,$A7,$4E,$C2
	dc.b	$F1,$0C,$99,$40,$A5,$4A,$98,$3F,$A4,$49,$97,$3E,$A3,$48,$96,$3D
	dc.b	$A2,$47,$FF

Bank080000_FFTerminatedCommandRecord_09AB95:
	; Like 0x09A497, this record starts with a compact setup/control prelude before the final
	; repeated byte-pair payload and its closing FF terminator.
	dc.b	$F6,$00,$F7,$01,$F0,$23,$D1,$C3,$AA,$D2,$C3,$AA,$D0,$DE,$AA,$D0
	dc.b	$2A,$AB,$D1,$42,$AB,$D0,$2A,$AB,$D0,$5A,$AB,$D0,$72,$AB,$FD,$9E
	dc.b	$AB,$F4,$00,$C4,$F1,$10,$F5,$17,$40,$41,$44,$45,$CA,$40,$C4,$3E
	dc.b	$C7,$3C,$CA,$44,$C8,$40,$C6,$48,$4A,$C4,$4C,$4D,$50,$51,$E2,$F0
	dc.b	$4C,$C6,$54,$C4,$53,$FA,$50,$E3,$38,$01,$4C,$FF

; This short follow-on keeps the same compact F4/F1/F5 framing as the neighboring pair-sweep
; record, but narrows into a repeated literal rise around `0x4A/0x49/0x4D/0x4F/0x51`.
Bank080000_RepeatedLiteralRiseCommandRecord_09ABE1:
Bank080000_FFTerminatedCommandRecord_09ABE1:
	dc.b	$F4,$00,$C4,$F1,$10,$F5,$12,$4A,$49,$4A,$C6,$4D,$C4,$4A,$4D,$4A
	dc.b	$4F,$4D,$4F,$51,$C8,$4A,$FF

Bank080000_FFTerminatedCommandRecord_09ABF8:
	dc.b	$F4,$00,$C8,$FA,$C2,$F1,$10,$F5,$17,$54,$53,$52,$51,$50,$4F,$4E
	dc.b	$4D,$FF

; This neighboring bridge returns to a local-control prelude, then spends its payload on one
; broader `F4 14` literal sweep that climbs from `0x34/0x35` through `0x53/0x54` before descending.
Bank080000_LocalControlAndLiteralSweepCommandRecord_09AC0A:
Bank080000_FFTerminatedCommandRecord_09AC0A:
	dc.b	$F6,$00,$F7,$02,$F0,$02,$CA,$DB,$FA,$FE,$D0,$B6,$AB,$D0,$E1,$AB
	dc.b	$CA,$FA,$FA,$D0,$E1,$AB,$CA,$FA,$D0,$F8,$AB,$FD,$14,$AC,$F4,$14
	dc.b	$C2,$F1,$0C,$F5,$17,$34,$35,$38,$39,$3B,$3E,$40,$3B,$39,$38,$41
	dc.b	$47,$4A,$4C,$4D,$50,$51,$53,$54,$53,$51,$50,$4C,$48,$47,$45,$44
	dc.b	$40,$3E,$3C,$3B,$38,$FF

; The following family stays in the same `F4 14` neighborhood: first as a short repeated `0x56`
; burst, then as mirrored high-byte/literal sweeps around `0xA1-0xA7`, and finally with a short
; descending literal tail at `0x47-0x40`.
Bank080000_LiteralHighByteSweepCommandFamily_09AC50:
Bank080000_FFTerminatedCommandRecord_09AC50:
	dc.b	$F4,$14,$C4,$F1,$0D,$F5,$12,$56,$FA,$56,$FA,$56,$FA,$56,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09AC60:
	dc.b	$F4,$14,$C2,$F1,$10,$F5,$12,$A1,$45,$A2,$46,$A3,$47,$A4,$48,$A5
	dc.b	$49,$A4,$48,$A3,$47,$A2,$46,$C4,$A1,$45,$AC,$51,$A1,$45,$AC,$51
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09AC81:
	dc.b	$F4,$14,$C2,$F1,$10,$F5,$12,$A3,$47,$A4,$48,$A5,$49,$A6,$4A,$A7
	dc.b	$4B,$A6,$4A,$A5,$49,$A4,$48,$C4,$A3,$47,$AE,$53,$A3,$47,$AE,$53
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09ACA2:
	dc.b	$F4,$14,$C2,$F1,$10,$F5,$12,$A3,$47,$A4,$48,$A5,$49,$A6,$4A,$A7
	dc.b	$4B,$A6,$4A,$A5,$49,$A4,$48,$F1,$0E,$F5,$FD,$47,$46,$45,$44,$F5
	dc.b	$FA,$43,$42,$F5,$FD,$41,$40,$FF

; This bridge shifts back to compact local control, then narrows into one short `F4 0C`
; literal-control pocket around `0x00/0x05` before the denser neighboring rows.
Bank080000_LocalControlAndLiteralControlCommandRecord_09ACCA:
Bank080000_FFTerminatedCommandRecord_09ACCA:
	dc.b	$F6,$00,$F7,$1C,$F0,$1D,$D1,$28,$AC,$D3,$28,$AC,$D1,$50,$AC,$D1
	dc.b	$60,$AC,$D1,$50,$AC,$D0,$81,$AC,$D0,$A2,$AC,$FD,$D3,$AC,$F4,$0C
	dc.b	$C6,$F5,$06,$00,$05,$00,$05,$FF

; The next three short records keep the same `F4 0C` row family, varying only how the
; `0x00/0x05/0x0D/0x0C` literal-control cells are arranged before FF.
Bank080000_LiteralControlRowCommandFamily_09ACF2:
Bank080000_FFTerminatedCommandRecord_09ACF2:
	dc.b	$F4,$0C,$C4,$F5,$06,$00,$FA,$C2,$05,$FA,$05,$05,$0D,$0D,$0D,$0C
	dc.b	$0C,$FA,$05,$05,$FF

Bank080000_FFTerminatedCommandRecord_09AD07:
	dc.b	$F4,$0C,$C4,$F5,$06,$00,$FA,$0D,$0C,$00,$FA,$05,$0C,$00,$FA,$0D
	dc.b	$0C,$C6,$FA,$C4,$05,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09AD1E:
	dc.b	$F4,$0C,$C4,$F5,$06,$00,$00,$05,$05,$00,$FA,$05,$FA,$FF

; This neighboring pocket returns to a local-seeded prelude, then widens into a compact `F4 1A`
; ladder that repeatedly revisits `0x34/0x32/0x2F` before the later short literal caps.
Bank080000_LocalSeededLiteralPairLadderCommandRecord_09AD2C:
Bank080000_FFTerminatedCommandRecord_09AD2C:
	dc.b	$F8,$D3,$E8,$AC,$D3,$E8,$AC,$D2,$E8,$AC,$D0,$F2,$AC,$D0,$07,$AD
	dc.b	$D1,$1E,$AD,$D0,$07,$AD,$D0,$1E,$AD,$D0,$F2,$AC,$FD,$30,$AD,$88
	dc.b	$DD,$01,$95,$AB,$0A,$AC,$CA,$AC,$2C,$AD,$00,$00,$F4,$1A,$C4,$F1
	dc.b	$0D,$F5,$FC,$34,$34,$C6,$FA,$C4,$35,$35,$C6,$FA,$C4,$34,$34,$C7
	dc.b	$FA,$C6,$32,$C4,$32,$FF

Bank080000_FFTerminatedCommandRecord_09AD72:
	dc.b	$F4,$1A,$C4,$F1,$0D,$F5,$06,$34,$2F,$34,$C6,$FA,$C4,$32,$2F,$32
	dc.b	$34,$2F,$34,$C6,$FA,$C4,$32,$C2,$FA,$C4,$32,$C2,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09AD90:
	dc.b	$F4,$1A,$C4,$F1,$0D,$F5,$06,$32,$32,$C6,$FA,$C4,$32,$32,$3C,$3E
	dc.b	$32,$32,$C7,$FA,$C2,$F1,$0C,$F5,$F6,$2F,$C4,$FA,$F1,$0D,$2F,$C2
	dc.b	$FA,$FF

Bank080000_FFTerminatedCommandRecord_09ADB2:
	dc.b	$F4,$1A,$C4,$F1,$0D,$F5,$06,$34,$34,$C6,$FA,$C4,$34,$34,$37,$39
	dc.b	$34,$34,$C7,$FA,$C2,$F1,$0C,$2F,$C4,$FA,$C5,$F1,$0D,$2F,$FF

Bank080000_FFTerminatedCommandRecord_09ADD1:
	dc.b	$F4,$1A,$CA,$F1,$10,$F5,$FC,$34,$34,$32,$CF,$32,$C4,$F1,$0D,$30
	dc.b	$32,$33,$FF

; This late follow-on returns to compact local control, then narrows into an `F4 0E` literal/
; high-byte ladder around `0x47/0x4A/0x48/0x4C/0x45/0x41` before the next shorter records.
Bank080000_LocalControlAndLiteralHighByteLadderCommandRecord_09ADE4:
Bank080000_FFTerminatedCommandRecord_09ADE4:
	dc.b	$F6,$00,$F7,$01,$F0,$09,$D1,$58,$AD,$D1,$72,$AD,$D0,$D1,$AD,$D0
	dc.b	$B2,$AD,$D0,$90,$AD,$FD,$E4,$AD,$F4,$0E,$C4,$F1,$10,$F5,$17,$47
	dc.b	$4A,$48,$C6,$47,$C4,$4C,$4A,$48,$C2,$47,$48,$47,$45,$C0,$46,$E2
	dc.b	$42,$47,$C4,$45,$41,$45,$47,$4A,$48,$C6,$47,$C4,$4C,$4A,$48,$C8
	dc.b	$47,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09AE27:
	dc.b	$F4,$0E,$C6,$FA,$C4,$F1,$10,$F5,$21,$A3,$47,$4C,$A5,$4A,$A1,$45
	dc.b	$47,$A0,$43,$FF

Bank080000_FFTerminatedCommandRecord_09AE3B:
	dc.b	$F4,$0E,$CF,$F1,$10,$F5,$17,$4C,$C2,$4A,$4C,$C4,$4D,$4F,$CF,$4C
	dc.b	$C2,$4A,$48,$C4,$47,$45,$FF

Bank080000_FFTerminatedCommandRecord_09AE52:
	dc.b	$F4,$0E,$CF,$F1,$10,$F5,$17,$4A,$C2,$48,$4A,$C4,$4B,$4D,$CF,$4A
	dc.b	$C4,$48,$4A,$4B,$FF

Bank080000_FFTerminatedCommandRecord_09AE67:
	dc.b	$F4,$0E,$CF,$F1,$10,$F5,$17,$4A,$C2,$48,$4A,$C4,$4B,$4D,$C9,$4A
	dc.b	$C4,$49,$48,$FF

; This front-edge tail returns to a local-control prelude, then settles into a broader `F4 11`
; literal family around repeated `0x53/0x4D/0x56/0x54` rows before the denser `0x5F` follow-on.
Bank080000_LocalControlAndLiteralRowCommandRecord_09AE7B:
Bank080000_FFTerminatedCommandRecord_09AE7B:
	dc.b	$F6,$00,$F7,$06,$F2,$00,$E8,$F0,$0A,$D0,$FC,$AD,$CA,$FA,$FA,$FA
	dc.b	$D0,$27,$AE,$D0,$3B,$AE,$D0,$52,$AE,$D0,$3B,$AE,$D0,$67,$AE,$FD
	dc.b	$7B,$AE,$F4,$11,$C2,$FA,$F1,$09,$F5,$17,$53,$4D,$53,$56,$54,$53
	dc.b	$4A,$FA,$4C,$4D,$4A,$53,$51,$4A,$4C,$FA,$53,$4D,$53,$56,$54,$53
	dc.b	$4A,$FA,$53,$4D,$53,$56,$54,$53,$4A,$FF

Bank080000_LiteralRowAnd5FControlCommandRecord_09AEC5:
Bank080000_FFTerminatedCommandRecord_09AEC5:
	dc.b	$F4,$11,$C2,$FA,$F1,$0C,$F5,$17,$51,$4D,$53,$FA,$4A,$56,$C4,$FA
	dc.b	$C2,$F1,$0D,$53,$59,$F5,$F6,$5F,$F5,$0A,$53,$58,$F5,$F6,$5F,$F5
	dc.b	$0A,$53,$FA,$F1,$0C,$51,$4D,$53,$FA,$4A,$56,$C4,$FA,$C2,$F5,$F6
	dc.b	$5F,$F5,$0A,$4D,$53,$59,$53,$4D,$F5,$F6,$5F,$FA,$F5,$0A,$51,$4D
	dc.b	$53,$FA,$4A,$56,$C4,$FA,$C2,$F1,$0D,$53,$59,$F5,$F6,$5F,$F5,$0A
	dc.b	$53,$58,$F5,$F6,$5F,$F5,$0A,$53,$FA,$F1,$0C,$51,$4D,$53,$C9,$FA
	dc.b	$FF

; This neighboring `F4 11` tail keeps the same literal-row neighborhood as 0x09AEC5, first as a
; compact `0x4C/0x4F/0x53/0x54/0x51/0x4D` sweep and then with one short `0x5F`-gated variation.
Bank080000_LiteralRowTailCommandFamily_09AF26:
Bank080000_FFTerminatedCommandRecord_09AF26:
	dc.b	$F4,$11,$C4,$F1,$0D,$F5,$17,$4C,$C2,$F1,$0C,$4F,$53,$FA,$54,$53
	dc.b	$4F,$C4,$F1,$0D,$51,$C2,$F1,$0C,$4D,$C5,$F1,$0D,$51,$C4,$4D,$FF

Bank080000_FFTerminatedCommandRecord_09AF46:
	dc.b	$F4,$11,$C4,$F1,$0D,$F5,$17,$4C,$C2,$F1,$0C,$4F,$53,$FA,$54,$53
	dc.b	$4F,$C4,$F1,$0D,$F5,$FB,$5F,$C2,$F1,$0C,$F5,$05,$4D,$C5,$F1,$0D
	dc.b	$53,$C4,$F5,$FB,$5F,$FF

; This bridge returns to compact local control, then widens into an `F4 04` literal/high-byte ladder
; around `0x44/0x45/0x46/0x47/0x48/0x4A` before a short E2-tagged handoff.
Bank080000_LocalControlAndLiteralHighByteLadderCommandRecord_09AF6C:
Bank080000_FFTerminatedCommandRecord_09AF6C:
	dc.b	$F6,$00,$F7,$08,$F2,$00,$F4,$F0,$26,$D1,$9D,$AE,$D0,$C5,$AE,$CA
	dc.b	$DB,$FA,$FE,$D2,$26,$AF,$D0,$46,$AF,$FD,$6C,$AF,$F4,$04,$CF,$FA
	dc.b	$C4,$F1,$10,$F5,$17,$44,$45,$46,$CF,$47,$C4,$45,$41,$45,$C8,$47
	dc.b	$C4,$FA,$44,$45,$46,$CF,$47,$C0,$45,$46,$C2,$47,$C4,$48,$4A,$C2
	dc.b	$47,$48,$47,$C0,$45,$44,$45,$46,$E2,$84,$47,$FF

Bank080000_FFTerminatedCommandRecord_09AFB8:
	dc.b	$F4,$04,$CA,$FA,$FF

; The following `F4 0D` family shifts back into literal-control rows around
; `0x60/0x08/0x00/0x6C/0x12/0x0D/0x07`, first behind a compact local-control prelude and then as
; a few shorter variations that add repeated `0x05` and `0x65` pockets.
Bank080000_LocalControlAndLiteralControlRowCommandFamily_09AFBD:
Bank080000_FFTerminatedCommandRecord_09AFBD:
	dc.b	$F6,$00,$F7,$06,$F0,$02,$D2,$B8,$AF,$D0,$88,$AF,$D7,$B8,$AF,$FD
	dc.b	$BD,$AF,$F4,$0D,$C2,$F5,$12,$60,$08,$FA,$00,$C5,$FA,$C2,$6C,$12
	dc.b	$0D,$00,$12,$60,$12,$C4,$FA,$C2,$08,$08,$FA,$60,$08,$FA,$00,$C5
	dc.b	$FA,$C2,$12,$12,$08,$08,$00,$FA,$0D,$0D,$60,$6C,$07,$6C,$07,$FF

Bank080000_FFTerminatedCommandRecord_09AFFD:
	dc.b	$F4,$0D,$C2,$F5,$12,$60,$08,$FA,$00,$FA,$C4,$00,$C2,$6C,$12,$0D
	dc.b	$00,$12,$60,$6C,$12,$0D,$00,$08,$6C,$08,$0D,$60,$08,$FA,$00,$FA
	dc.b	$C4,$11,$C2,$12,$12,$08,$08,$60,$0C,$0D,$FA,$00,$07,$07,$FF

Bank080000_FFTerminatedCommandRecord_09B02C:
	dc.b	$F4,$0D,$C2,$F5,$12,$60,$08,$FA,$00,$FA,$C4,$F5,$F6,$05,$C2,$F5
	dc.b	$0A,$6C,$12,$0D,$00,$12,$60,$12,$FA,$F5,$F6,$05,$F5,$0A,$08,$C4
	dc.b	$F5,$F6,$65,$F5,$0A,$08,$C2,$60,$08,$FA,$00,$FA,$C4,$F5,$F6,$65
	dc.b	$F5,$0A,$0C,$C2,$12,$12,$08,$08,$00,$FA,$0D,$0D,$60,$6C,$07,$6C
	dc.b	$07,$FF

Bank080000_FFTerminatedCommandRecord_09B06E:
	dc.b	$F4,$0D,$C2,$F5,$12,$08,$CE,$FA,$C2,$12,$C4,$FA,$C2,$12,$12,$C4
	dc.b	$FA,$C2,$08,$08,$FA,$08,$CE,$FA,$C2,$12,$12,$08,$08,$C6,$FA,$C2
	dc.b	$07,$07,$FF

; This bridge returns to the compact local-control framing, then settles into one short
; literal-row pocket around `0x30/0x33/0x36/0x3A/0x39/0x37` before the next related row tails.
Bank080000_LocalControlAndLiteralRowPocketCommandRecord_09B091:
Bank080000_FFTerminatedCommandRecord_09B091:
	dc.b	$F8,$D1,$CF,$AF,$D1,$FD,$AF,$D0,$6E,$B0,$D2,$2C,$B0,$FD,$92,$B0
	dc.b	$88,$55,$01,$E4,$AD,$7B,$AE,$6C,$AF,$BD,$AF,$91,$B0,$00,$00,$F4
	dc.b	$00,$C4,$F1,$10,$F5,$14,$30,$FA,$33,$FA,$C5,$36,$C2,$33,$C4,$FA
	dc.b	$C6,$F5,$FB,$30,$C2,$F5,$05,$30,$FA,$F5,$FB,$3A,$39,$3A,$FA,$F5
	dc.b	$05,$37,$C4,$FA,$C5,$36,$C4,$33,$FF

; These neighboring records keep the same compact `F4 00` row family, first as another
; `0x32/0x33/0x35/0x37` sweep and then as a shorter `0x30/0x2B` tail with repeated FA caps.
Bank080000_LiteralRowPocketCommandFamily_09B0DA:
Bank080000_FFTerminatedCommandRecord_09B0DA:
	dc.b	$F4,$00,$C4,$F5,$14,$32,$FA,$33,$FA,$C5,$35,$C2,$33,$C4,$FA,$C6
	dc.b	$F5,$FB,$32,$C2,$F5,$05,$32,$FA,$F5,$FB,$37,$35,$37,$FA,$C5,$F1
	dc.b	$05,$F5,$05,$35,$F1,$10,$33,$C4,$35,$2B,$37,$36,$36,$33,$33,$32
	dc.b	$30,$32,$2B,$2E,$31,$32,$C7,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09B113:
	dc.b	$F4,$00,$C4,$F1,$0D,$F5,$14,$30,$30,$C9,$FA,$C4,$FA,$F1,$10,$2B
	dc.b	$FA,$2B,$FA,$2B,$FA,$2B,$FF

; This bridge shifts back into compact local control, then climbs into a short literal/high-byte
; row around `0x3C/0x3F/0x42/0x46/0x45/0x43` before the adjacent high-byte-pair continuation.
Bank080000_LocalControlAndLiteralHighByteRowCommandRecord_09B12A:
Bank080000_FFTerminatedCommandRecord_09B12A:
	dc.b	$F6,$00,$F7,$01,$F0,$07,$D1,$B0,$B0,$D1,$B0,$B0,$D0,$DA,$B0,$D3
	dc.b	$13,$B1,$FD,$33,$B1,$F4,$18,$F7,$06,$C4,$F1,$10,$F5,$17,$3C,$FA
	dc.b	$3F,$FA,$C5,$42,$C2,$3F,$C4,$FA,$C6,$F5,$FB,$3C,$C2,$F5,$05,$3C
	dc.b	$FA,$F5,$FB,$46,$45,$46,$FA,$F5,$05,$43,$C4,$FA,$C5,$42,$C4,$3F
	dc.b	$FF

; The next pair keeps the same `F4 18` neighborhood but leans harder on `0x9F/0xA0/0xA1/0xA2`
; high-byte rows, then narrows into a shorter `0x9F/0x9E/0x9C/0x9A/0x99` descent.
Bank080000_HighBytePairSweepCommandFamily_09B16B:
Bank080000_FFTerminatedCommandRecord_09B16B:
	dc.b	$F4,$18,$F7,$06,$CF,$FA,$C0,$F5,$12,$9F,$44,$F5,$05,$A0,$45,$F5
	dc.b	$05,$A1,$46,$F5,$05,$A2,$47,$C2,$F5,$F1,$A3,$48,$A6,$4B,$A1,$46
	dc.b	$9F,$43,$CF,$FA,$C0,$9F,$44,$F5,$05,$A0,$45,$F5,$05,$A1,$46,$F5
	dc.b	$05,$A2,$47,$C2,$F5,$F1,$A3,$48,$A6,$4B,$C4,$F5,$05,$A1,$46,$FF

Bank080000_FFTerminatedCommandRecord_09B1AB:
	dc.b	$F7,$06,$F4,$18,$C4,$FA,$F5,$0D,$9F,$43,$9E,$42,$9C,$3F,$C2,$F5
	dc.b	$0A,$9A,$3E,$99,$3D,$9A,$3E,$99,$3D,$9A,$3E,$C5,$FA,$FF

; This adjacent family returns to the paired literal-row neighborhood, first as a compact
; `0x3C/0x3F/0x43` sweep and then with a neighboring `0x9E/0x9D/0x9A/0x99/0x97/0x92` high-byte tail.
Bank080000_LiteralRowAndHighByteTailCommandFamily_09B1C9:
Bank080000_FFTerminatedCommandRecord_09B1C9:
	dc.b	$F7,$02,$F4,$18,$C4,$F1,$05,$F5,$17,$3C,$3F,$43,$3F,$3C,$43,$3F
	dc.b	$3C,$42,$3F,$3C,$42,$3F,$3C,$42,$3C,$3C,$3F,$45,$3F,$3C,$45,$3F
	dc.b	$3C,$FF

Bank080000_FFTerminatedCommandRecord_09B1EB:
	dc.b	$F7,$02,$F4,$18,$C4,$F5,$17,$43,$3F,$3C,$43,$3F,$C2,$F1,$10,$F5
	dc.b	$F6,$F7,$06,$9E,$43,$9D,$42,$9A,$3F,$99,$3E,$97,$3C,$92,$37,$FF

Bank080000_FFTerminatedCommandRecord_09B20B:
	dc.b	$F4,$18,$C4,$F5,$17,$F7,$06,$93,$43,$9F,$46,$9F,$46,$92,$39,$C2
	dc.b	$9E,$45,$9E,$45,$FA,$9E,$45,$C4,$9D,$44,$9C,$43,$FF

; The next short pocket keeps one `F4 18` high-byte family explicit, first as repeated
; `0x93/0x95` rows with `F1 0D/F1 10` pivots and then as a local-control bridge into a compact
; `0x48/0x54` literal-row sweep.
Bank080000_HighBytePairAndLiteralRowCommandFamily_09B228:
Bank080000_FFTerminatedCommandRecord_09B228:
	dc.b	$F4,$18,$C4,$FA,$F7,$06,$F1,$0D,$F5,$0F,$93,$3A,$93,$3A,$F1,$10
	dc.b	$F5,$24,$93,$3A,$FA,$F1,$0D,$F5,$DC,$95,$3C,$95,$3C,$F1,$10,$F5
	dc.b	$24,$95,$3C,$FF

Bank080000_LocalControlAndLiteralRowCommandRecord_09B24C:
Bank080000_FFTerminatedCommandRecord_09B24C:
	dc.b	$F6,$00,$F0,$04,$D1,$3F,$B1,$CA,$FA,$FA,$D0,$6B,$B1,$CA,$FA,$FA
	dc.b	$FA,$D0,$AB,$B1,$D0,$C9,$B1,$D0,$EB,$B1,$D2,$0B,$B2,$D0,$28,$B2
	dc.b	$FD,$53,$B2,$F7,$01,$F4,$00,$C2,$F1,$02,$F5,$21,$48,$54,$54,$54
	dc.b	$54,$FA,$54,$54,$C4,$FA,$C2,$54,$54,$54,$FA,$54,$54,$FF

; This longer bridge starts with another compact local-control sweep, then spends most of its
; payload on repeated `0xAB/0xAA/0xA8/0xA6/0xA5/0xAD/0xAE/0xB1/0xB2` high-byte rows around
; `0x4F/0x4E/0x4B/0x4A/0x48/0x51/0x52/0x54/0x56` before the short `F7 08` literal tail.
Bank080000_LocalControlAndRepeatedHighByteRowCommandRecord_09B28A:
Bank080000_FFTerminatedCommandRecord_09B28A:
	dc.b	$F6,$02,$F3,$00,$F4,$F0,$04,$CA,$FA,$FA,$D1,$6F,$B2,$D5,$6F,$B2
	dc.b	$D0,$6F,$B2,$CA,$FA,$D0,$6F,$B2,$CA,$FA,$D0,$6F,$B2,$CA,$DC,$FA
	dc.b	$FE,$FD,$97,$B2,$F7,$0C,$F4,$28,$C8,$F1,$10,$AB,$4F,$AA,$4E,$C6
	dc.b	$AB,$4F,$AA,$4E,$AB,$4F,$AF,$52,$C2,$AB,$4F,$AB,$4F,$AB,$4F,$C5
	dc.b	$FA,$C2,$AB,$4F,$AB,$4F,$AB,$4F,$E2,$54,$FA,$C2,$AB,$4F,$AB,$4F
	dc.b	$AB,$4F,$C5,$FA,$C2,$AB,$4F,$AB,$4F,$AB,$4F,$E2,$54,$FA,$C8,$AA
	dc.b	$4D,$A8,$4B,$C4,$A6,$4A,$FA,$A5,$48,$FA,$A6,$4A,$FA,$A8,$4B,$FA
	dc.b	$AB,$4F,$AA,$4E,$AB,$4F,$AD,$51,$AE,$52
	dc.b	$AD,$51,$AE,$52,$B1,$54,$B2,$56,$F7,$08,$4F,$4E,$4B,$C2,$4A,$49
	dc.b	$4A,$49,$C6,$4A,$FF

; The next pair stays in the same `F4 28` neighborhood: first a repeated `0xA2/0x43` high-byte
; pocket with timing pivots, then a shorter literal descent rooted on `0x46/0x48/0x4F/0x4E/0x4B/0x4A/0x4D`.
Bank080000_HighByteRepeatAndLiteralTailCommandFamily_09B319:
Bank080000_FFTerminatedCommandRecord_09B319:
	dc.b	$F4,$28,$C4,$FA,$C2,$F5,$15,$F7,$0C,$A2,$43,$C5,$FA,$C2,$F5,$F1
	dc.b	$A2,$43,$C5,$FA,$C2,$F5,$EC,$A2,$43,$C5,$FA,$C2,$F5,$F6,$A2,$43
	dc.b	$F7,$08,$FA,$C4,$F5,$14,$46,$48,$4F,$C7,$4E,$C4,$F5,$0A,$48,$CF
	dc.b	$F5,$F6,$4B,$C8,$4A,$FF

Bank080000_FFTerminatedCommandRecord_09B34F:
	dc.b	$F4,$28,$C4,$FA,$F5,$06,$F7,$08,$46,$45,$44,$43,$42,$41,$40,$C8
	dc.b	$F5,$F6,$48,$C4,$46,$45,$43,$CF,$4B,$C8,$4D,$FF

; This bridge returns to compact local control, then hands off to one short `F4 00` literal/high-byte
; crest around `0x3C/0x43/0x42/0x46` before the neighboring literal-control pockets.
Bank080000_LocalControlAndLiteralCrestCommandRecord_09B36B:
Bank080000_FFTerminatedCommandRecord_09B36B:
	dc.b	$F6,$00,$F0,$01,$CA,$DB,$FA,$FE,$D0,$AE,$B2,$CA,$FA,$D0,$19,$B3
	dc.b	$CA,$FA,$D0,$4F,$B3,$FD,$73,$B3,$F4,$00,$C6,$F1,$10,$F5,$17,$3C
	dc.b	$43,$42,$C7,$46,$E2,$A8,$FA,$FF

; The next four records keep the same `F4 00` row-control neighborhood, first with a compact local-control
; prelude and then as shorter literal-control variations around `0x60/0x0D/0x00/0x0C/0x65/0x05/0x0F/0x6C/0x6D`.
Bank080000_LocalControlAndLiteralControlRowCommandFamily_09B393:
Bank080000_FFTerminatedCommandRecord_09B393:
	dc.b	$F6,$00,$CA,$DB,$FA,$FE,$CA,$DB,$FA,$FE,$DB,$FA,$FE,$F7,$0E,$D0
	dc.b	$83,$B3,$CA,$FA,$FA,$D0,$83,$B3,$CA,$D9,$FA,$FE,$FD,$99,$B3,$F4
	dc.b	$00,$C2,$F5,$12,$60,$0D,$C5,$FA,$C4,$00,$FA,$0C,$C2,$FA,$00,$C4
	dc.b	$FA,$C2,$F5,$F6,$65,$F5,$0A,$0C,$FA,$C4,$FA,$C2,$0D,$FA,$F5,$F6
	dc.b	$05,$C5,$FA,$C2,$F5,$0A,$0C,$0C,$0C,$FA,$0C,$C5,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09B3E1:
	dc.b	$F4,$00,$C6,$F5,$12,$00,$C5,$0D,$C2,$00,$C6,$00,$C2,$F5,$F6,$05
	dc.b	$FA,$C4,$F5,$0A,$0C,$FA,$0C,$C6,$0C,$C2,$60,$0C,$0C,$C4,$0C,$C2
	dc.b	$F5,$F6,$05,$C5,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09B407:
	dc.b	$F4,$00,$C2,$F5,$12,$00,$C5,$FA,$C2,$0D,$C4,$FA,$C2,$00,$00,$C5
	dc.b	$FA,$C2,$F5,$F6,$05,$FA,$F5,$0A,$0C,$FA,$C4,$FA,$C2,$0C,$FA,$0E
	dc.b	$0E,$0D,$0D,$0C,$C5,$FA,$C2,$F5,$F6,$05,$C5,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09B434:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$F5,$0A,$0F,$0F,$0F,$0F,$F5,$F6,$6D,$F5
	dc.b	$0A,$0F,$0F,$0F,$F5,$F6,$60,$F5,$0A,$0F,$F5,$F6,$60,$F5,$0A,$0F
	dc.b	$0F,$0F,$0F,$F5,$EC,$65,$F5,$14,$0F,$0F,$F5,$F6,$6C,$F5,$0A,$0F
	dc.b	$0F,$0F,$0F,$F5,$F6,$6C,$F5,$0A,$0F,$0F,$F5,$F6,$6C,$F5,$0A,$0F
	dc.b	$0F,$0F,$0F,$F5,$F6,$60,$6C,$F5,$0A,$0F,$F5,$F6,$6C,$F5,$0A,$0F
	dc.b	$F5,$F6,$6C,$F5,$0A,$0F,$0F,$F5,$EC,$65,$F5,$14,$0F,$0F,$0F,$0F
	dc.b	$FF

; This neighboring trio shifts into the `F4 02` family: one local-control bridge into repeated
; `E2`-tagged `0x3B/0x3C` rows, a short literal continuation, and then a denser `E2 04/44/2C`
; sweep around `0x2F/0x30/0x31/0x32/0x34/0x35/0x36/0x37/0x2D/0x2C/0x2B`.
Bank080000_LocalControlAndLiteralE2RowCommandFamily_09B495:
Bank080000_FFTerminatedCommandRecord_09B495:
	dc.b	$F8,$D1,$B2,$B3,$D2,$E1,$B3,$D0,$07,$B4,$D3,$34,$B4,$FD,$99,$B4
	dc.b	$88,$00,$02,$2A,$B1,$4C,$B2,$8A,$B2,$6B,$B3,$93,$B3,$95,$B4,$00
	dc.b	$00,$F4,$02,$C0,$F1,$10,$F5,$12,$3B,$E2,$42,$3C,$C0,$3B,$E2,$2A
	dc.b	$3C,$C4,$37,$39,$37,$C0,$3B,$E2,$42,$3C,$C0,$3B,$E2,$2A,$3C,$C7
	dc.b	$F5,$FB,$35,$FF

Bank080000_FFTerminatedCommandRecord_09B4D9:
	dc.b	$F4,$02,$C0,$F1,$10,$F5,$12,$3B,$E2,$42,$3C,$C0,$3B,$E2,$2A,$3C
	dc.b	$C4,$37,$39,$37,$C0,$3B,$E2,$42,$3C,$C0,$3B,$E2,$2A,$3C,$C4,$F5
	dc.b	$FB,$35,$34,$32,$FF

Bank080000_FFTerminatedCommandRecord_09B4FE:
	dc.b	$F4,$02,$E2,$04,$F1,$10,$F5,$17,$2F,$E2,$44,$30,$E2,$04,$2F,$E2
	dc.b	$2C,$30,$C4,$FA,$E2,$04,$36,$E2,$2C,$37,$E2,$04,$2F,$E2,$44,$30
	dc.b	$E2,$04,$2F,$E2,$2C,$30,$C4,$37,$35,$34,$E2,$04,$31,$E2,$44,$32
	dc.b	$C6,$30,$C4,$2F,$C6,$2D,$E2,$04,$36,$E2,$44,$37,$E2,$04,$36,$E2
	dc.b	$2C,$37,$C4,$FA,$E2,$04,$31,$E2,$2C,$32,$C7,$35,$C6,$30,$C4,$FA
	dc.b	$C6,$35,$E2,$04,$2F,$E2,$44,$30,$C4,$30,$FA,$34,$E2,$04,$36,$E2
	dc.b	$14,$37,$C4,$34,$C7,$32,$C4,$32,$C7,$34,$C4,$34,$C7,$35,$C4,$35
	dc.b	$C6,$37,$C4,$F5,$FB,$2B,$2C,$FF

; This neighboring trio stays in the same `F4 02` literal-row neighborhood, first as a repeated
; `0x2D/0x34/0x2B/0x32` ladder, then with a denser FA-gated variation, and finally as a short
; `0x34/0x32/0x31/0x2F/0x30` descent.
Bank080000_LiteralRowLadderCommandFamily_09B576:
Bank080000_FFTerminatedCommandRecord_09B576:
	dc.b	$F4,$02,$C7,$F1,$10,$F5,$17,$2D,$C4,$2D,$C7,$34,$C4,$2D,$C7,$2B
	dc.b	$C4,$2B,$C6,$32,$2F,$C7,$2D,$C4,$2D,$C7,$34,$C4,$2D,$C7,$2B,$C4
	dc.b	$2B,$C6,$32,$34,$C7,$35,$C4,$35,$C6,$34,$32,$C7,$30,$C4,$30,$C6
	dc.b	$2B,$30,$C7,$32,$C4,$32,$C6,$2D,$32,$C8,$F5,$05,$34,$32,$31,$2F
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09B5B7:
	dc.b	$F4,$02,$C7,$F1,$10,$F5,$17,$2D,$C4,$2D,$FA,$2D,$2F,$31,$C7,$32
	dc.b	$C4,$32,$FA,$32,$31,$2F,$C7,$2D,$C4,$2D,$FA,$2F,$31,$32,$C7,$34
	dc.b	$C4,$28,$34,$32,$31,$2F,$C7,$2D,$C4,$2D,$FA,$2D,$2F,$31,$C7,$32
	dc.b	$C4,$32,$FA,$32,$31,$2F,$C7,$2D,$C4,$34,$C6,$2B,$2F,$C4,$F5,$F6
	dc.b	$2D,$C8,$FA,$C6,$F5,$0A,$2B,$C4,$FA,$FF

; This bridge returns to compact local control, then widens into the next `F4 18` ladder around
; `0x48/0x4A/0x4C/0x4D/0x4F`, followed by two shorter literal-row continuations and a small
; `F4 04` local-control handoff into `0x40/0x43/0x45/0x47/0x48/0x4A`.
Bank080000_LocalControlAndLiteralHighByteBridgeCommandFamily_09B601:
Bank080000_FFTerminatedCommandRecord_09B601:
	dc.b	$F6,$00,$F7,$01,$F0,$09,$D2,$B6,$B4,$D0,$D9,$B4,$D0,$FE,$B4,$D0
	dc.b	$76,$B5,$D0,$B7,$B5,$FD,$0D,$B6,$F4,$18,$C6,$F1,$0D,$F5,$06,$48
	dc.b	$C4,$48,$48,$C6,$4A,$C4,$48,$4A,$C6,$4D,$C4,$4C,$4A,$C6,$4C,$48
	dc.b	$C7,$45,$C4,$4C,$C7,$4A,$C4,$48,$C7,$47,$C4,$4A,$43,$FA,$43,$43
	dc.b	$C6,$4A,$C4,$4A,$4C,$C6,$4D,$C4,$4C,$4A,$C6,$4F,$4C,$4A,$48,$C8
	dc.b	$4A,$4C,$4D,$4F,$FF

Bank080000_FFTerminatedCommandRecord_09B656:
	dc.b	$F4,$18,$C4,$F1,$10,$F5,$06,$39,$39,$40,$39,$40,$39,$40,$39,$FA
	dc.b	$39,$40,$39,$42,$40,$3E,$40,$FA,$39,$40,$39,$40,$39,$40,$39,$FF

Bank080000_FFTerminatedCommandRecord_09B676:
	dc.b	$F4,$18,$C9,$FA,$C4,$F1,$0D,$F5,$06,$43,$43,$FF

Bank080000_FFTerminatedCommandRecord_09B682:
	dc.b	$F6,$00,$F7,$0E,$F0,$00,$CA,$DE,$FA,$FE,$D0,$76,$B6,$D0,$19,$B6
	dc.b	$CA,$DF,$FA,$FE,$DF,$FA,$FE,$D0,$76,$B6,$FD,$8F,$B6,$F4,$04,$C9
	dc.b	$FA,$C4,$F1,$0D,$F5,$21,$40,$43,$FF

Bank080000_FFTerminatedCommandRecord_09B6AB:
	dc.b	$F4,$04,$C4,$F1,$10,$F5,$21,$45,$FA,$C6,$48,$47,$48,$4A,$48,$47
	dc.b	$43,$FF

Bank080000_FFTerminatedCommandRecord_09B6BD:
	dc.b	$F4,$04,$C4,$FA,$F1,$10,$F5,$21,$41,$40,$41,$F5,$F6,$40,$41,$F5
	dc.b	$F6,$40,$41,$FA,$F5,$14,$40,$3E,$40,$F5,$F6,$3E,$40,$F5,$F6,$3E
	dc.b	$40,$FA,$F5,$14,$41,$40,$41,$F5,$F6,$40,$41,$F5,$F6,$40,$41,$F5
	dc.b	$0A,$40,$F1,$08,$F5,$0A,$47,$4C,$40,$47,$4C,$40,$47,$4C,$40,$47
	dc.b	$4C,$40,$C7,$FA,$FF

; This next pocket stays in the same compact `F4 04` neighborhood as 0x09B682, first as a short
; `0x45/0x49/0x4A/0x4C/0x50/0x51` literal/high-byte ladder with one tiny cap, then as a broader
; local-control bridge into a denser `0x4F/0x4D/0x4C/0x4A/0x48/0x47/0x45/0x43/0x41/0x40/0x3E` descent.
Bank080000_LiteralAndHighByteLadderCommandFamily_09B702:
Bank080000_FFTerminatedCommandRecord_09B702:
	dc.b	$F4,$04,$C4,$F1,$10,$F5,$17,$45,$FA,$45,$49,$4A,$4C,$FA,$C6,$50
	dc.b	$C4,$51,$50,$4C,$FA,$4C,$4A,$49,$45,$FA,$45,$FA,$45,$44,$45,$40
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09B723:
	dc.b	$F4,$04,$CA,$FA,$FF

Bank080000_LocalControlAndLiteralHighByteLadderCommandRecord_09B728:
Bank080000_FFTerminatedCommandRecord_09B728:
	dc.b	$F6,$00,$F7,$08,$F0,$1F,$F2,$20,$00,$D0,$53,$B7,$F2,$00,$00,$F0
	dc.b	$21,$D0,$23,$B7,$CA,$DD,$FA,$FE,$D0,$9F,$B6,$D1,$AB,$B6,$D0,$BD
	dc.b	$B6,$CA,$DE,$FA,$FE,$D0,$23,$B7,$FD,$34,$B7,$F4,$0C,$E3,$20,$01
	dc.b	$F1,$10,$F5,$21,$4F,$C5,$F5,$F6,$4D,$F5,$03,$4C,$C4,$F5,$02,$4A
	dc.b	$E3,$20,$01,$F5,$05,$4C,$C5,$48,$47,$C4,$45,$E3,$20,$01,$43,$C5
	dc.b	$F5,$F6,$41,$F5,$03,$40,$C4,$F5,$02,$3E,$CA,$F5,$05,$40,$F5,$03
	dc.b	$F1,$0A,$CA,$43,$FF

Bank080000_FFTerminatedCommandRecord_09B78D:
	dc.b	$F4,$04,$F0,$1F,$C8,$F1,$0D,$F5,$17,$51,$C6,$4C,$51,$4F,$4D,$4C
	dc.b	$4A,$C8,$51,$C6,$4C,$51,$C8,$53,$4C,$4D,$C6,$48,$51,$4F,$4C,$4A
	dc.b	$48,$C8,$4A,$C7,$48,$C4,$4A,$E3,$20,$01,$F1,$10,$4C,$C8,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09B7BD:
	dc.b	$F4,$04,$CA,$FA,$FF

; The neighboring continuation keeps one compact `F4 04` front while walking a repeated
; `0x39/0x40/0x41/0x42/0x3B/0x3C/0x3D/0x3A` literal-row cycle, with two short E2-tagged local-offset
; hops at the tail before the next bridge.
Bank080000_LiteralRowAndLocalOffsetCommandFamily_09B7C2:
Bank080000_FFTerminatedCommandRecord_09B7C2:
	dc.b	$F4,$04,$F0,$27,$C4,$F1,$10,$F5,$1B,$39,$F5,$FC,$39,$F5,$04,$40
	dc.b	$39,$40,$39,$40,$C6,$39,$C4,$39,$F5,$FC,$40,$F5,$04,$39,$C0,$F5
	dc.b	$FC,$41,$C3,$F5,$04,$42,$C4,$40,$3E,$40,$FA,$39,$40,$39,$40,$39
	dc.b	$F5,$FC,$40,$39,$FA,$C6,$F5,$FE,$3B,$FA,$C0,$F5,$02,$3C,$C3,$F5
	dc.b	$04,$3D,$C4,$3B,$C6,$39,$C4,$39,$40,$39,$40,$39,$40,$C6,$39,$C4
	dc.b	$39,$40,$39,$C0,$F5,$FC,$41,$C3,$F5,$04,$42,$C4,$40,$3E,$40,$FA
	dc.b	$40,$40,$39,$C0,$F5,$F7,$3A,$C3,$F5,$09,$3B,$C4,$39,$C0,$F5,$F7
	dc.b	$3A,$E2,$2A,$F5,$09,$3B,$C4,$39,$E2,$A8,$FA,$FF

; This bridge returns to the same compact local-control shape, then narrows into two `F4 04`
; literal-row ladders centered on `0x30/0x37/0x39/0x3C` and `0x32/0x35/0x3B/0x3E/0x40/0x41/0x43`.
Bank080000_LocalControlAndLiteralRowLadderCommandFamily_09B83E:
Bank080000_FFTerminatedCommandRecord_09B83E:
	dc.b	$F6,$00,$F7,$04,$F0,$1F,$D0,$53,$B7,$F7,$0C,$D0,$BD,$B7,$CA,$DE
	dc.b	$FA,$FE,$D0,$8D,$B7,$D0,$C2,$B7,$FD,$47,$B8,$F4,$04,$C4,$F1,$10
	dc.b	$F5,$17,$30,$37,$39,$37,$3C,$37,$39,$37,$30,$35,$39,$35,$41,$C2
	dc.b	$35,$C4,$40,$C2,$35,$C4,$3C,$FF

Bank080000_FFTerminatedCommandRecord_09B876:
	dc.b	$F4,$04,$C4,$F1,$10,$F5,$1D,$30,$37,$39,$C6,$40,$C4,$37,$39,$C6
	dc.b	$40,$C4,$37,$39,$C6,$40,$C4,$37,$39,$40,$32,$35,$39,$C6,$3E,$C4
	dc.b	$39,$35,$C6,$3C,$C4,$39,$35,$C6,$3B,$C4,$39,$3E,$37,$35,$37,$39
	dc.b	$C6,$40,$C4,$35,$39,$C6,$40,$C4,$37,$39,$C6,$40,$C4,$37,$39,$40
	dc.b	$3E,$39,$35,$32,$40,$3B,$37,$34,$41,$3C,$39,$35,$43,$3E,$3B,$37
	dc.b	$FF

; The next four records stay in the same compact `F4 04` row family, first as a repeated
; `0x30/0x37/0x39/0x3C` ladder, then as a broader `0x39/0x40/0x48/0x47/0x45/0x43` sweep,
; and finally with two short `0x45/0x44/0x42` and `0x9E/0x43` tails.
Bank080000_LiteralRowAndHighBytePocketCommandFamily_09B8C7:
Bank080000_FFTerminatedCommandRecord_09B8C7:
	dc.b	$F4,$04,$C4,$F1,$10,$F5,$17,$30,$37,$39,$37,$3C,$37,$39,$37,$C2
	dc.b	$F5,$0F,$48,$41,$3C,$35,$F5,$FB,$48,$41,$3C,$35,$F5,$FB,$48,$41
	dc.b	$3C,$35,$F5,$FB,$48,$41,$3C,$35,$FF

Bank080000_FFTerminatedCommandRecord_09B8F0:
	dc.b	$F4,$04,$C4,$F1,$10,$F5,$1C,$39,$40,$48,$40,$47,$45,$43,$40,$37
	dc.b	$3E,$47,$3E,$45,$3E,$C0,$43,$42,$C2,$43,$C4,$3E,$39,$40,$48,$40
	dc.b	$47,$45,$43,$40,$37,$3E,$47,$3E,$45,$3E,$32,$34,$35,$3C,$41,$C8
	dc.b	$48,$C4,$FA,$34,$3C,$40,$C8,$47,$C4,$FA,$C0,$45,$C3,$48,$C4,$47
	dc.b	$43,$40,$3E,$3C,$3B,$37,$40,$47,$44,$40,$3E,$47,$44,$3E,$3D,$47
	dc.b	$44,$3D,$3B,$47,$44,$3B,$FF

Bank080000_FFTerminatedCommandRecord_09B947:
	dc.b	$F4,$04,$C4,$F1,$10,$F5,$21,$39,$40,$45,$40,$44,$40,$45,$40,$39
	dc.b	$3E,$45,$3E,$44,$3E,$42,$3E,$FF

Bank080000_FFTerminatedCommandRecord_09B95F:
	dc.b	$F4,$04,$C4,$F1,$10,$F5,$21,$39,$40,$45,$40,$3E,$3B,$37,$3B,$94
	dc.b	$39,$CF,$FA,$C6,$F1,$0D,$9E,$43,$FF

; This neighboring pocket returns to compact local control and then settles into repeated
; `0x07/0x12/0x72/0x09` literal-control rows with `0x60/0x65/0x67/0x6C/0x6D/0x6E` pivots.
Bank080000_LocalControlAndLiteralControlPocketCommandFamily_09B978:
Bank080000_FFTerminatedCommandRecord_09B978:
	dc.b	$F6,$00,$F7,$02,$F0,$27,$D2,$59,$B8,$D0,$C7,$B8,$D0,$76,$B8,$D0
	dc.b	$F0,$B8,$D2,$47,$B9,$D0,$5F,$B9,$FD,$84,$B9,$F4,$04,$C5,$F5,$08
	dc.b	$07,$C2,$12,$C4,$72,$09,$C2,$07,$FA,$12,$FA,$F5,$0A,$6D,$09,$0D
	dc.b	$6C,$F5,$F6,$07,$07,$F5,$0A,$6C,$F5,$F6,$67,$09,$07,$FF

Bank080000_FFTerminatedCommandRecord_09B9B6:
	dc.b	$F4,$04,$C5,$F5,$12,$60,$F5,$F6,$07,$C2,$12,$C4,$72,$09,$60,$07
	dc.b	$12,$09,$C2,$65,$07,$07,$67,$09,$07,$FF

Bank080000_FFTerminatedCommandRecord_09B9D0:
	dc.b	$F4,$04,$C4,$F5,$12,$60,$F5,$F6,$07,$C2,$FA,$12,$C4,$65,$72,$09
	dc.b	$C2,$07,$FA,$C4,$60,$12,$09,$C2,$65,$07,$07,$67,$09,$07,$C4,$F5
	dc.b	$0A,$60,$F5,$F6,$07,$C2,$FA,$12,$C4,$65,$72,$09,$C2,$07,$FA,$C4
	dc.b	$60,$12,$6D,$09,$C2,$6C,$07,$07,$6C,$67,$09,$07,$FF

Bank080000_FFTerminatedCommandRecord_09BA0D:
	dc.b	$F4,$04,$C2,$F5,$12,$60,$F5,$F6,$07,$C4,$FA,$C2,$12,$C4,$65,$09
	dc.b	$C2,$60,$07,$FA,$12,$FA,$C4,$09,$C2,$65,$07,$07,$F5,$0A,$60,$F5
	dc.b	$F6,$67,$09,$07,$FF

Bank080000_FFTerminatedCommandRecord_09BA32:
	dc.b	$F4,$04,$C5,$F5,$12,$60,$F5,$F6,$07,$C2,$12,$C4,$72,$09,$60,$07
	dc.b	$12,$C2,$F5,$0A,$60,$6E,$09,$0E,$65,$6D,$F5,$F6,$07,$07,$6C,$67
	dc.b	$09,$07,$FF

Bank080000_FFTerminatedCommandRecord_09BA55:
	dc.b	$F4,$04,$C2,$F5,$08,$07,$C4,$FA,$C2,$12,$C4,$72,$09,$C2,$07,$FA
	dc.b	$12,$FA,$C4,$09,$C2,$07,$07,$67,$09,$07,$FF

; This short bridge starts with a compact local-control handoff and then walks a small
; `F4 07` literal-row neighborhood around `0x28/0x34/0x35/0x38/0x39/0x3B/0x32/0x30/0x2F/0x2D`.
Bank080000_LocalControlBridgeAndLiteralRowCommandFamily_09BA70:
Bank080000_FFTerminatedCommandRecord_09BA70:
	dc.b	$F8,$D6,$55,$BA,$D0,$93,$B9,$D5,$B6,$B9,$D0,$D0,$B9,$D2,$B6,$B9
	dc.b	$D0,$32,$BA,$D2,$B6,$B9,$D0,$D0,$B9,$D5,$0D,$BA,$D0,$D0,$B9,$FD
	dc.b	$77,$BA,$88,$CC,$01,$01,$B6,$82,$B6,$28,$B7,$3E,$B8,$78,$B9,$70
	dc.b	$BA,$00,$00,$F4,$07,$C4,$F1,$0D,$F5,$10,$28,$28,$34,$34,$28,$28
	dc.b	$34,$34,$FF

Bank080000_FFTerminatedCommandRecord_09BAB3:
	dc.b	$F4,$07,$C6,$F1,$10,$F5,$10,$34,$C4,$35,$38,$C6,$39,$C4,$38,$35
	dc.b	$C9,$34,$C4,$35,$C2,$38,$35,$C9,$34,$C4,$32,$C2,$30,$32,$CA,$34
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09BAD4:
	dc.b	$F4,$07,$C2,$F1,$0C,$F5,$10,$3B,$35,$32,$30,$35,$32,$30,$2F,$32
	dc.b	$30,$2F,$2D,$34,$F5,$FB,$34,$F5,$FB,$34,$F5,$FB,$34,$FF

Bank080000_FFTerminatedCommandRecord_09BAF2:
	dc.b	$F4,$07,$C4,$F1,$0D,$F5,$10,$28,$2C,$2D,$2F,$32,$2F,$32,$34,$28
	dc.b	$2C,$2D,$34,$32,$2F,$F5,$F6,$2D,$2C,$FF

Bank080000_FFTerminatedCommandRecord_09BB0C:
	dc.b	$F4,$07,$C4,$F1,$0D,$F5,$10,$29,$29,$35,$35,$29,$29,$35,$35,$28
	dc.b	$E2,$A8,$FA,$C4,$2D,$2D,$39,$39,$2D,$2D,$39,$39,$FF

; The next pocket returns to local-control setup, then widens into repeated `F4 1B`
; high-byte and literal ladders around `0xA0/0x48`, `0x47/0x48/0x4B/0x4C`, and `0xA8/0x4D`.
Bank080000_LocalControlAndLiteralHighBytePocketCommandFamily_09BB29:
Bank080000_FFTerminatedCommandRecord_09BB29:
	dc.b	$F6,$00,$F7,$01,$F0,$07,$D0,$B3,$BA,$D2,$A3,$BA,$D0,$D4,$BA,$D3
	dc.b	$F2,$BA,$D0,$0C,$BB,$D0,$D4,$BA,$D3,$A3,$BA,$FD,$32,$BB,$F4,$1B
	dc.b	$C4,$F1,$0A,$F5,$06,$A0,$48,$A0,$48,$40,$40,$A0,$44,$A0,$44,$40
	dc.b	$40,$FF

Bank080000_FFTerminatedCommandRecord_09BB5B:
	dc.b	$F4,$1B,$C6,$F1,$10,$F5,$FC,$40,$C4,$41,$44,$C6,$45,$C4,$44,$41
	dc.b	$C9,$40,$C4,$41,$C2,$44,$41,$C9,$40,$C4,$3E,$C2,$3C,$3E,$FF

Bank080000_FFTerminatedCommandRecord_09BB7A:
	dc.b	$F4,$1B,$C4,$F1,$0D,$F5,$04,$47,$48,$C2,$F1,$0C,$4B,$4C,$C4,$F1
	dc.b	$0D,$48,$4C,$4B,$48,$4B,$48,$47,$48,$47,$C2,$F1,$0C,$48,$47,$45
	dc.b	$42,$C4,$F1,$0D,$F5,$EE,$47,$47,$FF

Bank080000_FFTerminatedCommandRecord_09BBA3:
	dc.b	$F4,$1B,$C4,$F1,$0D,$F5,$04,$47,$48,$C2,$F1,$0C,$4B,$4C,$C4,$F1
	dc.b	$0D,$48,$4C,$4B,$48,$4B,$48,$47,$48,$47,$C2,$F1,$0C,$48,$47,$45
	dc.b	$42,$C4,$F1,$0D,$F5,$F8,$40,$3F,$FF

Bank080000_FFTerminatedCommandRecord_09BBCC:
	dc.b	$F4,$1B,$C4,$F1,$0A,$F5,$10,$A8,$4D,$A8,$4D,$F5,$F6,$A8,$4D,$A8
	dc.b	$4D,$F5,$F6,$A8,$4D,$F5,$F6,$A8,$4D,$A8,$4D,$A8,$4D,$F5,$F3,$A7
	dc.b	$4C,$E2,$A8,$FA,$C4,$F5,$2B,$AD,$51,$AD,$51,$F5,$F6,$AD,$51,$AD
	dc.b	$51,$F5,$F6,$AD,$51,$AD,$51,$F5,$F6,$AD,$51,$AD,$51,$F5,$F6,$AC
	dc.b	$50,$E2,$A8,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09BC11:
	dc.b	$F4,$1B,$C2,$F1,$10,$F5,$FC,$4C,$47,$44,$41,$47,$44,$41,$40,$44
	dc.b	$41,$40,$3E,$C0,$F5,$05,$40,$F5,$05,$41,$F5,$FB,$40,$F5,$FB,$41
	dc.b	$F5,$FB,$40,$F5,$FB,$41,$F5,$FB,$40,$F5,$FB,$41,$FF

Bank080000_FFTerminatedCommandRecord_09BC3E:
	dc.b	$F4,$1B,$CA,$F1,$10,$F5,$FC,$40,$FF

; This neighboring bridge revisits compact local control, then resolves into short `F4 00`
; literal-control and literal/high-byte pockets around `0x40/0x44/0x45/0x47` and `0x4C/0x4D/0x50/0x51`.
Bank080000_LocalControlAndLiteralPocketCommandFamily_09BC47:
Bank080000_FFTerminatedCommandRecord_09BC47:
	dc.b	$F6,$00,$F7,$0E,$F0,$1F,$D3,$47,$BB,$D0,$5B,$BB,$D0,$11,$BC,$CA
	dc.b	$FA,$FA,$D0,$7A,$BB,$CA,$FA,$FA,$D0,$A3,$BB,$D0,$CC,$BB,$D0,$5B
	dc.b	$BB,$D0,$3E,$BC,$FD,$50,$BC,$F4,$00,$C4,$F1,$0D,$F5,$21,$40,$44
	dc.b	$45,$47,$40,$44,$45,$47,$FF

Bank080000_FFTerminatedCommandRecord_09BC7E:
	dc.b	$F4,$00,$C4,$F1,$0D,$F5,$21,$40,$F5,$FB,$B8,$53,$F5,$FB,$40,$B3
	dc.b	$50,$F5,$FB,$40,$AC,$50,$F5,$FB,$40,$F5,$F6,$AC,$47,$FF

Bank080000_FFTerminatedCommandRecord_09BC9C:
	dc.b	$F4,$00,$C4,$F1,$0D,$F5,$17,$4C,$4D,$C2,$F1,$0C,$50,$51,$C4,$F1
	dc.b	$0D,$4D,$51,$50,$4D,$50,$4D,$4C,$4D,$4C,$C2,$F1,$0C,$4D,$4C,$4A
	dc.b	$47,$C4,$F1,$0D,$F5,$F1,$4C,$4C,$FF

Bank080000_FFTerminatedCommandRecord_09BCC5:
	dc.b	$F4,$00,$C4,$F1,$10,$F5,$17,$4C,$C0,$4D,$4D,$4D,$4D,$50,$50,$51
	dc.b	$51,$4D,$4D,$C2,$FA,$C4,$F1,$0D,$51,$50,$C0,$F1,$10,$4D,$4D,$4D
	dc.b	$4D,$C4,$F1,$0D,$50,$4D,$C0,$F1,$10,$4C,$4C,$4C,$4C,$C4,$F1,$0D
	dc.b	$4D,$4C,$C2,$F1,$0C,$4D,$C0,$F1,$10,$4C,$4C,$C2,$F1,$0C,$4A,$47
	dc.b	$C0,$F1,$10,$F5,$05,$45,$45,$C2,$FA,$C0,$44,$44,$44,$44,$FF

Bank080000_FFTerminatedCommandRecord_09BD14:
	dc.b	$F4,$00,$C2,$F1,$10,$F5,$17,$45,$44,$45,$51,$50,$4D,$4C,$4A,$45
	dc.b	$44,$45,$4C,$4A,$47,$40,$40,$FF

; The next bridge returns to local control, then spends most of its body on a broader
; `F4 1B` literal/high-byte descent around `0x40/0x41/0x44/0x45/0x47/0x4A/0x4D/0x50`.
Bank080000_LocalControlAndHighByteSweepCommandFamily_09BD2C:
Bank080000_FFTerminatedCommandRecord_09BD2C:
	dc.b	$F6,$00,$F7,$0E,$F0,$26,$F2,$00,$F4,$CA,$DB,$FA,$FE,$D0,$6E,$BC
	dc.b	$D0,$14,$BD,$D0,$6E,$BC,$CA,$FA,$D2,$9C,$BC,$D0,$C5,$BC,$CA,$DB
	dc.b	$FA,$FE,$D0,$6E,$BC,$D0,$14,$BD,$D0,$6E,$BC,$D0,$14,$BD,$FD,$39
	dc.b	$BD,$F4,$1B,$C4,$F1,$0D,$F5,$06,$40,$F5,$FB,$B8,$53,$F5,$FB,$40
	dc.b	$B3,$50,$F5,$FB,$40,$F5,$FB,$AC,$50,$F5,$FB,$40,$AC,$47,$FF

Bank080000_FFTerminatedCommandRecord_09BD7B:
	dc.b	$F4,$1B,$C9,$F1,$10,$F5,$FC,$41,$C6,$40,$41,$C4,$40,$41,$C6,$45
	dc.b	$C4,$44,$45,$E2,$A8,$47,$C2,$46,$45,$C8,$44,$40,$C9,$3E,$C6,$40
	dc.b	$41,$45,$44,$41,$CF,$40,$C2,$3F,$3E,$C4,$3D,$3C,$C7,$3B,$C2,$3A
	dc.b	$39,$C6,$38,$34,$FF

Bank080000_FFTerminatedCommandRecord_09BDB0:
	dc.b	$F4,$1B,$CA,$FA,$C2,$F1,$10,$F5,$FC,$40,$41,$44,$47,$44,$47,$4A
	dc.b	$4D,$47,$4A,$4D,$50,$C0,$F5,$14,$4B,$F5,$FB,$4C,$F5,$FB,$4B,$F5
	dc.b	$FB,$4C,$F5,$FB,$4B,$F5,$05,$4C,$F5,$05,$4B,$F5,$05,$4C,$CA,$FA
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09BDE1:
	dc.b	$F4,$1B,$C2,$F1,$10,$F5,$FC,$4C,$47,$44,$41,$47,$44,$41,$40,$44
	dc.b	$41,$40,$3E,$C0,$F5,$08,$40,$F5,$08,$41,$F5,$FB,$40,$F5,$FA,$41
	dc.b	$F5,$FA,$40,$F5,$FA,$41,$F5,$FA,$40,$F5,$F8,$41,$FF

Bank080000_FFTerminatedCommandRecord_09BE0E:
	dc.b	$F4,$1B,$CA,$FA,$FF

; The following run drops back into compact literal-control rows around `0x0C/0x0D/0x0E/0x0F/0x05`
; with one local-control prelude and repeated `0x65/0x6C/0x6F` pivots.
Bank080000_LocalControlAndLiteralControlPocketCommandFamily_09BE13:
Bank080000_FFTerminatedCommandRecord_09BE13:
	dc.b	$F6,$00,$F7,$0E,$CA,$DB,$FA,$FE,$F0,$01,$D2,$0E,$BE,$D0,$5D,$BD
	dc.b	$D0,$7B,$BD,$F0,$25,$F3,$00,$F4,$D0,$B0,$BD,$D0,$E1,$BD,$F3,$00
	dc.b	$0C,$D3,$0E,$BE,$FD,$1B,$BE,$F4,$00,$C9,$FA,$C2,$F5,$12,$0C,$0D
	dc.b	$0C,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09BE46:
	dc.b	$F4,$00,$C2,$F5,$12,$0E,$C4,$FA,$C2,$0D,$F5,$F6,$05,$FA,$F5,$0A
	dc.b	$00,$FA,$0C,$0C,$FA,$0D,$F5,$F6,$05,$FA,$05,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09BE63:
	dc.b	$F4,$00,$C4,$F5,$12,$0C,$C2,$6C,$F5,$0A,$0F,$F5,$F6,$0D,$FA,$0C
	dc.b	$C4,$F5,$0A,$0F,$FA,$C2,$6F,$F5,$F6,$0D,$0D,$C4,$FA,$F5,$F6,$65
	dc.b	$F5,$14,$0F,$FF

Bank080000_FFTerminatedCommandRecord_09BE87:
	dc.b	$F4,$00,$C4,$F5,$12,$0C,$C2,$0C,$0D,$E2,$54,$FA,$C2,$0D,$C4,$F5
	dc.b	$F6,$05,$C2,$05,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09BE9D:
	dc.b	$F4,$00,$C4,$F5,$12,$00,$00,$C6,$FA,$C4,$00,$00,$FA,$C2,$05,$05
	dc.b	$F5,$F6,$05,$C5,$FA,$C2,$F5,$0A,$0C,$0C,$C4,$FA,$C2,$0E,$FA,$0C
	dc.b	$FA,$0C,$0C,$C4,$FA,$00,$00,$C6,$FA,$C4,$00,$00,$FA,$C2,$05,$05
	dc.b	$FF

; This final pocket begins with one more compact local-control bridge, then resolves into
; short `F4 00` literal-row families around `0x24/0x2A/0x2B`, `0x30/0x2B/0x27`, and `0x3C/0x3B/0x3A/0x38`.
Bank080000_LocalControlAndLiteralRowPocketCommandFamily_09BECE:
Bank080000_FFTerminatedCommandRecord_09BECE:
	dc.b	$F8,$CA,$FA,$FA,$FA,$D0,$3A,$BE,$D3,$46,$BE,$D0,$63,$BE,$D0,$87
	dc.b	$BE,$D0,$63,$BE,$D0,$87,$BE,$D0,$63,$BE,$D0,$87,$BE,$D0,$63,$BE
	dc.b	$D0,$87,$BE,$D0,$9D,$BE,$D4,$46,$BE,$FD,$D6,$BE,$88,$99,$01,$29
	dc.b	$BB,$47,$BC,$2C,$BD,$13,$BE,$CE,$BE,$00,$00,$F4,$00,$C4,$F1,$09
	dc.b	$F5,$03,$24,$24,$2A,$2B,$27,$27,$2A,$2B,$FF

Bank080000_FFTerminatedCommandRecord_09BF19:
	dc.b	$F4,$00,$C2,$F1,$0C,$F5,$03,$28,$27,$F5,$12,$26,$25,$F5,$FD,$24
	dc.b	$FA,$F5,$FB,$23,$22,$F5,$FB,$21,$F5,$FB,$20,$F5,$FE,$1F,$C5,$FA
	dc.b	$C4,$F5,$FF

Bank080000_FFTerminatedCommandRecord_09BF3C:
	dc.b	$1F,$FF

Bank080000_FFTerminatedCommandRecord_09BF3E:
	dc.b	$F4,$00,$C4,$F1,$09,$F5,$17,$32,$32,$38,$3B,$36,$36,$3B,$3E,$FF

Bank080000_FFTerminatedCommandRecord_09BF4E:
	dc.b	$F6,$00,$F7,$01,$F0,$23,$D7,$09,$BF,$D6,$09,$BF,$D0,$19,$BF,$FD
	dc.b	$4E,$BF,$F4,$00,$E2,$A8,$F1,$10,$F5,$17,$30,$C2,$2F,$2E,$E2,$A8
	dc.b	$2C,$C2,$27,$2A,$CA,$2B,$FF

Bank080000_FFTerminatedCommandRecord_09BF75:
	dc.b	$F4,$00,$C8,$F5,$0D,$24,$2A,$C9,$2B,$C6,$2A,$FF

Bank080000_FFTerminatedCommandRecord_09BF81:
	dc.b	$F4,$00,$C5,$F5,$0D,$30,$2B,$C4,$30,$C5,$2E,$27,$C4,$2E,$C5,$2D
	dc.b	$26,$C4,$2D,$C5,$2C,$25,$C4,$2C,$FF

Bank080000_FFTerminatedCommandRecord_09BF9A:
	dc.b	$F4,$00,$C5,$F5,$0D,$30,$2B,$C4,$30,$C5,$2E,$27,$C4,$2E,$F0,$23
	dc.b	$C2,$F5,$05,$39,$37,$F5,$FE,$38,$37,$F5,$FD,$36,$FA,$35,$32,$F5
	dc.b	$FE,$33,$F5,$FD,$34,$F1,$0C,$F5,$FE,$35,$C5,$FA,$C4,$F1,$0D,$F5
	dc.b	$FD,$37,$F1,$10,$FF

Bank080000_FFTerminatedCommandRecord_09BFCF:
	dc.b	$F6,$00,$F7,$0E,$F0,$23,$F2,$20,$00,$D0,$60,$BF,$CA,$FA,$D0,$60
	dc.b	$BF,$CA,$FA,$F0,$28,$D0,$75,$BF,$D0,$81,$BF,$D0,$75,$BF,$D0,$9A
	dc.b	$BF,$FD,$CF,$BF,$F4,$00,$E2,$A8,$F1,$10,$F5,$17,$3C,$C2,$3B,$3A
	dc.b	$E2,$A8,$38,$C2,$33,$36,$CA,$37,$FF
