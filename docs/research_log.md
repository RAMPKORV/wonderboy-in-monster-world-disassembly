# Research Log

## 2026-03-19

- Renamed bank `0x080000`'s `0x0A3500-0x0A4C76` table-targeted back-half owner from the old
  address-stamped `src/bank080000_a3500.asm` family to intention-revealing
  `src/bank080000_table_targeted_payload_records.asm` plus four ROM-order child modules
  (`src/bank080000_table_targeted_payload_front.asm`,
  `src/bank080000_table_targeted_payload_mid.asm`,
  `src/bank080000_table_targeted_payload_late.asm`,
  `src/bank080000_table_targeted_payload_late_tail.asm`, and
  `src/bank080000_table_targeted_payload_tail.asm`).
- This is a naming-and-ownership maturity pass rather than new byte recovery, but it removes one
  more mature late-ROM subsystem from raw address-derived filenames. The parent/child names now say
  what the region is actually proven to be: a table-targeted payload family rooted by the
  `0x0A0000-0x0A07C5` offset tree, with ROM-order continuations that stay explicit because their
  compact local-offset/control records still belong to the same back-half owner.

- Renamed the former address-stamped owner `src/bank080000_a10ab.asm` to
  `src/bank080000_ff_terminated_five_byte_tuples.asm` now that the full
  `0x0A10AB-0x0A34FF` span is proven as one FF-terminated five-byte tuple family. The child
  segments stay in ROM order and keep structural names, but the top-level owner and ROM map now
  read by proven format instead of by raw start address.

- Tightened another long still-regular run inside bank `0x080000`'s `0x0A10AB-0x0A34FF`
  FF-terminated five-byte tuple family without forcing subsystem meaning. The former coarse
  run-sized `incbin` owner at `0x0A1411-0x0A1D3E` in `src/bank080000_a1411.asm` now lives as
  explicit `dc.b` tuples.
- The new source keeps the same structural fit but makes this earlier middle window much
  easier to audit. It now shows mirrored `0x18/0x10/0x08/0x00` quadrant variants up front,
  a broad `0xC0`-through-`0xC5` center with repeated paired placements, and later compact
  `0x60/0x68` and `0x40/0x48` pockets immediately before the mixed bridge at `0x0A1D3F`.
- That removes another 215 record-local opaque slices from the same tuple family. The
  remaining uncertainty in this subsection is record meaning and loader ownership, not local
  byte coverage.

- Tightened another long still-regular run inside bank `0x080000`'s `0x0A10AB-0x0A34FF`
  FF-terminated five-byte tuple family without forcing subsystem meaning. The former
  record-local `incbin` bodies at `0x0A1D4F-0x0A23F5` in `src/bank080000_a1d4f.asm` now live
  as explicit `dc.b` records.
- The new source keeps the same structural fit but makes this middle run much easier to audit.
  It now shows the opening singleton `$FF` markers, mirrored `0x42`-page families, a denser
  `0x60/0x61` ladder through the center, compact low-page pockets near `0x0A21B3-0x0A22C9`,
  and the late mixed `0x68/0x60/0x40`-flavored tail immediately before `0x0A2400`.
- That removes another 113 record-local opaque slices from the same tuple family. The remaining
  uncertainty in this subsection is record meaning and loader ownership, not local byte coverage.

- Tightened two more still-regular pockets inside bank `0x080000`'s `0x0A10AB-0x0A34FF`
  FF-terminated five-byte tuple family without forcing subsystem meaning. The former
  record-local `incbin` runs at `0x0A2400-0x0A2585` and `0x0A27CB-0x0A2D85` now live as explicit
  `dc.b` tuples in `src/bank080000_a2400.asm` and `src/bank080000_a27cb.asm`.
- The new source keeps the same structural fit but makes two larger neighborhoods easier to audit.
  `0x0A2400-0x0A2585` now shows repeated paired `0x60/0x68` and `0x40/0x48` variants up front,
  a compact `0x01`-page cluster around `0xE0-0xFE` in the middle, and a late `0x60/0x61` ladder
  before the already split bridge at `0x0A2586`; `0x0A27CB-0x0A2D85` now makes a short `0x61`
  staircase, a compact `0x20/0x00/0x10/0x18` pocket, the larger `0x68/0x69` composite-record
  middle, and the late `0x60/0x61` ladder directly visible in source.
- That removes another 86 tiny opaque slices from the same tuple family. The remaining uncertainty in
  this subsection is record meaning and loader ownership, not local byte coverage.

- Tightened another still-regular pocket inside bank `0x080000`'s `0x0A10AB-0x0A34FF`
  FF-terminated five-byte tuple family without forcing subsystem meaning. The former
  `incbin`-backed runs at `0x0A258B-0x0A2605` and `0x0A2610-0x0A275F` now live as explicit
  `dc.b` tuples in `src/bank080000_a258b.asm` and the front of `src/bank080000_a2610.asm`.
- The new source keeps the same structural fit but makes the local neighborhoods easier to audit.
  `0x0A258B-0x0A25FF` stays inside the recurring `$43`-page pocket that already produced the
  short bridge records at `0x0A2586` and `0x0A2606`, while `0x0A2610-0x0A275F` exposes short
  paired rows, mirrored `0x08`/`0x28` variants, and a late `0x60`/`0x61` page cluster before
  the larger `0x0A2765+` records.
- That removes another 32 tiny record-local `incbin` slices from the same tuple family. The
  remaining uncertainty in this subsection is record meaning and loader ownership, not local
  byte coverage.

- Tightened the still-mixed `0x0A0C83-0x0A10AA` bridge inside bank `0x080000` again without forcing
  subsystem meaning. `src/bank080000_a0c83.asm` now source-authors the former raw pockets at
  `0x0A0D19-0x0A0D3E`, `0x0A0D75-0x0A0E84`, and `0x0A0F2D-0x0A0FA8` instead of leaving them as three
  `incbin` gaps between the already split six-byte record bands.
- The new proof is still structural, but stronger than before. `0x0A0D19-0x0A0D3E` and
  `0x0A0F2D-0x0A0FA8` each resolve into repeated FF-terminated local records plus one short trailing
  non-terminated tail, while `0x0A0D75-0x0A0E84` resolves completely into fourteen short FF-terminated
  records, one longer 76-byte FF-terminated continuation, one 56-byte FF-terminated continuation, and a
  final singleton `$FF` marker.
- That closes the last raw gaps inside the `0x0A0C83-0x0A10AA` lead-in window. The remaining uncertainty in
  this part of the island is loader ownership and field semantics, not hidden bytes between the now-explicit
  fixed-width and mixed FF-terminated families.

- Tightened the last still-incbin-backed regular runs inside bank `0x080000`'s `0x0A10AB-0x0A34FF`
  five-byte tuple family without forcing subsystem meaning.
  `src/bank080000_a2d9b.asm` and `src/bank080000_a304b.asm` now spell the former
  `0x0A2D9B-0x0A303F` and `0x0A304B-0x0A34FF` record runs directly as `dc.b` tuples instead of
  leaving each proven record body behind one sliced `incbin`.
- This does not change the structural interpretation of the family, but it does raise the source to the
  same maturity level as the earlier `0x0A10AB+` runs. Every regular FF-terminated record in the full
  `0x0A10AB-0x0A34FF` span is now byte-visible in source, so the remaining uncertainty is record meaning
  and loader ownership rather than hidden payload bytes.

- Tightened the front of bank `0x080000`'s Z80-program body again without forcing a subsystem name.
  `src/bank080000_mid_z80_program.asm` now source-authors the former `0x09803B-0x098274` main-body
  prelude instead of leaving it behind one `incbin`.
- The newly explicit bytes now read as a startup / sequencing / slot-management bridge. `0x09803B-0x0980E1`
  resets the `0x1B80+`, `0x1C80+`, and `0x1ED1+` work areas, emits fixed setup bursts through the already
  known output helpers, and enters a three-step warmup loop; `0x0980E2-0x09810A` is a short startup-burst
  helper plus an output-selector reset; `0x09810B-0x09815F` is a countdown-driven tick with a small
  wide-record phase initializer and an optional latched-mode mirror; `0x098160-0x09820A` advances and
  consumes an inline control stream that either dispatches raw bytes `$FA..$FF` through the later explicit
  meta-command table or indexes the local pointer table at `0x099B01`; and `0x09820B-0x098274` seeds or
  updates `0x1EC0`-rooted slot descriptors from inline pointer lists and selector bytes.
- That closes the last raw `incbin` inside `0x098000-0x09907A`: the full Z80 front is now source-visible.
  The remaining uncertainty is loader-side ownership and the exact subsystem meaning of the work areas,
  not local byte structure.

- Closed the last raw gaps inside bank `0x080000`'s `0x0A10AB-0x0A34FF` middle family and the tiny
  lead-in tail at `0x0A0C79-0x0A0C82`. `src/bank080000_a10ab.asm` now source-authors the former gap bytes
  at `0x0A136E-0x0A1377`, `0x0A1D3F-0x0A1D4E`, `0x0A23F6-0x0A23FF`, `0x0A2586-0x0A258A`, and
  `0x0A2606-0x0A260F`, while `src/bank080000_a0b26.asm` now makes the old `0x0A0C79-0x0A0C82` tail
  explicit as raw `dc.b` bytes.
- The evidence is still structural rather than loader-driven. Four of those former gaps resolve best as
  short FF-terminated mixed bridge records, while `0x0A1D3F-0x0A1D4E` fits the surrounding five-byte tuple
  family once embedded `$FF` fields are allowed. That removes the last raw `incbin` islands from the
  `0x0A10AB-0x0A34FF` source window without forcing subsystem names.

- Tightened five-byte tuple coverage inside bank `0x080000`'s `0x0A10AB-0x0A34FF` middle family without
  forcing subsystem meaning. The former anomaly pockets at `0x0A1322-0x0A132C`, `0x0A1406-0x0A1410`,
  `0x0A2765-0x0A27CA`, `0x0A2D86-0x0A2D9A`, and `0x0A3040-0x0A304A` now live as explicit `dc.b`
  records in `src/bank080000_a10ab.asm` instead of grouped `incbin`s.
- The new proof is still local byte cadence, but it is stronger than the old anomaly classification.
  Each recovered pocket ends on a real local `$FF` terminator, and the preceding bytes still resolve into
  five-byte tuple payloads even when one tuple embeds `$FF` as a field value. The larger `0x0A2765`
  pocket also resolves cleanly into two neighboring FF-terminated records at `0x0A2765` and `0x0A278E`.
- That leaves only five short mixed gaps in the whole `0x0A10AB-0x0A34FF` family
  (`0x0A136E-0x0A1377`, `0x0A1D3F-0x0A1D4E`, `0x0A23F6-0x0A23FF`, `0x0A2586-0x0A258A`, and
  `0x0A2606-0x0A260F`). The tuple meaning still is not proven, so the labels stay structural.

- Tightened the front mixed lead-in inside bank `0x080000`'s `0x0A0000-0x0A4C76` island without forcing
  subsystem meaning. The former single `incbin` at `0x0A0B26-0x0A0C82` in `src/bank080000_a0000.asm`
  now lives in `src/bank080000_a0b26.asm` as 26 explicit FF-terminated structural records plus one final
  10-byte unresolved tail at `0x0A0C79-0x0A0C82`.
- The new proof is still local byte structure rather than loader evidence, but it is stronger than one
  anonymous mixed patch. The front `0x0A0B26-0x0A0C78` bytes repeatedly end on local `$FF` markers, and
  the record bodies reuse the same short local-offset/control-like chunks around `0x00/0x01/0x04/0x05/0x08/0x09/0x0C/0x11`
  prefixes before the already split fixed-width 6-byte record families begin at `0x0A0C83`.
- Kept the new labels structural. This pass makes the `0x0A07C6+` front payload materially easier to audit
  in source, but it still does not prove whether the lead-in belongs to layout, object, sprite, script, or
  another table-driven tail-bank resource family without the 68k-side selector or decoder.

## 2026-03-16

- Bootstrapped the repository structure around the original `wonderboy.bin` dump.
- Captured a read-only baseline ROM copy in `original/`.
- Split the rebuild into a source-authored `header.asm` plus a raw ROM body blob.
- Standardized the initial `ASM68K` build and verification flow.
- Traced the front of the `0x004B58-0x004CB7` interrupt block and identified a VBlank
  task scheduler with one immediate queue at `0x8048`, one round-robin queue at
  `0x8248`, `0x80`-byte task slots, a callback pointer at slot offset `0x0C`, and
  queue-control bytes around `0x8A48-0x8A5D`.
- Tried to source-author that VBlank/task-dispatch slice, then rolled it back after
  confirming `ASM68K` widened several absolute address encodings and broke the
  bit-perfect rebuild. The semantic findings were kept in docs/worklogs instead.
- Promoted the confirmed VBlank scheduler RAM anchors into `ram_addresses.asm` and
  exported metadata, plus shared slot-layout constants in `game_constants.asm`, so
  future CODE-004 cleanup can reuse stable names before the handler itself is split.
- Probed `ASM68K` operand encoding behavior and confirmed that absolute-short work-RAM
  accesses in the `0xFFFF8000-0xFFFFFFFF` range assemble byte-identically when written
  as signed `.w` operands, while positive `0x00FFxxxx` symbols widen to absolute long;
  also confirmed that `incbin` supports offset/length slicing for partial blob splits.
- Converted `0x004B58-0x004BC1` from raw blob form into source-authored VBlank/dispatch
  code, keeping the tail `0x004BC2-0x004FFF` as a sliced `incbin` so the ROM still
  rebuilds bit-perfectly. The recovered slice now names the interrupt stub, live
  VBlank handler, queue-clear helper, round-robin retirement loop, and the follow-on
  cursor-prime code label at `0x004BBC`.
- Extended that split through `0x004CA7`, replacing the first pass over immediate task
  slots plus the timed/fallback round-robin dispatcher with source-authored code that
  uses `VDP_CONTROL_PORT`, `VDP_HV_COUNTER`, scheduler budget constants, and the same
  signed absolute-short RAM alias recipe.
- Extended the source-authored VBlank block again through `0x004CC3`: helper
  `0x004CA8` is now named `CompleteCurrentTaskSlotWithResult`, confirming that it
  clears the current task slot and latches `d0` into `0x8068`, and the bootstrap stub
  at `0x004CB8` now names the first immediate-task handoff into the still-opaque
  descriptor/callback bytes at `0x004CC4`.
- Extended that recovery through `0x004E63` by decoding the first inline
  descriptor/callback chain at `0x004CC4`: each descriptor's first longword is treated
  as task user data, the code entry starts four bytes later, and the recovered
  callbacks shuttle work between the secondary task-slot bank at `0x80C8`, the
  round-robin queue helpers at `0x50D4/0x50E2`, and a task-script state cluster at
  `0x8A4E-0x8A51`; the callback-list data at `0x004E5C` is now explicit in source.
- Extended the same VBlank/task-dispatch recovery through `0x004FED`, decoding the next
  descriptor/callback chain at `0x004F54-0x004FED`: it drives another secondary list at
  `0x004FC0`, uses helper `0x01AD62` plus the delay word at task-slot offset `0x40`,
  polls readiness bit 4 in `0x8C56`, and finally gates on `0xA3A4` plus progress bit 7
  in `0x8A7C` before patching immediate slot 0's callback pointer at `0x8054` to
  `0x004FA6`. Only the cross-bank tail starting at `0x004FEE` still needs recovery.
- Recovered that cross-bank tail through `0x00507B`: `0x004FEE` now clears the
  `0xFF1400` task-script progress buffer and zeroes progress/state bytes at `0x8A7A`,
  `0x8A7B`, `0x8A7C`, and `0x8A52`, while `0x00501C`, `0x005036`, and `0x00505C` now
  load countdown values, append progress-count pairs, and advance the task-script stream
  via the slot-local pointer at offset `0x44`.
- Extended the source-authored task chain through `0x00516F`: `0x00507C` is now an
  explicit round-robin descriptor/callback pair that clears the `0x9996` scratch block,
  resets task-script mode/aux flags, loads the `0x8EB0` secondary list, and then queues
  either `0x004F54` or `0x004CC4` based on `TaskCompletionResult`. The helper block at
  `0x0050D4-0x00513B` now names the round-robin/immediate queue installers,
  secondary-list loader, scratch clearer, and sound trigger.
- Decoded and source-authored `PollSecondaryTaskStatus` at `0x00513C-0x00516F`: it uses
  `SecondaryTaskStatusSelector` at `0x8A7D` as a latched source id (`0x80` or `0x81`),
  tests bit 7 in `SecondaryTaskReadySlot0` (`0x8A81`) or `SecondaryTaskReadySlot1`
  (`0x8A84`), and either returns the current ready-bit result or latches the first ready
  source before returning to the scheduler callbacks.
- Refreshed the exported metadata after that recovery so the `0x00507C-0x00516F` helper
  labels and the scheduler/task-script RAM anchors at `0x8A7C`, `0x8C56`, and `0xA3A4`
  are now visible in `tools/index/function_index.json`, `tools/index/symbol_map.json`,
  and the memory-map notes.
- Recovered `0x0051C6-0x005260` as source-authored controller helpers while leaving the
  unresolved bootstrap/data block at `0x005170-0x0051C5` opaque. That work confirms that
  `0x8A7F-0x8A81` and `0x8A82-0x8A84` are player 1/2 current-previous-pressed input
  triplets, that `0x8A7D` selects which pad is mirrored into `0x8A7A-0x8A7C`, and that
  the earlier `0x00501C-0x00505C` helpers are likely part of a broader input
  capture/playback path rather than a generic task-progress buffer.
- Recovered the previously opaque `0x005170-0x0051C5` block as two bootstrap stubs plus an
  inline patch stream: `0x005170` clears display/work buffers before tail-branching to the
  `0x559E` buffer-prime helper, `0x005188` resets VDP state, seeds four bootstrap patch
  words at `0x8B34-0x8B3A`, retires queued descriptors rooted at `0x006EA8` and
  `0x005608`, and then feeds the six-byte stream at `0x0051C0` into the decoder at
  `0x00234C`.
- Tightened the current interpretation of the `0x005016-0x00505C` helper group: instead of
  a generic progress tracker, it now looks like a tiny input-playback encoder/decoder that
  stores repeated `(duration,value)` records in `0xFF1400` and reuses `0x8A7A-0x8A7D` as
  selected-input playback state alongside the live controller mirror.
- Split and source-authored another proven downstream consumer at `0x00805A-0x0080A7`:
  it pops its return address into `0x9634`, runs the shared helper at `0x0400`, converts
  `0x8A7A/0x8A7C` into an auto-repeat-filtered UI byte at `0x95D9`, and uses `0x95D7`
  plus `0x95D8` as the held-input latch and repeat countdown. That narrows the earlier
  open question: the `0x005016-0x00505C` playback path definitely feeds at least one UI /
  menu-style consumer, even though the higher-level owners around `0x007924`, `0x007938`,
  and `0x008212` still need names.
- Cross-checked the current repo for a text-dump artifact to tie those UI consumers to
  known Wonder Boy places, shops, or dialogue sequences, but there is no repo-local dump
  to correlate yet. Until one lands, keep the `0x007924` / `0x007938` / `0x0080A8+` /
  `0x008212` owners described by behavior rather than forcing names like Purapril,
  Childam, or specific shop/menu screens.
- Disassembled the adjacent opaque block through `0x0083CF` and cross-checked its inline
  data against ROM text. That tightens the downstream fit substantially: `0x008272`
  selects heading strings `SELECT`, `WEAPON`, `ARMOR`, `SHIELD`, `BOOTS`, `ITEM`, and
  `MAGIC`; `0x008212` updates a four-row visible selection window; `0x0080A8`, `0x0080FA`,
  `0x008148`, and `0x0081A8` blink scroll indicators/cursors; and `0x0082F8` appears to
  build the visible-entry list from a category-specific availability bitmask. That is
  strong enough to rename the `0x95FA-0x9627` RAM work area as inventory/equipment menu
  state, but not yet strong enough to force specific in-game item names or shop owners.
- Source-authored that same inventory/equipment menu slice through `0x0083CF` while
  preserving the rebuild: `0x0080A8` / `0x0080FA` are now explicit scroll-indicator blink
  helpers, `0x008148` / `0x0081A8` are auxiliary/main cursor blink helpers,
  `0x008212` updates the visible selection window from repeat-gated selected input,
  `0x008272` draws the heading text, `0x0082F4` builds the visible entry-id list, and
  `0x0083B0` converts packed tile coordinates into a VDP control command. The newly named
  `0x95E6` word looks like a category-descriptor base pointer consumed by `0x0082F4`, but
  the actual descriptor owner and the row renderer at `0x0083D0` are still open.
