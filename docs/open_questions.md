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
  `0x020E4C-0x021195`. That is enough to justify explicit source-owned pointer and offset tables, but not
  yet enough to say whether the owner is a dictionary/dialogue builder, a menu text catalog, or some
  broader script/text dispatcher without the 68k-side code that loads these table bases.
- Determine the consumer and field semantics for the next bank `0x020000` structured island at
  `0x022460-0x022C5F`. The front `0x022460-0x0224BF` bytes are now split as six 0x10-byte same-bank
  reference descriptors, `0x0224C0-0x0225D7` is a monotone big-endian offset table that fits a
  payload base at `0x0225D8`, `0x022662-0x02292B` is now source-authored as a table-targeted payload
  family with one `0x8A`-byte lead-in plus mostly 6-byte short records and eight 8-byte variants, and
  `0x02292C-0x022AEB` is a stable 0x10-byte repeated descriptor band. That is enough to justify
  source-owned table labels and record boundaries, but not yet enough to call the region map, object,
  or script data. The next useful evidence target is the bank-local or low-ROM code that indexes the
  `0x0224C0` table, explains the duplicate `$0260` offset entry, or lands on the repeated records.
- Determine the consumer and field semantics for the later bank `0x020000` structured island at
  `0x023AB6-0x024537`. The bytes there are now split in source as a long band of big-endian word
  records whose boundaries are repeatedly marked by `$FFFF` sentinels, and several subfamilies share
  stable field counts or coordinate-like word patterns. That is enough to justify a ROM-order record
  split, but not yet enough to call the region menu layout data, object placement, script payloads, or
  another subsystem without the code that scans those sentinels or consumes the resulting fields.
- Determine the exact owner of the bank `0x080000` non-fill island at `0x098000-0x09F776`.
  The front `0x098000-0x09991F` slice is now split out as a strongly Z80-like opcode-dense block,
  the next `0x099920-0x09997F` and `0x099980-0x099A84` slices behave like descriptor/layout data,
  `0x099A85-0x099AFF` is explicit zero fill, and the `0x099B00+` command region now has a clearer
  front split: `0x099B00-0x099B31` is a short lead-in, `0x099B32-0x099BAF` is an explicit big-
  endian offset table whose entries mostly point back into the local `0x099B00-0x0A0348` command
  payload, `0x099BB0-0x099BD2` now stands alone as an unreferenced prelude, and `0x099BD3-0x09A347`
  is split in source into table-targeted ROM-order command records. One outlier word (`$F7FD`) still
  resists that local pattern, and the final table target at `0x09A348` still expands into a very
  large trailing record through `0x09F776`. The next useful evidence target is still the 68k-side
  loader or bank-switch path that enters this region, so these labels can move from structural names
  to subsystem ownership.
- Determine the exact owner and record format for the next bank `0x080000` non-fill island at
  `0x0A0000-0x0A4C76`. The front `0x0A0000-0x0A07C5` bytes are now explicit in source as a nested
  big-endian offset-table tree: a root table at `0x0A0000`, a denser second-stage block at
  `0x0A01C8`, and a short tail at `0x0A07BC`. Most words point back into the same island, often to
  later words or to the downstream payload, which makes this look like a table-driven resource index
  rather than random packed data. The first payload band at `0x0A07C6-0x0A08E5` is now also split
  in source as twelve repeated `0x18`-byte records, each with four 6-byte tuples, but the tuple
  semantics and higher-level owner are still unresolved. The later half is no longer completely
  monolithic either: `0x0A08E6-0x0A34FF` now stands as a separate unresolved lead-in, and
  `0x0A3500-0x0A4C76` is split in ROM order into table-targeted record slices because the same front
  offset tree already references stable starts throughout that back half. Raw-byte review still
  suggests much of the unresolved lead-in continues as a longer 6-byte tuple stream, with a more
  homogeneous motif beginning around `0x0A0E86`, but that motif change is not yet a loader-proven
  boundary. The next useful evidence target is the 68k-side code that selects one of these offsets or
  the downstream record decoder that interprets the `0x0A08E6+` payload families.
