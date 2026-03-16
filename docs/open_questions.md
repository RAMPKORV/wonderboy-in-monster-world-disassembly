# Open Questions

- Confirm whether the unusual SRAM support field at `0x01B0` is meaningful runtime data
  or simply a header artifact inherited from another configuration.
- Document whether the ROM ever validates the header checksum internally.
- Establish the first coarse ROM region map after Ghidra import.
- Prove the exact format and producers/consumers of the apparent input-playback stream used
  by `0x005016-0x00505C`. Current best fit is `(duration,value)` records in `0xFF1400`
  with `0x8A7A-0x8A7D` reused as selected-input playback state, but the upstream writers
  and downstream gameplay consumers are still unresolved.
- Pin down the exact semantics of the newly recovered bootstrap helpers at `0x005170` and
  `0x005188`, especially what the `0x8B34-0x8B3A` patch words and the six-byte stream at
  `0x0051C0` represent beyond their current best-fit decoder/bootstrap interpretation.
- Decide when the `0x000200+` body should be split into smaller `incbin` modules.
