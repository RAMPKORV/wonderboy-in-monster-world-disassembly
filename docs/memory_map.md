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
- `0x00FF9658`: auxiliary task-script flag cleared by the queue setup path at `0x005080`.
- `0x00FF1400`: task-script progress buffer; `0x004FEE` clears `0x400` longwords here and
  `0x00501C` / `0x00505C` treat it as a script stream of countdown/progress pairs through
  the source-authored tail ending at `0x00507B`.
- `0x00FFA3A4`: async-ready byte cleared and polled by `0x004FCC` before that callback
  rewrites immediate slot 0's callback pointer.
- `0x00FF9996`: auxiliary scratch buffer cleared by helper `0x005124`.

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
