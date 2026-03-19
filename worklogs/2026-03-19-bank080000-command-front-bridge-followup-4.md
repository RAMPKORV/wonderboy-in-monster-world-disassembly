# 2026-03-19 bank080000 command front bridge follow-up 4

- Tightened another front-table chunk in bank `0x080000` without forcing subsystem ownership.
- `src/bank080000_z80_resources.asm` now source-authors the former raw `0x099D78-0x099F23` stretch as explicit structural subrecords instead of twelve `incbin` slices.
- `0x099D78-0x099DE5` now stands as short tuple-style lead-ins plus compact FF-terminated control bodies and tiny FE/F5 trailers.
- `0x099DE6-0x099E0A` now makes one shared bridge explicit: the tuple at `0x099E05` and single-byte lead-in at `0x099E0A` feed the following `0x099E0B` target rather than belonging to the earlier `0x099DE6` body.
- `0x099E36-0x099ED1` and `0x099ED2-0x099F23` continue the same tuple-plus-control rhythm, including one larger literal/high-byte pocket at `0x099EA6` and smaller FC/F5 or FE-tagged tails nearby.
- Kept the labels structural. The bytes now justify cleaner table-targeted command ownership inside `0x099B00-0x09A347`, but they still do not prove whether the wider command stream belongs to audio, credits, animation, or another tail-bank interpreter.
