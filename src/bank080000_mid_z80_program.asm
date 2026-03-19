; ROM range: 0x098000-0x0991FF
; Front slice inside the 0x098000-0x09F776 non-fill tail-bank island.
;
; The bytes at 0x098000 are now strong enough to treat this as a real Z80 program front
; rather than a merely Z80-like blob: the bank opens with `DI`, `IM 1`, and an absolute
; `JP $003B`, later front stubs repeatedly `JP $0F8C`, and 0x098038 is a tiny `NOP`/`RETI`
; handler immediately before the jumped-to main body at 0x09803B.
;
; Keep the names structural until the higher-level owner is proven. The front stubs are
; visible because their entry boundaries are now stronger than the rest of the opcode-dense
; body, but the wider loader path still does not prove whether this is the sound driver,
; another Z80-resident helper, or a banked interpreter payload.
;
; The full 0x098000-0x0991FF front slice is now source-visible. The 0x09803B-0x09907A
; body still keeps structural names because the wider loader path is unresolved, but the
; former 0x09803B-0x098274 incbin now stands as startup, sequencing, and slot-management
; helpers before the later explicit meta-command dispatch and lookup tables. The final
; 0x185 bytes stay explicit source data too: the first table at 0x09907B-0x09913C rises
; from 0x028E to 0x051C across 97 entries, while the second at 0x09913D-0x0991FE falls
; from 0x0349 to 0x01A4 across another 97 entries.

Bank080000_Z80ProgramBlock_098000:

; The opening bytes are no longer kept inside one monolithic incbin: 0x098000 jumps to the
; later main entry at 0x09803B, 0x098020/0x098028/0x098030 are repeated absolute jump stubs,
; and 0x098038 is a tiny `NOP`/`RETI` handler.
Bank080000_Z80ProgramResetEntry_098000:
	dc.b	$F3,$ED,$56,$C3,$3B,$00

Bank080000_Z80ProgramFrontReturnStub_098006:
	dc.b	$77,$1A,$72,$23,$0B,$78,$B1,$20,$F9,$C9

; 0x098010-0x09801F remains a mixed front-stub pocket, but the three following 8-byte runs
; are strong enough to stand on their own because they all repeat the same absolute `JP $0F8C`
; handoff shape.
Bank080000_Z80ProgramFrontStubCluster_098010:
	dc.b	$DF,$DF,$DF,$1C,$C9,$FF,$FF,$FF,$7B,$42,$CD,$CB,$06,$1C,$C9,$FF

Bank080000_Z80ProgramJumpStub_098020:
	dc.b	$E3,$2B,$E3,$C3,$8C,$0F,$FF,$FF

Bank080000_Z80ProgramJumpStub_098028:
	dc.b	$E3,$2B,$E3,$C3,$8C,$0F,$FF,$FF

Bank080000_Z80ProgramJumpStub_098030:
	dc.b	$E3,$2B,$E3,$C3,$8C,$0F,$FF,$FF

Bank080000_Z80ProgramRetiStub_098038:
	dc.b	$00,$ED,$4D

Bank080000_Z80ProgramMainBody_09803B:

; The first main-body helper resets the wide-record and slot tables, shifts one startup byte
; out through 0x6000, emits three fixed setup bursts through 0x06F7/0x00E3/0x013E, and then
; runs a three-step warmup loop that advances the inline sequence state via 0x0110/0x0155/
; 0x019C before tail-jumping back into the countdown-driven tick below.
Bank080000_Z80ProgramInitializeSequencerState_09803B:
	dc.b	$21,$80,$1B,$F9,$36,$FF,$23,$01,$FF,$00,$16,$00,$CF,$01,$80,$03
	dc.b	$15,$CF,$21,$80,$1C,$11,$40,$00,$06,$09,$72,$19,$10,$FC,$1E,$20
	dc.b	$06,$0A,$72,$19,$10,$FC,$21,$D1,$1E,$06,$0A,$72,$19,$10,$FC,$3A
	dc.b	$01,$00,$32,$00,$60,$2E,$90,$06,$08,$AF,$CB,$25,$17,$32,$00,$60
	dc.b	$10,$F7,$0E,$00,$06,$2B,$CD,$F7,$06,$0E,$ED,$06,$26,$CD,$F7,$06
	dc.b	$3E,$2A,$32,$23,$1C,$4F,$06,$27,$CD,$F7,$06,$21,$11,$7F,$36,$9F
	dc.b	$36,$BF,$36,$DF,$36,$FF,$CD,$E3,$00,$CD,$3E,$01,$3E,$01,$32,$2D
	dc.b	$1C,$AF,$32,$00,$1C,$AF,$32,$06,$1C,$3E,$03,$32,$02,$1C,$CD,$10
	dc.b	$01,$CD,$55,$01,$CD,$9C,$01,$2A,$16,$1C,$26,$00,$ED,$5B,$14,$1C
	dc.b	$19,$22,$16,$1C,$7C,$21,$06,$1C,$86,$77,$CD,$0B,$07,$3A,$02,$1C
	dc.b	$3D,$20,$D8,$CD,$7F,$0B,$18,$CD

; Emit one short startup burst, then three row-like writes with C = 1..3 through 0x06F7.
Bank080000_Z80ProgramEmitStartupBurst_0980E2:
	dc.b	$0E,$00,$16,$90,$CD,$00,$01,$0D,$16,$80,$CD,$00,$01,$06,$28,$CD
	dc.b	$F5,$00,$0C,$1E,$03,$CD,$F7,$06,$0C,$1D,$20,$F9,$C9

; Clear the active output byte, select page 2 in 0x1C10, and pulse RST 10 four times.
Bank080000_Z80ProgramResetOutputSelector_0980FB:
	dc.b	$AF,$CD,$06,$01,$3E,$02,$32,$10,$1C,$1E,$00,$D7,$D7,$D7,$D7,$C9

; Countdown-driven tick. While the external handshake flag at 0x1B99 is nonzero, it first
; re-enters the repeated JP $0F8C target. Once the local delay at 0x1C2D expires, it advances
; the pointer at 0x1C04 and emits the next 0x1C23-selected write through 0x06F7.
Bank080000_Z80ProgramTickCountdownAndAdvancePointer_09810B:
	dc.b	$3A,$99,$1B,$B7,$C4,$8C,$0F,$21,$2D,$1C,$35,$C0,$36,$01,$3A,$03
	dc.b	$1C,$E6,$02,$28,$02,$36,$04,$3A,$00,$40,$E6,$02,$28,$E2,$2A,$04
	dc.b	$1C,$23,$22,$04,$1C,$3A,$23,$1C,$4F,$06,$27,$C3,$F7,$06

; Initialize phase bytes across the 0x1C81-rooted wide-record families.
Bank080000_Z80ProgramInitializeWideRecordPhaseBytes_09813E:
	dc.b	$CD,$69,$03,$21,$81,$1C,$11,$40,$00,$06,$06,$72,$19,$10,$FC,$06
	dc.b	$03,$36,$02,$19,$10,$FB,$C9

; Mirror the optional latched mode byte from 0x1C2B into 0x1C0B when 0x1C2A is nonzero.
Bank080000_Z80ProgramMirrorLatchedModeByte_098152:
	dc.b	$3A,$2A,$1C,$B7,$28,$07,$3A,$2B,$1C,$32,$0B,$1C,$C9

; Advance the inline sequence state at 0x1C0A/0x1C0C/0x1C0E. The active countdown at 0x1C09
; gates when the next control byte is fetched and when the source pointer/base word are advanced.
Bank080000_Z80ProgramAdvanceInlineSequenceState_098160:
	dc.b	$3A,$09,$1C,$B7,$C8,$2A,$0A,$1C,$ED,$5B,$0C,$1C,$19,$CB,$7C,$28
	dc.b	$0D,$CB,$7A,$CC,$21,$03,$AF,$32,$09,$1C,$32,$0B,$1C,$C9,$22,$0A
	dc.b	$1C,$21,$09,$1C,$35,$C0,$ED,$5B,$0E,$1C,$1A,$13,$77,$EB,$5E,$23
	dc.b	$56,$23,$22,$0E,$1C,$ED,$53,$0C,$1C,$C9

; Consume the next sequence byte. Values $FA-$FF dispatch through the later explicit table at
; 0x098275; smaller values below $58 index a local pointer table at 0x099B01; and the negative
; path seeds 0x1C14/0x1C16 before the slot-population helper below runs.
Bank080000_Z80ProgramConsumeSequenceByte_09819C:
	dc.b	$3E,$FF,$32,$00,$1C,$3A,$2F,$1C,$B7,$20,$04,$32,$00,$1C,$C9,$3D
	dc.b	$32,$2F,$1C,$3A,$2E,$1C,$5F,$16,$00,$21,$30,$1C,$19,$3C,$E6,$0F
	dc.b	$32,$2E,$1C,$4E,$AF,$32,$00,$1C,$79,$FE,$FA,$38,$0C,$2F,$87,$5F
	dc.b	$21,$75,$02,$19,$7E,$23,$66,$6F,$E9,$FE,$58,$D0,$87,$5F,$21,$01
	dc.b	$9B,$19,$7E,$23,$66,$6F,$7E,$23,$32,$28,$1C,$B7,$F2,$2D,$02,$AF
	dc.b	$32,$0A,$1C,$32,$0B,$1C,$32,$09,$1C,$32,$2A,$1C,$5E,$23,$56,$23
	dc.b	$ED,$53,$14,$1C,$E5,$21,$00,$00,$22,$16,$1C,$CD,$21,$03,$E1

