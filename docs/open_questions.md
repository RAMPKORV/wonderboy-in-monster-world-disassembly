# Open Questions

- Confirm whether the unusual SRAM support field at `0x01B0` is meaningful runtime data
  or simply a header artifact inherited from another configuration.
- Document whether the ROM ever validates the header checksum internally.
- Establish the first coarse ROM region map after Ghidra import.
- Prove the remaining producers and higher-level owners of the apparent input-playback
  stream used by `0x005016-0x00505C`. Current best fit is `(duration,value)` records in
  `0xFF1400` with `0x8A7A-0x8A7D` reused as selected-input playback state; `0x00805A`
  now looks proven as a downstream auto-repeat UI/menu-navigation consumer via
  `0x95D7-0x95D9`. The adjacent `0x0080A8-0x0083CF` block is now source-authored as
  inventory/equipment menu UI, with heading strings `SELECT`, `WEAPON`, `ARMOR`,
  `SHIELD`, `BOOTS`, `ITEM`, and `MAGIC`; `0x00853C-0x00861E` now also appears to draw a
  level badge/value and live gold total. The next recovered slice at `0x008620-0x00882A`
  now also looks like adjacent magic/status-panel logic: it mirrors selector bytes from
  `0x9F10/0x9F11` into caches at `0x95DC/0x95DD`, centers spell names via the localized
  table at `0x007BFE` (`FIRE STORM`, `QUAKE`, `THUNDER`, `POWER`, `SHIELD`, `RETURN`),
  and draws an eight-step meter cached at `0x95F8`. Raw ROM disassembly now narrows
  `0x007924` / `0x007938` to paired horizontal-toggle handlers for a two-choice adjacent
  magic/status submode, and the newly source-authored `0x00799E-0x007A43` loop now appears
  to use `0x95E0` as a modal flag plus `0x95E4` as a saved selection backup while
  refreshing `0x008620` / `0x00863C`. The same open path also makes `0x95E5`, `0x9640`,
  `0x964C`, and `0xC00C` look like current-selection plus modal return/dispatch/action
  scratch for that submode. The newly source-authored continuation at `0x007A44-0x007BA9`
  now also makes `0x9654` look like the apply-path return vector, `0x959C` a compact
  status-panel scratch base, and `0x95F0` an alternate selector paired with `0x95EE`.
  The newly source-authored `0x007BAA-0x007CA3` continuation now also proves that the adjacent
  view is specifically a six-row magic grid using the localized spell set `FIRE STORM`,
  `QUAKE`, `THUNDER`, `POWER`, `SHIELD`, and `RETURN`, with paired bar strips derived from
  per-spell counts mirrored through `0x95B7/0x95C8`. The upstream writers beyond `0x005036`,
  the category descriptor base pointer at `0x95E6`, the exact semantic split between
  `0x95EE` / `0x95F0` / `0x966B` and the `0x9F10-0x9F11` selectors, plus the newly recovered
  `0x007D9C-0x008059` visible-list / blink / row-transfer bridge and the already recovered `0x0086BC` layout-record loader that
  unpacks 6-byte config records from `0x008720` / `0x008750` into
  `0x9EFA/0x9EF2/0x9EF4/0x9EF6`, are still unresolved at the consumer/state-owner level.
  External dump
  evidence now usefully confirms localized strings like `FIRE STORM`, `Oasis Boots`,
  `Fire-Urn`, `Purapril`, `Childam`, `Shiela Purapril`, `Prince of the Devil World`, and
  `Bio-Mecha`, but keep the labels system-level unless the actual ROM control/data bytes for
  this menu flow point to one of those game-specific screens or inventories. The newly
  source-authored `0x007CA4-0x007D98` slice now shows that `0x95E6 == #$0005` selects the raw
  six-spell page while other values route through `0x95EE` / `0x95F0` plus `+$08` for top-row
  assignment clearing, and `0x007D00` proves a two-column six-choice navigation table. The
  newly source-authored `0x007D9C-0x008059` bridge now also proves nearby visible-list
  confirmation, a selected-row blink loop, packed menu-row upload helpers, and an inline
  `PAUSE` prompt, but the higher-level owner that seeds the page/state word, the exact meaning
  of visible-entry sentinel id `7`, and the concrete screen owner of those row templates are
  still not identified.
- Pin down the exact semantics of the newly recovered bootstrap helpers at `0x005170` and
  `0x005188`, especially what the `0x8B34-0x8B3A` patch words and the six-byte stream at
  `0x0051C0` represent beyond their current best-fit decoder/bootstrap interpretation.
- Source-author the next gauge/selector continuation at `0x0088C2-0x008C33` with an encoding
  recipe that preserves the original bytes after the new source-authored bridge at `0x00882C-0x0088C1`
  and the new state-init tail at `0x008C34-0x008C7F`. Raw ROM checks now strongly suggest a rendering
  helper that normalizes adjacent magic/status selectors, consumes a pending packed gauge value at
  `0x9628`, and fans out through a three-row tile-strip writer using scratch around
  `0x95AA`, `0x95B2`, `0x95B8-0x95C3`, `0x95F2`, `0x95F4`, `0x95F6`, `0x95FC`, `0x95FE`,
  `0x9600`, `0x9602`, and `0x9604`; the later continuation at `0x008A3A-0x008C33` now also looks
  like spell-bar refill, gauge-tile upload, width synthesis, and local selection-scratch mirroring,
  but the exact stat being visualized is still not proven.
  The surrounding RAM map is a little firmer now: `0x95CE-0x95D0` looks like a compact local
  selection scratch buffer mirrored into `0x95D2-0x95D4`, and `0x95F4` / `0x95F6` behave like paired
  gauge-width accumulators.
  The safer current fit is: the new source-authored bridge at `0x00882C-0x0088C1` clears matching
  top-row selector slots in `0x9F10/0x9F11` after remapping raw ids into the local selector space,
  `0x00885A` consumes `0x9628`, chooses between the `0x00893C` and `0x008950` gauge scales, refreshes
  the redraw countdown at `0x95F2`, and hands off to the still-opaque writer at `0x0088D6`; then
  `0x008A04` updates the six-entry fill/capacity arrays with the small inline step table
  `03 03 03 02 02 01`, `0x008AA2` builds the eight-byte gauge tile-id buffer at `0x95AA`,
  `0x008B2E` uploads the two gauge rows from inline tile tables. The newly source-authored
  `0x008C34-0x008C7F` continuation now also snapshots `0x95CE-0x95D0`, clears visible-list state,
  and filters valid sub-`#$08` top-row selector ids into `0x95E2/0x95E3`. That is enough to keep
  the next naming round honest, but not enough yet to force a final game-facing stat label.
  The remaining practical hazards now live in the still-opaque `0x0088C2-0x008C33` tail: exact
  short-branch sizing in the gauge loops, the original absolute-long table loads near `0x0089B6`,
  and the code/data boundaries through the scale bundles plus tile tables before the now-authored
  state-init tail at `0x008C34`. The conservative labels for
  `TryAdvanceMagicMenuSpellBarFill_008A3A`, `TryIncreaseMagicMenuSpellBarFill_008A88`,
  `BuildMagicMenuStatusGaugeTileIdBuffer_008AA2`, `UploadMagicMenuStatusGaugeTileRows_008B2E`,
  `UpdateMagicMenuStatusLayoutWidths_008BB6`, and `MagicMenuStatusWidthLookupTable_008C1E` are now
  exported in the machine-readable indexes, so the next productive step is to turn the remaining
  gauge body into a byte-identical source split rather than doing another blind naming pass.
