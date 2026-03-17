# Research Log

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