- Extended the same source-authored status-panel recovery through `0x00861F` without
  breaking the rebuild. The new block at `0x00853C` draws a likely level badge/value,
  `0x008596` formats the live gold total next to the inline `GOLD` text, and the shared
  helpers at `0x0085CC-0x00861E` write a small literal tile graphic set plus reusable
  2x2 tile quads. That gives strong new best-fit RAM names for `0x95E1` as level-display
  scratch, `0x962C` as the live gold total, and `0x9F00` as a likely player level byte,
  while the next opaque frontier now starts at `0x008620`.
- Pushed the source-authored menu recovery through `0x00882A` and tightened the best-fit
  interpretation from a generic status tail into adjacent magic/status-panel logic.
  `0x008620` compares selector bytes at `0x9F10/0x9F11` against caches at `0x95DC/0x95DD`,
  maps them through small pattern-id tables, optionally uploads a 0x20-word strip via the
  VRAM helper at `0x22A8`, and then reuses the tile-quad drawer from `0x0085F0`. The next
  block at `0x008778` follows the offset table at `0x007BFE`, which decodes cleanly to the
  localized magic list `FIRE STORM`, `QUAKE`, `THUNDER`, `POWER`, `SHIELD`, and `RETURN`;
  it measures and centers the currently selected spell name using width scratch at
  `0x95E8`, then clears the second row beneath it. `0x0087CE` draws a cached eight-step
  meter at tile coords `0x1602`, using `0x95F8` as the previous fill amount so redundant
  redraws are skipped. Several nearby owners are still opaque, especially the producers of
  `0x95EE`, `0x966B`, and the `0x9F10-0x9F11` selector bytes, so the new names stay scoped
  to menu/status behavior rather than forcing a specific in-game screen.
- Disassembled the still-incbin-backed upstream control slice at `0x007924-0x007A42` from
  raw ROM bytes to tighten the next CODE-004 frontier without forcing a risky split yet.
  `0x007924` and `0x007938` now look like paired left/right handlers for a two-choice
  magic/status submode: they mask horizontal bits out of repeat-gated input `0x95D9`, xor
  bit 0 of `0x9606`, select one of two top-row tile ids from the word table at `0x00799A`,
  and queue the adjacent tile update plus meter refresh before returning. The continuation
  at `0x00799E-0x007A42` uses `0x95E0` as a modal flag and `0x95E4` as a saved selection
  backup while it routes through `0x00805A`, `0x008620`, and `0x00863C`; that makes
  `0x95EE` look more like a lower-row magic/status selector than generic scratch. This
  still does not expose the writer for `0x966B`, so keep the higher-level state names
  conservative.
- Cross-checked the current menu/status findings against `_0blivion_`'s external English
  text dump on GameFAQs. That dump cleanly confirms the localized spell list as `FIRE
  STORM`, `QUAKE`, `THUNDER`, `POWER`, `SHIELD`, and `RETURN`, and it also matches the
  broader Wonder Boy vocabulary we should prefer when later labels warrant it: `Oasis
  Boots`, `Fire-Urn`, `Purapril`, `Childam`, `Shiela Purapril`, `Prince of the Devil
  World`, and `Bio-Mecha`. It also shows why the ROM bytes still have to win over flattened
  dump formatting: the dump merges nearby UI text into lines like `SELECT PAUSE ARMOR...`,
  while the inline heading table already recovered at `0x0082B6-0x0082EC` proves the actual
  visible menu headings remain `SELECT`, `WEAPON`, `ARMOR`, `SHIELD`, `BOOTS`, `ITEM`, and
  `MAGIC`.
- Applied that evidence conservatively by renaming the `0x008620` renderer and its caches /
  pattern tables from generic inventory-status wording to `MagicMenu*` names, keeping the
  rest of the still-opaque upstream owner flow unchanged until the `0x007924-0x007A42`
  control block and the `0x966B` writer are source-authored or otherwise proven.
- Recovered and source-authored the next adjacent slice at `0x0086BC-0x008777`. The new
  loader at `0x0086BC` picks one of several 6-byte layout/config records, using
  `0x95D1` as an index into a seven-record table at `0x008720` when `0x966B` is clear,
  a two-record override table at `0x008750` when that page flag is set, and a fixed
  fallback record at `0x00874A` when bit 4 of `0x9EF1` is set. It then unpacks those six
  bytes into the destination fields at `0x9EFA/0x9EF2/0x9EF4/0x9EF6`. The exact consumer of
  that destination cluster is still unknown, but the seven-record table size is now another
  clue that this adjacent status-panel flow tracks the same `SELECT` / `WEAPON` / `ARMOR` /
  `SHIELD` / `BOOTS` / `ITEM` / `MAGIC` category family already proven nearby.
- Source-authored the next upstream control slice at `0x007924-0x007A43` while preserving a
  bit-perfect rebuild. `0x007924` / `0x007938` are now explicit left/right handlers that
  watch the horizontal bits in repeat-gated input `0x95D9`, flip bit 0 of `0x9606`, play
  the familiar move sound at `0x008BB0`, and refresh one of two top-row tile ids from the
  tiny table at `0x00799A`. The new loop entry at `0x00799E` pops a dispatch vector into
  `0x964C`, uses `0x95E0` / `0x95E4` as modal flag plus saved selection backup, clears
  `0xC00C` on both exit paths, and routes through `0x007D7E` / `0x007D8A` around the shared
  repeat helper at `0x00805A`. The adjacent open path at `0x0079EE` also makes `0x9640`
  look like a modal return-vector scratch and `0x95E5` look like the selected submode value
  written back into the per-entry selector bytes before slot 0/1 status graphics are
  refreshed through `0x008620` / `0x00863C`. The exact game-facing meaning of that two-way
  submode still needs more evidence, so the new names stay system-level rather than forcing
  a spell page, shop, or location-specific label.
- Extended that source-authored front farther through `0x007BA9` while keeping the rebuild
  bit-perfect. `0x007A44` now looks like the apply/refresh half of the same modal flow: it
  stores a return vector in `0x9654`, reruns the submode loop, commits either `0x95EE` or
  `0x95F0` plus `0x08` back into the active entry's selector byte, redraws slot 0/1 status
  graphics, clears the highlighted indicator tile at one of two coords from `0x007ABC`, and
  then returns through the saved vector. The next block at `0x007AC0` walks a 12-entry grid,
  reuses `0x001E6A` plus the tile-row buffers at `0x8CE0/0x8CF0`, and writes those rows to
  a 3x4 tile grid using coords from `0x007B0A`. The status refresh at `0x007B22` also now
  gives firmer RAM anchors: `0x959C` is a compact panel scratch base whose leading byte feeds
  the adjacent two-digit level-style draw, `0x95F0` is an alternate status selector that only
  appears when the second icon byte is present, `0x95EE` stays the lower-row selector copied
  from the same scratch tuple, and `0x9654` is the apply-path return vector. These names stay
  behavior-level because the owning game concept still is not proven from ROM text alone.
- Source-authored the next adjacent slice at `0x007BAA-0x007CA3` while preserving a
  bit-perfect rebuild. The four words at `0x007BAA` are now explicit as the return-icon tile
  quad used by the status-graphic renderer at `0x008620`, and `0x007BB2` now clearly redraws
  a six-row magic grid driven by inline localized spell records for `FIRE STORM`, `QUAKE`,
  `THUNDER`, `POWER`, `SHIELD`, and `RETURN`. Each record begins with packed tile coords that
  line up with two visible columns across three rows; the code highlights the two active spell
  ids mirrored in `0x9F10/0x9F11` by switching between the normal and highlighted tile-string
  writers at `0x007870` / `0x00786A`, then derives filled/empty bar lengths from per-spell
  bytes at `-$6A48(a0)` / `-$6A42(a0)` into new scratch names at `0x95C8` / `0x95B7`. The
  helper at `0x007C68` then renders a two-row bar strip using tile pairs `$99/$98` for filled
  cells and `$BF/$BE` for empty cells before control continues into the still-opaque `0x007CA4+`
  owner logic.
- Pushed the same frontier farther by source-authoring `0x007CA4-0x007D98` without changing
  bytes. `0x007CA4` now looks like a top-row assignment clearer that checks both top-row
  selector slots at `0x9F10/0x9F11`, mirrors the cleared value into the existing caches at
  `0x95DC/0x95DD`, writes `#$FF` back into the live selector plus the paired per-entry graphic
  byte at `-$6A1E(a0)`, and redraws either slot 0 or slot 1 status graphics through
  `0x008620` / `0x00863C`. When `0x95E6` is not `#$0005`, the compared value is loaded from the
  paired status words at `0x95EE` / `0x95F0` plus `+$08`, which is a better fit for `0x95E6`
  as a current magic-menu page/state selector that also doubles as the category-descriptor base
  used later by `0x0082F4`, rather than a pure pointer.
- The next helper at `0x007D00` now reads as six-choice directional navigation for the same
  adjacent magic/status grid. It scans the repeat-gated selected-input bits in `0x95D9`, uses a
  6x4 transition table at `0x007D4A`, updates `0x9606`, and then chooses one of two cursor
  coordinate tables depending on whether `0x95FA` is zero before tail-calling the already named
  cursor-show helper at `0x0081D6`. The coordinate layout matches the visible two-column,
  three-row spell arrangement already proven by the `FIRE STORM` / `QUAKE` / `THUNDER` /
  `POWER` / `SHIELD` / `RETURN` records.
- Kept the `0x00882C+` frontier incbin-backed, but tightened its behavior enough to guide the
  next split safely. `0x00882C` is no longer best-fit as a generic display normalizer: it
  remaps candidate selector ids (`#$28 -> #$0C`, values `>= #$2B` minus `#$23`), compares the
  result against the live top-row magic/status slots at `0x9F10/0x9F11`, and clears whichever
  slot matches back to `#$FF` while mirroring the cleared id into `0x95DC/0x95DD`. The next
  helper at `0x00885A` consumes the pending packed gauge value in `0x9628`, chooses one of two
  gauge scales using the high-word thresholds `#$0200` / `#$0400`, seeds animation countdown
  `0x95F2`, and dispatches through `0x00893C` or `0x008950` into the three-row writer at
  `0x0088D6`. That writer uses tile-id scratch at `0x95AA`, body/fill/pad counts at
  `0x95FC/0x95FE/0x9600`, and inline tile tables at `0x00898E-0x0089B1`. The adjacent helper at
  `0x008A04` also now looks like a six-entry fill/capacity updater for the same localized spell
  set, growing `0x95B8-0x95BD` / `0x95BE-0x95C3` with the inline step table `03 03 03 02 02 01`
  while `0x008A3A+` appears to scan selected or eligible entries for a follow-up refill path.
  The exact game-facing stat is still not proven, so the names stay rendering-oriented rather
  than forcing AP/MP or a specific spell-school interpretation.
- Promoted a few of those still-incbin-backed frontier findings into the shared docs/indexes
  without forcing a code split: `0x95CE-0x95D0` / `0x95D2-0x95D4` now have conservative
  selection-buffer and snapshot aliases, and `0x95F4` / `0x95F6` are now called out as paired
  gauge-width accumulators alongside the already-tracked pending value at `0x9628`. This keeps
  the RAM map aligned with the current raw-ROM understanding while the byte-exact source recipe
  for `0x00882C-0x008A03` remains unresolved.
- Tightened the late `0x09E028-0x09F776` tail-bank command window again without forcing a loader
  guess. The records at `0x09F597-0x09F5F7` and `0x09F5F8-0x09F669` are now explicit `dc.b`
  families built around the same compact `F4 00 C2` header, repeated literal `0x0F` bursts, and
  recurring `0x60/0x6C/0x6D/0x65` control pocket; the neighboring `0x09F66A-0x09F6AD` record is
  also source-authored now as an alternating local-control rhythm that repeats `D2/D6 61`
  against `D0 7C` before a short tail. That leaves fewer anonymous incbins in the late command
  body and gives the remaining tail records a clearer structural neighborhood for the next pass.
- The small mask helpers at `0x007D7A`, `0x007D7E`, and `0x007D8A` are now straightforward
  pressed-button tests over the selected-input pressed byte at `0x8A7C`: `0x007D7A` checks the
  primary-action mask `$80`, `0x007D7E` checks the broader submode-action mask `$90`, and
  `0x007D8A` checks the exit/cancel mask `$60`, each returning success through `d6 = -1`.
- Added provisional RAM aliases from that new slice: `0x95E6` now also has the scoped alias
  `MagicMenuCurrentPageState`, `0x963C` now looks like a saved return vector for the nearby
  top-row assignment flow, and `0x8A77` now has a behavior-level alias `MenuTextTransferRowId`
  because the following `0x007E8C-0x008000` path repeatedly seeds it before forcing a menu-text
  upload interrupt.
- Source-authored the next bridge block at `0x007D9C-0x008059` while keeping the rebuild
  bit-perfect. The front routine now reads as visible-list confirmation for the same
  inventory/equipment UI: it reuses `0x008212` to move the cursor, treats bit-7-marked
  entries in the visible list as already selected, writes the new per-category entry id back
  through the descriptor family behind `0x95FA`, and refreshes the visible window before
  clearing both scroll indicators and playing the confirm sound. The special visible-entry id
  `7` still only has conservative handling as a sentinel because the ROM evidence proves the
  branch and sound effect but not yet the exact in-game meaning.
- The continuation at `0x007E12` now looks like a selected-row blink loop rather than generic
  delay code: it stores a return vector at `0x9648`, uses `0x95DB` as an arrow-refresh
  suppression counter, toggles `0x95DE/0x95DF` as blink phase countdown/state, alternates
  between clearing the active two-row visible entry and redrawing the full four-row window,
  and exits early on any face-button press from `0x8A7C`.
- The row-transfer helpers at `0x007E8C-0x008059` now resolve into a small menu-text upload
  family. They repeatedly seed `0x8A77`, set bit 2 in `0x8006`, and feed packed 32-tile row
  templates rooted at `0x008C82-0x008E02`; that is strong enough to rename the code around
  visible row transfers, an inline `PAUSE` prompt at `0x007F4E`, and the low-level literal /
  packed tile-row upload helpers at `0x008010` / `0x008024` without overcommitting to a
  specific town, shop, or story screen such as Purapril or Childam.
- Probed the next opaque continuation at `0x00882C-0x008A03` from raw ROM bytes without
  source-authoring it yet. The front helper still looks like selector normalization / top-row
  clearing for the adjacent magic/status view, but the stronger new win is the downstream gauge
  work area: `0x9628` behaves like a pending packed target, `0x95F2` as an animation countdown,
  `0x95F4/0x95F6` as paired width accumulators, `0x95FC/0x95FE/0x9600/0x9602/0x9604` as a small
  packed gauge-render scratch, `0x95AA` as an eight-byte tile-id buffer, and `0x95B8-0x95C3` as
  six-entry spell-bar fill/capacity arrays that still line up best with the same localized magic
  set `FIRE STORM`, `QUAKE`, `THUNDER`, `POWER`, `SHIELD`, and `RETURN` already proven nearby.
  The exact game-facing stat meaning is still unresolved, so the new names stay rendering-level
  instead of forcing AP/DP/SP or a town/shop-specific interpretation.
- Tried to source-author the wider `0x00882C-0x008C4F` continuation next, but reverted the body
  after `verify.bat` exposed several byte-identity traps. The main pitfalls were: short-branch
  sizing shifts around the tight gauge loops, absolute-long versus PC-relative table loads around
  `0x0089B6`, and nearby helper/tail data beginning earlier than the first raw disassembly pass
  suggested. The productive result is narrower: keep this region `incbin`-backed for now, treat
  `0x00882C-0x008C33` as the real first target window, and preserve the already-strong behavioral
  fit (pending gauge target at `0x9628`, three-row strip writer at `0x008B2E`, width synthesis at
  `0x008BB6`, and the compact selection snapshot immediately after the width table) until a
  byte-for-byte source recipe is proven.
- Tightened the same incbin-backed frontier without forcing a split. The conservative labels now
  better match the raw ROM behavior: `0x00882C` is tracked as
  `NormalizeAndClearMagicMenuTopRowSelection_00882C`, `0x00885A` as
  `ProcessPendingMagicMenuStatusGauge_00885A`, `0x0088B4` as
  `ClampMagicMenuStatusGaugeValue_0088B4`, and `0x008A04` as
  `UpdateMagicMenuSpellBarFillAndCapacity_008A04`. The surrounding RAM names also moved from the
  older layout-centric wording to `MagicMenuStatusSelectionScratchBuffer` /
  `MagicMenuStatusSelectionScratchSnapshot`, which is a better fit for the still-provisional
  three-byte local selector state at `0x95CE-0x95D4`.
- Extended that same raw-ROM pass farther through `0x008C34` without source-authoring it yet.
  The next continuation now fits more tightly: `0x00885A` clears the pending target at `0x9628`,
  chooses one of two scale bundles, clamps against the current packed value at `0x9602/0x9604`,
  and jumps through `0x00893C` / `0x008950` into the three-row strip writer at `0x0088D6`.
  `0x008A04` still grows the six localized spell bars (`FIRE STORM`, `QUAKE`, `THUNDER`,
  `POWER`, `SHIELD`, `RETURN`) with the inline step table `03 03 03 02 02 01`, while the new
  continuation at `0x008A3A-0x008A9A` tries to advance selected or fallback spell fill, `0x008AA2`
  builds an eight-byte gauge tile-id buffer at `0x95AA`, `0x008B2E` uploads two gauge rows from
  inline tile tables, `0x008BB6` synthesizes layout widths into `0x95F4/0x95F6`, and `0x008C34`
  mirrors the three-byte local selection scratch from `0x95CE` into `0x95D2`. The exact
  game-facing stat is still unresolved, so the names remain rendering-level rather than forcing
  AP/DP/SP or another menu-specific interpretation.
- Promoted that `0x00882C-0x008C34` frontier into the machine-readable indexes without forcing a
  risky source split. `function_index.json` now carries the conservative labels through
  `TryAdvanceMagicMenuSpellBarFill_008A3A`, `TryIncreaseMagicMenuSpellBarFill_008A88`,
  `BuildMagicMenuStatusGaugeTileIdBuffer_008AA2`, `UploadMagicMenuStatusGaugeTileRows_008B2E`,
  `UpdateMagicMenuStatusLayoutWidths_008BB6`, `MagicMenuStatusWidthLookupTable_008C1E`, and
  `MirrorMagicMenuStatusSelectionScratch_008C34`; `symbol_map.json` now also exposes the same
  code/data range plus the already-proven RAM anchors `MagicMenuStatusValue3` at `0x95F0` and
  `MagicMenuSubmodeApplyReturnVector` at `0x9654`, and the Ghidra source-sync bundle was refreshed
  so external analysis can pick up the tighter magic-menu gauge vocabulary immediately.

- Source-authored the first safe slice of that gauge frontier at `0x00882C-0x0088C1` while keeping
  the rebuild bit-perfect. `0x00882C` is now explicit as candidate-id normalization plus
  matching top-row clearing for the adjacent magic/status slots, `0x00885A` now owns pending
  packed-target consumption from `0x9628`, the two scale-bundle selection, redraw-countdown
  refresh at `0x95F2`, and the jump into the still-incbin-backed writer at `0x0088D6`, and
  `0x0088B4` is now a tiny clamp helper that caps the packed gauge value against its high-word
  component before it is mirrored into `0x9602/0x9604`. This keeps the downstream scale bundles
  and render/upload path at `0x0088C2-0x008C34` opaque for now, but the immediate bridge no longer
  depends on blind metadata-only labels.
- Resumed that same frontier at the next safe tail and source-authored `0x008C34-0x008C7F`
  without changing bytes. The new `InitializeMagicMenuSelectionState_008C34` copies the local
  three-byte selection scratch at `0x95CE-0x95D0` into its snapshot at `0x95D2-0x95D4`, clears the
  visible-list cursor/scroll/category state used by the adjacent inventory/magic UI, and filters
  the current top-row selector bytes from `0x9F10/0x9F11` into new RAM aliases at `0x95E2/0x95E3`
  only when they remain below the shared `#$08` status-value cutoff. That proves the post-gauge
  continuation is state-init glue rather than part of the still byte-sensitive gauge renderer, so
  the remaining opaque core is now more tightly bounded to `0x0088C2-0x008C33`.
- Tightened the front command window in bank `0x080000` again without forcing a subsystem guess.
  `src/bank080000_mid_command_tail_front.asm` now source-authors the former raw
  `0x09A6D7-0x09AA5B` run as fourteen explicit FF-terminated records instead of fourteen `incbin`
  slices.
- The new `0x09A6D7-0x09A7FC` pocket is now explicit as one local-control-plus-literal-control
  burst family dominated by `0x60/0x61/0x00/0x05/0x0F/0x01`, followed by a compact local-target
  sweep that hands off to a short `F4 F8` literal-pair family around `0x29/0x28/0x35/0x2F/0x36`.
- The neighboring `0x09A875-0x09A9CB` continuation now stands explicitly as a longer
  local-control-to-literal/high-byte ladder around `0x43/0x41/0x40/0x3C/0x39/0x45/0x48/0x4A/0x4C`,
  then a shorter `0x4C/0x4D/0x4F/0x51` ladder with small `E2`/`E3` local-offset hops, and one compact
  `0x39/0x35/0x40/0x3C/.../0x2F` descent at `0x09A991`.
