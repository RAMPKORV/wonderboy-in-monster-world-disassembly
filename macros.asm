; Byte-preserving macro library placeholder for future symbolic cleanup.

dma_vram: macro source,length,destination
	dc.l source
	dc.w length
	dc.w destination
	endm
