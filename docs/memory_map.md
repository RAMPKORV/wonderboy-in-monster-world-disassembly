# Memory Map

## ROM

- ROM address space: `0x000000-0x0BFFFF`
- Initial stack pointer: `0x00FF0C00`
- Reset vector: `0x00000200`

## RAM

- Work RAM start: `0x00FF0000`
- Work RAM end: `0x00FFFFFF`
- `0x00FF3300`: task-script scratch buffer seeded from the inline list at `0x004F14`
  before the secondary callback list at `0x004E5C` is queued.

## Identified RAM Anchors

- `0x00FF8006`: VBlank dispatch flags byte; bit 0 is set by the live VBlank handler.
- `0x00FF8068`: task completion result word written from `d0` when the current VBlank
  task slot is retired.
- `0x00FF8048`: immediate VBlank task-slot array base.
- `0x00FF80C8`: secondary VBlank task-slot array loaded from inline descriptor lists in
  the `0x004CC4-0x004E63` callback chain.
- `0x00FF8248`: round-robin VBlank task-slot array base.
- `0x00FF8A48`: immediate task cursor / active-slot mirror.
- `0x00FF8A49`: VBlank tick counter incremented once per live VBlank.
- `0x00FF8A4A`: round-robin task index.
- `0x00FF8A4B`: per-pass dispatch budget counter.
- `0x00FF8A4C`: current task-slot pointer backup.
- `0x00FF8A4E`: task-script countdown byte consumed by the callback chain rooted at
  `0x004DE2`.
- `0x00FF8A4F`: task-script value byte copied into the sequence scratch state each step.
- `0x00FF8A50`: task-script mode flag toggled while the `0x004DE2` callback runs.
- `0x00FF8A51`: task-script control flags; bit 0 is set before yielding and cleared when
  the callback restarts the initial immediate-task descriptor.
- `0x00FF8A52`: longword task-script state cleared when the progress buffer is reset or a
  new script stream is loaded.
- `0x00FF8A7A-0x00FF8A7C`: selected-input current/previous/new-press bytes. They are still
  shared with the helper chain at `0x00501C-0x005260`; current best fit is that
  `0x005016-0x00505C` treats `0xFF1400` as a stream of `(duration,value)` playback pairs
  and reuses this trio as selected-input playback state rather than a generic progress tracker.
- `0x00FF8A7D`: selected-input source latch; bit 0 chooses which per-pad input triplet is
  mirrored into `0x8A7A-0x8A7C`.
- `0x00FF8A7F-0x00FF8A81`: player 1 current/previous/new-press button bytes produced by
  `ReadControllerPortsAndLatchSelectedInput` / `ReadControllerInputStateTriplet`.
- `0x00FF8A82-0x00FF8A84`: player 2 current/previous/new-press button bytes produced by
  the same controller polling helpers.
- `0x00FF8A5D`: queue/timing flags consulted by the timed dispatcher; bit 6 gates the
  budgeted round-robin path.
- `0x00FF8B34-0x00FF8B3A`: four bootstrap patch words seeded with `0x0080` by
  `BootstrapRetirePendingTasksAndApplyPatch_005188` just before it retires queued
  descriptors and feeds the inline patch stream at `0x0051C0` into the decoder at
  `0x00234C`.
- `0x00FF8C56`: task-advance ready flags; bit 4 gates the ready loops at `0x004F84` and
  `0x004FA6` after helper `0x5842` runs.
- `0x00FF95D7`: selected-input repeat latch; `0x00805A` remembers the last held selected
  input here before applying auto-repeat suppression for downstream UI/menu navigation.
- `0x00FF95D8`: selected-input repeat countdown; `0x00805A` seeds it with `0x10` on a new
  press and `0x08` on subsequent auto-repeat ticks.
- `0x00FF95D9`: selected-input repeat output byte; `0x00805A` writes a gated one-frame UI
  or menu-navigation input here, and later opaque logic such as `0x007924`, `0x007938`,
  and `0x008212` consumes it.
- `0x00FF95D1`: best-fit magic/status layout-record index. The newly recovered loader at
  `0x0086BC` treats it as a selector for one of seven 6-byte records when `0x966B` is
  clear, and as a special-case chooser for a smaller two-record table when that page flag
  is set.