- The tail at `0x09A9CD-0x09AA5B` is also clearer now: two tiny `F4 05` literal rows remain explicit,
  and `0x09A9ED` resolves into a compact local-control bridge that finishes as an eight-step
  `E4`-tagged local-offset ladder carrying short 4-byte literal rows. The wider loader path into the
  `0x099B00-0x09F776` command region is still unproven, so the new names stay structural.
- Tightened another middle-window pocket in bank `0x080000`'s `0x09C008-0x09E027` command body without forcing
  subsystem meaning. `src/bank080000_mid_command_tail_mid.asm` now source-authors the former raw
  `0x09C0D7-0x09C252` run as nine explicit FF-terminated records instead of nine `incbin` slices.
- That new source pass exposes two neighboring structural families: `0x09C0D7` now reads as one compact
  local-control sweep that falls into a dense `0x4F/0x4E/0x4D/0x4C/0x4B/0x48` literal/high-byte pocket,
  followed by the tiny tails at `0x09C14D` and `0x09C158`; then `0x09C15B-0x09C252` resolves into a short
  literal-control pocket family built around the same compact `F4 00 C2/C4 F5 12` framing with repeated
  `0x00/0x05/0x0F` rows and one small `0x0D/0x0E/0x11` tail.
- The same pass also makes the later `0x09C62F-0x09C686` bridge explicit as four short `F4 04`
  literal-control records centered on `0x00/0x05/0x0D/0x0E/0x11/0x60/0x65`, with one small `E2 A8`
  local-offset hop in the final record. The wider loader path into the `0x099B00-0x09F776` command region
  is still unproven, so the new names stay structural.
- Tightened the next neighboring middle-window pocket in bank `0x080000` without forcing subsystem ownership.
  `src/bank080000_mid_command_tail_mid.asm` now source-authors the former raw `0x09C253-0x09C5B0` run as
  eighteen explicit FF-terminated records instead of eighteen `incbin` slices.
- That follow-up pass exposes a broader bridge between the earlier `0x09C15B+` literal-control family and the
  later `0x09C62F+` pocket: `0x09C253` is now explicit as an alternating local-control sweep that hands off
  to one short `F4 00` literal-row pocket around `0x30/0x2E/0x2B/0x31/0x34/0x35`, `0x09C2BA-0x09C308` keep
  that same neighborhood as three smaller literal-row continuations, `0x09C320-0x09C49B` widen into compact
  local-target and `F4 10` mixed literal/high-byte rows around `0x37/0x3D/0x48/0x44/0x46`,
  `0x54/0x4F/0x52`, `0x41/0x4D/0x4B/0x4A/0x48`, and the recurring `0x89/0x8B/0x90/0x91` plus
  `0xA0/0xA3/0xA4/0xA6` pair family.
- The same new pass also makes `0x09C4B8-0x09C5B0` explicit as one larger mixed literal/high-byte ladder at
  `0x09C4B8` around `0xA9/0x4C`, `0x9C/0x3D`, `0x99/0x3F`, and the recurring `0x43/0x41/0x40/0x97` pocket,
  followed by a shorter repeated literal ladder plus descending `0x9A/0x99/0x98/...` tail at
  `0x09C564-0x09C582`, and a final compact local-control burst at `0x09C5B0` that repeats the same
  `0x60/0x10/0x05` literal-control row several times before FF. The loader path into the wider
  `0x099B00-0x09F776` command region still is not proven, so the labels stay structural.
- Tightened the next adjacent front-window pocket in bank `0x080000` without forcing subsystem ownership.
  `src/bank080000_mid_command_tail_front.asm` now source-authors the former raw `0x09AA5C-0x09AB29` run as
  four explicit FF-terminated records instead of four `incbin` slices.
- That follow-up pass makes `0x09AA5C-0x09AA98` explicit as a compact local-control sweep into two short
  `F4 08` literal-control rows around `0x00/0x0C/0x05/0x60`, then resolves `0x09AA99-0x09AB29` as the next
  repeated high-byte pair pocket: one local-control prelude feeds a short `0x8D/0x39`, `0x8C/0x38`,
  `0x88/0x34` ladder and a denser follow-on record grows into repeated `0x93/0x3F` and `0x94/0x40` rows
  immediately before the already explicit `0x09AB2A-0x09AB71` triplet family. The loader path into the wider
  `0x099B00-0x09F776` command region still is not proven, so the labels stay structural.
- Tightened the next front-window bridge in bank `0x080000` without forcing subsystem ownership.
  `src/bank080000_mid_command_tail_front.asm` now source-authors the former raw `0x09B091-0x09B289` run as
  eleven explicit FF-terminated records instead of eleven `incbin` slices.
- That pass resolves `0x09B091-0x09B113` into one compact local-control-to-literal-row pocket followed by two
  shorter `F4 00` row continuations around `0x30/0x33/0x36/0x3A/0x39/0x37` and the recurring `0x2B` tail.
- The adjacent `0x09B12A-0x09B1AB` continuation now stands explicitly as one local-control bridge into a short
  `F4 18` literal/high-byte row around `0x3C/0x3F/0x42/0x46/0x45/0x43`, followed by two neighboring
  `0x9F/0xA0/0xA1/0xA2` then `0x9F/0x9E/0x9C/0x9A/0x99` high-byte descents.
- The same new pass also makes `0x09B1C9-0x09B24B` explicit as a paired literal-row pocket with a short
  `0x9E/0x9D/0x9A/0x99/0x97/0x92` high-byte tail plus one `0x93/0x95`-rooted bridge, and closes at
  `0x09B24C-0x09B289` with another compact local-control sweep into a repeated `0x48/0x54` literal-row family.
  The wider loader path into the `0x099B00-0x09F776` command region still is not proven, so the labels stay
  structural.
- Tightened the next adjacent front-window pocket in bank `0x080000` without forcing subsystem ownership.
  `src/bank080000_mid_command_tail_front.asm` now source-authors the former raw `0x09B28A-0x09B575` run as
  ten explicit FF-terminated records instead of ten `incbin` slices.
- That follow-up pass makes `0x09B28A` explicit as one compact local-control sweep into repeated
  `0xAB/0xAA/0xA8/0xA6/0xA5/0xAD/0xAE/0xB1/0xB2` high-byte rows around
  `0x4F/0x4E/0x4B/0x4A/0x48/0x51/0x52/0x54/0x56`, followed by a short `F7 08` literal tail.
- The neighboring `0x09B319-0x09B36A` continuation now stands explicitly as one repeated `0xA2/0x43`
  high-byte pocket with timing pivots plus a shorter literal descent rooted on
  `0x46/0x48/0x4F/0x4E/0x4B/0x4A/0x4D`.
- The same pass also makes `0x09B36B-0x09B494` explicit as one compact local-control bridge into a short
  `0x3C/0x43/0x42/0x46` crest plus a four-record `F4 00` literal-control family around
  `0x60/0x0D/0x00/0x0C/0x65/0x05/0x0F/0x6C/0x6D`, then resolves `0x09B495-0x09B575` as one local-control bridge
  into repeated `E2`-tagged `0x3B/0x3C` rows, a short literal continuation, and a denser `E2 04/44/2C` sweep
  around `0x2F/0x30/0x31/0x32/0x34/0x35/0x36/0x37/0x2D/0x2C/0x2B`.
- The wider loader path into the `0x099B00-0x09F776` command region still is not proven, so the labels stay
  structural.

## 2026-03-17

- Replaced the three top-level `0x020000+` whole-bank `incbin` directives in `src/rom_body.asm`
  with bank-specific include owners: `src/bank020000.asm`, `src/bank040000.asm`, and
  `src/bank080000.asm`.
- Kept `0x020000-0x03FFFF` conservative for now as a single bank-local opaque slice, which still
  satisfies the immediate ownership goal without pretending to know unproven code/data boundaries.
- Split `src/bank040000.asm` around the already-documented `0xFF` fill hotspot at
  `0x0409FA-0x040FFF`, so the late-ROM bank is no longer represented as one monolithic whole-bank
  `incbin`.
- Split `src/bank080000.asm` around the largest confirmed tail-bank `0xFF` runs at
  `0x09622B-0x097FFF`, `0x09F777-0x09FFFF`, and `0x0A4C77-0x0BFFFF`, making the heavy-fill tail
  layout explicit in source before deeper code/text/table recovery.
- Updated `docs/rom_layout.md` and `tools/index/rom_map.json` to reflect the new bank-local owners
  and the newly labeled fill regions, keeping the project manifests aligned with source ownership.
- Carved the first real text/name island out of bank `0x020000` at `0x021720-0x021B7F`. That new
  `src/bank020000_names.asm` source module now owns the offset table plus strings for inventory
  equipment, magic, and item names (`Legend Sword`, `Gradius`, `Oasis Boots`, `Fire Storm`,
  `Ocarina`, `Fire-Urn`, `Old Axe`, etc.), followed by a second keyword/name table carrying proven
  world and story terms such as `Shion`, `Alsedo`, `Maugham Desert`, `Lilypad`, `Begonia`,
  `Childam`, `Purapril`, `Eleanora`, `Myconid`, `Priscilla`, `Poseidon`, `Shiela Purapril`,
  `Sphinx`, `Hotta`, `Prince of the Devil World`, `Bio-Mecha`, and `Shabo`.
- Kept two still-undecoded text entries in that bank-local name block as raw byte strings:
  the inventory names at `0x021959` and `0x02199E`, plus the wrapped keyword at `0x021AA4` whose
  surrounding control bytes (`0x01A0` / `0x0180`) are now visible in source but not yet decoded.
- Carved the next adjacent text island out of bank `0x020000` at `0x021B80-0x02245F`. The new
  `src/bank020000_text.asm` module now owns a mixed shop/inn/Ocarina dialogue block plus a large
  null-terminated dialogue dictionary word table. Confirmed text in this slice includes an
  equipment shop buy/decline/not-enough-money flow, inn stay/save prompts, Ocarina practice and
  three-door melody hints, the `Jump from the top of the Pyramid and enter a new world.` hint, and
  a 168-word dictionary that contains both world nouns (`Alsedo`, `Purapril`, `Sphinx`, `Poseidon`,
  `Eleanora`, `Lilypad`) and common sentence glue words (`remember`, `journey`, `question`,
  `storekeeper`, `underwater`). The control bytes around those strings are still only partly
  decoded, so the new source keeps them explicit rather than over-claiming a finalized text codec.
- Carved the adjacent upstream quiz/trivia slice out of bank `0x020000` at `0x021360-0x02171F`.
  The new `src/bank020000_quiz.asm` module now owns the tail of a larger backwards-pointing word-
  offset table, two `YES  NO` prompt strings, a `GOLD` label, still-opaque quiz control/script
  records, and ten null-terminated multiple-choice quiz records. Confirmed question/answer text in
  this slice covers the first acquired magic (`Fire Storm` / `Tornado` / `Quake`), the elf queen
  (`Eleanora`), the first monster battled (`Myconid` / `Mecha-Dragon`), the `Gragg & Glagg`
  reward (`Lamp` / `Amulet` / `Trident`), the Wanderer weapon-shop inventory, the dwarf-village
  name (`Lilian` / `Lilypad` / `Lollipop`), the Pyramid key, Charmstone pricing, the desert-
  traversal boots (`Oasis Boots`), and which store does not sell weapons (`Gooningle` /
  `Bacchus` / `Felissimo`). The leading offsets and the control bytes ahead of the plain question
  strings are still not decoded enough to rename the driver format, so the new source keeps those
  records literal while still splitting the bank into readable ROM-order modules.
- Split the first non-fill island inside bank `0x080000` out of one coarse `incbin` into a new
  ROM-order module at `src/bank080000_mid.asm`. The front `0x098000-0x09991F` slice is now called
  out separately as `Bank080000_Z80LikeCodeBlock_098000` because its bytes are strongly opcode-dense
  and fit Z80 instruction patterns far better than 68k or plain assets, though the exact loader and
  subsystem owner are still unproven.
- Mapped the following tail-bank structure conservatively instead of leaving `0x098000-0x09F776` as
  one anonymous blob: `0x099920-0x09997F` now stands as compact descriptor-header records,
  `0x099980-0x099A84` as a packed layout/coordinate table, `0x099A85-0x099AFF` as explicit zero
  fill, and `0x099B00-0x09F776` as a pointer-and-command region whose opening bytes look like a
  little-endian pointer table into later command-like records.
- Kept all new tail-bank names structural rather than game-facing. The bytes support "opcode-dense
  Z80-like block", "descriptor records", and "pointer/command data" today, but not yet a stronger
  claim like credits script, audio bank, or endgame subsystem without matching 68k-side control flow.
- Tightened that same `0x099B00+` tail-bank split one step further without over-claiming ownership.
  The front `0x099B00-0x099B31` bytes now stand alone as a command lead-in, and the following
  `0x099B32-0x099BAF` words are now explicit in source as a bank-local command offset table because
  nearly every big-endian entry lands back inside the surrounding `0x099B00-0x0A0348` command region.
  One outlier word (`$F7FD`) still falls outside that local range, so the table stays literal and
  structural rather than being forced into stronger script/credits/audio terminology.
- Split the next non-fill tail-bank island at `0x0A0000-0x0A4C76` into its own ROM-order source
  module `src/bank080000_a0000.asm` instead of leaving it as one monolithic `incbin` inside
  `src/bank080000.asm`.
- The front `0x0A0000-0x0A07C5` bytes are now explicit `dc.w` data because they form a clear
  multi-level big-endian offset-table tree: an initial root table at `0x0A0000`, a much larger
  second-stage block at `0x0A01C8`, and a short tail at `0x0A07BC`. Most entries point back into the
  same `0x0A0000-0x0A4C76` island, either to other table nodes or into the still-opaque payload that
  begins at `0x0A07C6`.
- Kept the terminology structural rather than subsystem-specific. The bytes support "multi-level
  offset table" today, but not yet a stronger claim like credits script, map bank, or sound data
  without the 68k-side selector/decoder path that consumes those offsets.
- Split the `0x099BB0-0x09F776` tail-bank command region again using the now-proven local target
  offsets from `0x099B32-0x099BAF`. The source now keeps `0x099BB0-0x099BD2` explicit as a short
  unreferenced prelude, then breaks `0x099BD3-0x09A347` into ROM-order command-record slices at each
  table-targeted start instead of hiding the whole body behind one post-table incbin.
- Kept those new labels structural. The table evidence proves record boundaries and one non-local
  outlier word (`$F7FD`), but it still does not prove whether this region is audio, credits, a data
  interpreter, or another tail-bank subsystem, so the names stay at `CommandRecord_*` level until a
  68k-side loader or decoder path is recovered.
- Split the front of the `0x0A07C6+` payload inside `src/bank080000_a0000.asm` one step further.
  The first `0x120` bytes at `0x0A07C6-0x0A08E5` now stand alone in `src/bank080000_a07c6.asm` as
  twelve repeated `0x18`-byte records instead of one large trailing incbin.
- Those new records are still labeled structurally rather than semantically. The strongest current
  proof is their regular cadence: each entry is four 6-byte tuples, and the early entries share a
  tight repeated prefix before later records diverge. That is enough to justify a ROM-order table/
  record split, but not yet enough to force a subsystem name without the 68k-side consumer.
- Split the first post-dictionary structured island in bank `0x020000` out of the remaining coarse
  `0x022460+` bank slice. The new `src/bank020000_tables.asm` module now owns six same-bank
  reference descriptors at `0x022460-0x0224BF`, a monotone big-endian offset table at
  `0x0224C0-0x0225D7`, and a later repeated `0x10`-byte descriptor band at `0x02292C-0x022AEB`,
  with narrower ROM-order `incbin` slices left in between instead of one monolithic post-text blob.
- Kept those new bank `0x020000` labels structural rather than game-facing. The bytes strongly prove
  local same-bank references, an indexed payload base at `0x0225D8`, and a repeated descriptor cadence,
  but they still do not prove whether the region is map data, object placement, scripts, or another
  data-driven subsystem without the consumer that indexes `0x0224C0` or lands on the later records.
- Split another front-of-bank index island out of bank `0x020000` at `0x0211CA-0x02135F`. The new
  `src/bank020000_offsets.asm` module now owns a four-entry absolute longword pointer list at
  `0x0211CA-0x0211D9` that targets the new local index data itself plus the already split inventory-name
  table (`0x021720`), world-keyword table (`0x021A06`), and Ocarina-adjacent melody data (`0x021FCA`).
- The same new module also source-authors two bank-relative offset tables instead of leaving them inside
  the front opaque bank slice: `0x0211DA-0x021257` is a 52-entry table with 11 zero sentinels whose live
  entries point back into `0x0201D0-0x020539`, while `0x021258-0x02135F` is a monotone 132-word table
  with one leading zero sentinel whose targets land in a later `0x020E4C-0x021195` text/control band.
- Kept those new labels structural. The bytes prove bank-local text-index ownership and cross-links into
  already named modules, but they do not yet prove which menu, script, or dialogue driver walks these
  tables, so the source names stay at pointer-list and offset-table level for now.
- Tightened the current best fit for the unresolved `0x0A08E6+` tail-bank payload without forcing a
  risky split: beyond the already source-authored `0x0A07C6-0x0A08E5` four-tuple band, the downstream
  bytes still parse coherently as a much longer 6-byte tuple stream, with a more homogeneous motif
  around `0x0A0E86`, but no loader-proven internal boundary yet.
- Pushed that `0x0A0000` tail-bank recovery one step farther without over-claiming semantics. The
  back half of the same island is no longer one anonymous `incbin`: `0x0A08E6-0x0A34FF` now stands
  alone as an unresolved payload lead-in, while the later `0x0A3500-0x0A4C76` span is split into
  hundreds of ROM-order record slices in `src/bank080000_a3500.asm` because the front nested offset
  table already proves stable record starts throughout that range.
- Kept the new `0x0A3500+` labels structural rather than subsystem-specific. The offset-table tree
  proves where many records begin and that the later payload is heavily table-targeted, but it still
  does not prove whether these records are maps, credits, sound resources, scripts, or another data-
  driven family until a 68k-side selector or decoder is recovered.
- Split another later bank `0x020000` structured island out of the remaining coarse tail at
  `0x023AB6-0x024537`. The new `src/bank020000_records.asm` module now owns a long run of ROM-order
  big-endian word records separated by repeated `$FFFF` sentinels instead of leaving that whole span
  inside one anonymous post-table `incbin`.
- Kept the new `0x023AB6-0x024537` labels structural. The bytes strongly prove delimiter-based record
  boundaries and a recurring word-oriented layout with stable field counts, but they still do not prove
  whether the owner is a script, object-placement family, map metadata, or another data-driven system
  without the code that walks or dispatches these records.
- Split the middle payload of the bank `0x020000` structured island at `0x022662-0x02292B` out of its
  remaining coarse `incbin`. The `src/bank020000_tables.asm` module now source-authors that span as one
  `0x8A`-byte lead-in record, then a long ROM-order run of mostly 6-byte short records, eight 8-byte
  variants, and a final terminator word, all proven directly by the front offset table at `0x0224C0`.
- Kept those new labels structural rather than pretending the three-word records are already fully
  decoded. The offset-table evidence is now strong enough to justify stable record boundaries and a
  duplicate offset at `$0260`, but not yet enough to name the fields or the higher-level owner without
  the code that indexes `0x0224C0` and consumes the later descriptor bands.
- Extended the next bank `0x080000` front payload split inside `0x0A0000-0x0A4C76`. The new
  `src/bank080000_a08e6.asm` module now owns `0x0A08E6-0x0A0B25` as twenty-four more ROM-order
  `0x18`-byte records instead of leaving the entire `0x0A08E6+` lead-in behind one monolithic
  `incbin`.
- Kept that new tail-bank split structural. The strongest proof is cadence rather than subsystem
  meaning: the new span continues the same four-6-byte-tuple layout already source-authored at
  `0x0A07C6-0x0A08E5`, while the following bytes only become clearly different at the new unresolved
  lead-in start `0x0A0B26`. A later `0xFF`-delimited family around `0x0A0E85` now looks like the next
  conservative split candidate, but it is still left opaque until its local boundary is promoted into
  source.
- Split the first structurally strong post-fill island in bank `0x040000` out of the remaining coarse
  `0x041000-0x07FFFF` owner. The new `src/bank040000_tables.asm` module now owns
  `0x041000-0x041BFF` as a ROM-order flagged ROM-reference table cluster plus two explicit `0xFF`
  fill gaps instead of leaving that whole front late-bank span inside one anonymous `incbin`.
- The front `0x041000-0x0418AB` run is now source-authored as a 683-entry four-byte table whose
  longwords fit a repeated `[tag][24-bit ROM address]` pattern and point only into
  `0x041C00-0x07FF66`. The next `0x0418AC-0x041B3F` run keeps the same shape but points only into
  `0x0801CD-0x093FD0`, showing a clean local-to-cross-bank phase change rather than one undifferentiated
  blob.
