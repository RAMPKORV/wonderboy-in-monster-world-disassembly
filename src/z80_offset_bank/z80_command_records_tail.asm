; ROM range: 0x09E028-0x09F776
; Tail FF-terminated command-record window split into ROM-order slices at every proven
; local terminator. The final bytes remain a short non-terminated lead-out because the
; surrounding decoder/owner is still unresolved.

; This opening bridge reuses the compact local-control sweep framing already seen elsewhere in the
; tail command body, then hands off into a descending 0xAA/0xB8/0xB6/... high-byte ladder with
; repeated F5 FB pockets before the short 0xB1/0xB4 tail.
Bank080000_LocalControlSweepAndHighByteLadderCommandRecord_09E028:
Bank080000_FFTerminatedCommandRecord_09E028:
	dc.b	$F6,$00,$F7,$0C,$F0,$0A,$D0,$92,$DF,$D1,$D0,$DE,$D0,$2B,$DF,$CA
	dc.b	$FA,$FA,$D0,$B4,$DF,$CA,$FA,$FA,$D0,$EE,$DF,$D0,$2B,$DF,$FD,$31
	dc.b	$E0,$F4,$00,$C4,$F1,$0D,$F5,$30,$AA,$51,$B8,$5D,$B6,$5C,$F5,$FB
	dc.b	$AA,$51,$FA,$F5,$FB,$AA,$4F,$A9,$4E,$F5,$FB,$A8,$4D,$AF,$56,$F5
	dc.b	$FB,$A3,$4A,$A5,$4C,$F5,$FB,$A7,$4D,$A8,$4F,$F5,$FB,$B1,$58,$F5
	dc.b	$FB,$AA,$51,$F5,$FB,$B4,$5B,$FF

Bank080000_FFTerminatedCommandRecord_09E080:
	dc.b	$F4,$00,$C8,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09E085:
	dc.b	$F4,$00,$CA,$FA,$FF

; This nearby sweep keeps the same compact local-control front, but its payload narrows into
; short 0x00/0x05/0x0C/0x0D/0x11 literal-control rows instead of the surrounding byte-pair ladders.
Bank080000_LocalControlSweepAndLiteralControlCommandRecord_09E08A:
Bank080000_FFTerminatedCommandRecord_09E08A:
	dc.b	$F6,$00,$F7,$0E,$F0,$1C,$D0,$80,$E0,$D7,$85,$E0,$D7,$85,$E0,$D0
	dc.b	$49,$E0,$D1,$85,$E0,$D0,$49,$E0,$D7,$85,$E0,$D1,$85,$E0,$FD,$93
	dc.b	$E0,$F4,$05,$C2,$F5,$1C,$0D,$FA,$0C,$FA,$F5,$F6,$05,$FA,$F5,$0A
	dc.b	$0D,$FA,$0D,$FA,$0C,$0C,$F5,$F6,$05,$FA,$F5,$0A,$0D,$FA,$C4,$FA
	dc.b	$C2,$0D,$FA,$F5,$F6,$05,$FA,$F5,$0A,$0D,$0C,$C4,$0D,$C2,$0C,$FA
	dc.b	$F5,$F6,$11,$F5,$0A,$0C,$C4,$F5,$0A,$00,$FF

; Three short neighbors keep the same `F4 05 C2 F5 1C` literal-control framing, with the third
; widening into repeated `0x65` pockets before the final short `0x0D/0x05` tail.
Bank080000_LiteralControlCommandFamily_09E0E5:
Bank080000_FFTerminatedCommandRecord_09E0E5:
	dc.b	$F4,$05,$C2,$F5,$1C,$0D,$FA,$0C,$FA,$C4,$F5,$F6,$05,$C2,$F5,$0A
	dc.b	$0D,$FA,$0D,$FA,$0C,$0C,$C4,$F5,$F6,$05,$C2,$F5,$0A,$0D,$FA,$C4
	dc.b	$FA,$0D,$F5,$F6,$05,$F5,$0A,$0D,$0D,$FA,$C2,$F5,$F6,$11,$11,$11
	dc.b	$11,$FF

Bank080000_FFTerminatedCommandRecord_09E117:
	dc.b	$F4,$05,$C2,$F5,$1C,$00,$FA,$00,$FA,$F5,$F6,$05,$FA,$F5,$0A,$0D
	dc.b	$FA,$0C,$FA,$F5,$F6,$05,$05,$05,$FA,$05,$FA,$F5,$0A,$0C,$FA,$0C
	dc.b	$FA,$F5,$F6,$05,$FA,$F5,$0A,$0C,$FA,$F5,$F6,$05,$05,$F5,$0A,$0C
	dc.b	$0C,$F5,$F6,$05,$FA,$05,$05,$FF

Bank080000_FFTerminatedCommandRecord_09E14F:
	dc.b	$F4,$05,$C2,$F5,$1C,$00,$FA,$00,$FA,$F5,$F6,$05,$FA,$F5,$0A,$0D
	dc.b	$FA,$0C,$FA,$F5,$F6,$05,$05,$05,$FA,$05,$FA,$F5,$0A,$65,$0C,$FA
	dc.b	$65,$0C,$65,$0C,$05,$F5,$F6,$05,$05,$05,$05,$FA,$65,$F5,$0A,$0C
	dc.b	$F5,$F6,$65,$F5,$0A,$0C,$F5,$EC,$65,$F5,$0A,$0E,$F5,$F6,$05,$65
	dc.b	$F5,$0A,$0D,$F5,$F6,$05,$FF

Bank080000_FFTerminatedCommandRecord_09E196:
	dc.b	$F4,$05,$C2,$F5,$12,$00,$FA,$05,$FA,$00,$FA,$05,$FA,$00,$00,$05
	dc.b	$FA,$00,$FA,$05,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09E1AC:
	dc.b	$F4,$05,$C2,$F5,$12,$00,$FA,$05,$FA,$05,$C4,$FA,$C2,$05,$60,$05
	dc.b	$60,$05,$C4,$FA,$C2,$60,$05,$FA,$05,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09E1C7:
	dc.b	$F4,$05,$C8,$FA,$FF

; This short bridge returns to the denser local-control style: a same-window sweep plus one
; local-offset-like seed before a compact `F4 FE` literal pair row rooted on `0x2B/0x2D/0x2E`.
Bank080000_LocalControlSweepAndLiteralPairCommandRecord_09E1CC:
Bank080000_FFTerminatedCommandRecord_09E1CC:
	dc.b	$F8,$D0,$C7,$E1,$D0,$AB,$E0,$D0,$E5,$E0,$D0,$AB,$E0,$D0,$E5,$E0
	dc.b	$D2,$17,$E1,$D0,$4F,$E1,$D2,$96,$E1,$D0,$AC,$E1,$D2,$96,$E1,$D0
	dc.b	$AC,$E1,$D2,$17,$E1,$D0,$4F,$E1,$FD,$D0,$E1,$88,$46,$02,$58,$DE
	dc.b	$AF,$DE,$28,$E0,$8A,$E0,$CC,$E1,$00,$00,$F4,$FE,$C4,$F1,$0D,$F5
	dc.b	$0D,$2B,$2D,$2E,$2B,$2D,$2E,$2B,$2D,$FF

Bank080000_FFTerminatedCommandRecord_09E216:
	dc.b	$F4,$FE,$C4,$F1,$0D,$F5,$0D,$30,$31,$30,$31,$30,$C2,$31,$C4,$30
	dc.b	$C2,$30,$C4,$31,$FF

Bank080000_FFTerminatedCommandRecord_09E22B:
	dc.b	$F4,$FE,$C4,$F1,$0D,$F5,$03,$30,$30,$C9,$FA,$FF

; This neighboring run stays in the same local-sweep neighborhood, but the front record shifts into
; a short literal climb rooted on 0x4F/0x51/0x52 before the repeated AF/AE/AD high-byte rows take over.
Bank080000_LocalControlSweepAndLiteralClimbCommandRecord_09E237:
Bank080000_FFTerminatedCommandRecord_09E237:
	dc.b	$F7,$01,$F0,$06,$CA,$FA,$D7,$06,$E2,$D6,$16,$E2,$D0,$2B,$E2,$FD
	dc.b	$3D,$E2,$F4,$04,$C4,$F1,$0A,$F5,$21,$4F,$51,$52,$4F,$55,$56,$4F
	dc.b	$59,$5B,$55,$59,$C2,$58,$55,$C4,$58,$52,$56,$51,$FF

; The next trio keeps one compact `F4 00 C2` frame and walks down AF/AE/AD high-byte pairs, with
; the short neighbors collapsing that same shape into two AC-rooted local-offset variants.
Bank080000_DescendingHighBytePairAndLocalOffsetCommandFamily_09E264:
Bank080000_FFTerminatedCommandRecord_09E264:
	dc.b	$F4,$00,$C2,$F1,$0D,$F5,$17,$AF,$52,$FA,$AF,$52,$E2,$54,$FA,$C2
	dc.b	$AF,$52,$FA,$AF,$52,$C5,$B2,$56,$C2,$AE,$51,$FA,$AE,$51,$E2,$54
	dc.b	$FA,$C2,$AE,$51,$FA,$AE,$51,$C5,$B1,$56,$C2,$AD,$50,$FA,$AD,$50
	dc.b	$E2,$54,$FA,$C2,$AD,$50,$FA,$AD,$50,$C5,$B0,$54,$FF

Bank080000_FFTerminatedCommandRecord_09E2A1:
	dc.b	$F4,$00,$C2,$F1,$0D,$F5,$17,$AC,$4F,$FA,$AC,$4F,$E2,$9C,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09E2B1:
	dc.b	$F4,$00,$C2,$F1,$0C,$F5,$08,$AC,$4F,$FA,$AC,$4F,$E2,$9C,$FA,$FF

; This bridge returns to the broader local-control sweep shape, then spends the payload on a long
; descending 0x57..0x4A literal/high-byte ladder before handing off to shorter AA/A8/A5 clusters.
Bank080000_LocalControlSweepAndDescendingHighByteLadderCommandRecord_09E2C1:
Bank080000_FFTerminatedCommandRecord_09E2C1:
	dc.b	$F7,$0E,$F3,$00,$F4,$CA,$FA,$F0,$1D,$D3,$49,$E2,$F0,$1F,$D0,$64
	dc.b	$E2,$D0,$A1,$E2,$D0,$64,$E2,$D0,$B1,$E2,$FD,$C8,$E2,$F4,$08,$C2
	dc.b	$F1,$10,$F5,$17,$57,$56,$55,$54,$B2,$57,$B1,$56,$AF,$55,$AE,$54
	dc.b	$AD,$52,$AC,$51,$AB,$4F,$AA,$4E,$A8,$4D,$A6,$4C,$A5,$4B,$A3,$4A
	dc.b	$FF

