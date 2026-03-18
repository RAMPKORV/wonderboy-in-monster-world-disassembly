; ROM range: 0x02482C-0x03FFFF
; Tail region of bank 020000.
;
; Structure:
;   0x02482C  4-entry relative-offset table (10 bytes, terminated by 0xFF7B sentinel)
;             Offsets are relative to the table base (0x02482C):
;               0x0016 -> 0x024842  (sub-entry 0 within Block 1 RLE data)
;               0x007A -> 0x0248A6  (sub-entry 1 within Block 1 RLE data)
;               0x00EA -> 0x024916  (sub-entry 2 within Block 1 RLE data)
;               0x015E -> 0x02498A  (sub-entry 3 within Block 1 RLE data)
;               0xFF7B              (end-of-table sentinel)
;   0x024836  RLE/compressed graphics data blocks, each terminated by 0xFF7B.
;             Blocks 1-9 are confirmed by 0xFF7B terminators.
;   0x035078  More compressed/data blocks. The next three are terminated by
;             0xFF7A instead, and only the final 0x03C6E0-0x03FFFF tail still
;             lacks a proven internal split.
;
; The 0x52, 0x4A, 0x5A byte values within block payloads are RLE opcodes;
; 0xFF-heavy runs are fill patterns. This is consistent with Mega Drive
; tile/sprite compressed graphics formats.

; --- Offset table (0x02482C-0x024835, 10 bytes) ---
; 4 relative offsets into Block 1 payload + 0xFF7B end-of-table sentinel.
Bank020000_TailOffsetTable_02482C:
	dc.w	$0016,$007A,$00EA,$015E,$FF7B

; --- Block 1 (0x024836-0x025125, 2288 bytes) ---
; RLE-compressed graphics block. 12-byte header at 0x024836 followed by
; sub-entries at offsets 0x0016, 0x007A, 0x00EA, 0x015E from the offset table
; base (0x02482C). Block terminated by 0xFF7B at 0x025124.
Bank020000_TailGfxBlock1_024836:
	incbin "data/rom/bank_020000_03ffff.bin",$004836,$0008F0

; --- Block 2 (0x025126-0x0289B7, 14482 bytes) ---
; RLE-compressed graphics block, header 0x0B60... Terminated by 0xFF7B at 0x0289B6.
Bank020000_TailGfxBlock2_025126:
	incbin "data/rom/bank_020000_03ffff.bin",$005126,$003892

; --- Block 3 (0x0289B8-0x02AE74, 9405 bytes) ---
; RLE-compressed graphics block, header 0x1161... Terminated by 0xFF7B at 0x02AE73.
Bank020000_TailGfxBlock3_0289B8:
	incbin "data/rom/bank_020000_03ffff.bin",$0089B8,$0024BD

; --- Block 4 (0x02AE75-0x02F70F, 18587 bytes) ---
; RLE-compressed graphics block, header 0x7F63... Terminated by 0xFF7B at 0x02F70E.
Bank020000_TailGfxBlock4_02AE75:
	incbin "data/rom/bank_020000_03ffff.bin",$00AE75,$00489B

; --- Block 5 (0x02F710-0x030479, 3434 bytes) ---
; Compressed/bitfield data block, header 0x8F07... Terminated by 0xFF7B at 0x030478.
Bank020000_TailGfxBlock5_02F710:
	incbin "data/rom/bank_020000_03ffff.bin",$00F710,$000D6A

; --- Block 6 (0x03047A-0x0304ED, 116 bytes) ---
; Compressed/bitfield data block, header 0x0F03... Terminated by 0xFF7B at 0x0304EC.
Bank020000_TailGfxBlock6_03047A:
	incbin "data/rom/bank_020000_03ffff.bin",$01047A,$000074

; --- Block 7 (0x0304EE-0x03140D, 3872 bytes) ---
; Compressed/bitfield data block, same header pattern as Block 6 (0x0F03...).
; Terminated by 0xFF7B at 0x03140C.
Bank020000_TailGfxBlock7_0304EE:
	incbin "data/rom/bank_020000_03ffff.bin",$0104EE,$000F20

; --- Block 8 (0x03140E-0x034AEB, 14046 bytes) ---
; Compressed/bitfield data block, header 0xC0FB... Terminated by 0xFF7B at 0x034AEA.
Bank020000_TailGfxBlock8_03140E:
	incbin "data/rom/bank_020000_03ffff.bin",$01140E,$0036DE

; --- Block 9 (0x034AEC-0x035077, 1420 bytes) ---
; RLE-compressed graphics block, header 0x0660... Terminated by 0xFF7B at 0x035076.
Bank020000_TailGfxBlock9_034AEC:
	incbin "data/rom/bank_020000_03ffff.bin",$014AEC,$00058C

; --- Block 10 (0x035078-0x03519D, 294 bytes) ---
; Compact compressed/data block, header 0x0660... Terminated by 0xFF7A at 0x03519C.
Bank020000_TailGfxBlock10_035078:
	incbin "data/rom/bank_020000_03ffff.bin",$015078,$000126

; --- Block 11 (0x03519E-0x0354F3, 854 bytes) ---
; Compact compressed/data block, header 0x0B60... Terminated by 0xFF7A at 0x0354F2.
Bank020000_TailGfxBlock11_03519E:
	incbin "data/rom/bank_020000_03ffff.bin",$01519E,$000356

; --- Block 12 (0x0354F4-0x03C6DF, 29164 bytes) ---
; Larger compressed/data block, header 0x0F00... Terminated by 0xFF7A at 0x03C6DE.
Bank020000_TailGfxBlock12_0354F4:
	incbin "data/rom/bank_020000_03ffff.bin",$0154F4,$0071EC

; --- Final tail continuation (0x03C6E0-0x03FFFF, 14624 bytes) ---
; This bank end still lacks proven 0xFF7A/0xFF7B terminators, but several later internal
; starts are now called out explicitly because they begin with the same 0x0960 / 0x0F00 /
; 0x0B60-style header-like prefixes already seen in earlier tail blocks. Keep the names
; structural until a loader or decompressor proves whether these are true block headers,
; format variants, or nested substreams.
	include "src/bank020000_tail_remainder.asm"
