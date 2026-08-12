# asm68k.exe (SN System 68k, v2.53) — Verified Quirks

These are the assembler behaviours we hit while making a bit-perfect build.
**Every one of these was confirmed against a real ROM.** When in doubt,
trust the ROM bytes, not the assembler's output.

## 1. Branch displacement is relative to `addr+2` — for EVERY branch

`Bcc.b`, `Bcc.w`, `BRA`, `BSR`, `DBF` all compute the target as
`addr + 2 + displacement`. So:

- a `.b` branch at `$3100` to `$3104` has displacement `$02`.
- a `.w` branch at `$3100` to `$3104` has displacement `$0002`.
- `Bcc.w` / `BSR.w` are 4 bytes; `Bcc.l` is 6 bytes.

Ghidra computes targets correctly. Do **not** "correct" them to `addr+4`.

## 2. Forward SHORT branches (.b) to a later label assemble to disp $00

If the target label is defined *later in the source*, asm68k's pass-1 emits
displacement 0 and pass-2 does **not** fix `.b` sizes. Workaround: write the
branch with an explicit offset operand:

```
    bsr.b  *+$24            ; $B6C2 bsr.b -> $B6E6   (displacement $22)
```

For `*+N`, the emitted displacement is `N - 2`, so `N = target − addr`.

- Backward `.b` branches to earlier labels are FINE.
- `.w` and `.l` branches to forward labels are FINE.
- Only forward `.b` breaks.

## 3. `*+N` displacement rule (applies to both .b and .w)

The operand `*+N` is the absolute address `addr + N`; asm68k then emits
displacement `N - 2`. So:

| You want target | at addr | write        | emitted disp |
|-----------------|---------|--------------|--------------|
| $42C8           | $42C0   | `bsr.b *+$08`| $06          |
| $483E           | $47E0   | `beq.w *+$5E`| $005C        |

The classic mistake is writing `N = disp` (off by 2). Always compute
`N = target − addr`.

## 4. Ghidra normalizes `MOVE.W #byte,Dn` to `moveq`

Ghidra's listing shows `moveq $3F,D7` where the ROM really has
`3E3C 003F` = `MOVE.W #$003F,D7` (4 bytes). Copying the `moveq` form shrinks
your module by 2 bytes per occurrence. Symptom: the module comes up 2 bytes
short and the `; $ADDR` hints stop being monotonic. Hunt for Ghidra-invented
`moveq` and restore the true `MOVE.W`.

## 5. Ghidra misprints ABSOLUTE ADDRESSES and can SKIP instructions

- Ghidra may print `tst.w (0x00ffe010).l` where the ROM bytes are
  `4A79 00FFF010`. Trust the ROM bytes for absolute operands.
- Ghidra may omit instructions entirely (control-flow analysis skips).
  Always cross-check your `; $ADDR` hints for monotonicity.

## 6. The `(An)` vs `$00(An)` d16 form

asm68k emits the *short* 2-byte `MOVE Dn,(An)` / `MOVE (An),Dn` form when
the displacement is zero. The ROM frequently uses the 4-byte `d16` form
(`31C0 0000`). Write `$00(An)` explicitly to force the long encoding.

This also happens with `movea.l (A0),A1` vs `movea.l $00(A0),A1` — check
which the ROM used.

## 7. Shift-count encoding for `#1`

`ASL.W #1,D0` assembles to `$E148` in asm68k, but many ROMs use `$E348`
(count field `$01`). Any `ASL/ASR/LSL/LSR` with immediate count `1` is a
suspect; autofix will turn it into a `dc.w`. Counts ≥ 2 are fine.

## 8. `MOVE.W/B Dn,#imm,(An)` — the missing d16

See #6. Autofix's classic "SIZE MISMATCH of 2 bytes per line" report means
you used the short form where the ROM used `d16`.

## 9. Indexed-PC addressing (`(d,PC,Dn)`)

asm68k cannot emit several indexed-PC forms:

- `JMP (d,PC,Dn.w)` → emit `dc.w $4EBB, <disp>`
- `JMP (d,PC,Dn.l)` → emit `dc.w $4EFB, <disp>`
- `JSR (d,PC,Dn.w)` → emit `dc.w $4EBA, <disp>`
- `MOVE.W (d,PC,Dn.w),D0` → emit `dc.w $303B, <disp>`

The displacement is the ROM's raw extension word — **authoritative**. Ghidra
often mis-computes these; read the byte from the ROM.