; The next four records keep the same `F4 08` neighborhood but narrow from repeated E2-tagged AA/A9/A8
; rows into one A7-centered pair ladder, one literal tail, and two short literal-band closers.
Bank080000_HighBytePairAndLiteralTailCommandFamily_09E302:
Bank080000_FFTerminatedCommandRecord_09E302:
	dc.b	$F4,$08,$E2,$9C,$F1,$10,$F5,$17,$AA,$4D,$C2,$FA,$C4,$AA,$4D,$E2
	dc.b	$9C,$A9,$4C,$C2,$FA,$C4,$A9,$4C,$E2,$9C,$A8,$4B,$C2,$FA,$C4,$A8
	dc.b	$4B,$FF

Bank080000_FFTerminatedCommandRecord_09E324:
	dc.b	$F4,$08,$C5,$F1,$0D,$F5,$17,$A7,$4A,$C2,$A7,$4A,$A7,$4A,$FA,$AF
	dc.b	$52,$FA,$A7,$4A,$FA,$AD,$51,$FA,$A7,$4A,$FA,$A8,$4C,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09E343:
	dc.b	$F4,$08,$C5,$F1,$0D,$F5,$17,$A7,$4A,$C2,$A7,$4A,$A7,$4A,$FA,$5B
	dc.b	$59,$58,$57,$56,$55,$53,$4F,$4D,$4A,$FF

Bank080000_FFTerminatedCommandRecord_09E35D:
	dc.b	$F4,$08,$C4,$F1,$10,$F5,$21,$3C,$43,$48,$49,$42,$43,$48,$49,$FF

Bank080000_FFTerminatedCommandRecord_09E36D:
	dc.b	$F4,$08,$F3,$00,$0C,$C4,$F1,$0D,$F5,$21,$35,$F1,$08,$41,$48,$4D
	dc.b	$3C,$48,$4D,$54,$F3,$00,$F4,$FF

; These short neighbors keep the same compact `F4 08` framing as the surrounding family but
; narrow into one small literal crest around `0x41/0x4D/0x54/0x59` and a tiny `0x43` cap.
Bank080000_CompactLiteralCrestCommandFamily_09E385:
Bank080000_FFTerminatedCommandRecord_09E385:
	dc.b	$F4,$08,$C4,$F1,$0D,$F5,$21,$41,$F1,$08,$4D,$54,$59,$41,$4D,$48
	dc.b	$41,$FF

Bank080000_FFTerminatedCommandRecord_09E397:
	dc.b	$F4,$08,$C4,$F1,$08,$F5,$21,$43,$43,$C9,$FA,$FF

; This bridge returns to the broader local-control sweep shape, then drops into a compact
; literal-control pocket around `0x00/0x05/0x0D` before FF.
Bank080000_LocalControlSweepAndLiteralControlCommandRecord_09E3A3:
Bank080000_FFTerminatedCommandRecord_09E3A3:
	dc.b	$F7,$0E,$F0,$0A,$F3,$00,$F4,$D0,$DE,$E2,$F0,$0A,$D0,$02,$E3,$D0
	dc.b	$24,$E3,$D0,$02,$E3,$D0,$43,$E3,$F0,$21,$D0,$5D,$E3,$D0,$6D,$E3
	dc.b	$D0,$5D,$E3,$D0,$85,$E3,$D0,$5D,$E3,$D0,$6D,$E3,$D0,$5D,$E3,$D0
	dc.b	$97,$E3,$FD,$AD,$E3,$F4,$00,$C4,$F5,$12,$00,$C2,$05,$FA,$00,$FA
	dc.b	$05,$FA,$00,$FA,$05,$C5,$FA,$C2,$05,$FA,$FF

; The next pair stays in the same `F4 00` neighborhood but tightens into short literal-control
; rows before the longer repeated pair ladder at `0x09E424`.
Bank080000_CompactLiteralControlCommandFamily_09E3EE:
Bank080000_FFTerminatedCommandRecord_09E3EE:
	dc.b	$F4,$00,$C4,$F5,$12,$00,$FA,$05,$C2,$F5,$0A,$0E,$0E,$0D,$0D,$0D
	dc.b	$0D,$0C,$0C,$0C,$0C,$FF

Bank080000_FFTerminatedCommandRecord_09E404:
	dc.b	$F4,$00,$C2,$F5,$08,$05,$FA,$05,$FA,$0D,$0C,$F5,$0A,$05,$FA,$05
	dc.b	$FA,$05,$05,$F5,$14,$05,$F5,$F6,$05,$F5,$F6,$05,$F5,$F6,$05,$FF

; This longer bridge starts with a compact local-control / local-offset prelude, then spends most
; of its body on repeated `0x2B/0x2A/0x29/0x28` literal-pair ladders before the short tail.
Bank080000_LocalControlAndRepeatedLiteralPairLadderCommandRecord_09E424:
Bank080000_FFTerminatedCommandRecord_09E424:
	dc.b	$F8,$CA,$FA,$D6,$D8,$E3,$D0,$EE,$E3,$D6,$D8,$E3,$D0,$04,$E4,$FD
	dc.b	$27,$E4,$88,$1C,$02,$37,$E2,$C1,$E2,$A3,$E3,$24,$E4,$00,$00,$F4
	dc.b	$F8,$C7,$F1,$04,$F5,$17,$2B,$C4,$F1,$0D,$2B,$C7,$FA,$C4,$2B,$2A
	dc.b	$C6,$FA,$C4,$2A,$C7,$FA,$C4,$2A,$29,$C6,$FA,$C4,$29,$C7,$FA,$C4
	dc.b	$29,$28,$C6,$FA,$C4,$28,$FA,$C2,$26,$28,$C4,$2B,$2D,$30,$C6,$FA
	dc.b	$C2,$30,$28,$FA,$28,$2B,$FA,$C4,$30,$28,$2B,$C6,$FA,$C4,$2B,$C7
	dc.b	$FA,$C4,$2B,$2D,$C6,$FA,$C4,$2D,$FA,$34,$FA,$2D,$32,$FA,$30,$FA
	dc.b	$2F,$FA,$2D,$FA,$C7,$F1,$04,$2B,$C4,$F1,$0D,$2B,$C7,$FA,$C4,$2B
	dc.b	$2A,$C6,$FA,$C4,$2A,$C7,$FA,$C4,$2A,$29,$C6,$FA,$C4,$29,$C7,$FA
	dc.b	$C4,$29,$28,$C6,$FA,$C4,$28,$FA,$C2,$26,$28,$C4,$2B,$2D,$30,$C6
	dc.b	$FA,$C2,$30,$28,$FA,$28,$2B,$FA,$C4,$30,$28,$2B,$C6,$FA,$C4,$2B
	dc.b	$C7,$FA,$C4,$2B,$2D,$C6,$FA,$C4,$2D,$C7,$FA,$C4,$2D,$2B,$C6,$FA
	dc.b	$C4,$2B,$C7,$FA,$C4,$2B,$FF

Bank080000_FFTerminatedCommandRecord_09E4EB:
	dc.b	$C6,$FA,$FF

; This short follow-on returns to a compact local-target setup, then rises through one small
; literal band rooted on `0x3E/0x40/0x41/0x42`.
Bank080000_LocalTargetSetupAndLiteralRiseCommandRecord_09E4EE:
Bank080000_FFTerminatedCommandRecord_09E4EE:
	dc.b	$F6,$00,$F7,$01,$F0,$07,$F2,$00,$0C,$D0,$EB,$E4,$D0,$43,$E4,$FD
	dc.b	$FA,$E4,$F4,$08,$C2,$F1,$0D,$F5,$17,$3E,$40,$41,$42,$FF

; The next longer record keeps the same `F4 08` framing but expands into repeated literal/high-byte
; rows around `0x43/0x47/0x48/0x4A/0x4C`, ending on a short E2-tagged descent.
Bank080000_LiteralAndHighByteLadderCommandRecord_09E50C:
Bank080000_FFTerminatedCommandRecord_09E50C:
	dc.b	$F4,$08,$C7,$F1,$0D,$F5,$17,$43,$C4,$47,$48,$47,$45,$43,$C7,$45
	dc.b	$C4,$3E,$C6,$3E,$C2,$3E,$40,$41,$42,$C7,$43,$C4,$47,$48,$47,$45
	dc.b	$43,$C9,$4A,$C4,$48,$4A,$4C,$4C,$4C,$4C,$4C,$4A,$48,$C7,$4A,$C4
	dc.b	$4C,$C7,$47,$C4,$45,$47,$49,$49,$49,$49,$49,$4A,$4C,$45,$C9,$4A
	dc.b	$C2,$3E,$40,$41,$42,$C7,$43,$C4,$47,$48,$47,$45,$43,$C7,$45,$C4
	dc.b	$3E,$C6,$3E,$C2,$3E,$40,$41,$42,$C7,$43,$C4,$47,$48,$47,$45,$43
	dc.b	$C9,$4A,$C4,$48,$4A,$4C,$4C,$4C,$4C,$4C,$4A,$48,$C7,$4A,$C4,$4C
	dc.b	$C7,$47,$C4,$45,$47,$48,$48,$48,$48,$48,$47,$45,$E2,$A8,$F1,$10
	dc.b	$F5,$05,$43,$C2,$F1,$0D,$F5,$FB,$3E,$40,$41,$42,$FF

; This local-control pocket narrows into a short literal descent around `0x53/0x58/0x56/0x4F`,
; followed by two tiny neighbors and a short cap.
Bank080000_LocalControlSweepAndLiteralDescentCommandFamily_09E599:
Bank080000_FFTerminatedCommandRecord_09E599:
	dc.b	$F6,$00,$F7,$0A,$F0,$29,$D0,$00,$E5,$D0,$0C,$E5,$FD,$A2,$E5,$F4
	dc.b	$FA,$CA,$F1,$10,$F5,$21,$53,$C8,$58,$56,$CA,$4F,$C7,$56,$C4,$54
	dc.b	$C8,$54,$CA,$58,$C8,$56,$53,$FF

Bank080000_FFTerminatedCommandRecord_09E5C1:
	dc.b	$F4,$FA,$CA,$F5,$21,$51,$C8,$56,$54,$FF

Bank080000_FFTerminatedCommandRecord_09E5CB:
	dc.b	$F4,$FA,$CA,$F5,$21,$51,$4F,$FF

Bank080000_FFTerminatedCommandRecord_09E5D3:
	dc.b	$C6,$FA,$FF

; The next short bridge returns to a local-control setup and ends on one compact
; `0x60/0x0F/0x10/0x05` literal-control burst before two tiny caps.
Bank080000_LocalControlAndLiteralControlBurstCommandRecord_09E5D6:
Bank080000_FFTerminatedCommandRecord_09E5D6:
	dc.b	$F6,$00,$F7,$04,$F0,$20,$D0,$D3,$E5,$D0,$A8,$E5,$D0,$C1,$E5,$D0
	dc.b	$A8,$E5,$D0,$CB,$E5,$FD,$DF,$E5,$F4,$04,$C4,$F5,$12,$60,$0F,$10
	dc.b	$0F,$60,$0F,$0F,$0F,$05,$60,$0F,$FF

