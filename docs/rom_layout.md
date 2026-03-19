# ROM Layout

## Coarse Regions

- `0x000000-0x0000FF` vector table
- `0x000100-0x0001FF` Mega Drive header
- `0x000200-0x004FFF` bootstrap and early startup code blob
- `0x005000-0x01FFFF` early engine/code-heavy body blob
- `0x020000-0x03FFFF` mid-ROM mixed code/data blob
- `0x040000-0x07FFFF` late-ROM mixed code/data blob
- `0x080000-0x0BFFFF` tail banks with heavy `0xFF` fill and likely large data banks

## Current Source Ownership

- `header.asm` owns `0x000000-0x0001FF`
- `src/init.asm` owns `0x000200-0x004B57` through `data/rom/init_000200_004b57.bin`
- `src/vblank.asm` owns `0x004B58-0x004FFF` through `data/rom/vblank_004b58_004fff.bin`
- `src/core.asm` owns `0x005000-0x01FFFF` through `data/rom/core_005000_01ffff.bin`
- `src/bank020000.asm` owns `0x020000-0x03FFFF` and now also splits a front dialogue/script continuation at `0x020000-0x0201CF`, two front bank-relative text/control record families at `0x0201D0-0x020539` and `0x020E4C-0x0211C9`, an intervening dialogue/script continuation at `0x02053A-0x020E4B`, a front bank-relative text-index island at `0x0211CA-0x02135F`, a quiz/text/name band at `0x021360-0x02245F`, the first post-dictionary descriptor/index island at `0x022460-0x022DB7`, a later sentinel-delimited word-record band at `0x023AB6-0x024537`, and a partially decomposed compressed-data tail at `0x02482C-0x03FFFF` whose `0xFF7A`/`0xFF7B` block boundaries are now explicit through `0x03C6DF` and whose final bank-end remainder is further split into five header-like sub-blocks at `0x03C6E0`, `0x03E846`, `0x03EF4E`, `0x03F4D1`, and `0x03FE24`
- `src/bank040000.asm` owns `0x040000-0x07FFFF` and now also splits the front pre-table island at `0x040000-0x0409F9` into a lead-in plus six smaller header-like sub-blocks, a flagged ROM-reference table cluster at `0x041000-0x041BFF`, an expanded local-target payload window at `0x041C00-0x07FF66` whose repeated `0x4C0`-byte families now stand in their own ROM-order graphics/tile submodules at `0x04BFAA-0x04E5A9`, `0x05C5DA-0x05CA99`, `0x05D630-0x05FC2F`, and `0x06B192-0x06BB11`, a tiny trailing remainder at `0x07FF67-0x07FFFF`, and the confirmed `0xFF` fill run at `0x0409FA-0x040FFF`
- `src/bank080000.asm` owns `0x080000-0x0BFFFF` and now also splits the former opaque pre-fill front at `0x0801CD-0x0961D7` into cross-bank table-targeted ROM-order payload records plus two explicit untargeted gaps (`0x093FD1-0x094149` and `0x0961D8-0x09622A`) based on the flagged ROM-reference tables in bank `0x040000`; the same owner also splits the `0x098000-0x09F776` non-fill island into a Z80-like front body at `0x098000-0x09907A`, two odd-aligned little-endian word lookup tables at `0x09907B-0x09913C` and `0x09913D-0x0991FE`, a trailing zero byte at `0x0991FF`, a newly source-authored pre-descriptor structural tail at `0x099200-0x09991F` (two monotone byte bands, a fixed 19-byte record family, a fixed 16-byte record family, a 3-byte lead-in plus a fixed 5-byte record family, local-offset words, packed bytes, repeated `0x01F1` words, and a short word trailer), descriptor records, a zero-fill gap, and a front command substructure (`0x099B00-0x099B31` lead-in plus `0x099B32-0x099BAF` bank-local offset table) followed by narrower ROM-order command-record slices instead of one monolithic trailing blob, with several of the longer pre-`0x09A348` command targets now also explicit as smaller FF-terminated subrecords at `0x099D05`, `0x099D48`, `0x09A10E`, `0x09A16A`, and `0x09A288`; it also splits the next non-fill island at `0x0A0000-0x0A4C76` into a front multi-level offset-table tree through `0x0A07C5`, a source-authored `0x0A07C6-0x0A0B25` continued band of repeated four-tuple records, a narrower mixed lead-in at `0x0A0B26-0x0A0C82`, four FF-terminated 6-byte record bands through `0x0A10AA`, a fully record-sliced `0x0A10AB-0x0A34FF` middle span of FF-terminated 5-byte tuples plus short anomaly gaps, and a table-targeted back half at `0x0A3500-0x0A4C76` where the front `0x0A3500-0x0A37AF` run is now source-authored as a compact local-offset/control family and several later compact record groups are explicit as 3-word bands, local-offset triplets, a self-referencing local-offset list, and a final compact local-offset/control tail pocket at `0x0A4AEC-0x0A4C76`, alongside the confirmed `0xFF` fill runs at `0x09622B-0x097FFF`, `0x09F777-0x09FFFF`, and `0x0A4C77-0x0BFFFF`

  - `src/bank080000_z80_command_front.asm` now gives `0x099A85-0x09A347` its own ROM-order owner so the tail-bank island reads as Z80 program front -> pre-descriptor records -> descriptor/layout tables -> command front -> later FF-terminated command windows
  - `src/bank080000_z80_program.asm` now also makes the full `0x098000-0x09907A` Z80 front source-visible: reset entry -> short return stub -> mixed stub pocket -> repeated absolute jump stubs -> tiny `NOP`/`RETI` handler -> startup/sequencing/slot-management prelude -> later main-body helpers -> state-snapshot/transfer handshake -> odd-aligned lookup tables
  - `src/bank080000_table_targeted_payload_records.asm` now owns the full `0x0A3500-0x0A4C76` back-half payload family under one structural subsystem name, with ROM-order child modules for the front, mid, late, late-tail, and final tail continuations instead of leaving that mature region under `a3500`/`a3c17`/`a43d5`-style filenames