- `0x00FF95CE-0x00FF95D0`: compact three-byte magic/status selection scratch buffer mirrored into
  `0x00FF95D2-0x00FF95D4` by the still-incbin-backed `0x00882C+` continuation.
- `0x00FF95D2-0x00FF95D4`: snapshot copy of that same compact selection scratch buffer; raw ROM
  work suggests the adjacent gauge/selector continuation preserves these bytes while it
  normalizes or clears the live top-row selection state.
- `0x00FF95E2-0x00FF95E3`: filtered top-row magic/status selector mirrors initialized by
  `InitializeMagicMenuSelectionState_008C34`; each byte is seeded with `0xFF` and only replaced
  when the corresponding live selector at `0x00FF9F10-0x00FF9F11` remains below the shared
  `#$08` lower-row/status cutoff.
- `0x00FF95E0`: best-fit magic-submode modal flag. The newly source-authored control block
  at `0x00799E-0x007A43` sets this before it temporarily clears `0x9606`, runs the shared
  repeat-gated UI loop, and then restores the saved selection.
- `0x00FF95E4`: saved selection index for that same upstream magic-submode flow; the
  handler at `0x00799E` backs up `0x9606` here before forcing a temporary zero-based view.
- `0x00FF95E5`: current magic-submode selection value; `0x0079EE` writes it back into the
  per-entry selector bytes before refreshing the adjacent slot 0/1 status graphics.
- `0x00FF95E1`: scratch byte used by `0x00853C` while drawing the likely level value in
  the adjacent inventory/equipment status panel.
- `0x00FF959C`: leading byte of a compact magic/status-panel scratch tuple consumed by
  `0x007B22`; it feeds the same two-digit level-style drawer used at `0x008552` before the
  rest of the tuple is consulted for selector/icon refresh.
- `0x00FF95DC-0x00FF95DD`: cached one-byte status-art selectors compared against
  `0x00FF9F10-0x00FF9F11` by `0x008620` before the menu uploads new tile patterns.
- `0x00FF95E6`: inventory/equipment category-descriptor base pointer loaded by
  `0x0082F4`; the current best fit is that large negative offsets from this base expose a
  category availability bitmask and the currently highlighted/equipped entry id.
- `0x00FF95E8`: measured width of the currently selected spell name; `0x008778` uses it to
  center the localized magic labels from the table at `0x007BFE`.
- `0x00FF95EE`: lower-row magic/status selector. `0x008620` uses it when the menu switches
  to the status graphic row at tile coords `0x1605`, and the upstream apply path around
  `0x007A5A` reuses it as one of the per-slot values it pushes back into entry state.
- `0x00FF95F0`: alternate magic/status selector loaded by `0x007A64` / `0x007B54` for the
  second top-row entry before the apply path writes the chosen value back into entry state.
- `0x00FF95F2`: redraw countdown for the adjacent incbin-backed magic/status gauge update
  path rooted at `0x00885A`.
- `0x00FF95F4-0x00FF95F6`: paired gauge-width accumulators prepared by that same
  rendering-heavy continuation before it writes the three-row strip.
- `0x00FF95FA`: inventory/equipment menu category id. The heading table at `0x0082B6`
  maps this selector to the inline strings `SELECT`, `WEAPON`, `ARMOR`, `SHIELD`,
  `BOOTS`, `ITEM`, and `MAGIC`.
- `0x00FF95F8`: cached fill amount for the magic meter drawn by `0x0087CE`; only the high
  byte is compared so redundant redraws are skipped.
- `0x00FF95FC-0x00FF9600`: body/fill/pad tile counts for the adjacent three-row
  magic/status gauge strip writer reached from `0x0088D6`.
- `0x00FF9602-0x00FF9604`: current packed gauge value plus low-word remainder scratch used
  by that same still-opaque gauge-rendering path.
- `0x00FF9606`: inventory/equipment menu selection index toggled by the `0x007924`,
  `0x007938`, and `0x008212` handler cluster.
- `0x00FF9608-0x00FF960F`: visible inventory/equipment entry ids built from a category
  bitmask near `0x0082F8`; bit 7 marks the currently highlighted entry.
- `0x00FF9610`: visible entry count for the current inventory/equipment category.
- `0x00FF9612`: top visible entry index for the current four-row list window.
- `0x00FF9614-0x00FF9615`: blinking primary list-cursor state byte plus countdown.
- `0x00FF9616-0x00FF961F`: auxiliary cursor tile positions, state, countdown, and saved
  coordinates used by the same menu block.