- Decide when the `0x000200+` body should be split into smaller `incbin` modules.
- Decode the control-byte scheme and downstream consumers for the new bank `0x020000`
  text-bearing slice at `0x021B80-0x02245F`. The text bytes now prove a mixed block with an
  equipment shop buy flow, inn stay/save prompts, Ocarina practice and door-hint text, the Pyramid
  transition hint at `0x021FEA`, and a 168-word null-terminated dialogue dictionary at
  `0x022026-0x02245F`, but several short records are still script/control payloads rather than pure
  prose, and the odd byte sequence at `0x021FCA-0x021FDC` is only conservatively tracked as
  Ocarina-adjacent auxiliary data until its exact format is proven from code flow.
- Prove the driver format for the newly split bank `0x020000` quiz block at `0x021360-0x02171F`.
  The bytes now clearly show ten multiple-choice question/answer records plus repeated `YES  NO`
  prompts and a `GOLD` label, but the front `0x021360-0x0213AE` word list is only known as the tail
  of a larger backwards-pointing offset table, and the control payload at `0x0213BD-0x021428`
  remains undecoded. The next useful evidence target is the code that consumes those offsets and
  the encoded host/control bytes around `0x0213CE`, so the block can move from readable text-bank
  split to a truly documented quiz/script module.
- Determine the consumer for the new bank `0x020000` front index block at `0x0211CA-0x02135F`.
  The bytes now prove a four-entry absolute pointer list into bank-local resources
  (`0x0211DA`, `0x021720`, `0x021A06`, and `0x021FCA`), followed by one bank-relative offset table that
  targets `0x0201D0-0x020539` and a second monotone bank-relative offset table that targets
  `0x020E4C-0x0211C9`. The surrounding bytes are clearer now too: `0x020000-0x0201CF` and
  `0x02053A-0x020E4B` are no longer anonymous gaps, but adjacent dialogue/script continuation modules
  that carry the same mixed text-plus-control flavor as the two table-targeted record families. That
  confirms that the front bank is dealing with real script/text ownership rather than random earlier
  bytes. Even so, those record bytes still mix readable text fragments with undecoded control payloads,
  so it is not yet safe to say whether the owner is a dialogue builder, a menu text catalog, a quiz-host
  script table, or some broader script/text dispatcher without the 68k-side code that loads these bases.
- Determine the consumer and field semantics for the next bank `0x020000` structured island at
  `0x022460-0x022DB7`. The front `0x022460-0x0224BF` bytes are now split as six 0x10-byte same-bank
  reference descriptors, `0x0224C0-0x0225D7` is a monotone big-endian offset table that fits a
  payload base at `0x0225D8`, `0x022662-0x02292B` is now source-authored as a table-targeted payload
  family with one `0x8A`-byte lead-in plus mostly 6-byte short records and eight 8-byte variants,
  `0x02292C-0x022AEB` is a stable 0x10-byte repeated descriptor band, and the former opaque tail at
  `0x022AEC-0x022D3F` is now explicit as variable-length `$FFFF`-delimited word records with one larger
  descriptor at `0x022BBA` that embeds three `$FE00`-prefixed sublists before a doubled `$FFFF`
  terminator; the next `0x022D40-0x022D6B` span is a repeated `$0BFF` word band; and
  `0x022D6C-0x022DB7` is now split as several compact `$FF00`-terminated word records. That is enough
  to justify source-owned table labels and record boundaries, but not yet enough to call the region map,
  object, or script data. The next useful evidence target is the bank-local or low-ROM code that indexes
  the `0x0224C0` table, explains the duplicate `$0260` offset entry, or interprets the `$FFFF` / `$FE00`
  / `$FF00` delimiters plus the repeated `$0BFF` band in the newly exposed tail.
- Determine the consumer and field semantics for the later bank `0x020000` structured island at
  `0x022DB8-0x023AB5` in bank `0x020000`. The region is no longer one anonymous gap: `0x022DB8-0x0237B3`
  is now isolated as a recurring-word band, `0x0237B4` and `0x0237E2` are explicit standalone `$FFFF`
  words, `0x0237B6-0x0237CD` and `0x0237CE-0x0237DB` are source-visible `$FF00`-terminated compact word
  records, and `0x0237DC-0x0237E1` is a short three-word lead-in
  before the remaining mixed payload at `0x0237E4-0x023AB5`. That is enough to prove local structure and a
  real bridge between the earlier compact-record family and the later `$FFFF`-delimited word-record band,
  but not enough yet to name the higher-level owner without the code that recognizes those sentinels or
  steps across this transition zone.
- Determine the consumer and field semantics for the later bank `0x020000` structured island at
  `0x023AB6-0x02482B`. The bytes there are now split in source as a long band of big-endian word
  records whose boundaries are repeatedly marked by `$FFFF` sentinels, and several subfamilies share
  stable field counts or coordinate-like word patterns. The newly exposed continuation at
  `0x024538-0x02482B` also reuses several control-like words already seen nearby (`$E001/$E010/$E012/$E021/$E031/$E042/$E071`,
  `$D301`, and embedded `$FF00` markers before the final `$FFFF`), which strengthens the case that this
  is one larger structured family rather than two unrelated blobs. That is enough to justify a ROM-order
  record split, but not yet enough to call the region menu layout data, object placement, script payloads,
  or another subsystem without the code that scans those sentinels or consumes the resulting fields.
