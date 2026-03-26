SystemStackTop           equ $00FF0C00
WorkRamStart             equ $00FF0000
WorkRamEnd               equ $00FFFFFF
TaskScriptScratchBuffer   equ $00FF3300
VBlankDispatchFlags      equ $00FF8006
VBlankDispatchFlags_Short equ $FFFF8006
TaskCompletionResult      equ $00FF8068
TaskCompletionResult_Short equ $FFFF8068
ImmediateTaskSlots       equ $00FF8048
ImmediateTaskSlots_Short equ $FFFF8048
ImmediateTaskSlot0Callback equ $00FF8054
ImmediateTaskSlot0Callback_Short equ $FFFF8054
SecondaryTaskSlots       equ $00FF80C8
SecondaryTaskSlots_Short equ $FFFF80C8
RoundRobinTaskSlots      equ $00FF8248
RoundRobinTaskSlots_Short equ $FFFF8248
ImmediateTaskCursor      equ $00FF8A48
ImmediateTaskCursor_Short equ $FFFF8A48
VBlankTickCounter        equ $00FF8A49
VBlankTickCounter_Short  equ $FFFF8A49
RoundRobinTaskIndex      equ $00FF8A4A
RoundRobinTaskIndex_Short equ $FFFF8A4A
TaskDispatchBudget       equ $00FF8A4B
TaskDispatchBudget_Short equ $FFFF8A4B
CurrentTaskSlotPointer   equ $00FF8A4C
CurrentTaskSlotPointer_Short equ $FFFF8A4C
TaskScriptCountdown      equ $00FF8A4E
TaskScriptCountdown_Short equ $FFFF8A4E
TaskScriptValue          equ $00FF8A4F
TaskScriptValue_Short    equ $FFFF8A4F
TaskScriptMode           equ $00FF8A50
TaskScriptMode_Short     equ $FFFF8A50
SelectedInputPlaybackCountdown equ $00FF8A4E
SelectedInputPlaybackCountdown_Short equ $FFFF8A4E
SelectedInputPlaybackValue equ $00FF8A4F
SelectedInputPlaybackValue_Short equ $FFFF8A4F
SelectedInputPlaybackMode equ $00FF8A50
SelectedInputPlaybackMode_Short equ $FFFF8A50
TaskScriptFlags          equ $00FF8A51
TaskScriptFlags_Short    equ $FFFF8A51
TaskScriptStateLong      equ $00FF8A52
TaskScriptStateLong_Short equ $FFFF8A52
TaskScriptProgressCurrent equ $00FF8A7A
TaskScriptProgressCurrent_Short equ $FFFF8A7A
TaskScriptProgressPrevious equ $00FF8A7B
TaskScriptProgressPrevious_Short equ $FFFF8A7B
TaskScriptProgressFlags  equ $00FF8A7C
TaskScriptProgressFlags_Short equ $FFFF8A7C
SecondaryTaskStatusSelector equ $00FF8A7D
SecondaryTaskStatusSelector_Short equ $FFFF8A7D
SelectedInputCurrent     equ $00FF8A7A
SelectedInputCurrent_Short equ $FFFF8A7A
SelectedInputPrevious    equ $00FF8A7B
SelectedInputPrevious_Short equ $FFFF8A7B
SelectedInputPressed     equ $00FF8A7C
SelectedInputPressed_Short equ $FFFF8A7C
SelectedInputSource      equ $00FF8A7D
SelectedInputSource_Short equ $FFFF8A7D
; `0x8A7A-0x8A7D` is still shared between the task/bootstrap path and live pad input.
; Current best fit: the task/bootstrap path reuses this quartet as the selected-input
; playback mirror, while `0x8A4E-0x8A50` holds the packed duration/value state loaded
; from `TaskScriptProgressBuffer`.
Player1InputCurrent      equ $00FF8A7F
Player1InputCurrent_Short equ $FFFF8A7F
Player1InputPrevious     equ $00FF8A80
Player1InputPrevious_Short equ $FFFF8A80
SecondaryTaskReadySlot0   equ $00FF8A81
SecondaryTaskReadySlot0_Short equ $FFFF8A81
Player1InputPressed      equ $00FF8A81
Player1InputPressed_Short equ $FFFF8A81
Player2InputCurrent      equ $00FF8A82
Player2InputCurrent_Short equ $FFFF8A82
Player2InputPrevious     equ $00FF8A83
Player2InputPrevious_Short equ $FFFF8A83
SecondaryTaskReadySlot1   equ $00FF8A84
SecondaryTaskReadySlot1_Short equ $FFFF8A84
Player2InputPressed      equ $00FF8A84
Player2InputPressed_Short equ $FFFF8A84
MenuTextTransferRowId    equ $00FF8A77
MenuTextTransferRowId_Short equ $FFFF8A77
BootstrapPatchSlot0      equ $00FF8B34
BootstrapPatchSlot0_Short equ $FFFF8B34
BootstrapPatchSlot1      equ $00FF8B36
BootstrapPatchSlot1_Short equ $FFFF8B36
BootstrapPatchSlot2      equ $00FF8B38
BootstrapPatchSlot2_Short equ $FFFF8B38
BootstrapPatchSlot3      equ $00FF8B3A
BootstrapPatchSlot3_Short equ $FFFF8B3A
TaskDispatchTimingFlags  equ $00FF8A5D
TaskDispatchTimingFlags_Short equ $FFFF8A5D
MenuTextMetricNormalizeFlag equ $00FF8A8B
MenuTextMetricNormalizeFlag_Short equ $FFFF8A8B
TaskAdvanceReadyFlags    equ $00FF8C56
TaskAdvanceReadyFlags_Short equ $FFFF8C56
InventoryMenuEntryTextWidth equ $00FF8CDE
InventoryMenuEntryTextWidth_Short equ $FFFF8CDE
InventoryMenuEntryTileRow0Buffer equ $00FF8CE0
InventoryMenuEntryTileRow0Buffer_Short equ $FFFF8CE0
InventoryMenuEntryTileRow1Buffer equ $00FF8CF0
InventoryMenuEntryTileRow1Buffer_Short equ $FFFF8CF0
InventoryMenuNestedTextStreamStackOffset equ $00FF8D10
InventoryMenuNestedTextStreamStackOffset_Short equ $FFFF8D10
MenuTextOutputFrameBuffer equ $00FF8D12
MenuTextOutputFrameBuffer_Short equ $FFFF8D12
MenuTextMetricBaseX equ $00FF8D92
MenuTextMetricBaseX_Short equ $FFFF8D92
MenuTextMetricBaseY equ $00FF8D94
MenuTextMetricBaseY_Short equ $FFFF8D94
MenuTextMetricCursorX equ $00FF8D9A
MenuTextMetricCursorX_Short equ $FFFF8D9A
MenuTextMetricCursorY equ $00FF8D9C
MenuTextMetricCursorY_Short equ $FFFF8D9C
MenuTextMetricWidth equ $00FF8C9E
MenuTextMetricWidth_Short equ $FFFF8C9E
MenuTextMetricHeight equ $00FF8CA0
MenuTextMetricHeight_Short equ $FFFF8CA0
MenuTextMetricFlags equ $00FF8CA4
MenuTextMetricFlags_Short equ $FFFF8CA4
MenuTextUploadWidth equ $00FF8D9E
MenuTextUploadWidth_Short equ $FFFF8D9E
MenuTextUploadHeight equ $00FF8DA0
MenuTextUploadHeight_Short equ $FFFF8DA0
MenuTextRectColumnCount equ $00FF8DA2
MenuTextRectColumnCount_Short equ $FFFF8DA2
MenuTextRectRowCount equ $00FF8DA4
MenuTextRectRowCount_Short equ $FFFF8DA4
MenuTextUploadTileStride equ $00FF8DA6
MenuTextUploadTileStride_Short equ $FFFF8DA6
MenuTextUploadScratchBuffer equ $00FF8DA8
MenuTextUploadScratchBuffer_Short equ $FFFF8DA8
MagicMenuSpellBarEmptyTileCountScratch equ $00FF95B7
MagicMenuSpellBarEmptyTileCountScratch_Short equ $FFFF95B7
MagicMenuSpellBarFillDeltaScratch equ $00FF95B2
MagicMenuSpellBarFillDeltaScratch_Short equ $FFFF95B2
MagicMenuStatusGaugeTileIdBuffer equ $00FF95AA
MagicMenuStatusGaugeTileIdBuffer_Short equ $FFFF95AA
MagicMenuSpellBarFillBase equ $00FF95B8
MagicMenuSpellBarFillBase_Short equ $FFFF95B8
MagicMenuSpellBarCapacityBase equ $00FF95BE
MagicMenuSpellBarCapacityBase_Short equ $FFFF95BE
MagicMenuSpellBarFilledTileCountScratch equ $00FF95C8
MagicMenuSpellBarFilledTileCountScratch_Short equ $FFFF95C8
MagicMenuStatusSelectionScratchBuffer equ $00FF95CE
MagicMenuStatusSelectionScratchBuffer_Short equ $FFFF95CE
MagicMenuStatusLayoutRecordIndex equ $00FF95D1
MagicMenuStatusLayoutRecordIndex_Short equ $FFFF95D1
MagicMenuStatusSelectionScratchSnapshot equ $00FF95D2
MagicMenuStatusSelectionScratchSnapshot_Short equ $FFFF95D2
MagicMenuValidTopRowSelection0 equ $00FF95E2
MagicMenuValidTopRowSelection0_Short equ $FFFF95E2
MagicMenuValidTopRowSelection1 equ $00FF95E3
MagicMenuValidTopRowSelection1_Short equ $FFFF95E3
InventoryMenuPreviousCategoryEntryId equ $00FF95D6
InventoryMenuPreviousCategoryEntryId_Short equ $FFFF95D6
SelectedInputRepeatLatchedValue equ $00FF95D7
SelectedInputRepeatLatchedValue_Short equ $FFFF95D7
SelectedInputRepeatCountdown equ $00FF95D8
SelectedInputRepeatCountdown_Short equ $FFFF95D8
SelectedInputRepeatOutput equ $00FF95D9
SelectedInputRepeatOutput_Short equ $FFFF95D9
InventoryMenuTransferRowScratch equ $00FF95DA
InventoryMenuTransferRowScratch_Short equ $FFFF95DA
InventoryMenuSkipArrowRefreshFlag equ $00FF95DB
InventoryMenuSkipArrowRefreshFlag_Short equ $FFFF95DB
InventoryMenuArrowRefreshSuppressCounter equ $00FF95DB
InventoryMenuArrowRefreshSuppressCounter_Short equ $FFFF95DB
MagicMenuStatusGraphicCache0 equ $00FF95DC
MagicMenuStatusGraphicCache0_Short equ $FFFF95DC
MagicMenuStatusGraphicCache1 equ $00FF95DD
MagicMenuStatusGraphicCache1_Short equ $FFFF95DD
InventoryMenuBlinkPhaseCountdown equ $00FF95DE
InventoryMenuBlinkPhaseCountdown_Short equ $FFFF95DE
InventoryMenuBlinkPhaseToggle equ $00FF95DF
InventoryMenuBlinkPhaseToggle_Short equ $FFFF95DF
MagicMenuSubmodeModalFlag equ $00FF95E0
MagicMenuSubmodeModalFlag_Short equ $FFFF95E0
InventoryMenuLevelScratch equ $00FF95E1
InventoryMenuLevelScratch_Short equ $FFFF95E1
MagicMenuSubmodeSavedSelectionIndex equ $00FF95E4
MagicMenuSubmodeSavedSelectionIndex_Short equ $FFFF95E4
MagicMenuSubmodeSelectedValue equ $00FF95E5
MagicMenuSubmodeSelectedValue_Short equ $FFFF95E5
DecimalDigitScratchBuffer equ $00FF959F
DecimalDigitScratchBuffer_Short equ $FFFF959F
MagicMenuStatusPanelScratchBase equ $00FF959C
MagicMenuStatusPanelScratchBase_Short equ $FFFF959C
MagicMenuCurrentPageState equ $00FF95E6
MagicMenuCurrentPageState_Short equ $FFFF95E6
InventoryMenuCategoryDescriptorBase equ $00FF95E6
InventoryMenuCategoryDescriptorBase_Short equ $FFFF95E6
MagicMenuSpellNameWidth equ $00FF95E8
MagicMenuSpellNameWidth_Short equ $FFFF95E8
MagicMenuStatusValue2 equ $00FF95EE
MagicMenuStatusValue2_Short equ $FFFF95EE
MagicMenuStatusValue3 equ $00FF95F0
MagicMenuStatusValue3_Short equ $FFFF95F0
MagicMenuStatusGaugeAnimationCountdown equ $00FF95F2
MagicMenuStatusGaugeAnimationCountdown_Short equ $FFFF95F2
MagicMenuStatusGaugeWidthSlot0 equ $00FF95F4
MagicMenuStatusGaugeWidthSlot0_Short equ $FFFF95F4
MagicMenuStatusGaugeWidthSlot1 equ $00FF95F6
MagicMenuStatusGaugeWidthSlot1_Short equ $FFFF95F6
InventoryMenuCategoryId    equ $00FF95FA
InventoryMenuCategoryId_Short equ $FFFF95FA
MagicMenuMeterCache equ $00FF95F8
MagicMenuMeterCache_Short equ $FFFF95F8
MagicMenuStatusGaugeBodyTileCount equ $00FF95FC
MagicMenuStatusGaugeBodyTileCount_Short equ $FFFF95FC
MagicMenuStatusGaugeFilledTileCount equ $00FF95FE
MagicMenuStatusGaugeFilledTileCount_Short equ $FFFF95FE
MagicMenuStatusGaugeTailPadTileCount equ $00FF9600
MagicMenuStatusGaugeTailPadTileCount_Short equ $FFFF9600
MagicMenuStatusGaugePackedValue equ $00FF9602
MagicMenuStatusGaugePackedValue_Short equ $FFFF9602
MagicMenuStatusGaugeRemainderValue equ $00FF9604
MagicMenuStatusGaugeRemainderValue_Short equ $FFFF9604
InventoryMenuSelectionIndex equ $00FF9606
InventoryMenuSelectionIndex_Short equ $FFFF9606
InventoryMenuVisibleEntryIds equ $00FF9608
InventoryMenuVisibleEntryIds_Short equ $FFFF9608
InventoryMenuVisibleEntryCount equ $00FF9610
InventoryMenuVisibleEntryCount_Short equ $FFFF9610
InventoryMenuTopVisibleEntryIndex equ $00FF9612
InventoryMenuTopVisibleEntryIndex_Short equ $FFFF9612
InventoryMenuListCursorState equ $00FF9614
InventoryMenuListCursorState_Short equ $FFFF9614
InventoryMenuListCursorCountdown equ $00FF9615
InventoryMenuListCursorCountdown_Short equ $FFFF9615
InventoryMenuAuxCursorTileX equ $00FF9616
InventoryMenuAuxCursorTileX_Short equ $FFFF9616
InventoryMenuAuxCursorTileY equ $00FF9618
InventoryMenuAuxCursorTileY_Short equ $FFFF9618
InventoryMenuAuxCursorState equ $00FF961A
InventoryMenuAuxCursorState_Short equ $FFFF961A
InventoryMenuAuxCursorCountdown equ $00FF961B
InventoryMenuAuxCursorCountdown_Short equ $FFFF961B
InventoryMenuAuxCursorSavedTileX equ $00FF961C
InventoryMenuAuxCursorSavedTileX_Short equ $FFFF961C
InventoryMenuAuxCursorSavedTileY equ $00FF961E
InventoryMenuAuxCursorSavedTileY_Short equ $FFFF961E
InventoryMenuScrollUpIndicatorState equ $00FF9620
InventoryMenuScrollUpIndicatorState_Short equ $FFFF9620
InventoryMenuScrollUpIndicatorCountdown equ $00FF9621
InventoryMenuScrollUpIndicatorCountdown_Short equ $FFFF9621
InventoryMenuScrollDownIndicatorState equ $00FF9622
InventoryMenuScrollDownIndicatorState_Short equ $FFFF9622
InventoryMenuScrollDownIndicatorCountdown equ $00FF9623
InventoryMenuScrollDownIndicatorCountdown_Short equ $FFFF9623
InventoryMenuListCursorTileX equ $00FF9624
InventoryMenuListCursorTileX_Short equ $FFFF9624
InventoryMenuListCursorTileY equ $00FF9625
InventoryMenuListCursorTileY_Short equ $FFFF9625
InventoryMenuListCursorSavedTileX equ $00FF9626
InventoryMenuListCursorSavedTileX_Short equ $FFFF9626
InventoryMenuListCursorSavedTileY equ $00FF9627
InventoryMenuListCursorSavedTileY_Short equ $FFFF9627
SelectedInputRepeatReturnVector equ $00FF9634
SelectedInputRepeatReturnVector_Short equ $FFFF9634
MagicMenuTopRowAssignmentReturnVector equ $00FF963C
MagicMenuTopRowAssignmentReturnVector_Short equ $FFFF963C
MenuTransferReturnVector equ $00FF963C
MenuTransferReturnVector_Short equ $FFFF963C
MenuTextDisplayTimeout equ $00FF965C
MenuTextDisplayTimeout_Short equ $FFFF965C
MagicMenuSubmodeReturnVector equ $00FF9640
MagicMenuSubmodeReturnVector_Short equ $FFFF9640
InventoryMenuBlinkReturnVector equ $00FF9648
InventoryMenuBlinkReturnVector_Short equ $FFFF9648
MagicMenuSubmodeDispatchVector equ $00FF964C
MagicMenuSubmodeDispatchVector_Short equ $FFFF964C
MagicMenuSubmodeApplyReturnVector equ $00FF9654
MagicMenuSubmodeApplyReturnVector_Short equ $FFFF9654
PlayerGoldAmount equ $00FF962C
PlayerGoldAmount_Short equ $FFFF962C
MagicMenuStatusGaugePendingValue equ $00FF9628
MagicMenuStatusGaugePendingValue_Short equ $FFFF9628
TaskScriptAuxFlag        equ $00FF9658
TaskScriptAuxFlag_Short  equ $FFFF9658
MagicMenuSubmodeActionFlag equ $00FFC00C
MagicMenuSubmodeActionFlag_Short equ $FFFFC00C
MagicMenuSpellPageFlag equ $00FF966B
MagicMenuSpellPageFlag_Short equ $FFFF966B
MagicMenuStatusGaugeSourcePointer equ $00FF9EEE
MagicMenuStatusGaugeSourcePointer_Short equ $FFFF9EEE
MagicMenuStatusLayoutFlags equ $00FF9EF1
MagicMenuStatusLayoutFlags_Short equ $FFFF9EF1
MagicMenuStatusLayoutConfigLong0 equ $00FF9EFA
MagicMenuStatusLayoutConfigLong0_Short equ $FFFF9EFA
MagicMenuStatusLayoutConfigWord1 equ $00FF9EF2
MagicMenuStatusLayoutConfigWord1_Short equ $FFFF9EF2
MagicMenuStatusLayoutConfigWord2 equ $00FF9EF4
MagicMenuStatusLayoutConfigWord2_Short equ $FFFF9EF4
MagicMenuStatusLayoutConfigLong3 equ $00FF9EF6
MagicMenuStatusLayoutConfigLong3_Short equ $FFFF9EF6
PlayerLevel equ $00FF9F00
PlayerLevel_Short equ $FFFF9F00
MagicMenuStatusValue0 equ $00FF9F10
MagicMenuStatusValue0_Short equ $FFFF9F10
MagicMenuStatusValue1 equ $00FF9F11
MagicMenuStatusValue1_Short equ $FFFF9F11
TaskScriptProgressBuffer equ $00FF1400
AsyncTaskReadyByte       equ $00FFA3A4
AsyncTaskReadyByte_Short equ $FFFFA3A4
TaskScriptAuxScratchBuffer equ $00FF9996
TaskScriptAuxScratchBuffer_Short equ $FFFF9996

