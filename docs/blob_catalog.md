# Blob Catalog

Conservative ownership inventory for ROM regions that are still partly opaque, structurally decoded,
or awaiting a stronger subsystem/loader match. Confirmed byte structure is separated from softer
 subsystem guesses.

## Bank 0x080000

| ROM range | Current owner | Classification | Evidence | Confidence | Next evidence needed |
| --- | --- | --- | --- | --- | --- |
| `0x0801CD-0x093FD0` | `src/bank080000_cross_payload_front.asm` | Cross-bank table-targeted payload records | Flagged ROM-reference tables in bank `0x040000` prove stable target starts here; not shaped like 68k code; ROM-order records now split around targeted starts | Medium | Identify the 68k-side loader/consumer and whether these payloads are maps, graphics metadata, script, or another resource family |
| `0x093FD1-0x094149` | `src/bank080000.asm` | Untargeted cross-bank payload gap | Sits between proven cross-bank targets; no local code proof yet | Low | Downstream consumer proving whether this is gap/fill, local headers, or untargeted data |
| `0x09414A-0x0961D7` | `src/bank080000_cross_payload_tail.asm` | Cross-bank table-targeted payload records | Same bank `0x040000` flagged-reference evidence as the front half; stable starts already proven | Medium | Same loader/consumer match as the front half |
| `0x0961D8-0x09622A` | `src/bank080000.asm` | Untargeted cross-bank payload gap | Short untargeted interval between proven cross-bank records and fill | Low | Determine whether any pointer family or loader lands here |
| `0x09622B-0x097FFF` | `src/bank080000.asm` | Fill/padding | Long confirmed `0xFF` run with no competing structure | High | None unless a non-fill consumer appears |
| `0x098000-0x09907A` | `src/bank080000_z80_program.asm` | Z80-resident program code | Opens with `DI`, `IM 1`, absolute `JP`, `RETI`, then structured handlers, dispatch tables, and transfer/handshake logic | High | Tie the program to its 68k loader and decide whether it is definitely the audio-side driver or another Z80 service |
| `0x09907B-0x0991FF` | `src/bank080000_z80_program.asm` | Z80 lookup tables | Two odd-aligned little-endian word tables plus trailing zero byte immediately consumed by the Z80 program body | High | Name exact semantic role of each table |
| `0x099200-0x09991F` | `src/bank080000_z80_pre_descriptor_data.asm` | Structured descriptor/metadata tables for the Z80-owned island | Monotone bands, fixed 19-byte records, fixed 16-byte records, fixed 5-byte records, local offsets, repeated words; sits directly between Z80 code and later descriptor/command bands | Medium | Match record fields to the consuming Z80 routines |
| `0x099920-0x099A84` | `src/bank080000_z80_descriptor_tables.asm` | Structured descriptor/layout tables | Fixed 6-byte and 5-byte record cadence with a short tail; strong table shape | Medium | Determine whether these descriptors are voices, animation/layout entries, or another resource family |
| `0x099A85-0x09A347` | `src/bank080000_z80_command_front.asm` | Z80-side command front matter | Zero-fill prelude, lead-in words, bank-local offset table, then FF-terminated command records/subrecords | Medium-High | Exact command format and the producer that feeds this region |
| `0x09A348-0x09F776` | `src/bank080000_z80_command_records_a.asm`, `src/bank080000_z80_command_records_b.asm`, `src/bank080000_z80_command_records_c.asm` | Z80-side command record windows | Whole span now splits cleanly at local `0xFF` terminators; repeated command control bytes match the Z80 program's stream/dispatch logic | Medium-High | Map command opcodes/fields back to named driver behavior |
| `0x09F777-0x09FFFF` | `src/bank080000.asm` | Fill/padding | Confirmed `0xFF` fill run | High | None |
| `0x0A0000-0x0A07C5` | `src/bank080000_offset_tree_payload.asm` | Multi-level offset-table index | Dense big-endian word tree whose entries mostly point back into the same island and its downstream payload | High | Identify the owning loader and the semantic meaning of each table tier |
| `0x0A07C6-0x0A0B25` | `src/bank080000_a07c6.asm`, `src/bank080000_a08e6.asm` | Repeated four-tuple record family | Stable `0x18`-byte cadence with four 6-byte tuples per record | Medium | Determine tuple fields and whether this family is map/object/gfx metadata |
| `0x0A0B26-0x0A10AA` | `src/bank080000_a0b26.asm`, `src/bank080000_a0c83.asm` | Mixed lead-in plus FF-terminated 6-byte record families | Front mixed record prelude followed by narrower FF-terminated 6-byte bands and short structural bridges | Medium | Confirm whether these are headers into the later tuple/payload families or a separate resource class |
| `0x0A10AB-0x0A34FF` | `src/bank080000_ff_terminated_five_byte_tuples.asm` | FF-terminated five-byte tuple family | Full span now source-visible as FF-terminated 5-byte tuple runs plus short anomaly bridges | Medium | Recover tuple semantics and attach the family to a subsystem owner |
| `0x0A3500-0x0A4C76` | `src/bank080000_table_targeted_payload_records.asm` | Table-targeted payload records under offset-tree ownership | Stable starts are proven by the front offset tree; several compact subfamilies are already explicit | Medium | Determine whether the payload family is map/layout/script/gfx metadata and identify the consuming loader |
| `0x0A4C77-0x0BFFFF` | `src/bank080000.asm` | Fill/padding | Long confirmed `0xFF` tail fill | High | None |

## Notes

- Confirmed in-ROM terminology here is structural (`Z80 program`, `offset table`, `descriptor`, `command record`, `fill`).
- Softer subsystem guesses should stay in notes until control flow proves them. For example, the
  `0x098000-0x09F776` island is very likely audio-side or another Z80-owned service, but this catalog
  keeps that as inference rather than baking it into filenames.