- Determine the format family for the back tail of bank `0x020000` at `0x02482C-0x03FFFF`. The front
  offset table at `0x02482C` is now explicit `dc.w` data, nine earlier blocks at `0x024836-0x035077`
  already ended with `0xFF7B`, and the next three blocks at `0x035078-0x03C6DF` are now split out by
  proven `0xFF7A` terminators into `0x035078-0x03519D`, `0x03519E-0x0354F3`, and
  `0x0354F4-0x03C6DF`. The former single bank-end remainder at `0x03C6E0-0x03FFFF` is now also split in
  ROM order at later header-like starts into `0x03C6E0-0x03E845`, `0x03E846-0x03EF4D`,
  `0x03EF4E-0x03F4D0`, `0x03F4D1-0x03FE23`, and `0x03FE24-0x03FFFF`, but those boundaries are still
  weaker than the earlier terminator-proven ones. The strongest current byte-level evidence is still
  structural: header-like prefixes such as `0x0660`, `0x0B60`, `0x0F00`, and `0x0960`, heavy fill-style
  runs, and alternating `0xFF7A` / `0xFF7B` block terminators that look more like compressed graphics/data
  families than scripts or plain tables. The next useful evidence target is a loader/decompressor path that
  proves whether these are map, tile, sprite, or other asset blocks and whether `0xFF7A` and `0xFF7B` are
  true format variants, sibling terminators inside one codec family, or markers for nested substreams.
