; ROM range: 0x000200-0x004B57
; Physical order preserved; this module remains an opaque bootstrap blob for now.

InitRegion:
	incbin "data/rom/init_000200_004b57.bin"