; Walk a little-endian pointer list until a zero word is seen, seeding successive 0x1EC0-rooted
; 0x20-byte slot descriptors with the current selector byte at 0x1C28.
Bank080000_Z80ProgramPopulateLinearSlotDescriptors_09820B:
	dc.b	$DD,$21,$C0,$1E,$01,$20,$00,$5E,$23,$56,$7B,$B2,$C8,$23,$DD,$36
	dc.b	$00,$80,$3A,$28,$1C,$DD,$77,$10,$DD,$73,$06,$DD,$72,$07,$DD,$09
	dc.b	$18,$E5

; Reuse the current packed sequence byte as a nibble-pair index, select one 0x20-byte slot in
; the 0x1EC0 family, retire any lower-priority active record already there, and then reload that
; slot's selector plus its 16-bit source pointer from the inline stream.
Bank080000_Z80ProgramUpdateIndexedSlotDescriptor_09822A:
	dc.b	$E5,$CD,$44,$03,$E1,$7E,$FE,$FF,$C8,$23,$0F,$0F,$0F,$57,$E6,$E0
	dc.b	$5F,$7A,$E6,$07,$57,$DD,$21,$C0,$1E,$DD,$19,$DD,$CB,$00,$7E,$28
	dc.b	$11,$3A,$28,$1C,$DD,$BE,$10,$30,$04,$23,$23,$18,$D8,$E5,$CD,$FA
	dc.b	$02,$E1,$DD,$36,$00,$80,$3A,$28,$1C,$DD,$77,$10,$7E,$23,$DD,$77
	dc.b	$06,$7E,$23,$DD,$77,$07,$18,$BD

; 0x0981C5-0x0981D0 dispatches byte values $FF..$FA through this little-endian
; jump table after complementing the command byte and doubling it into a word index.
; The entries therefore prove six command-style targets inside the former monolithic
; main body, even though the higher-level owner is still unresolved.
Bank080000_Z80ProgramMetaCommandDispatchTable_098275:
	dc.b	$69,$03 ; $FF -> 0x0369
	dc.b	$9C,$02 ; $FE -> 0x029C
	dc.b	$E2,$02 ; $FD -> 0x02E2
	dc.b	$BA,$02 ; $FC -> 0x02BA
	dc.b	$82,$02 ; $FB -> 0x0282
	dc.b	$88,$02 ; $FA -> 0x0288

Bank080000_Z80ProgramMetaCommandDispatchReturn_098281:
	dc.b	$C9

; The $FB target is a tiny standalone handler that only latches a mode/state byte.
Bank080000_Z80ProgramMetaCommandHandler_FB_098282:
	dc.b	$3E,$01,$32,$2A,$1C,$C9

; The $FA and $FE targets differ only in which inline 3-byte record table they load.
; Both share the same initialization tail at 0x09829F, which clears the active cursor
; words, stores the selected table base in 0x1C0E, and marks the table-driven mode in
; 0x1C09 before returning.
Bank080000_Z80ProgramMetaCommandHandler_FA_098288:
	dc.b	$21,$8D,$02,$18,$12

Bank080000_Z80ProgramMetaCommandTableA_09828D:
	dc.b	$80,$10,$00
	dc.b	$80,$18,$00
	dc.b	$FF,$20,$00
	dc.b	$FF,$40,$00
	dc.b	$FF,$80,$00

Bank080000_Z80ProgramMetaCommandHandler_FE_09829C:
	dc.b	$21,$B1,$02

Bank080000_Z80ProgramSharedMetaCommandTableInit_09829F:
	dc.b	$22,$0E,$1C,$21,$00,$00,$22,$0C,$1C,$22,$2A,$1C,$3E,$01,$32,$09
	dc.b	$1C,$C9

Bank080000_Z80ProgramMetaCommandTableB_0982B1:
	dc.b	$20,$40,$00
	dc.b	$20,$60,$00
	dc.b	$FF,$80,$00

; The $FC target walks ten 0x20-byte slot records rooted at 0x1EC0. It clears the
; local slot counter at 0x1C07, optionally calls the shared helper at 0x02FA for
; active slots that also have bit 7 set at +0x10, then sets bit 0 in 0x1C03.
Bank080000_Z80ProgramMetaCommandHandler_FC_0982BA:
	dc.b	$DD,$21,$C0,$1E,$AF,$32,$07,$1C,$DD,$CB,$00,$7E,$28,$07,$DD,$CB
	dc.b	$10,$7E,$C4,$FA,$02,$11,$20,$00,$DD,$19,$3A,$07,$1C,$3C,$FE,$0A
	dc.b	$38,$E3,$21,$03,$1C,$CB,$C6,$C9

; The $FD target itself is tiny: it only clears bit 0 in 0x1C03 before returning.
Bank080000_Z80ProgramMetaCommandHandler_FD_0982E2:
	dc.b	$21,$03,$1C,$CB,$86,$C9

; Several nearby helpers are now explicit too. The first converts the current IX slot
; pointer into a packed slot index relative to the 0x1EC0 base, which the following
; routines reuse while scanning the surrounding slot tables.
Bank080000_Z80ProgramPackSlotIndexFromIX_0982E8:
	dc.b	$DD,$E5,$E1,$01,$40,$E1,$09,$7C,$07,$07,$07,$4F,$7D,$07,$07,$07
	dc.b	$B1,$C9

; Scan the 0x1C80 table in 0x40-byte steps, compare each active record's byte at +6
; with the packed IX-relative slot index, and call the shared helper at 0x0446 for
; matches. Keep the owner structural until the wider driver path is clearer.
Bank080000_Z80ProgramVisitMatchingPackedSlotRecords_0982FA:
	dc.b	$CD,$E8,$02,$DD,$E5,$DD,$21,$80,$1C,$06,$09,$DD,$CB,$00,$7E,$28
	dc.b	$0C,$DD,$BE,$06,$20,$07,$4F,$C5,$CD,$46,$04,$C1,$79,$11,$40,$00
	dc.b	$DD,$19,$10,$E7,$DD,$E1,$C9

; Walk the same ten 0x1EC0-rooted slot records and retire only the active entries
; whose secondary flag byte at +0x10 also has bit 7 set.
Bank080000_Z80ProgramDrainFlaggedSlotRecords_098321:
	dc.b	$DD,$21,$C0,$1E,$06,$0A,$DD,$CB,$00,$7E,$28,$0F,$DD,$CB,$10,$7E
	dc.b	$28,$09,$C5,$CD,$FA,$02,$C1,$DD,$36,$00,$00,$11,$20,$00,$DD,$19
	dc.b	$10,$E4,$C9

; This neighboring helper filters the same slot table by the selected byte at 0x1C28
; instead of the +0x10 high-bit flag, then retires matching active entries.
Bank080000_Z80ProgramDrainSelectedSlotRecords_098345:
	dc.b	$DD,$21,$C0,$1E,$06,$0A,$DD,$CB,$00,$7E,$28,$11,$3A,$28,$1C,$DD
	dc.b	$BE,$10,$20,$09,$C5,$CD,$FA,$02,$C1,$DD,$36,$00,$00,$11,$20,$00
	dc.b	$DD,$19,$10,$E2,$C9

; The $FF target retires every active 0x1EC0-rooted slot, then clears the nearby
; state bytes/words at 0x1C2A, 0x1C09, and 0x1C0B.
Bank080000_Z80ProgramMetaCommandHandler_FF_098369:
	dc.b	$DD,$21,$C0,$1E,$06,$0A,$DD,$CB,$00,$7E,$28,$09,$C5,$CD,$FA,$02
	dc.b	$C1,$DD,$36,$00,$00,$11,$20,$00,$DD,$19,$10,$EA,$21,$00,$00,$22
	dc.b	$2A,$1C,$AF,$32,$09,$1C,$32,$0B,$1C,$C9

; 0x1C20 behaves like an even-valued selector for one of three candidate banks.
; This helper turns 0/2/4 into 0/3/6, uses that as a byte offset into the
; 3-byte descriptor table below, masks 0x1C21 against the bank-local active-bit
; mask, and then scans the selected 0x40-byte records in descending bit order.
; The best matching active record is chosen by its byte at +4 plus the tie-break
; word at +0x3C/+0x3D before the shared helper at 0x0446 is called on it.
Bank080000_Z80ProgramSelectMaskedCandidateRecord_098393:
	dc.b	$3A,$20,$1C,$5F,$0F,$83,$5F,$16,$00,$21,$04,$04,$19,$5E,$23,$56
	dc.b	$23,$D5,$FD,$E1,$3A,$21,$1C,$A6,$4F,$06,$80,$11,$40,$00,$CB,$41
	dc.b	$28,$3A,$FD,$CB,$00,$7E,$C8,$3A,$22,$1C,$FD,$BE,$04,$38,$2D,$CB
	dc.b	$78,$20,$1A,$78,$FD,$BE,$04,$38,$23,$20,$12,$3A,$27,$1C,$FD,$BE
	dc.b	$3D,$38,$0A,$20,$17,$3A,$26,$1C,$FD,$BE,$3C,$30,$0F,$FD,$6E,$3C
	dc.b	$FD,$66,$3D,$22,$26,$1C,$FD,$46,$04,$FD,$E5,$E1,$FD,$19,$CB,$39
	dc.b	$20,$BC,$CB,$78,$C0,$E5,$DD,$E3,$CD,$46,$04,$DD,$E3,$FD,$E1,$AF
	dc.b	$C9

