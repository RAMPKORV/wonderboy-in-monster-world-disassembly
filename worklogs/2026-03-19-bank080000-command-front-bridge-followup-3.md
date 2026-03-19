# 2026-03-19 bank080000 command front bridge follow-up 3

- Tightened two more adjacent front-table command targets in bank `0x080000` without forcing subsystem ownership.
- `src/bank080000_z80_resources.asm` now source-authors the former raw `0x09A13C-0x09A169` continuation as explicit structural records instead of two `incbin` slices.
- `0x09A13C-0x09A148` now stands as a short tuple-style FF-terminated lead-in at `0x09A13C` followed by one compact non-terminated local-target tail at `0x09A141`.
- `0x09A149-0x09A169` now reads as another short tuple-style FF-terminated lead-in at `0x09A149` plus one larger FF-terminated control record at `0x09A14E` built around `F7 10`, `F1 10`, `F2 00 34`, `F4 0C`, and repeated `DF FC` / `F5` control bytes.
- Kept the labels structural. The bytes now justify cleaner record ownership inside the `0x099B00-0x09A347` command front, but they still do not prove whether the wider command stream belongs to audio, credits, animation, or another tail-bank interpreter.