Bank080000_FFTerminatedCommandRecord_09E5FF:
	dc.b	$F4,$04,$C6,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09E604:
	dc.b	$F8,$D0,$FF

; Another 0xAB-byte FF-terminated record uses the same compact control framing but expands
; into a long repeated byte-pair ladder across several adjacent values.
Bank080000_RepeatedBytePairCommandRecord_09E607:
Bank080000_FFTerminatedCommandRecord_09E607:
	dc.b	$E5,$D7,$EE,$E5,$D7,$EE,$E5,$FD,$08,$E6,$88,$AA,$01,$EE,$E4,$99
	dc.b	$E5,$D6,$E5,$04,$E6,$00,$00,$F4,$00,$C2,$F1,$0C,$F5,$0D,$33,$33
	dc.b	$3F,$FA,$C4,$F1,$0D,$32,$C2,$3E,$FA,$C4,$F1,$0D,$30,$C2,$3C,$FA
	dc.b	$C4,$2E,$C2,$3A,$FA,$33,$33,$3F,$FA,$C4,$32,$C2,$3E,$FA,$C4,$30
	dc.b	$C2,$3C,$FA,$C4,$2E,$C2,$3A,$FA,$C4,$32,$C2,$3E,$FA,$C4,$30,$C2
	dc.b	$3C,$FA,$C4,$2E,$C2,$3A,$FA,$C4,$2D,$C2,$39,$FA,$C4,$2B,$C2,$37
	dc.b	$37,$C4,$2D,$C2,$39,$39,$C4,$2E,$C2,$3A,$3A,$C4,$30,$C2,$3C,$3C
	dc.b	$33,$33,$3F,$FA,$C4,$32,$C2,$3E,$FA,$C4,$30,$C2,$3C,$FA,$C4,$2E
	dc.b	$C2,$3A,$FA,$33,$33,$3F,$FA,$C4,$32,$C2,$3E,$FA,$C4,$30,$C2,$3C
	dc.b	$FA,$C4,$2E,$C2,$3A,$FA,$C4,$32,$C2,$3E,$FA,$C4,$30,$C2,$3C,$FA
	dc.b	$C4,$2E,$C2,$3A,$FA,$C4,$2D,$C2,$39,$FA,$FF

; This adjacent pair keeps the same compact F4/F1/F5 framing as the surrounding repeated-shape
; records, but narrows into two shorter low-byte ladders with C0/C2/C4/C6 control pockets.
Bank080000_CompactLowByteLadderCommandPair_09E6B2:
Bank080000_FFTerminatedCommandRecord_09E6B2:
	dc.b	$F4,$00,$C0,$F1,$0B,$F5,$0D,$2B,$29,$28,$26,$C4,$FA,$C0,$2E,$2D
	dc.b	$2B,$29,$C6,$FA,$C4,$F1,$0D,$26,$28,$29,$FF

Bank080000_FFTerminatedCommandRecord_09E6CD:
	dc.b	$F4,$00,$C4,$F1,$0D,$F5,$0D,$2B,$C2,$FA,$C4,$29,$C2,$FA,$C4,$2B
	dc.b	$FA,$2E,$30,$32,$FF

Bank080000_FFTerminatedCommandRecord_09E6E2:
	dc.b	$F4,$00,$C4,$F1,$0D,$F5,$0D,$2B,$C2,$FA,$C4,$29,$C2,$FA,$C4,$27
	dc.b	$FA,$2E,$30,$32,$FF

; This local triplet repeats one control header with three different byte-pair payloads before
; the surrounding longer record at 0x09E73F, so keep the repeated 0x18-byte family explicit.
Bank080000_RepeatedTwentyFourByteCommandRecordTriplet_09E6F7:
Bank080000_FFTerminatedCommandRecord_09E6F7:
	dc.b	$F4,$00,$C4,$F1,$0D,$F5,$0D,$33,$33,$33,$33,$33,$33,$33,$33,$32
	dc.b	$32,$32,$32,$32,$32,$32,$32,$FF

Bank080000_FFTerminatedCommandRecord_09E70F:
	dc.b	$F4,$00,$C4,$F1,$0D,$F5,$0D,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$30
	dc.b	$30,$30,$30,$30,$3C,$30,$3C,$FF

Bank080000_FFTerminatedCommandRecord_09E727:
	dc.b	$F4,$00,$C4,$F1,$0D,$F5,$0D,$2B,$2B,$2B,$2B,$2D,$2D,$2D,$2D,$2E
	dc.b	$2E,$2E,$2E,$30,$30,$32,$32,$FF

; The next neighboring pair begins with one local-offset-like E3 seed and a short byte-pair walk,
; then follows with a longer C2/C4/C5-marked continuation before the later larger record.
Bank080000_LocalSeedAndLowByteLadderCommandPair_09E73F:
Bank080000_FFTerminatedCommandRecord_09E73F:
	dc.b	$F4,$00,$E3,$80,$01,$F1,$10,$F5,$0A,$33,$CA,$32,$C4,$F1,$0D,$2B
	dc.b	$37,$2D,$39,$2E,$3A,$2F,$3B,$FF

Bank080000_FFTerminatedCommandRecord_09E757:
	dc.b	$F4,$00,$C4,$F1,$0D,$F5,$0D,$30,$C2,$FA,$C4,$2E,$C2,$FA,$C4,$30
	dc.b	$FA,$2B,$2E,$37,$F5,$0A,$32,$C2,$FA,$C4,$30,$C2,$FA,$C4,$32,$FA
	dc.b	$2E,$2D,$2B,$33,$C2,$FA,$C4,$32,$C2,$FA,$C4,$30,$FA,$2D,$2E,$30
	dc.b	$C5,$32,$30,$C4,$2E,$C5,$2D,$2B,$C4,$29,$FF

; This longer bridge starts with another compact local-target sweep, then spends most of its
; body on repeated 0x9x/0xAx high-byte ladders around the same 0x43/0x45/0x48/0x4A/0x4D family,
; and finally drops through several E4-tagged local-offset tails before FF.
Bank080000_LocalTargetSweepAndHighBytePairLadderCommandRecord_09E792:
Bank080000_FFTerminatedCommandRecord_09E792:
	dc.b	$F7,$01,$F0,$09,$D0,$1E,$E6,$D0,$B2,$E6,$D2,$CD,$E6,$D0,$E2,$E6
	dc.b	$D2,$CD,$E6,$D0,$E2,$E6,$D0,$F7,$E6,$D0,$0F,$E7,$D0,$F7,$E6,$D0
	dc.b	$27,$E7,$D2,$CD,$E6,$D0,$E2,$E6,$D0,$3F,$E7,$D0,$57,$E7,$FD,$9C
	dc.b	$E7,$F4,$10,$C4,$F1,$0D,$F5,$0A,$A6,$4A,$C2,$F1,$0C,$A3,$48,$A3
	dc.b	$46,$A3,$F1,$10,$48,$FA,$F1,$0C,$9F,$43,$C5,$FA,$C2,$9F,$43,$9E
	dc.b	$41,$9F,$43,$A1,$45,$A3,$46,$A5,$48,$9E,$41,$9F,$43,$FA,$9E,$41
	dc.b	$9F,$43,$FA,$9F,$43,$A1,$45,$FA,$9F,$48,$A1,$4A,$FA,$A1,$F1,$10
	dc.b	$4A,$FA,$F1,$0C,$A5,$4D,$FA,$C4,$F1,$0D,$A5,$4D,$C2,$F1,$0C,$A5
	dc.b	$4D,$FA,$A1,$4A,$9F,$48,$FA,$C4,$F1,$0D,$A1,$4A,$C2,$F1,$0C,$A1
	dc.b	$4A,$9F,$48,$FA,$C4,$F1,$0D,$9E,$41,$9F,$43,$AA,$4F,$FA,$A8,$4D
	dc.b	$FA,$A8,$4B,$FA,$C6,$A6,$4A,$C4,$A6,$4A,$C2,$F1,$0C,$A3,$48,$A3
	dc.b	$46,$A3,$F1,$10,$48,$FA,$F1,$0C,$9F,$43,$C5,$FA,$C2,$9F,$43,$9E
	dc.b	$41,$9F,$43,$A1,$45,$A3,$46,$A5,$48,$9E,$41,$9F,$43,$FA,$9E,$41
	dc.b	$9F,$43,$FA,$9F,$43,$A1,$45,$FA,$9F,$48,$A1,$4A,$FA,$A1,$F1,$10
	dc.b	$4A,$FA,$F1,$0C,$A5,$4D,$FA,$E4,$A0,$01,$C4,$F1,$0D,$A5,$4D,$C2
	dc.b	$F1,$0C,$A5,$4D,$FA,$A1,$4A,$9F,$48,$FA,$C4,$F1,$0D,$A1,$4A,$C2
	dc.b	$F1,$0C,$A1,$4A,$9F,$48,$FA,$C4,$F1,$0D,$9E,$41,$9F,$43,$E4,$A8
	dc.b	$01,$C0,$F1,$10,$A3,$46,$A1,$45,$9F,$43,$9E,$41,$E4,$B0,$01,$9F
	dc.b	$43,$C3,$FA,$C0,$A5,$48,$A3,$46,$E4,$C0,$01,$A1,$45,$9F,$43,$9E
	dc.b	$41,$E2,$72,$FA,$E4,$ED,$01,$FF

; This adjacent record keeps the same compact F4/F1/F5 framing but collapses into repeated
; 0x9F/0x3E and 0x9E/0x3C byte-pair rows with short F5 FB / F5 05 variations and E4-tagged
; local-offset hops near the tail.
Bank080000_RepeatedHighBytePairAndLocalOffsetCommandRecord_09E8CA:
Bank080000_FFTerminatedCommandRecord_09E8CA:
	dc.b	$F4,$10,$C4,$F1,$0D,$F5,$10,$9F,$46,$3E,$9F,$46,$3E,$F5,$FB,$9F
	dc.b	$46,$3E,$9F,$46,$3E,$F5,$FB,$9F,$46,$3E,$F5,$05,$9F,$46,$3E,$F5
	dc.b	$05,$9F,$46,$3E,$9F,$46,$3E,$9E,$45,$3C,$9E,$45,$3C,$F5,$FB,$9E
	dc.b	$45,$3C,$E4,$DC,$01,$F5,$FB,$9E,$45,$3C,$E4,$D0,$01,$2B,$97,$3A
	dc.b	$E4,$CC,$01,$F5,$FB,$2D,$97,$3A,$E4,$D0,$01,$F5,$FB,$2E,$97,$3A
	dc.b	$E4,$D4,$01,$F5,$FB,$2F,$97,$3A,$E4,$ED,$01,$FF