; Each 3-byte descriptor is [record-base little-endian][active-bit mask].
; The three proven families start at 0x1C80, 0x1E00, and 0x1E80 with masks
; 0x3F, 0x07, and 0x01 respectively.
Bank080000_Z80ProgramCandidateBankDescriptorTable_098404:
	dc.b	$80,$1C,$3F
	dc.b	$00,$1E,$07
	dc.b	$80,$1E,$01

; Scan the 0x1C80-rooted 0x40-byte records, matching the local record byte at
; +6 against 0x1C07 and the adjacent packed-delta byte at +7 against the
; current IX-local delta ((IX+0x12) - (IX+0x13)). The helper returns early when
; a match is found; otherwise it exits with carry set after all nine records.
Bank080000_Z80ProgramFindMatchingPackedDeltaRecord_09840D:
	dc.b	$DD,$7E,$12,$DD,$96,$13,$4F,$FD,$21,$80,$1C,$11,$40,$00,$06,$09
	dc.b	$FD,$CB,$00,$7E,$28,$0D,$3A,$07,$1C,$FD,$BE,$06,$20,$05,$79,$FD
	dc.b	$BE,$07,$C8,$FD,$19,$10,$E9,$37,$C9

; Convert the current IX pointer into a packed 0x40-byte record index relative
; to the 0x1C80 base.
Bank080000_Z80ProgramPackWideRecordIndexFromIX_098436:
	dc.b	$DD,$E5,$E1,$01,$80,$E3,$09,$7C,$07,$07,$67,$7D,$07,$07,$B4,$C9

; The next helper is now source-visible too. It calls the shared selector helper at
; 0x0436, stores the resulting local selector split across 0x1C10/0x1C11, then takes
; one of three teardown/update paths based on (IX+1): a local 0x7F11 write path for
; value 2, an alternate fixed-byte path for values above 2, or a four-step clear path
; via 0x06C8/0x06E2 for values below 2.
Bank080000_Z80ProgramFinalizeIndexedSelection_098446:
	dc.b	$CD,$36,$04,$FE,$06,$38,$07,$D6,$06,$32,$11,$1C,$18,$0C

Bank080000_Z80ProgramStoreSplitLocalSelector_098454:
	dc.b	$CB,$3F,$32,$11,$1C,$3E,$00,$17,$07,$32,$10,$1C

	; Branch on (IX+1) after subtracting 2: the equal case writes 0x78 into the IX-local
	; byte at +0x29 and emits a nibble-expanded 0x1C11-derived byte to 0x7F11 before the
	; slot is cleared. The greater-than case instead uses the nearby 0x1C13 latch and a
	; fixed 0xFF write to the same destination.
	dc.b	$DD,$7E,$01,$D6,$02,$38,$25,$20,$14

Bank080000_Z80ProgramFinalizeSelectionEqualCase_098469:
	dc.b	$DD,$36,$29,$78,$3A,$11,$1C,$0F,$0F,$0F,$F6,$9F,$32,$11,$7F
	dc.b	$DD,$36,$00,$00,$C9

Bank080000_Z80ProgramFinalizeSelectionGreaterCase_09847D:
	dc.b	$3E,$78,$32,$13,$1C,$3E,$FF,$32,$11,$7F,$DD,$36,$00,$00,$C9

; The <2 path emits four fixed B values through 0x06C8 with C=$FF, optionally calls
; 0x06E2 when bit 1 of (IX+0) is clear, and then retires the active IX record.
Bank080000_Z80ProgramClearSelectionOutputPaths_09848C:
	dc.b	$0E,$FF,$06,$80,$CD,$C8,$06,$06,$84,$CD,$C8,$06,$06,$88,$CD,$C8
	dc.b	$06,$06,$8C,$CD,$C8,$06,$DD,$CB,$00,$4E,$20,$04,$AF,$CD,$E2,$06
	dc.b	$DD,$36,$00,$00,$C9

; Two neighboring lookup helpers follow. Both derive a small table index from the high
; nibbles of D/E plus the incoming HL base, read one 3-byte local record, and then fold
; the residual through two rounded halves before returning an adjusted DE pair. The only
; proven difference is which loaded byte is subtracted before the first halving step.
Bank080000_Z80ProgramResolveTripleLookupVariantA_0984B1:
	dc.b	$7A,$07,$07,$07,$07,$57,$7B,$0F,$0F,$0F,$0F,$E6,$0E,$B2,$85,$30
	dc.b	$01,$24,$6F,$7E,$23,$56,$23,$6E,$63,$5F,$7D,$93,$CB,$3F,$CB,$64
	dc.b	$28,$07,$6F,$83,$5F,$7D,$30,$01,$14,$CB,$3F,$CB,$5C,$C8,$83,$5F
	dc.b	$D0,$14,$C9

Bank080000_Z80ProgramResolveTripleLookupVariantB_0984E4:
	dc.b	$7A,$07,$07,$07,$07,$57,$7B,$0F,$0F,$0F,$0F,$E6,$0E,$B2,$85,$30
	dc.b	$01,$24,$6F,$7E,$23,$56,$23,$6E,$63,$5F,$95,$CB,$3F,$CB,$64,$28
	dc.b	$07,$6F,$83,$5F,$7D,$30,$01,$14,$CB,$3F,$CB,$5C,$C8,$83,$5F,$D0
	dc.b	$14,$C9

; Bucket the current high byte into coarse threshold bands. Values >= 0x60 take a fixed
; return path, while lower values peel through 0x30 / 0x18 / 0x0C cutoffs, accumulating a
; small band id in C and leaving the reduced high-byte remainder in D.
Bank080000_Z80ProgramBucketizeHighByteThresholds_098516:
	dc.b	$7A,$FE,$60,$38,$06,$11,$F8,$0B,$0E,$07,$C9,$0E,$00,$FE,$30,$38
	dc.b	$04,$D6,$30,$CB,$D1,$FE,$18,$38,$04,$D6,$18,$CB,$C9,$FE,$0C,$38
	dc.b	$03,$D6,$0C,$0C,$57,$C9

; Branch on the IX-local mode byte at +1. The nonzero path first refreshes the masked
; IX-local target word via 0x05A3, then uses the descending odd-aligned lookup table at
; 0x113D plus the threshold bucketizer at 0x0516 / lookup helper at 0x04E4 to derive two
; encoded output bytes written directly to 0x7F11.
Bank080000_Z80ProgramEmitQuantizedOutputPair_09853C:
	dc.b	$DD,$7E,$01,$B7,$28,$37,$CD,$A3,$05,$C8,$CD,$16,$05,$21,$3D,$11
	dc.b	$CD,$E4,$04,$41,$04,$05,$28,$06,$CB,$3A,$CB,$1B,$10,$FA,$7B,$E6
	dc.b	$0F,$4F,$3A,$11,$1C,$0F,$0F,$0F,$B1,$F6,$80,$32,$11,$7F,$7B,$E6
	dc.b	$F0,$CB,$3A,$1F,$CB,$3A,$1F,$0F,$0F,$32,$11,$7F,$C9

; The zero-valued +1 case still refreshes the same masked IX-local target word first, but
; then derives an alternate pair of outputs through 0x1C11 + 0xA4, the ascending table at
; 0x107B, and two calls to the local output helper at 0x06CD.
Bank080000_Z80ProgramEmitQuantizedOutputPair_ZeroMode_098579:
	dc.b	$CD,$A3,$05,$C8,$3A,$11,$1C,$C6,$A4,$47,$CD,$16,$05,$21,$7B,$10
	dc.b	$CD,$B1,$04,$79,$07,$07,$07,$B2,$4F,$CD,$CD,$06,$CB,$90,$4B,$C3
	dc.b	$CD,$06

; Round the incoming low byte in A down to an 8-byte boundary in E, then compare the
; resulting DE pair against HL. The 0x05A3 caller uses the flags to decide whether the
; IX-local target word actually changed.
Bank080000_Z80ProgramCompareMaskedDEAgainstHL_09859B:
	dc.b	$E6,$F8,$5F,$BD,$C0,$7A,$BC,$C9

; Refresh the IX-local target word at +0x0A/+0x0B from the IX-local source word at
; +0x08/+0x09, but only when the rounded-to-8-byte DE value no longer matches the current
; target word.
Bank080000_Z80ProgramRefreshMaskedTargetWord_0985A3:
	dc.b	$DD,$7E,$08,$DD,$56,$09,$DD,$6E,$0A,$DD,$66,$0B,$CD,$9B,$05,$C8
	dc.b	$DD,$73,$0A,$DD,$72,$0B,$C9