- Kept the new bank `0x040000` labels structural rather than calling the bytes a final pointer table.
  The top byte behaves like a tag or record-type field with mostly `$02` plus a smaller number of `$00`,
  `$01`, and `$FF` sentinel entries, so the safest current naming is a flagged ROM-reference table until
  the 68k-side consumer proves whether these are assets, scripts, maps, or another banked resource index.
- Split the short tail at `0x041B80-0x041BBF` as a second 16-entry table of the same shape, now known to
  point only into `0x09414A-0x0961D7`, and made both adjacent `0xFF` runs at `0x041B40-0x041B7F` and
  `0x041BC0-0x041BFF` explicit in source so the late-bank front no longer jumps directly from one fill
  hotspot to one huge opaque remainder.
- Split the front-middle of the still-mixed bank `0x080000` lead-in at `0x0A0B26-0x0A34FF` one step
  further without forcing subsystem meaning. The new `src/bank080000_a0c83.asm` module now owns four
  narrower FF-terminated 6-byte record bands at `0x0A0C83-0x0A0D18`, `0x0A0D3F-0x0A0D74`,
  `0x0A0E85-0x0A0F2C`, and `0x0A0FA9-0x0A10AA`, with the mixed bytes between them kept as explicit
  ROM-order `incbin` gaps rather than one monolithic unresolved lead-in.
- Kept those new bank `0x080000` labels structural. The immediate proof is purely byte-level: each new
  band is a stable run of 6-byte records whose last byte is always `$FF`, and several neighboring
  records reuse the same first-byte/second-byte families (`$0A/$05/$0B/$0E` with `$00/$20/$60/$02`
  selectors) plus signed offset-like tail bytes such as `$F4,$F8,$FC`. That is enough to justify
  source-owned record-band boundaries, but not enough yet to call them sprites, objects, credits, or
  map elements without the 68k-side consumer.
- Split the first front chunk of bank `0x040000`'s local-target payload family out of the remaining
  coarse late-bank owner. The new `src/bank040000_payload_front.asm` module now owns
  `0x041C00-0x043FFF` as twenty-two ROM-order record slices whose starts are proven directly by the
  monotone local target addresses in the flagged reference table at `0x041000-0x0418AB`.
- Kept that new bank `0x040000` split structural rather than subsystem-specific. The current proof is
  only ownership and ordering: the local flagged table points monotonically into `0x041C00-0x07FF66`,
  and the first twenty-two targets fill `0x041C00-0x043FFF` without gaps or overlaps. That is enough
  to justify a source-owned payload window and explicit record starts, but not enough yet to name the
  records as maps, scripts, assets, or another higher-level family without the 68k-side loader.
- Extended that same bank `0x040000` payload window much farther forward without forcing semantics.
  `src/bank040000_payload_front.asm` now carries fifty-nine additional ROM-order slices, so the
  proven local-target run reaches `0x04A70E` instead of stopping at `0x043FFF`.
- The added boundaries are still justified only by the monotone local-reference table at
  `0x041000-0x0418AB`: every new start from `0x0440C7` through `0x04A4B0` is table-targeted, ordered,
  and gap-free up to the next unsplit byte at `0x04A70F`. That is enough evidence for a clean mature
  source split even though the higher-level record family is still unresolved.
- Extended that same bank `0x040000` local-target payload split one chunk farther forward. The new
  `src/bank040000_payload_mid.asm` module now owns `0x04A70F-0x04E5A9` as twenty-three more ROM-order
  payload slices instead of dropping straight back to a monolithic bank remainder at `0x04A70F`.
- The strongest new pattern in that added span is structural, not semantic: after fifteen irregular
  table-targeted records from `0x04A70F` through `0x04BEA1`, the next eight starts at `0x04BFAA`,
  `0x04C46A`, `0x04C92A`, `0x04CDEA`, `0x04D2AA`, `0x04D76A`, `0x04DC2A`, and `0x04E0EA` form a clean
  fixed-stride run of `0x4C0`-byte records. That makes the local table's ownership of this region even
  more explicit, while the loader and resource meaning still remain open.
- Extended that same bank `0x040000` local-target payload split again into a new ROM-order module
  `src/bank040000_payload_late.asm`, so the explicit same-bank payload window now reaches
  `0x05FC2F` instead of stopping at `0x04E5A9`.
- This new pass promoted 160 more monotone same-bank starts from the flagged ROM-reference table at
  `0x041000-0x0418AB`, covering `0x04E5AA-0x05FC2F` as explicit record slices and pushing the next
  coarse late-bank remainder back to `0x05FC30`.
- The most useful new structural clue in that added span is another repeated fixed-stride family:
  after the irregular lead-in through `0x05D47B`, the local table lands on eight consecutive
  `0x4C0`-byte records at `0x05D630`, `0x05DAF0`, `0x05DFB0`, `0x05E470`, `0x05E930`, `0x05EDF0`,
  `0x05F2B0`, and `0x05F770`, following an earlier isolated `0x4C0` record at `0x05C5DA`.
- Kept the new late-bank names structural. The table still proves ordering and repeated record sizes,
  but not yet the consuming loader or whether this payload family is maps, scripts, graphics
  metadata, or another banked resource group.
- Extended that same bank `0x040000` local-target payload split through the rest of the proven same-bank
  target run. The new `src/bank040000_payload_tail.asm` module now owns `0x05FC30-0x07FF66` as 284 more
  ROM-order record slices, leaving only a tiny trailing remainder at `0x07FF67-0x07FFFF` in
  `src/bank040000.asm`.
- This final same-bank pass materially sharpens the front table's ownership claim: the local flagged
  references at `0x041000-0x0418AB` now expose almost their entire target domain directly in source,
  not just the earlier front and mid windows. The clearest new repeated-size clue in the added tail is a
  shorter two-record `0x4C0` stride family at `0x06B192` and `0x06B652`, in addition to the already
  documented eight-record runs at `0x04BFAA` and `0x05D630`.
- Kept the new labels structural rather than subsystem-specific. The bytes still prove stable ROM-order
  starts and repeated record sizes, but not yet whether the payload family is maps, scripts, graphics
  metadata, or another late-bank resource group without its loader/dispatcher.

## 2026-03-18

- Refreshed the bank-ownership metadata after the latest bank `0x020000` and `0x080000` maturity passes so
  the docs/indexes match the current source layout instead of older opaque-gap wording.
- `docs/rom_layout.md`, `docs/open_questions.md`, `tools/index/rom_map.json`, and `todos.json` now record that
  bank `0x020000` no longer treats `0x020000-0x0201CF` and `0x02053A-0x020E4B` as anonymous front gaps:
  both spans are dedicated dialogue/script continuation modules around the two bank-relative text/control
  record families.
- The same metadata refresh also marks the full `0x09E028-0x09F776` tail command window in bank `0x080000`
  as source-visible in `tools/index/rom_map.json`, matching the already explicit `dc.b` ownership in
  `src/bank080000_mid_command_tail_tail.asm` after the final lead-out at `0x09F76A-0x09F776` was split.

- Tightened the front of the bank `0x080000` back-half payload at `0x0A3500-0x0A37AF` into a new
  ROM-order source module `src/bank080000_a3500_front.asm` instead of leaving that whole opening run as
  dozens of tiny `incbin` slices inside `src/bank080000_a3500.asm`.
- The new front slice is still labeled structurally, but it is materially more readable now: most
  records begin with repeated `FC .. .. FB .. ..` prefixes, many embed local 24-bit offsets back into
  the earlier `0x0A07C6-0x0A0D80` tuple families, and several end in short `FF` or `FD`-terminated
  selector tails. That is enough evidence to keep the bytes source-authored without overclaiming a map,
  script, sprite, or credits owner.
- This also sharpens the next likely format split inside the same island. The first `0x0A3500+` run now
  reads as a compact front control/offset cluster, followed by the already source-authored 3-word band at
  `0x0A37B0-0x0A37F7`, standalone local offsets at `0x0A37F8-0x0A37FD`, and later local-offset triplet /
  self-referencing families farther back in the same bank-local payload.
- Extended that same flagged-reference evidence across the bank boundary into bank `0x080000`. The
  cross-bank target runs from `0x0418AC-0x041BBF` now split the former opaque `0x080000-0x09622A`
  front tail-bank slice into a tiny untargeted lead-in at `0x080000-0x0801CC`, a large ROM-order
  table-targeted payload front at `0x0801CD-0x093FD0`, an explicit untargeted gap at
  `0x093FD1-0x094149`, a shorter ROM-order table-targeted tail at `0x09414A-0x0961D7`, and a final
  untargeted gap at `0x0961D8-0x09622A` before the known `0xFF` fill run begins.
- Kept those new bank `0x080000` labels structural rather than forcing a subsystem guess. The current
  proof is still the same monotone flagged ROM-reference ownership from bank `0x040000`: 178 unique

- Tightened another late pocket inside the bank `0x080000` command-tail window at
  `0x09E028-0x09F776` without forcing a loader guess. The former raw run at
  `0x09F272-0x09F4D4` is now source-authored in `src/bank080000_mid_command_tail_tail.asm` as
  explicit FF-terminated records instead of sixteen `incbin` slices.
- That new source pass exposes three more local structural families: a pair of compact
  D0/CA/DF/FE control sweeps at `0x09F272` and `0x09F351`, a neighboring `F4 18` / `F4 05`
  byte-pair command family at `0x09F2A5-0x09F3C5`, and a short literal/control pocket family at
  `0x09F3D6-0x09F459` built around the same `0x45/0x47/0x48/0x4A/0x4C` literal band.
- Kept the naming structural. The bytes now prove another coherent cluster inside the still-opaque
  tail-bank interpreter, but they still do not prove whether the owner is audio, credits,
  animation, or another command-driven subsystem.
- Tightened two more neighboring bridge pockets in the same tail-bank command body without forcing
  a subsystem guess. `src/bank080000_mid_command_tail_mid.asm` now source-authors
  `0x09DE58-0x09DFB3` as explicit `dc.b` data instead of three raw `incbin` slices.
- That middle-window follow-up now reads as one compact `F6/F7/F0` local-target setup bridge at
  `0x09DE58`, followed by a longer repeated `0x9x/0xAx` high-byte ladder around one recurring
  `B4 59` anchor at `0x09DF2B` and a short descending high-byte tail at `0x09DF92`.
- `src/bank080000_mid_command_tail_tail.asm` also now source-authors `0x09E6E2-0x09E6F6` plus
  `0x09E9A3-0x09E9E6` as explicit `dc.b` data instead of four raw `incbin` slices.
- Those late-tail follow-ups make one more compact low-byte ladder bridge explicit at `0x09E6E2`,
  then expose a short `F4 1B` literal-descent pocket across `0x09E9A3-0x09E9E6` with two smaller
  neighboring continuations at `0x09E9CC` and `0x09E9DA`.
  cross-bank starts now expose the target domain directly in source, but the meaning of the flag byte,
  the loader path, and the payload record format remain open.
- Split the previously raw `0x022AEC-0x022C5F` tail inside bank `0x020000`'s first post-dictionary
  structured island into explicit source-authored word records instead of one late `incbin`.
- That tail now reads as a small family of variable-length descriptor records whose boundaries are mostly
  proved by `$FFFF` terminators. One larger record at `0x022BBA` is now called out separately because it
  carries three internal `$FE00`-prefixed sublists before a doubled `$FFFF` terminator at `0x022C00`.
- Revisited the four repeated `0x4C0`-byte late-bank families in `0x040000-0x07FFFF` and tightened
  their ownership from generic fixed-stride payload runs to graphics-oriented tile families. The new
  evidence is byte-level but strong: each record is exactly `38 * 0x20` bytes, sampled rows match
  familiar Mega Drive 4bpp planar tile patterns, and the formerly generic modules have been renamed to
  `src/bank040000_gfx_tiles_04bfaa.asm`, `src/bank040000_gfx_tiles_05c5da.asm`,
  `src/bank040000_gfx_tiles_05d630.asm`, and `src/bank040000_gfx_tiles_06b192.asm`.
- Kept those renamed late-bank modules conservative at tile-family level instead of forcing a stronger
  asset claim. The flagged ROM-reference table at `0x041000` still proves stable starts and shared
  ownership, but the consuming loader is not yet tied to map pages, sprites, font pages, UI art, or
  another specific graphics subsystem.
- Tightened the previously incbin-backed `0x099649-0x09988F` middle of bank `0x080000`'s pre-descriptor
  tail into explicit source-authored data in `src/bank080000_mid_front.asm` instead of two coarse mixed
  byte bands.
- The front `0x099649-0x099828` span now stands as thirty fixed 16-byte records, which is a much cleaner
  cadence than the earlier catch-all mixed/control label. The bytes stay structural, but the stable
  record width is now explicit in ROM order.
- The following `0x099829-0x09988F` span also tightened further: it now exposes a 3-byte lead-in at
  `0x099829-0x09982B` followed by twenty fixed 5-byte records at `0x09982C-0x09988F` instead of one
  compact-control `incbin`.
- Kept the new names structural. The byte evidence now proves cadence and boundaries, but not yet the
  loader, field semantics, or whether these records belong to audio, credits, sprite/layout metadata, or
  another tail-bank subsystem.
- Tightened the final unsplit bank-end tail in bank `0x020000` without overclaiming the format. The old
  single remainder at `0x03C6E0-0x03FFFF` in `src/bank020000_tail_blocks.asm` now lives in
  `src/bank020000_tail_remainder.asm` as five smaller ROM-order sub-blocks starting at `0x03C6E0`,
  `0x03E846`, `0x03EF4E`, `0x03F4D1`, and `0x03FE24`.
- Those new starts are still weaker than the earlier `0xFF7A` / `0xFF7B` terminator-proven boundaries, but
  they are not arbitrary: each one begins with one of the same short header-like prefixes already seen at
  earlier tail-block starts (`0x0960`, `0x0F00`, or `0x0B60`), and the surrounding bytes show the same
  compressed/data-heavy texture rather than plain text or code.
- Kept the names structural. This pass improves ROM-order readability and removes the last monolithic
  remainder in the bank `0x020000` compressed tail, but it still does not prove whether those later
  header-like starts are true block boundaries, nested substreams, or format variants until a loader or
  decompressor path is recovered.
- Tightened the mid-back pocket of bank `0x080000`'s `0x0A3500-0x0A4C76` table-targeted region without
  forcing subsystem meaning. The former run of tiny `incbin` slices at `0x0A37FE-0x0A3B76` is now
  source-authored as explicit `dc.b` records in `src/bank080000_a3500.asm` instead of opaque byte slices.
- The new proof is still structural but stronger than simple table-target boundaries: most records repeat
  `FC .. .. FB .. ..` front prefixes, then fan out through compact local 24-bit offsets back into the
  already split `0x0A0E85-0x0A12E5` and `0x0A12EC+` families, with short `FF`-terminated selector tails or
  `FD`-terminated control tails. Several records also expose useful subfamilies directly in source, such as
  short `00xxxx` local offsets, paired `08xxxx` target lists, and mixed `02/04/06/08` offset tuples.
- Kept the new names structural. The bytes now justify source-authored ownership and a compact-record-pocket
  comment for `0x0A37FE-0x0A3B76`, but they still do not prove whether the controlling loader is walking
  scripts, object layouts, sprite metadata, or another tail-bank resource family.
- Extended that same bank `0x080000` back-half cleanup farther in ROM order. The next continuation at
  `0x0A3C17-0x0A4AA2` is no longer a wall of tiny inline `incbin` slices inside `src/bank080000_a3500.asm`:
  it now lives in three ROM-order source modules, `src/bank080000_a3c17.asm`, `src/bank080000_a43d5.asm`,
  and `src/bank080000_a47d9.asm`, before the already explicit self-referencing cluster at `0x0A4AA3-0x0A4AEB`.
- The newly exposed bytes keep reinforcing the same structural fit rather than a subsystem claim. Large parts
  of `0x0A3C17-0x0A4AA2` reuse the proven `FC/FB/FE` prefix controls, short `00/01/02/03/04/05/06/07/08/0A`
  local-offset lists, and `FF` or `FD` tails, while repeatedly targeting earlier families in the same bank such
  as `0x0A0Fxx`, `0x0A15xx`, `0x0A16xx`, `0x0A19xx`, `0x0A1Bxx`, `0x0A2Cxx`, `0x0A2Dxx`, and `0x0A30xx`.
- Kept the new labels structural. The bytes now justify module-level ownership and a clearer ROM-order split,
  but they still do not prove whether this pocket is script data, object/layout metadata, sprite control data,
  or another table-driven resource family without the loader or decoder that interprets those prefixes.
- Tightened the far late tail of bank `0x080000`'s `0x09E028-0x09F776` command window again without forcing
  a loader guess. The former raw slices at `0x09F6AE-0x09F6C3`, `0x09F6C4-0x09F6D2`, `0x09F6DE-0x09F6F9`,
  `0x09F706-0x09F727`, and `0x09F738-0x09F769` are now explicit `dc.b` records in
  `src/bank080000_mid_command_tail_tail.asm`.
- The new evidence is still structural, but it is more specific than simple FF-terminated boundaries. That
  pocket now exposes one compact local-seeded setup ladder at `0x09F6AE`, one short header/literal burst at
  `0x09F6C4`, a compact paired `0x09F6DE/0x09F6E8` header-literal family, one two-row literal/control record
  at `0x09F706`, and a repeated `E4 .. 01 FA FA` local-offset ladder at `0x09F738` before the final lead-out.
- Kept those names structural. The bytes now justify more readable record ownership in the late command tail,
  but they still do not prove whether this bank-local command family belongs to audio, credits, a custom data
  interpreter, or another tail-bank subsystem without the loader or bank-switch path that enters `0x098000+`.
- Kept the new names structural. The bytes now justify stable record and sublist boundaries, but they do
  not yet prove whether this tail belongs to maps, object placement, scripts, or another data-driven
  subsystem without the code that scans the `$FFFF` / `$FE00` markers or consumes the surrounding
  `0x022460-0x022C5F` descriptor island.
- Tightened the bank `0x040000` same-bank payload split one more step without forcing semantics. The
  repeated `0x4C0`-byte target families are no longer just individual labels inside the larger
  irregular payload files: `0x04BFAA-0x04E5A9`, `0x05C5DA-0x05CA99`, `0x05D630-0x05FC2F`, and
  `0x06B192-0x06BB11` now each live in dedicated ROM-order source modules.
- This does not change the current subsystem interpretation, but it does make the strongest repeated-size
  evidence in bank `0x040000` much clearer for future passes. The front flagged ROM-reference table still
  proves all of these starts directly, and the resulting families now stand apart from their surrounding
  irregular records instead of being buried inside long monolithic payload modules.
- Tightened that same bank `0x040000` evidence one step farther forward. The earlier `0x045842-0x045D01`
  singleton inside `src/bank040000_payload_front.asm` is now split into its own
  `src/bank040000_gfx_tiles_045842.asm` module because the front flagged table already gives it the same
  `$01` tag later used by the `0x04BFAA`, `0x05C5DA`, `0x05D630`, and `0x06B192` planar tile families.
- That makes the current best-fit tag interpretation less vague: every same-bank `$01` target in the
  `0x041000` table now lands on a `0x4C0`-byte / 38-tile 4bpp planar graphics block, while `$00` and `$02`
  still remain structural until the owning loader or consumer is recovered.
- Tightened the same late bank `0x080000` command-tail window one more step without forcing a loader guess.
  The former raw run at `0x09EFD3-0x09F00A` in `src/bank080000_mid_command_tail_tail.asm` is now explicit
  `dc.b` data instead of one `incbin` slice.
- That bridge now reads as one compact descending literal-pair ladder with the same `F4/F5` framing already
  proven nearby: it walks repeated `0x30`, `0x2F`, `0x2D`, `0x2B`, `0x29`, and `0x28` pair pockets with
  `C4/C6/C7` control pivots before handing off to the already split `0x09F00B+` family.
- Kept the new naming structural. The bytes now justify one more explicit late-tail record boundary and make
  the neighborhood around `0x09EFD3` less opaque, but they still do not prove whether the broader
  `0x098000+` command region belongs to audio, credits, animation, or another tail-bank interpreter.
- Tightened the neighboring middle-window pocket in bank `0x080000`'s `0x09C008-0x09E027` command body
  again without forcing subsystem ownership. `src/bank080000_mid_command_tail_mid.asm` now source-authors
  the former raw `0x09C687-0x09C98C` span as explicit `dc.b` records instead of five `incbin` slices.
- That follow-up exposes two clearer structural pockets in the same neighborhood: `0x09C687-0x09C920`
  now reads as one broader literal-row cycle that repeatedly revisits `0x2B/0x29/0x27` rows before
  shorter `0x32/0x30/0x2E` and `0x3E/0x3C/0x3A` tails, while `0x09C921-0x09C98C` resolves into a compact
  local-target setup plus a denser `0x9E/0xA1/0x9F/0xA4/0xA5` high-byte pair ladder with short `F5 EC`
  and `F5 0A` pivots.
