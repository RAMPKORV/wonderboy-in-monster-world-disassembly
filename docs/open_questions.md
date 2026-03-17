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
  `0x020E4C-0x0211C9`. Both target domains are now split in source into ROM-order short record slices,
  which confirms that the front bank is dealing with real record families rather than random earlier
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
  `0x0354F4-0x03C6DF`. That leaves only `0x03C6E0-0x03FFFF` as the final unsplit tail in this bank
  region. The strongest current byte-level evidence is still structural: header-like prefixes such as
  `0x0660`, `0x0B60`, `0x0F00`, and `0x0960`, heavy fill-style runs, and alternating `0xFF7A` /
  `0xFF7B` block terminators that look more like compressed graphics/data families than scripts or plain
  tables. The next useful evidence target is a loader/decompressor path that proves whether these are map,
  tile, sprite, or other asset blocks and whether `0xFF7A` and `0xFF7B` are true format variants or just
  sibling terminators inside one codec family.
- Determine the exact owner of the bank `0x080000` non-fill island at `0x098000-0x09F776`.
  The front `0x098000-0x09991F` slice is now split out as a strongly Z80-like opcode-dense block,
  the next `0x099920-0x09997F` slice is now explicit as sixteen fixed 6-byte descriptor-like records,
  `0x099980-0x099A74` is now explicit as forty-nine fixed 5-byte layout-like records, and
  `0x099A75-0x099A84` stands apart as a short trailer,
  `0x099A85-0x099AFF` is explicit zero fill, and the `0x099B00+` command region now has a clearer
  front split: `0x099B00-0x099B31` is a short lead-in, `0x099B32-0x099BAF` is an explicit big-
  endian offset table whose entries mostly point back into the local `0x099B00-0x0A0348` command
  payload, `0x099BB0-0x099BD2` now stands alone as an unreferenced prelude, and `0x099BD3-0x09A347`
  is split in source into table-targeted ROM-order command records. The former monolithic target at
  `0x09A348-0x09F776` is now also broken at later proven record starts into three command-record
  windows: `0x09A348-0x09C007`, `0x09C008-0x09E027`, and `0x09E028-0x09F776`, and each of those windows
  is now further split into explicit FF-terminated ROM-order record slices (154 + 183 + 149 records)
  with only the short non-terminated lead-out at `0x09F76A-0x09F776` left grouped as a tail. Byte-level
  review still shows the same strongest clues: the repeated local `0xFF` record endings, repeated 24-byte
  triplets at `0x09AB2A-0x09AB71`, `0x09E6F7-0x09E73E`, and `0x09F4D5-0x09F51C`, and the unresolved
  68k-side entry path into this region. The next useful evidence target is still the loader or bank-switch
  path that enters this region, so these labels can move from structural names to subsystem ownership.