; The next short bridge returns to the compact local-control sweep shape, with repeated
; CA/DF/FE pockets up front and a small literal/high-byte continuation around 0x43/0x46/0x4B
; before the final FF.
Bank080000_LocalControlSweepAndLiteralCommandRecord_09E926:
Bank080000_FFTerminatedCommandRecord_09E926:
	dc.b	$F7,$0E,$F0,$21,$F3,$00,$00,$E4,$84,$01,$D0,$C3,$E7,$CA,$DF,$FA
	dc.b	$FE,$DF,$FA,$FE,$DB,$FA,$FE,$D0,$CA,$E8,$DB,$CA,$FA,$FE,$FD,$33
	dc.b	$E9,$F4,$1B,$C4,$F1,$0D,$F5,$FC,$43,$46,$4B,$C6,$4A,$C4,$43,$46
	dc.b	$E2,$D8,$48,$C4,$FA,$46,$43,$46,$41,$46,$3F,$46,$FF

; This follow-on continuation keeps the same F4/F1/F5 framing while stepping through a denser
; 0x48/0x4A/0x4B/0x4D front, then falling into a mixed literal and high-byte-pair descent.
Bank080000_HighBytePairAndLiteralLadderCommandRecord_09E963:
Bank080000_FFTerminatedCommandRecord_09E963:
	dc.b	$F4,$1B,$C4,$F1,$0D,$F5,$FC,$48,$C2,$F1,$0C,$4A,$E2,$9C,$F1,$0D
	dc.b	$4B,$C4,$4A,$C2,$F1,$0C,$4B,$E2,$9C,$F1,$0D,$4D,$C4,$4B,$C2,$F1
	dc.b	$0C,$4D,$C5,$4F,$C2,$4B,$4D,$4F,$FA,$C4,$F1,$0D,$46,$4B,$4F,$C2
	dc.b	$F1,$0C,$51,$52,$51,$4F,$C4,$F1,$0D,$51,$4F,$4E,$4A,$48,$46,$FF

; This neighboring bridge keeps the same F4/F1/F5 framing as 0x09E963, but narrows into two
; short 0x43/0x35/0x37 passes before a tiny literal descent.
Bank080000_CompactLiteralDescentCommandRecord_09E9A3:
Bank080000_FFTerminatedCommandRecord_09E9A3:
	dc.b	$F4,$1B,$C8,$F1,$0D,$F5,$FC,$43,$C0,$F1,$0B,$F5,$F6,$35,$C3,$F1
	dc.b	$10,$37,$C4,$F1,$0D,$F5,$0A,$43,$C0,$F1,$0B,$F5,$F6,$35,$C3,$F1
	dc.b	$10,$37,$C4,$F1,$0D,$F5,$0A,$43,$FF

Bank080000_FFTerminatedCommandRecord_09E9CC:
	dc.b	$F4,$1B,$C8,$F1,$0D,$F5,$FC,$43,$C4,$FA,$43,$41,$3E,$FF

Bank080000_FFTerminatedCommandRecord_09E9DA:
	dc.b	$F4,$1B,$CF,$FA,$C4,$F1,$0D,$F5,$F2,$3E,$40,$41,$FF


; This neighboring pocket continues the same `F4 1B` command family as 0x09E963-0x09E9E6, but here
; the record widens into a longer literal/high-byte ladder around the recurring `0x43/0x46/0x48/0x4A/0x4D`
; band before tapering into one final repeated `0x4A/0x56` tail.
Bank080000_LiteralAndHighByteLadderCommandRecord_09E9E7:
Bank080000_FFTerminatedCommandRecord_09E9E7:
	dc.b	$F4,$1B,$C4,$FA,$F1,$0D,$F5,$FC,$43,$49,$43,$46,$C6,$48,$C4,$49
	dc.b	$48,$4A,$4D,$C6,$4A,$C2,$F1,$0C,$4A,$48,$46,$48,$43,$46,$C4,$FA
	dc.b	$F1,$0D,$43,$46,$43,$45,$C6,$41,$C4,$48,$C7,$4A,$C2,$F1,$0C,$48
	dc.b	$46,$C6,$F1,$0D,$43,$FA,$C4,$FA,$4F,$C6,$4F,$C4,$49,$48,$C2,$F1
	dc.b	$0C,$45,$46,$C4,$F1,$0D,$43,$4A,$C6,$4D,$C2,$F1,$0C,$48,$46,$C6
	dc.b	$F1,$0D,$48,$C4,$F1,$10,$4A,$C2,$F1,$0C,$46,$43,$C4,$F1,$0D,$46
	dc.b	$43,$45,$46,$C6,$48,$C4,$4B,$48,$4D,$C6,$4A,$C2,$F1,$0C,$46,$48
	dc.b	$C4,$F1,$0D,$4A,$56,$4A,$56,$FF

; The next bridge revisits the compact local-control sweep shape: one `F7/F0/F3` setup pocket walks
; several same-window targets before dropping into a short `0x99/0x9B/0x9C` high-byte pair tail.
Bank080000_LocalControlSweepAndHighBytePairCommandRecord_09EA5F:
Bank080000_FFTerminatedCommandRecord_09EA5F:
	dc.b	$F7,$0E,$F0,$25,$F3,$00,$F4,$CA,$DE,$FA,$FE,$D0,$DA,$E9,$F0,$25
	dc.b	$D0,$47,$E9,$D0,$A3,$E9,$D0,$47,$E9,$D0,$CC,$E9,$D0,$E7,$E9,$D0
	dc.b	$47,$E9,$D0,$A3,$E9,$CA,$DB,$FA,$FE,$F0,$0A,$D0,$63,$E9,$FD,$6D
	dc.b	$EA,$F4,$1F,$CF,$FA,$C4,$F1,$10,$F5,$F2,$99,$3E,$9B,$40,$9C,$41
	dc.b	$FF

; Five adjacent records keep the same compact `F4 1F` front while varying only the descending
; high-byte-pair ladders and short literal tails that follow.
Bank080000_HighBytePairLadderCommandFamily_09EAA0:
Bank080000_FFTerminatedCommandRecord_09EAA0:
	dc.b	$F4,$1F,$C5,$F1,$10,$F5,$06,$9E,$43,$C4,$9C,$41,$C2,$FA,$9E,$43
	dc.b	$C5,$FA,$C4,$46,$45,$41,$FF

Bank080000_FFTerminatedCommandRecord_09EAB7:
	dc.b	$F4,$1F,$C5,$F1,$10,$F5,$06,$9E,$43,$C4,$9C,$41,$C2,$FA,$9E,$43
	dc.b	$FA,$F5,$F6,$32,$37,$32,$39,$32,$3A,$32,$3C,$FF

Bank080000_FFTerminatedCommandRecord_09EAD3:
	dc.b	$F4,$1F,$C5,$F1,$10,$F5,$06,$9E,$43,$C4,$9C,$41,$C2,$FA,$9A,$3F
	dc.b	$FA,$C6,$99,$3E,$97,$3C,$FF

Bank080000_FFTerminatedCommandRecord_09EAEA:
	dc.b	$F4,$1F,$C5,$F1,$10,$F5,$06,$9E,$43,$C4,$9C,$41,$C2,$FA,$9A,$3F
	dc.b	$FA,$C4,$99,$3E,$F5,$F6,$AF,$52,$AD,$51,$AA,$4D,$FF

; This next trio keeps the same `F4 1F` neighborhood but narrows into shorter literal-descent
; rows rather than the denser high-byte ladders above.
Bank080000_CompactLiteralDescentCommandFamily_09EB07:
Bank080000_FFTerminatedCommandRecord_09EB07:
	dc.b	$F4,$1F,$C4,$F1,$0D,$F5,$FC,$3F,$37,$3A,$3C,$FA,$C6,$3F,$C2,$F1
	dc.b	$0C,$39,$3C,$C4,$F1,$0D,$3E,$35,$3A,$39,$FA,$C6,$37,$C4,$35,$FF

Bank080000_FFTerminatedCommandRecord_09EB27:
	dc.b	$F4,$1F,$C4,$F1,$0D,$F5,$FC,$3A,$35,$37,$3A,$FA,$35,$37,$3A,$3C
	dc.b	$37,$39,$3C,$FA,$F1,$10,$3A,$39,$35,$FF

Bank080000_FFTerminatedCommandRecord_09EB41:
	dc.b	$F4,$1F,$C8,$F1,$10,$F5,$FC,$37,$39,$3A,$C6,$97,$3C,$99,$3E,$FF

; This longer continuation reuses the same compact framing but expands into one dense literal/control
; pocket around `0x4A/0x48/0x46/0x43/0x41`, then finishes with a short `0x4F/0x4D/0x4B/0x4A` tail.
Bank080000_LiteralControlPocketCommandRecord_09EB51:
Bank080000_FFTerminatedCommandRecord_09EB51:
	dc.b	$F4,$1F,$C4,$F1,$10,$F5,$F6,$4A,$C2,$48,$46,$C4,$48,$C2,$43,$C5
	dc.b	$FA,$C2,$43,$41,$43,$45,$46,$48,$41,$43,$FA,$41,$43,$FA,$43,$45
	dc.b	$FA,$48,$4A,$FA,$C4,$4A,$C2,$4D,$FA,$C4,$F1,$0D,$4D,$C2,$4D,$FA
	dc.b	$F1,$10,$4A,$48,$FA,$C4,$F1,$0D,$4A,$C2,$4A,$F1,$10,$48,$FA,$C4
	dc.b	$41,$43,$C6,$4F,$4D,$4B,$4A,$FF

; This neighboring record mixes one short `0xA3/0xA6` high-byte pocket, two literal descents, and a
; final `0x92`-anchored tail instead of keeping to only one repeated pair family.
Bank080000_HighByteAndLiteralLadderCommandRecord_09EB99:
Bank080000_FFTerminatedCommandRecord_09EB99:
	dc.b	$F4,$1F,$C5,$F1,$10,$F5,$06,$A3,$3C,$A6,$3F,$C2,$A3,$3C,$C5,$FA
	dc.b	$C4,$3A,$39,$35,$C5,$A5,$3E,$A8,$41,$C2,$A5,$3E,$C5,$FA,$C4,$3A
	dc.b	$39,$35,$C5,$9F,$46,$9E,$45,$C6,$9C,$43,$C4,$9A,$3F,$99,$3E,$97
	dc.b	$3C,$C5,$92,$3E,$92,$43,$C4,$92,$4A,$C5,$92,$45,$92,$42,$C4,$92
	dc.b	$3E,$FF

; Another compact sweep returns to the same local-control style seen elsewhere in the tail window,
; then resolves into a short `0x60/0x0F/0x65` literal-control burst before FF.
Bank080000_LocalControlBurstCommandRecord_09EBDB:
Bank080000_FFTerminatedCommandRecord_09EBDB:
	dc.b	$F7,$0E,$CA,$DE,$FA,$FE,$F0,$0A,$F3,$00,$F4,$D0,$90,$EA,$D0,$A0
	dc.b	$EA,$D0,$B7,$EA,$D0,$A0,$EA,$D0,$D3,$EA,$D0,$A0,$EA,$D0,$B7,$EA
	dc.b	$D0,$A0,$EA,$D0,$EA,$EA,$D0,$07,$EB,$D0,$27,$EB,$D0,$07,$EB,$D0
	dc.b	$41,$EB,$D0,$A0,$EA,$D0,$B7,$EA,$D0,$A0,$EA,$D0,$D3,$EA,$D0,$51
	dc.b	$EB,$D0,$99,$EB,$FD,$E9,$EB,$F4,$00,$C4,$F5,$0C,$60,$F5,$14,$0F
	dc.b	$C2,$10,$FA,$F5,$EC,$60,$F5,$14,$0F,$FA,$0F,$0F,$F5,$EC,$60,$F5
	dc.b	$14,$0F,$FA,$0F,$FA,$F5,$E2,$65,$F5,$1E,$0F,$FA,$0F,$FA,$FF