## Observations

- The first `0x200` bytes are already source-authored and rebuild byte-identically.
- The tail quarter of the ROM contains a very high density of `0xFF` bytes, suggesting
  padding, sparse tables, or banked asset regions that should be mapped carefully before
  any hand rewrite.
- Long repeated-byte runs exist throughout the ROM, so future splits should document
  whether each run is padding, compressed data, or structured fill.
- The tail-bank island at `0x098000-0x09F776` is no longer treated as one opaque blob: the
  front `0x098000-0x09907A` slice now reads strongly enough as a Z80 program front, with an explicit
  reset entry at `0x098000`, a short returning stub at `0x098006`, a mixed front stub pocket at
  `0x098010-0x09801F`, three repeated absolute `JP $0F8C` stubs at `0x098020`, `0x098028`, and `0x098030`,
  a tiny `NOP`/`RETI` stub at `0x098038`, and a main body start at `0x09803B`. That former main-body prelude is now
  source-visible too: `0x09803B-0x0980E1` resets `0x1B80+`, `0x1C80+`, and `0x1ED1+` work areas and emits fixed
  setup bursts before a warmup loop; `0x0980E2-0x09810A` is a short startup-burst helper plus output-selector reset;
  `0x09810B-0x09815F` is a countdown-driven tick with a wide-record phase initializer and optional latched-mode mirror;
  `0x098160-0x09820A` advances and consumes one inline sequence stream; and `0x09820B-0x098274` seeds or updates
  `0x1EC0`-rooted slot descriptors from inline pointer lists. The next body slice is a little less opaque now too:
  `0x098275-0x098280` is an explicit six-entry little-endian jump table for raw
  command bytes `$FF..$FA`, `0x098282` is a tiny standalone handler, `0x098288` / `0x09829C` are paired table-
  loader handlers with a shared init tail at `0x09829F-0x0982B0`, the two inline 3-byte record tables at
  `0x09828D` and `0x0982B1` are now visible in source, `0x0982BA-0x098392` now exposes the next slot-scan /
  slot-drain helper band directly in source, `0x098393-0x098403` now selects one masked candidate record from
  three banked 0x40-byte families via the new descriptor table at `0x098404`, `0x09840D-0x098435` now scans the
  `0x1C80` family for a matching packed-delta record, `0x098436-0x098445` packs a wide-record index from `IX`,
  `0x098446-0x0984B0` now finalizes one indexed selection path by splitting the local selector across `0x1C10/0x1C11`
  and then taking one of three teardown/update branches, `0x0984B1-0x098515` now exposes two neighboring
  three-byte-record lookup helpers, `0x098516-0x09853B` now buckets the current high byte through fixed
  `0x60/0x30/0x18/0x0C` thresholds, `0x09853C-0x098578` now emits one nonzero-mode pair of encoded bytes to `0x7F11`,
  `0x098579-0x09859A` is a neighboring zero-mode emitter that instead uses the ascending odd-aligned table,
  `0x09859B-0x0985B9` refreshes an IX-local masked target word only when its rounded value changes,
  `0x0985BA-0x098615` now updates one indexed output band around IX-local bytes `+0x28/+0x29`,
  `0x098616-0x09867B` now walks four triplet-spaced IX-local rows through a new 8-entry lookup table at `0x098674`,
  `0x09867C-0x0986E1` now expands indexed 4-byte descriptor rows through the table at `0x164B`,
  `0x0986E2-0x09870A` writes a latched output pair through `0x4000/0x4001`, `0x09870B-0x098755` sweeps active
  `0x1C80`-rooted wide records while cycling `0x1C10/0x1C11`, `0x098756-0x09875B` is an explicit bit-6 gate,
  `0x09875C-0x098771` sets that flag and dispatches by `(IX+1)-2`, `0x098772-0x098865` now advances a primary
  command-driven stream with explicit `$F8-$FF` control handling, `0x09886E-0x0988CD` applies the next working-offset
  and secondary-target bridge, `0x0988CE-0x098975` mirrors that pattern for a secondary stream plus a shared post-
  update dispatch, `0x098CA5-0x098D80` now initializes one `IY`-local record from either a 6-byte descriptor family or
  the active `IX` slot, `0x098D81-0x098E12` now finalizes that `IX -> IY` transfer with countdown derivation plus slot
  counter mirroring, `0x098E1B-0x098E61` is now explicit as the adjacent mode-table / triplet-write helper band, and
  `0x098E62-0x098F8B` now stands as the marked-slot high-command dispatch table plus handlers, and
  `0x098F8C-0x09907A` is now explicit as the repeated-`JP $0F8C` state-snapshot / transfer-handshake tail before the
  lookup tables;
  `0x09907B-0x09913C` and
  `0x09913D-0x0991FE` are now explicit as odd-aligned little-endian ascending/descending word
  lookup tables, `0x0991FF` is a trailing zero byte, the next `0x099200-0x09991F` span is now
  explicit as monotone byte bands, a fixed 19-byte record family, a fixed 16-byte record family,
  a short 3-byte lead-in plus fixed 5-byte records, and a smaller structural trailer, while the later
  `0x099920-0x099A84` records and `0x099B00+` command region now show a clearer front split
  into a short lead-in, a mostly bank-local offset table, and a table-driven set of narrower
  command-record slices through `0x09A347` before three later FF-terminated record windows.
  That front command span is now also promoted into its own source module, `src/bank080000_z80_command_front.asm`, instead of remaining embedded inside `src/bank080000_z80_resources.asm`.
  Several of the longer pre-`0x09A348` command targets now also expose internal FF-terminated
  subrecords directly in source instead of staying as single coarse slices, including the newly
  tightened `0x09A199-0x09A287` pocket plus its explicit 2-byte bridge at `0x09A22B` and one-byte
  sentinel at `0x09A26A`. Inside the later windows, the repeated 24-byte triplets at
  `0x09AB2A-0x09AB71`, `0x09E6F7-0x09E73E`, and `0x09F4D5-0x09F51C` are now explicit, the
  neighboring `0xAB`-byte repeated-byte-pair records at `0x09A3EC-0x09A496` and
  `0x09E607-0x09E6B1` are source-authored too, the middle-window bridge at
  `0x09C98D-0x09CBED` now also stands explicitly as a compact high-byte ladder pair plus a
  broader local-control / literal-high-byte descent and one short literal-control bridge, and
  the later records at `0x09F597-0x09F669` plus `0x09F66A-0x09F6AD` now also stand explicitly
  as one repeated literal-burst pair and one alternating local-control tail.
