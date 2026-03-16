# Debug Workflow

## Initial Emulator Strategy

- Use an emulator with 68000 stepping, ROM breakpoints, and RAM watches.
- Start by validating reset flow at `0x00000200` and interrupt targets around `0x00004B5C`.
- Record RAM writes in the `0x00FF0000-0x00FFFFFF` range during the first few frames.

## Feedback Loop

1. Capture an execution trace or breakpoint notes.
2. Mirror discovered labels and boundaries into Ghidra.
3. Reflect stable names or ownership notes back into source/docs.
4. Re-run `cmd /c verify.bat` after any source-side split changes.