; The next short family keeps one compact `F4 00` front while narrowing into tiny `0x05/0x00/0x60`
; literal-control rows.
Bank080000_CompactLiteralControlCommandFamily_09EC4A:
Bank080000_FFTerminatedCommandRecord_09EC4A:
	dc.b	$F4,$00,$C0,$F5,$0C,$05,$05,$05,$05,$C4,$FA,$C0,$05,$05,$05,$05
	dc.b	$C6,$FA,$C2,$F5,$F6,$05,$05,$05,$FA,$05,$05,$FF

Bank080000_FFTerminatedCommandRecord_09EC66:
	dc.b	$F4,$00,$C4,$F5,$0C,$00,$05,$C2,$00,$00,$05,$FA,$C4,$00,$C2,$05
	dc.b	$FA,$00,$FA,$05,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09EC7C:
	dc.b	$F4,$00,$C4,$F5,$0C,$00,$05,$C2,$00,$00,$05,$FA,$C4,$00,$C2,$05
	dc.b	$05,$60,$05,$05,$05,$05,$FF

; This last bridge alternates local `D6/D7/D2/D0` control steps before one short E3-seeded literal
; row closes the record.
Bank080000_AlternatingLocalControlAndSeededLiteralCommandRecord_09EC93:
Bank080000_FFTerminatedCommandRecord_09EC93:
	dc.b	$F8,$D6,$66,$EC,$D0,$4A,$EC,$D7,$66,$EC,$D7,$66,$EC,$D2,$66,$EC
	dc.b	$D0,$7C,$EC,$D2,$22,$EC,$D0,$7C,$EC,$D0,$66,$EC,$D0,$7C,$EC,$D0
	dc.b	$66,$EC,$D0,$7C,$EC,$FD,$9A,$EC,$88,$9C,$01,$92,$E7,$26,$E9,$5F
	dc.b	$EA,$DB,$EB,$93,$EC,$00,$00,$F4,$F8,$E3,$80,$01,$F1,$10,$F5,$0D
	dc.b	$32,$30,$FF

; This adjacent pair keeps the same compact `F4 F8` framing while alternating short `0x2D/0x2E`
; literal rows with only a few `C8/CA/C2` control pivots and one later `0x32/0x33` rise.
Bank080000_RepeatedLiteralPairCommandFamily_09ECD6:
Bank080000_FFTerminatedCommandRecord_09ECD6:
	dc.b	$F4,$F8,$C8,$F5,$17,$2E,$CA,$2D,$C8,$2E,$CA,$2D,$C8,$32,$32,$CA
	dc.b	$33,$C8,$32,$31,$C2,$F5,$0A,$2D,$2E,$2D,$2E,$2D,$2E,$2D,$2E,$F5
	dc.b	$FB,$2D,$2E,$2D,$2E,$2D,$2E,$2D,$2E,$FF

Bank080000_FFTerminatedCommandRecord_09ED00:
	dc.b	$F4,$F8,$C2,$F5,$17,$2D,$2E,$2D,$2E,$2D,$F5,$FB,$2E,$2D,$2E,$2D
	dc.b	$2E,$F5,$FB,$2D,$2E,$2D,$2E,$2D,$2E,$FF

; This bridge starts with one compact local-control sweep, then descends through a short
; literal run rooted on `0x59/0x56/0x58/0x54` before FF.
Bank080000_LocalControlSweepAndLiteralDescentCommandRecord_09ED1A:
Bank080000_FFTerminatedCommandRecord_09ED1A:
	dc.b	$F7,$01,$F0,$29,$F2,$00,$F4,$D3,$CA,$EC,$D1,$D6,$EC,$D0,$00,$ED
	dc.b	$FD,$1A,$ED,$F4,$04,$C4,$F1,$0D,$F5,$2B,$59,$56,$58,$54,$56,$53
	dc.b	$54,$51,$53,$4F,$51,$4D,$4F,$4C,$4D,$4A,$FF

Bank080000_FFTerminatedCommandRecord_09ED45:
	dc.b	$F4,$04,$CA,$FA,$FF

; The next neighboring record reuses the local-control front, then shifts into a mixed
; literal and high-byte ladder around `0x4A/0x4C/0x51` and `0x9C/0x9E/0xA0/0xA1`.
Bank080000_LocalControlAndHighByteLadderCommandRecord_09ED4A:
Bank080000_FFTerminatedCommandRecord_09ED4A:
	dc.b	$F7,$3E,$F0,$21,$D7,$2D,$ED,$D7,$45,$ED,$D6,$45,$ED,$FD,$4A,$ED
	dc.b	$F4,$04,$E2,$F0,$F1,$10,$F5,$17,$4A,$C6,$45,$4A,$4D,$E2,$F0,$4C
	dc.b	$C6,$48,$53,$54,$E3,$E0,$01,$51,$C6,$9C,$40,$9E,$41,$C8,$A0,$43
	dc.b	$A1,$45,$FF

; This follow-on record drops the local-control sweep and keeps only the high-byte and
; literal ladder, widening into the later `0xAD/0xAF/0xB1/0xB3` tail.
Bank080000_HighBytePairLadderCommandRecord_09ED7D:
Bank080000_FFTerminatedCommandRecord_09ED7D:
	dc.b	$F4,$04,$E2,$F0,$F5,$17,$4A,$C6,$45,$4A,$4D,$E2,$F0,$4C,$C6,$4A
	dc.b	$48,$4A,$C8,$45,$C6,$A1,$45,$A3,$47,$C8,$A5,$48,$C9,$F5,$0A,$A7
	dc.b	$4A,$C6,$FA,$F5,$0A,$AD,$51,$F5,$F6,$AF,$53,$C8,$F5,$F6,$B1,$54
	dc.b	$F5,$0A,$B3,$56,$FF

; This shorter continuation keeps the same `F4 04` neighborhood but mixes one repeated
; `0xAD/0xAC/0xA6` pocket with a later `0xA0-0xA5` high-byte tail.
Bank080000_HighBytePairMixCommandRecord_09EDB2:
Bank080000_FFTerminatedCommandRecord_09EDB2:
	dc.b	$F4,$04,$C8,$F5,$21,$AD,$52,$AC,$51,$A6,$4C,$AD,$52,$AC,$51,$A6
	dc.b	$4C,$FA,$C6,$F5,$F6,$A0,$43,$A1,$45,$C8,$F5,$0A,$A3,$46,$A1,$45
	dc.b	$A5,$4A,$A4,$49,$CA,$A1,$45,$FF

Bank080000_FFTerminatedCommandRecord_09EDDA:
	dc.b	$F4,$04,$C8,$FA,$C6,$F5,$21,$48,$49,$FF

; Another compact local-control sweep lands on a short literal descent around
; `0x2B/0x37/0x39/0x35` before the final `0x2B/0x30` tail.
Bank080000_LocalControlSweepAndLiteralLadderCommandRecord_09EDE4:
Bank080000_FFTerminatedCommandRecord_09EDE4:
	dc.b	$F7,$3E,$F0,$21,$F3,$00,$F4,$D0,$5A,$ED,$D0,$7D,$ED,$D1,$B2,$ED
	dc.b	$D0,$DA,$ED,$FD,$EB,$ED,$88,$30,$02,$1A,$ED,$4A,$ED,$E4,$ED,$00
	dc.b	$00,$F4,$F4,$C4,$F1,$10,$F5,$17,$2B,$37,$2B,$39,$2B,$37,$2B,$35
	dc.b	$29,$34,$28,$32,$26,$30,$24,$2B,$CA,$30,$FF

Bank080000_FFTerminatedCommandRecord_09EE1F:
	dc.b	$F7,$01,$F0,$07,$D0,$05,$EE,$FF

; This small pocket keeps the compact `F4 08` header and climbs from literal `0x43/0x41/0x40`
; into a short `0x4F/0x4D/0x4C/0x4A` plus `0xA3 48` high-byte tail.
Bank080000_LiteralAndHighByteLadderCommandRecord_09EE27:
Bank080000_FFTerminatedCommandRecord_09EE27:
	dc.b	$F4,$08,$C4,$F1,$10,$F5,$12,$43,$41,$40,$C6,$3E,$C4,$40,$C6,$41
	dc.b	$C4,$4F,$4D,$4C,$C6,$4A,$C4,$4C,$C6,$4D,$CA,$A3,$48,$FF

Bank080000_FFTerminatedCommandRecord_09EE45:
	dc.b	$F7,$3E,$F0,$21,$D0,$27,$EE,$FF

; This neighboring record is mostly a literal descent from `0x59` through `0x43`, with only a
; final compact `CA A0 A3 48` high-byte pocket at the end.
Bank080000_LiteralDescentWithHighByteTailCommandRecord_09EE4D:
Bank080000_FFTerminatedCommandRecord_09EE4D:
	dc.b	$F4,$00,$C2,$F1,$10,$F5,$17,$59,$56,$53,$4F,$58,$54,$51,$4D,$56
	dc.b	$53,$4F,$4C,$54,$51,$4D,$4A,$53,$4F,$4C,$48,$51,$4D,$4A,$47,$4F
	dc.b	$4C,$48,$45,$4D,$4A,$47,$43,$CA,$A0,$A3,$48,$FF

Bank080000_FFTerminatedCommandRecord_09EE79:
	dc.b	$F7,$3E,$F0,$1D,$D0,$4D,$EE,$FF

; This compact bridge opens with a local-offset-like seed and three same-window references,
; then drops into a tiny repeated `0x2D` literal pair with `C7` control pivots.
Bank080000_LocalOffsetSeededLiteralCommandRecord_09EE81:
Bank080000_FFTerminatedCommandRecord_09EE81:
	dc.b	$88,$10,$02,$1F,$EE,$45,$EE,$79,$EE,$00,$00,$F4,$FD,$C4,$F1,$0D
	dc.b	$F5,$0D,$2D,$2D,$FA,$C7,$FA,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09EE9A:
	dc.b	$F4,$FD,$C4,$F1,$0D,$F5,$0D,$2D,$2D,$FA,$C7,$FA,$C4,$F5,$0A,$2B
	dc.b	$FA,$2B,$FF