; Branch on (IX+1)-2. The equal and greater-than paths clamp one IX-local accumulator around
; +0x28/+0x29, cache the last emitted band in 0x1C13, and write one encoded byte to 0x7F11.
; The <2 path below instead fans the same state across four triplet-spaced IX-local rows.
Bank080000_Z80ProgramRefreshIndexedOutputBand_0985BA:
	dc.b	$DD,$7E,$01,$D6,$02,$38,$55,$20,$2C

Bank080000_Z80ProgramRefreshIndexedOutputBand_EqualCase_0985C3:
	dc.b	$DD,$7E,$00,$E6,$20,$28,$03,$3A,$0B,$1C,$DD,$86,$28,$F2,$D5,$05
	dc.b	$3E,$7F,$E6,$78,$DD,$BE,$29,$C8,$DD,$77,$29,$0F,$0F,$0F,$4F,$3A
	dc.b	$11,$1C,$0F,$0F,$0F,$F6,$90,$B1,$32,$11,$7F,$C9

Bank080000_Z80ProgramRefreshIndexedOutputBand_GreaterCase_0985EF:
	dc.b	$3A,$13,$1C,$47,$DD,$7E,$00,$E6,$20,$28,$03,$3A,$0B,$1C,$4F,$DD
	dc.b	$86,$28,$F2,$06,$06,$3E,$7F,$E6,$78,$B8,$C8,$32,$13,$1C,$0F,$0F
	dc.b	$0F,$F6,$F0,$32,$11,$7F,$C9

; The <2 case begins by calling the local 0x0667 pointer helper, then walks four IX-local
; output rows starting at +0x29 in 3-byte steps. Each row optionally updates its cached byte
; from the 0x0674 lookup table entry selected by the low three bits of (IX+0x24), clamps the
; sum through 0x1C08, and emits row-specific updates through the helper at 0x06C7.
Bank080000_Z80ProgramRefreshIndexedOutputBand_LowModeRows_098616:
	dc.b	$CD,$67,$06,$5E,$DD,$7E,$02,$DD,$86,$1C,$4F,$DD,$7E,$00,$E6,$20
	dc.b	$28,$03,$3A,$0B,$1C,$81,$E2,$31,$06,$3E,$7F,$32,$08,$1C,$DD,$E5
	dc.b	$E1,$01,$28,$00,$09,$50,$4E,$23,$CB,$3B,$30,$1C,$3A,$08,$1C,$81
	dc.b	$F2,$4B,$06,$3E,$7F,$BE,$28,$10,$77,$4F,$7A,$CB,$3F,$30,$02,$F6
	dc.b	$02,$07,$07,$F6,$40,$CD,$C7,$06,$23,$23,$23,$14,$CB,$52,$28,$D6
	dc.b	$C9

; Turn the low three bits of (IX+0x24) into a pointer rooted at 0x0674. Carry from the
; `ADD 0x74` step rolls the high byte from 0x06 to 0x07 so the returned HL pair can address
; either page without additional caller logic.
Bank080000_Z80ProgramResolveLow3LookupPointer_098667:
	dc.b	$DD,$7E,$24,$E6,$07,$C6,$74,$6F,$26,$06,$D0,$24,$C9

; 8-entry table consumed by 0x0667/0x0617 after masking (IX+0x24) down to its low three bits.
Bank080000_Z80ProgramLow3LookupTable_098674:
	dc.b	$08,$08,$08,$08,$0A,$0E,$0E,$0F

; Store the incoming selector byte in 0x1C12, mirror one literal byte directly from the
; source stream when needed, then use the following byte as an index into the 4-byte table
; at 0x164B. The selected four-byte row is compared against the current target bytes at DE;
; changed bytes are emitted through the shared 0x06C3 helper with B values 0x30/0x50/0x60/
; 0x70, and the final byte is also cached into the 0x4000-rooted page selected by 0x1C10.
Bank080000_Z80ProgramExpandIndexedOutputDescriptor_09867C:
	dc.b	$32,$12,$1C,$ED,$A0,$13,$4E,$23,$1A,$B9,$28,$07,$79,$12,$06,$30
	dc.b	$CD,$C3,$06,$13,$7E,$23,$E5,$6F,$26,$00,$29,$29,$01,$4B,$16,$09
	dc.b	$4F,$1A,$B9,$20,$06,$13,$23,$23,$23,$18,$18,$79,$12,$13,$4E,$23
	dc.b	$06,$50,$CD,$C3,$06,$4E,$23,$06,$60,$CD,$C3,$06,$4E,$23,$06,$70
	dc.b	$CD,$C3,$06,$4E,$E1,$06,$80,$3A,$12,$1C,$B0,$47,$3A,$11,$1C,$B0
	dc.b	$47,$3A,$10,$1C,$E5,$6F,$26,$40,$3A,$00,$40,$B7,$FA,$D4,$06,$70
	dc.b	$2C,$18,$00,$71,$E1,$C9

; Combine the incoming A value with the selector bytes at 0x1C10/0x1C11, then write the
; resulting control pair to 0x4000/0x4001. Bit 2 of the second byte is forced from bit 1 of
; 0x1C10, and the path falls back to the shared 0x06F7 writer when 0x4000 is already negative.
Bank080000_Z80ProgramWriteLatchedOutputPair_0986E2:
	dc.b	$06,$28,$4F,$3A,$11,$1C,$FE,$03,$CE,$FF,$B1,$4F,$3A,$10,$1C,$CB
	dc.b	$4F,$28,$02,$CB,$D1,$3A,$00,$40,$B7,$FA,$F7,$06,$78,$32,$00,$40
	dc.b	$18,$00,$18,$00,$79,$32,$01,$40,$C9

; Sweep the active 0x40-byte records rooted at 0x1C80 while cycling the selector bytes at
; 0x1C10/0x1C11. Each active record calls the shared helper at 0x0756 before IX advances to
; the next wide record, and the local counter at 0x1BF6 tracks progress through the sweep.
Bank080000_Z80ProgramSweepActiveWideRecords_09870B:
	dc.b	$DD,$21,$80,$1C,$AF,$32,$F6,$1B,$32,$11,$1C,$AF,$32,$10,$1C,$DD
	dc.b	$CB,$00,$7E,$C4,$56,$07,$11,$40,$00,$DD,$19,$21,$F6,$1B,$34,$3A
	dc.b	$10,$1C,$EE,$02,$20,$E6,$3A,$11,$1C,$3C,$FE,$03,$38,$DA,$AF,$32
	dc.b	$11,$1C,$DD,$CB,$00,$7E,$C4,$56,$07,$11,$40,$00,$DD,$19,$21,$F6
	dc.b	$1B,$34,$3A,$11,$1C,$3C,$FE,$03,$38,$E5,$C9

; The next gate is six bytes wide: it tests bit 6 of the IX-local flags byte and skips ahead
; to 0x098772 when that bit is already set.
Bank080000_Z80ProgramBit6Gate_098756:
	dc.b	$DD,$CB,$00,$76,$20,$16

; The fallthrough path sets that same bit, pushes 0x0772 as a local return target, and then
; dispatches on (IX+1)-2 to one of three deeper handlers still living inside the unresolved
; continuation.
Bank080000_Z80ProgramSetBit6AndDispatchByMode_09875C:
	dc.b	$DD,$CB,$00,$F6,$21,$72,$07,$E5,$DD,$7E,$01,$D6,$02,$DA,$08,$0A
	dc.b	$CA,$B2,$0A,$C3,$A9,$0A

; The next opcode-dense bridge is now explicit too. The front half advances one primary
; IX-local stream whose special bytes live in the $F8-$FF range: $FF reloads HL from the
; stream, $FE/$FD manage a nested countdown plus saved pointer, $FC subtracts the current
; delta word, $FB loads a new delta word, $FA clears the delta/count pair, and $F9/$F8 feed
; the local reload counter / scalar latch before the shared state store at 0x098865.
Bank080000_Z80ProgramAdvancePrimaryStreamState_098772:
	dc.b	$3E,$01,$DD,$CB,$00,$6E,$28,$03,$3A,$17,$1C,$DD,$86,$3C,$DD,$77
	dc.b	$3C,$30,$1D,$DD,$34,$3D,$CA,$60,$04,$E2,$A2,$07,$DD,$CB,$00,$C6
	dc.b	$DD,$7E,$01,$B7,$20,$03,$C3,$E2,$06,$DD,$7E,$01,$B7,$CC,$E2,$06
	dc.b	$DD,$35,$3B,$C2,$6D,$08,$DD,$7E,$3A,$DD,$77,$3B,$DD,$7E,$14,$DD
	dc.b	$86,$16,$DD,$77,$14,$DD,$7E,$15,$DD,$8E,$17,$DD,$77,$15,$DD,$7E
	dc.b	$0E,$B7,$CA,$6D,$08,$DD,$35,$0E,$C2,$6D,$08,$DD,$36,$3F,$00

