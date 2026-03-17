; ROM range: 0x040000-0x07FFFF
; Late-ROM bank split into bank-local slices. The first confirmed structure here is a
; long 0xFF fill run at 0x0409FA-0x040FFF, so keep that hotspot explicitly labeled while
; the surrounding code/data bank is still being mapped.

Bank040000:
	incbin "data/rom/bank_040000_07ffff.bin",$000000,$0009FA

Bank040000_Fill_0409FA_040FFF:
	incbin "data/rom/bank_040000_07ffff.bin",$0009FA,$000606

Bank040000_AfterFill_041000:
	incbin "data/rom/bank_040000_07ffff.bin",$001000,$03F000
