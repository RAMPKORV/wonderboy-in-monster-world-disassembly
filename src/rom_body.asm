RomBody:
	include "src/init.asm"
	include "src/vblank.asm"
	include "src/core.asm"
	incbin "data/rom/bank_020000_03ffff.bin"
	incbin "data/rom/bank_040000_07ffff.bin"
	incbin "data/rom/bank_080000_0bffff.bin"

EndOfRom:
