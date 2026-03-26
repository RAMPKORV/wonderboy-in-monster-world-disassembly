; ROM range: 0x09414A-0x0961D7
; Tail continuation of the same cross-bank-targeted payload family reached from the late
; bank040000 flagged ROM-reference table cluster. The final target begins one byte before
; the explicit 0x09622B-0x097FFF fill run, leaving a small untargeted tail gap in the owner.

Bank080000_CrossBankTableTargetedRecord_09414A:
	incbin "data/rom/bank_080000_0bffff.bin",$01414A,$00028F

Bank080000_CrossBankTableTargetedRecord_0943D9:
	incbin "data/rom/bank_080000_0bffff.bin",$0143D9,$0002C9

Bank080000_CrossBankTableTargetedRecord_0946A2:
	incbin "data/rom/bank_080000_0bffff.bin",$0146A2,$0002B4

Bank080000_CrossBankTableTargetedRecord_094956:
	incbin "data/rom/bank_080000_0bffff.bin",$014956,$0002AE

Bank080000_CrossBankTableTargetedRecord_094C04:
	incbin "data/rom/bank_080000_0bffff.bin",$014C04,$0002CA

Bank080000_CrossBankTableTargetedRecord_094ECE:
	incbin "data/rom/bank_080000_0bffff.bin",$014ECE,$00020A

Bank080000_CrossBankTableTargetedRecord_0950D8:
	incbin "data/rom/bank_080000_0bffff.bin",$0150D8,$000218

Bank080000_CrossBankTableTargetedRecord_0952F0:
	incbin "data/rom/bank_080000_0bffff.bin",$0152F0,$0001E6

Bank080000_CrossBankTableTargetedRecord_0954D6:
	incbin "data/rom/bank_080000_0bffff.bin",$0154D6,$0001BD

Bank080000_CrossBankTableTargetedRecord_095693:
	incbin "data/rom/bank_080000_0bffff.bin",$015693,$000172

Bank080000_CrossBankTableTargetedRecord_095805:
	incbin "data/rom/bank_080000_0bffff.bin",$015805,$0000C9

Bank080000_CrossBankTableTargetedRecord_0958CE:
	incbin "data/rom/bank_080000_0bffff.bin",$0158CE,$00017A

Bank080000_CrossBankTableTargetedRecord_095A48:
	incbin "data/rom/bank_080000_0bffff.bin",$015A48,$0002F1

Bank080000_CrossBankTableTargetedRecord_095D39:
	incbin "data/rom/bank_080000_0bffff.bin",$015D39,$0002D6

Bank080000_CrossBankTableTargetedRecord_09600F:
	incbin "data/rom/bank_080000_0bffff.bin",$01600F,$0001C8

Bank080000_CrossBankTableTargetedRecord_0961D7:
	incbin "data/rom/bank_080000_0bffff.bin",$0161D7,$000001