- The earlier tail-bank front at `0x0801CD-0x0961D7` is no longer hidden inside one `0x080000+`
  coarse incbin either: the cross-bank flagged-reference tables in `src/bank040000_tables.asm`
  now expose 178 stable starts there, which makes the payload family and its two untargeted gaps
  visible directly in bank080000 source even though the shared loader and record semantics remain open.
- The next tail-bank island at `0x0A0000-0x0A4C76` also now has a proven front structure: the
  first `0x07C6` bytes are a nested big-endian offset-table tree whose words mostly point back
  into the same island, followed by a continued `0x360`-byte band at `0x0A07C6-0x0A0B25` with a
  regular `0x18`-byte cadence of four 6-byte tuples, then a partly source-authored mixed lead-in at
  `0x0A0B26-0x0A0C82` whose front 26 FF-terminated structural records reach `0x0A0C78` before a
  final 10-byte tail, four narrower FF-terminated 6-byte record bands through `0x0A10AA`, and a newly exposed middle body
  at `0x0A10AB-0x0A34FF` that resolves into FF-terminated runs of 5-byte tuples with only short
  anomaly gaps between them; all eleven runs are now explicit record-by-record in source, including
  one singleton `$FF` record at `0x0A1378` and two singleton `$FF` records at `0x0A1D4F-0x0A1D50`;
  the middle windows at `0x0A2400-0x0A2585` and `0x0A27CB-0x0A2D85` are now fully source-authored as
  explicit tuple records too instead of record-local `incbin` slices;
  and finally a table-targeted back half at `0x0A3500-0x0A4C76` whose stable record starts are now
  explicit in source because the front offset tree already references them, with several subfamilies
  now tightened into explicit 3-word record bands, local-offset triplet records, a small
  self-referencing local-offset list, and a final compact local-offset/control tail pocket even though the
  higher-level owner and field semantics remain unresolved.
  The very front of that back-half target range is now cleaner too: `0x0A3500-0x0A37AF` is source-authored
  as a compact record family with repeated `FC/FB` prefixes and local 24-bit offsets into the earlier tuple
  bands instead of dozens of one-line `incbin` fragments.
