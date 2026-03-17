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
- `src/bank020000.asm` owns `0x020000-0x03FFFF` and now also splits a front bank-relative text-index island at `0x0211CA-0x02135F`, a quiz/text/name band at `0x021360-0x02245F`, the first post-dictionary descriptor/index island at `0x022460-0x022C5F`, and a later sentinel-delimited word-record band at `0x023AB6-0x024537`
- `src/bank040000.asm` owns `0x040000-0x07FFFF` and already splits out the confirmed `0xFF` fill run at `0x0409FA-0x040FFF`
- `src/bank080000.asm` owns `0x080000-0x0BFFFF` and now splits the `0x098000-0x09F776` non-fill island into a Z80-like opcode-dense block, descriptor records, a zero-fill gap, and a front command substructure (`0x099B00-0x099B31` lead-in plus `0x099B32-0x099BAF` bank-local offset table) followed by narrower ROM-order command-record slices instead of one monolithic trailing blob; it also splits the next non-fill island at `0x0A0000-0x0A4C76` into a front multi-level offset-table tree through `0x0A07C5`, a source-authored `0x0A07C6-0x0A08E5` band of repeated four-tuple records, an unresolved lead-in at `0x0A08E6-0x0A34FF`, and a table-targeted back half at `0x0A3500-0x0A4C76` with ROM-order record starts pulled out of the same offset tree, alongside the confirmed `0xFF` fill runs at `0x09622B-0x097FFF`, `0x09F777-0x09FFFF`, and `0x0A4C77-0x0BFFFF`

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
- The next tail-bank island at `0x0A0000-0x0A4C76` also now has a proven front structure: the
  first `0x07C6` bytes are a nested big-endian offset-table tree whose words mostly point back
  into the same island, followed by a `0x120`-byte band at `0x0A07C6-0x0A08E5` with a regular
  `0x18`-byte cadence of four 6-byte tuples, then an unresolved lead-in at `0x0A08E6-0x0A34FF`,
  and finally a table-targeted back half at `0x0A3500-0x0A4C76` whose stable record starts are
  now explicit in source because the front offset tree already references them, even though the
  higher-level owner and field semantics remain unresolved.
- The first post-dictionary bank `0x020000` island at `0x022460-0x022C5F` is no longer treated
  as one anonymous blob: the front `0x60` bytes are six same-bank reference descriptors, the next
  `0x118` bytes are a monotone local offset table that terminates with `0x0000`, the indexed payload
  at `0x022662-0x02292B` is now split into one table-targeted lead-in plus a long run of mostly
  6-byte short records and a few 8-byte variants, and the later `0x02292C-0x022AEB` band keeps a
  stable `0x10`-byte descriptor cadence even though the owning driver and field semantics are still
  unresolved.
- A later bank `0x020000` island at `0x023AB6-0x024537` is also no longer hidden inside one coarse
  `incbin`: it now stands as a ROM-order band of big-endian word records separated by repeated `$FFFF`
  sentinels, with several recurring record shapes visible even though the consumer and field semantics
  are still unresolved.
- Another front bank `0x020000` index island at `0x0211CA-0x02135F` is also now explicit in source:
  four absolute pointer longwords cross-link to the local offset data, the inventory-name table, the
  world-keyword table, and the Ocarina melody-adjacent bytes, followed by two bank-relative offset
  tables that target earlier text/control bands inside the same bank.

## Known Padding And Fill Hotspots

- Header padding spaces at `0x00013E-0x00014F`, `0x00016B-0x00017F`, and `0x0001BC-0x0001EF`
- Large `0xFF` runs at `0x01C602-0x01CBFF` and `0x0409FA-0x040FFF`
- Tail-bank `0xFF` runs now confirmed at `0x09622B-0x097FFF`, `0x09F777-0x09FFFF`, and `0x0A4C77-0x0BFFFF`
- Additional tail-bank structure now called out explicitly: a descriptor-header block at `0x099920-0x09997F`, a packed layout/coordinate table at `0x099980-0x099A84`, a zero-filled gap at `0x099A85-0x099AFF`, a command lead-in at `0x099B00-0x099B31`, a bank-local command offset table at `0x099B32-0x099BAF`, an unreferenced command-record prelude at `0x099BB0-0x099BD2`, and table-targeted record boundaries through `0x09A347`
- Additional tail-bank structure now also called out explicitly at `0x0A0000-0x0A4C76`: a root offset table at `0x0A0000-0x0A01C7`, a larger nested offset-table block at `0x0A01C8-0x0A07BB`, a short offset-table tail at `0x0A07BC-0x0A07C5`, a repeated four-tuple record band at `0x0A07C6-0x0A08E5`, an unresolved payload lead-in at `0x0A08E6-0x0A34FF`, and a table-targeted payload record region at `0x0A3500-0x0A4C76`
- Additional mid-bank structure now also called out explicitly at `0x022460-0x022C5F`: six same-bank reference descriptors at `0x022460-0x0224BF`, an indexed-payload offset table at `0x0224C0-0x0225D7`, a table-targeted short-record payload at `0x022662-0x02292B`, and a repeated descriptor-record band at `0x02292C-0x022AEB`
- Additional mid-bank structure now also called out explicitly at `0x0211CA-0x02135F`: a local text-table pointer list at `0x0211CA-0x0211D9`, a bank-relative offset table at `0x0211DA-0x021257`, and a second bank-relative offset table at `0x021258-0x02135F`
- Additional mid-bank structure now also called out explicitly at `0x023AB6-0x024537`: a long band of `$FFFF`-delimited big-endian word records with narrower ROM-order record boundaries instead of one later-bank anonymous blob
- Remaining non-fill slices in `0x080000-0x0BFFFF` still need code/data/text classification before deeper source-authoring