- Kept the naming structural. The bytes now justify one more readable pocket in the middle command
  window, but they still do not prove whether the broader `0x099B00+` command family belongs to audio,
  credits, animation, or another tail-bank interpreter without the loader path that enters `0x098000+`.
- Tightened the next neighboring middle-window bridge in bank `0x080000` without forcing subsystem
  ownership. `src/bank080000_mid_command_tail_mid.asm` now source-authors the former raw
  `0x09C98D-0x09CBED` run as six explicit FF-terminated records instead of six `incbin` slices.
- That follow-up keeps the same structural command neighborhood but makes three more local families easier
  to audit in source: `0x09C98D-0x09CA27` now stands as a compact `F4 00` high-byte ladder pair centered on
  repeated `0x9E/0xA1/0x9F` and `0xA3/0xA1/0xA5` sweeps, `0x09CA28-0x09CB41` expands into a broader
  local-control-to-literal/high-byte descent around `0x52/0x51/0x4F`, `0x4D/0x4E`, and later
  `0x54/0x56/0x57/0x59` bands, and `0x09CBCD-0x09CBED` closes with a shorter local-control bridge into a
  repeated `0x00/0x05` literal-control row.
- Kept the naming structural. The bytes now justify another mature ROM-order split inside the middle
  command window, but they still do not prove whether the broader `0x099B00+` command family belongs to
  audio, credits, animation, or another tail-bank interpreter without the loader path that enters
  `0x098000+`.
  without forcing subsystem meaning. The former raw run at `0x09D5BF-0x09D980` in
  `src/bank080000_mid_command_tail_mid.asm` is now explicit `dc.b` data instead of twenty `incbin`
  slices.
- That new source pass exposes another coherent structural neighborhood: `0x09D5BF-0x09D633` keeps a
  compact `F4 2C` family that alternates short `0x9E/0x9C/0x9B` high-byte descents with neighboring
  `0x43/0x47/0x4A/0x4D/0x4F` literal ladders, `0x09D66B` returns to a longer D0/D1 local-target sweep
  before a small `0x43` literal cap, `0x09D6D9-0x09D82A` widens into a broader `F4 0C` literal/high-byte
  ladder family around `0x43/0x45/0x47/0x48/0x4A/0x4C/0x4D/0x4F/0x51`, `0x09D85B-0x09D8F5` revisits the
  local `0x60/0x65` burst neighborhood with compact `0x0B/0x08/0x0D/0x07/0x13/0x14/0x15` control rows,
  and `0x09D922` now stands explicitly as an alternating D2/D6/D0 local-control bridge into the already
  split repeated `F4 10` pair-ladder cluster at `0x09D981`.
- Kept the new names structural. The bytes now justify another mature ROM-order split inside the middle
  command window, but they still do not prove whether the broader command family belongs to audio,
  credits, animation, or another tail-bank interpreter without the loader or bank-switch path that
  enters `0x098000+`.
- Tightened the next adjacent late-tail pocket in the same bank `0x080000` command window without forcing a
  loader guess. The former raw `0x09E385-0x09E604` run in `src/bank080000_mid_command_tail_tail.asm` is now
  explicit `dc.b` data instead of sixteen `incbin` slices.
- That new pass exposes another coherent bridge in the same local command neighborhood: `0x09E385-0x09E404`
  now stand as a short `F4 08` literal crest plus two compact `F4 00` literal-control rows, `0x09E424`
  expands into a longer local-control/local-offset prelude followed by repeated `0x2B/0x2A/0x29/0x28`
  literal-pair ladders, `0x09E4EE` rises through a compact `0x3E/0x40/0x41/0x42` literal band, `0x09E50C`
  widens into a broader `0x43/0x47/0x48/0x4A/0x4C` literal/high-byte ladder, and `0x09E599-0x09E604`
  taper back into a short `0x53/0x58/0x56/0x4F` descent plus one final `0x60/0x0F/0x10/0x05`
  literal-control burst.
- Kept the naming structural. The bytes now justify another explicit ROM-order bridge in the late tail-bank
  command family, but they still do not prove whether the owner is audio, credits, animation, or another
  command-driven subsystem without the loader or bank-switch path that enters `0x098000+`.
- Tightened the very end of that same late tail-bank command window without forcing subsystem meaning.
  The former grouped non-terminated lead-out at `0x09F76A-0x09F776` in
  `src/bank080000_mid_command_tail_tail.asm` is now source-authored as explicit `dc.b` bytes instead of
  one short `incbin` slice.
- The new evidence is still structural, but it is cleaner than a bare remainder: the lead-out starts with
  another local-offset-like seed (`88 78 01 D3`), steps through a compact `F6/F7` ladder, and then ends on
  the final two zero bytes immediately before the `0x09F777-0x09FFFF` fill run.
- Kept the naming structural. This removes the last opaque pocket inside `0x09E028-0x09F776`, but the
  surrounding command family's loader, tag meaning, and subsystem owner are still unproven.
- Extended that same bank `0x020000` structured tail farther forward without forcing semantics. The
  `src/bank020000_tables.asm` module now owns `0x022C56-0x022DB7` explicitly instead of dropping back to
  an anonymous `incbin` at `0x022C60`.
- The added front `0x022C56-0x022D3F` bytes continue the same structural pattern as the preceding tail:
  they are ROM-order variable-length word records terminated by `$FFFF`, including one longer record at
  `0x022C56`, several short six-word records, and another mixed record at `0x022CFC`.
- The next `0x022D40-0x022D6B` span is now explicit as a repeated `$0BFF` word band, and the following
  `0x022D6C-0x022DB7` bytes split cleanly into compact `$FF00`-terminated word records, two of which also
  embed `$FE00` markers. That is enough to justify smaller ROM-order structural slices even though the
  higher-level owner and field semantics remain open.
- Split the remaining mixed `0x0A10AB-0x0A34FF` lead-in inside bank `0x080000` one level further without
  forcing subsystem meaning. The new `src/bank080000_a10ab.asm` module now breaks that old monolithic tail
  into long FF-terminated runs whose pre-terminator payload lengths are always multiples of 5 bytes,
  separated by short anomaly gaps at `0x0A1322-0x0A132C`, `0x0A136E-0x0A1377`, `0x0A1406-0x0A1410`,
  `0x0A1D3F-0x0A1D4E`, `0x0A23F6-0x0A23FF`, `0x0A2586-0x0A258A`, `0x0A2606-0x0A260F`,
  `0x0A2765-0x0A27CA`, `0x0A2D86-0x0A2D9A`, and `0x0A3040-0x0A304A`.
- The new regular runs now stand explicitly in ROM order at `0x0A10AB-0x0A1321`, `0x0A132D-0x0A136D`,
  `0x0A1378-0x0A1405`, `0x0A1411-0x0A1D3E`, `0x0A1D4F-0x0A23F5`, `0x0A2400-0x0A2585`,
  `0x0A258B-0x0A2605`, `0x0A2610-0x0A2764`, `0x0A27CB-0x0A2D85`, `0x0A2D9B-0x0A303F`, and
  `0x0A304B-0x0A34FF`, so the largest remaining opaque middle slice in this island is no longer one
  anonymous incbin.
- Kept the labels structural. The byte-level evidence now strongly supports FF-delimited tuple-run
  ownership, but it still does not prove whether each 5-byte unit is layout, object, script, or another
  format without the decoder that consumes the surrounding `0x0A0000-0x0A4C76` table tree.
- Split the neighboring bank `0x080000` command tail at `0x09A348-0x09F776` one level further without
  forcing subsystem meaning. The former single large trailing record in `src/bank080000_mid.asm` now
  breaks at later proven record starts into three ROM-order source windows:
  `0x09A348-0x09C007`, `0x09C008-0x09E027`, and `0x09E028-0x09F776`.
- The new boundaries are still justified only by byte-level structure: the old trailing body contains
  486 local `0xFF` record ends, each new window starts immediately after one such terminator, and the
  same region also shows repeated 24-byte triplets at `0x09AB2A-0x09AB71`, `0x09E6F7-0x09E73E`, and
  `0x09F4D5-0x09F51C`, plus a short non-terminated lead-out at `0x09F76A-0x09F776`.
- Tightened the front descriptor/layout pocket in that same bank `0x080000` island without forcing a
  subsystem name. The former raw `0x099920-0x099A84` span is now source-authored in
  `src/bank080000_mid_descriptors.asm` as sixteen fixed 6-byte records at `0x099920-0x09997F`,
  forty-nine fixed 5-byte records at `0x099980-0x099A74`, and a short 16-byte trailer at
  `0x099A75-0x099A84`.
- Kept those new labels structural. The strongest new proof is cadence rather than semantics: the bytes
  now justify stable 6-byte and 5-byte record boundaries in ROM order, but they still do not prove the
  consuming loader or whether the fields describe layouts, objects, audio-side commands, or another
  tail-bank resource family.
- Split those three bank `0x080000` FF-terminated command windows one level further into explicit ROM-order
  record slices instead of leaving each window as one coarse `incbin`. The new `src/bank080000_mid_command_*.asm`
  modules now break `0x09A348-0x09C007` into 154 FF-terminated records, `0x09C008-0x09E027` into 183 records,
  and `0x09E028-0x09F776` into 149 FF-terminated records plus the existing short non-terminated lead-out at
  `0x09F76A-0x09F776`.
- Kept the new labels structural and ROM-order. The strongest proof is still purely local byte cadence: every
  new record ends at a proven in-window `0xFF` terminator, the slices cover each window without gaps, and the
  lone non-terminated tail remains isolated rather than being forced into the same record family.
- Tightened the neighboring `0x0A10AB-0x0A1405` tail-bank lead-in one step further without forcing subsystem
  meaning. The first three FF-terminated 5-byte-tuple runs in `src/bank080000_a10ab.asm`
  (`0x0A10AB-0x0A1321`, `0x0A132D-0x0A136D`, and `0x0A1378-0x0A1405`) are now source-authored as 63 explicit
  ROM-order record slices instead of three coarse run-sized `incbin`s.
- The byte-level evidence for that split is now stronger and more local: every authored record ends at a proven
  `0xFF` terminator, every pre-terminator payload in those three runs is an exact multiple of five bytes, and the
  front records already show repeated small tuple families plus one singleton `$FF` record at `0x0A1378`. That is
  enough to justify stable record boundaries while still keeping the names structural until a 68k-side consumer or
  decoder proves what the tuples mean.
- Extended that same `0x0A10AB+` tail-bank pass farther into the next long regular window without forcing semantics.
  The new `src/bank080000_a1411.asm` module now owns `0x0A1411-0x0A1D3E` as 215 explicit ROM-order FF-terminated
  record slices instead of one coarse run-sized `incbin` in `src/bank080000_a10ab.asm`.
- The byte-level proof in that new span stays structural but is strong enough for a mature split: every record ends
  at a local `0xFF`, every pre-terminator payload length remains a multiple of five bytes, and the run resolves
  cleanly from `0x0A1411` through `0x0A1D3E` with no internal anomaly gaps.
- Extended that same bank `0x080000` five-byte tuple pass farther forward without forcing subsystem meaning.
  The next four regular runs in `src/bank080000_a10ab.asm` are no longer coarse run-sized `incbin`s:
  `0x0A1D4F-0x0A23F5` now lives in `src/bank080000_a1d4f.asm`, `0x0A2400-0x0A2585` in
  `src/bank080000_a2400.asm`, `0x0A258B-0x0A2605` in `src/bank080000_a258b.asm`, and
  `0x0A2610-0x0A2764` in `src/bank080000_a2610.asm` as explicit ROM-order record slices.
- The byte-level proof stays local but strong: every new record ends at a proven local `$FF`, and every
  pre-terminator payload length across those four runs remains a multiple of five bytes. Their now-explicit
  record-length histograms are `1/6/11/16/21/26/31/36/41` for `0x0A1D4F-0x0A23F5`, `6/11/16/21/26` for
  `0x0A2400-0x0A2585`, `31/36/56` for `0x0A258B-0x0A2605`, and `6/11/16/21` for `0x0A2610-0x0A2764`.
- Kept the labels structural. This pass improves ROM-order readability and narrows the remaining grouped runs
  in `0x0A10AB-0x0A34FF`, but it still does not prove whether the 5-byte tuples are layout, object, script,
  or another resource family without the decoder behind the surrounding offset-table tree.
- Finished the same `0x0A10AB-0x0A34FF` tail-bank five-byte tuple pass by splitting the last three regular
  runs out of `src/bank080000_a10ab.asm` into `src/bank080000_a27cb.asm`, `src/bank080000_a2d9b.asm`, and
  `src/bank080000_a304b.asm`, so the spans at `0x0A27CB-0x0A2D85`, `0x0A2D9B-0x0A303F`, and
  `0x0A304B-0x0A34FF` now also expose every proven ROM-order record start directly in source.
- The byte-level proof stays local but strong. Every new record ends at a proven local `$FF`, every
  pre-terminator payload length in those final three runs remains a multiple of five bytes, and the run-local
  length histograms are now explicit: `0x0A27CB-0x0A2D85` has 62 records with sizes
  `6/11/16/21/31/36/41/46/56/76/81/86/91`, `0x0A2D9B-0x0A303F` has 77 records with sizes `6/11/21/46`, and
  `0x0A304B-0x0A34FF` has 115 records with sizes `6/11/16/21/41`.
- This leaves the whole regular `0x0A10AB-0x0A34FF` family split to individual record starts in ROM order,
  with only the already-explicit anomaly gaps between runs still left as mixed payload. The tuple meaning is
  still unresolved, so the names stay structural until the surrounding offset-tree consumer is recovered.
- Tightened the late tail of bank `0x080000`'s `0x09E028-0x09F776` command window without forcing subsystem
  meaning. `src/bank080000_mid_command_tail_tail.asm` now makes two more short repeated-shape families explicit
- Tightened the front edge of that same `0x09E028-0x09F776` tail window without forcing a loader guess. The
  former raw run at `0x09E028-0x09E22A` in `src/bank080000_mid_command_tail_tail.asm` is now explicit
  `dc.b` data instead of thirteen small `incbin` slices.
- That new source pass makes the tail window's opening neighborhood materially clearer: `0x09E028` now reads
  as one compact local-control sweep into a descending `0xAA/0xB8/0xB6/...` high-byte ladder, `0x09E08A`
  exposes one nearby local-control-to-literal-control bridge, `0x09E0E5-0x09E1C7` now stands as a short
  family of `F4 05 C2` literal/control records that widens into repeated `0x65` pockets, and `0x09E1CC`
  returns to a denser local-control sweep before the compact `F4 FE` literal-pair rows at `0x09E216` and
  `0x09E22B`.
- Kept those names structural. The bytes now justify source-authored ownership at the front of the tail
  command window and leave fewer anonymous bridge slices, but the controlling loader and subsystem owner for
  the broader `0x098000+` interpreter remain open.

- Tightened the `0x09E028-0x09F776` tail-bank command window again without forcing a loader guess. The
  former raw slices at `0x09E6B2-0x09E6E1`, `0x09E73F-0x09E791`, and `0x09F0AE-0x09F18B` are now explicit
  `dc.b` records in `src/bank080000_mid_command_tail_tail.asm`.
- The new proof is still structural, but clearer than simple FF-terminated boundaries: `0x09E6B2-0x09E6E1`
  now reads as a compact low-byte ladder pair with `C0/C2/C4/C6` control pockets, `0x09E73F-0x09E791`
  stands as an E3-seeded short record plus a longer low-byte ladder continuation, and
  `0x09F0AE-0x09F18B` now resolves into one local-target sweep followed by two adjacent high-byte pair
  ladders around the recurring `0xA1/0xA3` and `0x9x/0x3x` payload families.
- Kept the new names structural. The bytes now justify more readable record ownership in the late command
  tail, but they still do not prove whether this bank-local interpreter belongs to audio, credits,
  animation, or another tail-bank subsystem without the loader or bank-switch path that enters
  `0x098000+`.
- Tightened another front-table chunk inside bank `0x080000`'s `0x099B00-0x09A347` command front without
  forcing subsystem meaning. `src/bank080000_mid.asm` now source-authors the former raw
  `0x099D78-0x099F23` run as explicit tuple-led and FF-terminated subrecords instead of twelve `incbin`
  slices.
- That new source pass sharpens several neighboring structural fits at once: `0x099D78-0x099DE5` now reads
  as short tuple-style lead-ins plus compact control bodies and tiny FE/F5 trailers; `0x099DE6-0x099E0A`
  makes one cross-record bridge explicit because the `0x099E05` tuple preface and the single-byte lead-in
  at `0x099E0A` belong to the following `0x099E0B` target rather than the earlier `0x099DE6` body;
  `0x099E36-0x099E79`, `0x099E7A-0x099ED1`, and `0x099ED2-0x099F23` continue the same tuple-plus-control
  pattern with recurring `F6/F7/F0/F1/F2/F4` framing, local `DA/DC/DB` pockets, one larger literal/high-byte
  record at `0x099EA6`, and small FC/F5 or FE-tagged tails.
- Kept the naming structural. The bytes now justify cleaner source ownership throughout another table-targeted
  stretch of the command front, but they still do not prove whether the broader `0x099B00+` command family
  belongs to audio, credits, animation, or another tail-bank interpreter without the loader path that enters
  `0x098000+`.
- Tightened the middle `0x09C008-0x09E027` command window in bank `0x080000` again without forcing a
  subsystem guess. The former raw slices at `0x09DA43-0x09DB5A` and `0x09DCD6-0x09DE57` are now explicit
  `dc.b` records in `src/bank080000_mid_command_tail_mid.asm` instead of two larger incbin-backed pockets.
- The newly exposed `0x09DA43-0x09DB5A` pocket now reads as a compact `F4/F1/F5` family with short
  `0xBx/0x5x` and `0xAx/0x4x` high-byte pair ladders, two tiny literal-control pivots, and one longer mixed
  literal-plus-high-byte continuation before the next local-target setup record at `0x09DB5B`.
- The neighboring `0x09DCD6-0x09DE57` pocket is also less opaque now: it exposes one short `0x05/0x0D`
  literal-control pair family, two adjacent `0x60/0x65/0x6C/0x6D` burst records, a compact local-target
  sweep, and three pair-ladder continuations before the next setup record at `0x09DE58`.
- Kept the names structural. This pass materially reduces the opaque bridges between already source-authored
  mid-window command clusters, but it still does not prove whether the command decoder belongs to audio,
  credits, animation, or another tail-bank interpreter without the loader or bank-switch path that enters
  `0x098000+`.
- Tightened two more short bridge pockets in that same bank `0x080000` command-tail body without forcing a
  subsystem guess. The former raw slices at `0x09DB5B-0x09DBCB` and `0x09F51D-0x09F596` are now explicit
  `dc.b` records in `src/bank080000_mid_command_tail_mid.asm` and `src/bank080000_mid_command_tail_tail.asm`.
- The newly exposed `0x09DB5B-0x09DBCB` bridge now reads as one compact setup/local-target sweep that reuses
  `E0/E1`-tagged local steps before ending in a short repeated literal row, followed by two neighboring
  compact literal-row continuations with the same `F4/C4/F1/F5` framing and one tiny `C2/F1` pivot.
- The late-tail `0x09F51D-0x09F596` bridge is also less opaque now: it exposes one more compact
  `CA/DF/FE`-style local-control sweep at `0x09F51D`, followed by a neighboring pair of short
  `F4 00 C2` literal/control records at `0x09F561` and `0x09F57C` that vary the same
  `0x60/0x65/0x6C/0x0F` pocket just before the already explicit repeated-burst family at `0x09F597`.
- Kept the names structural. This pass removes two more incbin-backed bridges between already explicit
  command-tail pockets, but the owning loader and subsystem meaning still need code-flow evidence.
  at `0x09F00B-0x09F0AD` and `0x09F18C-0x09F271` instead of leaving those pockets as adjacent `incbin`
  records.
- The new proof is still local byte structure, but it is strong enough for source-owned command families.
  The first pocket keeps one compact `F4/F5` frame across nine short FF-terminated records whose payloads vary
  only in small `C4/C6/C7` control-byte changes and byte-pair ladders around `0x26-0x32`; the second pocket
  repeats the same idea with `0x9x/0x3x` byte-pair ladders across eight adjacent FF-terminated records.
- Kept the names structural. These newly explicit late-tail families make the command cadence easier to audit
  in ROM order, but they still do not prove the owning loader or the field semantics of the repeated byte-pair
  values without the code path that enters the `0x098000-0x09F776` island.
