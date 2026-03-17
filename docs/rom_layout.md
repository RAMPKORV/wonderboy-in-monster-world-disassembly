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
- `src/bank020000.asm` owns `0x020000-0x03FFFF` and now also splits two front bank-relative text/control record families at `0x0201D0-0x020539` and `0x020E4C-0x0211C9`, a front bank-relative text-index island at `0x0211CA-0x02135F`, a quiz/text/name band at `0x021360-0x02245F`, the first post-dictionary descriptor/index island at `0x022460-0x022DB7`, a later sentinel-delimited word-record band at `0x023AB6-0x024537`, and a partially decomposed compressed-data tail at `0x02482C-0x03FFFF` whose `0xFF7A`/`0xFF7B` block boundaries are now explicit through `0x03C6DF`
- `src/bank040000.asm` owns `0x040000-0x07FFFF` and now also splits a flagged ROM-reference table cluster at `0x041000-0x041BFF`, an expanded local-target payload window at `0x041C00-0x07FF66`, a tiny trailing remainder at `0x07FF67-0x07FFFF`, and the confirmed `0xFF` fill run at `0x0409FA-0x040FFF`
- `src/bank080000.asm` owns `0x080000-0x0BFFFF` and now also splits the former opaque pre-fill front at `0x0801CD-0x0961D7` into cross-bank table-targeted ROM-order payload records plus two explicit untargeted gaps (`0x093FD1-0x094149` and `0x0961D8-0x09622A`) based on the flagged ROM-reference tables in bank `0x040000`; the same owner also splits the `0x098000-0x09F776` non-fill island into a Z80-like opcode-dense block, descriptor records, a zero-fill gap, and a front command substructure (`0x099B00-0x099B31` lead-in plus `0x099B32-0x099BAF` bank-local offset table) followed by narrower ROM-order command-record slices instead of one monolithic trailing blob; it also splits the next non-fill island at `0x0A0000-0x0A4C76` into a front multi-level offset-table tree through `0x0A07C5`, a source-authored `0x0A07C6-0x0A0B25` continued band of repeated four-tuple records, a narrower mixed lead-in at `0x0A0B26-0x0A0C82`, four FF-terminated 6-byte record bands through `0x0A10AA`, a fully record-sliced `0x0A10AB-0x0A34FF` middle span of FF-terminated 5-byte tuples plus short anomaly gaps, and a table-targeted back half at `0x0A3500-0x0A4C76` where several compact record groups are now source-authored as explicit 3-word bands, local-offset triplets, and a self-referencing local-offset list, alongside the confirmed `0xFF` fill runs at `0x09622B-0x097FFF`, `0x09F777-0x09FFFF`, and `0x0A4C77-0x0BFFFF`

## Observations

- The first `0x200` bytes are already source-authored and rebuild byte-identically.
- The tail quarter of the ROM contains a very high density of `0xFF` bytes, suggesting
  padding, sparse tables, or banked asset regions that should be mapped carefully before
  any hand rewrite.
- Long repeated-byte runs exist throughout the ROM, so future splits should document
  whether each run is padding, compressed data, or structured fill.
- The tail-bank island at `0x098000-0x09F776` is no longer treated as one opaque blob: the
  front `0x098000-0x09991F` slice is strongly opcode-dense and Z80-like, while the later
  `0x099920-0x099A84` records and `0x099B00+` command region now show a clearer front split
  into a short lead-in, a mostly bank-local offset table, and a table-driven set of narrower
  command-record slices through `0x09A347` before the still-large trailing record at `0x09A348`.
- The earlier tail-bank front at `0x0801CD-0x0961D7` is no longer hidden inside one `0x080000+`
  coarse incbin either: the cross-bank flagged-reference tables in `src/bank040000_tables.asm`
  now expose 178 stable starts there, which makes the payload family and its two untargeted gaps
  visible directly in bank080000 source even though the shared loader and record semantics remain open.