Bank080000_Z80ProgramPrimaryStreamLoop_0987D2:
	dc.b	$DD,$6E,$10,$DD,$66,$11,$7E,$23,$B7,$CA,$6D,$08,$FE,$F8,$38,$79
	dc.b	$2F,$3D,$F2,$EC,$07

; $FF is the only high control byte whose complemented/decremented value goes negative, so
; it falls through here to reload HL from the following little-endian pointer before the loop
; retries the next primary stream byte.
Bank080000_Z80ProgramReloadPrimaryStreamPointer_0987E7:
	dc.b	$7E,$23,$66,$6F,$18,$EB

Bank080000_Z80ProgramPrimaryStreamCommand_FE_0987ED:
	dc.b	$20,$0D,$DD,$35,$0F,$28,$E4,$DD,$6E,$12,$DD,$66,$13,$18,$DC

Bank080000_Z80ProgramPrimaryStreamCommand_FD_0987FC:
	dc.b	$3D,$20,$0D,$7E,$23,$DD,$77,$0F,$DD,$75,$12,$DD,$74,$13,$18,$CC

Bank080000_Z80ProgramPrimaryStreamCommand_FC_09880C:
	dc.b	$3D,$20,$12,$DD,$96,$16,$DD,$77,$16,$3E,$00,$DD,$9E,$17,$DD,$77
	dc.b	$17,$7E,$23,$18,$44

Bank080000_Z80ProgramPrimaryStreamCommand_FB_098821:
	dc.b	$3D,$20,$0C,$7E,$23,$DD,$77,$14,$7E,$23,$DD,$77,$15,$18,$A8

Bank080000_Z80ProgramPrimaryStreamCommand_FA_09882F:
	dc.b	$3D,$20,$0B,$DD,$77,$16,$DD,$77,$17,$DD,$77,$0E,$18,$30

Bank080000_Z80ProgramPrimaryStreamCommand_F9_09883E:
	dc.b	$3D,$20,$0A,$7E,$23,$DD,$77,$3B,$DD,$77,$3A,$18,$8D

; Literal bytes below $F8 load one countdown byte plus a following delta word. The final
; shared store also captures the post-read HL as the active primary stream pointer.
Bank080000_Z80ProgramLoadPrimaryLiteralState_09884B:
	dc.b	$AF,$DD,$77,$16,$DD,$77,$17,$7E,$23,$DD,$77,$3F,$7E,$23,$18,$0A

Bank080000_Z80ProgramLoadPrimaryLiteralDeltaWord_09885B:
	dc.b	$4E,$23,$DD,$71,$16,$4E,$23,$DD,$71,$17

Bank080000_Z80ProgramStorePrimaryLiteralState_098865:
	dc.b	$DD,$77,$0E,$DD,$75,$10,$DD,$74,$11

; When bit 4 is set in the IX-local flags byte, the current working base at 0x0C/0x0D gains
; one extra IX-local offset word from +0x1A/+0x1B before it is cached back.
Bank080000_Z80ProgramApplyPrimaryWorkingOffset_09886E:
	dc.b	$DD,$6E,$0C,$DD,$66,$0D,$DD,$CB,$00,$66,$28,$27,$DD,$4E,$1A,$DD
	dc.b	$46,$1B,$09,$DD,$5E,$18,$DD,$56,$19,$7C,$BA,$20,$04,$7D,$BB,$28
	dc.b	$08,$CB,$78,$28,$01,$3F,$38,$05,$EB,$DD,$CB,$00,$A6,$DD,$75,$0C
	dc.b	$DD,$74,$0D

; The next routine resolves one secondary target word. When 0x3F is nonzero it calls the
; helper at 0x0B66 to derive a signed base step that is repeatedly doubled B times before the
; current base and the fixed +0x26/+0x27 offset are added in.
Bank080000_Z80ProgramResolveSecondaryTargetWord_0988A1:
	dc.b	$DD,$7E,$3F,$B7,$28,$13,$47,$E5,$CD,$66,$0B,$D1,$6F,$E6,$80,$28
	dc.b	$02,$3E,$FF,$67,$29,$10,$FD,$18,$06,$DD,$5E,$14,$DD,$56,$15,$19
	dc.b	$DD,$5E,$26,$DD,$56,$27,$19,$DD,$75,$08,$DD,$74,$09

; The secondary stream mirrors the primary pattern with a smaller control range. Here $FF
; again reloads HL from the stream, $FE/$FD manage a nested countdown plus saved pointer,
; $FC subtracts the current step byte, $FB loads that step byte, and $FA/$F9 clear or reload
; the local counters before the post-update dispatch at 0x098962.
Bank080000_Z80ProgramAdvanceSecondaryStreamState_0988CE:
	dc.b	$DD,$35,$39,$C2,$62,$09,$DD,$7E,$38,$DD,$77,$39,$DD,$7E,$1C,$DD
	dc.b	$86,$1D,$DD,$77,$1C,$DD,$7E,$1E,$B7,$28,$7A,$DD,$35,$1E,$20,$75
	dc.b	$DD,$6E,$20,$DD,$66,$21,$7E,$23,$B7,$28,$6A,$FE,$F9,$38,$58,$2F
	dc.b	$3D,$F2,$07,$09

Bank080000_Z80ProgramReloadSecondaryStreamPointer_098902:
	dc.b	$7E,$23,$66,$6F,$18,$EC

Bank080000_Z80ProgramSecondaryStreamCommand_FE_098908:
	dc.b	$20,$0D,$DD,$35,$1F,$28,$E5,$DD,$6E,$22,$DD,$66,$23,$18,$DD

Bank080000_Z80ProgramSecondaryStreamCommand_FD_098917:
	dc.b	$3D,$20,$0D,$7E,$23,$DD,$77,$1F,$DD,$75,$22,$DD,$74,$23,$18,$CD

Bank080000_Z80ProgramSecondaryStreamCommand_FC_098927:
	dc.b	$3D,$20,$0B,$AF,$DD,$96,$1D,$DD,$77,$1D,$7E,$23,$18,$25

Bank080000_Z80ProgramSecondaryStreamCommand_FB_098935:
	dc.b	$3D,$20,$07,$7E,$23,$DD,$77,$1C,$18,$B5

Bank080000_Z80ProgramSecondaryStreamCommand_FA_09893E:
	dc.b	$3D,$20,$09,$AF,$DD,$77,$1D,$DD,$77,$1E,$18,$18

Bank080000_Z80ProgramSecondaryStreamCommand_F9_09894A:
	dc.b	$7E,$23,$DD,$77,$39,$DD,$77,$38,$18,$9F

Bank080000_Z80ProgramLoadSecondaryLiteralState_098954:
	dc.b	$4E,$23,$DD,$71,$1D,$DD,$77,$1E,$DD,$75,$20,$DD,$74,$21

; Nonzero (IX+1) routes through 0x0976 before the final bit-7 gate decides whether the deeper
; 0x053C -> 0x05BA path should run.
Bank080000_Z80ProgramFinalizeSecondaryStreamState_098962:
	dc.b	$DD,$7E,$01,$B7,$28,$08,$CD,$76,$09,$DD,$CB,$00,$7E,$C8,$CD,$3C
	dc.b	$05,$C3,$BA,$05

; This next routine is reached directly from the shared post-update dispatch at 0x098962.
; It advances another IX-local countdown/pointer pair, peels a pointed control byte into
; a low-nibble countdown at +0x2C and an upper-band value at +0x30, then refreshes the
; derived byte at +0x28 from that band plus the existing +0x1C state.
Bank080000_Z80ProgramAdvanceIndexedCountdownState_098976:
	dc.b	$DD,$CB,$00,$4E,$20,$1B,$DD,$CB,$00,$46,$28,$49,$DD,$CB,$00,$CE
	dc.b	$DD,$7E,$2F,$B7,$28,$16,$DD,$BE,$30,$30,$11,$DD,$CB,$00,$D6,$18
	dc.b	$67,$DD,$CB,$00,$56,$20,$61,$DD,$35,$2C,$20,$5C,$DD,$7E,$30,$DD
	dc.b	$86,$2E,$DD,$4E,$2F,$0C,$0D,$20,$06,$B7,$FA,$60,$04,$18,$0E,$B7
	dc.b	$F2,$BB,$09,$18,$03,$B9,$38,$05,$79,$DD,$CB,$00,$D6,$DD,$4E,$2D
	dc.b	$DD,$71,$2C,$18,$30,$DD,$7E,$2C,$B7,$28,$2D,$DD,$35,$2C,$20,$28
	dc.b	$DD,$6E,$2A,$DD,$66,$2B,$7E,$FE,$F0,$CA,$60,$04,$23,$4F,$E6,$0F
	dc.b	$DD,$77,$2C,$DD,$75,$2A,$DD,$74,$2B,$79,$0F,$E6,$78,$DD,$86,$02
	dc.b	$F2,$FB,$09,$3E,$7F,$DD,$77,$30,$DD,$7E,$30,$DD,$86,$1C,$DD,$77
	dc.b	$28,$C9

