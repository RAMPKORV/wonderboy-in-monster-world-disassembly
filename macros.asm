; Byte-preserving macro library placeholder for future symbolic cleanup.

dma_vram: macro source,length,destination
	dc.l source
	dc.w length
	dc.w destination
	endm

flagged_rom_ref: macro tag,target
	dc.l ((tag)<<24)|target
	endm

flagged_rom_ref_unused: macro
	dc.l FlaggedRomReferenceUnusedValue
	endm
