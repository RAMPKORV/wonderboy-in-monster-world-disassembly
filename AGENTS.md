## Wonder Boy Repo Guidance

- Preserve a bit-perfect rebuild at all times; after every non-trivial change run `cmd /c verify.bat` and fix the cause of any mismatch.
- Treat `data/rom/*.bin` as temporary scaffolding for still-opaque bytes, not as an acceptable resting place for recoverable code or annotateable structured data.
- If a `.bin` region is proven to contain significant 68k code, pointer tables, price/value tables, string/name tables, script records, jump tables, or other structured formats, convert that region into source-authored `.asm` instead of leaving the understanding trapped in comments, notes, or external tools.
- Do not leave critical discoveries as comment-only summaries when the bytes can be represented directly as code or `dc.b`/`dc.w`/`dc.l` data in source.
- Use `.lst` output and byte comparison against `original/wonderboy.bin` to confirm extracted code/data still assembles to the exact original bytes.
- Prefer semantic owners and shared symbols in `ram_addresses.asm`, `game_constants.asm`, `hw_constants.asm`, `sound_constants.asm`, and `macros.asm` over raw addresses and magic values, but never at the cost of byte identity.
- When a temporary ROM-order split is unavoidable, document what still blocks promotion into a real subsystem/module and retire the temporary slice as soon as ownership is proven.
- Important ongoing priority: audit existing `.bin`-backed regions for hidden code and annotateable data tables, then move them into maintained `.asm` modules.