; Dispatch target 0x0A08 from the bit-6 mode gate at 0x09875C. The body indexes the fixed
; 19-byte bank-local record family rooted at local 0x1281 (ROM 0x099281), mirrors two changed
; bytes through 0x06C8, then fans the result out across four triplet-spaced row updates.
Bank080000_Z80ProgramLoadLowModeRecordAndEmitRows_098A08:
	dc.b	$DD,$6E,$03,$26,$00,$5D,$54,$29,$EB,$19,$EB,$29,$29,$29,$19,$11
	dc.b	$81,$12,$19,$7E,$23,$DD,$BE,$24,$28,$09,$DD,$77,$24,$4F,$06,$B0
	dc.b	$CD,$C8,$06,$7E,$23,$DD,$77,$05,$DD,$7E,$3E,$E6,$C0,$4F,$28,$02
	dc.b	$3E,$C0,$2F,$A6,$23,$B1,$DD,$BE,$25,$28,$09,$DD,$77,$25,$4F,$06
	dc.b	$B4,$CD,$C8,$06,$DD,$E5,$D1,$EB,$01,$28,$00,$09,$EB,$AF,$CD,$7C
	dc.b	$06,$3E,$08,$CD,$7C,$06,$3E,$04,$CD,$7C,$06,$3E,$0C,$CD,$7C,$06
	dc.b	$7E,$23,$DD,$77,$26,$7E,$23,$DD,$77,$27,$CD,$04,$0B,$CD,$67,$06
	dc.b	$5E,$DD,$E5,$E1,$01,$28,$00,$09,$50,$7E,$23,$CB,$3B,$38,$13,$BE
	dc.b	$28,$10,$77,$4F,$7A,$CB,$3F,$30,$02,$F6,$02,$07,$07,$F6,$40,$CD
	dc.b	$C7,$06,$23,$23,$23,$14,$CB,$52,$28,$DF,$DD,$7E,$05,$CD,$E2,$06
	dc.b	$C9

; Dispatch target 0x0AA9 is only a tiny fixed-output prelude; it falls straight into the
; shared initializer at 0x098AB2 instead of returning on its own.
Bank080000_Z80ProgramSeedHighModeFixedOutput_098AA9:
	dc.b	$DD,$36,$29,$78,$3E,$DF,$32,$11,$7F

; Dispatch target 0x0AB2 from the same mode gate. The front bytes seed several IX-local state
; fields from compact bank-local records rooted at local 0x1828/0x188F/0x1901/0x19D8, then the
; shared tail at 0x0B5B writes one literal byte and returns.
Bank080000_Z80ProgramInitializeIndexedModeState_098AB2:
	dc.b	$DD,$6E,$03,$26,$00,$5D,$54,$29,$19,$29,$11,$28,$18,$19,$7E,$23
	dc.b	$DD,$77,$2F,$7E,$23,$DD,$77,$2D,$7E,$23,$DD,$77,$2E,$7E,$23,$E5
	dc.b	$6F,$26,$00,$29,$11,$8F,$18,$19,$7E,$23,$66,$6F,$7E,$23,$DD,$75
	dc.b	$2A,$DD,$74,$2B,$5F,$E6,$0F,$DD,$77,$2C,$7B,$0F,$E6,$78,$DD,$86
	dc.b	$02,$F2,$F8,$0A,$3E,$7F,$DD,$77,$30,$E1,$DD,$36,$26,$00,$DD,$36
	dc.b	$27,$E8,$7E,$23,$E5,$6F,$26,$00,$29,$01,$01,$19,$09,$7E,$23,$DD
	dc.b	$77,$10,$7E,$23,$DD,$77,$11,$E1,$6E,$26,$00,$29,$01,$D8,$19,$09
	dc.b	$7E,$23,$DD,$77,$20,$7E,$23,$DD,$77,$21,$AF,$DD,$77,$14,$DD,$77
	dc.b	$15,$DD,$77,$16,$DD,$77,$17,$DD,$77,$1C,$DD,$77,$1D,$DD,$77,$3F
	dc.b	$3C,$DD,$77,$0E,$DD,$77,$3A,$DD,$77,$3B,$DD,$77,$1E,$DD,$77,$38
	dc.b	$DD,$77,$39,$CD,$5B,$0B,$36,$32,$C9

; Return HL = 0x1BF7 + current scratch index from 0x1BF6.
Bank080000_Z80ProgramResolveIndexedScratchPointer_098B5B:
	dc.b	$3A,$F6,$1B,$21,$F7,$1B,$85,$6F,$D0,$24,$C9

; Called from 0x0988A1 after the helper above. It repeatedly doubles/accumulates the current
; scratch byte, adds 0x7F, stores the result back through the same pointer, and returns.
Bank080000_Z80ProgramScaleIndexedScratchByte_098B66:
	dc.b	$CD,$5B,$0B,$7E,$4F,$CB,$21,$CB,$21,$81,$CB,$21,$CB,$21,$81,$CB
	dc.b	$21,$81,$CB,$21,$81,$C6,$7F,$77,$C9

; The next bridge is explicit too. The front sweep walks the 0x1EC0-rooted 0x20-byte slot
; records and hands each bit-7-marked entry to the per-slot updater below. Keep the owner
; structural until the wider loader path proves whether these are voices, tasks, or another
; fixed slot family.
Bank080000_Z80ProgramSweepMarkedSlotRecords_098B7F:
	dc.b	$DD,$21,$C0,$1E,$AF,$32,$07,$1C,$DD,$CB,$00,$7E,$C4,$9C,$0B,$11
	dc.b	$20,$00,$DD,$19,$3A,$07,$1C,$3C,$FE,$0A,$38,$E9,$C9

; Advance one bit-7-marked slot record. If bit 6 is still clear in the slot flags, this path
; seeds several countdown/state bytes, preserves only the low bit of (IX+0x11), and then falls
; into the shared stream-driven update path. The update itself decrements the slot-local word at
; +0x02/+0x03, reloads the pointed stream at +0x06/+0x07 when that word expires, snapshots the
; local base word into 0x1C18/0x1C19, and dispatches on the next control byte. Bytes >= 0xE0 jump
; through the local handler table at 0x0E62, 0xD0-0xDF route through helper 0x0E55, 0xC0-0xCF use
; the compact table at 0x0E35 to synthesize a triple-scaled word, and all lower values route
; through helper 0x0CA5 before the accumulated state is folded back into the slot.
Bank080000_Z80ProgramAdvanceMarkedSlotRecord_098B9C:
	dc.b	$DD,$CB,$10,$7E,$28,$06,$3A,$03,$1C,$CB,$47,$C0,$DD,$CB,$00,$76
	dc.b	$20,$35,$DD,$CB,$00,$F6,$AF,$DD,$77,$02,$DD,$77,$03,$DD,$77,$01
	dc.b	$DD,$77,$12,$DD,$77,$13,$DD,$77,$08,$DD,$77,$09,$DD,$36,$0A,$0F
	dc.b	$DD,$36,$0B,$08,$DD,$77,$0C,$DD,$77,$0D,$DD,$77,$0E,$DD,$7E,$11
	dc.b	$E6,$01,$DD,$77,$11,$18,$1F,$DD,$6E,$02,$DD,$66,$03,$1E,$09,$DD
	dc.b	$CB,$10,$7E,$28,$04,$3A,$06,$1C,$5F,$AF,$57,$ED,$52,$DD,$75,$02
	dc.b	$DD,$74,$03,$28,$01,$D0,$DD,$5E,$06,$DD,$56,$07,$AF,$32,$1A,$1C
	dc.b	$32,$1B,$1C,$DD,$6E,$04,$DD,$66,$05,$22,$18,$1C,$1A,$13,$FE,$E0
	dc.b	$38,$14,$87,$E6,$3E,$C6,$62,$6F,$3E,$00,$CE,$0E,$67,$7E,$23,$66
	dc.b	$6F,$01,$18,$0C,$C5,$E9,$FE,$D8,$38,$07,$D6,$D7,$CD,$55,$0E,$18
	dc.b	$DB,$FE,$D0,$38,$0B,$D6,$CF,$CD,$55,$0E,$EB,$5E,$23,$56,$18,$CC
	dc.b	$FE,$C0,$38,$1B,$E6,$0F,$4F,$06,$00,$21,$35,$0E,$09,$6E,$26,$00
	dc.b	$4D,$44,$29,$09,$22,$18,$1C,$DD,$75,$04,$DD,$74,$05,$18,$AD,$FE
	dc.b	$60,$38,$07,$D6,$60,$CD,$A5,$0C,$18,$A2,$CD,$A5,$0C,$DD,$73,$06
	dc.b	$DD,$72,$07,$3A,$18,$1C,$DD,$86,$02,$DD,$77,$02,$3A,$19,$1C,$DD
	dc.b	$8E,$03,$DD,$77,$03,$3A,$1B,$1C,$DD,$77,$13,$DD,$CB,$00,$A6,$3A
	dc.b	$1A,$1C,$B7,$C8,$DD,$CB,$00,$E6,$C9