- Tightened the next opaque bridge in bank `0x020000` without forcing subsystem meaning. The old monolithic
  `0x022DB8-0x023AB5` gap between `src/bank020000_tables.asm` and `src/bank020000_records.asm` now lives in
  `src/bank020000_gap.asm`, which isolates a front recurring-word band at `0x022DB8-0x0237B3`, then exposes
  two standalone `$FFFF` words at `0x0237B4` and `0x0237E2`, two more `$FF00`-terminated compact word
  records at `0x0237B6-0x0237CD` and `0x0237CE-0x0237DB`, a short
  three-word lead-in at `0x0237DC-0x0237E1`, and only then the remaining mixed payload at
  `0x0237E4-0x023AB5`.
- Kept the new bridge labels structural. The local sentinel words are now strong enough to prove a real
  transition zone between the earlier compact-record family and the later `$FFFF`-delimited word-record
  band, but not yet enough to claim the higher-level owner or field semantics without the code that walks
  or dispatches these records.
- Extended that same bank `0x020000` sentinel-delimited family one step farther into the following opaque
  tail without forcing subsystem meaning. The new `src/bank020000_tail_records.asm` module now owns the
  front `0x024538-0x02482B` continuation as nine explicit big-endian word records, each ending at a local
  `$FFFF` sentinel, instead of dropping straight back to a coarse bank-wide `incbin` immediately after
  `0x024537`.
- The new continuation sharpens two useful structural fits without overclaiming semantics: the front record

- Tightened the back half of bank `0x080000`'s `0x0A3500-0x0A4C76` table-targeted payload family without
  forcing subsystem meaning. Several repeated subfamilies are now explicit data instead of raw sliced
  `incbin`s inside `src/bank080000_a3500.asm`.
- The front new cluster at `0x0A37B0-0x0A37FD` is now source-authored as twelve fixed 3-word records
  followed by two standalone local offsets, which is a stronger structural fit than leaving fourteen short
  table-targeted slices opaque.
- The later run at `0x0A3B77-0x0A3C16` is now source-authored as sixteen local-offset triplet records. Each
  record is three bank-local 24-bit offsets plus a trailing `$FD`, and every pointed start lands back in the
  already split `0x0A12EC-0x0A1519` five-byte-tuple family.
- The tail cluster at `0x0A4AA3-0x0A4AEB` is now also explicit as eight fixed 3-word records plus an
  FF-terminated local-offset list that names those same eight starts, making a small self-referential group
  visible directly in source.
- Kept the names structural rather than subsystem-specific. The new evidence is still local byte structure
  and cross-links into already split tuple runs, not yet the 68k-side loader or decoder that would justify
  stronger ownership terms.
- Tightened the remaining tail of that same `0x0A3500+` back-half pocket without forcing subsystem meaning.
  The former final run of tiny `incbin` slices at `0x0A4AEC-0x0A4C76` now lives in
  `src/bank080000_a4aec.asm` as explicit `dc.b` records included from `src/bank080000_a3500.asm`.
- The newly exposed bytes continue the same structural motif already seen earlier in the back half: three
  standalone local offsets at `0x0A4AEC-0x0A4AF2`, then a compact control pocket whose records repeatedly
  start with `FC`/`FB`/`FE` prefix groups and end in short `FF`- or `FD`-terminated local-offset lists.
  Those lists reach back into several already split families, including the earlier `0x0A0E85+` tuple
  band, the `0x0A157B+` run, the self-referencing `0x0A319E+` cluster, the `0x0A323F+` local-offset
  family, and the late `0x0A3476+` starts.
- This pass keeps the names structural but leaves the bank materially cleaner: the whole currently split
  `0x0A3500-0x0A4C76` table-targeted back half is now source-authored as explicit data families rather
  than generic one-line target slices, even though the higher-level loader and field semantics still need
  code-flow evidence.
  at `0x024538` reuses several control-word motifs already seen nearby (`$E001/$E010/$E012/$E021/$E031/$E042/$E071`,
  `$D301`, and embedded `$FF00` markers before the final `$FFFF`), while the following eight shorter records
  cleanly continue the same pointer-like-header plus small word-tuple cadence already visible in
  `0x023AB6-0x024537`.
- Kept the names structural. This pass proves that the later word-record island extends at least through
  `0x02482B`, but the code that scans these sentinels and interprets the mixed control-like words still
  needs to be found before stronger subsystem names are safe.
- Followed the two already source-authored bank-relative offset tables at `0x0211DA-0x02135F` back into
  their target domains so the front of bank `0x020000` is no longer just one `0x020000-0x0211C9` blob.
- The new `src/bank020000_front_records_a.asm` module now owns `0x0201D0-0x020539` as 52 ROM-order
  record slices proved directly by the offset table at `0x0211DA`, while the gap before it
  (`0x020000-0x0201CF`) and the following untargeted middle (`0x02053A-0x020E4B`) stay explicit as
  separate `incbin` regions in `src/bank020000.asm`.
- The new `src/bank020000_front_records_b.asm` module now owns `0x020E4C-0x0211C9` as 131 ROM-order
  record slices proved directly by the monotone offset table at `0x021258`, leaving the front index
  island at `0x0211CA-0x02135F` adjacent to the exact target family it indexes.
- Kept those new front-bank labels structural. Raw bytes in both target ranges still mix text fragments
  with undecoded control payloads, so the tables now prove stable record boundaries and ROM-order
  ownership, but not yet the higher-level menu/script/dialogue consumer.

## 2026-03-18

- Split the formerly monolithic bank `0x040000` front pre-table slice at `0x040000-0x0409F9`
  into a dedicated ROM-order module, `src/bank040000_front_blocks.asm`, instead of leaving the
  whole bank front as one anonymous `incbin` in `src/bank040000.asm`.
- Kept the new bank-front names structural. Raw-byte review now supports six weaker but still useful
  internal starts at `0x040100`, `0x04025C`, `0x040400`, `0x04053C`, `0x0406C4`, and `0x0408D4`.
  Those starts are evidence-backed because they begin with recurring short header-like prefixes seen
  multiple times within the same front slice (`FFFF 000A`, `FFFF 000E`, or `0000 0102` followed by
  a nearby `FFFF 001E/000E` pocket), while the unique `0x040000-0x0400FF` lead-in stays separate.
- This pass does not prove the subsystem owner for the bank-front bytes, but it still improves the
  late-ROM source layout materially: bank `0x040000` now makes both its front pre-table island and
  its long table-targeted body visible in smaller ROM-order modules rather than falling back to a
  bank-front monolith before the already split flagged-reference tables at `0x041000`.

- Split `src/bank020000_dialogue_front.asm` (`0x020000-0x0201CF`, 19 labelled incbin slices, 8 NPC
  dialogue records). Split `src/bank020000_dialogue_mid.asm` (`0x02053A-0x020E4B`, 110+ labelled
  incbin slices, 53 null-delimited records including boss speeches and landmark hints). Both verified
  bit-perfect. `src/bank020000.asm` updated to include both new files.

- Tightened the bank `0x080000` pre-descriptor tail inside the `0x098000-0x09F776` non-fill island
  without forcing subsystem meaning. The former single `0x098000-0x09991F` front slice in
  `src/bank080000_mid.asm` is now split at `0x099200`, leaving only `0x098000-0x0991FF` under the
  strongly Z80-like opcode-dense label and moving `0x099200-0x09991F` into the new ROM-order module
  `src/bank080000_mid_front.asm`.
- The front `0x099200-0x09927F` bytes are now explicit as two monotone byte bands, and the next
  `0x099280-0x099648` span is source-authored as 51 fixed 19-byte records because every record stays
  aligned on the same cadence and its third/fourth bytes are consistently one of `F0C0`, `D0C0`, or
  `B0C0`.
- Kept the later `0x099649-0x09988F` bytes conservative as two smaller mixed/control tails rather than
  forcing a weak tuple theory, but still tightened the final `0x099890-0x09991F` trailer into source as
  a short local-offset word band, a packed byte band, eight repeated `0x01F1` words, a 14-byte trailer,
  and a final word tail leading directly into the already split `0x099920-0x099A84` descriptor/layout
  records.
- Kept the new names structural. The current proof is byte cadence and local ordering, not yet the
  consuming loader, so this pass records a clearer pre-descriptor frontier without overcommitting to
  audio, credits, scripts, or another subsystem.
- Tightened that same `0x098000-0x0991FF` front slice one step further without forcing subsystem meaning.
  The former single Z80-like `incbin` in `src/bank080000_mid.asm` now lives in
  `src/bank080000_mid_z80_program.asm`, where the front `0x098000-0x09907A` bytes are now treated as a
  real Z80 program front instead of a merely Z80-like blob: `0x098000` opens on `DI`, `IM 1`, and a
  jump to `0x09803B`, the pre-body cluster includes repeated absolute jump stubs plus a tiny `NOP` /
  `RETI` handler at `0x098038`, and the remaining `0x09803B-0x09907A` bytes stay grouped as the still-opaque
  main program body while the final `0x185` bytes remain explicit in ROM order instead of hidden inside the
  same blob.
- The new split is still structural but materially cleaner: `0x09907B-0x09913C` is now exposed as an
  odd-aligned little-endian ascending word table with 97 entries rising from `0x028E` to `0x051C`,
  `0x09913D-0x0991FE` is a matching descending table with 97 entries falling from `0x0349` to `0x01A4`,
  and `0x0991FF` stands apart as a single trailing zero byte before the already split pre-descriptor tail at
  `0x099200`.
- Kept the names structural rather than guessing at waveform, pitch, camera, or script semantics. The byte
  pattern proves odd-aligned little-endian lookup-table ownership inside the Z80-like island, but the
  consumer still needs to be found before stronger subsystem labels are safe.
- Tightened the front of the same `0x099BD3-0x09A347` command region one step further without forcing a
  subsystem guess. Five longer table-targeted command records are no longer single `incbin`s in
  `src/bank080000_mid.asm`: `0x099D05-0x099D47`, `0x099D48-0x099D77`, `0x09A10E-0x09A13B`,
  `0x09A16A-0x09A198`, and `0x09A288-0x09A347` are now explicit as smaller FF-terminated subrecords.
- That new split keeps the labels structural. The bytes prove repeated local `0xFF` terminators and one
  standalone `0xFF` sentinel at `0x09A11D`, but they still do not prove whether the command stream is audio,
  credits, animation, or another banked interpreter.
- Tightened the same tail-bank command front again at `0x09A199-0x09A287` while keeping the build
  bit-perfect. That whole pocket in `src/bank080000_mid.asm` is now source-authored as narrower
  FF-terminated command subrecords, with the two-byte bridge at `0x09A22B-0x09A22C` and the standalone
  `0xFF` byte at `0x09A26A` left explicit instead of hiding them inside neighboring slices.
- Tightened two more adjacent front-table command targets in the same bank `0x080000` command front
  without forcing subsystem meaning. `src/bank080000_mid.asm` now source-authors the former raw
  `0x09A13C-0x09A169` continuation as explicit structural records instead of two `incbin` slices.
- That follow-up makes the local shape clearer in source: `0x09A13C-0x09A148` now reads as a short
  tuple-style FF-terminated lead-in followed by one compact non-terminated local-target tail, while
  `0x09A149-0x09A169` resolves into another short tuple-style FF-terminated lead-in plus one larger
  FF-terminated control record built around `F7 10`, `F1 10`, `F2 00 34`, `F4 0C`, and repeated
  `DF FC` / `F5` control bytes.
- This does not yet prove the owning subsystem, but it materially improves the structure of the
  `0x099B00+` command region: the `0x09A199-0x09A1BA` and `0x09A1BB-0x09A1D7` targets each break into a
  short FF-terminated lead-in plus one larger FF-terminated payload, `0x09A1D8-0x09A1F1` breaks into
  three FF-terminated pieces, `0x09A1F2-0x09A22A` breaks into five, and the `0x09A22D-0x09A287` tail
  now exposes the same compact local cadence all the way up to the already-split `0x09A288` pocket.
- Tightened two more high-visibility pockets inside the same bank `0x080000` command tail without forcing
  subsystem meaning. The repeated 24-byte triplets at `0x09AB2A-0x09AB71`, `0x09E6F7-0x09E73E`, and
  `0x09F4D5-0x09F51C` are now explicit `dc.b` records in `src/bank080000_mid_command_tail_front.asm`
  and `src/bank080000_mid_command_tail_tail.asm` instead of raw `incbin` slices, and the longer
  neighboring `0xAB`-byte records at `0x09A3EC-0x09A496` and `0x09E607-0x09E6B1` are now source-authored
  too.
- The new proof is still structural but it raises the local maturity: those two 0xAB-byte records now read
  clearly as repeated-byte-pair sweeps under the same compact command framing used by nearby records, while
  the three 24-byte triplets now stand apart as a stable repeated family instead of being mentioned only in
  notes. The owner is still unresolved, so the names stay at repeated-command-record level rather than
  forcing audio, credits, or animation semantics.
- Tightened the same `0x09A348-0x09C007` command-tail front one step farther without forcing subsystem
  meaning. Five more FF-terminated records in `src/bank080000_mid_command_tail_front.asm` are now explicit
  `dc.b` data instead of raw `incbin` slices: `0x09A497-0x09A4F9`, `0x09A59B-0x09A613`,
  `0x09A63B-0x09A6D6`, `0x09AB72-0x09AB94`, and `0x09AB95-0x09ABE0`.
- The new proof is still byte-local but it makes the command cadence materially clearer. The first, second,
  third, and fifth records all open with the same compact setup/control prefixes (`F6/F7/F0 ...` or
  `F4/F1/F5 ...`) already seen in neighboring explicit command records, then expand into repeated byte-pair
  sweeps before their final `0xFF` terminators; `0x09AB72-0x09AB94` now also reads as the short follow-on
  continuation immediately after the already explicit 24-byte triplet family at `0x09AB2A-0x09AB71`.
- Kept the new labels structural. This pass improves source readability inside the most active `0x09A348+`
  command window, but the controlling loader and subsystem owner are still unresolved.
- Tightened the next neighboring front-window pocket in the same bank `0x080000` command body without
  forcing subsystem meaning. `src/bank080000_mid_command_tail_front.asm` now source-authors the former raw
  `0x09A4FA-0x09A63A` continuation as explicit `dc.b` records instead of six `incbin` slices.
- That follow-up makes two local structural families easier to audit in source: `0x09A4FA-0x09A55A` now
  stands as a short `F4 15` literal-row pocket that revisits `0x29/0x30/0x35/0x3C`, then broadens into a
  denser `0x2D/0x34/0x39/0x3B` row cycle with a tiny `0x2A/0x31/0x36/0x3C` cap, while
  `0x09A567-0x09A62C` returns to a compact local-seeded bridge that pivots through repeated `E4 .. 01`
  local-offset hops before ending on short `0x48/0x4A` and `0x49/0x48/0x46` literal tails.
- Kept the naming structural. The bytes now justify another mature ROM-order split inside the front
  command window, but they still do not prove whether the broader `0x099B00+` command family belongs to
  audio, credits, animation, or another tail-bank interpreter without the loader path that enters
  `0x098000+`.
- Tightened the next neighboring front-window pocket in that same bank `0x080000` command body without
  forcing subsystem meaning. `src/bank080000_mid_command_tail_front.asm` now source-authors the former raw
  `0x09ABE1-0x09AF25` continuation as explicit `dc.b` records instead of twenty-three `incbin` slices.
- That follow-up makes several local structural families easier to audit in source: `0x09ABE1-0x09ABF7`
  now stands as a compact repeated literal rise around `0x4A/0x49/0x4D/0x4F/0x51`, `0x09AC0A-0x09ACA1`
  resolves into a broader `F4 14` local-control-to-literal/high-byte sweep plus mirrored `0xA1-0xA7`
  rows, `0x09ACCA-0x09AD2B` narrows into a short `F4 0C` literal-control family around
  `0x00/0x05/0x0D/0x0C`, and `0x09AD2C-0x09ADD0` widens back out as the next `F4 1A` literal-pair ladder
  around repeated `0x34/0x32/0x2F` cells.
- The same pass also makes the later bridge at `0x09ADE4-0x09AF25` explicit as one compact
  local-control-to-`F4 0E` literal/high-byte ladder around `0x47/0x4A/0x48/0x4C/0x45/0x41`, three
  shorter `F4 0E` literal continuations, and the neighboring `F4 11` row family at
  `0x09AE7B-0x09AF25` whose rows repeatedly revisit `0x53/0x4D/0x56/0x54` plus a denser `0x5F` control
  pocket. The loader path into the wider `0x099B00-0x09F776` command region is still unproven, so the
  labels stay structural.
- Tightened the next neighboring front-window pocket in that same bank `0x080000` command body without
  forcing subsystem meaning. `src/bank080000_mid_command_tail_front.asm` now source-authors the former raw
  `0x09AF26-0x09B090` continuation as explicit `dc.b` records instead of eight `incbin` slices.
- That follow-up keeps the same structural command neighborhood but makes three more families easier to
  audit in source: `0x09AF26-0x09AF6B` now stands as the next compact `F4 11` row-tail pocket around
  `0x4C/0x4F/0x53/0x54/0x51/0x4D` with one short `0x5F`-gated variation, `0x09AF6C-0x09AFBC` resolves into
  a compact local-control-to-`F4 04` literal/high-byte bridge around `0x44/0x45/0x46/0x47/0x48/0x4A`, and
  `0x09AFBD-0x09B090` narrows into the next `F4 0D` literal-control family around
  `0x60/0x08/0x00/0x6C/0x12/0x0D/0x07` with shorter `0x05` and `0x65` variations. The loader path into the
  wider `0x099B00-0x09F776` command region is still unproven, so the labels stay structural.
- Tightened the middle `0x09C008-0x09E027` command window one step farther without forcing subsystem
  meaning. Fourteen more FF-terminated records in `src/bank080000_mid_command_tail_mid.asm` are now explicit
  `dc.b` data instead of raw `incbin` slices: the repeated-shape cluster at `0x09D981-0x09D9FE`, the second
  repeated-shape cluster at `0x09DBCC-0x09DC59`, and the neighboring singleton record at `0x09DE91-0x09DEA8`.
- The new proof is still byte-local but it sharpens a useful family pattern inside the mid command window.
  Both larger clusters repeat the same compact `F4/F1/F5`-style framing across adjacent `0x18`-byte records,
  then taper into shorter FF-terminated continuations with the same pair-heavy payload style; the later
  singleton at `0x09DE91` keeps the same framing even though its payload does not yet extend into a larger
  neighboring family.
- Kept the new labels structural. This pass makes one more opaque late-ROM command pocket readable in source,
  but the loader path and subsystem owner for the full `0x099B00-0x09F776` interpreter still need control-
  flow evidence before stronger names are safe.
- Tightened that same middle `0x09C008-0x09E027` command window again without forcing subsystem meaning.
  Three more longer FF-terminated records in `src/bank080000_mid_command_tail_mid.asm` are now explicit
  `dc.b` data instead of raw `incbin` slices: `0x09D9FF-0x09DA42`, `0x09DC5A-0x09DCD5`, and
  `0x09DEAF-0x09DF2A`.
- The new proof is still local byte structure, but the shared shape is clearer now. All three records open
  with compact `F6/F7/F0` setup ladders, walk dense local-target sequences through nearby `D0`/`D1`/`D2`/
  `FD` control bytes, and then fall into short literal or high-byte-pair payload pockets before their final
  `0xFF` terminators.
- Kept the names structural. This removes three more coarse slices from the still-opaque mid command window,
  but the controlling loader and concrete subsystem owner for the `0x099B00-0x09F776` interpreter remain open.
- Tightened the neighboring late-tail bridge in bank `0x080000` without forcing subsystem meaning. The former
  raw slices at `0x09E792-0x09E9A2` are now explicit `dc.b` records in
  `src/bank080000_mid_command_tail_tail.asm` instead of four incbin-backed FF-terminated records.
- The new proof is still local byte structure, but it raises the maturity of that pocket: `0x09E792` now
  reads as one longer local-target sweep that falls into repeated `0x9x/0xAx` high-byte ladders and several
  `E4`-tagged local-offset tails, `0x09E8CA` narrows into repeated `0x9F/0x9E` byte-pair rows with short
  `F5 FB` / `F5 05` variations, `0x09E926` returns to the familiar `CA/DF/FE` local-control sweep shape,
  and `0x09E963` follows with one denser literal/high-byte descent around the `0x48/0x4A/0x4B/0x4D` family.
- Kept the names structural. This pass removes another visible opaque bridge inside the `0x09E028-0x09F776`
  command tail, but the owning loader and subsystem meaning still need control-flow evidence before stronger
  names are safe.
- Tightened the next adjacent front-window pocket in bank `0x080000` without forcing subsystem meaning.
  `src/bank080000_mid_command_tail_front.asm` now source-authors the former raw `0x09B576-0x09B701`
  continuation as explicit `dc.b` records instead of eight `incbin` slices.
