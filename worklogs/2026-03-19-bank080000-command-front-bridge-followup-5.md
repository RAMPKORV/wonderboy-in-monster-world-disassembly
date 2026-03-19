# 2026-03-19 bank080000 command front bridge follow-up 5

- Tightened another adjacent bridge in bank `0x080000`'s `0x099B00-0x09A347` command front without forcing
  subsystem ownership.
- `src/bank080000_z80_resources.asm` now source-authors the former raw `0x099F24-0x09A10D` stretch as explicit tuple-led and
  FF-terminated subrecords instead of seventeen `incbin` slices.
- `0x099F24-0x099FDA` now stands as a repeated tuple-plus-control family with compact `F5/FE` and local-offset tails,
  including the denser `0x099F63` control body and neighboring short literal/high-byte pockets at `0x099F93` and
  `0x099FAA`.
- `0x099FFA-0x09A01D` now makes one shared bridge explicit: the tuple at `0x09A010` and the `F7/F4/F2/F0` setup bytes
  at `0x09A015` feed the following `0x09A01E` target rather than belonging to the preceding `0x099FFA` body.
- `0x09A02B-0x09A10D` continues the same structural rhythm with several short tuple-led control records, one local-target
  lead-out at `0x09A0DB`, and a final lead-out at `0x09A0FE` into the already explicit compound record at `0x09A10E`.
- Kept the labels structural. The bytes now justify a cleaner ROM-order split across most of the remaining
  `0x099B00-0x09A347` front table, but they still do not prove whether the wider command stream belongs to audio,
  credits, animation, or another tail-bank interpreter.