- Determine the exact owner of the bank `0x080000` non-fill island at `0x098000-0x09F776`.
  The front `0x098000-0x0991FF` slice is no longer one monolithic Z80-like blob: `0x098000-0x09907A`
  now reads strongly enough as a real Z80 program front, with `0x098000` opening on `DI` / `IM 1` /
  `JP $003B`, a tiny `NOP` / `RETI` stub at `0x098038`, and a jumped-to main body at `0x09803B`; `0x09907B-0x09913C` is now explicit as an odd-aligned
  little-endian ascending word table with 97 entries, `0x09913D-0x0991FE` is a matching odd-aligned
  descending word table with 97 entries, and `0x0991FF` stands alone as one trailing zero byte. The
  next `0x099200-0x09991F` pre-descriptor tail is now source-visible too: `0x099200-0x09927F`
  is explicit as two monotone byte bands, `0x099280-0x099648` is explicit as 51 fixed 19-byte records
  whose third/fourth bytes consistently fall in the `F0C0` / `D0C0` / `B0C0` family, `0x099649-0x099828`
  is now explicit as 30 fixed 16-byte records, `0x099829-0x09982B` stands alone as a short 3-byte lead-in,
  `0x09982C-0x09988F` is now explicit as 20 fixed 5-byte records, and `0x099890-0x09991F` is now split as
  a short local-offset word band, a packed byte band, eight repeated `0x01F1` words, a 14-byte trailer,
  and a final word tail that leads directly into the already explicit descriptor/layout pocket.
  The next `0x099920-0x09997F` slice is now explicit as sixteen fixed 6-byte descriptor-like records,
  `0x099980-0x099A74` is now explicit as forty-nine fixed 5-byte layout-like records, and
  `0x099A75-0x099A84` stands apart as a short trailer,
  `0x099A85-0x099AFF` is explicit zero fill, and the `0x099B00+` command region now has a fully source-visible
  pre-window front: `0x099B00-0x099B31` is now explicit as a 25-word structural lead-in, `0x099B32-0x099BAF`
  is an explicit big-endian offset table whose entries mostly point back into the local `0x099B00-0x0A0348`
  command payload, `0x099BB0-0x099BD2` now stands alone as an unreferenced prelude that further resolves into one
  lead byte, one tuple-led setup record, and one short `FD`-tagged bridge into the first table-targeted command,
  and `0x099BD3-0x09A347` is split in source into table-targeted ROM-order command records whose front is now a
  little less monolithic too: `0x099BD3-0x099C8E` is now explicit as a repeated family of tuple-style FF-terminated headers
  plus compact FF-terminated control bodies with short `FD xxxx` hand-offs, `0x099C8F-0x099D04` now stands as a
  denser tuple-plus-control pocket followed by two short tuple-led records with `F5/FE` tails and one final
  tuple-led bridge into `0x099D05`, and the former raw `0x099D78-0x099F23` stretch is now explicit as tuple-led and FF-terminated
  subrecords, including one shared bridge where `0x099E05` and the single-byte lead-in at `0x099E0A` feed
  the following `0x099E0B` target rather than the preceding `0x099DE6` body; the longer records at
  `0x099D05-0x099D47`, `0x099D48-0x099D77`, `0x09A10E-0x09A13B`, `0x09A13C-0x09A169`, `0x09A16A-0x09A198`,
  `0x09A199-0x09A287`, and `0x09A288-0x09A347` are explicit as smaller FF-terminated subrecords, with
  standalone gap/sentinel bytes now made explicit at `0x09A11D` and `0x09A26A` plus a short 2-byte lead-in
  at `0x09A22B-0x09A22C`. The former monolithic target at `0x09A348-0x09F776` is now also broken at later proven record starts into three command-record
  windows: `0x09A348-0x09C007`, `0x09C008-0x09E027`, and `0x09E028-0x09F776`, and each of those windows
  is now further split into explicit FF-terminated ROM-order record slices (154 + 189 + 149 records)
  with the former short non-terminated lead-out at `0x09F76A-0x09F776` now explicit too as one compact
  local-seeded tail rather than one grouped remainder. Byte-level
  review still shows the same strongest clues: the repeated local `0xFF` record endings, repeated 24-byte
  triplets at `0x09AB2A-0x09AB71`, `0x09E6F7-0x09E73E`, and `0x09F4D5-0x09F51C` are now explicit in source,
  the longer neighboring repeated-byte-pair records at `0x09A3EC-0x09A496` and `0x09E607-0x09E6B1` are
  source-authored too, and the `0x09A348-0x09C007` front command window is now fully source-visible at
  FF-terminated record granularity: the former lead-in at `0x09A348-0x09A3EB` now resolves into one tiny tuple,
  one compact local-control prelude, one broader `F4 25` high-byte pair pocket, and two short `0x9E/0xA0` tails,
  while the additional FF-terminated records at `0x09A497-0x09A4F9`, `0x09A4FA-0x09A55A`, `0x09A567-0x09A62C`,
  `0x09A59B-0x09A613`, `0x09A63B-0x09A6D6`, `0x09AA5C-0x09AB29`, `0x09AB72-0x09AB94`,
  `0x09AB95-0x09ABE0`, `0x09ABE1-0x09AF25`, `0x09AF26-0x09B090`, `0x09B091-0x09B289`,
  `0x09B28A-0x09B575`, `0x09B576-0x09B701`, `0x09B702-0x09B8C6`, and `0x09B8C7-0x09BFCF` are now explicit as the same compact
  command framing plus repeated byte-pair, literal-row, local-control, local-offset,
  literal/high-byte, or literal-control tails, the
  `0x09C008-0x09E027` middle command window is now fully source-visible at
  FF-terminated record granularity because the front-edge `0x09C008-0x09C0D6` family and the tiny caps at
  `0x09DEA9-0x09DEAE` are now explicit too alongside the earlier repeated-shape clusters at `0x09D981-0x09D9FE`
  and `0x09DBCC-0x09DC59` plus the neighboring singleton `0x09DE91-0x09DEA8`, and the later
  `0x09E028-0x09F776` tail window is a little less opaque because two more short FF-terminated family pockets
  at `0x09F00B-0x09F0AD` and `0x09F18C-0x09F271` are now source-authored with the same compact control framing
  plus repeated byte-pair ladders, the later records at `0x09F597-0x09F669` plus `0x09F66A-0x09F6AD`
  now also stand explicitly as one repeated literal-burst pair and one alternating local-control tail, and
  the final pre-lead-out pocket at `0x09F6AE-0x09F769` is no longer just raw slices either: it now exposes
  a compact local-seeded setup ladder at `0x09F6AE`, a short header/literal burst at `0x09F6C4`, a compact
  paired header-literal family at `0x09F6DE/0x09F6E8`, a two-row literal/control record at `0x09F706`, and a
  repeated `E4 .. 01 FA FA` local-offset ladder at `0x09F738`. The earlier pocket at
  `0x09F272-0x09F4D4` is a little less opaque too: it now exposes two compact D0/CA/DF/FE local-control
  sweeps at `0x09F272` and `0x09F351`, a neighboring byte-pair family at `0x09F2A5-0x09F3C5` that swaps
  among `F4 18` / `F4 05` fronts plus small `0xAx/0x4x` and `0x4x/0x3x` pair ladders, and one short
  literal/control pocket family at `0x09F3D6-0x09F459` built around the local `0x45/0x47/0x48/0x4A/0x4C`
  literal band. The neighboring late-tail pockets are a little less opaque too:
  `0x09E6B2-0x09E6E1` is now explicit as a compact low-byte ladder pair with `C0/C2/C4/C6` control pockets,
  `0x09E73F-0x09E791` as an E3-seeded short record plus a longer low-byte ladder continuation, and
  `0x09F0AE-0x09F18B` as one local-target sweep followed by two high-byte pair ladders around the recurring
  `0xA1/0xA3` and `0x9x/0x3x` payload families. The later `0x0A0000-0x0A4C76` island is also slightly less
  opaque now: the five former raw gaps inside `0x0A10AB-0x0A34FF` are source-authored as four short
  FF-terminated mixed bridge records plus one embedded-`$FF` tuple record, and the tiny `0x0A0C79-0x0A0C82`
  lead-in tail is now explicit `dc.b` data rather than a leftover `incbin`. The remaining uncertainty there is
  semantic format/owner evidence, not raw-byte coverage inside those isolated windows.
  The next late-tail bridge is a little less opaque too: `0x09E792-0x09E9A2` now stands as four explicit
  FF-terminated records where `0x09E792` opens with another `F7/F0` local-target sweep before expanding into
  long `0x9x/0xAx` high-byte pair ladders plus several `E4`-tagged local-offset hops, `0x09E8CA` keeps the
  same command neighborhood but narrows into repeated `0x9F/0x9E` byte-pair rows with short `F5 FB` /
  `F5 05` variations, `0x09E926` revisits the compact `CA/DF/FE` local-control sweep shape, and `0x09E963`
  follows with a denser literal/high-byte descent around the recurring `0x48/0x4A/0x4B/0x4D` family. The next
  neighboring bridge is a little less opaque too: `0x09E9E7-0x09ECD5` is now source-authored as sixteen more
  FF-terminated records where `0x09E9E7` continues the same `F4 1B` literal/high-byte ladder shape,
  `0x09EA5F` and `0x09EBDB` each return to compact local-control sweeps before short pair or literal tails,
  `0x09EAA0-0x09EAEA` keeps one short `F4 1F` high-byte ladder family explicit, `0x09EB07-0x09EB41` narrows
  into compact literal descents, `0x09EB51` and `0x09EB99` expose denser literal/high-byte pockets, and
  `0x09EC4A-0x09EC93` closes with tiny literal/control rows plus one alternating local-control bridge.
  The unresolved loader path into the now fully source-visible `0x098000-0x09907A`
  Z80 front is still the key evidence gap now that the front reset entry at `0x098000`, the short
  returning stub at `0x098006`, the mixed stub pocket at `0x098010`, the repeated absolute `JP $0F8C` stubs at
  `0x098020` / `0x098028` / `0x098030`, the tiny `NOP` / `RETI` handler at `0x098038`, and the former
  `0x09803B-0x098274` main-body prelude are all explicit in source. That prelude now reads as a startup /
  sequencing / slot-management bridge: `0x09803B-0x0980E1` resets the `0x1B80+`, `0x1C80+`, and `0x1ED1+`
  work areas and emits fixed setup bursts, `0x09810B-0x09815F` is a countdown-driven tick with a small
  phase initializer, `0x098160-0x09820A` advances and consumes an inline control stream, and
  `0x09820B-0x098274` seeds or updates `0x1EC0`-rooted slot descriptors from inline pointer lists. The
  `0x098275-0x098392` span is a little less opaque too: the bytes there now prove a six-entry
  meta-command jump table for raw values `$FF..$FA`, one tiny `$FB` handler, paired `$FA` / `$FE` handlers that
  only differ by which inline 3-byte record table they point `HL` at before a shared init tail, two short
  inline record tables at `0x09828D` and `0x0982B1`, a `$FC` target that scans ten `0x1EC0`-rooted slots, a tiny
  `$FD` bit-clear target, a packed-slot-index helper, two neighboring slot-drain helpers, and a `$FF` target that
  retires every active slot then clears nearby state bytes. The next bridge is a little less opaque too:
  `0x098393-0x098403` now selects one masked candidate record from three 0x40-byte record banks rooted at
  `0x1C80`, `0x1E00`, and `0x1E80` via a new 3-byte descriptor table at `0x098404-0x09840C`, while
  `0x09840D-0x098435` scans the `0x1C80` bank for a matching `(record+6, record+7)` pair keyed by `0x1C07`
  and the current `IX`-local packed delta, `0x098436-0x098445` packs a 0x40-byte record index from `IX`
  relative to `0x1C80`, `0x098446-0x0984B0` now finalizes one indexed selection path by splitting the
  local selector across `0x1C10/0x1C11`, taking one of two direct output/update branches for `(IX+1) >= 2`, or
  clearing four fixed output paths through `0x06C8` / `0x06E2` when `(IX+1) < 2`, `0x0984B1-0x098515` now exposes
  two neighboring helpers that derive a small table index from the high nibbles of `D/E`, read one 3-byte local
  record, and fold the residual through rounded halves, and `0x098516-0x09853B` now buckets the current high byte
  through fixed `0x60/0x30/0x18/0x0C` thresholds into `C` plus a reduced `D` remainder. The next bridge is a little
  less opaque too: `0x09853C-0x098578` now emits a nonzero-mode pair of encoded bytes to `0x7F11` through the
  descending odd-aligned table at `0x09913D`, `0x098579-0x09859A` is a neighboring zero-mode variant that instead uses
  `0x1C11 + 0xA4` plus the ascending odd-aligned table at `0x09907B`, `0x09859B-0x0985B9` now refreshes an IX-local
  target word only when its rounded-to-8-byte value changed, `0x0985BA-0x098615` now updates one indexed output band
  around IX-local bytes `+0x28/+0x29` while caching the last emitted band in `0x1C13`, and `0x098616-0x09867B` now
  handles the `(IX+1) < 2` case by walking four triplet-spaced IX-local rows through an 8-entry table at `0x098674`.
  The next bridge is a little less opaque too: `0x09867C-0x0986E1` now expands indexed 4-byte descriptor rows from
  the table at `0x164B`, mirrors changed bytes through the shared `0x06C3` emitter, and caches the final byte into the
  `0x4000` page selected by `0x1C10`; `0x0986E2-0x09870A` then combines the live input byte with `0x1C10/0x1C11` and
  writes a latched output pair to `0x4000/0x4001`; `0x09870B-0x098755` sweeps active `0x1C80`-rooted `0x40`-byte
  records while cycling `0x1C10/0x1C11` and calling the shared helper at `0x0756`; `0x098756-0x09875B` is now an
  explicit bit-6 gate on the IX-local flags byte; and `0x09875C-0x098771` sets that same bit, pushes `0x0772` as a
  local return target, and dispatches on `(IX+1)-2` to three deeper handlers.
  The next bridge is a little less opaque too: `0x098772-0x098865` now advances one primary IX-local stream whose
  special bytes in the `$F8-$FF` range reload or patch countdown, pointer, and delta-word state; `0x09886E-0x0988A0`
  conditionally folds an extra IX-local offset word into the working base when bit 4 is set; `0x0988A1-0x0988CD`
  resolves a secondary target word through the helper at `0x0B66`; `0x0988CE-0x098961` mirrors the same command-driven
  pattern for a secondary stream with step-byte state; and `0x098962-0x098975` now routes nonzero `(IX+1)` through
  `0x0976` before a bit-7 gate decides whether the deeper `0x053C -> 0x05BA` path should run.
  The next bridge is a little less opaque too: `0x098976-0x098A07` now advances another IX-local countdown/pointer
  pair and repacks a pointed control byte into the local `+0x2C`, `+0x30`, and `+0x28` state bytes; `0x098A08-0x098AA8`
  is now explicit as dispatch target `0x0A08`, indexing the fixed 19-byte bank-local record family rooted at local
  `0x1281` (ROM `0x099281`) before mirroring changed bytes and emitting four triplet-spaced row updates; `0x098AA9`
  is a tiny fixed-output prelude; `0x098AB2-0x098B5A` is now explicit as dispatch target `0x0AB2`, seeding several
  IX-local state fields from compact bank-local records rooted at local `0x1828`, `0x188F`, `0x1901`, and `0x19D8`;
  and `0x098B5B-0x098B7E` is now split as two tiny indexed-scratch helpers. The next bridge is a little less opaque too:
  `0x098B7F-0x098B9B` now sweeps ten marked `0x1EC0`-rooted slot records into a shared updater, and `0x098B9C-0x098CA4`
  advances one marked slot by reloading its pointed stream, snapshotting the local base word into `0x1C18/0x1C19`, and
  dispatching the next control byte through the local `0x0E62` handler table or the neighboring `0x0E55` / `0x0CA5`
  helper paths. The following continuation is a little less opaque too: `0x098CA5-0x098D80` now initializes one
  `IY`-local record from either a 6-byte descriptor family rooted at local `0x19F1` or the current `IX` slot plus the
  candidate-selection helpers at `0x040D` / `0x0446`; `0x098D81-0x098E12` then finalizes that transfer by calling the
  local helper at `0x0E1B`, deriving countdown bytes at `+0x3C/+0x3D`, mirroring slot ids/counters, and committing the
  initialized `IY` record; `0x098E1B-0x098E61` is now explicit as the nearby mode-table reader, low-nibble scale table,
  triplet-write-pointer helper, and triplet append helper; and `0x098E62-0x098F8B` now exposes the 32-entry high-command
  dispatch table for raw bytes `$E0..$FF` plus its local handlers, including the backward triplet walker at
  `0x098F56-0x098F8B`. The former `0x098F8C-0x09907A` continuation is now explicit too: the repeated jump stubs at
  `0x098020/0x098028/0x098030` all land on a structural state-snapshot / transfer-handshake routine that saves primary
  plus alternate register state into `0x1B80+`, copies three variable-length transfer slots out through the descriptor
  families at `0x1BA0/0x1BA8/0x1BB0`, raises handshake flags at `0x1B98/0x1B99`, waits for external acknowledgement by
  polling `0x1B99`, then copies those slots back locally and stamps the destination heads with `E7/EF/F7` before the
  local return tail at `0x09905E`. The whole `0x098000-0x09907A` Z80 front is therefore source-visible now; the wider
  loader path is still the key evidence gap instead of any remaining opaque bytes in that front body.
  The odd-aligned lookup tables remain open too, as does the still-unproven field meaning of the new
  19-byte, 16-byte, and 5-byte pre-descriptor records. The mid command window is a little less opaque too:
  `0x09C008-0x09C0D6` now exposes a front-edge family of compact `F4 00` high-byte-pair ladders around
  `0xA2/0x43`, `0x9F/0x42`, `0xA3/0x9C`, and `0x9F/0x98` before the already explicit `0x09C0D7+` local-control
  bridge; `0x09D9FF-0x09DA42`, `0x09DC5A-0x09DCD5`, and `0x09DEAF-0x09DF2A` are now source-authored as three more
  compact setup-plus-local-target records, each starting with an `F6/F7/F0` control ladder before dropping into
  short literal or high-byte-pair pockets. The neighboring bridges are a little less opaque too:
  `0x09C0D7-0x09C252` is now explicit as one compact local-control sweep into a dense
  `0x4F/0x4E/0x4D/0x4C/0x4B/0x48` literal/high-byte pocket plus a neighboring `F4 00 C2/C4 F5 12`
  literal-control family around `0x00/0x05/0x0F`, `0x09C253-0x09C5B0` now fills in the next bridge as one
  alternating local-control sweep into small literal-row continuations, compact local-target and `F4 10`
  mixed literal/high-byte rows, one broader `0xA9/0x4C` plus `0x9C/0x3D` / `0x99/0x3F` ladder, and a final
  repeated `0x60/0x10/0x05` local-control burst, `0x09C62F-0x09C686` now stands as four short `F4 04`
  literal-control records with one small `E2 A8` local-offset hop, `0x09C687-0x09C98C` now exposes a broader
  repeated literal-row cycle around `0x2B/0x29/0x27` with shorter `0x32/0x30/0x2E` and `0x3E/0x3C/0x3A`
  tails plus one neighboring compact local-target setup into a `0x9E/0xA1/0x9F/0xA4/0xA5` high-byte pair
  ladder, and `0x09C98D-0x09CBED` now continues that same mid-window neighborhood as a compact
  `F4 00` high-byte ladder pair followed by a broader local-control-to-literal/high-byte descent around
  `0x52/0x51/0x4F`, `0x4D/0x4E`, and `0x54/0x56/0x57/0x59`, then one short local-control bridge into a
  repeated `0x00/0x05` literal-control row. `0x09DA43-0x09DB5A` is now explicit as
  one compact `F4/F1/F5` family with short `0xBx/0x5x` plus `0xAx/0x4x` high-byte pair ladders and two tiny
  literal-control pivots, while `0x09DCD6-0x09DE57` now exposes one short `0x05/0x0D` literal-control pair
  family, two adjacent `0x60/0x65/0x6C/0x6D` burst records, a compact local-target sweep, and three
  pair-ladder continuations. The next useful evidence target
  is still the loader or bank-switch path that enters this region, so these labels can move from structural
  names to subsystem ownership. Two neighboring bridge pockets are a little less opaque now too:
  `0x09DB5B-0x09DBCB` stands as one compact setup/local-target sweep with `E0/E1`-tagged local steps plus
  two short literal-row continuations, `0x09DE58-0x09DFB3` now adds one more compact setup bridge plus a
  repeated `0x9x/0xAx` high-byte ladder around the recurring `B4 59` anchor and a short descending tail,
  and the adjacent `0x09DFB4-0x09E027` continuation now also stands explicitly as one more compact
  `F4 08` high-byte pair ladder family with a short `0xAC/0xAB/0xAA` to `0xA7/0xA5/0xA4/0xA3/0xA0`
  sweep followed by a denser descending `0xA7/0xA5/0xA3/0xA1/0xA0/0x9E/0x9C/0x9B` tail. The front edge of the
  following tail window is a little less opaque now too: `0x09E028-0x09E22A` exposes one compact local-control
  sweep into a descending `0xAA/0xB8/0xB6/...` high-byte ladder, a neighboring local-control-to-literal-control
  bridge at `0x09E08A`, a short `F4 05 C2` literal/control family across `0x09E0E5-0x09E1C7`, and a return to
  denser local-control-plus-literal-pair framing at `0x09E1CC-0x09E22A`. The next adjacent front-edge pocket is a
  little less opaque too: `0x09E237-0x09E384` now stands explicitly as one short local-control-to-literal climb,
  one descending `AF/AE/AD` high-byte-pair family plus two compact AC-rooted local-offset variants, one broader
  `F7/F0` local sweep into a longer `0x57..0x4A` literal/high-byte ladder, and four short `F4 08` tails around the
  recurring AA/A9/A8 and A7 anchors plus tiny literal-band closers; the next adjacent pocket at
  `0x09E385-0x09E604` is a little less opaque too, with a short `F4 08` literal crest, two compact
  `F4 00` literal-control rows, one longer local-control/local-offset bridge into repeated
  `0x2B/0x2A/0x29/0x28` literal-pair ladders, a compact `0x3E/0x40/0x41/0x42` rise, one broader
  `0x43/0x47/0x48/0x4A/0x4C` literal/high-byte ladder, and a short closing descent around
  `0x53/0x58/0x56/0x4F` plus one final `0x60/0x0F/0x10/0x05` burst,
  `0x09F51D-0x09F596` now exposes one more `CA/DF/FE`-style local-control sweep followed by a short
  `F4 00 C2` literal/control pair around the same `0x60/0x65/0x6C/0x0F` pocket immediately before the already
  explicit repeated-burst family at `0x09F597`, the later `0x09E6E2-0x09E9E6` continuation now also
  exposes one more compact low-byte ladder bridge plus a short `F4 1B` literal-descent pocket with two
  neighboring mini-records at `0x09E9CC` and `0x09E9DA`, and the next bridge at `0x09ECD6-0x09EFD2` now
  resolves into a compact repeated `0x2D/0x2E` literal-pair family, several short local-control or
  local-target setup bridges, two adjacent `F4 04` / `F4 08` literal-plus-high-byte ladders, and one tiny
  local-offset-seeded `0x2D` pair pocket at `0x09EE81-0x09EE9A`. The following `0x09EFD3-0x09F00A` bridge
  now also stands explicitly as one descending literal-pair ladder with the same compact `F4/F5` framing
  before the already split `0x09F00B+` family, and the final `0x09F76A-0x09F776` tail now stands explicitly
  as a compact local-seeded `88 78 01 D3` + `F6/F7` ladder ending in the final two zero bytes before fill.
  The neighboring mid-window pocket is a little less opaque now too: `0x09CBEE-0x09CFBC` now stands
  explicitly as one short `F4 00` literal-control pair, three broader setup bridges at
  `0x09CC16-0x09CCEC`, a local-seeded literal row plus compact `F4 14` ladders and tiny cap records at
  `0x09CD3C-0x09CD8D`, one short same-window sweep plus a neighboring `F4 14` literal/high-byte ladder family
  at `0x09CD90-0x09CE48`, a compact `F4 1A` low-byte ladder family at `0x09CE49-0x09CEF2`, and a broader
  local-target sweep plus final local-control-to-literal-row bridge at `0x09CEF7-0x09CF77`.
  The next adjacent mid-window run is a little less opaque now too: `0x09CFBD-0x09D341` now stands
  explicitly as one denser `F4 F0` literal-row cycle, a compact `F4 20` row-family pocket with two tiny caps,
  a broader setup bridge into mixed `0x3C/0x3E/0x40/0x41/...` literal rows, a neighboring compact
  `0xAC/0xAA/0xA8/.../0xA1` high-byte ladder, one later repeated literal-row descent around
  `0x3C/0x3B/0x39/0x37/0x35/0x34/0x32/0x30`, and a short literal-control family plus repeated `F4 FC`
  pair-ladder cluster leading into the now explicit `0x09D342-0x09D5BE` continuation. That next adjacent
  run is a little less opaque now too: `0x09D342-0x09D40F` continues the same repeated-pair neighborhood with
  two broader `0x29/0x30/0x35/0x37/0x32/0x34` row cycles plus one shorter mixed tail, `0x09D429-0x09D464`
  exposes the compact local-target bridge into the next family, and `0x09D48A-0x09D5A9` now stands explicitly
  as one compact `F4 2C` high-byte/literal pocket around `0x9E/0x9C/0x9B`, `0x99/0xA0/0x9E`, `0x95/0x97/0x9C`,
  and a short `0xAC/0xAA/0xA8/0xA6/0xA5/0xA3` tail before two tiny literal ladders. The middle-window
  neighborhood is a little less opaque now too: `0x09D5BF-0x09D633` is now explicit as a
  compact `F4 2C` family that alternates `0x9E/0x9C/0x9B` high-byte descents with neighboring
  `0x43/0x47/0x4A/0x4D/0x4F` literal ladders, `0x09D66B` now stands as a longer D0/D1 local-target sweep
  plus a small `0x43` literal cap, `0x09D6D9-0x09D82A` widens into a broader `F4 0C` literal/high-byte
  ladder family around `0x43/0x45/0x47/0x48/0x4A/0x4C/0x4D/0x4F/0x51`, `0x09D85B-0x09D8F5` revisits the
  local `0x60/0x65` burst neighborhood with compact `0x0B/0x08/0x0D/0x07/0x13/0x14/0x15` control rows,
  and `0x09D922` now stands explicitly as an alternating D2/D6/D0 local-control bridge into the already
  split repeated `F4 10` pair-ladder cluster at `0x09D981`. The front-window neighborhood is a little
  less opaque now too: `0x09A4FA-0x09A55A` now reads as a short `F4 15` literal-row cycle around
  `0x29/0x30/0x35/0x3C`, `0x09A567-0x09A62C` as a compact local-seeded bridge with repeated `E4 .. 01`
  local-offset hops plus tiny `0x48/0x4A` and `0x49/0x48/0x46` literal tails, `0x09A6D7-0x09A7FC` is explicit as one local-control / literal-control burst family
  plus a short local-target sweep into a compact `F4 F8` literal-pair tail, `0x09A875-0x09A9CB` now
  resolves into a longer `F4 11` literal/high-byte ladder followed by a shorter `0x4C/0x4D/0x4F/0x51`
  ladder with small `E2`/`E3` hops and one compact `0x39/0x35/0x40/0x3C/.../0x2F` descent, and
  `0x09A9CD-0x09AA5B` now stands as two tiny `F4 05` literal rows plus an `E4`-tagged local-offset ladder
  with eight short 4-byte literal rows. The next useful evidence target is still the loader or bank-switch
  path that enters the wider `0x099B00-0x09F776` command region, so these structural command families can
  move from byte-shape names to real subsystem ownership now that no raw coverage remains anywhere in the
  dedicated `src/bank080000_mid_command_front.asm` owner for the `0x099A85-0x09A347` pre-window command front.
  The newly explicit `0x09B8C7-0x09BFCF` follow-up
  now also sharpens that front command-window picture: it begins with a compact `F4 04` row neighborhood
  around `0x30/0x37/0x39/0x3C`, moves through a local-control plus `0x07/0x12/0x72/0x09` literal-control
  pocket, shifts into a short `F4 07` literal-row family, broadens into several `F4 1B` literal/high-byte
  ladders around `0xA0/0x48`, `0x47/0x48/0x4B/0x4C`, `0xA8/0x4D`, and the recurring
  `0x40/0x41/0x44/0x45/0x47/0x4A/0x4D/0x50` descent, and then closes with one more compact `F4 00`
  literal-control / literal-row pocket around `0x0C/0x0D/0x0E/0x0F/0x05`, `0x24/0x2A/0x2B`,
  `0x30/0x2B/0x27`, and `0x3C/0x3B/0x3A/0x38`.