- That follow-up keeps the same structural command neighborhood but makes two more families easier to audit
  in source: `0x09B576-0x09B600` now stands as a compact `F4 02` literal-row ladder around
  `0x2D/0x34/0x2B/0x32` with a denser FA-gated variation and a short `0x34/0x32/0x31/0x2F/0x30`
  descent, while `0x09B601-0x09B701` now reads as a compact local-control bridge into an `F4 18`
  literal/high-byte ladder around `0x48/0x4A/0x4C/0x4D/0x4F`, two shorter literal-row continuations,
  and a small `F4 04` local-control handoff into `0x40/0x43/0x45/0x47/0x48/0x4A`.
- Kept the new labels structural. The loader path into the wider `0x099B00-0x09F776` command region is
  still unproven, so the new names stay anchored to byte-local behavior rather than subsystem guesses.
- Tightened the next adjacent front-window pocket in bank `0x080000` without forcing subsystem meaning.
  `src/bank080000_mid_command_tail_front.asm` now source-authors the former raw `0x09B702-0x09B8C6`
  continuation as explicit `dc.b` records instead of eight `incbin` slices.
- The new proof is still byte-local, but it makes another visible run inside the front command window easier to
  audit in source: `0x09B702-0x09B727` now stands as a short `F4 04` literal/high-byte ladder around
  `0x45/0x49/0x4A/0x4C/0x50/0x51` plus a tiny cap, `0x09B728-0x09B7C1` follows as a broader local-control
  bridge into a denser `0x4F/0x4D/0x4C/0x4A/0x48/0x47/0x45/0x43/0x41/0x40/0x3E` descent, `0x09B78D-0x09B7C1`
  narrows into one shorter `0x51/0x4C/0x53/0x48/0x4A` continuation with a tiny cap at `0x09B7BD`,
  `0x09B7C2-0x09B83D` now keeps a repeated `0x39/0x40/0x41/0x42/0x3B/0x3C/0x3D/0x3A` literal-row cycle explicit
  with two short `E2` local-offset hops, and `0x09B83E-0x09B8C6` closes as a compact local-control bridge into
  two `F4 04` literal-row ladders centered on `0x30/0x37/0x39/0x3C` and `0x32/0x35/0x3B/0x3E/0x40/0x41/0x43`.
- Kept the names structural. This removes another contiguous opaque pocket from the `0x09A348-0x09C007` front
  command window, but the controlling loader and subsystem meaning still need control-flow evidence before
  stronger names are safe.
- Tightened the next neighboring late-tail pocket in bank `0x080000` without forcing subsystem meaning. The
  former raw slices at `0x09E9E7-0x09ECD5` are now explicit `dc.b` records in
  `src/bank080000_mid_command_tail_tail.asm` instead of sixteen incbin-backed FF-terminated records.
- The new proof is still local byte structure, but it makes another visible command family readable in source:
  `0x09E9E7` continues the same `F4 1B` literal/high-byte ladder neighborhood, `0x09EA5F` and `0x09EBDB`
  each revisit compact local-control sweeps before short pair or literal tails, `0x09EAA0-0x09EAEA` now stand
  explicitly as one short `F4 1F` high-byte ladder family, `0x09EB07-0x09EB41` collapse into a compact
  literal-descent run, `0x09EB51` and `0x09EB99` expose two denser literal/high-byte pockets, and
  `0x09EC4A-0x09EC93` close with tiny literal/control rows plus one alternating local-control bridge.
- Kept the names structural. This removes one more opaque late-tail bridge inside the `0x09E028-0x09F776`
  command window, but the controlling loader and subsystem meaning still need control-flow evidence before
  stronger names are safe.
- Tightened the next late-tail bridge in that same bank `0x080000` command window without forcing subsystem
  meaning. The former raw slices at `0x09ECD6-0x09EFD2` are now explicit `dc.b` records in
  `src/bank080000_mid_command_tail_tail.asm` instead of twenty-two incbin-backed FF-terminated records.
- The new proof is still local byte structure, but the pocket is materially clearer now: `0x09ECD6-0x09ED19`
  stands as one compact repeated `0x2D/0x2E` literal-pair family under the same `F4 F8` framing,
  `0x09ED1A`, `0x09ED4A`, `0x09EDE4`, `0x09EECB`, `0x09EF09`, `0x09EF52`, and `0x09EF81` each expose short
  local-control or local-target setup bridges before literal or high-byte tails, `0x09ED7D-0x09EDDA` and
  `0x09EE27-0x09EE4D` make adjacent `F4 04` / `F4 08` literal-plus-high-byte ladders explicit, and
  `0x09EE81-0x09EE9A` narrows into a tiny local-offset-seeded `0x2D` pair pocket.
- Kept the names structural. This removes another visible opaque bridge in the late command tail, but the
  controlling loader and subsystem meaning still need control-flow evidence before stronger names are safe.
- Tightened one more adjacent pocket in the bank `0x080000` mid command window without forcing subsystem
  meaning. The former raw slices at `0x09DFB4-0x09E027` are now explicit `dc.b` records in
  `src/bank080000_mid_command_tail_mid.asm` instead of two incbin-backed FF-terminated records.
- The byte proof is still local, but the family is clearer in source now: both records keep the same compact
  `F4 08` framing as the neighboring high-byte ladder pocket at `0x09DF2B`, the first stays in short
  `0xAC/0xAB/0xAA` to `0xA7/0xA5/0xA4/0xA3/0xA0` pair sweeps with repeated `F5 FB` pivots, and the second
  shifts into a denser descending `0xA7/0xA5/0xA3/0xA1/0xA0/0x9E/0x9C/0x9B` tail before the terminator.
- Kept the names structural. This removes two more raw slices from the `0x09C008-0x09E027` command window,
  but the controlling loader and subsystem meaning still need control-flow evidence before stronger names are
  safe.
- Tightened the front edge of the `0x09E028-0x09F776` tail command window again without forcing subsystem
  meaning. The former raw slices at `0x09E237-0x09E384` are now explicit `dc.b` records in
  `src/bank080000_mid_command_tail_tail.asm` instead of ten incbin-backed FF-terminated records.
- The byte proof is still local, but the neighboring family is materially clearer now: `0x09E237` opens with
  another short local-control sweep before climbing through a `0x4F/0x51/0x52/.../0x5B` literal band,
  `0x09E264-0x09E2C0` collapse into one descending `AF/AE/AD` high-byte-pair family plus two short AC-rooted
  local-offset variants, `0x09E2C1` returns to a broader local sweep before walking a longer descending
  `0x57..0x4A` literal/high-byte ladder, and `0x09E302-0x09E384` narrow into short AA/A9/A8, A7, and literal-band
  tails under the same compact `F4 08` framing.
- Kept the names structural. This removes another visible opaque pocket from the late command tail, but the
  controlling loader and subsystem meaning still need control-flow evidence before stronger names are safe.
- Tightened another visible pocket inside the same bank `0x080000` middle command window without forcing
  subsystem meaning. The former raw slices at `0x09CBEE-0x09CFBC` are now explicit `dc.b` records in
  `src/bank080000_mid_command_tail_mid.asm` instead of thirty incbin-backed FF-terminated records.
- The byte proof is still local, but the neighboring families are materially clearer now: `0x09CBEE-0x09CC00`
  keep one short `F4 00` literal-control pair explicit, `0x09CC16-0x09CCEC` now stand as three broader setup
  bridges that fall into a low-byte ladder, a mixed literal/high-byte pocket, and a `0x6D/0x6C` literal-
  control burst, `0x09CD3C-0x09CD8D` expose a local-seeded literal row plus compact `F4 14` ladders and tiny
  cap records, `0x09CD90-0x09CE48` widen into a short same-window sweep and a neighboring `F4 14` literal /
  high-byte ladder family, `0x09CE49-0x09CEF2` collapse into a compact `F4 1A` low-byte ladder run, and
  `0x09CEF7-0x09CF77` return to a broader local-target sweep before a final local-control-to-literal-row bridge.
- Kept the names structural. This removes another high-visibility opaque run from the mid command window, but
  the controlling loader and subsystem meaning still need control-flow evidence before stronger names are safe.
- Tightened the next adjacent middle-window pocket in that same bank `0x080000` command body without forcing
  subsystem meaning. The former raw slices at `0x09CFBD-0x09D341` are now explicit `dc.b` records in
  `src/bank080000_mid_command_tail_mid.asm` instead of nineteen incbin-backed FF-terminated records.
- The byte proof is still local, but the neighboring families are materially clearer now: `0x09CFBD-0x09D093`
  now stand as one denser `F4 F0` literal-row cycle followed by a compact `F4 20` row-family pocket,
  `0x09D098-0x09D1C6` expose a broader setup bridge into mixed `0x3C/0x3E/0x40/0x41/...` literal rows, one
  neighboring `0xAC/0xAA/0xA8/.../0xA1` high-byte ladder, and a later repeated literal-row descent, and
  `0x09D240-0x09D330` now make one short literal-control family plus a repeated `F4 FC` pair-ladder cluster
  explicit immediately before the already split `0x09D342+` continuation.
- Kept the names structural. This removes another contiguous opaque run from the mid command window, but the
  controlling loader and subsystem meaning still need control-flow evidence before stronger names are safe.
- Tightened the next adjacent middle-window pocket in that same bank `0x080000` command body without forcing
  subsystem meaning. The former raw slices at `0x09D342-0x09D5BE` are now explicit `dc.b` records in
  `src/bank080000_mid_command_tail_mid.asm` instead of fifteen incbin-backed FF-terminated records.
- The byte proof is still local, but the neighboring families are materially clearer now: `0x09D342-0x09D40F`
  continue the same `F4 FC` repeated-pair ladder neighborhood with two broader row cycles, one mixed bridge,
  and one shorter `0x30/0x2B/0x37/0x39/0x35` tail; `0x09D429-0x09D464` now expose the compact local-target setup
  that feeds the next pocket; and `0x09D48A-0x09D5A9` now keep one compact `F4 2C` high-byte family explicit
  around `0x9E/0x9C/0x9B`, `0x99/0xA0/0x9E`, and a later `0x95/0x97/0x9C` to `0xAC/0xAA/0xA8/0xA6/0xA5/0xA3`
  tail before two tiny literal ladders at `0x09D594` and `0x09D5A9`.
- Kept the names structural. This removes another contiguous opaque run from the mid command window, but the
  controlling loader and subsystem meaning still need control-flow evidence before stronger names are safe.
- Tightened that same middle `0x09C008-0x09E027` command window once more without forcing subsystem meaning.
  The former raw slices at `0x09C008-0x09C0D6` and the two tiny tails at `0x09DEA9-0x09DEAE` are now explicit
  `dc.b` records in `src/bank080000_mid_command_tail_mid.asm` instead of six incbin-backed FF-terminated records.
- The new proof is still byte-local, but it makes both exposed edges of the current mid-window body read more
  cleanly in source. `0x09C008-0x09C044` now stands as a compact repeated `0xA2/0x43` high-byte pair family,
  `0x09C045-0x09C069` narrows into a shorter repeated `0x9F/0x42` ladder with one `0xA0/0x43` tail,
  `0x09C06A-0x09C096` widens into an `0xA3/0x9C` to `0x9F/0x98` descending pair ladder, and
  `0x09C097-0x09C0D6` follows as a denser mixed continuation that revisits the same anchor family before the
  already explicit `0x09C0D7+` local-control bridge. The late singleton tails at `0x09DEA9` and `0x09DEAC`
  are now also visible as the same tiny `C8 FA FF` and `CA FA FF` caps that close the neighboring pocket.
- Kept the names structural. This removes the last raw `incbin` slices from `src/bank080000_mid_command_tail_mid.asm`,
  so the whole `0x09C008-0x09E027` middle command window is now source-visible as explicit FF-terminated records
  even though the owning loader and subsystem are still unresolved.
- Tightened the next remaining front-window pocket in bank `0x080000` without forcing subsystem meaning.
  The former raw `0x09B8C7-0x09BFCF` run in `src/bank080000_mid_command_tail_front.asm` is now source-authored as
  forty-six explicit FF-terminated records instead of forty-six `incbin` slices.
- The new byte-level proof keeps the same structural command vocabulary but removes most of the remaining blind spots in
  `0x09A348-0x09C007`. `0x09B8C7-0x09B95F` now reads as a compact `F4 04` literal-row neighborhood around
  `0x30/0x37/0x39/0x3C`, then a broader `0x39/0x40/0x48/0x47/0x45/0x43` sweep with two short tails at
  `0x09B947` and `0x09B95F`; `0x09B978-0x09BA55` resolves into a local-control bridge plus repeated
  `0x07/0x12/0x72/0x09` literal-control rows with `0x60/0x65/0x67/0x6C/0x6D/0x6E` pivots; `0x09BA70-0x09BB0C`
  shifts into a short `F4 07` literal-row family around `0x28/0x34/0x35/0x38/0x39/0x3B/0x32/0x30/0x2F/0x2D`;
  `0x09BB29-0x09BE0E` broadens into several `F4 1B` literal/high-byte pockets around `0xA0/0x48`,
  `0x47/0x48/0x4B/0x4C`, `0xA8/0x4D`, and the recurring `0x40/0x41/0x44/0x45/0x47/0x4A/0x4D/0x50` descent;
  and `0x09BE13-0x09BFCF` closes with one more local-control handoff into compact `F4 00` literal-control and
  literal-row families around `0x0C/0x0D/0x0E/0x0F/0x05`, `0x24/0x2A/0x2B`, `0x30/0x2B/0x27`, and
  `0x3C/0x3B/0x3A/0x38`.
- Kept the names structural. This leaves only the tiny front `0x09A348-0x09A3EB` lead-in as raw `incbin` coverage in
  `src/bank080000_mid_command_tail_front.asm`, while the rest of the front command window is now explicit source-owned
  FF-terminated record data pending loader/consumer proof.
- Tightened that final front-window lead-in in bank `0x080000` too, again without forcing subsystem meaning.
  The former raw `0x09A348-0x09A3EB` run in `src/bank080000_mid_command_tail_front.asm` is now source-authored as six
  explicit FF-terminated records instead of six `incbin` slices.
- The new byte-level proof is still structural, but it finishes the front command window cleanly: `0x09A348-0x09A34C`
  is now one tiny tuple lead-in, `0x09A34D-0x09A360` is a compact local-control prelude, `0x09A361-0x09A3D1`
  resolves into the first broader `F4 25` high-byte pair pocket around `0x97/0x99/0x95` then
  `0xA0/0x9A/0xA1/0x9C`, and `0x09A3D2-0x09A3EB` closes as two short `0x9E/0xA0` pair tails immediately before the
  already explicit repeated-byte-pair record at `0x09A3EC`.
- Kept the names structural. This removes the last raw `incbin` slices from
  `src/bank080000_mid_command_tail_front.asm`, so the whole `0x09A348-0x09C007` front command window is now
  source-visible as explicit FF-terminated records even though the owning loader and subsystem are still unresolved.

- Tightened another adjacent bridge in bank `0x080000`'s `0x099B00-0x09A347` pre-window command front without
  forcing subsystem meaning. `src/bank080000_mid.asm` now source-authors the former raw `0x099F24-0x09A10D`
  continuation as explicit tuple-led and FF-terminated subrecords instead of seventeen `incbin` slices.
- The new byte proof keeps the same structural command vocabulary but makes the late half of the front table much
  easier to audit in source: `0x099F24-0x099FDA` now reads as repeated tuple headers feeding compact control bodies,
  `0x099FFA-0x09A01D` exposes another shared bridge where the `0x09A010` tuple and `0x09A015` setup bytes belong to
  the following `0x09A01E` target, `0x09A02B-0x09A08D` narrows into several short tuple-plus-control records, and
  `0x09A0D6-0x09A10D` ends with two more explicit lead-outs into the already source-authored compound record at
  `0x09A10E`.
- Kept the labels structural. This removes another visible raw pocket from `src/bank080000_mid.asm`, but the loader
  path and concrete subsystem owner for the wider `0x099B00-0x09F776` command region still need control-flow proof.

- Tightened the very front of that same bank `0x080000` command region without forcing subsystem meaning.
  `src/bank080000_mid.asm` now source-authors the former raw `0x099BB0-0x099D04` stretch as explicit tuple-led,
  FF-terminated, and FD-bridged subrecords instead of ten `incbin` slices.
- The new source pass makes the opening command-table cadence much clearer in ROM order: the unreferenced prelude at
  `0x099BB0-0x099BD2` now stands as one lead byte, one tuple-led setup record, and one short bridge into the first
  table-targeted command; `0x099BD3-0x099C8E` then resolves into a repeated family of tuple-style FF-terminated
  headers plus compact FF-terminated control bodies with short `FD xxxx` hand-offs into the next targets.
- The later `0x099C8F-0x099D04` pocket is also cleaner now: `0x099C8F` keeps one tuple plus a denser control body
  with two `E2`-tagged payload pockets, `0x099CB5` and `0x099CDC` are now explicit tuple-led records with compact
  `F5/FE` tails, and `0x099CFE-0x099D04` ends as one short tuple-led bridge whose trailing `F6 02` bytes feed the
  already source-authored `0x099D05` target.
- Kept the labels structural. This removes the last early `incbin` pocket ahead of `0x099D05`, but the loader path
  and concrete subsystem owner for the wider `0x099B00-0x09F776` command region still need control-flow proof.

- Tightened the remaining lead-in at the front of bank `0x080000`'s `0x099B00-0x09A347` command table without
  forcing subsystem meaning. `src/bank080000_mid.asm` now source-authors the former raw `0x099B00-0x099B31`
  pocket as an explicit structural word band instead of one last `incbin` slice.
- The byte-level proof is still conservative: those 25 big-endian words continue to read best as a pre-table
  lead-in that the following `0x099B32-0x099BAF` offset list can target back into, but the range is now directly
  auditable in source instead of hidden behind raw coverage.
- Kept the labels structural. This removes the last raw `incbin` coverage from the full
  `0x099B00-0x09A347` pre-window command front, leaving that entire command-front span source-visible in ROM order
  while the owning loader and subsystem remain open questions.

- Promoted that same `0x099A85-0x09A347` front command ownership into its own ROM-order module,
  `src/bank080000_mid_command_front.asm`, instead of keeping the zero fill, lead-in words, offset table,
  and pre-`0x09A348` command records inside the broader `src/bank080000_mid.asm` catch-all.
- This is a structural ownership cleanup rather than a semantic rename: the bytes still only prove a dedicated
  command-front slice, not the final subsystem owner, but the bank now reads more like a maintained disassembly
  with separate owners for the Z80 program front, pre-descriptor records, descriptor/layout tables, command front,
  and later FF-terminated command windows.

- Tightened the front of that same bank `0x080000` Z80-program owner without forcing a sound-driver guess.
  `src/bank080000_mid_z80_program.asm` now source-authors `0x098000-0x09803A` as explicit bytes instead of four
  tiny `incbin` slices.
- The front control flow is unchanged but easier to audit in source: `0x098000` remains the reset-style `DI` / `IM 1`
  / `JP $003B` entry, `0x098006` is the short returning front stub, `0x098010-0x09801F` stays one mixed stub pocket,
  `0x098020`, `0x098028`, and `0x098030` are now explicit repeated absolute `JP $0F8C` stubs, and `0x098038` is the
  tiny `NOP` / `RETI` handler before the still-incbin-backed main body at `0x09803B`.
- Updated the ROM and symbol/function indexes to match that stronger split so the tail-bank island now exposes its
  proven Z80 front stub boundaries in machine-readable form as well as source.

- Tightened the first opaque slice inside that same Z80 program main body without forcing a subsystem guess.
  `src/bank080000_mid_z80_program.asm` now exposes `0x098275-0x0982B9` directly in source instead of leaving the
  whole `0x09803B-0x09907A` region behind one `incbin`.
- The new split is structurally stronger than a blind byte dump: `0x098275-0x098280` is now explicit as a
  six-entry little-endian jump table for raw command bytes `$FF..$FA`, because the preceding code at
  `0x0981C5-0x0981D0` complements those values and doubles them into this table before `JP (HL)`.
- Three of those targets are now cleaner too. `0x098282` is a tiny standalone `$FB` handler, while `0x098288`
  and `0x09829C` differ only in which inline 3-byte table they load (`0x09828D` or `0x0982B1`) before the shared
  initialization tail at `0x09829F-0x0982B0` stores the chosen table base, clears the active cursor words, and
  sets the mode byte at `0x1C09`.
- Kept the remaining dispatch targets at `0x0982BA`, `0x0982E2`, and `0x098369` incbin-backed for now. The jump-
  table ownership is proven, but the concrete subsystem meaning of those handlers and the two inline 3-byte record
  families is still unresolved without the wider loader/driver path.

- Tightened that same Z80 main-body frontier again through `0x098392`. The former opaque targets at `0x0982BA`,
  `0x0982E2`, and `0x098369` are now source-visible as slot-scanning helpers instead of three undifferentiated
  `incbin` ranges.
