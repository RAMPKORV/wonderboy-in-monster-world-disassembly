# Ghidra Conventions

## Label Prefixes

- `sub_` for code not yet semantically named
- `jmp_tbl_` for jump tables
- `ptr_` for pointer tables
- `data_` for named but still-opaque data blocks
- `blob_` for larger opaque binary regions
- `str_` for decoded text or string-like content

## Bookmark Categories

- `entrypoint`
- `interrupt`
- `header`
- `jump-table`
- `pointer-table`
- `graphics`
- `audio`
- `compression`
- `text`
- `uncertain`

## Rules

- Keep labels stable once mirrored into source.
- Prefer ROM-offset-informed names over auto-generated placeholders.
- Mark uncertain boundaries explicitly instead of silently forcing a code/data decision.
