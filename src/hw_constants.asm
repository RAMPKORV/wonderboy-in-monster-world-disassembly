; ======================================================================
; hw_constants.asm
; Sega Mega Drive / Genesis hardware register addresses and constants.
; Valid for all cartridge games on the 68000 side.
; ======================================================================

; --- VDP (Video Display Processor) --------------------------------------
VDP_data_port        = $C00000
VDP_control_port     = $C00004

; --- PSG (Programmable Sound Generator) ---------------------------------
PSG_data_port        = $C00011

; --- TMSS (Trademark Security System) -----------------------------------
; Write the long "SEGA" to this register before touching the VDP.
TMSS_register        = $A14000

; --- Z80 (sound coprocessor) --------------------------------------------
Z80_bus_request      = $A11100
Z80_reset            = $A11200
Z80_RAM_start        = $A00000   ; 8KB Z80 work RAM
Z80_YM2612_port_A    = $A04000   ; YM2612 address port (ch 1-3)
Z80_YM2612_port_B    = $A04002   ; YM2612 address port (ch 4-6)

; --- YM2612 (FM synthesis) ----------------------------------------------
YM2612_addr_1        = $A04000
YM2612_data_1        = $A04001
YM2612_addr_2        = $A04002
YM2612_data_2        = $A04003

; --- I/O ports ----------------------------------------------------------
IO_version_region    = $A10001   ; bit0-1: territory (0=Japan,1=US,2=Europe)
IO_data_port_1       = $A10003   ; Controller 1 data
IO_data_port_2       = $A10005   ; Controller 2 data
IO_ctrl_port_1       = $A10009   ; Controller 1 control
IO_ctrl_port_2       = $A1000B   ; Controller 2 control
IO_bus_req           = $A1000C   ; (optionally) I/O bus request

; --- Controller bit definitions (read from IO_data_port_N) ---------------
; Standard 3-button pad, active-low.
PAD_BIT_UP       = $1
PAD_BIT_DOWN     = $2
PAD_BIT_LEFT     = $4
PAD_BIT_RIGHT    = $8
PAD_BIT_B        = $10
PAD_BIT_C        = $20
PAD_BIT_A        = $40
PAD_BIT_START    = $80

; --- VDP register writes (control port) ----------------------------------
; Write register value as:  $8 << 8 | register_number (i.e. $8000|reg)
; e.g. MOVE.W #$8004, VDP_control_port sets reg 0 to $04 (HBlank ON).
VDP_REG0_HBLANK    = $8000
VDP_REG1_DISPLAY   = $8100
VDP_REG2_PLANEA    = $8200   ; + planA addr >> 10
VDP_REG3_WINDOW    = $8300
VDP_REG4_PLANEB    = $8400   ; + planB addr >> 10
VDP_REG5_SPRITE    = $8500   ; + sprite table addr >> 9
VDP_REG6_SPRITEDIM = $8600
VDP_REG7_BGCOLOR   = $8700
VDP_REG10_HINT     = $8A00
VDP_REG11_EXTINT   = $8B00
VDP_REG12_MODE     = $8C00
VDP_REG13_HSCROLL  = $8D00
VDP_REG15_AUTOINC  = $8F00
VDP_REG16_PLANESZ  = $9000
VDP_REG17_WINDOWH  = $9100
VDP_REG18_WINDOWV  = $9200
VDP_REG19_DMALEN_L = $9300
VDP_REG20_DMALEN_H = $9400
VDP_REG21_DMASRC_L = $9500
VDP_REG22_DMASRC_M = $9600
VDP_REG23_DMASRC_H = $9700

; --- VDP command word bits -----------------------------------------------
VDP_CMD_VRAM_WRITE  = $40000000   ; write to VRAM
VDP_CMD_VRAM_READ   = $00000000
VDP_CMD_CRAM_WRITE  = $C0000000   ; write to CRAM
VDP_CMD_VSRAM_WRITE = $40000010
VDP_CMD_DMA_VRAM    = $40000080
VDP_CMD_DMA_CRAM    = $C0000080
VDP_CMD_DMA_VSRAM   = $40000090

; --- Plane base addresses (typical) --------------------------------------
PLANEA_TILEMAP      = $C000   ; plan A name table (VRAM)
PLANEB_TILEMAP      = $E000   ; plan B name table
SPRITE_TABLE        = $D000   ; sprite attribute table