- `0x0982BA-0x0982E1` now reads as the `$FC` meta-command target: it walks ten `0x20`-byte records rooted at
  `0x1EC0`, clears the local counter byte at `0x1C07`, calls the shared helper at `0x02FA` for active entries whose
  byte at `+0x10` also has bit 7 set, and finally sets bit 0 in `0x1C03`.
- `0x0982E2` is now explicit as a tiny `$FD` target that clears that same bit 0, and `0x0982E8-0x0982F9` is now a
  reusable helper that converts the current `IX` pointer into a packed slot index relative to the `0x1EC0` base.
- Three adjacent non-dispatch helpers are now explicit too: `0x0982FA-0x098320` scans `0x1C80` in `0x40`-byte steps
  and calls `0x0446` when an active record's byte at `+0x06` matches the packed slot index; `0x098321-0x098344`
  drains active `0x1EC0`-rooted slots whose `+0x10` byte has bit 7 set; and `0x098345-0x098368` drains active slots
  whose `+0x10` byte matches the selected byte at `0x1C28`.
- `0x098369-0x098392` is now explicit as the `$FF` meta-command target: it retires every active `0x1EC0`-rooted
  slot via `0x02FA`, then clears the nearby state words/bytes at `0x1C2A`, `0x1C09`, and `0x1C0B`. The unresolved
  Z80 main-body continuation now starts later at `0x098393`.

- Tightened that same Z80 main-body frontier again through `0x098443` without forcing a subsystem guess.
  `src/bank080000_mid_z80_program.asm` now source-authors the next routine/table/helper bridge instead of leaving
  it inside the post-`0x098393` incbin.
- `0x098393-0x098403` now reads as a masked candidate selector across three 0x40-byte record banks. The routine uses
  an even-valued selector byte at `0x1C20` to index the new 3-byte descriptor table at `0x098404`, masks `0x1C21`
  against the chosen bank-local active-bit mask, then walks the selected records in 0x40-byte steps until it either
  finds the best active candidate or returns without dispatching.
- The new descriptor table at `0x098404-0x09840C` is now explicit in source as three compact
  `[little-endian record base][active-bit mask]` entries for the families rooted at `0x1C80`, `0x1E00`, and `0x1E80`
  with masks `0x3F`, `0x07`, and `0x01` respectively.
- `0x09840D-0x098435` is now explicit as a neighboring scan over the `0x1C80` family: it compares the current
  `0x1C07` selector plus the `((IX+0x12) - (IX+0x13))` packed delta against bytes `+6/+7` in each active 0x40-byte
  record and returns early when it finds a match.
- `0x098436-0x098445` is now explicit as a small helper that packs the current `IX` pointer into a 0x40-byte record
  index relative to the `0x1C80` base. The unresolved Z80 main-body continuation now starts later at `0x098446`.

- Tightened that same Z80 main-body frontier again through `0x0984B0` without forcing a subsystem guess.
  `src/bank080000_mid_z80_program.asm` now source-authors the next post-selector helper instead of leaving
  it inside the `0x098446+` incbin.
- `0x098446-0x098468` now calls the shared helper at `0x0436`, stores one local selector byte at `0x1C11`,
  and for the low six-value case also splits a doubled low-bit flag into `0x1C10` before branching on `(IX+1)`.
- `0x098469-0x09848B` then exposes two direct finalize/update paths for `(IX+1) >= 2`: the equal case writes
  `0x78` to the IX-local byte at `+0x29`, derives a `0x9F`-based output byte from `0x1C11`, and stores it to
  `0x7F11`, while the greater-than case uses the nearby latch at `0x1C13` and a fixed `0xFF` write to that same
  destination before clearing the active slot.
- `0x09848C-0x0984B0` is now explicit as the `<2` path: it feeds four fixed `B` values (`0x80`, `0x84`, `0x88`,
  `0x8C`) plus `C = 0xFF` through the shared helper at `0x06C8`, conditionally calls `0x06E2` when bit 1 of the
  IX-local status byte is clear, and then retires the current slot.
- The unresolved Z80 main-body continuation now starts later at `0x0984B1`.

- Tightened that same Z80 main-body frontier again through `0x098535` without forcing a subsystem guess.
  `src/bank080000_mid_z80_program.asm` now source-authors the next pair of lookup helpers plus a small threshold
  classifier instead of leaving them inside the post-`0x0984B1` incbin.
- `0x0984B1-0x098515` now stands explicitly as two neighboring helper variants that derive a small table index from
  the high nibbles of `D/E` plus the incoming `HL` base, read one local 3-byte record, and fold the residual through
  two rounded halves before returning an adjusted `DE` pair. The only proven difference so far is which loaded byte is
  subtracted before the first halving step.
- `0x098516-0x09853B` now reads as a compact high-byte threshold classifier: values `>= 0x60` take a fixed return
  path, while lower values peel through `0x30`, `0x18`, and `0x0C` cutoffs, accumulate a small band id in `C`, and
  leave the reduced high-byte remainder in `D`.
- The unresolved Z80 main-body continuation now starts later at `0x09853C`.

- Tightened that same Z80 main-body frontier again through `0x09867B` without forcing a subsystem guess.
  `src/bank080000_mid_z80_program.asm` now source-authors the next output-emission and row-update band instead of
  leaving it inside the post-`0x09853C` incbin.
- `0x09853C-0x098578` now stands explicitly as a nonzero-mode output emitter: after refreshing an IX-local cached
  target word through the new `0x0985A3` helper, it combines the descending odd-aligned table at `0x09913D` with the
  already split bucketizer/lookup helpers at `0x098516` and `0x0984E4` to write two encoded bytes to `0x7F11`.
- `0x098579-0x09859A` is a neighboring zero-mode variant that instead uses `0x1C11 + 0xA4`, the ascending odd-aligned
  table at `0x09907B`, and two calls to `0x06CD` before tail-jumping into the same local output path.
- `0x09859B-0x0985B9` now exposes the masked-target refresh glue around those emitters: `0x09859B` compares a low-byte
  value rounded down to an 8-byte boundary against `HL`, and `0x0985A3` only copies the IX-local source word at
  `+0x08/+0x09` into the cached target word at `+0x0A/+0x0B` when that rounded pair changes.
- `0x0985BA-0x098615` is now explicit as an indexed output-band updater keyed by `(IX+1)-2`: the equal and greater-than
  paths clamp one IX-local accumulator around `+0x28/+0x29`, cache the last emitted band in `0x1C13`, and emit one
  encoded byte to `0x7F11`.
- `0x098616-0x09867B` now exposes the `<2` path too: it resolves an 8-entry table from the low three bits of
  `(IX+0x24)`, walks four IX-local rows in 3-byte steps, conditionally updates each cached row byte, and emits row-
  specific updates through `0x06C7` while using `0x1C08` as a local clamp/ceiling byte.
- The unresolved Z80 main-body continuation now starts later at `0x09867C`.

- Tightened that same Z80 main-body frontier again through `0x09875A` while keeping the owner structural.
  `src/bank080000_mid_z80_program.asm` now source-authors the next descriptor-expansion / latched-output / active-
  record sweep band instead of leaving it inside the post-`0x09867C` continuation.
- `0x09867C-0x0986E1` now reads as an indexed 4-byte descriptor expander: it stores the incoming selector in `0x1C12`,
  conditionally mirrors one literal source byte, then uses the next stream byte as an index into the 4-byte table at
  `0x164B`; changed bytes are emitted through the shared helper at `0x06C3` with `B=$30/$50/$60/$70`, and the final
  byte is cached into the `0x4000` page selected by `0x1C10`.
- `0x0986E2-0x09870A` is a neighboring latched-output writer: it combines the incoming `A` value with selector bytes
  `0x1C10/0x1C11`, forces bit 2 of the second output byte from bit 1 of `0x1C10`, and writes the resulting pair to
  `0x4000/0x4001`, falling back to the shared `0x06F7` path when `0x4000` is already negative.
- `0x09870B-0x098755` now sweeps the active `0x1C80`-rooted `0x40`-byte records while cycling `0x1C10/0x1C11`; each
  active record calls the shared helper at `0x0756`, IX advances by `0x40`, and the local counter at `0x1BF6` tracks
  progress through the sweep.
- Tightened that same Z80 main-body frontier again through `0x098771` by correcting and extending the next gate-owned
  dispatch prelude.
- The former five-byte split at `0x098756` was one byte short: the trailing `0x20` is a `JR NZ` opcode whose displacement
  byte is `0x16` at `0x09875B`, so `0x098756-0x09875B` is now explicit as a six-byte bit-6 gate on the IX-local flags
  byte that skips ahead to `0x098772` when the bit is already set.
- The fallthrough `0x09875C-0x098771` path is now source-visible too: it sets that same bit, pushes `0x0772` as a
  local return target, and dispatches on `(IX+1)-2` to three deeper handlers at `0x0A08`, `0x0AB2`, and `0x0AA9`.
- The remaining opaque Z80 main-body continuation now starts later at `0x098772`.

- Tightened that same Z80 main-body frontier again through `0x098975` while keeping the owner structural.
  `src/bank080000_mid_z80_program.asm` now source-authors the next paired stream-state bridge instead of leaving it
  inside the post-`0x098772` continuation.
- `0x098772-0x098865` now reads as a primary stream/state updater over one IX-local control block: bytes below `$F8`
  load a countdown plus delta word, while `$FF` reloads HL from the stream, `$FE/$FD` manage a nested countdown plus
  saved pointer, `$FC` subtracts the current delta word, `$FB` reloads that delta word, and `$FA/$F9` clear or reload
  local counters before the shared state store at `0x098865`.
- `0x09886E-0x0988A0` then conditionally applies the extra IX-local offset word at `+0x1A/+0x1B` to the working base
  cached at `0x0C/0x0D` when bit 4 is set in the IX-local flags byte.
- `0x0988A1-0x0988CD` now resolves a secondary target word into `+0x08/+0x09`: when `0x3F` is nonzero it calls the
  helper at `0x0B66` to derive a signed base step, repeatedly doubles that step `B` times, then adds the current base
  plus the fixed `+0x26/+0x27` offset.
- `0x0988CE-0x098961` mirrors the same command-driven pattern for a secondary stream with a slightly smaller control
  range: `$FF` reloads HL, `$FE/$FD` manage a saved pointer/countdown pair, `$FC` subtracts the current step byte,
  `$FB` reloads that byte, and `$FA/$F9` clear or reload the local counters.
- `0x098962-0x098975` now stands as the shared post-update dispatch: nonzero `(IX+1)` first routes through `0x0976`,
  then a bit-7 gate on the IX-local flags byte decides whether the deeper `0x053C -> 0x05BA` path should run.
- The remaining opaque Z80 main-body continuation now starts later at `0x098976`.

- Tightened that same Z80 main-body frontier again through `0x098B7E` while keeping the owner structural.
  `src/bank080000_mid_z80_program.asm` now source-authors the next post-dispatch bridge instead of leaving the full
  `0x098976+` continuation opaque.
- `0x098976-0x098A07` now reads as another IX-local countdown/pointer updater: it advances the local `+0x2C` timer,
  reloads bytes from the pointer at `+0x2A/+0x2B` when the timer expires, peels the fetched control byte into a low-
  nibble countdown plus an upper-band value at `+0x30`, and then refreshes the derived byte at `+0x28` from that band
  plus the existing `+0x1C` state.
- `0x098A08-0x098AA8` is now explicit as dispatch target `0x0A08`: it indexes the fixed 19-byte bank-local record
  family rooted at local `0x1281` (ROM `0x099281`), mirrors changed bytes through `0x06C8` with `B=$B0/$B4`, calls the
  fixed-output helper at `0x067C`, then walks four triplet-spaced rows through `0x0667` / `0x06C7` before returning
  via `0x06E2`.
- `0x098AA9-0x098AB1` is now explicit as a tiny fixed-output prelude that seeds `+0x29` with `0x78`, writes `0xDF` to
  `0x7F11`, and falls straight into the next initializer at `0x098AB2`.
- `0x098AB2-0x098B5A` is now source-visible as dispatch target `0x0AB2`: it seeds several IX-local state fields from
  compact bank-local records rooted at local `0x1828`, `0x188F`, `0x1901`, and `0x19D8`, clears or initializes the
  paired primary/secondary stream state bytes, then uses the helper at `0x0B5B` before writing literal byte `0x32` and
  returning.
- Two tiny helpers are now explicit too: `0x098B5B-0x098B65` returns `HL = 0x1BF7 + [0x1BF6]`, and `0x098B66-0x098B7E`
  repeatedly doubles/accumulates that indexed scratch byte, adds `0x7F`, stores it back, and returns.
- The remaining opaque Z80 main-body continuation now starts later at `0x098B7F`, which is a cleaner next frontier
  because the next unresolved chunk is no longer mixed with this closed dispatch-owned bridge.

- Tightened that same Z80 main-body frontier again through `0x098CA4` while keeping the owner structural.
  `src/bank080000_mid_z80_program.asm` now source-authors the next slot-driven bridge instead of leaving the full
  `0x098B7F+` continuation opaque.
- `0x098B7F-0x098B9B` now sweeps ten `0x1EC0`-rooted `0x20`-byte slot records, increments the shared counter at
  `0x1C07`, and calls the neighboring updater only for active entries whose flags byte at `+0x00` still has bit 7 set.
- `0x098B9C-0x098CA4` now advances one marked slot record: when bit 6 is still clear it seeds several countdown/state
  bytes, preserves only the low bit of `(IX+0x11)`, decrements the slot-local word at `+0x02/+0x03`, reloads the
  pointed stream at `+0x06/+0x07` on expiry, snapshots the local base word into `0x1C18/0x1C19`, then dispatches on
  the next control byte. Bytes `>= 0xE0` jump through the local handler table at `0x0E62`, `0xD0-0xDF` route through
  helper `0x0E55`, `0xC0-0xCF` use the compact table at `0x0E35` to synthesize a triple-scaled word, and all lower
  values route through helper `0x0CA5` before the accumulated state is folded back into the slot.
- The remaining opaque Z80 main-body continuation now starts later at `0x098CA5`, which leaves the next pass focused on
  the downstream local-handler table and its slot-state consumers rather than this now-closed marked-slot bridge.

- Tightened that same Z80 main-body frontier again through `0x098F8B` while keeping the owner structural.
  `src/bank080000_mid_z80_program.asm` now source-authors the next marked-slot continuation instead of leaving the full
  `0x098CA5+` range opaque.
- `0x098CA5-0x098D80` now initializes one `IY`-local record from the current `IX` slot via two front paths: one path
  uses the incoming A value to index a 6-byte descriptor family rooted at local `0x19F1`, while the alternate path
  seeds state from the `IX`-local base word and reuses the candidate-selection helpers at `0x040D` / `0x0446`.
- `0x098D81-0x098E12` now closes that bridge with a shared IY-record initializer: it stores the working base word,
  calls the local helper at `0x0E1B`, derives countdown bytes at `+0x3C/+0x3D`, mirrors slot id/counter fields into
  the new record, then commits the initialized `IY` record and advances the surrounding slot counters.
- `0x098E1B-0x098E61` is now explicit as the support band for that bridge: a two-page mode table reader at `0x098E1B`,
  a 16-byte low-nibble scale table at `0x098E35`, a triplet-write pointer helper at `0x098E45`, and a triplet append
  helper at `0x098E55` that stores `[lo][hi][tag]` into the `IX+0x14` write area.
- `0x098E62-0x098F8B` now exposes the high-command dispatch family used by the marked-slot updater. The 32-entry
  little-endian table at `0x098E62` routes raw command bytes `$E0..$FF` to local handlers; the `0xE0-0xE4` handlers
  load or combine inline bytes/words into `IX`-local state and the cached stream pair at `0x1C14/0x1C15`; `0xF0-0xF9`
  write or patch slot-local mode/count/state bytes; and `0xFA-0xFF` now stand explicitly as a mix of helper trampolines,
  slot-retire paths, and a backward triplet walker over the `IX+0x14` area.
- The remaining opaque Z80 main-body continuation now starts later at `0x098F8C`, leaving the next pass focused on the
  state-save / loader-owned tail before the odd-aligned lookup tables at `0x09907B+`.
- Tightened that same Z80 main-body frontier again through `0x09907A` while keeping the owner structural.
  `src/bank080000_mid_z80_program.asm` now source-authors the former `0x098F8C-0x09907A` incbin as a state-snapshot /
  transfer-handshake routine reached by the repeated jump stubs at `0x098020`, `0x098028`, and `0x098030`.
- `0x098F8C-0x098FBF` now stands explicitly as the register snapshot prologue: it stores the primary `BC/DE/HL`, `IX`,
  `IY`, popped return address, `SP`, primary `AF`, alternate `AF'`, and alternate `BC'/DE'/HL'` into the `0x1B80+`
  save area before the transfer phase begins.
- `0x098FC0-0x098FEF` then copies out three variable-length transfer slots described by
  `[target word][length byte][local mirror bytes]` at `0x1BA0/0x1BA2/0x1BA3`, `0x1BA8/0x1BAA/0x1BAB`, and
  `0x1BB0/0x1BB2/0x1BB3`; `0x098FF6-0x099003` raises the handshake flags at `0x1B98/0x1B99` and busy-waits until an
  external owner clears `0x1B99`.
- `0x099004-0x09905D` now reads as the return half of the same handshake: each nonempty transfer slot is copied back
  into its local mirror and its destination region is stamped with `E7`, `EF`, or `F7` plus zero fill. The tail at
  `0x09905E-0x09907A` restores the saved primary subset plus the return address and drops `0x1B98` before returning;
  `IX/IY` and the alternate register set are only snapshotted here, not restored by this local tail.
- That closes the last incbin inside the `0x098000-0x0991FF` front Z80 slice. The remaining uncertainty in this owner is
  now higher-level rather than structural: the wider loader path, the exact role of the `0x1B98/0x1B99` handshake flags,
  and the subsystem meaning of the transfer slots plus the odd-aligned lookup tables still need a stronger caller-side fit.

- Split the full tail region `0x02482C-0x03FFFF` (112,596 bytes) into 11 named sections in
  `src/bank020000_tail_blocks.asm`, replacing the single opaque `incbin`:
  - `Bank020000_TailOffsetTable_02482C` (10 bytes): 4-entry relative-offset table, offsets
    0x0016/0x007A/0x00EA/0x015E pointing into Block 1's RLE payload, terminated by 0xFF7B sentinel.
  - `Bank020000_TailGfxBlock1_024836` – `Bank020000_TailGfxBlock9_034AEC`: 9 RLE/compressed-graphics
    blocks, each terminated by 0xFF7B. Sizes range from 116 bytes (Block 6) to 18,587 bytes (Block 4).
    Blocks 1-4 use a `0xXX60`/`0xXX6Y` header byte pattern; Blocks 5-7 share the `0x0F03...` header
    pattern; Block 8 uses `0xC0FB...`. The 0x52, 0x4A, 0x5A byte values within payloads are RLE
    opcodes consistent with Mega Drive tile/sprite compressed graphics formats.
  - `Bank020000_TailRemainder_035078` (44,936 bytes): remaining tail not yet further subdivided;
    contains additional RLE blocks (some terminated by 0xFF7A) and further structured records.
  - Build verified bit-perfect (SHA256 matches) and all `node tools/run_checks.js` checks pass.

- Key structural discovery: the 0xFF7B byte pattern is the block terminator for RLE graphics blocks
  in bank 020000's tail, not merely an offset-table sentinel. The first 0xFF7B at 0x024834 IS the
  offset table's end-of-table sentinel; the subsequent 0xFF7B occurrences mark the ends of individual
  compressed graphics blocks. A second terminator variant 0xFF7A also occurs within the tail remainder
  (9 occurrences at 0x02CF1A, 0x02D91E, 0x032D27/29, 0x033149/4B, 0x03519C, 0x034F2, 0x03C6DE).

- Open questions still pending: second dictionary location (indices 0xA8-0xFF), content of tail
  remainder (0x035078-0x03FFFF), identity of the data structure type referenced by the 6 descriptors
  at 0x022460.

- Tightened the tail of bank `0x020000` again without over-claiming semantics. The former single
  `Bank020000_TailRemainder_035078` slice in `src/bank020000_tail_blocks.asm` is now split into
  three additional compressed/data blocks plus a smaller trailing remainder: `0x035078-0x03519D`,
  `0x03519E-0x0354F3`, and `0x0354F4-0x03C6DF` each end with a proven `0xFF7A` terminator, leaving
  only `0x03C6E0-0x03FFFF` grouped as the final unresolved tail.
- Promoted the front `0x02482C-0x024835` offset table from a raw `incbin` into explicit `dc.w`
  data (`$0016,$007A,$00EA,$015E,$FF7B`), since those values are already fully understood as
  relative offsets into Block 1 plus the terminating sentinel.
- The new `0xFF7A`-terminated split keeps the terminology structural. The three added blocks start
  with header-like prefixes `0x0660`, `0x0B60`, and `0x0F00`, which fits the broader compressed-data
  picture in this tail, but the exact codec/asset family is still not proven enough to hardcode a
  stronger subsystem label.