- Determine the exact owner and record format for the next bank `0x080000` non-fill island at
  `0x0A0000-0x0A4C76`. The front `0x0A0000-0x0A07C5` bytes are now explicit in source as a nested
  big-endian offset-table tree: a root table at `0x0A0000`, a denser second-stage block at
  `0x0A01C8`, and a short tail at `0x0A07BC`. Most words point back into the same island, often to
  later words or to the downstream payload, which makes this look like a table-driven resource index
  rather than random packed data. The first payload band is now split farther in source as a continued
  run of repeated `0x18`-byte records from `0x0A07C6-0x0A0B25`, each still fitting four 6-byte tuples,
  but the tuple semantics and higher-level owner remain unresolved. The later half is no longer
  completely monolithic either: the old single lead-in at `0x0A0B26-0x0A34FF` is now split into an
  earlier mixed lead-in whose front `0x0A0B26-0x0A0C78` span is source-authored as 26 short
  FF-terminated structural records plus a final 10-byte tail at `0x0A0C79-0x0A0C82`, and the next
  `0x0A0C83-0x0A10AA` lead-in window is now completely source-visible too: four narrower FF-terminated 6-byte
  record bands at `0x0A0C83-0x0A0D18`, `0x0A0D3F-0x0A0D74`, `0x0A0E85-0x0A0F2C`, and `0x0A0FA9-0x0A10AA`, plus
  three formerly raw bridge pockets at `0x0A0D19-0x0A0D3E`, `0x0A0D75-0x0A0E84`, and `0x0A0F2D-0x0A0FA8` that now
  resolve into explicit FF-terminated mixed records with only short non-terminated tails at `0x0A0D3A-0x0A0D3E`
  and `0x0A0F95-0x0A0FA8` and a singleton `$FF` marker at `0x0A0E84`, then a much
  more structured `0x0A10AB-0x0A34FF` region that mostly resolves into FF-terminated runs whose payload
  lengths are multiples of 5 bytes, interrupted only by five short mixed gaps at `0x0A136E-0x0A1377`,
  `0x0A1D3F-0x0A1D4E`, `0x0A23F6-0x0A23FF`, `0x0A2586-0x0A258A`, and `0x0A2606-0x0A260F`. The earlier
  pockets at `0x0A1322-0x0A132C`, `0x0A1406-0x0A1410`, `0x0A2765-0x0A27CA`, `0x0A2D86-0x0A2D9A`, and
  `0x0A3040-0x0A304A` now also stand explicitly as FF-terminated records once the embedded `$FF` tuple
  bytes are treated as data rather than false boundary noise. The back half at `0x0A3500-0x0A4C76` still
  has table-targeted stable starts
  are already proven by the front offset tree. The full regular 5-byte-tuple body at
  `0x0A10AB-0x0A34FF` is now split all the way down to individual FF-terminated record starts in ROM order,
  including the singleton `$FF` record at `0x0A1378`. The
  new 6-byte families have a strong local shape,
  (constant trailing `$FF`, repeated first-byte groups like `$0A/$05/$0B/$0E`, and selector-like second
  bytes such as `$00`, `$20`, `$60`, and `$02`), while the newly split `0x0A0B26-0x0A0C78` record family
  now shows a looser but still repeat-heavy FF-terminated prelude built from short local-offset/control-like
  chunks before the regular 6-byte bands, and the newer `0x0A10AB+` body now strongly suggests
  a different FF-delimited 5-byte tuple family. That still does not prove the exact role of either
  family. The regular runs now cover the full span through `0x0A34FF`, including the windows at
  `0x0A1411-0x0A1D3E`, `0x0A1D4F-0x0A23F5`, `0x0A2400-0x0A2585`, `0x0A258B-0x0A2605`, `0x0A2610-0x0A2764`,
  `0x0A27CB-0x0A2D85`, `0x0A2D9B-0x0A303F`, and `0x0A304B-0x0A34FF`; the middle two windows now also
  stand directly as explicit `dc.b` tuples instead of record-local `incbin` slices, and the `0x0A1411-0x0A1D3E`
  window now also makes its early mirrored quadrant variants plus its later compact `0x60/0x68` and `0x40/0x48`
  pockets directly visible in source; the first of those later windows still begins with
  two singleton `$FF` records before settling back into the usual small tuple multiples. The whole regular
  `0x0A10AB-0x0A34FF` family is now source-visible in ROM order; `0x0A1D4F-0x0A23F5` is no longer
  a run-sized wrapper either and now makes its singleton `$FF` lead-in, mirrored `0x42` page
  rows, central `0x60/0x61` ladder, and late low-page pockets directly visible in source
  with only the short anomaly gaps still grouped as mixed payload. The last three run-local length histograms
  are now explicit too: `0x0A27CB-0x0A2D85` has sizes `6/11/16/21/31/36/41/46/56/76/81/86/91`,
  `0x0A2D9B-0x0A303F` has `6/11/21/46`, and `0x0A304B-0x0A34FF` has `6/11/16/21/41`. Two more middle
  windows are cleaner now too: `0x0A2400-0x0A2585` exposes paired `0x60/0x68` and `0x40/0x48` variants up
  front, then a compact `0x01`-page cluster around `0xE0-0xFE`, and finally a late `0x60/0x61` ladder;
  `0x0A27CB-0x0A2D85` now makes its front `0x61` staircase, compact `0x20/0x00/0x10/0x18` pocket, larger
  `0x68/0x69` composite middle, and late `0x60/0x61` ladder directly auditable in source instead of hiding
  behind record-local slices. That still does not prove the exact role of the tuple family. The back half at `0x0A3500-0x0A4C76` is also a little less
  opaque now: besides generic table-targeted slices, it now exposes a 12-record 3-word band at
  `0x0A37B0-0x0A37F7`, a source-authored compact local-offset/control pocket at `0x0A37FE-0x0A3B76`,
  a 16-record local-offset-triplet band at `0x0A3B77-0x0A3C16` whose entries point back into the
  `0x0A12EC-0x0A1519` tuple family, three more ROM-order source-authored compact-control continuations at
  `0x0A3C17-0x0A43D4`, `0x0A43D5-0x0A47D8`, and `0x0A47D9-0x0A4AA2`, then a small self-referencing tail
  cluster at `0x0A4AA3-0x0A4AEB` made of eight 3-word records plus an FF-terminated local-offset list naming
  those same starts. The front of the `0x0A3500+` back half is a little less opaque too: `0x0A3500-0x0A37AF`
  is now source-authored as a compact record family whose repeated `FC/FB` prefixes and local 24-bit offsets
  point back into the earlier `0x0A07C6-0x0A0D80` tuple bands, the `0x0A37FE-0x0A4AA2` continuation repeats
  the same structural motif while also reaching into the later `0x0A0E85-0x0A12E5`, `0x0A12EC+`, `0x0A157B+`,
  `0x0A319E+`, `0x0A323F+`, and `0x0A3476+` families with short local-offset lists plus `FF`/`FD` tails,
  and the final `0x0A4AEC-0x0A4C76` continuation now shows one more compact control pocket with three
  standalone local offsets up front. The controlling loader and field roles are still unproven.
  The next useful evidence target is still the 68k-side code that selects one of these offsets or the
  downstream record decoder that interprets the `0x0A07C6+` and `0x0A3500+` payload families.