- The first post-dictionary bank `0x020000` island at `0x022460-0x022DB7` is no longer treated
  as one anonymous blob: the front `0x60` bytes are six same-bank reference descriptors, the next
  `0x118` bytes are a monotone local offset table that terminates with `0x0000`, the indexed payload
  at `0x022662-0x02292B` is now split into one table-targeted lead-in plus a long run of mostly
  6-byte short records and a few 8-byte variants, and the later `0x02292C-0x022AEB` band keeps a
  stable `0x10`-byte descriptor cadence. The former `0x022AEC-0x022DB7` tail is now also explicit as
  front `$FFFF`-delimited descriptor records, a short repeated `$0BFF` band, and several compact
  `$FF00`-terminated word records even though the owning driver and field semantics are still unresolved.
- A later bank `0x020000` island at `0x023AB6-0x024537` is also no longer hidden inside one coarse
  `incbin`: it now stands as a ROM-order band of big-endian word records separated by repeated `$FFFF`
  sentinels, with several recurring record shapes visible even though the consumer and field semantics
  are still unresolved.
- Another front bank `0x020000` index island at `0x0211CA-0x02135F` is also now explicit in source:
  four absolute pointer longwords cross-link to the local offset data, the inventory-name table, the
  world-keyword table, and the Ocarina melody-adjacent bytes, followed by two bank-relative offset
  tables that target earlier text/control bands inside the same bank.
- The back half of bank `0x020000` is also a little less opaque now: the tail owner at
  `0x02482C-0x03FFFF` no longer stops at nine `0xFF7B`-terminated compressed/data blocks. Three more
  blocks at `0x035078-0x03519D`, `0x03519E-0x0354F3`, and `0x0354F4-0x03C6DF` are now called out by
  explicit `0xFF7A` terminators, the front `0x02482C-0x024835` table is source-authored as literal
  relative offsets instead of a blind `incbin`, and the final `0x03C6E0-0x03FFFF` bank-end tail is now
  split into five smaller header-like sub-blocks rather than one monolithic remainder.
- The front of bank `0x020000` is no longer just record families plus unnamed gaps: `0x020000-0x0201CF`
  and `0x02053A-0x020E4B` now live in dedicated dialogue/script continuation modules, while
  `0x0201D0-0x020539` is split into 52 short ROM-order slices from the first offset table and
  `0x020E4C-0x0211C9` is split into 131 short ROM-order slices from the second. The bytes still mix
  text fragments with undecoded control data, so the names remain structural rather than forcing a
  final dialogue or script subsystem.
