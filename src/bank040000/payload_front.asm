; ROM range: 0x041C00-0x04A70E
; Front chunk of the local-target payload family reached from the flagged ROM-reference
; table at 0x041000-0x0418AB. Those table entries point monotonically into the larger
; 0x041C00-0x07FF66 payload region; this first 0x8B0F-byte window now keeps the proven
; ROM-order starts explicit instead of leaving the entire local-target body monolithic.
;
; The tagged front table now also proves that the isolated 0x045842 target belongs with the
; later planar tile blocks rather than the surrounding irregular payload records, so that one
; block now lives in its own graphics-oriented child module too.

Bank040000_LocalTableTargetedPayloadRecord_041C00:
	incbin "data/rom/bank_040000_07ffff.bin",$001C00,$0000CF

Bank040000_LocalTableTargetedPayloadRecord_041CCF:
	incbin "data/rom/bank_040000_07ffff.bin",$001CCF,$00011C

Bank040000_LocalTableTargetedPayloadRecord_041DEB:
	incbin "data/rom/bank_040000_07ffff.bin",$001DEB,$000138

Bank040000_LocalTableTargetedPayloadRecord_041F23:
	incbin "data/rom/bank_040000_07ffff.bin",$001F23,$0000F6

Bank040000_LocalTableTargetedPayloadRecord_042019:
	incbin "data/rom/bank_040000_07ffff.bin",$002019,$000136

Bank040000_LocalTableTargetedPayloadRecord_04214F:
	incbin "data/rom/bank_040000_07ffff.bin",$00214F,$000159

Bank040000_LocalTableTargetedPayloadRecord_0422A8:
	incbin "data/rom/bank_040000_07ffff.bin",$0022A8,$000152

Bank040000_LocalTableTargetedPayloadRecord_0423FA:
	incbin "data/rom/bank_040000_07ffff.bin",$0023FA,$000154

Bank040000_LocalTableTargetedPayloadRecord_04254E:
	incbin "data/rom/bank_040000_07ffff.bin",$00254E,$0002B7

Bank040000_LocalTableTargetedPayloadRecord_042805:
	incbin "data/rom/bank_040000_07ffff.bin",$002805,$000262

Bank040000_LocalTableTargetedPayloadRecord_042A67:
	incbin "data/rom/bank_040000_07ffff.bin",$002A67,$00025E

Bank040000_LocalTableTargetedPayloadRecord_042CC5:
	incbin "data/rom/bank_040000_07ffff.bin",$002CC5,$000285

Bank040000_LocalTableTargetedPayloadRecord_042F4A:
	incbin "data/rom/bank_040000_07ffff.bin",$002F4A,$000260

Bank040000_LocalTableTargetedPayloadRecord_0431AA:
	incbin "data/rom/bank_040000_07ffff.bin",$0031AA,$0001DA

Bank040000_LocalTableTargetedPayloadRecord_043384:
	incbin "data/rom/bank_040000_07ffff.bin",$003384,$0001E4

Bank040000_LocalTableTargetedPayloadRecord_043568:
	incbin "data/rom/bank_040000_07ffff.bin",$003568,$00016B

Bank040000_LocalTableTargetedPayloadRecord_0436D3:
	incbin "data/rom/bank_040000_07ffff.bin",$0036D3,$00011C

Bank040000_LocalTableTargetedPayloadRecord_0437EF:
	incbin "data/rom/bank_040000_07ffff.bin",$0037EF,$0002B1

Bank040000_LocalTableTargetedPayloadRecord_043AA0:
	incbin "data/rom/bank_040000_07ffff.bin",$003AA0,$0001B0

Bank040000_LocalTableTargetedPayloadRecord_043C50:
	incbin "data/rom/bank_040000_07ffff.bin",$003C50,$000190

Bank040000_LocalTableTargetedPayloadRecord_043DE0:
	incbin "data/rom/bank_040000_07ffff.bin",$003DE0,$000180

Bank040000_LocalTableTargetedPayloadRecord_043F60:
	incbin "data/rom/bank_040000_07ffff.bin",$003F60,$000167

Bank040000_LocalTableTargetedPayloadRecord_0440C7:
	incbin "data/rom/bank_040000_07ffff.bin",$0040C7,$00026D

Bank040000_LocalTableTargetedPayloadRecord_044334:
	incbin "data/rom/bank_040000_07ffff.bin",$004334,$0001B2

