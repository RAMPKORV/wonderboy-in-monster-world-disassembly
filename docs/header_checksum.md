# Header Checksum

The bootstrap rebuild currently preserves the original header checksum value `0x9D79`
verbatim in `header.asm`.

No in-ROM checksum validation routine has been documented yet, so phase 0 treats the
checksum as a byte-identity requirement rather than a regenerated field.

Follow-up work:

- Locate any runtime checksum handling in code analysis.
- Decide whether future build tooling should preserve or recalculate the field.
- Keep `verify.bat` focused on whole-ROM hash identity until that research is complete.
