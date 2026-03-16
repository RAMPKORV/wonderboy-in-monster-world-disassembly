# Naming And Contribution Guide

## Naming

- Keep ROM-order source splits intact; do not reshuffle modules for aesthetics.
- Prefer hexadecimal literals in assembly and ROM data tables.
- Use meaningful labels once a block is understood; keep unknown ranges byte-perfect.
- Reserve `data/` for opaque blobs and `src/` for source-authored assembly.

## Verification

- Run `cmd /c verify.bat` after source changes.
- Run `node tools/validate_todos.js` after editing `todos.json`.
- Run `node tools/run_checks.js` before handing off larger bootstrap changes.

## Comments

- Add comments for calling conventions, invariants, or ROM-layout artifacts.
- Avoid narration for obvious instructions or raw byte mirrors.