- Determine the consumer and tag semantics for the newly split bank `0x040000` front table cluster at
  `0x041000-0x07FF66`. The bytes now prove a repeated four-byte `[tag][24-bit ROM address]` shape with
  an earlier bank-front pre-table island at `0x040000-0x0409F9` that is no longer monolithic either:
  that front span is now split conservatively at `0x040100`, `0x04025C`, `0x040400`, `0x04053C`,
  `0x0406C4`, and `0x0408D4` because those starts repeat short header-like prefixes (`FFFF 000A`,
  `FFFF 000E`, and `0000 0102`-style lead-ins) before the explicit fill run at `0x0409FA`,
  a large local-target run at `0x041000-0x0418AB`, a cross-bank run at `0x0418AC-0x041B3F`, a short
  tail table at `0x041B80-0x041BBF`, explicit `0xFF` fill gaps on both sides of that tail, and an
  expanded local-target payload window at `0x041C00-0x07FF66` whose internal ROM-order starts are now
  source-visible almost to the end of the bank. The top byte is mostly `$02` with smaller `$00`, `$01`,
  and `$FF` sentinel cases. One part is now stronger than before: every same-bank `$01` target lands on the
  isolated `0x045842-0x045D01` block or one of the later `0x04BFAA-0x04E5A9`, `0x05C5DA-0x05CA99`,
  `0x05D630-0x05FC2F`, and `0x06B192-0x06BB11` families, all of which cleanly fit `0x4C0` bytes = 38
  Mega Drive 4bpp planar tiles. It is therefore safe to treat `$01` as a planar-tile variant, but the
  payload body and the remaining `$00` / `$02` distinctions still need the 68k-side owner before they can
  be named beyond flagged references and table-targeted records. The next
  useful evidence target is the code or descriptor path that loads `0x041000` as a table base or
  dispatches into the `0x041C00+` / `0x0801CD+` target ranges, especially now that the cross-bank side is
  also split in source as 178 ROM-order starts across `0x0801CD-0x0961D7` with explicit untargeted gaps
  at `0x093FD1-0x094149` and `0x0961D8-0x09622A`. The planar-tile targets remain particularly strong
  evidence targets because the flagged table/consumer path could now promote them from generic tile blocks
  to specific map, UI, sprite, font, or other graphics ownership once found, and the unresolved `$00`
  versus `$02` split may still expose a second resource distinction in the same table.
