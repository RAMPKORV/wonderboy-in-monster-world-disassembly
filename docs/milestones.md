# Milestone Gates

## M0 - Bootstrap Rebuild

- Repo scaffold exists.
- Original ROM baseline is preserved and documented.
- `cmd /c verify.bat` reproduces the ROM exactly.

## M1 - Coarse Split

- The ROM body is divided into stable layout-preserving modules.
- Major opaque blobs are extracted into named `data/` files.
- A ROM range manifest tracks module ownership.

## M2 - Named Core Engine

- Reset/startup, interrupts, and frame loop have stable labels.
- Core RAM and hardware constants exist.
- Main state dispatchers are documented.

## M3 - Documented Data Formats

- Key graphics, map, text, and compression formats are understood.
- Extract/build tooling round-trips decoded assets byte-identically.
- Blob manifests describe owners, formats, and unresolved questions.

## M4 - Tooling-Ready Foundation

- Symbol exports, validation scripts, and ROM diff tooling are stable.
- Data extraction and injection flows support safe editing.
- The project is ready to support viewers, editors, and modding workflows.
