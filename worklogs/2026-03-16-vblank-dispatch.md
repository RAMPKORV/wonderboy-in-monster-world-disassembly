# 2026-03-16 - VBlank dispatch reconnaissance

- Verified that the ROM stays bit-perfect after reverting a failed source-authored split
  of the front of `src/vblank.asm`.
- The block at `0x004B58` begins with the default interrupt spin (`nop` / `bra.s -4`).
- `0x004B5C` is the live VBlank handler: it increments `0xFFFF8A49` and sets bit 0 at
  `0x8006` before returning with `rte`.
- `0x004B6A-0x004BBB` clears queue bookkeeping and retires pending task entries.
- Two task-slot arrays are visible:
  - Immediate queue base `0x8048`, 4 slots, stride `0x80`
  - Round-robin queue base `0x8248`, 16 slots, stride `0x80`
- Slot observations from the dispatcher:
  - offset `0x00`: signed/flagged state word, bit 7 marks active work
  - offset `0x04`: user data passed in `d2` to helper `jsr ($04A4).w`
  - offset `0x0C`: callback pointer used by `jsr (a0)`
- Queue-control RAM observed in the front slice:
  - `0x8A48`: current immediate slot id / cursor mirror
  - `0x8A49`: VBlank tick counter
  - `0x8A4A`: round-robin slot index
  - `0x8A4B`: per-pass budget counter
  - `0x8A4C`: current slot pointer backup
  - `0x8A5D`: queue/timing flags checked before timed dispatch
- The attempted symbolic rewrite failed because `ASM68K` did not preserve several
  short absolute encodings exactly; it promoted some operands to longer forms and
  shifted all following bytes. Future source-authored recovery of this block needs a
  tested encoding recipe before another split attempt.
- Follow-up probing confirmed the recipe: `ASM68K` will emit absolute-short forms for
  this RAM window when operands are written as signed `.w` values (`($FFFF8A49).w`,
  `($FFFF8006).w`, or negative `equ` aliases), while plain positive `0x00FFxxxx`
  symbols widen to absolute long. It also accepts `incbin "file",offset,length`, which
  should allow a front-of-blob source split once the signed alias layer is designed.
- Applied that recipe successfully: `0x004B58-0x004BC1` now lives in `src/vblank.asm`
  as source-authored code with a sliced `incbin` tail beginning at `0x004BC2`, and the
  rebuilt ROM remains bit-perfect. The current split uses signed `_Short` RAM aliases
  for absolute-short operands and a couple of raw branch opcodes where `ASM68K` would
  not keep the original short displacement automatically.
- Extended the source-authored region through `0x004CA7`. That newly named slice walks
  the four immediate task slots, then runs either a timed round-robin dispatch path or
  a full fallback sweep over the 16-slot round-robin queue.
- Confirmed two more scheduler semantics while doing that split:
  - `0x8A5D` bit 6 enables the budgeted timed-dispatch path.
  - The timed path seeds a budget counter of `0x10`, polls `0xC00004`/`0xC00008`, and
    repeatedly calls the round-robin helper until the budget expires or VDP timing says
    to stop.
- Extended the authored tail a little further through `0x004CC3` after decoding the
  next helper/stub pair with Capstone and ROM byte checks:
  - `0x004CA8` restores `a5` from `0x8A4C`, clears the current slot state word, stores
    `d0` to `0x8068`, and returns.
  - `0x004CB8` seeds `a1` with the inline descriptor at `0x004CC4` and tail-jumps to
    the existing immediate-task install helper at `0x0050E2`.
  - `0x004CB4` is another local idle spin (`nop` / `bra.s -4`) that now has an
    explicit label in source.
- Extended the source-authored region again through `0x004E63` by treating the inline
  blocks at `0x004CC4`, `0x004D14`, `0x004D52`, `0x004D64`, and `0x004DDE` as
  descriptor-plus-callback pairs: each leading longword becomes task user data and the
  callback entry starts at descriptor + 4.
- Confirmed another task-slot bank at `0x80C8` that is populated from inline lists via
  the helper at `0x5106`; the callbacks poll its slot-0 active bit before queueing more
  immediate or round-robin work.
- Confirmed a task-script state cluster at `0x8A4E-0x8A51`: `0x004DE2` seeds a stream at
  `0x004E64`, toggles mode/flag bytes at `0x8A50-0x8A51`, and loops back to the initial
  immediate-task descriptor when the sequence winds down.
- Promoted the short callback list at `0x004E5C` into source as two longwords
  (`0x00008EB0`, `0x00000000`) and shifted the remaining opaque tail to begin cleanly at
  `0x004E64`.