; This short local-target sweep hands off to one compact literal/high-byte row centered on
; `0x3B/0x3C/0x41/0x40` before FF.
Bank080000_LocalTargetSweepAndLiteralPairCommandRecord_09EEAD:
Bank080000_FFTerminatedCommandRecord_09EEAD:
	dc.b	$F7,$01,$F0,$07,$D6,$8C,$EE,$D0,$9A,$EE,$FD,$AD,$EE,$F4,$25,$C4
	dc.b	$F1,$0D,$F5,$F2,$3B,$3C,$41,$40,$3C,$3B,$3C,$41,$3C,$FF

; The next bridge returns to the denser local-control style: two short same-window sweeps,
; one `E3`-seeded offset pocket, and a compact `0xA7/0xA8/0xAA` high-byte ladder tail.
Bank080000_LocalControlSweepAndHighByteLadderCommandRecord_09EECB:
Bank080000_FFTerminatedCommandRecord_09EECB:
	dc.b	$F7,$0E,$F0,$26,$D7,$BA,$EE,$FD,$CB,$EE,$F4,$10,$E3,$B0,$01,$F1
	dc.b	$10,$F5,$17,$A7,$4C,$A8,$4D,$AA,$4F,$E2,$F0,$A8,$4D,$C6,$FA,$C7
	dc.b	$FA,$C4,$A7,$4C,$FA,$A5,$4A,$E3,$60,$03,$F1,$10,$A7,$4C,$E3,$B0
	dc.b	$01,$F0,$31,$F1,$04,$AA,$4F,$AA,$4F,$F0,$0A,$F1,$10,$FF

; This follow-on record keeps a compact local-control front and narrows into a literal/control
; pocket around `0x60/0x65/0x00/0x05/0x10/0x0F`.
Bank080000_LocalControlSweepAndLiteralControlCommandRecord_09EF09:
Bank080000_FFTerminatedCommandRecord_09EF09:
	dc.b	$F7,$0E,$F2,$00,$F4,$F0,$0A,$D0,$D5,$EE,$FD,$09,$EF,$F4,$FC,$C4
	dc.b	$F5,$12,$60,$F5,$0A,$0F,$FA,$F5,$F6,$60,$65,$F5,$0A,$0F,$F5,$F6
	dc.b	$00,$60,$F5,$0A,$10,$F5,$F6,$65,$F5,$0A,$0F,$0F,$F5,$F6,$05,$F5
	dc.b	$0A,$0F,$FF

Bank080000_FFTerminatedCommandRecord_09EF3C:
	dc.b	$F4,$FC,$C4,$F5,$12,$00,$FA,$05,$C2,$00,$0D,$0D,$0C,$0C,$0C,$C4
	dc.b	$05,$FA,$C2,$11,$FA,$FF

; This neighboring bridge alternates local-control references into the same window before one
; short literal descent around `0x5D/0x58/0x54/0x4D/0x5B/0x56/0x53/0x4F`.
Bank080000_AlternatingLocalControlAndLiteralCommandRecord_09EF52:
Bank080000_FFTerminatedCommandRecord_09EF52:
	dc.b	$F8,$D6,$16,$EF,$D0,$3C,$EF,$FD,$53,$EF,$88,$65,$02,$AD,$EE,$CB
	dc.b	$EE,$09,$EF,$52,$EF,$00,$00,$F4,$08,$C2,$F1,$09,$F5,$21,$5D,$58
	dc.b	$54,$4D,$5B,$56,$53,$4D,$5D,$58,$54,$4F,$5B,$56,$53,$4F,$FF

; This last bridge in the run stacks three compact local sweeps before one short `F4 F5`-headed
; literal row around `0x30/0x29/0x35/0x37`.
Bank080000_LocalControlBridgeAndLiteralCommandRecord_09EF81:
Bank080000_FFTerminatedCommandRecord_09EF81:
	dc.b	$F7,$11,$F0,$2D,$D7,$69,$EF,$FD,$81,$EF,$F7,$22,$F0,$1C,$F3,$20
	dc.b	$00,$E2,$04,$FA,$D7,$69,$EF,$FD,$95,$EF,$F7,$0C,$F0,$31,$F4,$18
	dc.b	$F1,$0E,$DC,$CA,$FA,$FB,$FE,$CA,$B8,$5C,$FA,$FA,$FB,$FD,$9B,$EF
	dc.b	$88,$00,$02,$81,$EF,$8B,$EF,$9B,$EF,$00,$00,$F4,$F5,$C7,$F1,$10
	dc.b	$F5,$17,$30,$C4,$30,$C7,$FA,$C4,$29,$FA,$35,$FA,$29,$2B,$FA,$37
	dc.b	$FA,$FF

; This bridge uses the same compact F4/F5 framing as the late adjacent pair-ladder family, but
; walks one descending 0x30/0x2F/0x2D/0x2B/0x29/0x28 literal pair run before the next cluster.
Bank080000_DescendingLiteralPairLadderCommandRecord_09EFD3:
Bank080000_FFTerminatedCommandRecord_09EFD3:
	dc.b	$F4,$F5,$C7,$F1,$0D,$F5,$17,$30,$C4,$30,$C7,$FA,$C4,$30,$C7,$2F
	dc.b	$C4,$2F,$C7,$FA,$C4,$2F,$C7,$2D,$C4,$2D,$C7,$FA,$C4,$2D,$C7,$2B
	dc.b	$C4,$2B,$C7,$FA,$C4,$2B,$29,$C6,$FA,$C4,$29,$C7,$FA,$C4,$29,$C7
	dc.b	$28,$C4,$28,$C7,$FA,$C4,$28,$FF

; This late local family keeps the same compact F4/F5 framing across a run of short adjacent
; FF-terminated records, varying only the C4/C6/C7 control bytes and the small byte-pair
; ladders that follow.
Bank080000_CompactPairLadderCommandFamily_09F00B:
Bank080000_FFTerminatedCommandRecord_09F00B:
	dc.b	$F4,$F5,$C6,$F1,$10,$F5,$17,$26,$C4,$28,$F1,$0D,$29,$C6,$FA,$C4
	dc.b	$29,$C7,$F1,$0E,$2B,$C4,$FA,$C7,$F1,$0D,$2B,$C6,$2F,$FF

Bank080000_FFTerminatedCommandRecord_09F029:
	dc.b	$F4,$F5,$C7,$F1,$0D,$F5,$17,$29,$C4,$29,$FA,$2B,$FA,$C7,$28,$C4
	dc.b	$FA,$28,$FA,$2F,$30,$32,$FF

Bank080000_FFTerminatedCommandRecord_09F040:
	dc.b	$F4,$F5,$C7,$F1,$0D,$F5,$17,$29,$C4,$29,$C8,$29,$FF

Bank080000_FFTerminatedCommandRecord_09F04D:
	dc.b	$F4,$F5,$C7,$F1,$0D,$F5,$17,$28,$C4,$28,$C8,$28,$FF

Bank080000_FFTerminatedCommandRecord_09F05A:
	dc.b	$F4,$F5,$C7,$F1,$0D,$F5,$17,$2B,$C4,$2B,$C6,$2B,$2C,$FF

Bank080000_FFTerminatedCommandRecord_09F068:
	dc.b	$F4,$F5,$C7,$F1,$0D,$F5,$17,$2D,$C4,$2D,$C8,$2D,$FF

Bank080000_FFTerminatedCommandRecord_09F075:
	dc.b	$F4,$F5,$C7,$F1,$0D,$F5,$17,$2B,$C4,$2B,$C8,$2B,$FF

Bank080000_FFTerminatedCommandRecord_09F082:
	dc.b	$F4,$F5,$C7,$F1,$0D,$F5,$17,$26,$C4,$26,$C8,$26,$C7,$2B,$C4,$2B
	dc.b	$C8,$2B,$FF

Bank080000_FFTerminatedCommandRecord_09F095:
	dc.b	$F4,$F5,$C4,$F1,$0D,$F5,$17,$30,$30,$C9,$FA,$C4,$FA,$F1,$10,$F5
	dc.b	$F6,$2B,$FA,$2B,$FA,$2B,$FA,$2B,$FF

; This neighboring pair starts with one compact F7/F0 local-target sweep that walks several same-window
; D0/F0 targets before a short E4 offset tail, then shifts into a high-byte pair ladder around 0xA1/0xA3.
Bank080000_LocalTargetSweepAndHighBytePairCommandPair_09F0AE:
Bank080000_FFTerminatedCommandRecord_09F0AE:
	dc.b	$F7,$01,$F0,$07,$D3,$BC,$EF,$D0,$D3,$EF,$D0,$0B,$F0,$D0,$D3,$EF
	dc.b	$D0,$29,$F0,$D0,$40,$F0,$D0,$4D,$F0,$D0,$40,$F0,$D0,$5A,$F0,$D0
	dc.b	$68,$F0,$D0,$5A,$F0,$D0,$68,$F0,$D0,$75,$F0,$D0,$40,$F0,$D0,$4D
	dc.b	$F0,$D0,$40,$F0,$D0,$5A,$F0,$D0,$68,$F0,$D0,$75,$F0,$D0,$82,$F0
	dc.b	$D0,$D3,$EF,$D0,$0B,$F0,$D0,$D3,$EF,$D0,$0B,$F0,$E4,$00,$02,$D3
	dc.b	$95,$F0,$C6,$2B,$FF

Bank080000_FFTerminatedCommandRecord_09F103:
	dc.b	$F4,$05,$C4,$F1,$0A,$F5,$21,$3C,$43,$48,$3C,$47,$48,$3C,$43,$3C
	dc.b	$47,$48,$3C,$47,$48,$3C,$43,$3C,$43,$48,$3C,$47,$48,$3C,$43,$F5
	dc.b	$F6,$3C,$A1,$45,$A1,$45,$3C,$3E,$A3,$47,$A3,$47,$3E,$FF

; This follow-on record keeps the same F4/F1/F5 framing but expands the 0x9x/0x3x high-byte pair
; sweep and inserts one short C2/F1 pivot before the final descending tail.
Bank080000_HighBytePairSweepCommandRecord_09F131:
Bank080000_FFTerminatedCommandRecord_09F131:
	dc.b	$F4,$05,$C4,$F1,$0A,$F5,$21,$9B,$40,$9C,$41,$9E,$43,$A0,$45,$FA
	dc.b	$40,$3E,$40,$99,$3E,$9B,$40,$9E,$43,$9B,$3E,$FA,$C2,$F1,$10,$3C
	dc.b	$F1,$09,$F5,$0A,$3B,$C4,$F1,$0A,$F5,$F6,$3C,$37,$99,$3C,$9B,$3E
	dc.b	$9C,$40,$9C,$40,$FA,$45,$40,$3C,$9B,$3E,$9C,$40,$9E,$43,$9B,$3E
	dc.b	$FA,$3E,$3C,$3B,$99,$35,$37,$39,$C6,$99,$3C,$C4,$3B,$39,$37,$97
	dc.b	$40,$3E,$3C,$C6,$97,$3B,$C4,$39,$37,$39,$FF