- The next tail-bank island at `0x0A0000-0x0A4C76` also now has a proven front structure: the
  first `0x07C6` bytes are a nested big-endian offset-table tree whose words mostly point back
  into the same island, followed by a continued `0x360`-byte band at `0x0A07C6-0x0A0B25` with a
  regular `0x18`-byte cadence of four 6-byte tuples, then a mixed lead-in at `0x0A0B26-0x0A0C82`,
  four narrower FF-terminated 6-byte record bands through `0x0A10AA`, a newly exposed middle body
  at `0x0A10AB-0x0A34FF` that resolves into FF-terminated runs of 5-byte tuples with only short
  anomaly gaps between them; all eleven runs are now explicit record-by-record in source, including
  one singleton `$FF` record at `0x0A1378` and two singleton `$FF` records at `0x0A1D4F-0x0A1D50`;
  and finally a table-targeted back half at `0x0A3500-0x0A4C76` whose stable record starts are now
  explicit in source because the front offset tree already references them, with several subfamilies
  now tightened into explicit 3-word record bands, local-offset triplet records, and a small
  self-referencing local-offset list even though the higher-level owner and field semantics remain unresolved.
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
  explicit `0xFF7A` terminators, and the front `0x02482C-0x024835` table is source-authored as literal
  relative offsets instead of a blind `incbin`, leaving only `0x03C6E0-0x03FFFF` as the final grouped
  tail remainder for that bank slice.
- Those earlier target bands are now explicit too instead of staying hidden inside one front-bank blob:
  `0x0201D0-0x020539` is split into 52 short ROM-order slices from the first offset table, and
  `0x020E4C-0x0211C9` is split into 131 short ROM-order slices from the second. The bytes still mix text
  fragments with undecoded control data, so the names remain structural rather than forcing a dialogue or
  script subsystem.
- The front late-bank `0x040000` span at `0x041000-0x07FF66` is no longer opaque either: it is now
  explicit as a regular four-byte flagged ROM-reference table cluster with a clean phase change from
  local targets (`0x041C00-0x07FF66`) to cross-bank targets (`0x0801CD-0x093FD0`), followed by a short
  same-shape tail table at `0x041B80-0x041BBF`, two smaller `0xFF` fill gaps at `0x041B40-0x041B7F`
  and `0x041BC0-0x041BFF`, and an expanded local-target payload window at `0x041C00-0x07FF66` whose
  internal record starts are now split out directly from the monotone local table targets. The newly
  exposed tail also reveals fixed-stride runs of eight `0x4C0`-byte records at `0x04BFAA-0x04E5A9`
  and `0x05D630-0x05FC2F`, an earlier isolated `0x4C0` record at `0x05C5DA`, and a shorter two-record
  `0x4C0` run at `0x06B192-0x06BB11` before the final tiny remainder at `0x07FF67-0x07FFFF`.

## Known Padding And Fill Hotspots

- Header padding spaces at `0x00013E-0x00014F`, `0x00016B-0x00017F`, and `0x0001BC-0x0001EF`
- Large `0xFF` runs at `0x01C602-0x01CBFF` and `0x0409FA-0x040FFF`
- Additional late-bank front structure now called out explicitly at `0x041000-0x07FF66`: a local
  flagged ROM-reference table at `0x041000-0x0418AB`, a cross-bank flagged ROM-reference table at
  `0x0418AC-0x041B3F`, a short fill gap at `0x041B40-0x041B7F`, a short tail table at
  `0x041B80-0x041BBF`, another short fill gap at `0x041BC0-0x041BFF`, and a first local-target
  payload window with explicit ROM-order record starts at `0x041C00-0x07FF66`
