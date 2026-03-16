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