; A second adjacent family keeps the same framing but swaps in the recurring 0x9x/0x3x byte-pair
; ladders seen elsewhere in this tail-bank command body.
Bank080000_HighBytePairLadderCommandFamily_09F18C:
Bank080000_FFTerminatedCommandRecord_09F18C:
	dc.b	$F4,$05,$C6,$F1,$0A,$F5,$0D,$95,$39,$C4,$97,$3B,$99,$3C,$FA,$9B
	dc.b	$3E,$FA,$9C,$40,$FA,$9E,$41,$9C,$40,$9B,$3E,$FA,$99,$3C,$97,$3B
	dc.b	$FA,$FF

Bank080000_FFTerminatedCommandRecord_09F1AE:
	dc.b	$F4,$05,$C6,$F1,$0A,$F5,$0D,$9E,$41,$C4,$9C,$40,$C6,$9B,$3E,$C4
	dc.b	$FA,$99,$3C,$9B,$40,$C7,$FA,$C4,$94,$38,$FA,$98,$3B,$9B,$3E,$9B
	dc.b	$40,$FF

Bank080000_FFTerminatedCommandRecord_09F1D0:
	dc.b	$F4,$05,$C4,$F1,$0A,$F5,$21,$9A,$3F,$43,$3F,$3C,$98,$3E,$3F,$98
	dc.b	$3E,$37,$FF

Bank080000_FFTerminatedCommandRecord_09F1E3:
	dc.b	$F4,$05,$C4,$F1,$0A,$F5,$21,$99,$3E,$43,$3E,$3B,$97,$3D,$3E,$97
	dc.b	$3D,$36,$FF

Bank080000_FFTerminatedCommandRecord_09F1F6:
	dc.b	$F4,$05,$C4,$F1,$05,$F5,$17,$3C,$3F,$43,$3F,$3C,$43,$3F,$3C,$42
	dc.b	$3F,$3C,$42,$3F,$3C,$42,$3C,$3C,$3F,$45,$3F,$3C,$45,$3F,$3C,$FF

Bank080000_FFTerminatedCommandRecord_09F216:
	dc.b	$F4,$05,$C4,$F1,$05,$F5,$17,$43,$3F,$3C,$43,$3F,$C2,$F1,$10,$F5
	dc.b	$F6,$9E,$43,$9D,$42,$9A,$3F,$99,$3E,$97,$3C,$92,$37,$FF

Bank080000_FFTerminatedCommandRecord_09F234:
	dc.b	$F4,$05,$C4,$F1,$10,$F5,$17,$93,$43,$9F,$46,$9F,$46,$92,$39,$C2
	dc.b	$9E,$45,$9E,$45,$FA,$9E,$45,$C4,$9D,$44,$9C,$43,$FF

Bank080000_FFTerminatedCommandRecord_09F251:
	dc.b	$F4,$05,$C4,$FA,$F1,$0D,$F5,$17,$95,$3F,$93,$3E,$92,$3C,$C2,$9C
	dc.b	$43,$9A,$41,$95,$3C,$99,$3F,$F5,$F6,$93,$3A,$92,$39,$C7,$90,$37
	dc.b	$FF

; This local control-sweep record keeps the same CA/DF/FE pocket used elsewhere in the tail
; window, but here it walks a short D0/F1/F2/F3/F4 ladder before terminating.
Bank080000_LocalControlSweepCommandRecord_09F272:
Bank080000_FFTerminatedCommandRecord_09F272:
	dc.b	$F7,$0C,$F0,$27,$D1,$03,$F1,$D0,$31,$F1,$D0,$8C,$F1,$D0,$31,$F1
	dc.b	$D0,$AE,$F1,$CA,$DF,$FA,$FE,$DF,$FA,$FE,$D0,$31,$F1,$D0,$8C,$F1
	dc.b	$D0,$31,$F1,$D0,$8C,$F1,$D0,$F6,$F1,$D0,$16,$F2,$D2,$34,$F2,$D0
	dc.b	$51,$F2,$FF

; The next short run shares one compact `F4 18` front plus the same byte-pair ladder style
; already seen in neighboring repeated-shape records, but swaps among C4/C6/C8/C9/CF controls
; and small 0xAx/0x4x payload pairs instead of the earlier 0x9x/0x3x families.
Bank080000_HighBytePairControlCommandFamily_09F2A5:
Bank080000_FFTerminatedCommandRecord_09F2A5:
	dc.b	$F4,$18,$C4,$F1,$10,$F5,$F6,$A8,$4C,$AA,$4D,$A8,$4C,$C6,$A7,$4A
	dc.b	$A5,$48,$A1,$45,$A8,$4C,$A7,$4A,$C4,$48,$4A,$48,$C5,$A8,$4C,$A3
	dc.b	$48,$CF,$A0,$43,$FF

Bank080000_FFTerminatedCommandRecord_09F2CA:
	dc.b	$F4,$18,$C8,$FA,$C4,$F1,$10,$F5,$F2,$40,$41,$F1,$0D,$43,$C8,$F1
	dc.b	$10,$43,$C6,$45,$C4,$43,$41,$CF,$40,$C4,$3C,$3E,$F1,$0D,$40,$C7
	dc.b	$F1,$0F,$40,$C4,$F1,$10,$41,$C6,$40,$C4,$3E,$3C,$3E,$C9,$39,$C4
	dc.b	$3E,$E2,$A8,$3C,$C4,$37,$37,$FF

Bank080000_FFTerminatedCommandRecord_09F302:
	dc.b	$F4,$18,$C6,$F1,$10,$F5,$F2,$39,$C4,$3B,$C6,$3C,$C4,$FA,$3E,$C8
	dc.b	$40,$CF,$3E,$FF

Bank080000_FFTerminatedCommandRecord_09F316:
	dc.b	$F4,$18,$C6,$F1,$10,$F5,$F2,$41,$C4,$40,$C6,$41,$43,$E2,$D8,$40
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09F327:
	dc.b	$F4,$18,$C6,$F1,$10,$F5,$F2,$41,$C4,$40,$3E,$FA,$3C,$FA,$40,$FA
	dc.b	$F1,$0D,$3E,$C8,$3E,$C6,$F1,$10,$3B,$FF

Bank080000_FFTerminatedCommandRecord_09F341:
	dc.b	$F4,$18,$F1,$10,$F5,$F2,$C6,$3C,$43,$42,$C7,$46,$E2,$A8,$FA,$FF

; This adjacent record returns to the local-control sweep shape: a compact setup header,
; repeated CA/DF/FE pockets, and several short D0/F2/F3/F4 climbs before the final FF.
Bank080000_LocalControlSweepCommandRecord_09F351:
Bank080000_FFTerminatedCommandRecord_09F351:
	dc.b	$F6,$02,$F7,$07,$F2,$00,$E8,$F0,$02,$D0,$A5,$F2,$CA,$FA,$D0,$A5
	dc.b	$F2,$CA,$FA,$D0,$CA,$F2,$D0,$02,$F3,$D0,$CA,$F2,$D0,$16,$F3,$CA
	dc.b	$DF,$FA,$FE,$DF,$FA,$FE,$D0,$CA,$F2,$CA,$FA,$FA,$D0,$CA,$F2,$D0
	dc.b	$27,$F3,$D0,$41,$F3,$CA,$FA,$FA,$D0,$41,$F3,$FF

Bank080000_FFTerminatedCommandRecord_09F38D:
	dc.b	$F4,$05,$C8,$FA,$C4,$F1,$10,$F5,$1E,$40,$41,$F1,$0D,$43,$C8,$F1
	dc.b	$10,$43,$C6,$45,$C4,$43,$41,$CF,$40,$C4,$3C,$3E,$F1,$0D,$40,$C7
	dc.b	$F1,$0F,$40,$C4,$F1,$10,$41,$C6,$40,$C4,$3E,$3C,$3E,$C9,$39,$C4
	dc.b	$3E,$E2,$A8,$3C,$C4,$37,$37,$FF

Bank080000_FFTerminatedCommandRecord_09F3C5:
	dc.b	$F4,$05,$C6,$F1,$10,$F5,$1C,$41,$C4,$40,$C6,$41,$43,$E2,$D8,$40
	dc.b	$FF

; The next cluster shifts from pair ladders to short literal/control pockets around the same
; 0x45/0x47/0x48/0x4A/0x4C byte family, again using compact FF-terminated records.
Bank080000_LiteralControlPocketCommandFamily_09F3D6:
Bank080000_FFTerminatedCommandRecord_09F3D6:
	dc.b	$F4,$05,$C8,$FA,$C4,$F1,$10,$F5,$12,$45,$47,$48,$C8,$47,$C6,$43
	dc.b	$40,$CF,$45,$C4,$45,$47,$48,$C7,$4A,$C4,$48,$C7,$47,$C6,$43,$C7
	dc.b	$45,$C4,$FA,$45,$C7,$4C,$4A,$C2,$49,$48,$C8,$47,$FF

Bank080000_FFTerminatedCommandRecord_09F403:
	dc.b	$F4,$05,$C7,$F1,$10,$F5,$12,$45,$C4,$FA,$45,$C7,$4C,$C8,$4A,$43
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09F414:
	dc.b	$F4,$05,$C6,$F1,$10,$F5,$12,$45,$FA,$C4,$45,$C7,$48,$C8,$47,$4A
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09F425:
	dc.b	$F4,$05,$C4,$FA,$C2,$F1,$10,$F5,$30,$A2,$43,$C5,$FA,$C2,$F5,$F1
	dc.b	$A2,$43,$C5,$FA,$C2,$F5,$EC,$A2,$43,$C5,$FA,$C2,$F5,$F6,$A2,$43
	dc.b	$FA,$C4,$F5,$14,$46,$48,$4F,$C7,$4E,$C4,$F5,$0A,$48,$CF,$F5,$F6
	dc.b	$4B,$C8,$4A,$FF

Bank080000_FFTerminatedCommandRecord_09F459:
	dc.b	$F4,$05,$C4,$FA,$F1,$10,$F5,$1E,$46,$45,$44,$43,$42,$41,$40,$C8
	dc.b	$F5,$F6,$48,$C4,$46,$45,$43,$CF,$4B,$C2,$F5,$F8,$F1,$0C,$A8,$4D
	dc.b	$A7,$4C,$A6,$4B,$A5,$4A,$A4,$49,$A3,$48,$A2,$47,$C6,$A1,$46,$FF

; One more compact local-control sweep closes this pocket before the later repeated triplet.
Bank080000_LocalControlSweepCommandRecord_09F489:
Bank080000_FFTerminatedCommandRecord_09F489:
	dc.b	$F7,$0E,$F0,$21,$F2,$00,$0C,$CA,$DF,$FA,$FE,$DF,$FA,$FE,$D0,$8D
	dc.b	$F3,$D0,$C5,$F3,$D0,$D6,$F3,$D0,$03,$F4,$D0,$D6,$F3,$D0,$14,$F4
	dc.b	$F2,$00,$00,$D0,$8D,$F3,$CA,$FA,$FA,$F2,$00,$0C,$D0,$8D,$F3,$D0
	dc.b	$27,$F3,$C6,$3C,$43,$42,$46,$F0,$01,$F2,$00,$00,$D0,$25,$F4,$F0
	dc.b	$21,$C6,$3C,$43,$42,$46,$F0,$01,$D0,$59,$F4,$FF

