; ======================================================================
; src/bootstrap_init.asm
; ROM range: 0x000200-0x004B57 - bootstrap blob kept in physical ROM order
; ======================================================================
; The front bootstrap text-helper island at 0x001E20-0x00210F is now source-authored,
; including the mixed text/control decoder, found-item/found-gold message builders, and the
; adjacent numeric value table used by that path.

InitRegion:
	incbin "data/rom/init_000200_004b57.bin",$000000,$001C20

BootstrapMenuTextHelpers_001E20:
	include "src/bootstrap_menu_text_helpers.asm"

	incbin "data/rom/init_000200_004b57.bin",$001F10,$002A48
