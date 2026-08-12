; ======================================================================
; sound_constants.asm
; Z80 sound driver interface for Wonder Boy in Monster World (Genesis)
; The Z80 driver lives at ROM $98000 and is uploaded to Z80 RAM $A0000.
; ======================================================================

; --- Z80 mailbox (68K -> Z80 command channel) --------------------------
; SendZ80Command (src/core.asm $364) writes command byte D0 to the mailbox
; ring slot at Z80_RAM + $1C30 + (($1C2E + $1C2F) & $F). The driver
; increments the sequence counter $1C2F so commands round-robin through
; 16 slots. The busy byte at $1C00 must be 0 before sending.
Z80_MailboxBase      = $00A01C30   ; mailbox ring base (Z80 RAM $1C30)
Z80_MailboxBusy      = $00001C00   ; busy flag offset within Z80 RAM
Z80_MailboxIdxBase   = $00001C2E   ; command index base offset
Z80_MailboxSeq       = $00001C2F   ; command sequence counter offset
Z80_MailboxSlots     = $00000010   ; ring size (16 slots)

; --- Sound driver entry points -----------------------------------------
; Commands are sent via:  moveq #<cmd>, D0 / jsr $366.w  (entry keeps D0)
; The exact command-ID meanings are decoded from the Z80 driver in
; src/z80_driver.asm (work area $1B80+, sequencer $1C03+, FM $1C80+).
