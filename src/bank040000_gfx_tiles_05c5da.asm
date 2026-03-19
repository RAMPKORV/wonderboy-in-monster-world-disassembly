; ROM range: 0x05C5DA-0x05CA99
; Isolated 0x4C0-byte planar tile block inside the bank040000 local-target payload family.
;
; This one record appears before the larger 0x05D630-0x05FC2F planar tile run and keeps the
; same exact 38-tile size. The graphics interpretation is strong enough to give it tile-block
; ownership even though its consumer and precise asset role remain unknown.

Bank040000_LocalTableTargetedIsolatedPlanarTileBlock_05C5DA:
Bank040000_LocalTableTargetedPlanarTileBlock_05C5DA:
	incbin "data/rom/bank_040000_07ffff.bin",$01C5DA,$0004C0