- The front late-bank `0x040000` span at `0x041000-0x07FF66` is no longer opaque either: it is now
  explicit as a regular four-byte flagged ROM-reference table cluster with a clean phase change from
  local targets (`0x041C00-0x07FF66`) to cross-bank targets (`0x0801CD-0x093FD0`), followed by a short
  same-shape tail table at `0x041B80-0x041BBF`, two smaller `0xFF` fill gaps at `0x041B40-0x041B7F`
  and `0x041BC0-0x041BFF`, and an expanded local-target payload window at `0x041C00-0x07FF66` whose
  internal record starts are now split out directly from the monotone local table targets. The same table
  now also makes one earlier singleton explicit at `0x045842-0x045D01`, followed by the later fixed-stride
  runs of eight `0x4C0`-byte records at `0x04BFAA-0x04E5A9` and `0x05D630-0x05FC2F`, another isolated
  `0x4C0` record at `0x05C5DA-0x05CA99`, and a shorter two-record `0x4C0` run at `0x06B192-0x06BB11`
  before the final tiny remainder at `0x07FF67-0x07FFFF`. Those repeated records now read strongly enough
  as 38-tile 4bpp planar graphics blocks that tag `$01` in the same-bank flagged table can be treated as a
  planar-tile variant, even though the exact loader and asset purpose remain open.
- The short bank-front lead-in before that table cluster is cleaner now too: `0x040000-0x0409F9` is
  no longer one monolithic bank-front blob, but a unique lead-in plus six smaller header-like pockets
  whose starts recur on short signatures `FFFF 000A`, `FFFF 000E`, and `0000 0102`.

## Known Padding And Fill Hotspots

- Header padding spaces at `0x00013E-0x00014F`, `0x00016B-0x00017F`, and `0x0001BC-0x0001EF`
- Large `0xFF` runs at `0x01C602-0x01CBFF` and `0x0409FA-0x040FFF`
- Additional late-bank front structure now called out explicitly at `0x041000-0x07FF66`: a local
  flagged ROM-reference table at `0x041000-0x0418AB`, a cross-bank flagged ROM-reference table at
  `0x0418AC-0x041B3F`, a short fill gap at `0x041B40-0x041B7F`, a short tail table at
  `0x041B80-0x041BBF`, another short fill gap at `0x041BC0-0x041BFF`, and a first local-target
  payload window with explicit ROM-order record starts at `0x041C00-0x07FF66`
- Additional bank-front late-ROM structure now also called out explicitly at `0x040000-0x0409F9`: a
  unique lead-in at `0x040000-0x0400FF`, followed by smaller header-like pockets at
  `0x040100-0x04025B`, `0x04025C-0x0403FF`, `0x040400-0x04053B`, `0x04053C-0x0406C3`,
  `0x0406C4-0x0408D3`, and `0x0408D4-0x0409F9`
