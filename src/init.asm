; ======================================================================
; src/init.asm
; ROM range: 0x000200-0x004B57 - bootstrap blob kept in physical ROM order
; ======================================================================

InitRegion:
	incbin "data/rom/init_000200_004b57.bin"