- `0x00FF9620-0x00FF9623`: up/down scroll-indicator state bytes plus blink countdowns.
- `0x00FF9624-0x00FF9627`: primary list-cursor tile coordinates and saved coordinates.
- `0x00FF962C`: likely live gold total formatted by `0x008596` in the same menu/status
  panel that renders the inline `GOLD` label.
- `0x00FF9628`: pending packed target value consumed by the incbin-backed magic/status
  gauge updater at `0x00885A` before it chooses one of two render scales.
- `0x00FF9634`: return vector scratch used by `0x00805A` while it pops its caller return
  address, runs the selected-input UI-repeat helper, and tail-jumps back without growing
  the stack.
- `0x00FF9640`: modal magic-submode return vector scratch used by `0x0079EE` while it runs
  the adjacent selection loop and then tail-jumps back to its caller.
- `0x00FF964C`: modal magic-submode dispatch vector scratch; `0x00799E` pops its caller
  continuation here before looping on repeat-gated input and dispatching through it on
  confirm/exit.
- `0x00FF9654`: apply-path return vector scratch used by `0x007A44` while it reruns the same
  modal submode loop, commits the chosen selector, clears the indicator tile, and then
  tail-jumps back to its caller.
- `0x00FF966B`: one-bit flag consulted by `0x0086C8` while selecting one of two small
  six-byte configuration records for the adjacent magic/status panel; the exact owner is
  still unresolved even after the new `0x007924-0x007A43` control-flow recovery.
- `0x00FFC00C`: best-fit action/confirm flag for that same modal magic-submode loop;
  `0x00799E` clears it on both the confirm and cancel-style exits before dispatching.
- `0x00FF9EF1`: best-fit layout/config flags for that same magic/status panel. Bit 4 makes
  `0x0086BC` skip the normal table selection and fall back to the fixed 6-byte record at
  `0x00874A`.
- `0x00FF9EFA`: first unpacked destination longword written by `0x0086BC` from bytes 0-1 of
  the selected 6-byte layout record.
- `0x00FF9EF2`: signed word written by `0x0086BC` from byte 2 of that record after a left
  shift by 4.
- `0x00FF9EF4`: word written by `0x0086BC` from byte 3 of that record.
- `0x00FF9EF6`: second unpacked destination longword written by `0x0086BC` from bytes 4-5
  of that record after a left shift by 4; the exact consumer of the `0x9EF1/0x9EFA+`
  cluster is still unresolved.
- `0x00FF9658`: auxiliary task-script flag cleared by the queue setup path at `0x005080`.
- `0x00FF1400`: task-script progress buffer; `0x004FEE` clears `0x400` longwords here and
  `0x00501C` / `0x00505C` treat it as a script stream of countdown/progress pairs through
  the source-authored tail ending at `0x00507B`.
- `0x00FFA3A4`: async-ready byte cleared and polled by `0x004FCC` before that callback
  rewrites immediate slot 0's callback pointer.
- `0x00FF9996`: auxiliary scratch buffer cleared by helper `0x005124`.
- `0x00FF9F00`: likely player level byte copied by `0x00853C` before it is converted into
  HUD digit tiles for the same inventory/equipment status panel.
- `0x00FF9F10-0x00FF9F11`: current magic/status-art selectors mirrored into
  `0x00FF95DC-0x00FF95DD`; `0x008620` maps them onto pattern ids and literal tile quads.

## Header Advertised Save/RAM Fields

- Backup RAM identifier bytes: `52 41 E8 40`
- Backup RAM start: `0x00200001`
- Backup RAM end: `0x00200001`

The backup RAM range currently collapses to a single odd address, so it should be
treated as a header-level observation rather than a confirmed functional SRAM map.

## Vector Table Highlights

- Bus error vector: `0x000049FA`
- Address error vector: `0x000049F8`
- Most exception vectors point to `0x000049FE`, `0x00004A02`, or `0x00004B58`
- Interrupt level 6 vector points to `0x00004B5C`
- Many reserved vectors contain `0x00000006`, which should be preserved exactly until
  code analysis explains whether they act as intentional traps or placeholder data
