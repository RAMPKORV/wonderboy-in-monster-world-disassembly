# 2026-03-19 bank080000 Z80 bit-6 dispatch gate

- Tightened the next proven Z80 main-body frontier in `src/bank080000_mid_z80_program.asm` from `0x098756` through `0x098771`.
- Corrected the earlier boundary at `0x098756`: the former five-byte gate actually consumes six bytes because the trailing `0x20` is a `JR NZ` opcode whose displacement byte is `0x16` at `0x09875B`.
- `0x098756-0x09875B` is now explicit as a bit-6 gate on the IX-local flags byte that skips directly to `0x098772` when the bit is already set.
- `0x09875C-0x098771` is now source-visible as the fallthrough dispatch prelude: it sets that same bit, pushes `0x0772` as a local return target, and branches on `(IX+1)-2` to three deeper handlers at `0x0A08`, `0x0AB2`, and `0x0AA9`.
- The unresolved Z80 main-body continuation now starts later at `0x098772` instead of `0x09875B`.