Bank040000_LocalTableTargetedPayloadRecord_0444E6:
	incbin "data/rom/bank_040000_07ffff.bin",$0044E6,$0001D5

Bank040000_LocalTableTargetedPayloadRecord_0446BB:
	incbin "data/rom/bank_040000_07ffff.bin",$0046BB,$00016C

Bank040000_LocalTableTargetedPayloadRecord_044827:
	incbin "data/rom/bank_040000_07ffff.bin",$004827,$00022C

Bank040000_LocalTableTargetedPayloadRecord_044A53:
	incbin "data/rom/bank_040000_07ffff.bin",$004A53,$000214

Bank040000_LocalTableTargetedPayloadRecord_044C67:
	incbin "data/rom/bank_040000_07ffff.bin",$004C67,$000262

Bank040000_LocalTableTargetedPayloadRecord_044EC9:
	incbin "data/rom/bank_040000_07ffff.bin",$004EC9,$000205

Bank040000_LocalTableTargetedPayloadRecord_0450CE:
	incbin "data/rom/bank_040000_07ffff.bin",$0050CE,$0001E8

Bank040000_LocalTableTargetedPayloadRecord_0452B6:
	incbin "data/rom/bank_040000_07ffff.bin",$0052B6,$00009D

Bank040000_LocalTableTargetedPayloadRecord_045353:
	incbin "data/rom/bank_040000_07ffff.bin",$005353,$0001A8

Bank040000_LocalTableTargetedPayloadRecord_0454FB:
	incbin "data/rom/bank_040000_07ffff.bin",$0054FB,$0001A9

Bank040000_LocalTableTargetedPayloadRecord_0456A4:
	incbin "data/rom/bank_040000_07ffff.bin",$0056A4,$00019E

	include "src/bank040000/gfx_tiles_045842.asm"

Bank040000_LocalTableTargetedPayloadRecord_045D02:
	incbin "data/rom/bank_040000_07ffff.bin",$005D02,$0001A9

Bank040000_LocalTableTargetedPayloadRecord_045EAB:
	incbin "data/rom/bank_040000_07ffff.bin",$005EAB,$000207

Bank040000_LocalTableTargetedPayloadRecord_0460B2:
	incbin "data/rom/bank_040000_07ffff.bin",$0060B2,$0001C2

Bank040000_LocalTableTargetedPayloadRecord_046274:
	incbin "data/rom/bank_040000_07ffff.bin",$006274,$000133

Bank040000_LocalTableTargetedPayloadRecord_0463A7:
	incbin "data/rom/bank_040000_07ffff.bin",$0063A7,$0001FE

Bank040000_LocalTableTargetedPayloadRecord_0465A5:
	incbin "data/rom/bank_040000_07ffff.bin",$0065A5,$000143

Bank040000_LocalTableTargetedPayloadRecord_0466E8:
	incbin "data/rom/bank_040000_07ffff.bin",$0066E8,$000135

Bank040000_LocalTableTargetedPayloadRecord_04681D:
	incbin "data/rom/bank_040000_07ffff.bin",$00681D,$00010E

Bank040000_LocalTableTargetedPayloadRecord_04692B:
	incbin "data/rom/bank_040000_07ffff.bin",$00692B,$00016A

Bank040000_LocalTableTargetedPayloadRecord_046A95:
	incbin "data/rom/bank_040000_07ffff.bin",$006A95,$000124

Bank040000_LocalTableTargetedPayloadRecord_046BB9:
	incbin "data/rom/bank_040000_07ffff.bin",$006BB9,$000193

Bank040000_LocalTableTargetedPayloadRecord_046D4C:
	incbin "data/rom/bank_040000_07ffff.bin",$006D4C,$000164

Bank040000_LocalTableTargetedPayloadRecord_046EB0:
	incbin "data/rom/bank_040000_07ffff.bin",$006EB0,$00022E

Bank040000_LocalTableTargetedPayloadRecord_0470DE:
	incbin "data/rom/bank_040000_07ffff.bin",$0070DE,$00026D

Bank040000_LocalTableTargetedPayloadRecord_04734B:
	incbin "data/rom/bank_040000_07ffff.bin",$00734B,$0001D1

Bank040000_LocalTableTargetedPayloadRecord_04751C:
	incbin "data/rom/bank_040000_07ffff.bin",$00751C,$0001B2

Bank040000_LocalTableTargetedPayloadRecord_0476CE:
	incbin "data/rom/bank_040000_07ffff.bin",$0076CE,$00010E

