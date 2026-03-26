; ROM range: 0x045842-0x045D01
; Early isolated 0x4C0-byte planar tile block inside the bank040000 local-target payload family.
;
; The front flagged ROM-reference table now makes this earlier singleton explicit: it is the first
; same-bank $01-tagged target before the later 0x04BFAA, 0x05C5DA, 0x05D630, and 0x06B192 planar
; tile families. Like those later blocks, it is exactly 38 Mega Drive 4bpp tiles.

Bank040000_LocalTableTargetedIsolatedPlanarTileBlock_045842:
Bank040000_LocalTableTargetedPlanarTileBlock_045842:
	incbin "data/rom/bank_040000_07ffff.bin",$005842,$0004C0