- Determine the exact owner and record format for the next bank `0x080000` non-fill island at
  `0x0A0000-0x0A4C76`. The front `0x0A0000-0x0A07C5` bytes are now explicit in source as a nested
  big-endian offset-table tree: a root table at `0x0A0000`, a denser second-stage block at
  `0x0A01C8`, and a short tail at `0x0A07BC`. Most words point back into the same island, often to
  later words or to the downstream payload, which makes this look like a table-driven resource index
  rather than random packed data. The first payload band is now split farther in source as a continued
  run of repeated `0x18`-byte records from `0x0A07C6-0x0A0B25`, each still fitting four 6-byte tuples,
  but the tuple semantics and higher-level owner remain unresolved. The later half is no longer
  completely monolithic either: the old single lead-in at `0x0A0B26-0x0A34FF` is now split into an
  earlier mixed patch at `0x0A0B26-0x0A0C82`, four narrower FF-terminated 6-byte record bands at
  `0x0A0C83-0x0A0D18`, `0x0A0D3F-0x0A0D74`, `0x0A0E85-0x0A0F2C`, and `0x0A0FA9-0x0A10AA`, then a much
  more structured `0x0A10AB-0x0A34FF` region that mostly resolves into FF-terminated runs whose payload
  lengths are multiples of 5 bytes, interrupted only by short anomaly gaps at `0x0A1322-0x0A132C`,
  `0x0A136E-0x0A1377`, `0x0A1406-0x0A1410`, `0x0A1D3F-0x0A1D4E`, `0x0A23F6-0x0A23FF`,
  `0x0A2586-0x0A258A`, `0x0A2606-0x0A260F`, `0x0A2765-0x0A27CA`, `0x0A2D86-0x0A2D9A`, and
  `0x0A3040-0x0A304A`, and then a table-targeted back half at `0x0A3500-0x0A4C76` whose stable starts
  are already proven by the front offset tree. The first three 5-byte-tuple runs are now split all the way down to
  individual FF-terminated record starts at `0x0A10AB-0x0A1321`, `0x0A132D-0x0A136D`, and `0x0A1378-0x0A1405`,
  including a singleton `$FF` record at `0x0A1378`, but the later runs still remain grouped at run granularity. The
  new 6-byte families have a strong local shape
  (constant trailing `$FF`, repeated first-byte groups like `$0A/$05/$0B/$0E`, and selector-like second
  bytes such as `$00`, `$20`, `$60`, and `$02`), while the newer `0x0A10AB+` body now strongly suggests
  a different FF-delimited 5-byte tuple family. That still does not prove the exact role of either
  family. The first eight 5-byte-tuple runs are now split to individual record starts through
  `0x0A2764`, including the later windows at `0x0A1D4F-0x0A23F5`, `0x0A2400-0x0A2585`,
  `0x0A258B-0x0A2605`, and `0x0A2610-0x0A2764`; the first of those even begins with two singleton `$FF`
  records before settling back into the usual small tuple multiples. The later runs at
  `0x0A27CB-0x0A2D85`, `0x0A2D9B-0x0A303F`, and `0x0A304B-0x0A34FF` are now also split all the way down to
  individual record starts, so the whole regular `0x0A10AB-0x0A34FF` family is source-visible in ROM order
  with only the short anomaly gaps still grouped as mixed payload. The last three run-local length histograms
  are now explicit too: `0x0A27CB-0x0A2D85` has sizes `6/11/16/21/31/36/41/46/56/76/81/86/91`,
  `0x0A2D9B-0x0A303F` has `6/11/21/46`, and `0x0A304B-0x0A34FF` has `6/11/16/21/41`. That still does not
  prove the exact role of the tuple family. The back half at `0x0A3500-0x0A4C76` is also a little less
  opaque now: besides generic table-targeted slices, it now exposes a 12-record 3-word band at
  `0x0A37B0-0x0A37F7`, a 16-record local-offset-triplet band at `0x0A3B77-0x0A3C16` whose entries point
  back into the `0x0A12EC-0x0A1519` tuple family, and a small self-referencing tail cluster at
  `0x0A4AA3-0x0A4AEB` made of eight 3-word records plus an FF-terminated local-offset list naming those
  same starts. The next useful evidence target is still the 68k-side code that selects one of these
  offsets or the downstream record decoder that interprets the `0x0A07C6+` and `0x0A3500+` payload families.
- Determine the consumer and tag semantics for the newly split bank `0x040000` front table cluster at
  `0x041000-0x07FF66`. The bytes now prove a repeated four-byte `[tag][24-bit ROM address]` shape with
  a large local-target run at `0x041000-0x0418AB`, a cross-bank run at `0x0418AC-0x041B3F`, a short
  tail table at `0x041B80-0x041BBF`, explicit `0xFF` fill gaps on both sides of that tail, and an
  expanded local-target payload window at `0x041C00-0x07FF66` whose internal ROM-order starts are now
  source-visible almost to the end of the bank. The top byte is mostly `$02` with smaller `$00`, `$01`,
  and `$FF` sentinel cases, so it is safer to treat the front records as flagged ROM references and the
  payload body as table-targeted records rather than plain pointers or named assets until the 68k-side
  owner proves what the flag means and what kind of resource families live behind the targets. The next
  useful evidence target is the code or descriptor path that loads `0x041000` as a table base or
  dispatches into the `0x041C00+` / `0x0801CD+` target ranges, especially now that the cross-bank side is
  also split in source as 178 ROM-order starts across `0x0801CD-0x0961D7` with explicit untargeted gaps
  at `0x093FD1-0x094149` and `0x0961D8-0x09622A`. The same-bank fixed-stride bands at
  `0x04BFAA-0x04E5A9` and `0x05D630-0x05FC2F`, plus the later shorter pair at `0x06B192-0x06BB11`,
  remain particularly strong evidence targets because their cadence could help identify the shared
  payload family once the consumer is found.