; The next bridge initializes one IY-local record from the current IX slot. The front path
; either pulls a 6-byte descriptor from the local 0x19F1 family using the incoming A value,
; or reuses the current IX state plus the candidate-selection helpers at 0x0393 / 0x040D.
Bank080000_Z80ProgramInitializeDescriptorDrivenRecord_098CA5:
	dc.b	$D5,$DD,$CB,$11,$46,$C2,$12,$0E,$DD,$CB,$00,$46,$28,$38,$6F,$87
	dc.b	$85,$6F,$26,$00,$CB,$14,$29,$11,$F1,$19,$19,$7E,$23,$32,$20,$1C
	dc.b	$7E,$23,$32,$21,$1C,$DD,$7E,$10,$E6,$7F,$32,$22,$1C,$E5,$CD,$93
	dc.b	$03,$E1,$C2,$12,$0E,$7E,$23,$FD,$77,$03,$7E,$23,$4F,$E6,$3F,$5E
	dc.b	$23,$56,$EB,$C3,$A5,$0D

; When bit 0 is clear in the current IX slot flags, this alternate path seeds the candidate
; state from the IX-local base word and either reuses the current IY record or falls back to
; the local selection helpers before sharing the initializer below.
Bank080000_Z80ProgramInitializeIndexedTargetRecord_098CE8:
	dc.b	$DD,$86,$0D,$67,$DD,$6E,$0C,$22,$24,$1C,$DD,$7E,$08,$32,$20,$1C
	dc.b	$DD,$CB,$00,$6E,$28,$61,$CD,$0D,$04,$38,$7C,$DD,$CB,$00,$66,$20
	dc.b	$09,$FD,$E5,$DD,$E3,$CD,$46,$04,$DD,$E1,$2A,$24,$1C,$FD,$75,$18
	dc.b	$FD,$74,$19,$FD,$5E,$0C,$FD,$56,$0D,$B7,$ED,$52,$F5,$30,$07,$AF
	dc.b	$95,$6F,$3E,$00,$9C,$67,$AF,$06,$10,$DD,$4E,$0F,$29,$17,$B9,$38
	dc.b	$02,$91,$2C,$10,$F7,$F1,$30,$07,$AF,$95,$6F,$3E,$00,$9C,$67,$FD
	dc.b	$75,$1A,$FD,$74,$1B,$DD,$CB,$00,$66,$20,$20,$FD,$36,$00,$80,$DD
	dc.b	$7E,$0B,$DD,$4E,$11,$18,$49,$DD,$CB,$00,$66,$28,$1A,$CD,$0D,$04
	dc.b	$38,$15,$2A,$24,$1C,$FD,$75,$0C,$FD,$74,$0D,$CD,$1B,$0E,$DD,$7E
	dc.b	$12,$FD,$77,$07,$C3,$12,$0E

; If the candidate-selection helper at 0x0393 succeeds, this shorter path reuses IX-local
; bytes 0x09/0x0A/0x0B plus the shared word at 0x1C24 before falling into the same IY-local
; initializer.
Bank080000_Z80ProgramInitializeMatchedTargetRecord_098D81:
	dc.b	$DD,$7E,$0A,$32,$21,$1C,$DD,$7E,$10,$E6,$7F,$32,$22,$1C,$CD,$93
	dc.b	$03,$C2,$12,$0E,$DD,$7E,$09,$FD,$77,$03,$DD,$7E,$0B,$DD,$4E,$11

; Shared IY-local initializer for the two paths above. It stores the working base word,
; calls the local mode-table helper at 0x0E1B, derives the countdown bytes at +0x3C/+0x3D,
; mirrors the slot id/counter fields, then commits the new IY record and advances the slot
; counters when the setup succeeds.
Bank080000_Z80ProgramFinalizeSlotTransferToIY_098DA5:
	dc.b	$2A,$24,$1C,$FD,$75,$0C,$FD,$74,$0D,$FD,$71,$3E,$CD,$1B,$0E,$21
	dc.b	$1A,$1C,$CB,$46,$28,$06,$AF,$FD,$77,$3C,$18,$1B,$06,$05,$ED,$5B
	dc.b	$18,$1C,$21,$00,$00,$CB,$3C,$CB,$1D,$1F,$30,$01,$19,$10,$F6,$AF
	dc.b	$95,$FD,$77,$3C,$3E,$80,$9C,$FD,$77,$3D,$3A,$20,$1C,$B7,$28,$03
	dc.b	$FD,$77,$01,$0E,$80,$DD,$7E,$10,$B7,$F2,$F2,$0D,$E6,$7F,$0E,$A0
	dc.b	$DD,$CB,$00,$6E,$28,$08,$FD,$CB,$00,$7E,$28,$02,$CB,$E1,$FD,$77
	dc.b	$04,$FD,$71,$00,$3A,$07,$1C,$FD,$77,$06,$DD,$7E,$12,$FD,$77,$07

Bank080000_Z80ProgramCommitInitializedIYRecord_098E12:
	dc.b	$D1,$DD,$34,$12,$21,$1B,$1C,$34,$C9

; Select one byte from one of two local tables rooted at 0x1200/0x1240 using the IX-local
; mode byte at +0x0E. The result is stored in the active IY record at +0x02.
Bank080000_Z80ProgramLoadIYByteFromModeTable_098E1B:
	dc.b	$21,$00,$12,$FD,$46,$01,$04,$05,$28,$03,$21,$40,$12,$DD,$5E,$0E
	dc.b	$CB,$3B,$16,$00,$19,$6E,$FD,$75,$02,$C9

; Low-nibble scale table consumed by the 0x0CA5 / 0x0E55 control-byte bridge.
Bank080000_Z80ProgramArgumentScaleTable_098E35:
	dc.b	$06,$09,$0C,$12,$18,$24,$30,$48,$60,$90,$C0,$08,$10,$20,$3C,$78

; Turn the current triplet count in (IX+1) into a write pointer rooted at IX+0x14.
Bank080000_Z80ProgramResolveTripletWritePointer_098E45:
	dc.b	$DD,$7E,$01,$6F,$87,$85,$C6,$14,$DD,$E5,$E1,$85,$6F,$D0,$24,$C9

; Append one [lo][hi][tag] triplet to that IX-local write area and then advance the count.
Bank080000_Z80ProgramAppendTripletWrite_098E55:
	dc.b	$4F,$CD,$45,$0E,$73,$23,$72,$23,$71,$DD,$34,$01,$C9

; Dispatch table for the high-byte command range 0xE0-0xFF used by the marked-slot updater at
; 0x098B9C. Most entries stay local, while the final 0xFF command already jumps out to the
; external helper at local 0x131A (ROM 0x09931A).
Bank080000_Z80ProgramHighCommandDispatchTable_098E62:
	dc.b	$A2,$0E ; $E0 -> 0x0EA2
	dc.b	$AC,$0E ; $E1 -> 0x0EAC
	dc.b	$B1,$0E ; $E2 -> 0x0EB1
	dc.b	$B8,$0E ; $E3 -> 0x0EB8
	dc.b	$CC,$0E ; $E4 -> 0x0ECC
	dc.b	$AB,$0E ; $E5 -> 0x0EAB
	dc.b	$AB,$0E ; $E6 -> 0x0EAB
	dc.b	$AB,$0E ; $E7 -> 0x0EAB
	dc.b	$AB,$0E ; $E8 -> 0x0EAB
	dc.b	$AB,$0E ; $E9 -> 0x0EAB
	dc.b	$AB,$0E ; $EA -> 0x0EAB
	dc.b	$AB,$0E ; $EB -> 0x0EAB
	dc.b	$AB,$0E ; $EC -> 0x0EAB
	dc.b	$AB,$0E ; $ED -> 0x0EAB
	dc.b	$AB,$0E ; $EE -> 0x0EAB
	dc.b	$AB,$0E ; $EF -> 0x0EAB
	dc.b	$D7,$0E ; $F0 -> 0x0ED7
	dc.b	$DD,$0E ; $F1 -> 0x0EDD
	dc.b	$E3,$0E ; $F2 -> 0x0EE3
	dc.b	$EE,$0E ; $F3 -> 0x0EEE
	dc.b	$FF,$0E ; $F4 -> 0x0EFF
	dc.b	$05,$0F ; $F5 -> 0x0F05
	dc.b	$0E,$0F ; $F6 -> 0x0F0E
	dc.b	$25,$0F ; $F7 -> 0x0F25
	dc.b	$2B,$0F ; $F8 -> 0x0F2B
	dc.b	$34,$0F ; $F9 -> 0x0F34
	dc.b	$41,$0F ; $FA -> 0x0F41
	dc.b	$45,$0F ; $FB -> 0x0F45
	dc.b	$4B,$0F ; $FC -> 0x0F4B
	dc.b	$51,$0F ; $FD -> 0x0F51
	dc.b	$56,$0F ; $FE -> 0x0F56
	dc.b	$66,$0F ; $FF -> 0x0F66

; 0xE0 loads one inline byte into (IX+0x0F) and marks bit 5 in the slot flags.
Bank080000_Z80ProgramHighCommandHandler_E0_098EA2:
	dc.b	$1A,$13,$DD,$77,$0F,$DD,$CB,$00,$EE

; 0xE5-0xEF all alias this bare return for now.
Bank080000_Z80ProgramHighCommandHandler_NoOp_098EAB:
	dc.b	$C9

; 0xE1 clears bit 5 in the slot flags.
Bank080000_Z80ProgramHighCommandHandler_E1_098EAC:
	dc.b	$DD,$CB,$00,$AE,$C9