- Tail-bank `0xFF` runs now confirmed at `0x09622B-0x097FFF`, `0x09F777-0x09FFFF`, and `0x0A4C77-0x0BFFFF`
- Additional tail-bank front structure now also called out explicitly: a small untargeted lead-in at `0x080000-0x0801CC`, a large cross-bank table-targeted payload region at `0x0801CD-0x093FD0`, an untargeted gap at `0x093FD1-0x094149`, a second cross-bank table-targeted payload region at `0x09414A-0x0961D7`, and a final untargeted gap at `0x0961D8-0x09622A`
- Additional tail-bank structure now called out explicitly: a fixed 16-byte pre-descriptor record band at `0x099649-0x099828`, a 3-byte lead-in plus fixed 5-byte pre-descriptor record band at `0x099829-0x09988F`, a descriptor-header block at `0x099920-0x09997F`, a packed layout/coordinate table at `0x099980-0x099A84`, a zero-filled gap at `0x099A85-0x099AFF`, a command lead-in at `0x099B00-0x099B31`, a bank-local command offset table at `0x099B32-0x099BAF`, an unreferenced command-record prelude at `0x099BB0-0x099BD2`, table-targeted record boundaries through `0x09A347`, and FF-terminated internal subrecord boundaries now made explicit inside the longer front command targets at `0x099D05`, `0x099D48`, `0x09A10E`, `0x09A13C`, and `0x09A16A`; the later `0x09A348+` windows now also make repeated 24-byte, `0xAB`-byte, repeated-literal-burst, alternating local-control, compact high-byte ladder, local-control / literal-high-byte bridge, and neighboring `F4 02` literal-row ladder pockets explicit instead of leaving those shapes trapped inside raw slices
- Additional tail-bank structure now also called out explicitly at `0x0A0000-0x0A4C76`: a root offset table at `0x0A0000-0x0A01C7`, a larger nested offset-table block at `0x0A01C8-0x0A07BB`, a short offset-table tail at `0x0A07BC-0x0A07C5`, a continued four-tuple record band at `0x0A07C6-0x0A0B25`, a front mixed lead-in record family at `0x0A0B26-0x0A0C78` plus a 10-byte tail at `0x0A0C79-0x0A0C82`, FF-terminated 6-byte record bands at `0x0A0C83-0x0A0D18`, `0x0A0D3F-0x0A0D74`, `0x0A0E85-0x0A0F2C`, and `0x0A0FA9-0x0A10AA`, long FF-terminated 5-byte-tuple runs at `0x0A10AB-0x0A1321`, `0x0A132D-0x0A136D`, `0x0A1378-0x0A1405`, `0x0A1411-0x0A1D3E`, `0x0A1D4F-0x0A23F5`, `0x0A2400-0x0A2585`, `0x0A258B-0x0A2605`, `0x0A2610-0x0A2764`, `0x0A27CB-0x0A2D85`, `0x0A2D9B-0x0A303F`, and `0x0A304B-0x0A34FF`, plus newly explicit embedded-`$FF` record pockets at `0x0A1322-0x0A132C`, `0x0A1406-0x0A1410`, `0x0A2765-0x0A27CA`, `0x0A2D86-0x0A2D9A`, and `0x0A3040-0x0A304A`; only five short mixed gaps now remain between those runs, and the table-targeted payload record region at `0x0A3500-0x0A4C76` now also exposes a compact local-offset/control pocket at `0x0A37FE-0x0A3B76`, a 12-record 3-word band at `0x0A37B0-0x0A37F7`, a 16-record local-offset-triplet band at `0x0A3B77-0x0A3C16`, a small self-referencing 3-word/local-offset cluster at `0x0A4AA3-0x0A4AEB`, and a final compact local-offset/control tail pocket at `0x0A4AEC-0x0A4C76`
- Additional mid-bank structure now also called out explicitly at `0x022460-0x022DB7`: six same-bank reference descriptors at `0x022460-0x0224BF`, an indexed-payload offset table at `0x0224C0-0x0225D7`, a table-targeted short-record payload at `0x022662-0x02292B`, a repeated descriptor-record band at `0x02292C-0x022AEB`, a front `$FFFF`-delimited descriptor tail at `0x022AEC-0x022D3F`, a repeated `$0BFF` word band at `0x022D40-0x022D6B`, and compact `$FF00`-terminated word records at `0x022D6C-0x022DB7`
- Additional mid-bank structure now also called out explicitly at `0x0211CA-0x02135F`: a local text-table pointer list at `0x0211CA-0x0211D9`, a bank-relative offset table at `0x0211DA-0x021257`, and a second bank-relative offset table at `0x021258-0x02135F`
- Additional front-bank structure now also called out explicitly at `0x020000-0x0211C9`: a front dialogue/script continuation at `0x020000-0x0201CF`, a first bank-relative text/control record family at `0x0201D0-0x020539`, a second dialogue/script continuation at `0x02053A-0x020E4B`, and a second bank-relative text/control record family at `0x020E4C-0x0211C9`
- Additional mid-bank structure now also called out explicitly at `0x023AB6-0x024537`: a long band of `$FFFF`-delimited big-endian word records with narrower ROM-order record boundaries instead of one later-bank anonymous blob
- Additional back-half bank `0x020000` structure now also called out explicitly at `0x02482C-0x03FFFF`: a source-authored 4-entry relative-offset table plus twelve compressed/data blocks with proven `0xFF7A`/`0xFF7B` terminators through `0x03C6DF`, followed by five smaller header-like sub-blocks at `0x03C6E0-0x03E845`, `0x03E846-0x03EF4D`, `0x03EF4E-0x03F4D0`, `0x03F4D1-0x03FE23`, and `0x03FE24-0x03FFFF`
- Remaining non-fill slices in `0x080000-0x0BFFFF` still need code/data/text classification before deeper source-authoring