- Extended the authored region again through `0x004FED` after decoding the next
  descriptor/callback chain at `0x004F54`, `0x004FC0`, and `0x004FC8`:
  - `0x004F58` loads a secondary descriptor list rooted at `0x004FC0`, then tail-jumps
    into long helper `0x01AA3C`.
  - `0x004F66` seeds the current task slot's delay word at offset `0x40` with `0x0E10`,
    runs helper `0x01AD62`, decrements the delay, and falls through into a readiness poll.
  - `0x004F84` and `0x004FA6` both use helper `0x5842` plus ready-bit 4 at `0x8C56` to
    wait until the bootstrap immediate descriptor at `0x004CC4` can be queued again.
  - `0x004FCC` gates on `0xA3A4` plus progress bit 7 at `0x8A7C`, then patches immediate
    slot 0's callback pointer at `0x8054` to `0x004FA6` before retiring the current slot.
  - Only the cross-bank tail beginning at `0x004FEE` remains opaque in this scheduler block.
- Recovered the cross-bank tail through `0x00507B` without breaking the rebuild:
  - `0x004FEE` (`ClearTaskScriptProgressBuffer`) clears `0x400` longwords at `0xFF1400`,
    stores that stream base in the current task slot's offset `0x44`, and zeroes the
    progress/state bytes at `0x8A7A`, `0x8A7B`, `0x8A7C`, and `0x8A52`.
  - `0x005016` re-seeds `a0` from the same progress buffer and `0x00501C`
    (`AdvanceTaskScript`) pulls the next countdown word into `0x8A4E` while resetting the
    current/previous progress bytes.
  - `0x005036` appends/increments `(count,value)` pairs in the same stream using the slot
    pointer at offset `0x44`, and `0x00505C` (`StepTaskScript`) advances the active
    progress value while reloading the next countdown word when the current one expires.
- The next opaque frontier is now the descriptor/data block beginning at `0x00507C` and
  the queue-install helpers at `0x0050D4+`.
- Finished the `0x00513C-0x00516F` tail as source-authored code after decoding the raw
  bytes by hand:
  - `0x8A7D` is now `SecondaryTaskStatusSelector`, a latched signed selector where
    `0x80` watches `0x8A81` and `0x81` watches `0x8A84`.
  - `0x00513C` first checks whether that selector is already negative; if so, it masks
    the low 7 bits to choose `SecondaryTaskReadySlot0` or `SecondaryTaskReadySlot1` and
    returns the current bit-7 ready state via `btst`.
  - If no selector is latched yet, the helper probes `0x8A81` first, then `0x8A84`,
    stores `0x80` or `0x81` back to `0x8A7D` when one becomes ready, and otherwise
    returns with Z set so the caller can stay in its polling path.
- Split out and decoded the next clean function boundary at `0x0051C6-0x005260` while
  leaving `0x005170-0x0051C5` opaque:
  - `0x0051C6` requests the Z80 bus, polls both controller data ports, stores each pad's
    current/previous/new-press state in three-byte triplets at `0x8A7F-0x8A81` and
    `0x8A82-0x8A84`, releases the bus, and then mirrors the selected pad's current byte
    into `0x8A7A` unless `0x8A50` is negative.
  - `0x005216` is the per-port polling helper: it performs the two-phase TH line dance on
    `0xA10003` / `0xA10005`, builds the 8-bit pad state byte, and derives a freshly
    pressed mask as `(current ^ previous) & current`.
  - `0x005250` repeats that same pressed-mask formula for the selected-input mirror at
    `0x8A7A-0x8A7C`, strongly suggesting that the earlier `0x00501C-0x00505C` helpers are
    handling input recording/playback rather than abstract task progress.
- Finished the remaining `0x005170-0x0051C5` bootstrap gap as source-authored code:
  - `0x005170` clears VDP/display work through helper calls at `0x006910`, `0x006916`,
    `0x00693E`, and `0x00696C` after masking VDP register-1 state with `0x0006F6`, then
    tail-branches to the already known `0x00559E` buffer-prime helper.
  - `0x005188` resets the same VDP state through `0x0006BE`, reruns the display clear
    stub, seeds four bootstrap patch words at `0x8B34-0x8B3A` with `0x0080`, clears an
    additional scratch block through `0x005398`, retires queued descriptors rooted at
    `0x006EA8` and `0x005608`, and then jumps into the stream decoder at `0x00234C`.
  - `0x0051C0` is not code: it is a six-byte inline command stream (`B0 FB FB FB FF 00`)
    consumed via PC-relative `lea`, so it must stay physically adjacent to the stub.
- Tightened the input-stream interpretation without changing bytes:
  - `0x00501C` does not load an arbitrary word count. Because `0x8A4E` and `0x8A4F` are
    adjacent bytes, `move.w (a0)+,(0x8A4E).w` proves each stream entry is a packed
    `(duration,value)` pair latched straight into countdown/value state.
  - `0x005036` is therefore a run-length encoder for the same format: it increments the
    leading duration byte until it reaches `0xFF`, then advances to the next pair when the
    selected-input value changes.
  - `0x0051C6` and `0x005250` confirm the consumer side: when playback mode at `0x8A50`
    is negative, live pad mirroring into `0x8A7A-0x8A7C` stops, leaving `0x00505C` to feed
    replayed values into the selected-input mirror and `0x005250` to derive edge presses.