; 0xE2 and 0xE3 share the same triple-scaling tail: 0xE2 treats the next inline byte as a
; small index, while 0xE3 instead loads a little-endian word from the stream first.
Bank080000_Z80ProgramHighCommandHandler_E2_098EB1:
	dc.b	$1A,$13,$6F,$26,$00,$18,$06

Bank080000_Z80ProgramHighCommandHandler_E3_098EB8:
	dc.b	$EB,$5E,$23,$56,$23,$EB,$4D,$44,$29,$09,$22,$18,$1C,$DD,$75,$04
	dc.b	$DD,$74,$05,$C9

; 0xE4 reloads the two stream bytes cached at 0x1C14/0x1C15.
Bank080000_Z80ProgramHighCommandHandler_E4_098ECC:
	dc.b	$1A,$13,$32,$14,$1C,$1A,$13,$32,$15,$1C,$C9

Bank080000_Z80ProgramHighCommandHandler_F0_098ED7:
	dc.b	$1A,$13,$DD,$77,$09,$C9

Bank080000_Z80ProgramHighCommandHandler_F1_098EDD:
	dc.b	$1A,$13,$DD,$77,$0B,$C9

Bank080000_Z80ProgramHighCommandHandler_F2_098EE3:
	dc.b	$1A,$13,$DD,$77,$0C,$1A,$13,$DD,$77,$0D,$C9

; 0xF3 adds one inline little-endian word into the IX-local +0x0C/+0x0D pair.
Bank080000_Z80ProgramHighCommandHandler_F3_098EEE:
	dc.b	$1A,$13,$DD,$86,$0C,$DD,$77,$0C,$1A,$13,$DD,$8E,$0D,$DD,$77,$0D
	dc.b	$C9

Bank080000_Z80ProgramHighCommandHandler_F4_098EFF:
	dc.b	$1A,$13,$DD,$77,$0E,$C9

Bank080000_Z80ProgramHighCommandHandler_F5_098F05:
	dc.b	$1A,$13,$DD,$86,$0E,$DD,$77,$0E,$C9

; 0xF6 stores one mode byte at +0x08, then derives one of three fixed class values for +0x0A.
Bank080000_Z80ProgramHighCommandHandler_F6_098F0E:
	dc.b	$1A,$13,$DD,$77,$08,$D6,$02,$3E,$3F,$38,$08,$28,$04,$3E,$01,$18
	dc.b	$02,$3E,$07,$DD,$77,$0A,$C9

Bank080000_Z80ProgramHighCommandHandler_F7_098F25:
	dc.b	$1A,$13,$DD,$77,$0A,$C9

Bank080000_Z80ProgramHighCommandHandler_F8_098F2B:
	dc.b	$DD,$7E,$00,$EE,$01,$DD,$77,$00,$C9

; 0xF9 patches the low six bits of (IX+0x11) with one inline mask byte.
Bank080000_Z80ProgramHighCommandHandler_F9_098F34:
	dc.b	$DD,$7E,$11,$E6,$3F,$4F,$1A,$13,$B1,$DD,$77,$11,$C9

Bank080000_Z80ProgramHighCommandHandler_FA_098F41:
	dc.b	$E1,$C3,$79,$0C

Bank080000_Z80ProgramHighCommandHandler_FB_098F45:
	dc.b	$D5,$CD,$FA,$02,$D1,$C9

Bank080000_Z80ProgramHighCommandHandler_FC_098F4B:
	dc.b	$3E,$01,$32,$1A,$1C,$C9

Bank080000_Z80ProgramHighCommandHandler_FD_098F51:
	dc.b	$EB,$5E,$23,$56,$C9

; 0xFE walks backward through the IX-local triplet area rooted at IX+0x14, either decreasing
; the current countdown byte or returning the preceding little-endian pair.
Bank080000_Z80ProgramHighCommandHandler_FE_098F56:
	dc.b	$CD,$45,$0E,$2B,$35,$20,$04,$DD,$35,$01,$C9,$2B,$56,$2B,$5E,$C9

; 0xFF is the local tail of the same triplet walker. When no triplets remain it retires the
; current slot through 0x02FA; otherwise it decrements the current record, optionally drops one
; triplet from the count, and returns the surviving little-endian pair in DE.
Bank080000_Z80ProgramHighCommandHandler_FF_098F66:
	dc.b	$DD,$7E,$01,$B7,$C2,$76,$0F,$E1,$CD,$FA,$02,$DD,$36,$00,$00,$C9
	dc.b	$3D,$CD,$48,$0E,$5E,$23,$56,$23,$35,$20,$06,$DD,$35,$01,$13,$13
	dc.b	$C9,$EB,$5E,$23,$56,$C9

; The repeated jump stubs at 0x098020/0x098028/0x098030 all hand off here. This routine
; snapshots primary plus alternate register state into 0x1B80+, mirrors three variable-length
; transfer slots out to their destination pointers, raises the 0x1B98/0x1B99 handshake flags,
; then waits for an external clear of 0x1B99 before copying those slots back locally and
; stamping the destination heads with E7/EF/F7 plus zero fill.
Bank080000_Z80ProgramStateSnapshotAndTransferHandshake_098F8C:
	dc.b	$ED,$43,$82,$1B,$ED,$53,$84,$1B,$22,$86,$1B,$DD,$22,$88,$1B,$FD
	dc.b	$22,$8A,$1B,$E1,$22,$8C,$1B,$ED,$73,$8E,$1B,$F5,$E1,$22,$80,$1B
	dc.b	$08,$F5,$08,$E1,$22,$90,$1B,$D9,$ED,$43,$92,$1B,$ED,$53,$94,$1B
	dc.b	$22,$96,$1B,$D9

; Each transfer descriptor is [target word][length byte][local mirror bytes]. The first copy
; phase exports the local mirror rooted at 0x1BA3/0x1BAB/0x1BB3 whenever the corresponding
; length byte is nonzero.
Bank080000_Z80ProgramCopyOutTransferSlot0_098FC0:
	dc.b	$3A,$A2,$1B,$B7,$28,$0C,$4F,$06,$00,$21,$A3,$1B,$ED,$5B,$A0,$1B
	dc.b	$ED,$B0

Bank080000_Z80ProgramCopyOutTransferSlot1_098FD2:
	dc.b	$3A,$AA,$1B,$B7,$28,$0C,$4F,$06,$00,$21,$AB,$1B,$ED,$5B,$A8,$1B
	dc.b	$ED,$B0

Bank080000_Z80ProgramCopyOutTransferSlot2_098FE4:
	dc.b	$3A,$B2,$1B,$B7,$28,$0C,$4F,$06,$00,$21,$B3,$1B,$ED,$5B,$B0,$1B
	dc.b	$ED,$B0

; Raise the two handshake flags, then busy-wait until an external owner clears 0x1B99.
Bank080000_Z80ProgramWaitForExternalAck_098FF6:
	dc.b	$3E,$01,$32,$98,$1B,$32,$99,$1B,$3A,$99,$1B,$B7,$20,$FA

; After the external side finishes, copy each slot back into its local mirror and overwrite the
; destination region with a slot-specific marker byte followed by zero fill.
Bank080000_Z80ProgramCopyBackAndClearTransferSlot0_099004:
	dc.b	$3A,$A2,$1B,$B7,$28,$18,$4F,$06,$00,$2A,$A0,$1B,$11,$A3,$1B,$ED
	dc.b	$B0,$2A,$A0,$1B,$36,$E7,$23,$3D,$28,$04,$36,$00,$18,$F8

Bank080000_Z80ProgramCopyBackAndClearTransferSlot1_099022:
	dc.b	$3A,$AA,$1B,$B7,$28,$18,$4F,$06,$00,$2A,$A8,$1B,$11,$AB,$1B,$ED
	dc.b	$B0,$2A,$A8,$1B,$36,$EF,$23,$3D,$28,$04,$36,$00,$18,$F8

Bank080000_Z80ProgramCopyBackAndClearTransferSlot2_099040:
	dc.b	$3A,$B2,$1B,$B7,$28,$18,$4F,$06,$00,$2A,$B0,$1B,$11,$B3,$1B,$ED
	dc.b	$B0,$2A,$B0,$1B,$36,$F7,$23,$3D,$28,$04,$36,$00,$18,$F8

; Restore the primary register subset plus the saved return address, drop the busy flag at 0x1B98,
; and return. IX/IY and the alternate register set are only snapshotted here; this local tail does
; not restore them itself.
Bank080000_Z80ProgramRestoreStateAndReturn_09905E:
	dc.b	$ED,$4B,$82,$1B,$ED,$5B,$84,$1B,$ED,$7B,$8E,$1B,$2A,$8C,$1B,$E5
	dc.b	$2A,$80,$1B,$E5,$2A,$86,$1B,$AF,$32,$98,$1B,$F1,$C9

Bank080000_Z80ProgramOddAlignedAscendingWordTable_09907B:
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

Bank080000_Z80ProgramOddAlignedDescendingWordTable_09913D:
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

Bank080000_Z80ProgramLookupTableTailByte_0991FF:
	dc.b	$00