; Another repeated 0x18-byte triplet appears late in the tail window with the same F4/F1/F5
; framing but a different repeated pair payload.
Bank080000_RepeatedTwentyFourByteCommandRecordTriplet_09F4D5:
Bank080000_FFTerminatedCommandRecord_09F4D5:
	dc.b	$F4,$10,$C4,$F1,$10,$F5,$17,$99,$40,$95,$3E,$99,$40,$95,$3E,$99
	dc.b	$40,$95,$3E,$99,$40,$95,$3C,$FF

Bank080000_FFTerminatedCommandRecord_09F4ED:
	dc.b	$F4,$10,$C4,$F1,$10,$F5,$17,$97,$3E,$94,$3B,$97,$3E,$94,$3B,$97
	dc.b	$3E,$94,$3B,$97,$3E,$94,$3B,$FF

Bank080000_FFTerminatedCommandRecord_09F505:
	dc.b	$F4,$10,$C4,$F1,$10,$F5,$17,$9B,$40,$99,$3E,$9B,$40,$99,$3E,$9B
	dc.b	$40,$99,$3E,$9B,$40,$94,$3C,$FF

; This short bridge returns to the compact local-control sweep shape: a setup header, repeated
; CA/DF/FE pockets, and a tight D0-prefixed ladder that alternates local F4/F5 targets before FF.
Bank080000_LocalControlSweepCommandRecord_09F51D:
Bank080000_FFTerminatedCommandRecord_09F51D:
	dc.b	$F6,$02,$F7,$07,$F2,$00,$E8,$F0,$03,$CA,$DF,$FA,$FE,$DF,$FA,$FE
	dc.b	$DF,$FA,$FE,$D0,$D5,$F4,$D0,$ED,$F4,$D0,$D5,$F4,$D0,$ED,$F4,$D0
	dc.b	$05,$F5,$D0,$ED,$F4,$D0,$05,$F5,$D0,$ED,$F4,$D0,$D5,$F4,$D0,$ED
	dc.b	$F4,$D0,$D5,$F4,$D0,$ED,$F4,$D0,$05,$F5,$D0,$ED,$F4,$D0,$D5,$F4
	dc.b	$D0,$ED,$F4,$FF

; The next two short records keep one compact F4/C2/F5 header while varying only the local
; literal/control pockets around 0x60/0x65/0x6C/0x0F before the later repeated-burst family.
Bank080000_CompactLiteralControlCommandPair_09F561:
Bank080000_FFTerminatedCommandRecord_09F561:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$0F,$FA,$0F,$FA,$65,$0F,$FA,$C4,$60,$10
	dc.b	$60,$0F,$C2,$0F,$FA,$65,$0F,$FA,$0F,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09F57C:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$0F,$FA,$6C,$0F,$FA,$65,$0F,$0F,$60,$10
	dc.b	$FA,$60,$0F,$FA,$05,$05,$0D,$0C,$11,$FA,$FF

; This adjacent pair keeps one compact F4/C2 command header while repeating long literal 0x0F
; bursts between the same small 0x60/0x6C/0x6D/0x65 control pocket. The second record extends
; the same local pattern with one extra 0x6C/0x6D step plus a short 0x65-tail variation.
Bank080000_RepeatedLiteralBurstCommandFamily_09F597:
Bank080000_FFTerminatedCommandRecord_09F597:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$F5,$0A,$0F,$0F,$0F,$0F,$F5,$F6,$6D,$F5
	dc.b	$0A,$0F,$0F,$0F,$F5,$F6,$60,$F5,$0A,$0F,$F5,$F6,$60,$F5,$0A,$0F
	dc.b	$0F,$0F,$0F,$F5,$EC,$65,$F5,$14,$0F,$0F,$F5,$F6,$6C,$F5,$0A,$0F
	dc.b	$0F,$0F,$0F,$F5,$F6,$6C,$F5,$0A,$0F,$0F,$F5,$F6,$6C,$F5,$0A,$0F
	dc.b	$0F,$0F,$0F,$F5,$F6,$60,$6C,$F5,$0A,$0F,$F5,$F6,$6C,$F5,$0A,$0F
	dc.b	$F5,$F6,$6C,$F5,$0A,$0F,$0F,$F5,$EC,$65,$F5,$14,$0F,$0F,$0F,$0F
	dc.b	$FF

Bank080000_FFTerminatedCommandRecord_09F5F8:
	dc.b	$F4,$00,$C2,$F5,$12,$60,$F5,$0A,$0F,$0F,$0F,$0F,$F5,$F6,$6D,$F5
	dc.b	$0A,$0F,$0F,$0F,$F5,$F6,$60,$F5,$0A,$0F,$F5,$F6,$60,$F5,$0A,$0F
	dc.b	$0F,$0F,$0F,$F5,$EC,$65,$F5,$14,$0F,$0F,$F5,$F6,$6C,$F5,$0A,$0F
	dc.b	$0F,$0F,$0F,$F5,$F6,$6C,$F5,$0A,$0F,$0F,$F5,$F6,$6C,$F5,$0A,$0F
	dc.b	$0F,$0F,$0F,$F5,$F6,$60,$6C,$F5,$0A,$0F,$F5,$F6,$6C,$F5,$0A,$0F
	dc.b	$F5,$F6,$6C,$F5,$0A,$0F,$F5,$F6,$6C,$6D,$F5,$0A,$0F,$F5,$0A,$65
	dc.b	$F5,$F6,$0F,$65,$0F,$F5,$F6,$65,$F5,$0A,$0F,$F5,$EC,$65,$F5,$14
	dc.b	$0F,$FF

; This late record alternates one repeated local-control pair (`D2/D6 61` against `D0 7C`) before
; ending in a short local tail, so keep the byte rhythm explicit instead of hiding it in one slice.
Bank080000_AlternatingLocalControlCommandRecord_09F66A:
Bank080000_FFTerminatedCommandRecord_09F66A:
	dc.b	$F8,$D2,$61,$F5,$D0,$7C,$F5,$D2,$61,$F5,$D0,$7C,$F5,$D6,$61,$F5
	dc.b	$D0,$7C,$F5,$D6,$61,$F5,$D0,$7C,$F5,$D2,$61,$F5,$D0,$7C,$F5,$D2
	dc.b	$61,$F5,$D0,$7C,$F5,$D2,$61,$F5,$D0,$7C,$F5,$D2,$61,$F5,$D0,$7C
	dc.b	$F5,$D6,$61,$F5,$D0,$7C,$F5,$D6,$61,$F5,$D0,$7C,$F5,$D2,$97,$F5
	dc.b	$D0,$F8,$F5,$FF

; This compact tail starts with one local-offset-like seed and then walks a short F0/F2/F3/F4/F5/F6
; setup ladder before the usual FF terminator, so keep the whole stack visible in source.
Bank080000_LocalSeededSetupCommandRecord_09F6AE:
Bank080000_FFTerminatedCommandRecord_09F6AE:
	dc.b	$88,$C0,$01,$AE,$F0,$72,$F2,$51,$F3,$89,$F4,$1D,$F5,$6A,$F6,$00
	dc.b	$00,$F4,$00,$C6,$FA,$FF

; The next compact header/literal pocket keeps the same F4/F1/F5 framing as the neighboring records
; while embedding a short six-byte literal burst before the shared C4/FA tail.
Bank080000_CompactLiteralBurstCommandRecord_09F6C4:
Bank080000_FFTerminatedCommandRecord_09F6C4:
	dc.b	$F4,$00,$C7,$F1,$10,$F5,$17,$35,$C8,$34,$32,$30,$C4,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09F6D3:
	dc.b	$F7,$01,$F0,$23,$D0,$BF,$F6,$D0,$C4,$F6,$FF

; These adjacent short records share the same compact C4-header framing. The second extends the first
; with one extra literal/control pocket before dropping into the same C7/FA terminator.
Bank080000_CompactHeaderLiteralCommandPair_09F6DE:
Bank080000_FFTerminatedCommandRecord_09F6DE:
	dc.b	$F4,$00,$C4,$F1,$0E,$F5,$17,$45,$47,$FF

Bank080000_FFTerminatedCommandRecord_09F6E8:
	dc.b	$F4,$00,$C4,$F1,$0E,$F5,$17,$48,$45,$47,$C6,$43,$45,$41,$43,$40
	dc.b	$C7,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09F6FB:
	dc.b	$F7,$06,$F0,$23,$D0,$DE,$F6,$D0,$E8,$F6,$FF

; This slightly longer neighbor keeps the same C4/F1/F5 header rhythm but alternates literal pairs and
; local C4/C6/C8 markers across two short rows before one final F6/FA tail.
Bank080000_TwoRowLiteralControlCommandRecord_09F706:
Bank080000_FFTerminatedCommandRecord_09F706:
	dc.b	$F4,$00,$C4,$F1,$10,$F5,$21,$99,$40,$35,$99,$40,$C6,$97,$3E,$C4
	dc.b	$34,$97,$3E,$C6,$95,$3C,$C4,$32,$95,$3C,$C8,$F5,$F6,$94,$3B,$C4
	dc.b	$FA,$FF

Bank080000_FFTerminatedCommandRecord_09F728:
	dc.b	$F4,$00,$C6,$FA,$FF

Bank080000_FFTerminatedCommandRecord_09F72D:
	dc.b	$F7,$38,$F0,$23,$D0,$28,$F7,$D0,$06,$F7,$FF

; The final terminated record before the lead-out is a repeated E4/offset ladder with a stable `01 FA FA`
; suffix, so source-author the local rhythm instead of hiding it in one raw slice.
Bank080000_LocalOffsetLadderCommandRecord_09F738:
Bank080000_FFTerminatedCommandRecord_09F738:
	dc.b	$F6,$02,$C4,$FA,$E4,$A0,$01,$FA,$FA,$E4,$90,$01,$FA,$FA,$E4,$80
	dc.b	$01,$FA,$FA,$E4,$70,$01,$FA,$FA,$E4,$68,$01,$FA,$FA,$E4,$5C,$01
	dc.b	$FA,$FA,$E4,$48,$01,$FA,$FA,$E4,$40,$01,$FA,$FA,$E4,$60,$01,$FA
	dc.b	$FA,$FF

; The final non-terminated tail is still short but no longer opaque: it begins with another
; local-offset-like seed, steps through a compact F6/F7 ladder, and then ends on the two-byte
; zero trailer immediately before the bank fill run.
Bank080000_LocalSeededLeadOut_09F76A:
Bank080000_CommandRecordLeadOut_09F76A:
	dc.b	$88,$78,$01,$D3,$F6,$FB,$F6,$2D,$F7,$38,$F7,$00,$00
