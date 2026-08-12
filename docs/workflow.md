# Agent Workflow — Day to Day

This file tells an AI coding agent exactly what to do when working in this
project. Read it alongside `AGENTS.md` (the master instructions) and
`docs/pipeline.md`.

## If the project is freshly copied (no ROM yet, or no conversion done)

You are starting a NEW disassembly. Do this in order:

### 1. Interrogate the user (ask, don't guess)
- Which game / revision is this? (the filename + header will tell you a lot)
- What is the *goal*? (clean documented source, a re-implementation in
  another engine, modding, documentation only)
- Do they have emulator notes, memory maps, or other reverse-engineering
  material?
- Which serial/region are we disassembling? Is this a common revision or a
  rare one?

### 2. Web research the game
Search for: the game's serial, existing disassemblies / reverse-engineering
threads (Sonic Retro, romhacking.net, GitHub), engine articles, technical
docs, the manual, and any known structure (state machine, level format,
compression). Record findings in `docs/game-notes.md`.

### 3. Run setup
```
node tools/setup.js "/path/to/Game (USA).bin"
```
Confirm the baseline build is bit-perfect.

### 4. Map the boot flow (decode, don't convert yet)
- Reset vector → entry point.
- First ~100 instructions: VDP init, RAM clear, Z80 boot, state dispatch.
- Identify the state machine and its table.
- Produce a `docs/game-notes.md` plan: the list of regions/modules to
  convert and in what order.

### 5. Convert the first region (core/boot)
Follow `docs/pipeline.md` Step 2-6. Register it, converge, verify, commit.

### 6. Work through the plan
Convert regions in the planned order, committing after each verified
region (or each couple of regions).

## If the user says "Continue working"

- Read `docs/progress.md` (tracking) and `tools/regions.json` to see where
  things stand.
- Pick the next region from the plan.
- Convert → register → regen → autofix → verify → commit.
- If a region is already fully converted, move to the next; if the plan is
  done, look for what remains (data tables, cleanup, documentation).

## If the user says "Work according to plan"

Same as "Continue working" but explicitly follow `docs/game-notes.md` /
`docs/progress.md` in order, and stop to report when the plan's goals are
met.

## Required checks on EVERY change

1. The build assembles with zero errors:
   `wine asm68k.exe /k /p /o ae- wonderboy.asm,out.bin,,game.lst`
2. `./verify.sh` prints `BUILD VERIFIED - ROM IS BIT-PERFECT`.
   A non-bit-perfect build is NEVER acceptable — do not proceed.
3. Commit each verified module so there's always a known-good checkpoint.
4. Update `docs/progress.md` when a region is registered/verified.

## Writing style for modules

- One instruction per source line, `; $ADDR` trailing comment.
- Labels at column 0; instructions indented with one tab.
- Uppercase mnemonics, lowercase size suffixes: `MOVE.w`, `TST.l`.
- Keep hex for addresses/masks/data; decimal is OK for instruction
  immediates (`MOVE.w #0,D0`).
- Rename `loc_XXXXXXXX` to meaningful PascalCase once a routine is
  understood, keeping the original address in a comment:
  `; loc_0000633C` / `MapRLEDecompressor:`
- Section banner comments (`; ===...===`) at the top of each module and
  before each routine.

## Common pitfalls while converting

- See `docs/asm68k.md` for the full list. The top 3:
  1. Forward `.b` branches → use `*+N` (N = target − addr).
  2. Ghidra `moveq` normalization → restore the true `MOVE.W #imm,Dn`.
  3. Wrong loop labels → branches target the loop-body re-entry, not the
     loop header.
- A region module MUST emit exactly the bytes of its declared
  `regions.json` range. Off-by-one at a region boundary (e.g. a 2-byte
  `rts` straddling the end) silently shifts every later region.

## When the plan is complete

- Verify the whole ROM is bit-perfect one final time.
- Update `docs/game-notes.md` and `docs/engine.md` (create if absent) with
  the engine architecture: state machine, memory map, data formats, and
  how each subsystem works.
- Commit everything with a summary message.
- Report the final structure to the user.
