; ======================================================================
; src/bank080000.asm
; ROM range: 0x080000-0x0BFFFF - tail-bank payloads, Z80 resources, and offset-tree data
; ======================================================================
; Tail-bank owner split around the largest confirmed 0xFF fill runs. The front non-fill
; slice is no longer one opaque bank chunk either: the cross-bank flagged ROM-reference
; tables at 0x0418AC-0x041BBF now prove 178 stable target starts inside 0x0801CD-0x0961D7,
; so that pre-fill payload is split into two ROM-order include modules with the untargeted
; gaps left explicit in this file.

Bank080000:
	incbin "data/rom/bank_080000_0bffff.bin",$000000,$0001CD

Bank080000_CrossBankTableTargetedPayloadFront_0801CD:
	include "src/bank080000/cross_payload_front.asm"

Bank080000_CrossBankTableTargetGap_093FD1:
	incbin "data/rom/bank_080000_0bffff.bin",$013FD1,$000179

Bank080000_CrossBankTableTargetedPayloadTail_09414A:
	include "src/bank080000/cross_payload_tail.asm"

Bank080000_CrossBankTableTargetGap_0961D8:
	incbin "data/rom/bank_080000_0bffff.bin",$0161D8,$000053

Bank080000_Fill_09622B_097FFF:
	incbin "data/rom/bank_080000_0bffff.bin",$01622B,$001DD5

Bank080000_Z80Resources_098000_09F776:
	include "src/bank080000/z80_resources.asm"

Bank080000_Fill_09F777_09FFFF:
	incbin "data/rom/bank_080000_0bffff.bin",$01F777,$000889

Bank080000_OffsetTreePayload_0A0000_0A4C76:
	include "src/bank080000/offset_tree_payload.asm"

Bank080000_Fill_0A4C77_0BFFFF:
	incbin "data/rom/bank_080000_0bffff.bin",$024C77,$01B389