; `0x95DC-0x964C` now looks like a combined inventory/equipment plus magic-menu work area.
; Best fit from the in-ROM strings and control flow around `0x007924-0x00882A`:
; `0x95DC/0x95DD` cache two one-byte magic/status-art selectors mirrored from `0x9F10/0x9F11`,
; while `0x95E0/0x95E4` are now best-fit as a magic-submode modal flag plus saved
; selection index inside the now source-authored upstream loop at `0x00799E-0x007A43`.
; `0x95E5` carries the currently chosen submode value that the same modal-open path writes
; back into per-entry state before it refreshes slot 0/1 status graphics. The next
; source-authored helper block at `0x007CA4-0x007D98` also suggests `0x95E6` is not just a
; generic descriptor pointer: the same word behaves like a page/state selector whose value
; `0x0005` chooses the raw six-spell page, while other values route through the paired
; status-value words at `0x95EE` / `0x95F0` plus a shared `+$08` bias before top-row
; assignments are cleared.
; `0x95B7` / `0x95C8` are now also reused as per-spell empty/filled tile counts while the
; `0x007BB2-0x007CA3` spell-grid refresh draws the six localized spell rows and their paired
; bar strips. `0x959C-0x95A1` now also looks like a small scratch panel/state tuple used by the newly
; source-authored `0x007B22-0x007BA9` status refresh path: `0x959C` feeds the level-style
; two-digit draw, while the later byte at `0x95A2` becomes the slot-2 selector copied into
; `0x95EE`. `0x95D1` now also looks like a layout/config record index consumed by `0x0086BC`; when
; `0x966B` is clear it selects one of seven 6-byte records, and when that page flag is set
; the same value special-cases a smaller two-record table instead.
; The newly source-authored `0x008C34-0x008C7F` tail also snapshots `0x95CE-0x95D0` into
; `0x95D2-0x95D4`, clears the visible-list cursor/scroll/category state, and stores filtered
; copies of the current top-row selector bytes in `0x95E2-0x95E3` whenever `0x9F10/0x9F11`
; still point below the shared `+$08` status-value cutoff.
; `0x95D6` now also looks like the previous category-owned entry id captured before the
; `0x007D9C` visible-list selection flow swaps in a new marked/equipped entry. `0x95DA`
; is a transfer-row scratch byte reused by the adjacent row-upload helpers at
; `0x007E8C-0x007F42`, `0x95DB` is broader than a simple flag and now also acts as an
; arrow-refresh suppression counter during the selected-row blink loop at `0x007E12`, and
; `0x95DE` / `0x95DF` are the matching blink phase countdown/toggle bytes for that same
; effect. `0x95E1` is a scratch byte used by the adjacent status-panel code at `0x00853C` to
; format the likely player level read from `0x9F00`. `0x95E6` is a word-sized base pointer
; consumed by `0x0082F4` when it builds the visible-entry list from category
; availability/equip state bytes at large negative offsets. `0x95E8` holds the measured
; width of the currently selected spell name, `0x95EE` now looks more specifically like a
; lower-row magic/status selector reused by the upstream apply path at `0x007A5A`, `0x95F0`
; is the alternate selector value that the same path swaps in for the second top-row entry,
; and `0x95F8` caches the already-drawn fill amount for the adjacent magic meter.
; `0x963C` now also looks like another saved return vector used by the adjacent top-row
; assignment/clear flow that starts at `0x007E8C`, while `0x9640` / `0x964C` act like scratch
; return/dispatch vectors for the modal submode loop, `0x9648` is the saved return vector
; used by the visible-entry blink loop at `0x007E12`, and `0x9654` is now the matching apply/refresh return vector used by
; `0x007A44-0x007AA8`. `0x95FA` selects headings such as `SELECT`, `WEAPON`, `ARMOR`, `SHIELD`, `BOOTS`,
; `ITEM`, and `MAGIC`; `0x9606-0x9612` track the current list selection and visible
; window; `0x9614-0x9627` drive the blinking list cursor, an auxiliary cursor, and the
; up/down scroll indicators that the selected-input repeat helper updates. The same menu
; cluster also uses `0x966B` as a one-bit page/variant flag that still needs its owner,
; `0x9EF1` bit 4 as a layout-update lock/fallback gate, `0x9EFA/0x9EF2/0x9EF4/0x9EF6` as
; the unpacked destination fields for that 6-byte layout loader, `0x9F10-0x9F11` as
; current top-row status-art selectors, `0x8CDE`, `0x8CE0`, and `0x8CF0` as entry-text width plus two
; tile-row buffers, `0x959F+` as decimal-digit scratch, `0x95DB` as a redraw flag that
; suppresses the post-window arrow refresh, `0x8A77` as a one-byte row id consumed by the
; adjacent text/tile upload helpers around `0x007E8C-0x008000`, and the longword at `0x962C`
; as the likely live gold total.
; Raw ROM work on the still-incbin-backed `0x00882C-0x008C34` continuation keeps the same
; cautious scope. `0x00882C` remaps candidate magic/status ids (`#$28 -> #$0C`, values
; `>= #$2B` minus `#$23`) before clearing matching top-row slots mirrored in `0x9F10/0x9F11`
; and cached in `0x95DC/0x95DD`. `0x00885A` then consumes the pending packed gauge target at
; `0x9628`, selects one of two scale bundles, clamps it against the current packed value at
; `0x9602/0x9604`, and drives the three-row writer at `0x0088D6`. The later `0x008A04`
; continuation still fits best as six-entry spell-bar growth for the localized magic set
; (`FIRE STORM`, `QUAKE`, `THUNDER`, `POWER`, `SHIELD`, `RETURN`) using the inline step table
; `03 03 03 02 02 01`, while `0x008AA2` builds an eight-byte gauge tile-id buffer and
; `0x008BB6` synthesizes follow-on layout widths from the local selection scratch. `0x95B2`
; remains the one-byte fill delta produced when a spell bar grows, `0x95CE-0x95D0` is a
; compact three-byte selection buffer mirrored into `0x95D2-0x95D4`, and
; `0x95F2/0x95F4/0x95F6/0x95FC/0x95FE/0x9600/0x9602/0x9604/0x9628` still form a
; rendering-centric status-gauge work area: animation countdown, two slot widths, body/fill/
; pad tile counts, the current packed value, its low-word remainder component, and a pending
; packed target. The exact game-facing stat meaning still needs more evidence, so those names
; stay display-oriented.