## 10. The `DC.W` "space-comma" bug (autofix fixed)

asm68k **drops every value after a space-comma**: `dc.w $1234 ,$5678`
emits only `$1234`. Never put a space before a comma in multi-value `dc.w`.
`tools/autofix.js` now emits no-space commas.

## 11. Wrong-label symptom (the most common failure)

When autofix turns a branch into `dc.w`, it usually means the target label
sits on the **wrong instruction** — typically the loop header instead of the
loop-body re-entry point. Example: a `dbf` that targets the `move.l` inside
the loop, not the label at the loop top. Compute the target from
`addr+2+disp`, move the label, restore the mnemonic. Correct labels make
PASS 1 clean with real mnemonics.

## 12. `.b` vs `.w` branch SIZE (a hidden 2 bytes per branch)

The ROM sometimes uses a 4-byte `bne.w/beq.w` where a 2-byte `.b` would
fit. If your module is N×2 bytes short, check every branch's Ghidra size
suffix (`.b` vs `.w`) against the ROM bytes — not your intuition.

## 13. `moveq #imm,Dn` value mangling

asm68k mangles `moveq` immediates whose **positive hex byte is >= $80**
(e.g. `moveq #$EF,D0` emits `$7061`, not `$70EF`). Use the negative form:
`moveq #-$11,D0` (== `$70EF`) or decimal `moveq #-17,D0` — both assemble
correctly. When in doubt, test against the ROM byte and fall back to the
`dc.w` form. Also: `moveq` takes **no size suffix** (`moveq #1,D0`, not
`moveq.l`).

## 14. `movem.l` register lists

- No braces: `movem.l D0/A1/D2,-(SP)` (the `{...}` brace form is rejected).
- Predecrement masks are bit-reversed; let asm68k compute them — do not
  hand-write masks.
- Register ranges must be ascending (`A0-A3`, not `A3-A0`).

## 15. EQU vs label resolution order

EQU constants are resolved at their **point of use** — a module included
early that references an EQU defined in a later module fails. Put shared
constants (RAM addresses, data pointers) in `src/game_constants.asm`
(included first). Routine *labels* forward-reference freely across modules.

## 16. `MOVE from SR` / `MOVE to SR`

`move SR,Dn` = `$40Cn`; `move #imm,SR` = `$46FC imm`. Write them without a
size suffix (`move SR,D0`). Note the ROM may pop a *different* register than
it pushed (e.g. push D3, pop D0) — match the bytes exactly.

## 17. `ori`/`andi` to CCR

Used to set/clear the carry flag as a return convention:
- `ori.w #1, CCR` = `$003C 0001`
- `andi.w #$FE, CCR` = `$023C 00FE` (note: `$FE`, not `$FFFE` — check the ROM)

## 18. PC-relative `lea` — operand is an ABSOLUTE target

asm68k treats `LEA ($7C,PC),A5` / `LEA $7C(PC),A5` as "target = absolute
address $7C", and emits displacement = `$7C - (addr+2)`. Ghidra prints the
ROM's *displacement* (`($7C,PC)` means target = PC+2+$7C = $28E), so a
direct transcription targets the wrong address and autofix rewrites it to
`dc.w $4BFA,$007C`. Use the label form and asm68k computes the displacement:
```
	lea	BootInitTable(PC), A5	; -> $4BFA $007C at $210
```

## 19. EXG non-canonical encodings

The ROM uses EXG encodings asm68k never produces (e.g. `$C340` vs asm68k's
`$C141` for the same register pair). Transcribe them as `dc.w $C340 ; EXG`.
Also: `move.l (d16,PC,Dn.w),-(SP)` index-table dispatch works with a label
(`move.l JumpTable(PC,D0.w),-(SP)`), and the listing shows disp `$0000`
for forward PC-relative refs even though the binary is correct.

## Diagnostic Workflow

1. `node tools/findfirstdiff.js game.rom out.bin` — first mismatched byte.
   A *value* diff (same size) = wrong operand/label. A *shift* = module
   emitted wrong total length.
2. `node tools/regiondiff.js game.rom <start> <end>` — diffs within a region.
3. `node tools/findshift.js game.rom` — finds where the output shifted and
   by how much (size errors).
4. Check the `game.lst` listing: the `; $ADDR` hints in your module vs the
   listing addresses reveal exactly where the module drifted.

When autofix reports `listing entries != source instr`, the module size is
wrong. Fix the instruction; don't let autofix guess.
