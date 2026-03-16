ReservedVectorTrap         equ $00000006
ResetEntry                equ $00000200
AddressErrorHandler       equ $000049F8
BusErrorHandler           equ $000049FA
DefaultExceptionHandlerA  equ $000049FE
DefaultExceptionHandlerB  equ $00004A02

StartOfRom:
VectorInitialStackPointer:
	dc.l SystemStackTop
VectorReset:
	dc.l ResetEntry
VectorBusError:
	dc.l BusErrorHandler
VectorAddressError:
	dc.l AddressErrorHandler
	dc.l DefaultExceptionHandlerA
	dc.l DefaultExceptionHandlerA
	dc.l DefaultExceptionHandlerA
	dc.l DefaultExceptionHandlerA
	dc.l DefaultExceptionHandlerA
	dc.l DefaultExceptionHandlerA
	dc.l DefaultExceptionHandlerA
	dc.l DefaultExceptionHandlerA
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l DefaultExceptionHandlerA
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l DefaultExceptionHandlerA
	dc.l DefaultInterruptHandler
	dc.l DefaultInterruptHandler
	dc.l DefaultInterruptHandler
	dc.l DefaultInterruptHandler
	dc.l DefaultInterruptHandler
	dc.l VBlankHandler
	dc.l DefaultInterruptHandler
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l DefaultExceptionHandlerB
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap
	dc.l ReservedVectorTrap

RomHeader:
	dc.b "SEGA MEGA DRIVE "
	dc.b "(C)SEGA 1990.JAN"
	dc.b "Wonder Boy V Monster World III                  "
	dc.b "WONDER BOY in Monster world                     "
	dc.b "GM G-4060  -00"
HeaderChecksum:
	dc.w $9D79
	dc.b "J               "
	dc.l RomStart
	dc.l RomEndInclusive
	dc.l WorkRamStart
	dc.l WorkRamEnd
	dc.b $52,$41,$E8,$40
	dc.l $00200001
	dc.l $00200001
	dc.b "            "
	dc.b "                                        "
	dc.b "UE              "