Bank040000_LocalTableTargetedPayloadRecord_0477DC:
	incbin "data/rom/bank_040000_07ffff.bin",$0077DC,$000114

Bank040000_LocalTableTargetedPayloadRecord_0478F0:
	incbin "data/rom/bank_040000_07ffff.bin",$0078F0,$000123

Bank040000_LocalTableTargetedPayloadRecord_047A13:
	incbin "data/rom/bank_040000_07ffff.bin",$007A13,$000297

Bank040000_LocalTableTargetedPayloadRecord_047CAA:
	incbin "data/rom/bank_040000_07ffff.bin",$007CAA,$0001E4

Bank040000_LocalTableTargetedPayloadRecord_047E8E:
	incbin "data/rom/bank_040000_07ffff.bin",$007E8E,$0001F2

Bank040000_LocalTableTargetedPayloadRecord_048080:
	incbin "data/rom/bank_040000_07ffff.bin",$008080,$00014B

Bank040000_LocalTableTargetedPayloadRecord_0481CB:
	incbin "data/rom/bank_040000_07ffff.bin",$0081CB,$00010F

Bank040000_LocalTableTargetedPayloadRecord_0482DA:
	incbin "data/rom/bank_040000_07ffff.bin",$0082DA,$0001D8

Bank040000_LocalTableTargetedPayloadRecord_0484B2:
	incbin "data/rom/bank_040000_07ffff.bin",$0084B2,$0001D0

Bank040000_LocalTableTargetedPayloadRecord_048682:
	incbin "data/rom/bank_040000_07ffff.bin",$008682,$0001CB

Bank040000_LocalTableTargetedPayloadRecord_04884D:
	incbin "data/rom/bank_040000_07ffff.bin",$00884D,$0001BD

Bank040000_LocalTableTargetedPayloadRecord_048A0A:
	incbin "data/rom/bank_040000_07ffff.bin",$008A0A,$0001AC

Bank040000_LocalTableTargetedPayloadRecord_048BB6:
	incbin "data/rom/bank_040000_07ffff.bin",$008BB6,$000235

Bank040000_LocalTableTargetedPayloadRecord_048DEB:
	incbin "data/rom/bank_040000_07ffff.bin",$008DEB,$0001A7

Bank040000_LocalTableTargetedPayloadRecord_048F92:
	incbin "data/rom/bank_040000_07ffff.bin",$008F92,$000174

Bank040000_LocalTableTargetedPayloadRecord_049106:
	incbin "data/rom/bank_040000_07ffff.bin",$009106,$000183

Bank040000_LocalTableTargetedPayloadRecord_049289:
	incbin "data/rom/bank_040000_07ffff.bin",$009289,$0001AD

Bank040000_LocalTableTargetedPayloadRecord_049436:
	incbin "data/rom/bank_040000_07ffff.bin",$009436,$0001D8

Bank040000_LocalTableTargetedPayloadRecord_04960E:
	incbin "data/rom/bank_040000_07ffff.bin",$00960E,$000165

Bank040000_LocalTableTargetedPayloadRecord_049773:
	incbin "data/rom/bank_040000_07ffff.bin",$009773,$0000D0

Bank040000_LocalTableTargetedPayloadRecord_049843:
	incbin "data/rom/bank_040000_07ffff.bin",$009843,$000159

Bank040000_LocalTableTargetedPayloadRecord_04999C:
	incbin "data/rom/bank_040000_07ffff.bin",$00999C,$0000CF

Bank040000_LocalTableTargetedPayloadRecord_049A6B:
	incbin "data/rom/bank_040000_07ffff.bin",$009A6B,$00026C

Bank040000_LocalTableTargetedPayloadRecord_049CD7:
	incbin "data/rom/bank_040000_07ffff.bin",$009CD7,$00025A

Bank040000_LocalTableTargetedPayloadRecord_049F31:
	incbin "data/rom/bank_040000_07ffff.bin",$009F31,$000223

Bank040000_LocalTableTargetedPayloadRecord_04A154:
	incbin "data/rom/bank_040000_07ffff.bin",$00A154,$00025D

Bank040000_LocalTableTargetedPayloadRecord_04A3B1:
	incbin "data/rom/bank_040000_07ffff.bin",$00A3B1,$0000FF

Bank040000_LocalTableTargetedPayloadRecord_04A4B0:
	incbin "data/rom/bank_040000_07ffff.bin",$00A4B0,$00025F
