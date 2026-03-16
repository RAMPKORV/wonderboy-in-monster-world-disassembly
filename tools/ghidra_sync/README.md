# Ghidra Sync Helpers

- `node tools/ghidra_sync/export_source_sync.js` writes `ghidra/exports/source_sync_bundle.json`
- `node tools/ghidra_export.js` exports live Ghidra symbols, functions, comments, and bookmarks
- `node tools/ghidra_sync/import_ghidra_exports.js` normalizes exported Ghidra JSON back into `tools/index/`
