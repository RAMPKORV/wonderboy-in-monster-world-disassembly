; ROM range: 0x0A1411-0x0A1D3E
; This long regular run is no longer hidden behind one coarse incbin. Every record in
; this window ends with $FF, and every pre-terminator payload length remains a multiple
; of 5 bytes, so the source now exposes each stable record start directly in ROM order.
; The tuple meaning is still unresolved, so keep the labels structural.

Bank080000_FFTerminatedFiveByteTupleRecord_0A1411:
	dc.b	$01,$00,$19,$10,$F0
	dc.b	$04,$00,$17,$00,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A141C:
	dc.b	$01,$18,$06,$08,$00
	dc.b	$01,$08,$06,$08,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1427:
	dc.b	$01,$18,$08,$08,$00
	dc.b	$01,$08,$08,$08,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1432:
	dc.b	$01,$18,$0A,$08,$00
	dc.b	$01,$08,$0A,$08,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A143D:
	dc.b	$04,$18,$0E,$F8,$08
	dc.b	$01,$18,$0C,$08,$FE
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1448:
	dc.b	$04,$18,$12,$F8,$08
	dc.b	$01,$18,$10,$08,$FD
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1453:
	dc.b	$04,$18,$16,$F9,$08
	dc.b	$01,$18,$14,$08,$F9
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A145E:
	dc.b	$04,$18,$00,$00,$08
	dc.b	$04,$10,$00,$F0,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1469:
	dc.b	$04,$18,$02,$00,$08
	dc.b	$04,$10,$02,$F0,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1474:
	dc.b	$04,$18,$04,$00,$08
	dc.b	$04,$10,$04,$F0,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A147F:
	dc.b	$04,$10,$0E,$F8,$08
	dc.b	$01,$10,$0C,$F0,$FE
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A148A:
	dc.b	$04,$10,$12,$F8,$08
	dc.b	$01,$10,$10,$F0,$FD
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1495:
	dc.b	$04,$10,$16,$F7,$08
	dc.b	$01,$10,$14,$F0,$F9
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A14A0:
	dc.b	$01,$10,$06,$F0,$00
	dc.b	$01,$00,$06,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A14AB:
	dc.b	$01,$10,$08,$F0,$00
	dc.b	$01,$00,$08,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A14B6:
	dc.b	$01,$10,$0A,$F0,$00
	dc.b	$01,$00,$0A,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A14C1:
	dc.b	$04,$00,$0E,$F8,$F0
	dc.b	$01,$00,$0C,$F0,$F2
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A14CC:
	dc.b	$04,$00,$12,$F8,$F0
	dc.b	$01,$00,$10,$F0,$F3
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A14D7:
	dc.b	$04,$00,$16,$F7,$F0
	dc.b	$01,$00,$14,$F0,$F7
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A14E2:
	dc.b	$04,$08,$00,$00,$F0
	dc.b	$04,$00,$00,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A14ED:
	dc.b	$04,$08,$02,$00,$F0
	dc.b	$04,$00,$02,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A14F8:
	dc.b	$04,$08,$04,$00,$F0
	dc.b	$04,$00,$04,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1503:
	dc.b	$04,$08,$0E,$F8,$F0
	dc.b	$01,$08,$0C,$08,$F2
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A150E:
	dc.b	$04,$08,$12,$F8,$F0
	dc.b	$01,$08,$10,$08,$F3
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1519:
	dc.b	$04,$08,$16,$F9,$F0
	dc.b	$01,$08,$14,$08,$F7
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1524:
	dc.b	$0F,$60,$04,$F0,$F4
	dc.b	$0C,$60,$00,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A152F:
	dc.b	$0F,$60,$18,$F0,$F4
	dc.b	$0C,$60,$14,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A153A:
	dc.b	$0F,$60,$2C,$F0,$F4
	dc.b	$0C,$60,$28,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1545:
	dc.b	$0C,$60,$3C,$F0,$EC
	dc.b	$0F,$60,$40,$F0,$F4
	dc.b	$0C,$60,$3C,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1555:
	dc.b	$01,$60,$64,$10,$FC
	dc.b	$0F,$60,$54,$F0,$F4
	dc.b	$0C,$60,$50,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1565:
	dc.b	$0F,$60,$6A,$F0,$F4
	dc.b	$0C,$60,$66,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1570:
	dc.b	$0F,$60,$7E,$F0,$F4
	dc.b	$0C,$60,$7A,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A157B:
	dc.b	$05,$60,$00,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1581:
	dc.b	$05,$60,$04,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1587:
	dc.b	$05,$60,$08,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A158D:
	dc.b	$05,$60,$0C,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1593:
	dc.b	$0C,$60,$10,$F0,$0C
	dc.b	$0F,$60,$00,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A159E:
	dc.b	$08,$60,$24,$F0,$0C
	dc.b	$0F,$60,$14,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A15A9:
	dc.b	$0F,$60,$27,$F0,$EC
	dc.b	$0C,$60,$38,$F0,$0C
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A15B4:
	dc.b	$0C,$60,$4C,$F0,$0C
	dc.b	$0F,$60,$3C,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A15BF:
	dc.b	$06,$60,$64,$10,$EC
	dc.b	$0C,$60,$60,$F0,$0C
	dc.b	$0F,$60,$50,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A15CF:
	dc.b	$05,$60,$7E,$10,$04
	dc.b	$0C,$60,$7A,$F0,$0C
	dc.b	$0F,$60,$6A,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A15DF:
	dc.b	$0C,$60,$92,$F0,$0C
	dc.b	$0F,$60,$82,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A15EA:
	dc.b	$0C,$60,$A6,$F0,$0C
	dc.b	$0F,$60,$96,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A15F5:
	dc.b	$0E,$60,$00,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A15FB:
	dc.b	$0E,$60,$0C,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1601:
	dc.b	$0E,$60,$18,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1607:
	dc.b	$0E,$60,$24,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A160D:
	dc.b	$0E,$60,$30,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1613:
	dc.b	$05,$60,$3C,$F0,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1619:
	dc.b	$05,$60,$40,$F0,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A161F:
	dc.b	$0E,$60,$44,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1625:
	dc.b	$0E,$60,$50,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A162B:
	dc.b	$0F,$60,$30,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1631:
	dc.b	$0B,$60,$40,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1637:
	dc.b	$0B,$60,$4C,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A163D:
	dc.b	$0F,$60,$60,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1643:
	dc.b	$0F,$60,$70,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1649:
	dc.b	$0F,$60,$00,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A164F:
	dc.b	$0F,$60,$10,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1655:
	dc.b	$0F,$60,$20,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A165B:
	dc.b	$0F,$60,$30,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1661:
	dc.b	$0B,$00,$00,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1667:
	dc.b	$0B,$00,$0C,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A166D:
	dc.b	$0B,$00,$18,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1673:
	dc.b	$0B,$00,$24,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1679:
	dc.b	$0B,$00,$30,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A167F:
	dc.b	$0B,$00,$3C,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1685:
	dc.b	$05,$60,$3C,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A168B:
	dc.b	$05,$60,$40,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1691:
	dc.b	$01,$60,$44,$FC,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1697:
	dc.b	$05,$60,$46,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A169D:
	dc.b	$0F,$60,$30,$00,$00
	dc.b	$0F,$60,$20,$E0,$00
	dc.b	$0F,$60,$10,$00,$E0
	dc.b	$0F,$60,$00,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A16B2:
	dc.b	$0F,$60,$70,$00,$00
	dc.b	$0F,$60,$60,$E0,$00
	dc.b	$0F,$60,$50,$00,$E0
	dc.b	$0F,$60,$40,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A16C7:
	dc.b	$0F,$60,$B0,$00,$00
	dc.b	$0F,$60,$A0,$E0,$00
	dc.b	$0F,$60,$90,$00,$E0
	dc.b	$0F,$60,$80,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A16DC:
	dc.b	$0F,$60,$F0,$00,$00
	dc.b	$0F,$60,$E0,$E0,$00
	dc.b	$0F,$60,$D0,$00,$E0
	dc.b	$0F,$60,$C0,$E0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A16F1:
	dc.b	$0A,$60,$36,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A16F7:
	dc.b	$0A,$60,$3F,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A16FD:
	dc.b	$0E,$60,$1B,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1703:
	dc.b	$0A,$60,$27,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1709:
	dc.b	$0B,$42,$F4,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A170F:
	dc.b	$06,$20,$80,$F8,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1715:
	dc.b	$09,$20,$86,$F4,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A171B:
	dc.b	$06,$38,$80,$F8,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1721:
	dc.b	$09,$38,$86,$F4,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1727:
	dc.b	$05,$00,$48,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A172D:
	dc.b	$02,$00,$03,$FC,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1733:
	dc.b	$08,$00,$00,$F4,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1739:
	dc.b	$09,$00,$06,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A173F:
	dc.b	$0A,$00,$1A,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1745:
	dc.b	$04,$00,$29,$F8,$F4
	dc.b	$0A,$00,$1A,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1750:
	dc.b	$09,$00,$06,$F4,$00
	dc.b	$09,$00,$00,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A175B:
	dc.b	$09,$00,$0C,$F4,$00
	dc.b	$09,$00,$00,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1766:
	dc.b	$09,$00,$12,$F4,$00
	dc.b	$09,$00,$00,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1771:
	dc.b	$04,$00,$18,$FC,$F8
	dc.b	$09,$00,$0C,$F4,$00
	dc.b	$09,$00,$00,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1781:
	dc.b	$0A,$00,$2B,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1787:
	dc.b	$04,$00,$36,$F8,$F0
	dc.b	$0A,$00,$2B,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1792:
	dc.b	$04,$00,$34,$F8,$F0
	dc.b	$0A,$00,$2B,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A179D:
	dc.b	$0B,$00,$7A,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A17A3:
	dc.b	$04,$00,$8E,$FC,$F4
	dc.b	$0B,$00,$7A,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A17AE:
	dc.b	$04,$00,$8C,$F8,$F4
	dc.b	$0B,$00,$7A,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A17B9:
	dc.b	$09,$00,$94,$F5,$F8
	dc.b	$04,$08,$92,$00,$08
	dc.b	$04,$00,$92,$F1,$08
	dc.b	$04,$08,$90,$00,$F0
	dc.b	$04,$00,$90,$F1,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A17D3:
	dc.b	$0A,$00,$38,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A17D9:
	dc.b	$00,$00,$48,$00,$F4
	dc.b	$0A,$00,$38,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A17E4:
	dc.b	$04,$00,$47,$F8,$F4
	dc.b	$0A,$00,$38,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A17EF:
	dc.b	$09,$00,$86,$F4,$FC
	dc.b	$08,$00,$63,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A17FA:
	dc.b	$04,$00,$78,$FC,$FC
	dc.b	$09,$00,$86,$F4,$FC
	dc.b	$08,$00,$63,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A180A:
	dc.b	$09,$00,$66,$F4,$FC
	dc.b	$08,$00,$63,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1815:
	dc.b	$09,$00,$6C,$F4,$FC
	dc.b	$08,$00,$63,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1820:
	dc.b	$09,$00,$72,$F4,$FC
	dc.b	$08,$00,$63,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A182B:
	dc.b	$0A,$00,$B3,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1831:
	dc.b	$05,$42,$F0,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1837:
	dc.b	$05,$04,$00,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A183D:
	dc.b	$0D,$0A,$F8,$00,$F8
	dc.b	$0D,$02,$F8,$E0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1848:
	dc.b	$05,$02,$F0,$06,$F8
	dc.b	$05,$02,$F0,$F0,$F8
	dc.b	$09,$0A,$E0,$00,$F8
	dc.b	$09,$02,$E0,$E8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A185D:
	dc.b	$05,$02,$EB,$06,$F8
	dc.b	$05,$02,$E7,$F0,$F8
	dc.b	$09,$0A,$E0,$00,$F8
	dc.b	$09,$02,$E0,$E8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1872:
	dc.b	$05,$02,$E7,$06,$F8
	dc.b	$05,$02,$EB,$F0,$F8
	dc.b	$09,$0A,$E0,$00,$F8
	dc.b	$09,$02,$E0,$E8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1887:
	dc.b	$0C,$40,$04,$00,$FC
	dc.b	$0C,$40,$00,$E0,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1892:
	dc.b	$0C,$40,$0C,$00,$FC
	dc.b	$0C,$40,$08,$E0,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A189D:
	dc.b	$0C,$40,$14,$00,$FC
	dc.b	$0C,$40,$10,$E0,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A18A8:
	dc.b	$05,$63,$D0,$1A,$FB
	dc.b	$0D,$63,$C8,$FA,$FB
	dc.b	$0D,$63,$C0,$DA,$FB
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A18B8:
	dc.b	$05,$63,$E4,$1A,$FB
	dc.b	$0D,$63,$DC,$FA,$FB
	dc.b	$0D,$63,$D4,$DA,$FB
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A18C8:
	dc.b	$01,$64,$16,$4D,$FB
	dc.b	$0D,$64,$0C,$2D,$FB
	dc.b	$0D,$64,$04,$0D,$FB
	dc.b	$0D,$63,$F8,$ED,$FB
	dc.b	$0D,$63,$F0,$CD,$FB
	dc.b	$0D,$63,$E8,$AD,$FB
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A18E7:
	dc.b	$05,$64,$00,$FB,$F9
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A18ED:
	dc.b	$04,$00,$00,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A18F3:
	dc.b	$0A,$00,$02,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A18F9:
	dc.b	$0E,$00,$0B,$F0,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A18FF:
	dc.b	$05,$00,$1C,$F8,$E4
	dc.b	$00,$00,$1B,$F4,$F0
	dc.b	$0C,$00,$17,$F0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A190F:
	dc.b	$04,$0F,$96,$00,$F8
	dc.b	$04,$07,$96,$F0,$F8
	dc.b	$05,$0F,$86,$00,$00
	dc.b	$05,$07,$86,$F0,$00
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1924:
	dc.b	$05,$0F,$8A,$00,$F0
	dc.b	$05,$07,$8A,$F0,$F0
	dc.b	$05,$0F,$86,$00,$00
	dc.b	$05,$07,$86,$F0,$00
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1939:
	dc.b	$05,$42,$EC,$00,$F8
	dc.b	$05,$42,$E0,$F0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1944:
	dc.b	$0D,$42,$E8,$00,$F8
	dc.b	$0D,$42,$E0,$E0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A194F:
	dc.b	$0D,$42,$E4,$00,$F8
	dc.b	$0D,$42,$E4,$E0,$F8
	dc.b	$05,$42,$EC,$20,$F8
	dc.b	$05,$42,$E0,$D0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1964:
	dc.b	$07,$44,$60,$18,$B8
	dc.b	$0F,$44,$50,$F8,$B8
	dc.b	$0F,$44,$40,$D8,$B8
	dc.b	$07,$44,$68,$F8,$D8
	dc.b	$05,$22,$E2,$00,$F8
	dc.b	$05,$22,$E2,$F0,$F8
	dc.b	$09,$22,$E2,$10,$F8
	dc.b	$09,$22,$E0,$D8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A198D:
	dc.b	$0B,$00,$21,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1993:
	dc.b	$04,$00,$2D,$F8,$F8
	dc.b	$0B,$00,$21,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A199E:
	dc.b	$0A,$00,$00,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A19A4:
	dc.b	$04,$00,$09,$F8,$F4
	dc.b	$0A,$00,$00,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A19AF:
	dc.b	$09,$00,$22,$F4,$02
	dc.b	$08,$00,$0F,$F4,$FA
	dc.b	$09,$00,$09,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A19BF:
	dc.b	$09,$00,$28,$F4,$02
	dc.b	$08,$00,$12,$F4,$FA
	dc.b	$09,$00,$09,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A19CF:
	dc.b	$09,$00,$2E,$F4,$02
	dc.b	$08,$00,$15,$F4,$FA
	dc.b	$09,$00,$09,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A19DF:
	dc.b	$04,$00,$1A,$FC,$F6
	dc.b	$09,$00,$28,$F4,$02
	dc.b	$08,$00,$12,$F4,$FA
	dc.b	$09,$00,$09,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A19F4:
	dc.b	$0A,$00,$16,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A19FA:
	dc.b	$04,$00,$1F,$F8,$F4
	dc.b	$0A,$00,$16,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1A05:
	dc.b	$09,$00,$8A,$F4,$02
	dc.b	$08,$00,$77,$F4,$FA
	dc.b	$09,$00,$71,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1A15:
	dc.b	$09,$00,$90,$F4,$02
	dc.b	$08,$00,$7A,$F4,$FA
	dc.b	$09,$00,$71,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1A25:
	dc.b	$09,$00,$96,$F4,$02
	dc.b	$08,$00,$7D,$F4,$FA
	dc.b	$09,$00,$71,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1A35:
	dc.b	$04,$00,$82,$FC,$F6
	dc.b	$09,$00,$90,$F4,$02
	dc.b	$08,$00,$7A,$F4,$FA
	dc.b	$09,$00,$71,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1A4A:
	dc.b	$0A,$00,$0B,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1A50:
	dc.b	$04,$00,$14,$F8,$F4
	dc.b	$0A,$00,$0B,$F4,$E8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1A5B:
	dc.b	$09,$00,$56,$F4,$02
	dc.b	$08,$00,$43,$F4,$FA
	dc.b	$09,$00,$3D,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1A6B:
	dc.b	$09,$00,$5C,$F4,$02
	dc.b	$08,$00,$46,$F4,$FA
	dc.b	$09,$00,$3D,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1A7B:
	dc.b	$09,$00,$62,$F4,$02
	dc.b	$08,$00,$49,$F4,$FA
	dc.b	$09,$00,$3D,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1A8B:
	dc.b	$04,$00,$4E,$FC,$F6
	dc.b	$09,$00,$5C,$F4,$02
	dc.b	$08,$00,$46,$F4,$FA
	dc.b	$09,$00,$3D,$F4,$EA
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1AA0:
	dc.b	$0E,$08,$2C,$F0,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1AA6:
	dc.b	$0A,$00,$38,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1AAC:
	dc.b	$09,$00,$24,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1AB2:
	dc.b	$04,$00,$2A,$F8,$F4
	dc.b	$09,$00,$24,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1ABD:
	dc.b	$04,$00,$12,$F8,$00
	dc.b	$05,$00,$04,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1AC8:
	dc.b	$04,$00,$14,$F8,$00
	dc.b	$05,$00,$08,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1AD3:
	dc.b	$04,$00,$16,$F8,$00
	dc.b	$05,$00,$0C,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1ADE:
	dc.b	$00,$00,$7F,$FD,$F8
	dc.b	$04,$00,$14,$F8,$00
	dc.b	$05,$00,$08,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1AEE:
	dc.b	$09,$00,$1C,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1AF4:
	dc.b	$04,$00,$22,$F8,$F4
	dc.b	$09,$00,$1C,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1AFF:
	dc.b	$04,$00,$1A,$F8,$00
	dc.b	$05,$00,$24,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B0A:
	dc.b	$04,$00,$1C,$F8,$00
	dc.b	$05,$00,$28,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B15:
	dc.b	$04,$00,$1E,$F8,$00
	dc.b	$05,$00,$2C,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B20:
	dc.b	$00,$00,$7C,$00,$F8
	dc.b	$04,$00,$1C,$F8,$00
	dc.b	$05,$00,$28,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B30:
	dc.b	$09,$00,$14,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B36:
	dc.b	$04,$00,$1A,$F8,$F4
	dc.b	$09,$00,$14,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B41:
	dc.b	$04,$00,$42,$F8,$04
	dc.b	$05,$00,$34,$F8,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B4C:
	dc.b	$04,$00,$44,$F8,$04
	dc.b	$05,$00,$38,$F8,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B57:
	dc.b	$04,$00,$46,$F8,$04
	dc.b	$05,$00,$3C,$F8,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B62:
	dc.b	$00,$00,$7D,$FE,$FA
	dc.b	$04,$00,$44,$F8,$04
	dc.b	$05,$00,$38,$F8,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B72:
	dc.b	$05,$00,$50,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B78:
	dc.b	$05,$00,$54,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B7E:
	dc.b	$05,$00,$58,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B84:
	dc.b	$05,$00,$5C,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B8A:
	dc.b	$00,$08,$7A,$00,$F8
	dc.b	$00,$00,$7A,$F8,$F8
	dc.b	$05,$00,$50,$F8,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1B9A:
	dc.b	$04,$00,$09,$FC,$FC
	dc.b	$0A,$00,$00,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1BA5:
	dc.b	$0A,$00,$0B,$F4,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1BAB:
	dc.b	$08,$00,$12,$F5,$04
	dc.b	$09,$00,$00,$F5,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1BB6:
	dc.b	$08,$00,$12,$F6,$04
	dc.b	$09,$00,$06,$F6,$F4
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1BC1:
	dc.b	$00,$02,$DB,$FC,$FC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1BC7:
	dc.b	$0F,$60,$40,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1BCD:
	dc.b	$0F,$60,$50,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1BD3:
	dc.b	$0F,$00,$04,$F0,$F4
	dc.b	$0C,$00,$00,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1BDE:
	dc.b	$0F,$00,$18,$F0,$F4
	dc.b	$0C,$00,$14,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1BE9:
	dc.b	$0F,$00,$28,$F0,$F4
	dc.b	$0C,$00,$00,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1BF4:
	dc.b	$0F,$00,$38,$F0,$F4
	dc.b	$0C,$00,$00,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1BFF:
	dc.b	$05,$00,$59,$0A,$F4
	dc.b	$0D,$00,$51,$F2,$04
	dc.b	$0A,$00,$48,$F2,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1C0F:
	dc.b	$01,$00,$6E,$12,$04
	dc.b	$0D,$00,$66,$F2,$04
	dc.b	$0A,$00,$5D,$F2,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1C1F:
	dc.b	$0C,$00,$80,$F0,$0C
	dc.b	$0F,$00,$70,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1C2A:
	dc.b	$0C,$00,$94,$F0,$0C
	dc.b	$0F,$00,$84,$F0,$EC
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1C35:
	dc.b	$0D,$03,$A4,$F0,$F8
	dc.b	$0D,$03,$A4,$F0,$08
	dc.b	$0D,$03,$A4,$F0,$E8
	dc.b	$0C,$03,$AC,$F0,$18
	dc.b	$0C,$03,$A0,$F0,$E0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1C4F:
	dc.b	$05,$00,$13,$EE,$00
	dc.b	$05,$00,$0F,$E6,$F0
	dc.b	$09,$00,$06,$F4,$00
	dc.b	$09,$00,$00,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1C64:
	dc.b	$00,$00,$0C,$FC,$F8
	dc.b	$05,$00,$13,$EE,$00
	dc.b	$05,$00,$0F,$E6,$F0
	dc.b	$09,$00,$06,$F4,$00
	dc.b	$09,$00,$00,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1C7E:
	dc.b	$0C,$40,$4D,$F0,$10
	dc.b	$0F,$40,$00,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1C89:
	dc.b	$0C,$40,$4D,$F0,$10
	dc.b	$09,$40,$20,$F3,$E0
	dc.b	$0F,$40,$10,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1C99:
	dc.b	$0C,$40,$4D,$F0,$10
	dc.b	$0A,$40,$36,$F8,$D8
	dc.b	$0F,$40,$26,$F0,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1CA9:
	dc.b	$00,$40,$4C,$08,$DA
	dc.b	$00,$40,$4B,$F8,$D8
	dc.b	$0E,$40,$3F,$F0,$00
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1CB9:
	dc.b	$0C,$40,$4D,$F0,$10
	dc.b	$0E,$40,$51,$F0,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1CC4:
	dc.b	$0C,$40,$4D,$F0,$10
	dc.b	$0D,$40,$60,$F0,$00
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1CCF:
	dc.b	$0C,$40,$4D,$F0,$10
	dc.b	$0D,$40,$68,$F0,$00
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1CDA:
	dc.b	$0C,$40,$4D,$F0,$10
	dc.b	$0C,$40,$70,$F0,$08
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1CE5:
	dc.b	$05,$02,$4B,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1CEB:
	dc.b	$05,$02,$47,$F8,$F8
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1CF1:
	dc.b	$09,$00,$45,$F4,$00
	dc.b	$0A,$00,$2F,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1CFC:
	dc.b	$09,$00,$4B,$F4,$00
	dc.b	$0A,$00,$2F,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D07:
	dc.b	$09,$00,$51,$F4,$00
	dc.b	$0A,$00,$2F,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D12:
	dc.b	$04,$00,$43,$FC,$F8
	dc.b	$09,$00,$4B,$F4,$00
	dc.b	$0A,$00,$2F,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D22:
	dc.b	$0A,$00,$69,$F4,$F8
	dc.b	$0A,$00,$57,$F4,$F0
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D2D:
	dc.b	$00,$02,$4F,$FD,$FD
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D33:
	dc.b	$00,$02,$50,$FE,$FE
	dc.b	$FF

Bank080000_FFTerminatedFiveByteTupleRecord_0A1D39:
	dc.b	$00,$02,$51,$FE,$FE
	dc.b	$FF