- Tail-bank `0xFF` runs now confirmed at `0x09622B-0x097FFF`, `0x09F777-0x09FFFF`, and `0x0A4C77-0x0BFFFF`
- Additional tail-bank front structure now also called out explicitly: a small untargeted lead-in at `0x080000-0x0801CC`, a large cross-bank table-targeted payload region at `0x0801CD-0x093FD0`, an untargeted gap at `0x093FD1-0x094149`, a second cross-bank table-targeted payload region at `0x09414A-0x0961D7`, and a final untargeted gap at `0x0961D8-0x09622A`
- Additional tail-bank structure now called out explicitly: a descriptor-header block at `0x099920-0x09997F`, a packed layout/coordinate table at `0x099980-0x099A84`, a zero-filled gap at `0x099A85-0x099AFF`, a command lead-in at `0x099B00-0x099B31`, a bank-local command offset table at `0x099B32-0x099BAF`, an unreferenced command-record prelude at `0x099BB0-0x099BD2`, and table-targeted record boundaries through `0x09A347`
- Additional tail-bank structure now also called out explicitly at `0x0A0000-0x0A4C76`: a root offset table at `0x0A0000-0x0A01C7`, a larger nested offset-table block at `0x0A01C8-0x0A07BB`, a short offset-table tail at `0x0A07BC-0x0A07C5`, a continued four-tuple record band at `0x0A07C6-0x0A0B25`, a mixed lead-in at `0x0A0B26-0x0A0C82`, FF-terminated 6-byte record bands at `0x0A0C83-0x0A0D18`, `0x0A0D3F-0x0A0D74`, `0x0A0E85-0x0A0F2C`, and `0x0A0FA9-0x0A10AA`, long FF-terminated 5-byte-tuple runs at `0x0A10AB-0x0A1321`, `0x0A132D-0x0A136D`, `0x0A1378-0x0A1405`, `0x0A1411-0x0A1D3E`, `0x0A1D4F-0x0A23F5`, `0x0A2400-0x0A2585`, `0x0A258B-0x0A2605`, `0x0A2610-0x0A2764`, `0x0A27CB-0x0A2D85`, `0x0A2D9B-0x0A303F`, and `0x0A304B-0x0A34FF`, with all eleven runs now split to individual record starts, short anomaly gaps between those runs, and a table-targeted payload record region at `0x0A3500-0x0A4C76` that now also exposes a 12-record 3-word band at `0x0A37B0-0x0A37F7`, a 16-record local-offset-triplet band at `0x0A3B77-0x0A3C16`, and a small self-referencing 3-word/local-offset cluster at `0x0A4AA3-0x0A4AEB`
- Additional mid-bank structure now also called out explicitly at `0x022460-0x022DB7`: six same-bank reference descriptors at `0x022460-0x0224BF`, an indexed-payload offset table at `0x0224C0-0x0225D7`, a table-targeted short-record payload at `0x022662-0x02292B`, a repeated descriptor-record band at `0x02292C-0x022AEB`, a front `$FFFF`-delimited descriptor tail at `0x022AEC-0x022D3F`, a repeated `$0BFF` word band at `0x022D40-0x022D6B`, and compact `$FF00`-terminated word records at `0x022D6C-0x022DB7`
- Additional mid-bank structure now also called out explicitly at `0x0211CA-0x02135F`: a local text-table pointer list at `0x0211CA-0x0211D9`, a bank-relative offset table at `0x0211DA-0x021257`, and a second bank-relative offset table at `0x021258-0x02135F`
- Additional front-bank structure now also called out explicitly at `0x0201D0-0x0211C9`: a first bank-relative text/control record family at `0x0201D0-0x020539`, an untargeted front gap at `0x02053A-0x020E4B`, and a second bank-relative text/control record family at `0x020E4C-0x0211C9`
- Additional mid-bank structure now also called out explicitly at `0x023AB6-0x024537`: a long band of `$FFFF`-delimited big-endian word records with narrower ROM-order record boundaries instead of one later-bank anonymous blob
- Additional back-half bank `0x020000` structure now also called out explicitly at `0x02482C-0x03FFFF`: a source-authored 4-entry relative-offset table plus twelve compressed/data blocks with proven `0xFF7A`/`0xFF7B` terminators through `0x03C6DF`, followed by a smaller final remainder at `0x03C6E0-0x03FFFF`
- Remaining non-fill slices in `0x080000-0x0BFFFF` still need code/data/text classification before deeper source-authoring
