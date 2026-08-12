; ======================================================================
; src/z80_driver.asm
; Z80 sound driver, uploaded to Z80 RAM $A000 by WriteZ80Driver.
; Bit-exact dc.b per ROM byte; Z80 disassembly annotated as comments
; on instruction starts (tools/z80dis.js). Covers $0098000-$0099A76.
; YM2612 ports: $4000=reg, $4001=data; DAC/sound select $6000.
; Work area: $1B80+ context/command, $1C03+ tempo/seq, $1C80+ FM chan,
; $1EC0+ channel state (10 x $20), $0404 note-frequency table.
; ======================================================================
Z80DriverReset:
	dc.b	$f3	; z$0000	DI
	dc.b	$ed	; z$0001	IM 1
	dc.b	$56	; z$0002
	dc.b	$c3	; z$0003	JP z003B
	dc.b	$3b	; z$0004
	dc.b	$00	; z$0005
Z80CopyBlock:
	dc.b	$77	; z$0006	LD (HL),A
	dc.b	$1a	; z$0007	LD A,(DE)
	dc.b	$72	; z$0008	LD (HL),D
	dc.b	$23	; z$0009	INC HL
	dc.b	$0b	; z$000A	DEC BC
	dc.b	$78	; z$000B	LD A,B
	dc.b	$b1	; z$000C	OR C
	dc.b	$20	; z$000D	JR NZ,z0008
	dc.b	$f9	; z$000E
	dc.b	$c9	; z$000F	RET
Z80Rst18Handler:
	dc.b	$df	; z$0010	RST $18
	dc.b	$df	; z$0011	RST $18
	dc.b	$df	; z$0012	RST $18
Z80Rst18Return:
	dc.b	$1c	; z$0013	INC E
	dc.b	$c9	; z$0014	RET
	dc.b	$ff	; z$0015	RST $38
	dc.b	$ff	; z$0016	RST $38
	dc.b	$ff	; z$0017	RST $38
Z80Rst38Stub:
	dc.b	$7b	; z$0018	LD A,E
	dc.b	$42	; z$0019	LD B,D
	dc.b	$cd	; z$001A	CALL z06CB
	dc.b	$cb	; z$001B
	dc.b	$06	; z$001C
	dc.b	$1c	; z$001D	INC E
	dc.b	$c9	; z$001E	RET
	dc.b	$ff	; z$001F	RST $38
Z80CmdStubs:
	dc.b	$e3	; z$0020	EX (SP),HL
	dc.b	$2b	; z$0021	DEC HL
	dc.b	$e3	; z$0022	EX (SP),HL
	dc.b	$c3	; z$0023	JP z0F8C
	dc.b	$8c	; z$0024
	dc.b	$0f	; z$0025
	dc.b	$ff	; z$0026	RST $38
	dc.b	$ff	; z$0027	RST $38
	dc.b	$e3	; z$0028	EX (SP),HL
	dc.b	$2b	; z$0029	DEC HL
	dc.b	$e3	; z$002A	EX (SP),HL
	dc.b	$c3	; z$002B	JP z0F8C
	dc.b	$8c	; z$002C
	dc.b	$0f	; z$002D
	dc.b	$ff	; z$002E	RST $38
	dc.b	$ff	; z$002F	RST $38
	dc.b	$e3	; z$0030	EX (SP),HL
	dc.b	$2b	; z$0031	DEC HL
	dc.b	$e3	; z$0032	EX (SP),HL
	dc.b	$c3	; z$0033	JP z0F8C
	dc.b	$8c	; z$0034
	dc.b	$0f	; z$0035
	dc.b	$ff	; z$0036	RST $38
	dc.b	$ff	; z$0037	RST $38
	dc.b	$00	; z$0038	NOP
	dc.b	$ed	; z$0039	RETI
	dc.b	$4d	; z$003A
Z80DriverInit:
	dc.b	$21	; z$003B	LD HL,$1B80
	dc.b	$80	; z$003C
	dc.b	$1b	; z$003D
	dc.b	$f9	; z$003E	LD SP,HL
	dc.b	$36	; z$003F	LD (HL),$FF
	dc.b	$ff	; z$0040
	dc.b	$23	; z$0041	INC HL
	dc.b	$01	; z$0042	LD BC,$00FF
	dc.b	$ff	; z$0043
	dc.b	$00	; z$0044
	dc.b	$16	; z$0045	LD D,$00
	dc.b	$00	; z$0046
	dc.b	$cf	; z$0047	RST $08
	dc.b	$01	; z$0048	LD BC,$0380
	dc.b	$80	; z$0049
	dc.b	$03	; z$004A
	dc.b	$15	; z$004B	DEC D
	dc.b	$cf	; z$004C	RST $08
	dc.b	$21	; z$004D	LD HL,$1C80
	dc.b	$80	; z$004E
	dc.b	$1c	; z$004F
	dc.b	$11	; z$0050	LD DE,$0040
	dc.b	$40	; z$0051
	dc.b	$00	; z$0052
	dc.b	$06	; z$0053	LD B,$09
	dc.b	$09	; z$0054
	dc.b	$72	; z$0055	LD (HL),D
	dc.b	$19	; z$0056	ADD HL,DE
	dc.b	$10	; z$0057	DJNZ z0055
	dc.b	$fc	; z$0058
	dc.b	$1e	; z$0059	LD E,$20
	dc.b	$20	; z$005A
	dc.b	$06	; z$005B	LD B,$0A
	dc.b	$0a	; z$005C
	dc.b	$72	; z$005D	LD (HL),D
	dc.b	$19	; z$005E	ADD HL,DE
	dc.b	$10	; z$005F	DJNZ z005D
	dc.b	$fc	; z$0060
	dc.b	$21	; z$0061	LD HL,$1ED1
	dc.b	$d1	; z$0062
	dc.b	$1e	; z$0063
	dc.b	$06	; z$0064	LD B,$0A
	dc.b	$0a	; z$0065
	dc.b	$72	; z$0066	LD (HL),D
	dc.b	$19	; z$0067	ADD HL,DE
	dc.b	$10	; z$0068	DJNZ z0066
	dc.b	$fc	; z$0069
	dc.b	$3a	; z$006A	LD A,($0001)
	dc.b	$01	; z$006B
	dc.b	$00	; z$006C
	dc.b	$32	; z$006D	LD ($6000),A
	dc.b	$00	; z$006E
	dc.b	$60	; z$006F
	dc.b	$2e	; z$0070	LD L,$90
	dc.b	$90	; z$0071
	dc.b	$06	; z$0072	LD B,$08
	dc.b	$08	; z$0073
	dc.b	$af	; z$0074	XOR A
	dc.b	$cb	; z$0075	RLC H
	dc.b	$25	; z$0076
	dc.b	$17	; z$0077	RLA
	dc.b	$32	; z$0078	LD ($6000),A
	dc.b	$00	; z$0079
	dc.b	$60	; z$007A
	dc.b	$10	; z$007B	DJNZ z0074
	dc.b	$f7	; z$007C
	dc.b	$0e	; z$007D	LD C,$00
	dc.b	$00	; z$007E
	dc.b	$06	; z$007F	LD B,$2B
	dc.b	$2b	; z$0080
	dc.b	$cd	; z$0081	CALL z06F7
	dc.b	$f7	; z$0082
	dc.b	$06	; z$0083
	dc.b	$0e	; z$0084	LD C,$ED
	dc.b	$ed	; z$0085
	dc.b	$06	; z$0086	LD B,$26
	dc.b	$26	; z$0087
	dc.b	$cd	; z$0088	CALL z06F7
	dc.b	$f7	; z$0089
	dc.b	$06	; z$008A
	dc.b	$3e	; z$008B	LD A,$2A
	dc.b	$2a	; z$008C
	dc.b	$32	; z$008D	LD ($1C23),A
	dc.b	$23	; z$008E
	dc.b	$1c	; z$008F
	dc.b	$4f	; z$0090	LD C,A
	dc.b	$06	; z$0091	LD B,$27
	dc.b	$27	; z$0092
	dc.b	$cd	; z$0093	CALL z06F7
	dc.b	$f7	; z$0094
	dc.b	$06	; z$0095
	dc.b	$21	; z$0096	LD HL,$7F11
	dc.b	$11	; z$0097
	dc.b	$7f	; z$0098
	dc.b	$36	; z$0099	LD (HL),$9F
	dc.b	$9f	; z$009A
	dc.b	$36	; z$009B	LD (HL),$BF
	dc.b	$bf	; z$009C
	dc.b	$36	; z$009D	LD (HL),$DF
	dc.b	$df	; z$009E
	dc.b	$36	; z$009F	LD (HL),$FF
	dc.b	$ff	; z$00A0
	dc.b	$cd	; z$00A1	CALL z00E3
	dc.b	$e3	; z$00A2
	dc.b	$00	; z$00A3
	dc.b	$cd	; z$00A4	CALL z013E
	dc.b	$3e	; z$00A5
	dc.b	$01	; z$00A6
	dc.b	$3e	; z$00A7	LD A,$01
	dc.b	$01	; z$00A8
	dc.b	$32	; z$00A9	LD ($1C2D),A
	dc.b	$2d	; z$00AA
	dc.b	$1c	; z$00AB
	dc.b	$af	; z$00AC	XOR A
	dc.b	$32	; z$00AD	LD ($1C00),A
	dc.b	$00	; z$00AE
	dc.b	$1c	; z$00AF
	dc.b	$af	; z$00B0	XOR A
	dc.b	$32	; z$00B1	LD ($1C06),A
	dc.b	$06	; z$00B2
	dc.b	$1c	; z$00B3
	dc.b	$3e	; z$00B4	LD A,$03
	dc.b	$03	; z$00B5
	dc.b	$32	; z$00B6	LD ($1C02),A
	dc.b	$02	; z$00B7
	dc.b	$1c	; z$00B8
	dc.b	$cd	; z$00B9	CALL z0110
	dc.b	$10	; z$00BA
	dc.b	$01	; z$00BB
	dc.b	$cd	; z$00BC	CALL z0155
	dc.b	$55	; z$00BD
	dc.b	$01	; z$00BE
	dc.b	$cd	; z$00BF	CALL z019C
	dc.b	$9c	; z$00C0
	dc.b	$01	; z$00C1
	dc.b	$2a	; z$00C2	LD HL,($1C16)
	dc.b	$16	; z$00C3
	dc.b	$1c	; z$00C4
	dc.b	$26	; z$00C5	LD H,$00
	dc.b	$00	; z$00C6
	dc.b	$ed	; z$00C7	LD DE,($1C14)
	dc.b	$5b	; z$00C8
	dc.b	$14	; z$00C9
	dc.b	$1c	; z$00CA
	dc.b	$19	; z$00CB	ADD HL,DE
	dc.b	$22	; z$00CC	LD ($1C16),HL
	dc.b	$16	; z$00CD
	dc.b	$1c	; z$00CE
	dc.b	$7c	; z$00CF	LD A,H
	dc.b	$21	; z$00D0	LD HL,$1C06
	dc.b	$06	; z$00D1
	dc.b	$1c	; z$00D2
	dc.b	$86	; z$00D3	ADD A,(HL)
	dc.b	$77	; z$00D4	LD (HL),A
	dc.b	$cd	; z$00D5	CALL z070B
	dc.b	$0b	; z$00D6
	dc.b	$07	; z$00D7
	dc.b	$3a	; z$00D8	LD A,($1C02)
	dc.b	$02	; z$00D9
	dc.b	$1c	; z$00DA
	dc.b	$3d	; z$00DB	DEC A
	dc.b	$20	; z$00DC	JR NZ,z00B6
	dc.b	$d8	; z$00DD
	dc.b	$cd	; z$00DE	CALL z0B7F
	dc.b	$7f	; z$00DF
	dc.b	$0b	; z$00E0
	dc.b	$18	; z$00E1	JR z00B0
	dc.b	$cd	; z$00E2
FMChannelSetup:
	dc.b	$0e	; z$00E3	LD C,$00
	dc.b	$00	; z$00E4
	dc.b	$16	; z$00E5	LD D,$90
	dc.b	$90	; z$00E6
	dc.b	$cd	; z$00E7	CALL z0100
	dc.b	$00	; z$00E8
	dc.b	$01	; z$00E9
	dc.b	$0d	; z$00EA	DEC C
	dc.b	$16	; z$00EB	LD D,$80
	dc.b	$80	; z$00EC
	dc.b	$cd	; z$00ED	CALL z0100
	dc.b	$00	; z$00EE
	dc.b	$01	; z$00EF
	dc.b	$06	; z$00F0	LD B,$28
	dc.b	$28	; z$00F1
	dc.b	$cd	; z$00F2	CALL z00F5
	dc.b	$f5	; z$00F3
	dc.b	$00	; z$00F4
FMRegWriteSeq:
	dc.b	$0c	; z$00F5	INC C
	dc.b	$1e	; z$00F6	LD E,$03
	dc.b	$03	; z$00F7
	dc.b	$cd	; z$00F8	CALL z06F7
	dc.b	$f7	; z$00F9
	dc.b	$06	; z$00FA
	dc.b	$0c	; z$00FB	INC C
	dc.b	$1d	; z$00FC	DEC E
	dc.b	$20	; z$00FD	JR NZ,z00F8
	dc.b	$f9	; z$00FE
	dc.b	$c9	; z$00FF	RET
YMSetMode:
	dc.b	$af	; z$0100	XOR A
	dc.b	$cd	; z$0101	CALL z0106
	dc.b	$06	; z$0102
	dc.b	$01	; z$0103
	dc.b	$3e	; z$0104	LD A,$02
	dc.b	$02	; z$0105
	dc.b	$32	; z$0106	LD ($1C10),A
	dc.b	$10	; z$0107
	dc.b	$1c	; z$0108
	dc.b	$1e	; z$0109	LD E,$00
	dc.b	$00	; z$010A
	dc.b	$d7	; z$010B	RST $10
	dc.b	$d7	; z$010C	RST $10
	dc.b	$d7	; z$010D	RST $10
	dc.b	$d7	; z$010E	RST $10
	dc.b	$c9	; z$010F	RET
SongSequencer:
	dc.b	$3a	; z$0110	LD A,($1B99)
	dc.b	$99	; z$0111
	dc.b	$1b	; z$0112
	dc.b	$b7	; z$0113	OR A
	dc.b	$c4	; z$0114	CALL NZ,z0F8C
	dc.b	$8c	; z$0115
	dc.b	$0f	; z$0116
	dc.b	$21	; z$0117	LD HL,$1C2D
	dc.b	$2d	; z$0118
	dc.b	$1c	; z$0119
	dc.b	$35	; z$011A	DEC (HL)
	dc.b	$c0	; z$011B	RET NZ
	dc.b	$36	; z$011C	LD (HL),$01
	dc.b	$01	; z$011D
	dc.b	$3a	; z$011E	LD A,($1C03)
	dc.b	$03	; z$011F
	dc.b	$1c	; z$0120
	dc.b	$e6	; z$0121	AND $02
	dc.b	$02	; z$0122
	dc.b	$28	; z$0123	JR Z,z0127
	dc.b	$02	; z$0124
	dc.b	$36	; z$0125	LD (HL),$04
	dc.b	$04	; z$0126
	dc.b	$3a	; z$0127	LD A,($4000)
	dc.b	$00	; z$0128
	dc.b	$40	; z$0129
	dc.b	$e6	; z$012A	AND $02
	dc.b	$02	; z$012B
	dc.b	$28	; z$012C	JR Z,z0110
	dc.b	$e2	; z$012D
	dc.b	$2a	; z$012E	LD HL,($1C04)
	dc.b	$04	; z$012F
	dc.b	$1c	; z$0130
	dc.b	$23	; z$0131	INC HL
	dc.b	$22	; z$0132	LD ($1C04),HL
	dc.b	$04	; z$0133
	dc.b	$1c	; z$0134
	dc.b	$3a	; z$0135	LD A,($1C23)
	dc.b	$23	; z$0136
	dc.b	$1c	; z$0137
	dc.b	$4f	; z$0138	LD C,A
	dc.b	$06	; z$0139	LD B,$27
	dc.b	$27	; z$013A
	dc.b	$c3	; z$013B	JP z06F7
	dc.b	$f7	; z$013C
	dc.b	$06	; z$013D
ResetSoundChannels:
	dc.b	$cd	; z$013E	CALL z0369
	dc.b	$69	; z$013F
	dc.b	$03	; z$0140
	dc.b	$21	; z$0141	LD HL,$1C81
	dc.b	$81	; z$0142
	dc.b	$1c	; z$0143
	dc.b	$11	; z$0144	LD DE,$0040
	dc.b	$40	; z$0145
	dc.b	$00	; z$0146
	dc.b	$06	; z$0147	LD B,$06
	dc.b	$06	; z$0148
	dc.b	$72	; z$0149	LD (HL),D
	dc.b	$19	; z$014A	ADD HL,DE
	dc.b	$10	; z$014B	DJNZ z0149
	dc.b	$fc	; z$014C
	dc.b	$06	; z$014D	LD B,$03
	dc.b	$03	; z$014E
	dc.b	$36	; z$014F	LD (HL),$02
	dc.b	$02	; z$0150
	dc.b	$19	; z$0151	ADD HL,DE
	dc.b	$10	; z$0152	DJNZ z014F
	dc.b	$fb	; z$0153
	dc.b	$c9	; z$0154	RET
ProcessNoteData:
	dc.b	$3a	; z$0155	LD A,($1C2A)
	dc.b	$2a	; z$0156
	dc.b	$1c	; z$0157
	dc.b	$b7	; z$0158	OR A
	dc.b	$28	; z$0159	JR Z,z0162
	dc.b	$07	; z$015A
	dc.b	$3a	; z$015B	LD A,($1C2B)
	dc.b	$2b	; z$015C
	dc.b	$1c	; z$015D
	dc.b	$32	; z$015E	LD ($1C0B),A
	dc.b	$0b	; z$015F
	dc.b	$1c	; z$0160
	dc.b	$c9	; z$0161	RET
	dc.b	$3a	; z$0162	LD A,($1C09)
	dc.b	$09	; z$0163
	dc.b	$1c	; z$0164
	dc.b	$b7	; z$0165	OR A
	dc.b	$c8	; z$0166	RET Z
	dc.b	$2a	; z$0167	LD HL,($1C0A)
	dc.b	$0a	; z$0168
	dc.b	$1c	; z$0169
	dc.b	$ed	; z$016A	LD DE,($1C0C)
	dc.b	$5b	; z$016B
	dc.b	$0c	; z$016C
	dc.b	$1c	; z$016D
	dc.b	$19	; z$016E	ADD HL,DE
	dc.b	$cb	; z$016F	RRC A
	dc.b	$7c	; z$0170
	dc.b	$28	; z$0171	JR Z,z0180
	dc.b	$0d	; z$0172
	dc.b	$cb	; z$0173	RRC A
	dc.b	$7a	; z$0174
	dc.b	$cc	; z$0175	CALL Z,z0321
	dc.b	$21	; z$0176
	dc.b	$03	; z$0177
	dc.b	$af	; z$0178	XOR A
	dc.b	$32	; z$0179	LD ($1C09),A
	dc.b	$09	; z$017A
	dc.b	$1c	; z$017B
	dc.b	$32	; z$017C	LD ($1C0B),A
	dc.b	$0b	; z$017D
	dc.b	$1c	; z$017E
	dc.b	$c9	; z$017F	RET
	dc.b	$22	; z$0180	LD ($1C0A),HL
	dc.b	$0a	; z$0181
	dc.b	$1c	; z$0182
	dc.b	$21	; z$0183	LD HL,$1C09
	dc.b	$09	; z$0184
	dc.b	$1c	; z$0185
	dc.b	$35	; z$0186	DEC (HL)
	dc.b	$c0	; z$0187	RET NZ
	dc.b	$ed	; z$0188	LD DE,($1C0E)
	dc.b	$5b	; z$0189
	dc.b	$0e	; z$018A
	dc.b	$1c	; z$018B
	dc.b	$1a	; z$018C	LD A,(DE)
	dc.b	$13	; z$018D	INC DE
	dc.b	$77	; z$018E	LD (HL),A
	dc.b	$eb	; z$018F	EX DE,HL
	dc.b	$5e	; z$0190	LD E,(HL)
	dc.b	$23	; z$0191	INC HL
	dc.b	$56	; z$0192	LD D,(HL)
	dc.b	$23	; z$0193	INC HL
	dc.b	$22	; z$0194	LD ($1C0E),HL
	dc.b	$0e	; z$0195
	dc.b	$1c	; z$0196
	dc.b	$ed	; z$0197	LD ($1C0C),DE
	dc.b	$53	; z$0198
	dc.b	$0c	; z$0199
	dc.b	$1c	; z$019A
	dc.b	$c9	; z$019B	RET
	dc.b	$3e	; z$019C	LD A,$FF
	dc.b	$ff	; z$019D
	dc.b	$32	; z$019E	LD ($1C00),A
	dc.b	$00	; z$019F
	dc.b	$1c	; z$01A0
	dc.b	$3a	; z$01A1	LD A,($1C2F)
	dc.b	$2f	; z$01A2
	dc.b	$1c	; z$01A3
	dc.b	$b7	; z$01A4	OR A
	dc.b	$20	; z$01A5	JR NZ,z01AB
	dc.b	$04	; z$01A6
	dc.b	$32	; z$01A7	LD ($1C00),A
	dc.b	$00	; z$01A8
	dc.b	$1c	; z$01A9
	dc.b	$c9	; z$01AA	RET
	dc.b	$3d	; z$01AB	DEC A
	dc.b	$32	; z$01AC	LD ($1C2F),A
	dc.b	$2f	; z$01AD
	dc.b	$1c	; z$01AE
	dc.b	$3a	; z$01AF	LD A,($1C2E)
	dc.b	$2e	; z$01B0
	dc.b	$1c	; z$01B1
	dc.b	$5f	; z$01B2	LD E,A
	dc.b	$16	; z$01B3	LD D,$00
	dc.b	$00	; z$01B4
	dc.b	$21	; z$01B5	LD HL,$1C30
	dc.b	$30	; z$01B6
	dc.b	$1c	; z$01B7
	dc.b	$19	; z$01B8	ADD HL,DE
	dc.b	$3c	; z$01B9	INC A
	dc.b	$e6	; z$01BA	AND $0F
	dc.b	$0f	; z$01BB
	dc.b	$32	; z$01BC	LD ($1C2E),A
	dc.b	$2e	; z$01BD
	dc.b	$1c	; z$01BE
	dc.b	$4e	; z$01BF	LD C,(HL)
	dc.b	$af	; z$01C0	XOR A
	dc.b	$32	; z$01C1	LD ($1C00),A
	dc.b	$00	; z$01C2
	dc.b	$1c	; z$01C3
	dc.b	$79	; z$01C4	LD A,C
	dc.b	$fe	; z$01C5	CP $FA
	dc.b	$fa	; z$01C6
	dc.b	$38	; z$01C7	JR C,z01D5
	dc.b	$0c	; z$01C8
	dc.b	$2f	; z$01C9	CPL
	dc.b	$87	; z$01CA	ADD A,A
	dc.b	$5f	; z$01CB	LD E,A
	dc.b	$21	; z$01CC	LD HL,$0275
	dc.b	$75	; z$01CD
	dc.b	$02	; z$01CE
	dc.b	$19	; z$01CF	ADD HL,DE
	dc.b	$7e	; z$01D0	LD A,(HL)
	dc.b	$23	; z$01D1	INC HL
	dc.b	$66	; z$01D2	LD H,(HL)
	dc.b	$6f	; z$01D3	LD L,A
	dc.b	$e9	; z$01D4	JP (HL)
	dc.b	$fe	; z$01D5	CP $58
	dc.b	$58	; z$01D6
	dc.b	$d0	; z$01D7	RET NC
	dc.b	$87	; z$01D8	ADD A,A
	dc.b	$5f	; z$01D9	LD E,A
	dc.b	$21	; z$01DA	LD HL,$9B01
	dc.b	$01	; z$01DB
	dc.b	$9b	; z$01DC
	dc.b	$19	; z$01DD	ADD HL,DE
	dc.b	$7e	; z$01DE	LD A,(HL)
	dc.b	$23	; z$01DF	INC HL
	dc.b	$66	; z$01E0	LD H,(HL)
	dc.b	$6f	; z$01E1	LD L,A
	dc.b	$7e	; z$01E2	LD A,(HL)
	dc.b	$23	; z$01E3	INC HL
	dc.b	$32	; z$01E4	LD ($1C28),A
	dc.b	$28	; z$01E5
	dc.b	$1c	; z$01E6
	dc.b	$b7	; z$01E7	OR A
	dc.b	$f2	; z$01E8	JP P,z022D
	dc.b	$2d	; z$01E9
	dc.b	$02	; z$01EA
	dc.b	$af	; z$01EB	XOR A
	dc.b	$32	; z$01EC	LD ($1C0A),A
	dc.b	$0a	; z$01ED
	dc.b	$1c	; z$01EE
	dc.b	$32	; z$01EF	LD ($1C0B),A
	dc.b	$0b	; z$01F0
	dc.b	$1c	; z$01F1
	dc.b	$32	; z$01F2	LD ($1C09),A
	dc.b	$09	; z$01F3
	dc.b	$1c	; z$01F4
	dc.b	$32	; z$01F5	LD ($1C2A),A
	dc.b	$2a	; z$01F6
	dc.b	$1c	; z$01F7
	dc.b	$5e	; z$01F8	LD E,(HL)
	dc.b	$23	; z$01F9	INC HL
	dc.b	$56	; z$01FA	LD D,(HL)
	dc.b	$23	; z$01FB	INC HL
	dc.b	$ed	; z$01FC	LD ($1C14),DE
	dc.b	$53	; z$01FD
	dc.b	$14	; z$01FE
	dc.b	$1c	; z$01FF
	dc.b	$e5	; z$0200	PUSH HL
	dc.b	$21	; z$0201	LD HL,$0000
	dc.b	$00	; z$0202
	dc.b	$00	; z$0203
	dc.b	$22	; z$0204	LD ($1C16),HL
	dc.b	$16	; z$0205
	dc.b	$1c	; z$0206
	dc.b	$cd	; z$0207	CALL z0321
	dc.b	$21	; z$0208
	dc.b	$03	; z$0209
	dc.b	$e1	; z$020A	POP HL
	dc.b	$dd	; z$020B	LD IX,$1EC0
	dc.b	$21	; z$020C
	dc.b	$c0	; z$020D
	dc.b	$1e	; z$020E
	dc.b	$01	; z$020F	LD BC,$0020
	dc.b	$20	; z$0210
	dc.b	$00	; z$0211
	dc.b	$5e	; z$0212	LD E,(HL)
	dc.b	$23	; z$0213	INC HL
	dc.b	$56	; z$0214	LD D,(HL)
	dc.b	$7b	; z$0215	LD A,E
	dc.b	$b2	; z$0216	OR D
	dc.b	$c8	; z$0217	RET Z
	dc.b	$23	; z$0218	INC HL
	dc.b	$dd	; z$0219	LD (IX+0),$80
	dc.b	$36	; z$021A
	dc.b	$00	; z$021B
	dc.b	$80	; z$021C
	dc.b	$3a	; z$021D	LD A,($1C28)
	dc.b	$28	; z$021E
	dc.b	$1c	; z$021F
	dc.b	$dd	; z$0220	LD (IX-23),A
	dc.b	$77	; z$0221
	dc.b	$10	; z$0222
	dc.b	$dd	; z$0223
	dc.b	$73	; z$0224	LD (HL),E
	dc.b	$06	; z$0225	LD B,$DD
	dc.b	$dd	; z$0226
	dc.b	$72	; z$0227	LD (HL),D
	dc.b	$07	; z$0228	RLCA
	dc.b	$dd	; z$0229	ADD IX,BC
	dc.b	$09	; z$022A
	dc.b	$18	; z$022B	JR z0212
	dc.b	$e5	; z$022C
	dc.b	$e5	; z$022D	PUSH HL
	dc.b	$cd	; z$022E	CALL z0344
	dc.b	$44	; z$022F
	dc.b	$03	; z$0230
	dc.b	$e1	; z$0231	POP HL
	dc.b	$7e	; z$0232	LD A,(HL)
	dc.b	$fe	; z$0233	CP $FF
	dc.b	$ff	; z$0234
	dc.b	$c8	; z$0235	RET Z
	dc.b	$23	; z$0236	INC HL
	dc.b	$0f	; z$0237	RRCA
	dc.b	$0f	; z$0238	RRCA
	dc.b	$0f	; z$0239	RRCA
	dc.b	$57	; z$023A	LD D,A
	dc.b	$e6	; z$023B	AND $E0
	dc.b	$e0	; z$023C
	dc.b	$5f	; z$023D	LD E,A
	dc.b	$7a	; z$023E	LD A,D
	dc.b	$e6	; z$023F	AND $07
	dc.b	$07	; z$0240
	dc.b	$57	; z$0241	LD D,A
	dc.b	$dd	; z$0242	LD IX,$1EC0
	dc.b	$21	; z$0243
	dc.b	$c0	; z$0244
	dc.b	$1e	; z$0245
	dc.b	$dd	; z$0246	ADD IX,DE
	dc.b	$19	; z$0247
	dc.b	$dd	; z$0248	RRC (IX+0)
	dc.b	$cb	; z$0249
	dc.b	$00	; z$024A
	dc.b	$7e	; z$024B
	dc.b	$28	; z$024C	JR Z,z025F
	dc.b	$11	; z$024D
	dc.b	$3a	; z$024E	LD A,($1C28)
	dc.b	$28	; z$024F
	dc.b	$1c	; z$0250
	dc.b	$dd	; z$0251	CP (IX+10)
	dc.b	$be	; z$0252
	dc.b	$10	; z$0253
	dc.b	$30	; z$0254	JR NC,z025A
	dc.b	$04	; z$0255
	dc.b	$23	; z$0256	INC HL
	dc.b	$23	; z$0257	INC HL
	dc.b	$18	; z$0258	JR z0232
	dc.b	$d8	; z$0259
	dc.b	$e5	; z$025A	PUSH HL
	dc.b	$cd	; z$025B	CALL z02FA
	dc.b	$fa	; z$025C
	dc.b	$02	; z$025D
	dc.b	$e1	; z$025E	POP HL
	dc.b	$dd	; z$025F	LD (IX+0),$80
	dc.b	$36	; z$0260
	dc.b	$00	; z$0261
	dc.b	$80	; z$0262
	dc.b	$3a	; z$0263	LD A,($1C28)
	dc.b	$28	; z$0264
	dc.b	$1c	; z$0265
	dc.b	$dd	; z$0266	LD (IX+7E),A
	dc.b	$77	; z$0267
	dc.b	$10	; z$0268
	dc.b	$7e	; z$0269
	dc.b	$23	; z$026A	INC HL
	dc.b	$dd	; z$026B	LD (IX+7E),A
	dc.b	$77	; z$026C
	dc.b	$06	; z$026D
	dc.b	$7e	; z$026E
	dc.b	$23	; z$026F	INC HL
	dc.b	$dd	; z$0270	LD (IX+18),A
	dc.b	$77	; z$0271
	dc.b	$07	; z$0272
	dc.b	$18	; z$0273
	dc.b	$bd	; z$0274	CP L
	dc.b	$69	; z$0275	LD L,C
	dc.b	$03	; z$0276	INC BC
	dc.b	$9c	; z$0277	SBC A,H
	dc.b	$02	; z$0278	LD (BC),A
	dc.b	$e2	; z$0279	JP PO,zBA02
	dc.b	$02	; z$027A
	dc.b	$ba	; z$027B
	dc.b	$02	; z$027C	LD (BC),A
	dc.b	$82	; z$027D	ADD A,D
	dc.b	$02	; z$027E	LD (BC),A
	dc.b	$88	; z$027F	ADC A,B
	dc.b	$02	; z$0280	LD (BC),A
	dc.b	$c9	; z$0281	RET
	dc.b	$3e	; z$0282	LD A,$01
	dc.b	$01	; z$0283
	dc.b	$32	; z$0284	LD ($1C2A),A
	dc.b	$2a	; z$0285
	dc.b	$1c	; z$0286
	dc.b	$c9	; z$0287	RET
	dc.b	$21	; z$0288	LD HL,$028D
	dc.b	$8d	; z$0289
	dc.b	$02	; z$028A
	dc.b	$18	; z$028B	JR z029F
	dc.b	$12	; z$028C
	dc.b	$80	; z$028D	ADD A,B
	dc.b	$10	; z$028E	DJNZ z0290
	dc.b	$00	; z$028F
	dc.b	$80	; z$0290	ADD A,B
	dc.b	$18	; z$0291	JR z0293
	dc.b	$00	; z$0292
	dc.b	$ff	; z$0293	RST $38
	dc.b	$20	; z$0294	JR NZ,z0296
	dc.b	$00	; z$0295
	dc.b	$ff	; z$0296	RST $38
	dc.b	$40	; z$0297	LD B,B
	dc.b	$00	; z$0298	NOP
	dc.b	$ff	; z$0299	RST $38
	dc.b	$80	; z$029A	ADD A,B
	dc.b	$00	; z$029B	NOP
	dc.b	$21	; z$029C	LD HL,$02B1
	dc.b	$b1	; z$029D
	dc.b	$02	; z$029E
	dc.b	$22	; z$029F	LD ($1C0E),HL
	dc.b	$0e	; z$02A0
	dc.b	$1c	; z$02A1
	dc.b	$21	; z$02A2	LD HL,$0000
	dc.b	$00	; z$02A3
	dc.b	$00	; z$02A4
	dc.b	$22	; z$02A5	LD ($1C0C),HL
	dc.b	$0c	; z$02A6
	dc.b	$1c	; z$02A7
	dc.b	$22	; z$02A8	LD ($1C2A),HL
	dc.b	$2a	; z$02A9
	dc.b	$1c	; z$02AA
	dc.b	$3e	; z$02AB	LD A,$01
	dc.b	$01	; z$02AC
	dc.b	$32	; z$02AD	LD ($1C09),A
	dc.b	$09	; z$02AE
	dc.b	$1c	; z$02AF
	dc.b	$c9	; z$02B0	RET
	dc.b	$20	; z$02B1	JR NZ,z02F3
	dc.b	$40	; z$02B2
	dc.b	$00	; z$02B3	NOP
	dc.b	$20	; z$02B4	JR NZ,z0316
	dc.b	$60	; z$02B5
	dc.b	$00	; z$02B6	NOP
	dc.b	$ff	; z$02B7	RST $38
	dc.b	$80	; z$02B8	ADD A,B
	dc.b	$00	; z$02B9	NOP
	dc.b	$dd	; z$02BA	LD IX,$1EC0
	dc.b	$21	; z$02BB
	dc.b	$c0	; z$02BC
	dc.b	$1e	; z$02BD
	dc.b	$af	; z$02BE	XOR A
	dc.b	$32	; z$02BF	LD ($1C07),A
	dc.b	$07	; z$02C0
	dc.b	$1c	; z$02C1
	dc.b	$dd	; z$02C2	RRC (IX+0)
	dc.b	$cb	; z$02C3
	dc.b	$00	; z$02C4
	dc.b	$7e	; z$02C5
	dc.b	$28	; z$02C6	JR Z,z02CF
	dc.b	$07	; z$02C7
	dc.b	$dd	; z$02C8	RRC (IX+10)
	dc.b	$cb	; z$02C9
	dc.b	$10	; z$02CA
	dc.b	$7e	; z$02CB
	dc.b	$c4	; z$02CC	CALL NZ,z02FA
	dc.b	$fa	; z$02CD
	dc.b	$02	; z$02CE
	dc.b	$11	; z$02CF	LD DE,$0020
	dc.b	$20	; z$02D0
	dc.b	$00	; z$02D1
	dc.b	$dd	; z$02D2	ADD IX,DE
	dc.b	$19	; z$02D3
	dc.b	$3a	; z$02D4	LD A,($1C07)
	dc.b	$07	; z$02D5
	dc.b	$1c	; z$02D6
	dc.b	$3c	; z$02D7	INC A
	dc.b	$fe	; z$02D8	CP $0A
	dc.b	$0a	; z$02D9
	dc.b	$38	; z$02DA	JR C,z02BF
	dc.b	$e3	; z$02DB
	dc.b	$21	; z$02DC	LD HL,$1C03
	dc.b	$03	; z$02DD
	dc.b	$1c	; z$02DE
	dc.b	$cb	; z$02DF	RR (HL)
	dc.b	$c6	; z$02E0
	dc.b	$c9	; z$02E1	RET
	dc.b	$21	; z$02E2	LD HL,$1C03
	dc.b	$03	; z$02E3
	dc.b	$1c	; z$02E4
	dc.b	$cb	; z$02E5	RL (HL)
	dc.b	$86	; z$02E6
	dc.b	$c9	; z$02E7	RET
	dc.b	$dd	; z$02E8	PUSH IX
	dc.b	$e5	; z$02E9
	dc.b	$e1	; z$02EA	POP HL
	dc.b	$01	; z$02EB	LD BC,$E140
	dc.b	$40	; z$02EC
	dc.b	$e1	; z$02ED
	dc.b	$09	; z$02EE	ADD HL,BC
	dc.b	$7c	; z$02EF	LD A,H
	dc.b	$07	; z$02F0	RLCA
	dc.b	$07	; z$02F1	RLCA
	dc.b	$07	; z$02F2	RLCA
	dc.b	$4f	; z$02F3	LD C,A
	dc.b	$7d	; z$02F4	LD A,L
	dc.b	$07	; z$02F5	RLCA
	dc.b	$07	; z$02F6	RLCA
	dc.b	$07	; z$02F7	RLCA
	dc.b	$b1	; z$02F8	OR C
	dc.b	$c9	; z$02F9	RET
	dc.b	$cd	; z$02FA	CALL z02E8
	dc.b	$e8	; z$02FB
	dc.b	$02	; z$02FC
	dc.b	$dd	; z$02FD	PUSH IX
	dc.b	$e5	; z$02FE
	dc.b	$dd	; z$02FF	LD IX,$1C80
	dc.b	$21	; z$0300
	dc.b	$80	; z$0301
	dc.b	$1c	; z$0302
	dc.b	$06	; z$0303	LD B,$09
	dc.b	$09	; z$0304
	dc.b	$dd	; z$0305	RRC (IX+0)
	dc.b	$cb	; z$0306
	dc.b	$00	; z$0307
	dc.b	$7e	; z$0308
	dc.b	$28	; z$0309	JR Z,z0317
	dc.b	$0c	; z$030A
	dc.b	$dd	; z$030B	CP (IX+6)
	dc.b	$be	; z$030C
	dc.b	$06	; z$030D
	dc.b	$20	; z$030E	JR NZ,z0317
	dc.b	$07	; z$030F
	dc.b	$4f	; z$0310	LD C,A
	dc.b	$c5	; z$0311	PUSH BC
	dc.b	$cd	; z$0312	CALL z0446
	dc.b	$46	; z$0313
	dc.b	$04	; z$0314
	dc.b	$c1	; z$0315	POP BC
	dc.b	$79	; z$0316	LD A,C
	dc.b	$11	; z$0317	LD DE,$0040
	dc.b	$40	; z$0318
	dc.b	$00	; z$0319
	dc.b	$dd	; z$031A	ADD IX,DE
	dc.b	$19	; z$031B
	dc.b	$10	; z$031C	DJNZ z0305
	dc.b	$e7	; z$031D
	dc.b	$dd	; z$031E	POP IX
	dc.b	$e1	; z$031F
	dc.b	$c9	; z$0320	RET
ScanChannels:
	dc.b	$dd	; z$0321	LD IX,$1EC0
	dc.b	$21	; z$0322
	dc.b	$c0	; z$0323
	dc.b	$1e	; z$0324
	dc.b	$06	; z$0325	LD B,$0A
	dc.b	$0a	; z$0326
	dc.b	$dd	; z$0327	RRC (IX+0)
	dc.b	$cb	; z$0328
	dc.b	$00	; z$0329
	dc.b	$7e	; z$032A
	dc.b	$28	; z$032B	JR Z,z033C
	dc.b	$0f	; z$032C
	dc.b	$dd	; z$032D	RRC (IX+10)
	dc.b	$cb	; z$032E
	dc.b	$10	; z$032F
	dc.b	$7e	; z$0330
	dc.b	$28	; z$0331	JR Z,z033C
	dc.b	$09	; z$0332
	dc.b	$c5	; z$0333	PUSH BC
	dc.b	$cd	; z$0334	CALL z02FA
	dc.b	$fa	; z$0335
	dc.b	$02	; z$0336
	dc.b	$c1	; z$0337	POP BC
	dc.b	$dd	; z$0338	LD (IX+0),$00
	dc.b	$36	; z$0339
	dc.b	$00	; z$033A
	dc.b	$00	; z$033B
	dc.b	$11	; z$033C	LD DE,$0020
	dc.b	$20	; z$033D
	dc.b	$00	; z$033E
	dc.b	$dd	; z$033F	ADD IX,DE
	dc.b	$19	; z$0340
	dc.b	$10	; z$0341	DJNZ z0327
	dc.b	$e4	; z$0342
	dc.b	$c9	; z$0343	RET
	dc.b	$dd	; z$0344	LD IX,$1EC0
	dc.b	$21	; z$0345
	dc.b	$c0	; z$0346
	dc.b	$1e	; z$0347
	dc.b	$06	; z$0348	LD B,$0A
	dc.b	$0a	; z$0349
	dc.b	$dd	; z$034A	RRC (IX+0)
	dc.b	$cb	; z$034B
	dc.b	$00	; z$034C
	dc.b	$7e	; z$034D
	dc.b	$28	; z$034E	JR Z,z0361
	dc.b	$11	; z$034F
	dc.b	$3a	; z$0350	LD A,($1C28)
	dc.b	$28	; z$0351
	dc.b	$1c	; z$0352
	dc.b	$dd	; z$0353	CP (IX+10)
	dc.b	$be	; z$0354
	dc.b	$10	; z$0355
	dc.b	$20	; z$0356	JR NZ,z0361
	dc.b	$09	; z$0357
	dc.b	$c5	; z$0358	PUSH BC
	dc.b	$cd	; z$0359	CALL z02FA
	dc.b	$fa	; z$035A
	dc.b	$02	; z$035B
	dc.b	$c1	; z$035C	POP BC
	dc.b	$dd	; z$035D	LD (IX+0),$00
	dc.b	$36	; z$035E
	dc.b	$00	; z$035F
	dc.b	$00	; z$0360
	dc.b	$11	; z$0361	LD DE,$0020
	dc.b	$20	; z$0362
	dc.b	$00	; z$0363
	dc.b	$dd	; z$0364	ADD IX,DE
	dc.b	$19	; z$0365
	dc.b	$10	; z$0366	DJNZ z034A
	dc.b	$e2	; z$0367
	dc.b	$c9	; z$0368	RET
ProcessActiveChannels:
	dc.b	$dd	; z$0369	LD IX,$1EC0
	dc.b	$21	; z$036A
	dc.b	$c0	; z$036B
	dc.b	$1e	; z$036C
	dc.b	$06	; z$036D	LD B,$0A
	dc.b	$0a	; z$036E
	dc.b	$dd	; z$036F	RRC (IX+0)
	dc.b	$cb	; z$0370
	dc.b	$00	; z$0371
	dc.b	$7e	; z$0372
	dc.b	$28	; z$0373	JR Z,z037E
	dc.b	$09	; z$0374
	dc.b	$c5	; z$0375	PUSH BC
	dc.b	$cd	; z$0376	CALL z02FA
	dc.b	$fa	; z$0377
	dc.b	$02	; z$0378
	dc.b	$c1	; z$0379	POP BC
	dc.b	$dd	; z$037A	LD (IX+0),$00
	dc.b	$36	; z$037B
	dc.b	$00	; z$037C
	dc.b	$00	; z$037D
	dc.b	$11	; z$037E	LD DE,$0020
	dc.b	$20	; z$037F
	dc.b	$00	; z$0380
	dc.b	$dd	; z$0381	ADD IX,DE
	dc.b	$19	; z$0382
	dc.b	$10	; z$0383	DJNZ z036F
	dc.b	$ea	; z$0384
	dc.b	$21	; z$0385	LD HL,$0000
	dc.b	$00	; z$0386
	dc.b	$00	; z$0387
	dc.b	$22	; z$0388	LD ($1C2A),HL
	dc.b	$2a	; z$0389
	dc.b	$1c	; z$038A
	dc.b	$af	; z$038B	XOR A
	dc.b	$32	; z$038C	LD ($1C09),A
	dc.b	$09	; z$038D
	dc.b	$1c	; z$038E
	dc.b	$32	; z$038F	LD ($1C0B),A
	dc.b	$0b	; z$0390
	dc.b	$1c	; z$0391
	dc.b	$c9	; z$0392	RET
LookupFrequency:
	dc.b	$3a	; z$0393	LD A,($1C20)
	dc.b	$20	; z$0394
	dc.b	$1c	; z$0395
	dc.b	$5f	; z$0396	LD E,A
	dc.b	$0f	; z$0397	RRCA
	dc.b	$83	; z$0398	ADD A,E
	dc.b	$5f	; z$0399	LD E,A
	dc.b	$16	; z$039A	LD D,$00
	dc.b	$00	; z$039B
	dc.b	$21	; z$039C	LD HL,$0404
	dc.b	$04	; z$039D
	dc.b	$04	; z$039E
	dc.b	$19	; z$039F	ADD HL,DE
	dc.b	$5e	; z$03A0	LD E,(HL)
	dc.b	$23	; z$03A1	INC HL
	dc.b	$56	; z$03A2	LD D,(HL)
	dc.b	$23	; z$03A3	INC HL
	dc.b	$d5	; z$03A4	PUSH DE
	dc.b	$fd	; z$03A5	POP IY
	dc.b	$e1	; z$03A6
	dc.b	$3a	; z$03A7	LD A,($1C21)
	dc.b	$21	; z$03A8
	dc.b	$1c	; z$03A9
	dc.b	$a6	; z$03AA	AND (HL)
	dc.b	$4f	; z$03AB	LD C,A
	dc.b	$06	; z$03AC	LD B,$80
	dc.b	$80	; z$03AD
	dc.b	$11	; z$03AE	LD DE,$0040
	dc.b	$40	; z$03AF
	dc.b	$00	; z$03B0
	dc.b	$cb	; z$03B1	RRC B
	dc.b	$41	; z$03B2
	dc.b	$28	; z$03B3	JR Z,z03EF
	dc.b	$3a	; z$03B4
	dc.b	$fd	; z$03B5	RRC (IY+0)
	dc.b	$cb	; z$03B6
	dc.b	$00	; z$03B7
	dc.b	$7e	; z$03B8
	dc.b	$c8	; z$03B9	RET Z
	dc.b	$3a	; z$03BA	LD A,($1C22)
	dc.b	$22	; z$03BB
	dc.b	$1c	; z$03BC
	dc.b	$fd	; z$03BD	CP (IY+4)
	dc.b	$be	; z$03BE
	dc.b	$04	; z$03BF
	dc.b	$38	; z$03C0	JR C,z03EF
	dc.b	$2d	; z$03C1
	dc.b	$cb	; z$03C2	RRC A
	dc.b	$78	; z$03C3
	dc.b	$20	; z$03C4	JR NZ,z03E0
	dc.b	$1a	; z$03C5
	dc.b	$78	; z$03C6	LD A,B
	dc.b	$fd	; z$03C7	CP (IY+4)
	dc.b	$be	; z$03C8
	dc.b	$04	; z$03C9
	dc.b	$38	; z$03CA	JR C,z03EF
	dc.b	$23	; z$03CB
	dc.b	$20	; z$03CC	JR NZ,z03E0
	dc.b	$12	; z$03CD
	dc.b	$3a	; z$03CE	LD A,($1C27)
	dc.b	$27	; z$03CF
	dc.b	$1c	; z$03D0
	dc.b	$fd	; z$03D1	CP (IY+3D)
	dc.b	$be	; z$03D2
	dc.b	$3d	; z$03D3
	dc.b	$38	; z$03D4	JR C,z03E0
	dc.b	$0a	; z$03D5
	dc.b	$20	; z$03D6	JR NZ,z03EF
	dc.b	$17	; z$03D7
	dc.b	$3a	; z$03D8	LD A,($1C26)
	dc.b	$26	; z$03D9
	dc.b	$1c	; z$03DA
	dc.b	$fd	; z$03DB	CP (IY+3C)
	dc.b	$be	; z$03DC
	dc.b	$3c	; z$03DD
	dc.b	$30	; z$03DE	JR NC,z03EF
	dc.b	$0f	; z$03DF
	dc.b	$fd	; z$03E0	LD L,(IY-3)
	dc.b	$6e	; z$03E1
	dc.b	$3c	; z$03E2
	dc.b	$fd	; z$03E3
	dc.b	$66	; z$03E4	LD H,(HL)
	dc.b	$3d	; z$03E5	DEC A
	dc.b	$22	; z$03E6	LD ($1C26),HL
	dc.b	$26	; z$03E7
	dc.b	$1c	; z$03E8
	dc.b	$fd	; z$03E9	LD B,(IY-3)
	dc.b	$46	; z$03EA
	dc.b	$04	; z$03EB
	dc.b	$fd	; z$03EC
	dc.b	$e5	; z$03ED	PUSH HL
	dc.b	$e1	; z$03EE	POP HL
	dc.b	$fd	; z$03EF	ADD IY,DE
	dc.b	$19	; z$03F0
	dc.b	$cb	; z$03F1	RLC A
	dc.b	$39	; z$03F2
	dc.b	$20	; z$03F3	JR NZ,z03B1
	dc.b	$bc	; z$03F4
	dc.b	$cb	; z$03F5	RRC A
	dc.b	$78	; z$03F6
	dc.b	$c0	; z$03F7	RET NZ
	dc.b	$e5	; z$03F8	PUSH HL
	dc.b	$dd	; z$03F9	DB $IX, $E3
	dc.b	$e3	; z$03FA
	dc.b	$cd	; z$03FB	CALL z0446
	dc.b	$46	; z$03FC
	dc.b	$04	; z$03FD
	dc.b	$dd	; z$03FE	DB $IX, $E3
	dc.b	$e3	; z$03FF
	dc.b	$fd	; z$0400	POP IY
	dc.b	$e1	; z$0401
	dc.b	$af	; z$0402	XOR A
	dc.b	$c9	; z$0403	RET
	dc.b	$80	; z$0404	ADD A,B
	dc.b	$1c	; z$0405	INC E
	dc.b	$3f	; z$0406	CCF
	dc.b	$00	; z$0407	NOP
	dc.b	$1e	; z$0408	LD E,$07
	dc.b	$07	; z$0409
	dc.b	$80	; z$040A	ADD A,B
	dc.b	$1e	; z$040B	LD E,$01
	dc.b	$01	; z$040C
	dc.b	$dd	; z$040D	LD A,(IX-23)
	dc.b	$7e	; z$040E
	dc.b	$12	; z$040F
	dc.b	$dd	; z$0410
	dc.b	$96	; z$0411	SUB (HL)
	dc.b	$13	; z$0412	INC DE
	dc.b	$4f	; z$0413	LD C,A
	dc.b	$fd	; z$0414	LD IY,$1C80
	dc.b	$21	; z$0415
	dc.b	$80	; z$0416
	dc.b	$1c	; z$0417
	dc.b	$11	; z$0418	LD DE,$0040
	dc.b	$40	; z$0419
	dc.b	$00	; z$041A
	dc.b	$06	; z$041B	LD B,$09
	dc.b	$09	; z$041C
	dc.b	$fd	; z$041D	RRC (IY+0)
	dc.b	$cb	; z$041E
	dc.b	$00	; z$041F
	dc.b	$7e	; z$0420
	dc.b	$28	; z$0421	JR Z,z0430
	dc.b	$0d	; z$0422
	dc.b	$3a	; z$0423	LD A,($1C07)
	dc.b	$07	; z$0424
	dc.b	$1c	; z$0425
	dc.b	$fd	; z$0426	CP (IY+6)
	dc.b	$be	; z$0427
	dc.b	$06	; z$0428
	dc.b	$20	; z$0429	JR NZ,z0430
	dc.b	$05	; z$042A
	dc.b	$79	; z$042B	LD A,C
	dc.b	$fd	; z$042C	CP (IY+7)
	dc.b	$be	; z$042D
	dc.b	$07	; z$042E
	dc.b	$c8	; z$042F	RET Z
	dc.b	$fd	; z$0430	ADD IY,DE
	dc.b	$19	; z$0431
	dc.b	$10	; z$0432	DJNZ z041D
	dc.b	$e9	; z$0433
	dc.b	$37	; z$0434	SCF
	dc.b	$c9	; z$0435	RET
	dc.b	$dd	; z$0436	PUSH IX
	dc.b	$e5	; z$0437
	dc.b	$e1	; z$0438	POP HL
	dc.b	$01	; z$0439	LD BC,$E380
	dc.b	$80	; z$043A
	dc.b	$e3	; z$043B
	dc.b	$09	; z$043C	ADD HL,BC
	dc.b	$7c	; z$043D	LD A,H
	dc.b	$07	; z$043E	RLCA
	dc.b	$07	; z$043F	RLCA
	dc.b	$67	; z$0440	LD H,A
	dc.b	$7d	; z$0441	LD A,L
	dc.b	$07	; z$0442	RLCA
	dc.b	$07	; z$0443	RLCA
	dc.b	$b4	; z$0444	OR H
	dc.b	$c9	; z$0445	RET
	dc.b	$cd	; z$0446	CALL z0436
	dc.b	$36	; z$0447
	dc.b	$04	; z$0448
	dc.b	$fe	; z$0449	CP $06
	dc.b	$06	; z$044A
	dc.b	$38	; z$044B	JR C,z0454
	dc.b	$07	; z$044C
	dc.b	$d6	; z$044D	SUB $06
	dc.b	$06	; z$044E
	dc.b	$32	; z$044F	LD ($1C11),A
	dc.b	$11	; z$0450
	dc.b	$1c	; z$0451
	dc.b	$18	; z$0452	JR z0460
	dc.b	$0c	; z$0453
	dc.b	$cb	; z$0454	RLC A
	dc.b	$3f	; z$0455
	dc.b	$32	; z$0456	LD ($1C11),A
	dc.b	$11	; z$0457
	dc.b	$1c	; z$0458
	dc.b	$3e	; z$0459	LD A,$00
	dc.b	$00	; z$045A
	dc.b	$17	; z$045B	RLA
	dc.b	$07	; z$045C	RLCA
	dc.b	$32	; z$045D	LD ($1C10),A
	dc.b	$10	; z$045E
	dc.b	$1c	; z$045F
	dc.b	$dd	; z$0460	LD A,(IX-2A)
	dc.b	$7e	; z$0461
	dc.b	$01	; z$0462
	dc.b	$d6	; z$0463
	dc.b	$02	; z$0464	LD (BC),A
	dc.b	$38	; z$0465	JR C,z048C
	dc.b	$25	; z$0466
	dc.b	$20	; z$0467	JR NZ,z047D
	dc.b	$14	; z$0468
	dc.b	$dd	; z$0469	LD (IX+29),$78
	dc.b	$36	; z$046A
	dc.b	$29	; z$046B
	dc.b	$78	; z$046C
	dc.b	$3a	; z$046D	LD A,($1C11)
	dc.b	$11	; z$046E
	dc.b	$1c	; z$046F
	dc.b	$0f	; z$0470	RRCA
	dc.b	$0f	; z$0471	RRCA
	dc.b	$0f	; z$0472	RRCA
	dc.b	$f6	; z$0473	OR $9F
	dc.b	$9f	; z$0474
	dc.b	$32	; z$0475	LD ($7F11),A
	dc.b	$11	; z$0476
	dc.b	$7f	; z$0477
	dc.b	$dd	; z$0478	LD (IX+0),$00
	dc.b	$36	; z$0479
	dc.b	$00	; z$047A
	dc.b	$00	; z$047B
	dc.b	$c9	; z$047C	RET
	dc.b	$3e	; z$047D	LD A,$78
	dc.b	$78	; z$047E
	dc.b	$32	; z$047F	LD ($1C13),A
	dc.b	$13	; z$0480
	dc.b	$1c	; z$0481
	dc.b	$3e	; z$0482	LD A,$FF
	dc.b	$ff	; z$0483
	dc.b	$32	; z$0484	LD ($7F11),A
	dc.b	$11	; z$0485
	dc.b	$7f	; z$0486
	dc.b	$dd	; z$0487	LD (IX+0),$00
	dc.b	$36	; z$0488
	dc.b	$00	; z$0489
	dc.b	$00	; z$048A
	dc.b	$c9	; z$048B	RET
	dc.b	$0e	; z$048C	LD C,$FF
	dc.b	$ff	; z$048D
	dc.b	$06	; z$048E	LD B,$80
	dc.b	$80	; z$048F
	dc.b	$cd	; z$0490	CALL z06C8
	dc.b	$c8	; z$0491
	dc.b	$06	; z$0492
	dc.b	$06	; z$0493	LD B,$84
	dc.b	$84	; z$0494
	dc.b	$cd	; z$0495	CALL z06C8
	dc.b	$c8	; z$0496
	dc.b	$06	; z$0497
	dc.b	$06	; z$0498	LD B,$88
	dc.b	$88	; z$0499
	dc.b	$cd	; z$049A	CALL z06C8
	dc.b	$c8	; z$049B
	dc.b	$06	; z$049C
	dc.b	$06	; z$049D	LD B,$8C
	dc.b	$8c	; z$049E
	dc.b	$cd	; z$049F	CALL z06C8
	dc.b	$c8	; z$04A0
	dc.b	$06	; z$04A1
	dc.b	$dd	; z$04A2	RRC (IX+0)
	dc.b	$cb	; z$04A3
	dc.b	$00	; z$04A4
	dc.b	$4e	; z$04A5
	dc.b	$20	; z$04A6	JR NZ,z04AC
	dc.b	$04	; z$04A7
	dc.b	$af	; z$04A8	XOR A
	dc.b	$cd	; z$04A9	CALL z06E2
	dc.b	$e2	; z$04AA
	dc.b	$06	; z$04AB
	dc.b	$dd	; z$04AC	LD (IX+0),$00
	dc.b	$36	; z$04AD
	dc.b	$00	; z$04AE
	dc.b	$00	; z$04AF
	dc.b	$c9	; z$04B0	RET
	dc.b	$7a	; z$04B1	LD A,D
	dc.b	$07	; z$04B2	RLCA
	dc.b	$07	; z$04B3	RLCA
	dc.b	$07	; z$04B4	RLCA
	dc.b	$07	; z$04B5	RLCA
	dc.b	$57	; z$04B6	LD D,A
	dc.b	$7b	; z$04B7	LD A,E
	dc.b	$0f	; z$04B8	RRCA
	dc.b	$0f	; z$04B9	RRCA
	dc.b	$0f	; z$04BA	RRCA
	dc.b	$0f	; z$04BB	RRCA
	dc.b	$e6	; z$04BC	AND $0E
	dc.b	$0e	; z$04BD
	dc.b	$b2	; z$04BE	OR D
	dc.b	$85	; z$04BF	ADD A,L
	dc.b	$30	; z$04C0	JR NC,z04C3
	dc.b	$01	; z$04C1
	dc.b	$24	; z$04C2	INC H
	dc.b	$6f	; z$04C3	LD L,A
	dc.b	$7e	; z$04C4	LD A,(HL)
	dc.b	$23	; z$04C5	INC HL
	dc.b	$56	; z$04C6	LD D,(HL)
	dc.b	$23	; z$04C7	INC HL
	dc.b	$6e	; z$04C8	LD L,(HL)
	dc.b	$63	; z$04C9	LD H,E
	dc.b	$5f	; z$04CA	LD E,A
	dc.b	$7d	; z$04CB	LD A,L
	dc.b	$93	; z$04CC	SUB E
	dc.b	$cb	; z$04CD	RLC A
	dc.b	$3f	; z$04CE
	dc.b	$cb	; z$04CF	RRC H
	dc.b	$64	; z$04D0
	dc.b	$28	; z$04D1	JR Z,z04DA
	dc.b	$07	; z$04D2
	dc.b	$6f	; z$04D3	LD L,A
	dc.b	$83	; z$04D4	ADD A,E
	dc.b	$5f	; z$04D5	LD E,A
	dc.b	$7d	; z$04D6	LD A,L
	dc.b	$30	; z$04D7	JR NC,z04DA
	dc.b	$01	; z$04D8
	dc.b	$14	; z$04D9	INC D
	dc.b	$cb	; z$04DA	RLC A
	dc.b	$3f	; z$04DB
	dc.b	$cb	; z$04DC	RRC E
	dc.b	$5c	; z$04DD
	dc.b	$c8	; z$04DE	RET Z
	dc.b	$83	; z$04DF	ADD A,E
	dc.b	$5f	; z$04E0	LD E,A
	dc.b	$d0	; z$04E1	RET NC
	dc.b	$14	; z$04E2	INC D
	dc.b	$c9	; z$04E3	RET
	dc.b	$7a	; z$04E4	LD A,D
	dc.b	$07	; z$04E5	RLCA
	dc.b	$07	; z$04E6	RLCA
	dc.b	$07	; z$04E7	RLCA
	dc.b	$07	; z$04E8	RLCA
	dc.b	$57	; z$04E9	LD D,A
	dc.b	$7b	; z$04EA	LD A,E
	dc.b	$0f	; z$04EB	RRCA
	dc.b	$0f	; z$04EC	RRCA
	dc.b	$0f	; z$04ED	RRCA
	dc.b	$0f	; z$04EE	RRCA
	dc.b	$e6	; z$04EF	AND $0E
	dc.b	$0e	; z$04F0
	dc.b	$b2	; z$04F1	OR D
	dc.b	$85	; z$04F2	ADD A,L
	dc.b	$30	; z$04F3	JR NC,z04F6
	dc.b	$01	; z$04F4
	dc.b	$24	; z$04F5	INC H
	dc.b	$6f	; z$04F6	LD L,A
	dc.b	$7e	; z$04F7	LD A,(HL)
	dc.b	$23	; z$04F8	INC HL
	dc.b	$56	; z$04F9	LD D,(HL)
	dc.b	$23	; z$04FA	INC HL
	dc.b	$6e	; z$04FB	LD L,(HL)
	dc.b	$63	; z$04FC	LD H,E
	dc.b	$5f	; z$04FD	LD E,A
	dc.b	$95	; z$04FE	SUB L
	dc.b	$cb	; z$04FF	RLC A
	dc.b	$3f	; z$0500
	dc.b	$cb	; z$0501	RRC H
	dc.b	$64	; z$0502
	dc.b	$28	; z$0503	JR Z,z050C
	dc.b	$07	; z$0504
	dc.b	$6f	; z$0505	LD L,A
	dc.b	$83	; z$0506	ADD A,E
	dc.b	$5f	; z$0507	LD E,A
	dc.b	$7d	; z$0508	LD A,L
	dc.b	$30	; z$0509	JR NC,z050C
	dc.b	$01	; z$050A
	dc.b	$14	; z$050B	INC D
	dc.b	$cb	; z$050C	RLC A
	dc.b	$3f	; z$050D
	dc.b	$cb	; z$050E	RRC E
	dc.b	$5c	; z$050F
	dc.b	$c8	; z$0510	RET Z
	dc.b	$83	; z$0511	ADD A,E
	dc.b	$5f	; z$0512	LD E,A
	dc.b	$d0	; z$0513	RET NC
	dc.b	$14	; z$0514	INC D
	dc.b	$c9	; z$0515	RET
	dc.b	$7a	; z$0516	LD A,D
	dc.b	$fe	; z$0517	CP $60
	dc.b	$60	; z$0518
	dc.b	$38	; z$0519	JR C,z0521
	dc.b	$06	; z$051A
	dc.b	$11	; z$051B	LD DE,$0BF8
	dc.b	$f8	; z$051C
	dc.b	$0b	; z$051D
	dc.b	$0e	; z$051E	LD C,$07
	dc.b	$07	; z$051F
	dc.b	$c9	; z$0520	RET
	dc.b	$0e	; z$0521	LD C,$00
	dc.b	$00	; z$0522
	dc.b	$fe	; z$0523	CP $30
	dc.b	$30	; z$0524
	dc.b	$38	; z$0525	JR C,z052B
	dc.b	$04	; z$0526
	dc.b	$d6	; z$0527	SUB $30
	dc.b	$30	; z$0528
	dc.b	$cb	; z$0529	RR D
	dc.b	$d1	; z$052A
	dc.b	$fe	; z$052B	CP $18
	dc.b	$18	; z$052C
	dc.b	$38	; z$052D	JR C,z0533
	dc.b	$04	; z$052E
	dc.b	$d6	; z$052F	SUB $18
	dc.b	$18	; z$0530
	dc.b	$cb	; z$0531	RR C
	dc.b	$c9	; z$0532
	dc.b	$fe	; z$0533	CP $0C
	dc.b	$0c	; z$0534
	dc.b	$38	; z$0535	JR C,z053A
	dc.b	$03	; z$0536
	dc.b	$d6	; z$0537	SUB $0C
	dc.b	$0c	; z$0538
	dc.b	$0c	; z$0539	INC C
	dc.b	$57	; z$053A	LD D,A
	dc.b	$c9	; z$053B	RET
	dc.b	$dd	; z$053C	LD A,(IX-49)
	dc.b	$7e	; z$053D
	dc.b	$01	; z$053E
	dc.b	$b7	; z$053F
	dc.b	$28	; z$0540	JR Z,z0579
	dc.b	$37	; z$0541
	dc.b	$cd	; z$0542	CALL z05A3
	dc.b	$a3	; z$0543
	dc.b	$05	; z$0544
	dc.b	$c8	; z$0545	RET Z
	dc.b	$cd	; z$0546	CALL z0516
	dc.b	$16	; z$0547
	dc.b	$05	; z$0548
	dc.b	$21	; z$0549	LD HL,$113D
	dc.b	$3d	; z$054A
	dc.b	$11	; z$054B
	dc.b	$cd	; z$054C	CALL z04E4
	dc.b	$e4	; z$054D
	dc.b	$04	; z$054E
	dc.b	$41	; z$054F	LD B,C
	dc.b	$04	; z$0550	INC B
	dc.b	$05	; z$0551	DEC B
	dc.b	$28	; z$0552	JR Z,z055A
	dc.b	$06	; z$0553
	dc.b	$cb	; z$0554	RLC A
	dc.b	$3a	; z$0555
	dc.b	$cb	; z$0556	RLC E
	dc.b	$1b	; z$0557
	dc.b	$10	; z$0558	DJNZ z0554
	dc.b	$fa	; z$0559
	dc.b	$7b	; z$055A	LD A,E
	dc.b	$e6	; z$055B	AND $0F
	dc.b	$0f	; z$055C
	dc.b	$4f	; z$055D	LD C,A
	dc.b	$3a	; z$055E	LD A,($1C11)
	dc.b	$11	; z$055F
	dc.b	$1c	; z$0560
	dc.b	$0f	; z$0561	RRCA
	dc.b	$0f	; z$0562	RRCA
	dc.b	$0f	; z$0563	RRCA
	dc.b	$b1	; z$0564	OR C
	dc.b	$f6	; z$0565	OR $80
	dc.b	$80	; z$0566
	dc.b	$32	; z$0567	LD ($7F11),A
	dc.b	$11	; z$0568
	dc.b	$7f	; z$0569
	dc.b	$7b	; z$056A	LD A,E
	dc.b	$e6	; z$056B	AND $F0
	dc.b	$f0	; z$056C
	dc.b	$cb	; z$056D	RLC A
	dc.b	$3a	; z$056E
	dc.b	$1f	; z$056F	RRA
	dc.b	$cb	; z$0570	RLC A
	dc.b	$3a	; z$0571
	dc.b	$1f	; z$0572	RRA
	dc.b	$0f	; z$0573	RRCA
	dc.b	$0f	; z$0574	RRCA
	dc.b	$32	; z$0575	LD ($7F11),A
	dc.b	$11	; z$0576
	dc.b	$7f	; z$0577
	dc.b	$c9	; z$0578	RET
	dc.b	$cd	; z$0579	CALL z05A3
	dc.b	$a3	; z$057A
	dc.b	$05	; z$057B
	dc.b	$c8	; z$057C	RET Z
	dc.b	$3a	; z$057D	LD A,($1C11)
	dc.b	$11	; z$057E
	dc.b	$1c	; z$057F
	dc.b	$c6	; z$0580	ADD A,$A4
	dc.b	$a4	; z$0581
	dc.b	$47	; z$0582	LD B,A
	dc.b	$cd	; z$0583	CALL z0516
	dc.b	$16	; z$0584
	dc.b	$05	; z$0585
	dc.b	$21	; z$0586	LD HL,$107B
	dc.b	$7b	; z$0587
	dc.b	$10	; z$0588
	dc.b	$cd	; z$0589	CALL z04B1
	dc.b	$b1	; z$058A
	dc.b	$04	; z$058B
	dc.b	$79	; z$058C	LD A,C
	dc.b	$07	; z$058D	RLCA
	dc.b	$07	; z$058E	RLCA
	dc.b	$07	; z$058F	RLCA
	dc.b	$b2	; z$0590	OR D
	dc.b	$4f	; z$0591	LD C,A
	dc.b	$cd	; z$0592	CALL z06CD
	dc.b	$cd	; z$0593
	dc.b	$06	; z$0594
	dc.b	$cb	; z$0595	RL D
	dc.b	$90	; z$0596
	dc.b	$4b	; z$0597	LD C,E
	dc.b	$c3	; z$0598	JP z06CD
	dc.b	$cd	; z$0599
	dc.b	$06	; z$059A
	dc.b	$e6	; z$059B	AND $F8
	dc.b	$f8	; z$059C
	dc.b	$5f	; z$059D	LD E,A
	dc.b	$bd	; z$059E	CP L
	dc.b	$c0	; z$059F	RET NZ
	dc.b	$7a	; z$05A0	LD A,D
	dc.b	$bc	; z$05A1	CP H
	dc.b	$c9	; z$05A2	RET
	dc.b	$dd	; z$05A3	LD A,(IX-23)
	dc.b	$7e	; z$05A4
	dc.b	$08	; z$05A5
	dc.b	$dd	; z$05A6
	dc.b	$56	; z$05A7	LD D,(HL)
	dc.b	$09	; z$05A8	ADD HL,BC
	dc.b	$dd	; z$05A9	LD L,(IX-23)
	dc.b	$6e	; z$05AA
	dc.b	$0a	; z$05AB
	dc.b	$dd	; z$05AC
	dc.b	$66	; z$05AD	LD H,(HL)
	dc.b	$0b	; z$05AE	DEC BC
	dc.b	$cd	; z$05AF	CALL z059B
	dc.b	$9b	; z$05B0
	dc.b	$05	; z$05B1
	dc.b	$c8	; z$05B2	RET Z
	dc.b	$dd	; z$05B3	LD (IX-23),E
	dc.b	$73	; z$05B4
	dc.b	$0a	; z$05B5
	dc.b	$dd	; z$05B6
	dc.b	$72	; z$05B7	LD (HL),D
	dc.b	$0b	; z$05B8	DEC BC
	dc.b	$c9	; z$05B9	RET
	dc.b	$dd	; z$05BA	LD A,(IX-2A)
	dc.b	$7e	; z$05BB
	dc.b	$01	; z$05BC
	dc.b	$d6	; z$05BD
	dc.b	$02	; z$05BE	LD (BC),A
	dc.b	$38	; z$05BF	JR C,z0616
	dc.b	$55	; z$05C0
	dc.b	$20	; z$05C1	JR NZ,z05EF
	dc.b	$2c	; z$05C2
	dc.b	$dd	; z$05C3	LD A,(IX-1A)
	dc.b	$7e	; z$05C4
	dc.b	$00	; z$05C5
	dc.b	$e6	; z$05C6
	dc.b	$20	; z$05C7	JR NZ,z05F1
	dc.b	$28	; z$05C8
	dc.b	$03	; z$05C9	INC BC
	dc.b	$3a	; z$05CA	LD A,($1C0B)
	dc.b	$0b	; z$05CB
	dc.b	$1c	; z$05CC
	dc.b	$dd	; z$05CD	ADD A,(IX+28)
	dc.b	$86	; z$05CE
	dc.b	$28	; z$05CF
	dc.b	$f2	; z$05D0	JP P,z05D5
	dc.b	$d5	; z$05D1
	dc.b	$05	; z$05D2
	dc.b	$3e	; z$05D3	LD A,$7F
	dc.b	$7f	; z$05D4
	dc.b	$e6	; z$05D5	AND $78
	dc.b	$78	; z$05D6
	dc.b	$dd	; z$05D7	CP (IX+29)
	dc.b	$be	; z$05D8
	dc.b	$29	; z$05D9
	dc.b	$c8	; z$05DA	RET Z
	dc.b	$dd	; z$05DB	LD (IX+F),A
	dc.b	$77	; z$05DC
	dc.b	$29	; z$05DD
	dc.b	$0f	; z$05DE
	dc.b	$0f	; z$05DF	RRCA
	dc.b	$0f	; z$05E0	RRCA
	dc.b	$4f	; z$05E1	LD C,A
	dc.b	$3a	; z$05E2	LD A,($1C11)
	dc.b	$11	; z$05E3
	dc.b	$1c	; z$05E4
	dc.b	$0f	; z$05E5	RRCA
	dc.b	$0f	; z$05E6	RRCA
	dc.b	$0f	; z$05E7	RRCA
	dc.b	$f6	; z$05E8	OR $90
	dc.b	$90	; z$05E9
	dc.b	$b1	; z$05EA	OR C
	dc.b	$32	; z$05EB	LD ($7F11),A
	dc.b	$11	; z$05EC
	dc.b	$7f	; z$05ED
	dc.b	$c9	; z$05EE	RET
	dc.b	$3a	; z$05EF	LD A,($1C13)
	dc.b	$13	; z$05F0
	dc.b	$1c	; z$05F1
	dc.b	$47	; z$05F2	LD B,A
	dc.b	$dd	; z$05F3	LD A,(IX-1A)
	dc.b	$7e	; z$05F4
	dc.b	$00	; z$05F5
	dc.b	$e6	; z$05F6
	dc.b	$20	; z$05F7	JR NZ,z0621
	dc.b	$28	; z$05F8
	dc.b	$03	; z$05F9	INC BC
	dc.b	$3a	; z$05FA	LD A,($1C0B)
	dc.b	$0b	; z$05FB
	dc.b	$1c	; z$05FC
	dc.b	$4f	; z$05FD	LD C,A
	dc.b	$dd	; z$05FE	ADD A,(IX+28)
	dc.b	$86	; z$05FF
	dc.b	$28	; z$0600
	dc.b	$f2	; z$0601	JP P,z0606
	dc.b	$06	; z$0602
	dc.b	$06	; z$0603
	dc.b	$3e	; z$0604	LD A,$7F
	dc.b	$7f	; z$0605
	dc.b	$e6	; z$0606	AND $78
	dc.b	$78	; z$0607
	dc.b	$b8	; z$0608	CP B
	dc.b	$c8	; z$0609	RET Z
	dc.b	$32	; z$060A	LD ($1C13),A
	dc.b	$13	; z$060B
	dc.b	$1c	; z$060C
	dc.b	$0f	; z$060D	RRCA
	dc.b	$0f	; z$060E	RRCA
	dc.b	$0f	; z$060F	RRCA
	dc.b	$f6	; z$0610	OR $F0
	dc.b	$f0	; z$0611
	dc.b	$32	; z$0612	LD ($7F11),A
	dc.b	$11	; z$0613
	dc.b	$7f	; z$0614
	dc.b	$c9	; z$0615	RET
	dc.b	$cd	; z$0616	CALL z0667
	dc.b	$67	; z$0617
	dc.b	$06	; z$0618
	dc.b	$5e	; z$0619	LD E,(HL)
	dc.b	$dd	; z$061A	LD A,(IX-23)
	dc.b	$7e	; z$061B
	dc.b	$02	; z$061C
	dc.b	$dd	; z$061D
	dc.b	$86	; z$061E	ADD A,(HL)
	dc.b	$1c	; z$061F	INC E
	dc.b	$4f	; z$0620	LD C,A
	dc.b	$dd	; z$0621	LD A,(IX-1A)
	dc.b	$7e	; z$0622
	dc.b	$00	; z$0623
	dc.b	$e6	; z$0624
	dc.b	$20	; z$0625	JR NZ,z064F
	dc.b	$28	; z$0626
	dc.b	$03	; z$0627	INC BC
	dc.b	$3a	; z$0628	LD A,($1C0B)
	dc.b	$0b	; z$0629
	dc.b	$1c	; z$062A
	dc.b	$81	; z$062B	ADD A,C
	dc.b	$e2	; z$062C	JP PO,z0631
	dc.b	$31	; z$062D
	dc.b	$06	; z$062E
	dc.b	$3e	; z$062F	LD A,$7F
	dc.b	$7f	; z$0630
	dc.b	$32	; z$0631	LD ($1C08),A
	dc.b	$08	; z$0632
	dc.b	$1c	; z$0633
	dc.b	$dd	; z$0634	PUSH IX
	dc.b	$e5	; z$0635
	dc.b	$e1	; z$0636	POP HL
	dc.b	$01	; z$0637	LD BC,$0028
	dc.b	$28	; z$0638
	dc.b	$00	; z$0639
	dc.b	$09	; z$063A	ADD HL,BC
	dc.b	$50	; z$063B	LD D,B
	dc.b	$4e	; z$063C	LD C,(HL)
	dc.b	$23	; z$063D	INC HL
	dc.b	$cb	; z$063E	RLC A
	dc.b	$3b	; z$063F
	dc.b	$30	; z$0640	JR NC,z065E
	dc.b	$1c	; z$0641
	dc.b	$3a	; z$0642	LD A,($1C08)
	dc.b	$08	; z$0643
	dc.b	$1c	; z$0644
	dc.b	$81	; z$0645	ADD A,C
	dc.b	$f2	; z$0646	JP P,z064B
	dc.b	$4b	; z$0647
	dc.b	$06	; z$0648
	dc.b	$3e	; z$0649	LD A,$7F
	dc.b	$7f	; z$064A
	dc.b	$be	; z$064B	CP (HL)
	dc.b	$28	; z$064C	JR Z,z065E
	dc.b	$10	; z$064D
	dc.b	$77	; z$064E	LD (HL),A
	dc.b	$4f	; z$064F	LD C,A
	dc.b	$7a	; z$0650	LD A,D
	dc.b	$cb	; z$0651	RLC A
	dc.b	$3f	; z$0652
	dc.b	$30	; z$0653	JR NC,z0657
	dc.b	$02	; z$0654
	dc.b	$f6	; z$0655	OR $02
	dc.b	$02	; z$0656
	dc.b	$07	; z$0657	RLCA
	dc.b	$07	; z$0658	RLCA
	dc.b	$f6	; z$0659	OR $40
	dc.b	$40	; z$065A
	dc.b	$cd	; z$065B	CALL z06C7
	dc.b	$c7	; z$065C
	dc.b	$06	; z$065D
	dc.b	$23	; z$065E	INC HL
	dc.b	$23	; z$065F	INC HL
	dc.b	$23	; z$0660	INC HL
	dc.b	$14	; z$0661	INC D
	dc.b	$cb	; z$0662	RRC D
	dc.b	$52	; z$0663
	dc.b	$28	; z$0664	JR Z,z063C
	dc.b	$d6	; z$0665
	dc.b	$c9	; z$0666	RET
	dc.b	$dd	; z$0667	LD A,(IX-1A)
	dc.b	$7e	; z$0668
	dc.b	$24	; z$0669
	dc.b	$e6	; z$066A
	dc.b	$07	; z$066B	RLCA
	dc.b	$c6	; z$066C	ADD A,$74
	dc.b	$74	; z$066D
	dc.b	$6f	; z$066E	LD L,A
	dc.b	$26	; z$066F	LD H,$06
	dc.b	$06	; z$0670
	dc.b	$d0	; z$0671	RET NC
	dc.b	$24	; z$0672	INC H
	dc.b	$c9	; z$0673	RET
	dc.b	$08	; z$0674	EX AF,AF'
	dc.b	$08	; z$0675	EX AF,AF'
	dc.b	$08	; z$0676	EX AF,AF'
	dc.b	$08	; z$0677	EX AF,AF'
	dc.b	$0a	; z$0678	LD A,(BC)
	dc.b	$0e	; z$0679	LD C,$0E
	dc.b	$0e	; z$067A
	dc.b	$0f	; z$067B	RRCA
	dc.b	$32	; z$067C	LD ($1C12),A
	dc.b	$12	; z$067D
	dc.b	$1c	; z$067E
	dc.b	$ed	; z$067F	LDI
	dc.b	$a0	; z$0680
	dc.b	$13	; z$0681	INC DE
	dc.b	$4e	; z$0682	LD C,(HL)
	dc.b	$23	; z$0683	INC HL
	dc.b	$1a	; z$0684	LD A,(DE)
	dc.b	$b9	; z$0685	CP C
	dc.b	$28	; z$0686	JR Z,z068F
	dc.b	$07	; z$0687
	dc.b	$79	; z$0688	LD A,C
	dc.b	$12	; z$0689	LD (DE),A
	dc.b	$06	; z$068A	LD B,$30
	dc.b	$30	; z$068B
	dc.b	$cd	; z$068C	CALL z06C3
	dc.b	$c3	; z$068D
	dc.b	$06	; z$068E
	dc.b	$13	; z$068F	INC DE
	dc.b	$7e	; z$0690	LD A,(HL)
	dc.b	$23	; z$0691	INC HL
	dc.b	$e5	; z$0692	PUSH HL
	dc.b	$6f	; z$0693	LD L,A
	dc.b	$26	; z$0694	LD H,$00
	dc.b	$00	; z$0695
	dc.b	$29	; z$0696	ADD HL,HL
	dc.b	$29	; z$0697	ADD HL,HL
	dc.b	$01	; z$0698	LD BC,$164B
	dc.b	$4b	; z$0699
	dc.b	$16	; z$069A
	dc.b	$09	; z$069B	ADD HL,BC
	dc.b	$4f	; z$069C	LD C,A
	dc.b	$1a	; z$069D	LD A,(DE)
	dc.b	$b9	; z$069E	CP C
	dc.b	$20	; z$069F	JR NZ,z06A7
	dc.b	$06	; z$06A0
	dc.b	$13	; z$06A1	INC DE
	dc.b	$23	; z$06A2	INC HL
	dc.b	$23	; z$06A3	INC HL
	dc.b	$23	; z$06A4	INC HL
	dc.b	$18	; z$06A5	JR z06BF
	dc.b	$18	; z$06A6
	dc.b	$79	; z$06A7	LD A,C
	dc.b	$12	; z$06A8	LD (DE),A
	dc.b	$13	; z$06A9	INC DE
	dc.b	$4e	; z$06AA	LD C,(HL)
	dc.b	$23	; z$06AB	INC HL
	dc.b	$06	; z$06AC	LD B,$50
	dc.b	$50	; z$06AD
	dc.b	$cd	; z$06AE	CALL z06C3
	dc.b	$c3	; z$06AF
	dc.b	$06	; z$06B0
	dc.b	$4e	; z$06B1	LD C,(HL)
	dc.b	$23	; z$06B2	INC HL
	dc.b	$06	; z$06B3	LD B,$60
	dc.b	$60	; z$06B4
	dc.b	$cd	; z$06B5	CALL z06C3
	dc.b	$c3	; z$06B6
	dc.b	$06	; z$06B7
	dc.b	$4e	; z$06B8	LD C,(HL)
	dc.b	$23	; z$06B9	INC HL
	dc.b	$06	; z$06BA	LD B,$70
	dc.b	$70	; z$06BB
	dc.b	$cd	; z$06BC	CALL z06C3
	dc.b	$c3	; z$06BD
	dc.b	$06	; z$06BE
	dc.b	$4e	; z$06BF	LD C,(HL)
	dc.b	$e1	; z$06C0	POP HL
	dc.b	$06	; z$06C1	LD B,$80
	dc.b	$80	; z$06C2
	dc.b	$3a	; z$06C3	LD A,($1C12)
	dc.b	$12	; z$06C4
	dc.b	$1c	; z$06C5
	dc.b	$b0	; z$06C6	OR B
	dc.b	$47	; z$06C7	LD B,A
	dc.b	$3a	; z$06C8	LD A,($1C11)
	dc.b	$11	; z$06C9
	dc.b	$1c	; z$06CA
YM2612Write:
	dc.b	$b0	; z$06CB	OR B
	dc.b	$47	; z$06CC	LD B,A
	dc.b	$3a	; z$06CD	LD A,($1C10)
	dc.b	$10	; z$06CE
	dc.b	$1c	; z$06CF
	dc.b	$e5	; z$06D0	PUSH HL
	dc.b	$6f	; z$06D1	LD L,A
	dc.b	$26	; z$06D2	LD H,$40
	dc.b	$40	; z$06D3
	dc.b	$3a	; z$06D4	LD A,($4000)
	dc.b	$00	; z$06D5
	dc.b	$40	; z$06D6
	dc.b	$b7	; z$06D7	OR A
	dc.b	$fa	; z$06D8	JP M,z06D4
	dc.b	$d4	; z$06D9
	dc.b	$06	; z$06DA
	dc.b	$70	; z$06DB	LD (HL),B
	dc.b	$2c	; z$06DC	INC L
	dc.b	$18	; z$06DD	JR z06DF
	dc.b	$00	; z$06DE
	dc.b	$71	; z$06DF	LD (HL),C
	dc.b	$e1	; z$06E0	POP HL
	dc.b	$c9	; z$06E1	RET
	dc.b	$06	; z$06E2	LD B,$28
	dc.b	$28	; z$06E3
	dc.b	$4f	; z$06E4	LD C,A
	dc.b	$3a	; z$06E5	LD A,($1C11)
	dc.b	$11	; z$06E6
	dc.b	$1c	; z$06E7
	dc.b	$fe	; z$06E8	CP $03
	dc.b	$03	; z$06E9
	dc.b	$ce	; z$06EA	ADC A,$FF
	dc.b	$ff	; z$06EB
	dc.b	$b1	; z$06EC	OR C
	dc.b	$4f	; z$06ED	LD C,A
	dc.b	$3a	; z$06EE	LD A,($1C10)
	dc.b	$10	; z$06EF
	dc.b	$1c	; z$06F0
	dc.b	$cb	; z$06F1	RRC C
	dc.b	$4f	; z$06F2
	dc.b	$28	; z$06F3	JR Z,z06F7
	dc.b	$02	; z$06F4
	dc.b	$cb	; z$06F5	RR D
	dc.b	$d1	; z$06F6
YM2612WriteRegs:
	dc.b	$3a	; z$06F7	LD A,($4000)
	dc.b	$00	; z$06F8
	dc.b	$40	; z$06F9
	dc.b	$b7	; z$06FA	OR A
	dc.b	$fa	; z$06FB	JP M,z06F7
	dc.b	$f7	; z$06FC
	dc.b	$06	; z$06FD
	dc.b	$78	; z$06FE	LD A,B
	dc.b	$32	; z$06FF	LD ($4000),A
	dc.b	$00	; z$0700
	dc.b	$40	; z$0701
	dc.b	$18	; z$0702	JR z0704
	dc.b	$00	; z$0703
	dc.b	$18	; z$0704	JR z0706
	dc.b	$00	; z$0705
	dc.b	$79	; z$0706	LD A,C
	dc.b	$32	; z$0707	LD ($4001),A
	dc.b	$01	; z$0708
	dc.b	$40	; z$0709
	dc.b	$c9	; z$070A	RET
Z80ChannelLoop:
	dc.b	$dd	; z$070B	LD IX,$1C80
	dc.b	$21	; z$070C
	dc.b	$80	; z$070D
	dc.b	$1c	; z$070E
	dc.b	$af	; z$070F	XOR A
	dc.b	$32	; z$0710	LD ($1BF6),A
	dc.b	$f6	; z$0711
	dc.b	$1b	; z$0712
	dc.b	$32	; z$0713	LD ($1C11),A
	dc.b	$11	; z$0714
	dc.b	$1c	; z$0715
	dc.b	$af	; z$0716	XOR A
	dc.b	$32	; z$0717	LD ($1C10),A
	dc.b	$10	; z$0718
	dc.b	$1c	; z$0719
	dc.b	$dd	; z$071A	RRC (IX+0)
	dc.b	$cb	; z$071B
	dc.b	$00	; z$071C
	dc.b	$7e	; z$071D
	dc.b	$c4	; z$071E	CALL NZ,z0756
	dc.b	$56	; z$071F
	dc.b	$07	; z$0720
	dc.b	$11	; z$0721	LD DE,$0040
	dc.b	$40	; z$0722
	dc.b	$00	; z$0723
	dc.b	$dd	; z$0724	ADD IX,DE
	dc.b	$19	; z$0725
	dc.b	$21	; z$0726	LD HL,$1BF6
	dc.b	$f6	; z$0727
	dc.b	$1b	; z$0728
	dc.b	$34	; z$0729	INC (HL)
	dc.b	$3a	; z$072A	LD A,($1C10)
	dc.b	$10	; z$072B
	dc.b	$1c	; z$072C
	dc.b	$ee	; z$072D	XOR $02
	dc.b	$02	; z$072E
	dc.b	$20	; z$072F	JR NZ,z0717
	dc.b	$e6	; z$0730
	dc.b	$3a	; z$0731	LD A,($1C11)
	dc.b	$11	; z$0732
	dc.b	$1c	; z$0733
	dc.b	$3c	; z$0734	INC A
	dc.b	$fe	; z$0735	CP $03
	dc.b	$03	; z$0736
	dc.b	$38	; z$0737	JR C,z0713
	dc.b	$da	; z$0738
	dc.b	$af	; z$0739	XOR A
	dc.b	$32	; z$073A	LD ($1C11),A
	dc.b	$11	; z$073B
	dc.b	$1c	; z$073C
	dc.b	$dd	; z$073D	RRC (IX+0)
	dc.b	$cb	; z$073E
	dc.b	$00	; z$073F
	dc.b	$7e	; z$0740
	dc.b	$c4	; z$0741	CALL NZ,z0756
	dc.b	$56	; z$0742
	dc.b	$07	; z$0743
	dc.b	$11	; z$0744	LD DE,$0040
	dc.b	$40	; z$0745
	dc.b	$00	; z$0746
	dc.b	$dd	; z$0747	ADD IX,DE
	dc.b	$19	; z$0748
	dc.b	$21	; z$0749	LD HL,$1BF6
	dc.b	$f6	; z$074A
	dc.b	$1b	; z$074B
	dc.b	$34	; z$074C	INC (HL)
	dc.b	$3a	; z$074D	LD A,($1C11)
	dc.b	$11	; z$074E
	dc.b	$1c	; z$074F
	dc.b	$3c	; z$0750	INC A
	dc.b	$fe	; z$0751	CP $03
	dc.b	$03	; z$0752
	dc.b	$38	; z$0753	JR C,z073A
	dc.b	$e5	; z$0754
	dc.b	$c9	; z$0755	RET
	dc.b	$dd	; z$0756	RRC (IX+0)
	dc.b	$cb	; z$0757
	dc.b	$00	; z$0758
	dc.b	$76	; z$0759
	dc.b	$20	; z$075A	JR NZ,z0772
	dc.b	$16	; z$075B
	dc.b	$dd	; z$075C	RR (IX+0)
	dc.b	$cb	; z$075D
	dc.b	$00	; z$075E
	dc.b	$f6	; z$075F
	dc.b	$21	; z$0760	LD HL,$0772
	dc.b	$72	; z$0761
	dc.b	$07	; z$0762
	dc.b	$e5	; z$0763	PUSH HL
	dc.b	$dd	; z$0764	LD A,(IX-2A)
	dc.b	$7e	; z$0765
	dc.b	$01	; z$0766
	dc.b	$d6	; z$0767
	dc.b	$02	; z$0768	LD (BC),A
	dc.b	$da	; z$0769	JP C,z0A08
	dc.b	$08	; z$076A
	dc.b	$0a	; z$076B
	dc.b	$ca	; z$076C	JP Z,z0AB2
	dc.b	$b2	; z$076D
	dc.b	$0a	; z$076E
	dc.b	$c3	; z$076F	JP z0AA9
	dc.b	$a9	; z$0770
	dc.b	$0a	; z$0771
	dc.b	$3e	; z$0772	LD A,$01
	dc.b	$01	; z$0773
	dc.b	$dd	; z$0774	RRC (IX+0)
	dc.b	$cb	; z$0775
	dc.b	$00	; z$0776
	dc.b	$6e	; z$0777
	dc.b	$28	; z$0778	JR Z,z077D
	dc.b	$03	; z$0779
	dc.b	$3a	; z$077A	LD A,($1C17)
	dc.b	$17	; z$077B
	dc.b	$1c	; z$077C
	dc.b	$dd	; z$077D	ADD A,(IX+3C)
	dc.b	$86	; z$077E
	dc.b	$3c	; z$077F
	dc.b	$dd	; z$0780	LD (IX+30),A
	dc.b	$77	; z$0781
	dc.b	$3c	; z$0782
	dc.b	$30	; z$0783
	dc.b	$1d	; z$0784	DEC E
	dc.b	$dd	; z$0785	INC (IX-36)
	dc.b	$34	; z$0786
	dc.b	$3d	; z$0787
	dc.b	$ca	; z$0788
	dc.b	$60	; z$0789	LD H,B
	dc.b	$04	; z$078A	INC B
	dc.b	$e2	; z$078B	JP PO,z07A2
	dc.b	$a2	; z$078C
	dc.b	$07	; z$078D
	dc.b	$dd	; z$078E	RR (IX+0)
	dc.b	$cb	; z$078F
	dc.b	$00	; z$0790
	dc.b	$c6	; z$0791
	dc.b	$dd	; z$0792	LD A,(IX-49)
	dc.b	$7e	; z$0793
	dc.b	$01	; z$0794
	dc.b	$b7	; z$0795
	dc.b	$20	; z$0796	JR NZ,z079B
	dc.b	$03	; z$0797
	dc.b	$c3	; z$0798	JP z06E2
	dc.b	$e2	; z$0799
	dc.b	$06	; z$079A
	dc.b	$dd	; z$079B	LD A,(IX-49)
	dc.b	$7e	; z$079C
	dc.b	$01	; z$079D
	dc.b	$b7	; z$079E
	dc.b	$cc	; z$079F	CALL Z,z06E2
	dc.b	$e2	; z$07A0
	dc.b	$06	; z$07A1
	dc.b	$dd	; z$07A2	DEC (IX-3E)
	dc.b	$35	; z$07A3
	dc.b	$3b	; z$07A4
	dc.b	$c2	; z$07A5
	dc.b	$6d	; z$07A6	LD L,L
	dc.b	$08	; z$07A7	EX AF,AF'
	dc.b	$dd	; z$07A8	LD A,(IX-23)
	dc.b	$7e	; z$07A9
	dc.b	$3a	; z$07AA
	dc.b	$dd	; z$07AB
	dc.b	$77	; z$07AC	LD (HL),A
	dc.b	$3b	; z$07AD	DEC SP
	dc.b	$dd	; z$07AE	LD A,(IX-23)
	dc.b	$7e	; z$07AF
	dc.b	$14	; z$07B0
	dc.b	$dd	; z$07B1
	dc.b	$86	; z$07B2	ADD A,(HL)
	dc.b	$16	; z$07B3	LD D,$DD
	dc.b	$dd	; z$07B4
	dc.b	$77	; z$07B5	LD (HL),A
	dc.b	$14	; z$07B6	INC D
	dc.b	$dd	; z$07B7	LD A,(IX-23)
	dc.b	$7e	; z$07B8
	dc.b	$15	; z$07B9
	dc.b	$dd	; z$07BA
	dc.b	$8e	; z$07BB	ADC A,(HL)
	dc.b	$17	; z$07BC	RLA
	dc.b	$dd	; z$07BD	LD (IX-23),A
	dc.b	$77	; z$07BE
	dc.b	$15	; z$07BF
	dc.b	$dd	; z$07C0
	dc.b	$7e	; z$07C1	LD A,(HL)
	dc.b	$0e	; z$07C2	LD C,$B7
	dc.b	$b7	; z$07C3
	dc.b	$ca	; z$07C4	JP Z,z086D
	dc.b	$6d	; z$07C5
	dc.b	$08	; z$07C6
	dc.b	$dd	; z$07C7	DEC (IX-3E)
	dc.b	$35	; z$07C8
	dc.b	$0e	; z$07C9
	dc.b	$c2	; z$07CA
	dc.b	$6d	; z$07CB	LD L,L
	dc.b	$08	; z$07CC	EX AF,AF'
	dc.b	$dd	; z$07CD	LD (IX+3F),$00
	dc.b	$36	; z$07CE
	dc.b	$3f	; z$07CF
	dc.b	$00	; z$07D0
	dc.b	$dd	; z$07D1	LD L,(IX-23)
	dc.b	$6e	; z$07D2
	dc.b	$10	; z$07D3
	dc.b	$dd	; z$07D4
	dc.b	$66	; z$07D5	LD H,(HL)
	dc.b	$11	; z$07D6	LD DE,$237E
	dc.b	$7e	; z$07D7
	dc.b	$23	; z$07D8
	dc.b	$b7	; z$07D9	OR A
	dc.b	$ca	; z$07DA	JP Z,z086D
	dc.b	$6d	; z$07DB
	dc.b	$08	; z$07DC
	dc.b	$fe	; z$07DD	CP $F8
	dc.b	$f8	; z$07DE
	dc.b	$38	; z$07DF	JR C,z085A
	dc.b	$79	; z$07E0
	dc.b	$2f	; z$07E1	CPL
	dc.b	$3d	; z$07E2	DEC A
	dc.b	$f2	; z$07E3	JP P,z07EC
	dc.b	$ec	; z$07E4
	dc.b	$07	; z$07E5
	dc.b	$7e	; z$07E6	LD A,(HL)
	dc.b	$23	; z$07E7	INC HL
	dc.b	$66	; z$07E8	LD H,(HL)
	dc.b	$6f	; z$07E9	LD L,A
	dc.b	$18	; z$07EA	JR z07D7
	dc.b	$eb	; z$07EB
	dc.b	$20	; z$07EC	JR NZ,z07FB
	dc.b	$0d	; z$07ED
	dc.b	$dd	; z$07EE	DEC (IX+28)
	dc.b	$35	; z$07EF
	dc.b	$0f	; z$07F0
	dc.b	$28	; z$07F1
	dc.b	$e4	; z$07F2	CALL PO,z6EDD
	dc.b	$dd	; z$07F3
	dc.b	$6e	; z$07F4
	dc.b	$12	; z$07F5	LD (DE),A
	dc.b	$dd	; z$07F6	LD H,(IX+18)
	dc.b	$66	; z$07F7
	dc.b	$13	; z$07F8
	dc.b	$18	; z$07F9
	dc.b	$dc	; z$07FA	CALL C,z203D
	dc.b	$3d	; z$07FB
	dc.b	$20	; z$07FC
	dc.b	$0d	; z$07FD	DEC C
	dc.b	$7e	; z$07FE	LD A,(HL)
	dc.b	$23	; z$07FF	INC HL
	dc.b	$dd	; z$0800	LD (IX-23),A
	dc.b	$77	; z$0801
	dc.b	$0f	; z$0802
	dc.b	$dd	; z$0803
	dc.b	$75	; z$0804	LD (HL),L
	dc.b	$12	; z$0805	LD (DE),A
	dc.b	$dd	; z$0806	LD (IX+18),H
	dc.b	$74	; z$0807
	dc.b	$13	; z$0808
	dc.b	$18	; z$0809
	dc.b	$cc	; z$080A	CALL Z,z203D
	dc.b	$3d	; z$080B
	dc.b	$20	; z$080C
	dc.b	$12	; z$080D	LD (DE),A
	dc.b	$dd	; z$080E	SUB (IX+16)
	dc.b	$96	; z$080F
	dc.b	$16	; z$0810
	dc.b	$dd	; z$0811	LD (IX+3E),A
	dc.b	$77	; z$0812
	dc.b	$16	; z$0813
	dc.b	$3e	; z$0814
	dc.b	$00	; z$0815	NOP
	dc.b	$dd	; z$0816	SBC A,(IX+17)
	dc.b	$9e	; z$0817
	dc.b	$17	; z$0818
	dc.b	$dd	; z$0819	LD (IX+7E),A
	dc.b	$77	; z$081A
	dc.b	$17	; z$081B
	dc.b	$7e	; z$081C
	dc.b	$23	; z$081D	INC HL
	dc.b	$18	; z$081E	JR z0864
	dc.b	$44	; z$081F
	dc.b	$3d	; z$0820	DEC A
	dc.b	$20	; z$0821	JR NZ,z082F
	dc.b	$0c	; z$0822
	dc.b	$7e	; z$0823	LD A,(HL)
	dc.b	$23	; z$0824	INC HL
	dc.b	$dd	; z$0825	LD (IX+7E),A
	dc.b	$77	; z$0826
	dc.b	$14	; z$0827
	dc.b	$7e	; z$0828
	dc.b	$23	; z$0829	INC HL
	dc.b	$dd	; z$082A	LD (IX+18),A
	dc.b	$77	; z$082B
	dc.b	$15	; z$082C
	dc.b	$18	; z$082D
	dc.b	$a8	; z$082E	XOR B
	dc.b	$3d	; z$082F	DEC A
	dc.b	$20	; z$0830	JR NZ,z083D
	dc.b	$0b	; z$0831
	dc.b	$dd	; z$0832	LD (IX-23),A
	dc.b	$77	; z$0833
	dc.b	$16	; z$0834
	dc.b	$dd	; z$0835
	dc.b	$77	; z$0836	LD (HL),A
	dc.b	$17	; z$0837	RLA
	dc.b	$dd	; z$0838	LD (IX+18),A
	dc.b	$77	; z$0839
	dc.b	$0e	; z$083A
	dc.b	$18	; z$083B
	dc.b	$30	; z$083C	JR NC,z087B
	dc.b	$3d	; z$083D
	dc.b	$20	; z$083E	JR NZ,z084A
	dc.b	$0a	; z$083F
	dc.b	$7e	; z$0840	LD A,(HL)
	dc.b	$23	; z$0841	INC HL
	dc.b	$dd	; z$0842	LD (IX-23),A
	dc.b	$77	; z$0843
	dc.b	$3b	; z$0844
	dc.b	$dd	; z$0845
	dc.b	$77	; z$0846	LD (HL),A
	dc.b	$3a	; z$0847	LD A,($8D18)
	dc.b	$18	; z$0848
	dc.b	$8d	; z$0849
	dc.b	$af	; z$084A	XOR A
	dc.b	$dd	; z$084B	LD (IX-23),A
	dc.b	$77	; z$084C
	dc.b	$16	; z$084D
	dc.b	$dd	; z$084E
	dc.b	$77	; z$084F	LD (HL),A
	dc.b	$17	; z$0850	RLA
	dc.b	$7e	; z$0851	LD A,(HL)
	dc.b	$23	; z$0852	INC HL
	dc.b	$dd	; z$0853	LD (IX+7E),A
	dc.b	$77	; z$0854
	dc.b	$3f	; z$0855
	dc.b	$7e	; z$0856
	dc.b	$23	; z$0857	INC HL
	dc.b	$18	; z$0858	JR z0864
	dc.b	$0a	; z$0859
	dc.b	$4e	; z$085A	LD C,(HL)
	dc.b	$23	; z$085B	INC HL
	dc.b	$dd	; z$085C	LD (IX+4E),C
	dc.b	$71	; z$085D
	dc.b	$16	; z$085E
	dc.b	$4e	; z$085F
	dc.b	$23	; z$0860	INC HL
	dc.b	$dd	; z$0861	LD (IX-23),C
	dc.b	$71	; z$0862
	dc.b	$17	; z$0863
	dc.b	$dd	; z$0864
	dc.b	$77	; z$0865	LD (HL),A
	dc.b	$0e	; z$0866	LD C,$DD
	dc.b	$dd	; z$0867
	dc.b	$75	; z$0868	LD (HL),L
	dc.b	$10	; z$0869	DJNZ z0848
	dc.b	$dd	; z$086A
	dc.b	$74	; z$086B	LD (HL),H
	dc.b	$11	; z$086C	LD DE,$6EDD
	dc.b	$dd	; z$086D
	dc.b	$6e	; z$086E
	dc.b	$0c	; z$086F	INC C
	dc.b	$dd	; z$0870	LD H,(IX-23)
	dc.b	$66	; z$0871
	dc.b	$0d	; z$0872
	dc.b	$dd	; z$0873
	dc.b	$cb	; z$0874	RLC B
	dc.b	$00	; z$0875
	dc.b	$66	; z$0876	LD H,(HL)
	dc.b	$28	; z$0877	JR Z,z08A0
	dc.b	$27	; z$0878
	dc.b	$dd	; z$0879	LD C,(IX-23)
	dc.b	$4e	; z$087A
	dc.b	$1a	; z$087B
	dc.b	$dd	; z$087C
	dc.b	$46	; z$087D	LD B,(HL)
	dc.b	$1b	; z$087E	DEC DE
	dc.b	$09	; z$087F	ADD HL,BC
	dc.b	$dd	; z$0880	LD E,(IX-23)
	dc.b	$5e	; z$0881
	dc.b	$18	; z$0882
	dc.b	$dd	; z$0883
	dc.b	$56	; z$0884	LD D,(HL)
	dc.b	$19	; z$0885	ADD HL,DE
	dc.b	$7c	; z$0886	LD A,H
	dc.b	$ba	; z$0887	CP D
	dc.b	$20	; z$0888	JR NZ,z088E
	dc.b	$04	; z$0889
	dc.b	$7d	; z$088A	LD A,L
	dc.b	$bb	; z$088B	CP E
	dc.b	$28	; z$088C	JR Z,z0896
	dc.b	$08	; z$088D
	dc.b	$cb	; z$088E	RRC A
	dc.b	$78	; z$088F
	dc.b	$28	; z$0890	JR Z,z0893
	dc.b	$01	; z$0891
	dc.b	$3f	; z$0892	CCF
	dc.b	$38	; z$0893	JR C,z089A
	dc.b	$05	; z$0894
	dc.b	$eb	; z$0895	EX DE,HL
	dc.b	$dd	; z$0896	RL (IX+0)
	dc.b	$cb	; z$0897
	dc.b	$00	; z$0898
	dc.b	$a6	; z$0899
	dc.b	$dd	; z$089A	LD (IX-23),L
	dc.b	$75	; z$089B
	dc.b	$0c	; z$089C
	dc.b	$dd	; z$089D
	dc.b	$74	; z$089E	LD (HL),H
	dc.b	$0d	; z$089F	DEC C
	dc.b	$dd	; z$08A0	LD A,(IX-49)
	dc.b	$7e	; z$08A1
	dc.b	$3f	; z$08A2
	dc.b	$b7	; z$08A3
	dc.b	$28	; z$08A4	JR Z,z08B9
	dc.b	$13	; z$08A5
	dc.b	$47	; z$08A6	LD B,A
	dc.b	$e5	; z$08A7	PUSH HL
	dc.b	$cd	; z$08A8	CALL z0B66
	dc.b	$66	; z$08A9
	dc.b	$0b	; z$08AA
	dc.b	$d1	; z$08AB	POP DE
	dc.b	$6f	; z$08AC	LD L,A
	dc.b	$e6	; z$08AD	AND $80
	dc.b	$80	; z$08AE
	dc.b	$28	; z$08AF	JR Z,z08B3
	dc.b	$02	; z$08B0
	dc.b	$3e	; z$08B1	LD A,$FF
	dc.b	$ff	; z$08B2
	dc.b	$67	; z$08B3	LD H,A
	dc.b	$29	; z$08B4	ADD HL,HL
	dc.b	$10	; z$08B5	DJNZ z08B4
	dc.b	$fd	; z$08B6
	dc.b	$18	; z$08B7	JR z08BF
	dc.b	$06	; z$08B8
	dc.b	$dd	; z$08B9	LD E,(IX-23)
	dc.b	$5e	; z$08BA
	dc.b	$14	; z$08BB
	dc.b	$dd	; z$08BC
	dc.b	$56	; z$08BD	LD D,(HL)
	dc.b	$15	; z$08BE	DEC D
	dc.b	$19	; z$08BF	ADD HL,DE
	dc.b	$dd	; z$08C0	LD E,(IX-23)
	dc.b	$5e	; z$08C1
	dc.b	$26	; z$08C2
	dc.b	$dd	; z$08C3
	dc.b	$56	; z$08C4	LD D,(HL)
	dc.b	$27	; z$08C5	DAA
	dc.b	$19	; z$08C6	ADD HL,DE
	dc.b	$dd	; z$08C7	LD (IX-23),L
	dc.b	$75	; z$08C8
	dc.b	$08	; z$08C9
	dc.b	$dd	; z$08CA
	dc.b	$74	; z$08CB	LD (HL),H
	dc.b	$09	; z$08CC	ADD HL,BC
	dc.b	$dd	; z$08CD	DEC (IX-3E)
	dc.b	$35	; z$08CE
	dc.b	$39	; z$08CF
	dc.b	$c2	; z$08D0
	dc.b	$62	; z$08D1	LD H,D
	dc.b	$09	; z$08D2	ADD HL,BC
	dc.b	$dd	; z$08D3	LD A,(IX-23)
	dc.b	$7e	; z$08D4
	dc.b	$38	; z$08D5
	dc.b	$dd	; z$08D6
	dc.b	$77	; z$08D7	LD (HL),A
	dc.b	$39	; z$08D8	ADD HL,SP
	dc.b	$dd	; z$08D9	LD A,(IX-23)
	dc.b	$7e	; z$08DA
	dc.b	$1c	; z$08DB
	dc.b	$dd	; z$08DC
	dc.b	$86	; z$08DD	ADD A,(HL)
	dc.b	$1d	; z$08DE	DEC E
	dc.b	$dd	; z$08DF	LD (IX-23),A
	dc.b	$77	; z$08E0
	dc.b	$1c	; z$08E1
	dc.b	$dd	; z$08E2
	dc.b	$7e	; z$08E3	LD A,(HL)
	dc.b	$1e	; z$08E4	LD E,$B7
	dc.b	$b7	; z$08E5
	dc.b	$28	; z$08E6	JR Z,z0962
	dc.b	$7a	; z$08E7
	dc.b	$dd	; z$08E8	DEC (IX+20)
	dc.b	$35	; z$08E9
	dc.b	$1e	; z$08EA
	dc.b	$20	; z$08EB
	dc.b	$75	; z$08EC	LD (HL),L
	dc.b	$dd	; z$08ED	LD L,(IX-23)
	dc.b	$6e	; z$08EE
	dc.b	$20	; z$08EF
	dc.b	$dd	; z$08F0
	dc.b	$66	; z$08F1	LD H,(HL)
	dc.b	$21	; z$08F2	LD HL,$237E
	dc.b	$7e	; z$08F3
	dc.b	$23	; z$08F4
	dc.b	$b7	; z$08F5	OR A
	dc.b	$28	; z$08F6	JR Z,z0962
	dc.b	$6a	; z$08F7
	dc.b	$fe	; z$08F8	CP $F9
	dc.b	$f9	; z$08F9
	dc.b	$38	; z$08FA	JR C,z0954
	dc.b	$58	; z$08FB
	dc.b	$2f	; z$08FC	CPL
	dc.b	$3d	; z$08FD	DEC A
	dc.b	$f2	; z$08FE	JP P,z0907
	dc.b	$07	; z$08FF
	dc.b	$09	; z$0900
	dc.b	$7e	; z$0901	LD A,(HL)
	dc.b	$23	; z$0902	INC HL
	dc.b	$66	; z$0903	LD H,(HL)
	dc.b	$6f	; z$0904	LD L,A
	dc.b	$18	; z$0905	JR z08F3
	dc.b	$ec	; z$0906
	dc.b	$20	; z$0907	JR NZ,z0916
	dc.b	$0d	; z$0908
	dc.b	$dd	; z$0909	DEC (IX+28)
	dc.b	$35	; z$090A
	dc.b	$1f	; z$090B
	dc.b	$28	; z$090C
	dc.b	$e5	; z$090D	PUSH HL
	dc.b	$dd	; z$090E	LD L,(IX-23)
	dc.b	$6e	; z$090F
	dc.b	$22	; z$0910
	dc.b	$dd	; z$0911
	dc.b	$66	; z$0912	LD H,(HL)
	dc.b	$23	; z$0913	INC HL
	dc.b	$18	; z$0914	JR z08F3
	dc.b	$dd	; z$0915
	dc.b	$3d	; z$0916	DEC A
	dc.b	$20	; z$0917	JR NZ,z0926
	dc.b	$0d	; z$0918
	dc.b	$7e	; z$0919	LD A,(HL)
	dc.b	$23	; z$091A	INC HL
	dc.b	$dd	; z$091B	LD (IX-23),A
	dc.b	$77	; z$091C
	dc.b	$1f	; z$091D
	dc.b	$dd	; z$091E
	dc.b	$75	; z$091F	LD (HL),L
	dc.b	$22	; z$0920	LD ($74DD),HL
	dc.b	$dd	; z$0921
	dc.b	$74	; z$0922
	dc.b	$23	; z$0923	INC HL
	dc.b	$18	; z$0924	JR z08F3
	dc.b	$cd	; z$0925
	dc.b	$3d	; z$0926	DEC A
	dc.b	$20	; z$0927	JR NZ,z0934
	dc.b	$0b	; z$0928
	dc.b	$af	; z$0929	XOR A
	dc.b	$dd	; z$092A	SUB (IX+1D)
	dc.b	$96	; z$092B
	dc.b	$1d	; z$092C
	dc.b	$dd	; z$092D	LD (IX+7E),A
	dc.b	$77	; z$092E
	dc.b	$1d	; z$092F
	dc.b	$7e	; z$0930
	dc.b	$23	; z$0931	INC HL
	dc.b	$18	; z$0932	JR z0959
	dc.b	$25	; z$0933
	dc.b	$3d	; z$0934	DEC A
	dc.b	$20	; z$0935	JR NZ,z093E
	dc.b	$07	; z$0936
	dc.b	$7e	; z$0937	LD A,(HL)
	dc.b	$23	; z$0938	INC HL
	dc.b	$dd	; z$0939	LD (IX+18),A
	dc.b	$77	; z$093A
	dc.b	$1c	; z$093B
	dc.b	$18	; z$093C
	dc.b	$b5	; z$093D	OR L
	dc.b	$3d	; z$093E	DEC A
	dc.b	$20	; z$093F	JR NZ,z094A
	dc.b	$09	; z$0940
	dc.b	$af	; z$0941	XOR A
	dc.b	$dd	; z$0942	LD (IX-23),A
	dc.b	$77	; z$0943
	dc.b	$1d	; z$0944
	dc.b	$dd	; z$0945
	dc.b	$77	; z$0946	LD (HL),A
	dc.b	$1e	; z$0947	LD E,$18
	dc.b	$18	; z$0948
	dc.b	$18	; z$0949	JR z09C9
	dc.b	$7e	; z$094A
	dc.b	$23	; z$094B	INC HL
	dc.b	$dd	; z$094C	LD (IX-23),A
	dc.b	$77	; z$094D
	dc.b	$39	; z$094E
	dc.b	$dd	; z$094F
	dc.b	$77	; z$0950	LD (HL),A
	dc.b	$38	; z$0951	JR C,z096B
	dc.b	$18	; z$0952
	dc.b	$9f	; z$0953	SBC A,A
	dc.b	$4e	; z$0954	LD C,(HL)
	dc.b	$23	; z$0955	INC HL
	dc.b	$dd	; z$0956	LD (IX-23),C
	dc.b	$71	; z$0957
	dc.b	$1d	; z$0958
	dc.b	$dd	; z$0959
	dc.b	$77	; z$095A	LD (HL),A
	dc.b	$1e	; z$095B	LD E,$DD
	dc.b	$dd	; z$095C
	dc.b	$75	; z$095D	LD (HL),L
	dc.b	$20	; z$095E	JR NZ,z093D
	dc.b	$dd	; z$095F
	dc.b	$74	; z$0960	LD (HL),H
	dc.b	$21	; z$0961	LD HL,$7EDD
	dc.b	$dd	; z$0962
	dc.b	$7e	; z$0963
	dc.b	$01	; z$0964	LD BC,$28B7
	dc.b	$b7	; z$0965
	dc.b	$28	; z$0966
	dc.b	$08	; z$0967	EX AF,AF'
	dc.b	$cd	; z$0968	CALL z0976
	dc.b	$76	; z$0969
	dc.b	$09	; z$096A
	dc.b	$dd	; z$096B	RRC (IX+0)
	dc.b	$cb	; z$096C
	dc.b	$00	; z$096D
	dc.b	$7e	; z$096E
	dc.b	$c8	; z$096F	RET Z
	dc.b	$cd	; z$0970	CALL z053C
	dc.b	$3c	; z$0971
	dc.b	$05	; z$0972
	dc.b	$c3	; z$0973	JP z05BA
	dc.b	$ba	; z$0974
	dc.b	$05	; z$0975
	dc.b	$dd	; z$0976	RRC (IX+0)
	dc.b	$cb	; z$0977
	dc.b	$00	; z$0978
	dc.b	$4e	; z$0979
	dc.b	$20	; z$097A	JR NZ,z0997
	dc.b	$1b	; z$097B
	dc.b	$dd	; z$097C	RRC (IX+0)
	dc.b	$cb	; z$097D
	dc.b	$00	; z$097E
	dc.b	$46	; z$097F
	dc.b	$28	; z$0980	JR Z,z09CB
	dc.b	$49	; z$0981
	dc.b	$dd	; z$0982	RR (IX+0)
	dc.b	$cb	; z$0983
	dc.b	$00	; z$0984
	dc.b	$ce	; z$0985
	dc.b	$dd	; z$0986	LD A,(IX-49)
	dc.b	$7e	; z$0987
	dc.b	$2f	; z$0988
	dc.b	$b7	; z$0989
	dc.b	$28	; z$098A	JR Z,z09A2
	dc.b	$16	; z$098B
	dc.b	$dd	; z$098C	CP (IX+30)
	dc.b	$be	; z$098D
	dc.b	$30	; z$098E
	dc.b	$30	; z$098F	JR NC,z09A2
	dc.b	$11	; z$0990
	dc.b	$dd	; z$0991	RR (IX+0)
	dc.b	$cb	; z$0992
	dc.b	$00	; z$0993
	dc.b	$d6	; z$0994
	dc.b	$18	; z$0995	JR z09FE
	dc.b	$67	; z$0996
	dc.b	$dd	; z$0997	RRC (IX+0)
	dc.b	$cb	; z$0998
	dc.b	$00	; z$0999
	dc.b	$56	; z$099A
	dc.b	$20	; z$099B	JR NZ,z09FE
	dc.b	$61	; z$099C
	dc.b	$dd	; z$099D	DEC (IX+20)
	dc.b	$35	; z$099E
	dc.b	$2c	; z$099F
	dc.b	$20	; z$09A0
	dc.b	$5c	; z$09A1	LD E,H
	dc.b	$dd	; z$09A2	LD A,(IX-23)
	dc.b	$7e	; z$09A3
	dc.b	$30	; z$09A4
	dc.b	$dd	; z$09A5
	dc.b	$86	; z$09A6	ADD A,(HL)
	dc.b	$2e	; z$09A7	LD L,$DD
	dc.b	$dd	; z$09A8
	dc.b	$4e	; z$09A9	LD C,(HL)
	dc.b	$2f	; z$09AA	CPL
	dc.b	$0c	; z$09AB	INC C
	dc.b	$0d	; z$09AC	DEC C
	dc.b	$20	; z$09AD	JR NZ,z09B5
	dc.b	$06	; z$09AE
	dc.b	$b7	; z$09AF	OR A
	dc.b	$fa	; z$09B0	JP M,z0460
	dc.b	$60	; z$09B1
	dc.b	$04	; z$09B2
	dc.b	$18	; z$09B3	JR z09C3
	dc.b	$0e	; z$09B4
	dc.b	$b7	; z$09B5	OR A
	dc.b	$f2	; z$09B6	JP P,z09BB
	dc.b	$bb	; z$09B7
	dc.b	$09	; z$09B8
	dc.b	$18	; z$09B9	JR z09BE
	dc.b	$03	; z$09BA
	dc.b	$b9	; z$09BB	CP C
	dc.b	$38	; z$09BC	JR C,z09C3
	dc.b	$05	; z$09BD
	dc.b	$79	; z$09BE	LD A,C
	dc.b	$dd	; z$09BF	RR (IX+0)
	dc.b	$cb	; z$09C0
	dc.b	$00	; z$09C1
	dc.b	$d6	; z$09C2
	dc.b	$dd	; z$09C3	LD C,(IX-23)
	dc.b	$4e	; z$09C4
	dc.b	$2d	; z$09C5
	dc.b	$dd	; z$09C6
	dc.b	$71	; z$09C7	LD (HL),C
	dc.b	$2c	; z$09C8	INC L
	dc.b	$18	; z$09C9	JR z09FB
	dc.b	$30	; z$09CA
	dc.b	$dd	; z$09CB	LD A,(IX-49)
	dc.b	$7e	; z$09CC
	dc.b	$2c	; z$09CD
	dc.b	$b7	; z$09CE
	dc.b	$28	; z$09CF	JR Z,z09FE
	dc.b	$2d	; z$09D0
	dc.b	$dd	; z$09D1	DEC (IX+20)
	dc.b	$35	; z$09D2
	dc.b	$2c	; z$09D3
	dc.b	$20	; z$09D4
	dc.b	$28	; z$09D5	JR Z,z09B4
	dc.b	$dd	; z$09D6
	dc.b	$6e	; z$09D7	LD L,(HL)
	dc.b	$2a	; z$09D8	LD HL,($66DD)
	dc.b	$dd	; z$09D9
	dc.b	$66	; z$09DA
	dc.b	$2b	; z$09DB	DEC HL
	dc.b	$7e	; z$09DC	LD A,(HL)
	dc.b	$fe	; z$09DD	CP $F0
	dc.b	$f0	; z$09DE
	dc.b	$ca	; z$09DF	JP Z,z0460
	dc.b	$60	; z$09E0
	dc.b	$04	; z$09E1
	dc.b	$23	; z$09E2	INC HL
	dc.b	$4f	; z$09E3	LD C,A
	dc.b	$e6	; z$09E4	AND $0F
	dc.b	$0f	; z$09E5
	dc.b	$dd	; z$09E6	LD (IX-23),A
	dc.b	$77	; z$09E7
	dc.b	$2c	; z$09E8
	dc.b	$dd	; z$09E9
	dc.b	$75	; z$09EA	LD (HL),L
	dc.b	$2a	; z$09EB	LD HL,($74DD)
	dc.b	$dd	; z$09EC
	dc.b	$74	; z$09ED
	dc.b	$2b	; z$09EE	DEC HL
	dc.b	$79	; z$09EF	LD A,C
	dc.b	$0f	; z$09F0	RRCA
	dc.b	$e6	; z$09F1	AND $78
	dc.b	$78	; z$09F2
	dc.b	$dd	; z$09F3	ADD A,(IX+2)
	dc.b	$86	; z$09F4
	dc.b	$02	; z$09F5
	dc.b	$f2	; z$09F6	JP P,z09FB
	dc.b	$fb	; z$09F7
	dc.b	$09	; z$09F8
	dc.b	$3e	; z$09F9	LD A,$7F
	dc.b	$7f	; z$09FA
	dc.b	$dd	; z$09FB	LD (IX-23),A
	dc.b	$77	; z$09FC
	dc.b	$30	; z$09FD
	dc.b	$dd	; z$09FE
	dc.b	$7e	; z$09FF	LD A,(HL)
	dc.b	$30	; z$0A00	JR NC,z09DF
	dc.b	$dd	; z$0A01
	dc.b	$86	; z$0A02	ADD A,(HL)
	dc.b	$1c	; z$0A03	INC E
	dc.b	$dd	; z$0A04	LD (IX-37),A
	dc.b	$77	; z$0A05
	dc.b	$28	; z$0A06
	dc.b	$c9	; z$0A07
	dc.b	$dd	; z$0A08	LD L,(IX+26)
	dc.b	$6e	; z$0A09
	dc.b	$03	; z$0A0A
	dc.b	$26	; z$0A0B
	dc.b	$00	; z$0A0C	NOP
	dc.b	$5d	; z$0A0D	LD E,L
	dc.b	$54	; z$0A0E	LD D,H
	dc.b	$29	; z$0A0F	ADD HL,HL
	dc.b	$eb	; z$0A10	EX DE,HL
	dc.b	$19	; z$0A11	ADD HL,DE
	dc.b	$eb	; z$0A12	EX DE,HL
	dc.b	$29	; z$0A13	ADD HL,HL
	dc.b	$29	; z$0A14	ADD HL,HL
	dc.b	$29	; z$0A15	ADD HL,HL
	dc.b	$19	; z$0A16	ADD HL,DE
	dc.b	$11	; z$0A17	LD DE,$1281
	dc.b	$81	; z$0A18
	dc.b	$12	; z$0A19
	dc.b	$19	; z$0A1A	ADD HL,DE
	dc.b	$7e	; z$0A1B	LD A,(HL)
	dc.b	$23	; z$0A1C	INC HL
	dc.b	$dd	; z$0A1D	CP (IX+24)
	dc.b	$be	; z$0A1E
	dc.b	$24	; z$0A1F
	dc.b	$28	; z$0A20	JR Z,z0A2B
	dc.b	$09	; z$0A21
	dc.b	$dd	; z$0A22	LD (IX+4F),A
	dc.b	$77	; z$0A23
	dc.b	$24	; z$0A24
	dc.b	$4f	; z$0A25
	dc.b	$06	; z$0A26	LD B,$B0
	dc.b	$b0	; z$0A27
	dc.b	$cd	; z$0A28	CALL z06C8
	dc.b	$c8	; z$0A29
	dc.b	$06	; z$0A2A
	dc.b	$7e	; z$0A2B	LD A,(HL)
	dc.b	$23	; z$0A2C	INC HL
	dc.b	$dd	; z$0A2D	LD (IX-23),A
	dc.b	$77	; z$0A2E
	dc.b	$05	; z$0A2F
	dc.b	$dd	; z$0A30
	dc.b	$7e	; z$0A31	LD A,(HL)
	dc.b	$3e	; z$0A32	LD A,$E6
	dc.b	$e6	; z$0A33
	dc.b	$c0	; z$0A34	RET NZ
	dc.b	$4f	; z$0A35	LD C,A
	dc.b	$28	; z$0A36	JR Z,z0A3A
	dc.b	$02	; z$0A37
	dc.b	$3e	; z$0A38	LD A,$C0
	dc.b	$c0	; z$0A39
	dc.b	$2f	; z$0A3A	CPL
	dc.b	$a6	; z$0A3B	AND (HL)
	dc.b	$23	; z$0A3C	INC HL
	dc.b	$b1	; z$0A3D	OR C
	dc.b	$dd	; z$0A3E	CP (IX+25)
	dc.b	$be	; z$0A3F
	dc.b	$25	; z$0A40
	dc.b	$28	; z$0A41	JR Z,z0A4C
	dc.b	$09	; z$0A42
	dc.b	$dd	; z$0A43	LD (IX+4F),A
	dc.b	$77	; z$0A44
	dc.b	$25	; z$0A45
	dc.b	$4f	; z$0A46
	dc.b	$06	; z$0A47	LD B,$B4
	dc.b	$b4	; z$0A48
	dc.b	$cd	; z$0A49	CALL z06C8
	dc.b	$c8	; z$0A4A
	dc.b	$06	; z$0A4B
	dc.b	$dd	; z$0A4C	PUSH IX
	dc.b	$e5	; z$0A4D
	dc.b	$d1	; z$0A4E	POP DE
	dc.b	$eb	; z$0A4F	EX DE,HL
	dc.b	$01	; z$0A50	LD BC,$0028
	dc.b	$28	; z$0A51
	dc.b	$00	; z$0A52
	dc.b	$09	; z$0A53	ADD HL,BC
	dc.b	$eb	; z$0A54	EX DE,HL
	dc.b	$af	; z$0A55	XOR A
	dc.b	$cd	; z$0A56	CALL z067C
	dc.b	$7c	; z$0A57
	dc.b	$06	; z$0A58
	dc.b	$3e	; z$0A59	LD A,$08
	dc.b	$08	; z$0A5A
	dc.b	$cd	; z$0A5B	CALL z067C
	dc.b	$7c	; z$0A5C
	dc.b	$06	; z$0A5D
	dc.b	$3e	; z$0A5E	LD A,$04
	dc.b	$04	; z$0A5F
	dc.b	$cd	; z$0A60	CALL z067C
	dc.b	$7c	; z$0A61
	dc.b	$06	; z$0A62
	dc.b	$3e	; z$0A63	LD A,$0C
	dc.b	$0c	; z$0A64
	dc.b	$cd	; z$0A65	CALL z067C
	dc.b	$7c	; z$0A66
	dc.b	$06	; z$0A67
	dc.b	$7e	; z$0A68	LD A,(HL)
	dc.b	$23	; z$0A69	INC HL
	dc.b	$dd	; z$0A6A	LD (IX+7E),A
	dc.b	$77	; z$0A6B
	dc.b	$26	; z$0A6C
	dc.b	$7e	; z$0A6D
	dc.b	$23	; z$0A6E	INC HL
	dc.b	$dd	; z$0A6F	LD (IX-33),A
	dc.b	$77	; z$0A70
	dc.b	$27	; z$0A71
	dc.b	$cd	; z$0A72
	dc.b	$04	; z$0A73	INC B
	dc.b	$0b	; z$0A74	DEC BC
	dc.b	$cd	; z$0A75	CALL z0667
	dc.b	$67	; z$0A76
	dc.b	$06	; z$0A77
	dc.b	$5e	; z$0A78	LD E,(HL)
	dc.b	$dd	; z$0A79	PUSH IX
	dc.b	$e5	; z$0A7A
	dc.b	$e1	; z$0A7B	POP HL
	dc.b	$01	; z$0A7C	LD BC,$0028
	dc.b	$28	; z$0A7D
	dc.b	$00	; z$0A7E
	dc.b	$09	; z$0A7F	ADD HL,BC
	dc.b	$50	; z$0A80	LD D,B
	dc.b	$7e	; z$0A81	LD A,(HL)
	dc.b	$23	; z$0A82	INC HL
	dc.b	$cb	; z$0A83	RLC A
	dc.b	$3b	; z$0A84
	dc.b	$38	; z$0A85	JR C,z0A9A
	dc.b	$13	; z$0A86
	dc.b	$be	; z$0A87	CP (HL)
	dc.b	$28	; z$0A88	JR Z,z0A9A
	dc.b	$10	; z$0A89
	dc.b	$77	; z$0A8A	LD (HL),A
	dc.b	$4f	; z$0A8B	LD C,A
	dc.b	$7a	; z$0A8C	LD A,D
	dc.b	$cb	; z$0A8D	RLC A
	dc.b	$3f	; z$0A8E
	dc.b	$30	; z$0A8F	JR NC,z0A93
	dc.b	$02	; z$0A90
	dc.b	$f6	; z$0A91	OR $02
	dc.b	$02	; z$0A92
	dc.b	$07	; z$0A93	RLCA
	dc.b	$07	; z$0A94	RLCA
	dc.b	$f6	; z$0A95	OR $40
	dc.b	$40	; z$0A96
	dc.b	$cd	; z$0A97	CALL z06C7
	dc.b	$c7	; z$0A98
	dc.b	$06	; z$0A99
	dc.b	$23	; z$0A9A	INC HL
	dc.b	$23	; z$0A9B	INC HL
	dc.b	$23	; z$0A9C	INC HL
	dc.b	$14	; z$0A9D	INC D
	dc.b	$cb	; z$0A9E	RRC D
	dc.b	$52	; z$0A9F
	dc.b	$28	; z$0AA0	JR Z,z0A81
	dc.b	$df	; z$0AA1
	dc.b	$dd	; z$0AA2	LD A,(IX-33)
	dc.b	$7e	; z$0AA3
	dc.b	$05	; z$0AA4
	dc.b	$cd	; z$0AA5
	dc.b	$e2	; z$0AA6	JP PO,zC906
	dc.b	$06	; z$0AA7
	dc.b	$c9	; z$0AA8
	dc.b	$dd	; z$0AA9	LD (IX+29),$78
	dc.b	$36	; z$0AAA
	dc.b	$29	; z$0AAB
	dc.b	$78	; z$0AAC
	dc.b	$3e	; z$0AAD	LD A,$DF
	dc.b	$df	; z$0AAE
	dc.b	$32	; z$0AAF	LD ($7F11),A
	dc.b	$11	; z$0AB0
	dc.b	$7f	; z$0AB1
	dc.b	$dd	; z$0AB2	LD L,(IX+26)
	dc.b	$6e	; z$0AB3
	dc.b	$03	; z$0AB4
	dc.b	$26	; z$0AB5
	dc.b	$00	; z$0AB6	NOP
	dc.b	$5d	; z$0AB7	LD E,L
	dc.b	$54	; z$0AB8	LD D,H
	dc.b	$29	; z$0AB9	ADD HL,HL
	dc.b	$19	; z$0ABA	ADD HL,DE
	dc.b	$29	; z$0ABB	ADD HL,HL
	dc.b	$11	; z$0ABC	LD DE,$1828
	dc.b	$28	; z$0ABD
	dc.b	$18	; z$0ABE
	dc.b	$19	; z$0ABF	ADD HL,DE
	dc.b	$7e	; z$0AC0	LD A,(HL)
	dc.b	$23	; z$0AC1	INC HL
	dc.b	$dd	; z$0AC2	LD (IX+7E),A
	dc.b	$77	; z$0AC3
	dc.b	$2f	; z$0AC4
	dc.b	$7e	; z$0AC5
	dc.b	$23	; z$0AC6	INC HL
	dc.b	$dd	; z$0AC7	LD (IX+7E),A
	dc.b	$77	; z$0AC8
	dc.b	$2d	; z$0AC9
	dc.b	$7e	; z$0ACA
	dc.b	$23	; z$0ACB	INC HL
	dc.b	$dd	; z$0ACC	LD (IX+7E),A
	dc.b	$77	; z$0ACD
	dc.b	$2e	; z$0ACE
	dc.b	$7e	; z$0ACF
	dc.b	$23	; z$0AD0	INC HL
	dc.b	$e5	; z$0AD1	PUSH HL
	dc.b	$6f	; z$0AD2	LD L,A
	dc.b	$26	; z$0AD3	LD H,$00
	dc.b	$00	; z$0AD4
	dc.b	$29	; z$0AD5	ADD HL,HL
	dc.b	$11	; z$0AD6	LD DE,$188F
	dc.b	$8f	; z$0AD7
	dc.b	$18	; z$0AD8
	dc.b	$19	; z$0AD9	ADD HL,DE
	dc.b	$7e	; z$0ADA	LD A,(HL)
	dc.b	$23	; z$0ADB	INC HL
	dc.b	$66	; z$0ADC	LD H,(HL)
	dc.b	$6f	; z$0ADD	LD L,A
	dc.b	$7e	; z$0ADE	LD A,(HL)
	dc.b	$23	; z$0ADF	INC HL
	dc.b	$dd	; z$0AE0	LD (IX-23),L
	dc.b	$75	; z$0AE1
	dc.b	$2a	; z$0AE2
	dc.b	$dd	; z$0AE3
	dc.b	$74	; z$0AE4	LD (HL),H
	dc.b	$2b	; z$0AE5	DEC HL
	dc.b	$5f	; z$0AE6	LD E,A
	dc.b	$e6	; z$0AE7	AND $0F
	dc.b	$0f	; z$0AE8
	dc.b	$dd	; z$0AE9	LD (IX+7B),A
	dc.b	$77	; z$0AEA
	dc.b	$2c	; z$0AEB
	dc.b	$7b	; z$0AEC
	dc.b	$0f	; z$0AED	RRCA
	dc.b	$e6	; z$0AEE	AND $78
	dc.b	$78	; z$0AEF
	dc.b	$dd	; z$0AF0	ADD A,(IX+2)
	dc.b	$86	; z$0AF1
	dc.b	$02	; z$0AF2
	dc.b	$f2	; z$0AF3	JP P,z0AF8
	dc.b	$f8	; z$0AF4
	dc.b	$0a	; z$0AF5
	dc.b	$3e	; z$0AF6	LD A,$7F
	dc.b	$7f	; z$0AF7
	dc.b	$dd	; z$0AF8	LD (IX-1F),A
	dc.b	$77	; z$0AF9
	dc.b	$30	; z$0AFA
	dc.b	$e1	; z$0AFB
	dc.b	$dd	; z$0AFC	LD (IX+26),$00
	dc.b	$36	; z$0AFD
	dc.b	$26	; z$0AFE
	dc.b	$00	; z$0AFF
	dc.b	$dd	; z$0B00	LD (IX+27),$E8
	dc.b	$36	; z$0B01
	dc.b	$27	; z$0B02
	dc.b	$e8	; z$0B03
	dc.b	$7e	; z$0B04	LD A,(HL)
	dc.b	$23	; z$0B05	INC HL
	dc.b	$e5	; z$0B06	PUSH HL
	dc.b	$6f	; z$0B07	LD L,A
	dc.b	$26	; z$0B08	LD H,$00
	dc.b	$00	; z$0B09
	dc.b	$29	; z$0B0A	ADD HL,HL
	dc.b	$01	; z$0B0B	LD BC,$1901
	dc.b	$01	; z$0B0C
	dc.b	$19	; z$0B0D
	dc.b	$09	; z$0B0E	ADD HL,BC
	dc.b	$7e	; z$0B0F	LD A,(HL)
	dc.b	$23	; z$0B10	INC HL
	dc.b	$dd	; z$0B11	LD (IX+7E),A
	dc.b	$77	; z$0B12
	dc.b	$10	; z$0B13
	dc.b	$7e	; z$0B14
	dc.b	$23	; z$0B15	INC HL
	dc.b	$dd	; z$0B16	LD (IX-1F),A
	dc.b	$77	; z$0B17
	dc.b	$11	; z$0B18
	dc.b	$e1	; z$0B19
	dc.b	$6e	; z$0B1A	LD L,(HL)
	dc.b	$26	; z$0B1B	LD H,$00
	dc.b	$00	; z$0B1C
	dc.b	$29	; z$0B1D	ADD HL,HL
	dc.b	$01	; z$0B1E	LD BC,$19D8
	dc.b	$d8	; z$0B1F
	dc.b	$19	; z$0B20
	dc.b	$09	; z$0B21	ADD HL,BC
	dc.b	$7e	; z$0B22	LD A,(HL)
	dc.b	$23	; z$0B23	INC HL
	dc.b	$dd	; z$0B24	LD (IX+7E),A
	dc.b	$77	; z$0B25
	dc.b	$20	; z$0B26
	dc.b	$7e	; z$0B27
	dc.b	$23	; z$0B28	INC HL
	dc.b	$dd	; z$0B29	LD (IX-51),A
	dc.b	$77	; z$0B2A
	dc.b	$21	; z$0B2B
	dc.b	$af	; z$0B2C
	dc.b	$dd	; z$0B2D	LD (IX-23),A
	dc.b	$77	; z$0B2E
	dc.b	$14	; z$0B2F
	dc.b	$dd	; z$0B30
	dc.b	$77	; z$0B31	LD (HL),A
	dc.b	$15	; z$0B32	DEC D
	dc.b	$dd	; z$0B33	LD (IX-23),A
	dc.b	$77	; z$0B34
	dc.b	$16	; z$0B35
	dc.b	$dd	; z$0B36
	dc.b	$77	; z$0B37	LD (HL),A
	dc.b	$17	; z$0B38	RLA
	dc.b	$dd	; z$0B39	LD (IX-23),A
	dc.b	$77	; z$0B3A
	dc.b	$1c	; z$0B3B
	dc.b	$dd	; z$0B3C
	dc.b	$77	; z$0B3D	LD (HL),A
	dc.b	$1d	; z$0B3E	DEC E
	dc.b	$dd	; z$0B3F	LD (IX+3C),A
	dc.b	$77	; z$0B40
	dc.b	$3f	; z$0B41
	dc.b	$3c	; z$0B42
	dc.b	$dd	; z$0B43	LD (IX-23),A
	dc.b	$77	; z$0B44
	dc.b	$0e	; z$0B45
	dc.b	$dd	; z$0B46
	dc.b	$77	; z$0B47	LD (HL),A
	dc.b	$3a	; z$0B48	LD A,($77DD)
	dc.b	$dd	; z$0B49
	dc.b	$77	; z$0B4A
	dc.b	$3b	; z$0B4B	DEC SP
	dc.b	$dd	; z$0B4C	LD (IX-23),A
	dc.b	$77	; z$0B4D
	dc.b	$1e	; z$0B4E
	dc.b	$dd	; z$0B4F
	dc.b	$77	; z$0B50	LD (HL),A
	dc.b	$38	; z$0B51	JR C,z0B30
	dc.b	$dd	; z$0B52
	dc.b	$77	; z$0B53	LD (HL),A
	dc.b	$39	; z$0B54	ADD HL,SP
	dc.b	$cd	; z$0B55	CALL z0B5B
	dc.b	$5b	; z$0B56
	dc.b	$0b	; z$0B57
	dc.b	$36	; z$0B58	LD (HL),$32
	dc.b	$32	; z$0B59
	dc.b	$c9	; z$0B5A	RET
	dc.b	$3a	; z$0B5B	LD A,($1BF6)
	dc.b	$f6	; z$0B5C
	dc.b	$1b	; z$0B5D
	dc.b	$21	; z$0B5E	LD HL,$1BF7
	dc.b	$f7	; z$0B5F
	dc.b	$1b	; z$0B60
	dc.b	$85	; z$0B61	ADD A,L
	dc.b	$6f	; z$0B62	LD L,A
	dc.b	$d0	; z$0B63	RET NC
	dc.b	$24	; z$0B64	INC H
	dc.b	$c9	; z$0B65	RET
	dc.b	$cd	; z$0B66	CALL z0B5B
	dc.b	$5b	; z$0B67
	dc.b	$0b	; z$0B68
	dc.b	$7e	; z$0B69	LD A,(HL)
	dc.b	$4f	; z$0B6A	LD C,A
	dc.b	$cb	; z$0B6B	RLC H
	dc.b	$21	; z$0B6C
	dc.b	$cb	; z$0B6D	RLC H
	dc.b	$21	; z$0B6E
	dc.b	$81	; z$0B6F	ADD A,C
	dc.b	$cb	; z$0B70	RLC H
	dc.b	$21	; z$0B71
	dc.b	$cb	; z$0B72	RLC H
	dc.b	$21	; z$0B73
	dc.b	$81	; z$0B74	ADD A,C
	dc.b	$cb	; z$0B75	RLC H
	dc.b	$21	; z$0B76
	dc.b	$81	; z$0B77	ADD A,C
	dc.b	$cb	; z$0B78	RLC H
	dc.b	$21	; z$0B79
	dc.b	$81	; z$0B7A	ADD A,C
	dc.b	$c6	; z$0B7B	ADD A,$7F
	dc.b	$7f	; z$0B7C
	dc.b	$77	; z$0B7D	LD (HL),A
	dc.b	$c9	; z$0B7E	RET
	dc.b	$dd	; z$0B7F	LD IX,$1EC0
	dc.b	$21	; z$0B80
	dc.b	$c0	; z$0B81
	dc.b	$1e	; z$0B82
	dc.b	$af	; z$0B83	XOR A
	dc.b	$32	; z$0B84	LD ($1C07),A
	dc.b	$07	; z$0B85
	dc.b	$1c	; z$0B86
	dc.b	$dd	; z$0B87	RRC (IX+0)
	dc.b	$cb	; z$0B88
	dc.b	$00	; z$0B89
	dc.b	$7e	; z$0B8A
	dc.b	$c4	; z$0B8B	CALL NZ,z0B9C
	dc.b	$9c	; z$0B8C
	dc.b	$0b	; z$0B8D
	dc.b	$11	; z$0B8E	LD DE,$0020
	dc.b	$20	; z$0B8F
	dc.b	$00	; z$0B90
	dc.b	$dd	; z$0B91	ADD IX,DE
	dc.b	$19	; z$0B92
	dc.b	$3a	; z$0B93	LD A,($1C07)
	dc.b	$07	; z$0B94
	dc.b	$1c	; z$0B95
	dc.b	$3c	; z$0B96	INC A
	dc.b	$fe	; z$0B97	CP $0A
	dc.b	$0a	; z$0B98
	dc.b	$38	; z$0B99	JR C,z0B84
	dc.b	$e9	; z$0B9A
	dc.b	$c9	; z$0B9B	RET
	dc.b	$dd	; z$0B9C	RRC (IX+10)
	dc.b	$cb	; z$0B9D
	dc.b	$10	; z$0B9E
	dc.b	$7e	; z$0B9F
	dc.b	$28	; z$0BA0	JR Z,z0BA8
	dc.b	$06	; z$0BA1
	dc.b	$3a	; z$0BA2	LD A,($1C03)
	dc.b	$03	; z$0BA3
	dc.b	$1c	; z$0BA4
	dc.b	$cb	; z$0BA5	RRC B
	dc.b	$47	; z$0BA6
	dc.b	$c0	; z$0BA7	RET NZ
	dc.b	$dd	; z$0BA8	RRC (IX+0)
	dc.b	$cb	; z$0BA9
	dc.b	$00	; z$0BAA
	dc.b	$76	; z$0BAB
	dc.b	$20	; z$0BAC	JR NZ,z0BE3
	dc.b	$35	; z$0BAD
	dc.b	$dd	; z$0BAE	RR (IX+0)
	dc.b	$cb	; z$0BAF
	dc.b	$00	; z$0BB0
	dc.b	$f6	; z$0BB1
	dc.b	$af	; z$0BB2	XOR A
	dc.b	$dd	; z$0BB3	LD (IX-23),A
	dc.b	$77	; z$0BB4
	dc.b	$02	; z$0BB5
	dc.b	$dd	; z$0BB6
	dc.b	$77	; z$0BB7	LD (HL),A
	dc.b	$03	; z$0BB8	INC BC
	dc.b	$dd	; z$0BB9	LD (IX-23),A
	dc.b	$77	; z$0BBA
	dc.b	$01	; z$0BBB
	dc.b	$dd	; z$0BBC
	dc.b	$77	; z$0BBD	LD (HL),A
	dc.b	$12	; z$0BBE	LD (DE),A
	dc.b	$dd	; z$0BBF	LD (IX-23),A
	dc.b	$77	; z$0BC0
	dc.b	$13	; z$0BC1
	dc.b	$dd	; z$0BC2
	dc.b	$77	; z$0BC3	LD (HL),A
	dc.b	$08	; z$0BC4	EX AF,AF'
	dc.b	$dd	; z$0BC5	LD (IX-23),A
	dc.b	$77	; z$0BC6
	dc.b	$09	; z$0BC7
	dc.b	$dd	; z$0BC8
	dc.b	$36	; z$0BC9	LD (HL),$0A
	dc.b	$0a	; z$0BCA
	dc.b	$0f	; z$0BCB	RRCA
	dc.b	$dd	; z$0BCC	LD (IX+B),$08
	dc.b	$36	; z$0BCD
	dc.b	$0b	; z$0BCE
	dc.b	$08	; z$0BCF
	dc.b	$dd	; z$0BD0	LD (IX-23),A
	dc.b	$77	; z$0BD1
	dc.b	$0c	; z$0BD2
	dc.b	$dd	; z$0BD3
	dc.b	$77	; z$0BD4	LD (HL),A
	dc.b	$0d	; z$0BD5	DEC C
	dc.b	$dd	; z$0BD6	LD (IX-23),A
	dc.b	$77	; z$0BD7
	dc.b	$0e	; z$0BD8
	dc.b	$dd	; z$0BD9
	dc.b	$7e	; z$0BDA	LD A,(HL)
	dc.b	$11	; z$0BDB	LD DE,$01E6
	dc.b	$e6	; z$0BDC
	dc.b	$01	; z$0BDD
	dc.b	$dd	; z$0BDE	LD (IX+18),A
	dc.b	$77	; z$0BDF
	dc.b	$11	; z$0BE0
	dc.b	$18	; z$0BE1
	dc.b	$1f	; z$0BE2	RRA
	dc.b	$dd	; z$0BE3	LD L,(IX-23)
	dc.b	$6e	; z$0BE4
	dc.b	$02	; z$0BE5
	dc.b	$dd	; z$0BE6
	dc.b	$66	; z$0BE7	LD H,(HL)
	dc.b	$03	; z$0BE8	INC BC
	dc.b	$1e	; z$0BE9	LD E,$09
	dc.b	$09	; z$0BEA
	dc.b	$dd	; z$0BEB	RRC (IX+10)
	dc.b	$cb	; z$0BEC
	dc.b	$10	; z$0BED
	dc.b	$7e	; z$0BEE
	dc.b	$28	; z$0BEF	JR Z,z0BF5
	dc.b	$04	; z$0BF0
	dc.b	$3a	; z$0BF1	LD A,($1C06)
	dc.b	$06	; z$0BF2
	dc.b	$1c	; z$0BF3
	dc.b	$5f	; z$0BF4	LD E,A
	dc.b	$af	; z$0BF5	XOR A
	dc.b	$57	; z$0BF6	LD D,A
	dc.b	$ed	; z$0BF7	SBC HL,DE
	dc.b	$52	; z$0BF8
	dc.b	$dd	; z$0BF9	LD (IX-23),L
	dc.b	$75	; z$0BFA
	dc.b	$02	; z$0BFB
	dc.b	$dd	; z$0BFC
	dc.b	$74	; z$0BFD	LD (HL),H
	dc.b	$03	; z$0BFE	INC BC
	dc.b	$28	; z$0BFF	JR Z,z0C02
	dc.b	$01	; z$0C00
	dc.b	$d0	; z$0C01	RET NC
	dc.b	$dd	; z$0C02	LD E,(IX-23)
	dc.b	$5e	; z$0C03
	dc.b	$06	; z$0C04
	dc.b	$dd	; z$0C05
	dc.b	$56	; z$0C06	LD D,(HL)
	dc.b	$07	; z$0C07	RLCA
	dc.b	$af	; z$0C08	XOR A
	dc.b	$32	; z$0C09	LD ($1C1A),A
	dc.b	$1a	; z$0C0A
	dc.b	$1c	; z$0C0B
	dc.b	$32	; z$0C0C	LD ($1C1B),A
	dc.b	$1b	; z$0C0D
	dc.b	$1c	; z$0C0E
	dc.b	$dd	; z$0C0F	LD L,(IX-23)
	dc.b	$6e	; z$0C10
	dc.b	$04	; z$0C11
	dc.b	$dd	; z$0C12
	dc.b	$66	; z$0C13	LD H,(HL)
	dc.b	$05	; z$0C14	DEC B
	dc.b	$22	; z$0C15	LD ($1C18),HL
	dc.b	$18	; z$0C16
	dc.b	$1c	; z$0C17
	dc.b	$1a	; z$0C18	LD A,(DE)
	dc.b	$13	; z$0C19	INC DE
	dc.b	$fe	; z$0C1A	CP $E0
	dc.b	$e0	; z$0C1B
	dc.b	$38	; z$0C1C	JR C,z0C32
	dc.b	$14	; z$0C1D
	dc.b	$87	; z$0C1E	ADD A,A
	dc.b	$e6	; z$0C1F	AND $3E
	dc.b	$3e	; z$0C20
	dc.b	$c6	; z$0C21	ADD A,$62
	dc.b	$62	; z$0C22
	dc.b	$6f	; z$0C23	LD L,A
	dc.b	$3e	; z$0C24	LD A,$00
	dc.b	$00	; z$0C25
	dc.b	$ce	; z$0C26	ADC A,$0E
	dc.b	$0e	; z$0C27
	dc.b	$67	; z$0C28	LD H,A
	dc.b	$7e	; z$0C29	LD A,(HL)
	dc.b	$23	; z$0C2A	INC HL
	dc.b	$66	; z$0C2B	LD H,(HL)
	dc.b	$6f	; z$0C2C	LD L,A
	dc.b	$01	; z$0C2D	LD BC,$0C18
	dc.b	$18	; z$0C2E
	dc.b	$0c	; z$0C2F
	dc.b	$c5	; z$0C30	PUSH BC
	dc.b	$e9	; z$0C31	JP (HL)
	dc.b	$fe	; z$0C32	CP $D8
	dc.b	$d8	; z$0C33
	dc.b	$38	; z$0C34	JR C,z0C3D
	dc.b	$07	; z$0C35
	dc.b	$d6	; z$0C36	SUB $D7
	dc.b	$d7	; z$0C37
	dc.b	$cd	; z$0C38	CALL z0E55
	dc.b	$55	; z$0C39
	dc.b	$0e	; z$0C3A
	dc.b	$18	; z$0C3B	JR z0C18
	dc.b	$db	; z$0C3C
	dc.b	$fe	; z$0C3D	CP $D0
	dc.b	$d0	; z$0C3E
	dc.b	$38	; z$0C3F	JR C,z0C4C
	dc.b	$0b	; z$0C40
	dc.b	$d6	; z$0C41	SUB $CF
	dc.b	$cf	; z$0C42
	dc.b	$cd	; z$0C43	CALL z0E55
	dc.b	$55	; z$0C44
	dc.b	$0e	; z$0C45
	dc.b	$eb	; z$0C46	EX DE,HL
	dc.b	$5e	; z$0C47	LD E,(HL)
	dc.b	$23	; z$0C48	INC HL
	dc.b	$56	; z$0C49	LD D,(HL)
	dc.b	$18	; z$0C4A	JR z0C18
	dc.b	$cc	; z$0C4B
	dc.b	$fe	; z$0C4C	CP $C0
	dc.b	$c0	; z$0C4D
	dc.b	$38	; z$0C4E	JR C,z0C6B
	dc.b	$1b	; z$0C4F
	dc.b	$e6	; z$0C50	AND $0F
	dc.b	$0f	; z$0C51
	dc.b	$4f	; z$0C52	LD C,A
	dc.b	$06	; z$0C53	LD B,$00
	dc.b	$00	; z$0C54
	dc.b	$21	; z$0C55	LD HL,$0E35
	dc.b	$35	; z$0C56
	dc.b	$0e	; z$0C57
	dc.b	$09	; z$0C58	ADD HL,BC
	dc.b	$6e	; z$0C59	LD L,(HL)
	dc.b	$26	; z$0C5A	LD H,$00
	dc.b	$00	; z$0C5B
	dc.b	$4d	; z$0C5C	LD C,L
	dc.b	$44	; z$0C5D	LD B,H
	dc.b	$29	; z$0C5E	ADD HL,HL
	dc.b	$09	; z$0C5F	ADD HL,BC
	dc.b	$22	; z$0C60	LD ($1C18),HL
	dc.b	$18	; z$0C61
	dc.b	$1c	; z$0C62
	dc.b	$dd	; z$0C63	LD (IX-23),L
	dc.b	$75	; z$0C64
	dc.b	$04	; z$0C65
	dc.b	$dd	; z$0C66
	dc.b	$74	; z$0C67	LD (HL),H
	dc.b	$05	; z$0C68	DEC B
	dc.b	$18	; z$0C69	JR z0C18
	dc.b	$ad	; z$0C6A
	dc.b	$fe	; z$0C6B	CP $60
	dc.b	$60	; z$0C6C
	dc.b	$38	; z$0C6D	JR C,z0C76
	dc.b	$07	; z$0C6E
	dc.b	$d6	; z$0C6F	SUB $60
	dc.b	$60	; z$0C70
	dc.b	$cd	; z$0C71	CALL z0CA5
	dc.b	$a5	; z$0C72
	dc.b	$0c	; z$0C73
	dc.b	$18	; z$0C74	JR z0C18
	dc.b	$a2	; z$0C75
	dc.b	$cd	; z$0C76	CALL z0CA5
	dc.b	$a5	; z$0C77
	dc.b	$0c	; z$0C78
	dc.b	$dd	; z$0C79	LD (IX-23),E
	dc.b	$73	; z$0C7A
	dc.b	$06	; z$0C7B
	dc.b	$dd	; z$0C7C
	dc.b	$72	; z$0C7D	LD (HL),D
	dc.b	$07	; z$0C7E	RLCA
	dc.b	$3a	; z$0C7F	LD A,($1C18)
	dc.b	$18	; z$0C80
	dc.b	$1c	; z$0C81
	dc.b	$dd	; z$0C82	ADD A,(IX+2)
	dc.b	$86	; z$0C83
	dc.b	$02	; z$0C84
	dc.b	$dd	; z$0C85	LD (IX+3A),A
	dc.b	$77	; z$0C86
	dc.b	$02	; z$0C87
	dc.b	$3a	; z$0C88
	dc.b	$19	; z$0C89	ADD HL,DE
	dc.b	$1c	; z$0C8A	INC E
	dc.b	$dd	; z$0C8B	ADC A,(IX+3)
	dc.b	$8e	; z$0C8C
	dc.b	$03	; z$0C8D
	dc.b	$dd	; z$0C8E	LD (IX+3A),A
	dc.b	$77	; z$0C8F
	dc.b	$03	; z$0C90
	dc.b	$3a	; z$0C91
	dc.b	$1b	; z$0C92	DEC DE
	dc.b	$1c	; z$0C93	INC E
	dc.b	$dd	; z$0C94	LD (IX-23),A
	dc.b	$77	; z$0C95
	dc.b	$13	; z$0C96
	dc.b	$dd	; z$0C97
	dc.b	$cb	; z$0C98	RLC B
	dc.b	$00	; z$0C99
	dc.b	$a6	; z$0C9A	AND (HL)
	dc.b	$3a	; z$0C9B	LD A,($1C1A)
	dc.b	$1a	; z$0C9C
	dc.b	$1c	; z$0C9D
	dc.b	$b7	; z$0C9E	OR A
	dc.b	$c8	; z$0C9F	RET Z
	dc.b	$dd	; z$0CA0	RR (IX+0)
	dc.b	$cb	; z$0CA1
	dc.b	$00	; z$0CA2
	dc.b	$e6	; z$0CA3
	dc.b	$c9	; z$0CA4	RET
	dc.b	$d5	; z$0CA5	PUSH DE
	dc.b	$dd	; z$0CA6	RRC (IX+11)
	dc.b	$cb	; z$0CA7
	dc.b	$11	; z$0CA8
	dc.b	$46	; z$0CA9
	dc.b	$c2	; z$0CAA	JP NZ,z0E12
	dc.b	$12	; z$0CAB
	dc.b	$0e	; z$0CAC
	dc.b	$dd	; z$0CAD	RRC (IX+0)
	dc.b	$cb	; z$0CAE
	dc.b	$00	; z$0CAF
	dc.b	$46	; z$0CB0
	dc.b	$28	; z$0CB1	JR Z,z0CEB
	dc.b	$38	; z$0CB2
	dc.b	$6f	; z$0CB3	LD L,A
	dc.b	$87	; z$0CB4	ADD A,A
	dc.b	$85	; z$0CB5	ADD A,L
	dc.b	$6f	; z$0CB6	LD L,A
	dc.b	$26	; z$0CB7	LD H,$00
	dc.b	$00	; z$0CB8
	dc.b	$cb	; z$0CB9	RLC D
	dc.b	$14	; z$0CBA
	dc.b	$29	; z$0CBB	ADD HL,HL
	dc.b	$11	; z$0CBC	LD DE,$19F1
	dc.b	$f1	; z$0CBD
	dc.b	$19	; z$0CBE
	dc.b	$19	; z$0CBF	ADD HL,DE
	dc.b	$7e	; z$0CC0	LD A,(HL)
	dc.b	$23	; z$0CC1	INC HL
	dc.b	$32	; z$0CC2	LD ($1C20),A
	dc.b	$20	; z$0CC3
	dc.b	$1c	; z$0CC4
	dc.b	$7e	; z$0CC5	LD A,(HL)
	dc.b	$23	; z$0CC6	INC HL
	dc.b	$32	; z$0CC7	LD ($1C21),A
	dc.b	$21	; z$0CC8
	dc.b	$1c	; z$0CC9
	dc.b	$dd	; z$0CCA	LD A,(IX-1A)
	dc.b	$7e	; z$0CCB
	dc.b	$10	; z$0CCC
	dc.b	$e6	; z$0CCD
	dc.b	$7f	; z$0CCE	LD A,A
	dc.b	$32	; z$0CCF	LD ($1C22),A
	dc.b	$22	; z$0CD0
	dc.b	$1c	; z$0CD1
	dc.b	$e5	; z$0CD2	PUSH HL
	dc.b	$cd	; z$0CD3	CALL z0393
	dc.b	$93	; z$0CD4
	dc.b	$03	; z$0CD5
	dc.b	$e1	; z$0CD6	POP HL
	dc.b	$c2	; z$0CD7	JP NZ,z0E12
	dc.b	$12	; z$0CD8
	dc.b	$0e	; z$0CD9
	dc.b	$7e	; z$0CDA	LD A,(HL)
	dc.b	$23	; z$0CDB	INC HL
	dc.b	$fd	; z$0CDC	LD (IY+7E),A
	dc.b	$77	; z$0CDD
	dc.b	$03	; z$0CDE
	dc.b	$7e	; z$0CDF
	dc.b	$23	; z$0CE0	INC HL
	dc.b	$4f	; z$0CE1	LD C,A
	dc.b	$e6	; z$0CE2	AND $3F
	dc.b	$3f	; z$0CE3
	dc.b	$5e	; z$0CE4	LD E,(HL)
	dc.b	$23	; z$0CE5	INC HL
	dc.b	$56	; z$0CE6	LD D,(HL)
	dc.b	$eb	; z$0CE7	EX DE,HL
	dc.b	$c3	; z$0CE8	JP z0DA5
	dc.b	$a5	; z$0CE9
	dc.b	$0d	; z$0CEA
	dc.b	$dd	; z$0CEB	ADD A,(IX+D)
	dc.b	$86	; z$0CEC
	dc.b	$0d	; z$0CED
	dc.b	$67	; z$0CEE	LD H,A
	dc.b	$dd	; z$0CEF	LD L,(IX+22)
	dc.b	$6e	; z$0CF0
	dc.b	$0c	; z$0CF1
	dc.b	$22	; z$0CF2
	dc.b	$24	; z$0CF3	INC H
	dc.b	$1c	; z$0CF4	INC E
	dc.b	$dd	; z$0CF5	LD A,(IX+32)
	dc.b	$7e	; z$0CF6
	dc.b	$08	; z$0CF7
	dc.b	$32	; z$0CF8
	dc.b	$20	; z$0CF9	JR NZ,z0D17
	dc.b	$1c	; z$0CFA
	dc.b	$dd	; z$0CFB	RRC (IX+0)
	dc.b	$cb	; z$0CFC
	dc.b	$00	; z$0CFD
	dc.b	$6e	; z$0CFE
	dc.b	$28	; z$0CFF	JR Z,z0D62
	dc.b	$61	; z$0D00
	dc.b	$cd	; z$0D01	CALL z040D
	dc.b	$0d	; z$0D02
	dc.b	$04	; z$0D03
	dc.b	$38	; z$0D04	JR C,z0D82
	dc.b	$7c	; z$0D05
	dc.b	$dd	; z$0D06	RRC (IX+0)
	dc.b	$cb	; z$0D07
	dc.b	$00	; z$0D08
	dc.b	$66	; z$0D09
	dc.b	$20	; z$0D0A	JR NZ,z0D15
	dc.b	$09	; z$0D0B
	dc.b	$fd	; z$0D0C	PUSH IY
	dc.b	$e5	; z$0D0D
	dc.b	$dd	; z$0D0E	DB $IX, $E3
	dc.b	$e3	; z$0D0F
	dc.b	$cd	; z$0D10	CALL z0446
	dc.b	$46	; z$0D11
	dc.b	$04	; z$0D12
	dc.b	$dd	; z$0D13	POP IX
	dc.b	$e1	; z$0D14
	dc.b	$2a	; z$0D15	LD HL,($1C24)
	dc.b	$24	; z$0D16
	dc.b	$1c	; z$0D17
	dc.b	$fd	; z$0D18	LD (IY-3),L
	dc.b	$75	; z$0D19
	dc.b	$18	; z$0D1A
	dc.b	$fd	; z$0D1B
	dc.b	$74	; z$0D1C	LD (HL),H
	dc.b	$19	; z$0D1D	ADD HL,DE
	dc.b	$fd	; z$0D1E	LD E,(IY-3)
	dc.b	$5e	; z$0D1F
	dc.b	$0c	; z$0D20
	dc.b	$fd	; z$0D21
	dc.b	$56	; z$0D22	LD D,(HL)
	dc.b	$0d	; z$0D23	DEC C
	dc.b	$b7	; z$0D24	OR A
	dc.b	$ed	; z$0D25	SBC HL,DE
	dc.b	$52	; z$0D26
	dc.b	$f5	; z$0D27	PUSH SP
	dc.b	$30	; z$0D28	JR NC,z0D31
	dc.b	$07	; z$0D29
	dc.b	$af	; z$0D2A	XOR A
	dc.b	$95	; z$0D2B	SUB L
	dc.b	$6f	; z$0D2C	LD L,A
	dc.b	$3e	; z$0D2D	LD A,$00
	dc.b	$00	; z$0D2E
	dc.b	$9c	; z$0D2F	SBC A,H
	dc.b	$67	; z$0D30	LD H,A
	dc.b	$af	; z$0D31	XOR A
	dc.b	$06	; z$0D32	LD B,$10
	dc.b	$10	; z$0D33
	dc.b	$dd	; z$0D34	LD C,(IX+29)
	dc.b	$4e	; z$0D35
	dc.b	$0f	; z$0D36
	dc.b	$29	; z$0D37
	dc.b	$17	; z$0D38	RLA
	dc.b	$b9	; z$0D39	CP C
	dc.b	$38	; z$0D3A	JR C,z0D3E
	dc.b	$02	; z$0D3B
	dc.b	$91	; z$0D3C	SUB C
	dc.b	$2c	; z$0D3D	INC L
	dc.b	$10	; z$0D3E	DJNZ z0D37
	dc.b	$f7	; z$0D3F
	dc.b	$f1	; z$0D40	POP SP
	dc.b	$30	; z$0D41	JR NC,z0D4A
	dc.b	$07	; z$0D42
	dc.b	$af	; z$0D43	XOR A
	dc.b	$95	; z$0D44	SUB L
	dc.b	$6f	; z$0D45	LD L,A
	dc.b	$3e	; z$0D46	LD A,$00
	dc.b	$00	; z$0D47
	dc.b	$9c	; z$0D48	SBC A,H
	dc.b	$67	; z$0D49	LD H,A
	dc.b	$fd	; z$0D4A	LD (IY-3),L
	dc.b	$75	; z$0D4B
	dc.b	$1a	; z$0D4C
	dc.b	$fd	; z$0D4D
	dc.b	$74	; z$0D4E	LD (HL),H
	dc.b	$1b	; z$0D4F	DEC DE
	dc.b	$dd	; z$0D50	RRC (IX+0)
	dc.b	$cb	; z$0D51
	dc.b	$00	; z$0D52
	dc.b	$66	; z$0D53
	dc.b	$20	; z$0D54	JR NZ,z0D76
	dc.b	$20	; z$0D55
	dc.b	$fd	; z$0D56	LD (IY+0),$80
	dc.b	$36	; z$0D57
	dc.b	$00	; z$0D58
	dc.b	$80	; z$0D59
	dc.b	$dd	; z$0D5A	LD A,(IX-23)
	dc.b	$7e	; z$0D5B
	dc.b	$0b	; z$0D5C
	dc.b	$dd	; z$0D5D
	dc.b	$4e	; z$0D5E	LD C,(HL)
	dc.b	$11	; z$0D5F	LD DE,$4918
	dc.b	$18	; z$0D60
	dc.b	$49	; z$0D61
	dc.b	$dd	; z$0D62	RRC (IX+0)
	dc.b	$cb	; z$0D63
	dc.b	$00	; z$0D64
	dc.b	$66	; z$0D65
	dc.b	$28	; z$0D66	JR Z,z0D82
	dc.b	$1a	; z$0D67
	dc.b	$cd	; z$0D68	CALL z040D
	dc.b	$0d	; z$0D69
	dc.b	$04	; z$0D6A
	dc.b	$38	; z$0D6B	JR C,z0D82
	dc.b	$15	; z$0D6C
	dc.b	$2a	; z$0D6D	LD HL,($1C24)
	dc.b	$24	; z$0D6E
	dc.b	$1c	; z$0D6F
	dc.b	$fd	; z$0D70	LD (IY-3),L
	dc.b	$75	; z$0D71
	dc.b	$0c	; z$0D72
	dc.b	$fd	; z$0D73
	dc.b	$74	; z$0D74	LD (HL),H
	dc.b	$0d	; z$0D75	DEC C
	dc.b	$cd	; z$0D76	CALL z0E1B
	dc.b	$1b	; z$0D77
	dc.b	$0e	; z$0D78
	dc.b	$dd	; z$0D79	LD A,(IX-3)
	dc.b	$7e	; z$0D7A
	dc.b	$12	; z$0D7B
	dc.b	$fd	; z$0D7C
	dc.b	$77	; z$0D7D	LD (HL),A
	dc.b	$07	; z$0D7E	RLCA
	dc.b	$c3	; z$0D7F	JP z0E12
	dc.b	$12	; z$0D80
	dc.b	$0e	; z$0D81
	dc.b	$dd	; z$0D82	LD A,(IX+32)
	dc.b	$7e	; z$0D83
	dc.b	$0a	; z$0D84
	dc.b	$32	; z$0D85
	dc.b	$21	; z$0D86	LD HL,$DD1C
	dc.b	$1c	; z$0D87
	dc.b	$dd	; z$0D88
	dc.b	$7e	; z$0D89	LD A,(HL)
	dc.b	$10	; z$0D8A	DJNZ z0D72
	dc.b	$e6	; z$0D8B
	dc.b	$7f	; z$0D8C	LD A,A
	dc.b	$32	; z$0D8D	LD ($1C22),A
	dc.b	$22	; z$0D8E
	dc.b	$1c	; z$0D8F
	dc.b	$cd	; z$0D90	CALL z0393
	dc.b	$93	; z$0D91
	dc.b	$03	; z$0D92
	dc.b	$c2	; z$0D93	JP NZ,z0E12
	dc.b	$12	; z$0D94
	dc.b	$0e	; z$0D95
	dc.b	$dd	; z$0D96	LD A,(IX-3)
	dc.b	$7e	; z$0D97
	dc.b	$09	; z$0D98
	dc.b	$fd	; z$0D99
	dc.b	$77	; z$0D9A	LD (HL),A
	dc.b	$03	; z$0D9B	INC BC
	dc.b	$dd	; z$0D9C	LD A,(IX-23)
	dc.b	$7e	; z$0D9D
	dc.b	$0b	; z$0D9E
	dc.b	$dd	; z$0D9F
	dc.b	$4e	; z$0DA0	LD C,(HL)
	dc.b	$11	; z$0DA1	LD DE,$242A
	dc.b	$2a	; z$0DA2
	dc.b	$24	; z$0DA3
	dc.b	$1c	; z$0DA4	INC E
	dc.b	$fd	; z$0DA5	LD (IY-3),L
	dc.b	$75	; z$0DA6
	dc.b	$0c	; z$0DA7
	dc.b	$fd	; z$0DA8
	dc.b	$74	; z$0DA9	LD (HL),H
	dc.b	$0d	; z$0DAA	DEC C
	dc.b	$fd	; z$0DAB	LD (IY-33),C
	dc.b	$71	; z$0DAC
	dc.b	$3e	; z$0DAD
	dc.b	$cd	; z$0DAE
	dc.b	$1b	; z$0DAF	DEC DE
	dc.b	$0e	; z$0DB0	LD C,$21
	dc.b	$21	; z$0DB1
	dc.b	$1a	; z$0DB2	LD A,(DE)
	dc.b	$1c	; z$0DB3	INC E
	dc.b	$cb	; z$0DB4	RRC (HL)
	dc.b	$46	; z$0DB5
	dc.b	$28	; z$0DB6	JR Z,z0DBE
	dc.b	$06	; z$0DB7
	dc.b	$af	; z$0DB8	XOR A
	dc.b	$fd	; z$0DB9	LD (IY+18),A
	dc.b	$77	; z$0DBA
	dc.b	$3c	; z$0DBB
	dc.b	$18	; z$0DBC
	dc.b	$1b	; z$0DBD	DEC DE
	dc.b	$06	; z$0DBE	LD B,$05
	dc.b	$05	; z$0DBF
	dc.b	$ed	; z$0DC0	LD DE,($1C18)
	dc.b	$5b	; z$0DC1
	dc.b	$18	; z$0DC2
	dc.b	$1c	; z$0DC3
	dc.b	$21	; z$0DC4	LD HL,$0000
	dc.b	$00	; z$0DC5
	dc.b	$00	; z$0DC6
	dc.b	$cb	; z$0DC7	RLC A
	dc.b	$3c	; z$0DC8
	dc.b	$cb	; z$0DC9	RLC E
	dc.b	$1d	; z$0DCA
	dc.b	$1f	; z$0DCB	RRA
	dc.b	$30	; z$0DCC	JR NC,z0DCF
	dc.b	$01	; z$0DCD
	dc.b	$19	; z$0DCE	ADD HL,DE
	dc.b	$10	; z$0DCF	DJNZ z0DC7
	dc.b	$f6	; z$0DD0
	dc.b	$af	; z$0DD1	XOR A
	dc.b	$95	; z$0DD2	SUB L
	dc.b	$fd	; z$0DD3	LD (IY+3E),A
	dc.b	$77	; z$0DD4
	dc.b	$3c	; z$0DD5
	dc.b	$3e	; z$0DD6
	dc.b	$80	; z$0DD7	ADD A,B
	dc.b	$9c	; z$0DD8	SBC A,H
	dc.b	$fd	; z$0DD9	LD (IY+3A),A
	dc.b	$77	; z$0DDA
	dc.b	$3d	; z$0DDB
	dc.b	$3a	; z$0DDC
	dc.b	$20	; z$0DDD	JR NZ,z0DFB
	dc.b	$1c	; z$0DDE
	dc.b	$b7	; z$0DDF	OR A
	dc.b	$28	; z$0DE0	JR Z,z0DE5
	dc.b	$03	; z$0DE1
	dc.b	$fd	; z$0DE2	LD (IY+E),A
	dc.b	$77	; z$0DE3
	dc.b	$01	; z$0DE4
	dc.b	$0e	; z$0DE5
	dc.b	$80	; z$0DE6	ADD A,B
	dc.b	$dd	; z$0DE7	LD A,(IX-49)
	dc.b	$7e	; z$0DE8
	dc.b	$10	; z$0DE9
	dc.b	$b7	; z$0DEA
	dc.b	$f2	; z$0DEB	JP P,z0DF2
	dc.b	$f2	; z$0DEC
	dc.b	$0d	; z$0DED
	dc.b	$e6	; z$0DEE	AND $7F
	dc.b	$7f	; z$0DEF
	dc.b	$0e	; z$0DF0	LD C,$A0
	dc.b	$a0	; z$0DF1
	dc.b	$dd	; z$0DF2	RRC (IX+0)
	dc.b	$cb	; z$0DF3
	dc.b	$00	; z$0DF4
	dc.b	$6e	; z$0DF5
	dc.b	$28	; z$0DF6	JR Z,z0E00
	dc.b	$08	; z$0DF7
	dc.b	$fd	; z$0DF8	RRC (IY+0)
	dc.b	$cb	; z$0DF9
	dc.b	$00	; z$0DFA
	dc.b	$7e	; z$0DFB
	dc.b	$28	; z$0DFC	JR Z,z0E00
	dc.b	$02	; z$0DFD
	dc.b	$cb	; z$0DFE	RR H
	dc.b	$e1	; z$0DFF
	dc.b	$fd	; z$0E00	LD (IY-3),A
	dc.b	$77	; z$0E01
	dc.b	$04	; z$0E02
	dc.b	$fd	; z$0E03
	dc.b	$71	; z$0E04	LD (HL),C
	dc.b	$00	; z$0E05	NOP
	dc.b	$3a	; z$0E06	LD A,($1C07)
	dc.b	$07	; z$0E07
	dc.b	$1c	; z$0E08
	dc.b	$fd	; z$0E09	LD (IY-23),A
	dc.b	$77	; z$0E0A
	dc.b	$06	; z$0E0B
	dc.b	$dd	; z$0E0C
	dc.b	$7e	; z$0E0D	LD A,(HL)
	dc.b	$12	; z$0E0E	LD (DE),A
	dc.b	$fd	; z$0E0F	LD (IY-2F),A
	dc.b	$77	; z$0E10
	dc.b	$07	; z$0E11
	dc.b	$d1	; z$0E12
	dc.b	$dd	; z$0E13	INC (IX+21)
	dc.b	$34	; z$0E14
	dc.b	$12	; z$0E15
	dc.b	$21	; z$0E16
	dc.b	$1b	; z$0E17	DEC DE
	dc.b	$1c	; z$0E18	INC E
	dc.b	$34	; z$0E19	INC (HL)
	dc.b	$c9	; z$0E1A	RET
	dc.b	$21	; z$0E1B	LD HL,$1200
	dc.b	$00	; z$0E1C
	dc.b	$12	; z$0E1D
	dc.b	$fd	; z$0E1E	LD B,(IY+4)
	dc.b	$46	; z$0E1F
	dc.b	$01	; z$0E20
	dc.b	$04	; z$0E21
	dc.b	$05	; z$0E22	DEC B
	dc.b	$28	; z$0E23	JR Z,z0E28
	dc.b	$03	; z$0E24
	dc.b	$21	; z$0E25	LD HL,$1240
	dc.b	$40	; z$0E26
	dc.b	$12	; z$0E27
	dc.b	$dd	; z$0E28	LD E,(IX-35)
	dc.b	$5e	; z$0E29
	dc.b	$0e	; z$0E2A
	dc.b	$cb	; z$0E2B
	dc.b	$3b	; z$0E2C	DEC SP
	dc.b	$16	; z$0E2D	LD D,$00
	dc.b	$00	; z$0E2E
	dc.b	$19	; z$0E2F	ADD HL,DE
	dc.b	$6e	; z$0E30	LD L,(HL)
	dc.b	$fd	; z$0E31	LD (IY-37),L
	dc.b	$75	; z$0E32
	dc.b	$02	; z$0E33
	dc.b	$c9	; z$0E34
	dc.b	$06	; z$0E35	LD B,$09
	dc.b	$09	; z$0E36
	dc.b	$0c	; z$0E37	INC C
	dc.b	$12	; z$0E38	LD (DE),A
	dc.b	$18	; z$0E39	JR z0E5F
	dc.b	$24	; z$0E3A
	dc.b	$30	; z$0E3B	JR NC,z0E85
	dc.b	$48	; z$0E3C
	dc.b	$60	; z$0E3D	LD H,B
	dc.b	$90	; z$0E3E	SUB B
	dc.b	$c0	; z$0E3F	RET NZ
	dc.b	$08	; z$0E40	EX AF,AF'
	dc.b	$10	; z$0E41	DJNZ z0E63
	dc.b	$20	; z$0E42
	dc.b	$3c	; z$0E43	INC A
	dc.b	$78	; z$0E44	LD A,B
	dc.b	$dd	; z$0E45	LD A,(IX+6F)
	dc.b	$7e	; z$0E46
	dc.b	$01	; z$0E47
	dc.b	$6f	; z$0E48
	dc.b	$87	; z$0E49	ADD A,A
	dc.b	$85	; z$0E4A	ADD A,L
	dc.b	$c6	; z$0E4B	ADD A,$14
	dc.b	$14	; z$0E4C
	dc.b	$dd	; z$0E4D	PUSH IX
	dc.b	$e5	; z$0E4E
	dc.b	$e1	; z$0E4F	POP HL
	dc.b	$85	; z$0E50	ADD A,L
	dc.b	$6f	; z$0E51	LD L,A
	dc.b	$d0	; z$0E52	RET NC
	dc.b	$24	; z$0E53	INC H
	dc.b	$c9	; z$0E54	RET
	dc.b	$4f	; z$0E55	LD C,A
	dc.b	$cd	; z$0E56	CALL z0E45
	dc.b	$45	; z$0E57
	dc.b	$0e	; z$0E58
	dc.b	$73	; z$0E59	LD (HL),E
	dc.b	$23	; z$0E5A	INC HL
	dc.b	$72	; z$0E5B	LD (HL),D
	dc.b	$23	; z$0E5C	INC HL
	dc.b	$71	; z$0E5D	LD (HL),C
	dc.b	$dd	; z$0E5E	INC (IX-37)
	dc.b	$34	; z$0E5F
	dc.b	$01	; z$0E60
	dc.b	$c9	; z$0E61
	dc.b	$a2	; z$0E62	AND D
	dc.b	$0e	; z$0E63	LD C,$AC
	dc.b	$ac	; z$0E64
	dc.b	$0e	; z$0E65	LD C,$B1
	dc.b	$b1	; z$0E66
	dc.b	$0e	; z$0E67	LD C,$B8
	dc.b	$b8	; z$0E68
	dc.b	$0e	; z$0E69	LD C,$CC
	dc.b	$cc	; z$0E6A
	dc.b	$0e	; z$0E6B	LD C,$AB
	dc.b	$ab	; z$0E6C
	dc.b	$0e	; z$0E6D	LD C,$AB
	dc.b	$ab	; z$0E6E
	dc.b	$0e	; z$0E6F	LD C,$AB
	dc.b	$ab	; z$0E70
	dc.b	$0e	; z$0E71	LD C,$AB
	dc.b	$ab	; z$0E72
	dc.b	$0e	; z$0E73	LD C,$AB
	dc.b	$ab	; z$0E74
	dc.b	$0e	; z$0E75	LD C,$AB
	dc.b	$ab	; z$0E76
	dc.b	$0e	; z$0E77	LD C,$AB
	dc.b	$ab	; z$0E78
	dc.b	$0e	; z$0E79	LD C,$AB
	dc.b	$ab	; z$0E7A
	dc.b	$0e	; z$0E7B	LD C,$AB
	dc.b	$ab	; z$0E7C
	dc.b	$0e	; z$0E7D	LD C,$AB
	dc.b	$ab	; z$0E7E
	dc.b	$0e	; z$0E7F	LD C,$AB
	dc.b	$ab	; z$0E80
	dc.b	$0e	; z$0E81	LD C,$D7
	dc.b	$d7	; z$0E82
	dc.b	$0e	; z$0E83	LD C,$DD
	dc.b	$dd	; z$0E84
	dc.b	$0e	; z$0E85	LD C,$E3
	dc.b	$e3	; z$0E86
	dc.b	$0e	; z$0E87	LD C,$EE
	dc.b	$ee	; z$0E88
	dc.b	$0e	; z$0E89	LD C,$FF
	dc.b	$ff	; z$0E8A
	dc.b	$0e	; z$0E8B	LD C,$05
	dc.b	$05	; z$0E8C
	dc.b	$0f	; z$0E8D	RRCA
	dc.b	$0e	; z$0E8E	LD C,$0F
	dc.b	$0f	; z$0E8F
	dc.b	$25	; z$0E90	DEC H
	dc.b	$0f	; z$0E91	RRCA
	dc.b	$2b	; z$0E92	DEC HL
	dc.b	$0f	; z$0E93	RRCA
	dc.b	$34	; z$0E94	INC (HL)
	dc.b	$0f	; z$0E95	RRCA
	dc.b	$41	; z$0E96	LD B,C
	dc.b	$0f	; z$0E97	RRCA
	dc.b	$45	; z$0E98	LD B,L
	dc.b	$0f	; z$0E99	RRCA
	dc.b	$4b	; z$0E9A	LD C,E
	dc.b	$0f	; z$0E9B	RRCA
	dc.b	$51	; z$0E9C	LD D,C
	dc.b	$0f	; z$0E9D	RRCA
	dc.b	$56	; z$0E9E	LD D,(HL)
	dc.b	$0f	; z$0E9F	RRCA
	dc.b	$66	; z$0EA0	LD H,(HL)
	dc.b	$0f	; z$0EA1	RRCA
	dc.b	$1a	; z$0EA2	LD A,(DE)
	dc.b	$13	; z$0EA3	INC DE
	dc.b	$dd	; z$0EA4	LD (IX-23),A
	dc.b	$77	; z$0EA5
	dc.b	$0f	; z$0EA6
	dc.b	$dd	; z$0EA7
	dc.b	$cb	; z$0EA8	RLC B
	dc.b	$00	; z$0EA9
	dc.b	$ee	; z$0EAA	XOR $C9
	dc.b	$c9	; z$0EAB
	dc.b	$dd	; z$0EAC	RL (IX+0)
	dc.b	$cb	; z$0EAD
	dc.b	$00	; z$0EAE
	dc.b	$ae	; z$0EAF
	dc.b	$c9	; z$0EB0	RET
	dc.b	$1a	; z$0EB1	LD A,(DE)
	dc.b	$13	; z$0EB2	INC DE
	dc.b	$6f	; z$0EB3	LD L,A
	dc.b	$26	; z$0EB4	LD H,$00
	dc.b	$00	; z$0EB5
	dc.b	$18	; z$0EB6	JR z0EBE
	dc.b	$06	; z$0EB7
	dc.b	$eb	; z$0EB8	EX DE,HL
	dc.b	$5e	; z$0EB9	LD E,(HL)
	dc.b	$23	; z$0EBA	INC HL
	dc.b	$56	; z$0EBB	LD D,(HL)
	dc.b	$23	; z$0EBC	INC HL
	dc.b	$eb	; z$0EBD	EX DE,HL
	dc.b	$4d	; z$0EBE	LD C,L
	dc.b	$44	; z$0EBF	LD B,H
	dc.b	$29	; z$0EC0	ADD HL,HL
	dc.b	$09	; z$0EC1	ADD HL,BC
	dc.b	$22	; z$0EC2	LD ($1C18),HL
	dc.b	$18	; z$0EC3
	dc.b	$1c	; z$0EC4
	dc.b	$dd	; z$0EC5	LD (IX-23),L
	dc.b	$75	; z$0EC6
	dc.b	$04	; z$0EC7
	dc.b	$dd	; z$0EC8
	dc.b	$74	; z$0EC9	LD (HL),H
	dc.b	$05	; z$0ECA	DEC B
	dc.b	$c9	; z$0ECB	RET
	dc.b	$1a	; z$0ECC	LD A,(DE)
	dc.b	$13	; z$0ECD	INC DE
	dc.b	$32	; z$0ECE	LD ($1C14),A
	dc.b	$14	; z$0ECF
	dc.b	$1c	; z$0ED0
	dc.b	$1a	; z$0ED1	LD A,(DE)
	dc.b	$13	; z$0ED2	INC DE
	dc.b	$32	; z$0ED3	LD ($1C15),A
	dc.b	$15	; z$0ED4
	dc.b	$1c	; z$0ED5
	dc.b	$c9	; z$0ED6	RET
	dc.b	$1a	; z$0ED7	LD A,(DE)
	dc.b	$13	; z$0ED8	INC DE
	dc.b	$dd	; z$0ED9	LD (IX-37),A
	dc.b	$77	; z$0EDA
	dc.b	$09	; z$0EDB
	dc.b	$c9	; z$0EDC
	dc.b	$1a	; z$0EDD	LD A,(DE)
	dc.b	$13	; z$0EDE	INC DE
	dc.b	$dd	; z$0EDF	LD (IX-37),A
	dc.b	$77	; z$0EE0
	dc.b	$0b	; z$0EE1
	dc.b	$c9	; z$0EE2
	dc.b	$1a	; z$0EE3	LD A,(DE)
	dc.b	$13	; z$0EE4	INC DE
	dc.b	$dd	; z$0EE5	LD (IX+1A),A
	dc.b	$77	; z$0EE6
	dc.b	$0c	; z$0EE7
	dc.b	$1a	; z$0EE8
	dc.b	$13	; z$0EE9	INC DE
	dc.b	$dd	; z$0EEA	LD (IX-37),A
	dc.b	$77	; z$0EEB
	dc.b	$0d	; z$0EEC
	dc.b	$c9	; z$0EED
	dc.b	$1a	; z$0EEE	LD A,(DE)
	dc.b	$13	; z$0EEF	INC DE
	dc.b	$dd	; z$0EF0	ADD A,(IX+C)
	dc.b	$86	; z$0EF1
	dc.b	$0c	; z$0EF2
	dc.b	$dd	; z$0EF3	LD (IX+1A),A
	dc.b	$77	; z$0EF4
	dc.b	$0c	; z$0EF5
	dc.b	$1a	; z$0EF6
	dc.b	$13	; z$0EF7	INC DE
	dc.b	$dd	; z$0EF8	ADC A,(IX+D)
	dc.b	$8e	; z$0EF9
	dc.b	$0d	; z$0EFA
	dc.b	$dd	; z$0EFB	LD (IX-37),A
	dc.b	$77	; z$0EFC
	dc.b	$0d	; z$0EFD
	dc.b	$c9	; z$0EFE
	dc.b	$1a	; z$0EFF	LD A,(DE)
	dc.b	$13	; z$0F00	INC DE
	dc.b	$dd	; z$0F01	LD (IX-37),A
	dc.b	$77	; z$0F02
	dc.b	$0e	; z$0F03
	dc.b	$c9	; z$0F04
	dc.b	$1a	; z$0F05	LD A,(DE)
	dc.b	$13	; z$0F06	INC DE
	dc.b	$dd	; z$0F07	ADD A,(IX+E)
	dc.b	$86	; z$0F08
	dc.b	$0e	; z$0F09
	dc.b	$dd	; z$0F0A	LD (IX-37),A
	dc.b	$77	; z$0F0B
	dc.b	$0e	; z$0F0C
	dc.b	$c9	; z$0F0D
	dc.b	$1a	; z$0F0E	LD A,(DE)
	dc.b	$13	; z$0F0F	INC DE
	dc.b	$dd	; z$0F10	LD (IX-2A),A
	dc.b	$77	; z$0F11
	dc.b	$08	; z$0F12
	dc.b	$d6	; z$0F13
	dc.b	$02	; z$0F14	LD (BC),A
	dc.b	$3e	; z$0F15	LD A,$3F
	dc.b	$3f	; z$0F16
	dc.b	$38	; z$0F17	JR C,z0F21
	dc.b	$08	; z$0F18
	dc.b	$28	; z$0F19	JR Z,z0F1F
	dc.b	$04	; z$0F1A
	dc.b	$3e	; z$0F1B	LD A,$01
	dc.b	$01	; z$0F1C
	dc.b	$18	; z$0F1D	JR z0F21
	dc.b	$02	; z$0F1E
	dc.b	$3e	; z$0F1F	LD A,$07
	dc.b	$07	; z$0F20
	dc.b	$dd	; z$0F21	LD (IX-37),A
	dc.b	$77	; z$0F22
	dc.b	$0a	; z$0F23
	dc.b	$c9	; z$0F24
	dc.b	$1a	; z$0F25	LD A,(DE)
	dc.b	$13	; z$0F26	INC DE
	dc.b	$dd	; z$0F27	LD (IX-37),A
	dc.b	$77	; z$0F28
	dc.b	$0a	; z$0F29
	dc.b	$c9	; z$0F2A
	dc.b	$dd	; z$0F2B	LD A,(IX-12)
	dc.b	$7e	; z$0F2C
	dc.b	$00	; z$0F2D
	dc.b	$ee	; z$0F2E
	dc.b	$01	; z$0F2F	LD BC,$77DD
	dc.b	$dd	; z$0F30
	dc.b	$77	; z$0F31
	dc.b	$00	; z$0F32	NOP
	dc.b	$c9	; z$0F33	RET
	dc.b	$dd	; z$0F34	LD A,(IX-1A)
	dc.b	$7e	; z$0F35
	dc.b	$11	; z$0F36
	dc.b	$e6	; z$0F37
	dc.b	$3f	; z$0F38	CCF
	dc.b	$4f	; z$0F39	LD C,A
	dc.b	$1a	; z$0F3A	LD A,(DE)
	dc.b	$13	; z$0F3B	INC DE
	dc.b	$b1	; z$0F3C	OR C
	dc.b	$dd	; z$0F3D	LD (IX-37),A
	dc.b	$77	; z$0F3E
	dc.b	$11	; z$0F3F
	dc.b	$c9	; z$0F40
	dc.b	$e1	; z$0F41	POP HL
	dc.b	$c3	; z$0F42	JP z0C79
	dc.b	$79	; z$0F43
	dc.b	$0c	; z$0F44
	dc.b	$d5	; z$0F45	PUSH DE
	dc.b	$cd	; z$0F46	CALL z02FA
	dc.b	$fa	; z$0F47
	dc.b	$02	; z$0F48
	dc.b	$d1	; z$0F49	POP DE
	dc.b	$c9	; z$0F4A	RET
	dc.b	$3e	; z$0F4B	LD A,$01
	dc.b	$01	; z$0F4C
	dc.b	$32	; z$0F4D	LD ($1C1A),A
	dc.b	$1a	; z$0F4E
	dc.b	$1c	; z$0F4F
	dc.b	$c9	; z$0F50	RET
	dc.b	$eb	; z$0F51	EX DE,HL
	dc.b	$5e	; z$0F52	LD E,(HL)
	dc.b	$23	; z$0F53	INC HL
	dc.b	$56	; z$0F54	LD D,(HL)
	dc.b	$c9	; z$0F55	RET
	dc.b	$cd	; z$0F56	CALL z0E45
	dc.b	$45	; z$0F57
	dc.b	$0e	; z$0F58
	dc.b	$2b	; z$0F59	DEC HL
	dc.b	$35	; z$0F5A	DEC (HL)
	dc.b	$20	; z$0F5B	JR NZ,z0F61
	dc.b	$04	; z$0F5C
	dc.b	$dd	; z$0F5D	DEC (IX-37)
	dc.b	$35	; z$0F5E
	dc.b	$01	; z$0F5F
	dc.b	$c9	; z$0F60
	dc.b	$2b	; z$0F61	DEC HL
	dc.b	$56	; z$0F62	LD D,(HL)
	dc.b	$2b	; z$0F63	DEC HL
	dc.b	$5e	; z$0F64	LD E,(HL)
	dc.b	$c9	; z$0F65	RET
	dc.b	$dd	; z$0F66	LD A,(IX-49)
	dc.b	$7e	; z$0F67
	dc.b	$01	; z$0F68
	dc.b	$b7	; z$0F69
	dc.b	$c2	; z$0F6A	JP NZ,z0F76
	dc.b	$76	; z$0F6B
	dc.b	$0f	; z$0F6C
	dc.b	$e1	; z$0F6D	POP HL
	dc.b	$cd	; z$0F6E	CALL z02FA
	dc.b	$fa	; z$0F6F
	dc.b	$02	; z$0F70
	dc.b	$dd	; z$0F71	LD (IX+0),$00
	dc.b	$36	; z$0F72
	dc.b	$00	; z$0F73
	dc.b	$00	; z$0F74
	dc.b	$c9	; z$0F75	RET
	dc.b	$3d	; z$0F76	DEC A
	dc.b	$cd	; z$0F77	CALL z0E48
	dc.b	$48	; z$0F78
	dc.b	$0e	; z$0F79
	dc.b	$5e	; z$0F7A	LD E,(HL)
	dc.b	$23	; z$0F7B	INC HL
	dc.b	$56	; z$0F7C	LD D,(HL)
	dc.b	$23	; z$0F7D	INC HL
	dc.b	$35	; z$0F7E	DEC (HL)
	dc.b	$20	; z$0F7F	JR NZ,z0F87
	dc.b	$06	; z$0F80
	dc.b	$dd	; z$0F81	DEC (IX+13)
	dc.b	$35	; z$0F82
	dc.b	$01	; z$0F83
	dc.b	$13	; z$0F84
	dc.b	$13	; z$0F85	INC DE
	dc.b	$c9	; z$0F86	RET
	dc.b	$eb	; z$0F87	EX DE,HL
	dc.b	$5e	; z$0F88	LD E,(HL)
	dc.b	$23	; z$0F89	INC HL
	dc.b	$56	; z$0F8A	LD D,(HL)
	dc.b	$c9	; z$0F8B	RET
Z80ContextSwitch:
	dc.b	$ed	; z$0F8C	LD ($1B82),BC
	dc.b	$43	; z$0F8D
	dc.b	$82	; z$0F8E
	dc.b	$1b	; z$0F8F
	dc.b	$ed	; z$0F90	LD ($1B84),DE
	dc.b	$53	; z$0F91
	dc.b	$84	; z$0F92
	dc.b	$1b	; z$0F93
	dc.b	$22	; z$0F94	LD ($1B86),HL
	dc.b	$86	; z$0F95
	dc.b	$1b	; z$0F96
	dc.b	$dd	; z$0F97	LD ($1B88),IX
	dc.b	$22	; z$0F98
	dc.b	$88	; z$0F99
	dc.b	$1b	; z$0F9A
	dc.b	$fd	; z$0F9B	LD ($1B8A),IY
	dc.b	$22	; z$0F9C
	dc.b	$8a	; z$0F9D
	dc.b	$1b	; z$0F9E
	dc.b	$e1	; z$0F9F	POP HL
	dc.b	$22	; z$0FA0	LD ($1B8C),HL
	dc.b	$8c	; z$0FA1
	dc.b	$1b	; z$0FA2
	dc.b	$ed	; z$0FA3	LD ($1B8E),SP
	dc.b	$73	; z$0FA4
	dc.b	$8e	; z$0FA5
	dc.b	$1b	; z$0FA6
	dc.b	$f5	; z$0FA7	PUSH SP
	dc.b	$e1	; z$0FA8	POP HL
	dc.b	$22	; z$0FA9	LD ($1B80),HL
	dc.b	$80	; z$0FAA
	dc.b	$1b	; z$0FAB
	dc.b	$08	; z$0FAC	EX AF,AF'
	dc.b	$f5	; z$0FAD	PUSH SP
	dc.b	$08	; z$0FAE	EX AF,AF'
	dc.b	$e1	; z$0FAF	POP HL
	dc.b	$22	; z$0FB0	LD ($1B90),HL
	dc.b	$90	; z$0FB1
	dc.b	$1b	; z$0FB2
	dc.b	$d9	; z$0FB3	EXX
	dc.b	$ed	; z$0FB4	LD ($1B92),BC
	dc.b	$43	; z$0FB5
	dc.b	$92	; z$0FB6
	dc.b	$1b	; z$0FB7
	dc.b	$ed	; z$0FB8	LD ($1B94),DE
	dc.b	$53	; z$0FB9
	dc.b	$94	; z$0FBA
	dc.b	$1b	; z$0FBB
	dc.b	$22	; z$0FBC	LD ($1B96),HL
	dc.b	$96	; z$0FBD
	dc.b	$1b	; z$0FBE
	dc.b	$d9	; z$0FBF	EXX
	dc.b	$3a	; z$0FC0	LD A,($1BA2)
	dc.b	$a2	; z$0FC1
	dc.b	$1b	; z$0FC2
	dc.b	$b7	; z$0FC3	OR A
	dc.b	$28	; z$0FC4	JR Z,z0FD2
	dc.b	$0c	; z$0FC5
	dc.b	$4f	; z$0FC6	LD C,A
	dc.b	$06	; z$0FC7	LD B,$00
	dc.b	$00	; z$0FC8
	dc.b	$21	; z$0FC9	LD HL,$1BA3
	dc.b	$a3	; z$0FCA
	dc.b	$1b	; z$0FCB
	dc.b	$ed	; z$0FCC	LD DE,($1BA0)
	dc.b	$5b	; z$0FCD
	dc.b	$a0	; z$0FCE
	dc.b	$1b	; z$0FCF
	dc.b	$ed	; z$0FD0	LDIR
	dc.b	$b0	; z$0FD1
	dc.b	$3a	; z$0FD2	LD A,($1BAA)
	dc.b	$aa	; z$0FD3
	dc.b	$1b	; z$0FD4
	dc.b	$b7	; z$0FD5	OR A
	dc.b	$28	; z$0FD6	JR Z,z0FE4
	dc.b	$0c	; z$0FD7
	dc.b	$4f	; z$0FD8	LD C,A
	dc.b	$06	; z$0FD9	LD B,$00
	dc.b	$00	; z$0FDA
	dc.b	$21	; z$0FDB	LD HL,$1BAB
	dc.b	$ab	; z$0FDC
	dc.b	$1b	; z$0FDD
	dc.b	$ed	; z$0FDE	LD DE,($1BA8)
	dc.b	$5b	; z$0FDF
	dc.b	$a8	; z$0FE0
	dc.b	$1b	; z$0FE1
	dc.b	$ed	; z$0FE2	LDIR
	dc.b	$b0	; z$0FE3
	dc.b	$3a	; z$0FE4	LD A,($1BB2)
	dc.b	$b2	; z$0FE5
	dc.b	$1b	; z$0FE6
	dc.b	$b7	; z$0FE7	OR A
	dc.b	$28	; z$0FE8	JR Z,z0FF6
	dc.b	$0c	; z$0FE9
	dc.b	$4f	; z$0FEA	LD C,A
	dc.b	$06	; z$0FEB	LD B,$00
	dc.b	$00	; z$0FEC
	dc.b	$21	; z$0FED	LD HL,$1BB3
	dc.b	$b3	; z$0FEE
	dc.b	$1b	; z$0FEF
	dc.b	$ed	; z$0FF0	LD DE,($1BB0)
	dc.b	$5b	; z$0FF1
	dc.b	$b0	; z$0FF2
	dc.b	$1b	; z$0FF3
	dc.b	$ed	; z$0FF4	LDIR
	dc.b	$b0	; z$0FF5
	dc.b	$3e	; z$0FF6	LD A,$01
	dc.b	$01	; z$0FF7
	dc.b	$32	; z$0FF8	LD ($1B98),A
	dc.b	$98	; z$0FF9
	dc.b	$1b	; z$0FFA
	dc.b	$32	; z$0FFB	LD ($1B99),A
	dc.b	$99	; z$0FFC
	dc.b	$1b	; z$0FFD
	dc.b	$3a	; z$0FFE	LD A,($1B99)
	dc.b	$99	; z$0FFF
	dc.b	$1b	; z$1000
	dc.b	$b7	; z$1001	OR A
	dc.b	$20	; z$1002	JR NZ,z0FFE
	dc.b	$fa	; z$1003
	dc.b	$3a	; z$1004	LD A,($1BA2)
	dc.b	$a2	; z$1005
	dc.b	$1b	; z$1006
	dc.b	$b7	; z$1007	OR A
	dc.b	$28	; z$1008	JR Z,z1022
	dc.b	$18	; z$1009
	dc.b	$4f	; z$100A	LD C,A
	dc.b	$06	; z$100B	LD B,$00
	dc.b	$00	; z$100C
	dc.b	$2a	; z$100D	LD HL,($1BA0)
	dc.b	$a0	; z$100E
	dc.b	$1b	; z$100F
	dc.b	$11	; z$1010	LD DE,$1BA3
	dc.b	$a3	; z$1011
	dc.b	$1b	; z$1012
	dc.b	$ed	; z$1013	LDIR
	dc.b	$b0	; z$1014
	dc.b	$2a	; z$1015	LD HL,($1BA0)
	dc.b	$a0	; z$1016
	dc.b	$1b	; z$1017
	dc.b	$36	; z$1018	LD (HL),$E7
	dc.b	$e7	; z$1019
	dc.b	$23	; z$101A	INC HL
	dc.b	$3d	; z$101B	DEC A
	dc.b	$28	; z$101C	JR Z,z1022
	dc.b	$04	; z$101D
	dc.b	$36	; z$101E	LD (HL),$00
	dc.b	$00	; z$101F
	dc.b	$18	; z$1020	JR z101A
	dc.b	$f8	; z$1021
	dc.b	$3a	; z$1022	LD A,($1BAA)
	dc.b	$aa	; z$1023
	dc.b	$1b	; z$1024
	dc.b	$b7	; z$1025	OR A
	dc.b	$28	; z$1026	JR Z,z1040
	dc.b	$18	; z$1027
	dc.b	$4f	; z$1028	LD C,A
	dc.b	$06	; z$1029	LD B,$00
	dc.b	$00	; z$102A
	dc.b	$2a	; z$102B	LD HL,($1BA8)
	dc.b	$a8	; z$102C
	dc.b	$1b	; z$102D
	dc.b	$11	; z$102E	LD DE,$1BAB
	dc.b	$ab	; z$102F
	dc.b	$1b	; z$1030
	dc.b	$ed	; z$1031	LDIR
	dc.b	$b0	; z$1032
	dc.b	$2a	; z$1033	LD HL,($1BA8)
	dc.b	$a8	; z$1034
	dc.b	$1b	; z$1035
	dc.b	$36	; z$1036	LD (HL),$EF
	dc.b	$ef	; z$1037
	dc.b	$23	; z$1038	INC HL
	dc.b	$3d	; z$1039	DEC A
	dc.b	$28	; z$103A	JR Z,z1040
	dc.b	$04	; z$103B
	dc.b	$36	; z$103C	LD (HL),$00
	dc.b	$00	; z$103D
	dc.b	$18	; z$103E	JR z1038
	dc.b	$f8	; z$103F
	dc.b	$3a	; z$1040	LD A,($1BB2)
	dc.b	$b2	; z$1041
	dc.b	$1b	; z$1042
	dc.b	$b7	; z$1043	OR A
	dc.b	$28	; z$1044	JR Z,z105E
	dc.b	$18	; z$1045
	dc.b	$4f	; z$1046	LD C,A
	dc.b	$06	; z$1047	LD B,$00
	dc.b	$00	; z$1048
	dc.b	$2a	; z$1049	LD HL,($1BB0)
	dc.b	$b0	; z$104A
	dc.b	$1b	; z$104B
	dc.b	$11	; z$104C	LD DE,$1BB3
	dc.b	$b3	; z$104D
	dc.b	$1b	; z$104E
	dc.b	$ed	; z$104F	LDIR
	dc.b	$b0	; z$1050
	dc.b	$2a	; z$1051	LD HL,($1BB0)
	dc.b	$b0	; z$1052
	dc.b	$1b	; z$1053
	dc.b	$36	; z$1054	LD (HL),$F7
	dc.b	$f7	; z$1055
	dc.b	$23	; z$1056	INC HL
	dc.b	$3d	; z$1057	DEC A
	dc.b	$28	; z$1058	JR Z,z105E
	dc.b	$04	; z$1059
	dc.b	$36	; z$105A	LD (HL),$00
	dc.b	$00	; z$105B
	dc.b	$18	; z$105C	JR z1056
	dc.b	$f8	; z$105D
	dc.b	$ed	; z$105E	LD BC,($1B82)
	dc.b	$4b	; z$105F
	dc.b	$82	; z$1060
	dc.b	$1b	; z$1061
	dc.b	$ed	; z$1062	LD DE,($1B84)
	dc.b	$5b	; z$1063
	dc.b	$84	; z$1064
	dc.b	$1b	; z$1065
	dc.b	$ed	; z$1066	LD SP,($1B8E)
	dc.b	$7b	; z$1067
	dc.b	$8e	; z$1068
	dc.b	$1b	; z$1069
	dc.b	$2a	; z$106A	LD HL,($1B8C)
	dc.b	$8c	; z$106B
	dc.b	$1b	; z$106C
	dc.b	$e5	; z$106D	PUSH HL
	dc.b	$2a	; z$106E	LD HL,($1B80)
	dc.b	$80	; z$106F
	dc.b	$1b	; z$1070
	dc.b	$e5	; z$1071	PUSH HL
	dc.b	$2a	; z$1072	LD HL,($1B86)
	dc.b	$86	; z$1073
	dc.b	$1b	; z$1074
	dc.b	$af	; z$1075	XOR A
	dc.b	$32	; z$1076	LD ($1B98),A
	dc.b	$98	; z$1077
	dc.b	$1b	; z$1078
	dc.b	$f1	; z$1079	POP SP
	dc.b	$c9	; z$107A	RET
	dc.b	$8e	; z$107B	ADC A,(HL)
	dc.b	$02	; z$107C	LD (BC),A
	dc.b	$93	; z$107D	SUB E
	dc.b	$02	; z$107E	LD (BC),A
	dc.b	$97	; z$107F	SUB A
	dc.b	$02	; z$1080	LD (BC),A
	dc.b	$9c	; z$1081	SBC A,H
	dc.b	$02	; z$1082	LD (BC),A
	dc.b	$a1	; z$1083	AND C
	dc.b	$02	; z$1084	LD (BC),A
	dc.b	$a6	; z$1085	AND (HL)
	dc.b	$02	; z$1086	LD (BC),A
	dc.b	$ab	; z$1087	XOR E
	dc.b	$02	; z$1088	LD (BC),A
	dc.b	$b0	; z$1089	OR B
	dc.b	$02	; z$108A	LD (BC),A
	dc.b	$b5	; z$108B	OR L
	dc.b	$02	; z$108C	LD (BC),A
	dc.b	$ba	; z$108D	CP D
	dc.b	$02	; z$108E	LD (BC),A
	dc.b	$bf	; z$108F	CP A
	dc.b	$02	; z$1090	LD (BC),A
	dc.b	$c4	; z$1091	CALL NZ,zC902
	dc.b	$02	; z$1092
	dc.b	$c9	; z$1093
	dc.b	$02	; z$1094	LD (BC),A
	dc.b	$ce	; z$1095	ADC A,$02
	dc.b	$02	; z$1096
	dc.b	$d4	; z$1097	CALL NC,zD902
	dc.b	$02	; z$1098
	dc.b	$d9	; z$1099
	dc.b	$02	; z$109A	LD (BC),A
	dc.b	$de	; z$109B	SBC A,$02
	dc.b	$02	; z$109C
	dc.b	$e3	; z$109D	EX (SP),HL
	dc.b	$02	; z$109E	LD (BC),A
	dc.b	$e9	; z$109F	JP (HL)
	dc.b	$02	; z$10A0	LD (BC),A
	dc.b	$ee	; z$10A1	XOR $02
	dc.b	$02	; z$10A2
	dc.b	$f4	; z$10A3	CALL P,zF902
	dc.b	$02	; z$10A4
	dc.b	$f9	; z$10A5
	dc.b	$02	; z$10A6	LD (BC),A
	dc.b	$ff	; z$10A7	RST $38
	dc.b	$02	; z$10A8	LD (BC),A
	dc.b	$04	; z$10A9	INC B
	dc.b	$03	; z$10AA	INC BC
	dc.b	$0a	; z$10AB	LD A,(BC)
	dc.b	$03	; z$10AC	INC BC
	dc.b	$0f	; z$10AD	RRCA
	dc.b	$03	; z$10AE	INC BC
	dc.b	$15	; z$10AF	DEC D
	dc.b	$03	; z$10B0	INC BC
	dc.b	$1b	; z$10B1	DEC DE
	dc.b	$03	; z$10B2	INC BC
	dc.b	$20	; z$10B3	JR NZ,z10B8
	dc.b	$03	; z$10B4
	dc.b	$26	; z$10B5	LD H,$03
	dc.b	$03	; z$10B6
	dc.b	$2c	; z$10B7	INC L
	dc.b	$03	; z$10B8	INC BC
	dc.b	$32	; z$10B9	LD ($3803),A
	dc.b	$03	; z$10BA
	dc.b	$38	; z$10BB
	dc.b	$03	; z$10BC	INC BC
	dc.b	$3e	; z$10BD	LD A,$03
	dc.b	$03	; z$10BE
	dc.b	$44	; z$10BF	LD B,H
	dc.b	$03	; z$10C0	INC BC
	dc.b	$4a	; z$10C1	LD C,D
	dc.b	$03	; z$10C2	INC BC
	dc.b	$50	; z$10C3	LD D,B
	dc.b	$03	; z$10C4	INC BC
	dc.b	$56	; z$10C5	LD D,(HL)
	dc.b	$03	; z$10C6	INC BC
	dc.b	$5c	; z$10C7	LD E,H
	dc.b	$03	; z$10C8	INC BC
	dc.b	$63	; z$10C9	LD H,E
	dc.b	$03	; z$10CA	INC BC
	dc.b	$69	; z$10CB	LD L,C
	dc.b	$03	; z$10CC	INC BC
	dc.b	$6f	; z$10CD	LD L,A
	dc.b	$03	; z$10CE	INC BC
	dc.b	$76	; z$10CF	HALT
	dc.b	$03	; z$10D0	INC BC
	dc.b	$7c	; z$10D1	LD A,H
	dc.b	$03	; z$10D2	INC BC
	dc.b	$83	; z$10D3	ADD A,E
	dc.b	$03	; z$10D4	INC BC
	dc.b	$89	; z$10D5	ADC A,C
	dc.b	$03	; z$10D6	INC BC
	dc.b	$90	; z$10D7	SUB B
	dc.b	$03	; z$10D8	INC BC
	dc.b	$96	; z$10D9	SUB (HL)
	dc.b	$03	; z$10DA	INC BC
	dc.b	$9d	; z$10DB	SBC A,L
	dc.b	$03	; z$10DC	INC BC
	dc.b	$a4	; z$10DD	AND H
	dc.b	$03	; z$10DE	INC BC
	dc.b	$aa	; z$10DF	XOR D
	dc.b	$03	; z$10E0	INC BC
	dc.b	$b1	; z$10E1	OR C
	dc.b	$03	; z$10E2	INC BC
	dc.b	$b8	; z$10E3	CP B
	dc.b	$03	; z$10E4	INC BC
	dc.b	$bf	; z$10E5	CP A
	dc.b	$03	; z$10E6	INC BC
	dc.b	$c6	; z$10E7	ADD A,$03
	dc.b	$03	; z$10E8
	dc.b	$cd	; z$10E9	CALL zD403
	dc.b	$03	; z$10EA
	dc.b	$d4	; z$10EB
	dc.b	$03	; z$10EC	INC BC
	dc.b	$db	; z$10ED	IN A,($03)
	dc.b	$03	; z$10EE
	dc.b	$e2	; z$10EF	JP PO,zE903
	dc.b	$03	; z$10F0
	dc.b	$e9	; z$10F1
	dc.b	$03	; z$10F2	INC BC
	dc.b	$f1	; z$10F3	POP SP
	dc.b	$03	; z$10F4	INC BC
	dc.b	$f8	; z$10F5	RET M
	dc.b	$03	; z$10F6	INC BC
	dc.b	$ff	; z$10F7	RST $38
	dc.b	$03	; z$10F8	INC BC
	dc.b	$07	; z$10F9	RLCA
	dc.b	$04	; z$10FA	INC B
	dc.b	$0e	; z$10FB	LD C,$04
	dc.b	$04	; z$10FC
	dc.b	$16	; z$10FD	LD D,$04
	dc.b	$04	; z$10FE
	dc.b	$1d	; z$10FF	DEC E
	dc.b	$04	; z$1100	INC B
	dc.b	$25	; z$1101	DEC H
	dc.b	$04	; z$1102	INC B
	dc.b	$2d	; z$1103	DEC L
	dc.b	$04	; z$1104	INC B
	dc.b	$34	; z$1105	INC (HL)
	dc.b	$04	; z$1106	INC B
	dc.b	$3c	; z$1107	INC A
	dc.b	$04	; z$1108	INC B
	dc.b	$44	; z$1109	LD B,H
	dc.b	$04	; z$110A	INC B
	dc.b	$4c	; z$110B	LD C,H
	dc.b	$04	; z$110C	INC B
	dc.b	$54	; z$110D	LD D,H
	dc.b	$04	; z$110E	INC B
	dc.b	$5c	; z$110F	LD E,H
	dc.b	$04	; z$1110	INC B
	dc.b	$64	; z$1111	LD H,H
	dc.b	$04	; z$1112	INC B
	dc.b	$6c	; z$1113	LD L,H
	dc.b	$04	; z$1114	INC B
	dc.b	$74	; z$1115	LD (HL),H
	dc.b	$04	; z$1116	INC B
	dc.b	$7d	; z$1117	LD A,L
	dc.b	$04	; z$1118	INC B
	dc.b	$85	; z$1119	ADD A,L
	dc.b	$04	; z$111A	INC B
	dc.b	$8d	; z$111B	ADC A,L
	dc.b	$04	; z$111C	INC B
	dc.b	$96	; z$111D	SUB (HL)
	dc.b	$04	; z$111E	INC B
	dc.b	$9e	; z$111F	SBC A,(HL)
	dc.b	$04	; z$1120	INC B
	dc.b	$a7	; z$1121	AND A
	dc.b	$04	; z$1122	INC B
	dc.b	$af	; z$1123	XOR A
	dc.b	$04	; z$1124	INC B
	dc.b	$b8	; z$1125	CP B
	dc.b	$04	; z$1126	INC B
	dc.b	$c1	; z$1127	POP BC
	dc.b	$04	; z$1128	INC B
	dc.b	$ca	; z$1129	JP Z,zD304
	dc.b	$04	; z$112A
	dc.b	$d3	; z$112B
	dc.b	$04	; z$112C	INC B
	dc.b	$db	; z$112D	IN A,($04)
	dc.b	$04	; z$112E
	dc.b	$e4	; z$112F	CALL PO,zEE04
	dc.b	$04	; z$1130
	dc.b	$ee	; z$1131
	dc.b	$04	; z$1132	INC B
	dc.b	$f7	; z$1133	RST $30
	dc.b	$04	; z$1134	INC B
	dc.b	$00	; z$1135	NOP
	dc.b	$05	; z$1136	DEC B
	dc.b	$09	; z$1137	ADD HL,BC
	dc.b	$05	; z$1138	DEC B
	dc.b	$13	; z$1139	INC DE
	dc.b	$05	; z$113A	DEC B
	dc.b	$1c	; z$113B	INC E
	dc.b	$05	; z$113C	DEC B
	dc.b	$49	; z$113D	LD C,C
	dc.b	$03	; z$113E	INC BC
	dc.b	$43	; z$113F	LD B,E
	dc.b	$03	; z$1140	INC BC
	dc.b	$3d	; z$1141	DEC A
	dc.b	$03	; z$1142	INC BC
	dc.b	$37	; z$1143	SCF
	dc.b	$03	; z$1144	INC BC
	dc.b	$31	; z$1145	LD SP,$2B03
	dc.b	$03	; z$1146
	dc.b	$2b	; z$1147
	dc.b	$03	; z$1148	INC BC
	dc.b	$26	; z$1149	LD H,$03
	dc.b	$03	; z$114A
	dc.b	$20	; z$114B	JR NZ,z1150
	dc.b	$03	; z$114C
	dc.b	$1a	; z$114D	LD A,(DE)
	dc.b	$03	; z$114E	INC BC
	dc.b	$14	; z$114F	INC D
	dc.b	$03	; z$1150	INC BC
	dc.b	$0f	; z$1151	RRCA
	dc.b	$03	; z$1152	INC BC
	dc.b	$09	; z$1153	ADD HL,BC
	dc.b	$03	; z$1154	INC BC
	dc.b	$03	; z$1155	INC BC
	dc.b	$03	; z$1156	INC BC
	dc.b	$fe	; z$1157	CP $02
	dc.b	$02	; z$1158
	dc.b	$f8	; z$1159	RET M
	dc.b	$02	; z$115A	LD (BC),A
	dc.b	$f3	; z$115B	DI
	dc.b	$02	; z$115C	LD (BC),A
	dc.b	$ed	; z$115D	DB $ED, $02
	dc.b	$02	; z$115E
	dc.b	$e8	; z$115F	RET PE
	dc.b	$02	; z$1160	LD (BC),A
	dc.b	$e3	; z$1161	EX (SP),HL
	dc.b	$02	; z$1162	LD (BC),A
	dc.b	$dd	; z$1163	DB $IX, $02
	dc.b	$02	; z$1164
	dc.b	$d8	; z$1165	RET C
	dc.b	$02	; z$1166	LD (BC),A
	dc.b	$d3	; z$1167	OUT ($02),A
	dc.b	$02	; z$1168
	dc.b	$ce	; z$1169	ADC A,$02
	dc.b	$02	; z$116A
	dc.b	$c8	; z$116B	RET Z
	dc.b	$02	; z$116C	LD (BC),A
	dc.b	$c3	; z$116D	JP zBE02
	dc.b	$02	; z$116E
	dc.b	$be	; z$116F
	dc.b	$02	; z$1170	LD (BC),A
	dc.b	$b9	; z$1171	CP C
	dc.b	$02	; z$1172	LD (BC),A
	dc.b	$b4	; z$1173	OR H
	dc.b	$02	; z$1174	LD (BC),A
	dc.b	$af	; z$1175	XOR A
	dc.b	$02	; z$1176	LD (BC),A
	dc.b	$aa	; z$1177	XOR D
	dc.b	$02	; z$1178	LD (BC),A
	dc.b	$a5	; z$1179	AND L
	dc.b	$02	; z$117A	LD (BC),A
	dc.b	$a0	; z$117B	AND B
	dc.b	$02	; z$117C	LD (BC),A
	dc.b	$9c	; z$117D	SBC A,H
	dc.b	$02	; z$117E	LD (BC),A
	dc.b	$97	; z$117F	SUB A
	dc.b	$02	; z$1180	LD (BC),A
	dc.b	$92	; z$1181	SUB D
	dc.b	$02	; z$1182	LD (BC),A
	dc.b	$8d	; z$1183	ADC A,L
	dc.b	$02	; z$1184	LD (BC),A
	dc.b	$89	; z$1185	ADC A,C
	dc.b	$02	; z$1186	LD (BC),A
	dc.b	$84	; z$1187	ADD A,H
	dc.b	$02	; z$1188	LD (BC),A
	dc.b	$7f	; z$1189	LD A,A
	dc.b	$02	; z$118A	LD (BC),A
	dc.b	$7b	; z$118B	LD A,E
	dc.b	$02	; z$118C	LD (BC),A
	dc.b	$76	; z$118D	HALT
	dc.b	$02	; z$118E	LD (BC),A
	dc.b	$72	; z$118F	LD (HL),D
	dc.b	$02	; z$1190	LD (BC),A
	dc.b	$6d	; z$1191	LD L,L
	dc.b	$02	; z$1192	LD (BC),A
	dc.b	$69	; z$1193	LD L,C
	dc.b	$02	; z$1194	LD (BC),A
	dc.b	$64	; z$1195	LD H,H
	dc.b	$02	; z$1196	LD (BC),A
	dc.b	$60	; z$1197	LD H,B
	dc.b	$02	; z$1198	LD (BC),A
	dc.b	$5b	; z$1199	LD E,E
	dc.b	$02	; z$119A	LD (BC),A
	dc.b	$57	; z$119B	LD D,A
	dc.b	$02	; z$119C	LD (BC),A
	dc.b	$53	; z$119D	LD D,E
	dc.b	$02	; z$119E	LD (BC),A
	dc.b	$4e	; z$119F	LD C,(HL)
	dc.b	$02	; z$11A0	LD (BC),A
	dc.b	$4a	; z$11A1	LD C,D
	dc.b	$02	; z$11A2	LD (BC),A
	dc.b	$46	; z$11A3	LD B,(HL)
	dc.b	$02	; z$11A4	LD (BC),A
	dc.b	$42	; z$11A5	LD B,D
	dc.b	$02	; z$11A6	LD (BC),A
	dc.b	$3e	; z$11A7	LD A,$02
	dc.b	$02	; z$11A8
	dc.b	$39	; z$11A9	ADD HL,SP
	dc.b	$02	; z$11AA	LD (BC),A
	dc.b	$35	; z$11AB	DEC (HL)
	dc.b	$02	; z$11AC	LD (BC),A
	dc.b	$31	; z$11AD	LD SP,$2D02
	dc.b	$02	; z$11AE
	dc.b	$2d	; z$11AF
	dc.b	$02	; z$11B0	LD (BC),A
	dc.b	$29	; z$11B1	ADD HL,HL
	dc.b	$02	; z$11B2	LD (BC),A
	dc.b	$25	; z$11B3	DEC H
	dc.b	$02	; z$11B4	LD (BC),A
	dc.b	$21	; z$11B5	LD HL,$1D02
	dc.b	$02	; z$11B6
	dc.b	$1d	; z$11B7
	dc.b	$02	; z$11B8	LD (BC),A
	dc.b	$19	; z$11B9	ADD HL,DE
	dc.b	$02	; z$11BA	LD (BC),A
	dc.b	$16	; z$11BB	LD D,$02
	dc.b	$02	; z$11BC
	dc.b	$12	; z$11BD	LD (DE),A
	dc.b	$02	; z$11BE	LD (BC),A
	dc.b	$0e	; z$11BF	LD C,$02
	dc.b	$02	; z$11C0
	dc.b	$0a	; z$11C1	LD A,(BC)
	dc.b	$02	; z$11C2	LD (BC),A
	dc.b	$06	; z$11C3	LD B,$02
	dc.b	$02	; z$11C4
	dc.b	$03	; z$11C5	INC BC
	dc.b	$02	; z$11C6	LD (BC),A
	dc.b	$ff	; z$11C7	RST $38
	dc.b	$01	; z$11C8	LD BC,$01FB
	dc.b	$fb	; z$11C9
	dc.b	$01	; z$11CA
	dc.b	$f8	; z$11CB	RET M
	dc.b	$01	; z$11CC	LD BC,$01F4
	dc.b	$f4	; z$11CD
	dc.b	$01	; z$11CE
	dc.b	$f0	; z$11CF	RET P
	dc.b	$01	; z$11D0	LD BC,$01ED
	dc.b	$ed	; z$11D1
	dc.b	$01	; z$11D2
	dc.b	$e9	; z$11D3	JP (HL)
	dc.b	$01	; z$11D4	LD BC,$01E6
	dc.b	$e6	; z$11D5
	dc.b	$01	; z$11D6
	dc.b	$e2	; z$11D7	JP PO,zDF01
	dc.b	$01	; z$11D8
	dc.b	$df	; z$11D9
	dc.b	$01	; z$11DA	LD BC,$01DB
	dc.b	$db	; z$11DB
	dc.b	$01	; z$11DC
	dc.b	$d8	; z$11DD	RET C
	dc.b	$01	; z$11DE	LD BC,$01D5
	dc.b	$d5	; z$11DF
	dc.b	$01	; z$11E0
	dc.b	$d1	; z$11E1	POP DE
	dc.b	$01	; z$11E2	LD BC,$01CE
	dc.b	$ce	; z$11E3
	dc.b	$01	; z$11E4
	dc.b	$ca	; z$11E5	JP Z,zC701
	dc.b	$01	; z$11E6
	dc.b	$c7	; z$11E7
	dc.b	$01	; z$11E8	LD BC,$01C4
	dc.b	$c4	; z$11E9
	dc.b	$01	; z$11EA
	dc.b	$c1	; z$11EB	POP BC
	dc.b	$01	; z$11EC	LD BC,$01BD
	dc.b	$bd	; z$11ED
	dc.b	$01	; z$11EE
	dc.b	$ba	; z$11EF	CP D
	dc.b	$01	; z$11F0	LD BC,$01B7
	dc.b	$b7	; z$11F1
	dc.b	$01	; z$11F2
	dc.b	$b4	; z$11F3	OR H
	dc.b	$01	; z$11F4	LD BC,$01B1
	dc.b	$b1	; z$11F5
	dc.b	$01	; z$11F6
	dc.b	$ae	; z$11F7	XOR (HL)
	dc.b	$01	; z$11F8	LD BC,$01AB
	dc.b	$ab	; z$11F9
	dc.b	$01	; z$11FA
	dc.b	$a7	; z$11FB	AND A
	dc.b	$01	; z$11FC	LD BC,$01A4
	dc.b	$a4	; z$11FD
	dc.b	$01	; z$11FE
	dc.b	$00	; z$11FF	NOP
	dc.b	$00	; z$1200	NOP
	dc.b	$00	; z$1201	NOP
	dc.b	$00	; z$1202	NOP
	dc.b	$00	; z$1203	NOP
	dc.b	$01	; z$1204	LD BC,$0101
	dc.b	$01	; z$1205
	dc.b	$01	; z$1206
	dc.b	$02	; z$1207	LD (BC),A
	dc.b	$02	; z$1208	LD (BC),A
	dc.b	$03	; z$1209	INC BC
	dc.b	$03	; z$120A	INC BC
	dc.b	$04	; z$120B	INC B
	dc.b	$05	; z$120C	DEC B
	dc.b	$05	; z$120D	DEC B
	dc.b	$06	; z$120E	LD B,$07
	dc.b	$07	; z$120F
	dc.b	$08	; z$1210	EX AF,AF'
	dc.b	$09	; z$1211	ADD HL,BC
	dc.b	$0a	; z$1212	LD A,(BC)
	dc.b	$0b	; z$1213	DEC BC
	dc.b	$0d	; z$1214	DEC C
	dc.b	$0f	; z$1215	RRCA
	dc.b	$10	; z$1216	DJNZ z122A
	dc.b	$12	; z$1217
	dc.b	$14	; z$1218	INC D
	dc.b	$18	; z$1219	JR z1233
	dc.b	$18	; z$121A
	dc.b	$1a	; z$121B	LD A,(DE)
	dc.b	$1c	; z$121C	INC E
	dc.b	$1f	; z$121D	RRA
	dc.b	$21	; z$121E	LD HL,$2623
	dc.b	$23	; z$121F
	dc.b	$26	; z$1220
	dc.b	$28	; z$1221	JR Z,z124D
	dc.b	$2a	; z$1222
	dc.b	$2c	; z$1223	INC L
	dc.b	$2e	; z$1224	LD L,$30
	dc.b	$30	; z$1225
	dc.b	$32	; z$1226	LD ($3634),A
	dc.b	$34	; z$1227
	dc.b	$36	; z$1228
	dc.b	$38	; z$1229	JR C,z1265
	dc.b	$3a	; z$122A
	dc.b	$3c	; z$122B	INC A
	dc.b	$40	; z$122C	LD B,B
	dc.b	$41	; z$122D	LD B,C
	dc.b	$42	; z$122E	LD B,D
	dc.b	$43	; z$122F	LD B,E
	dc.b	$44	; z$1230	LD B,H
	dc.b	$45	; z$1231	LD B,L
	dc.b	$46	; z$1232	LD B,(HL)
	dc.b	$47	; z$1233	LD B,A
	dc.b	$48	; z$1234	LD C,B
	dc.b	$49	; z$1235	LD C,C
	dc.b	$4a	; z$1236	LD C,D
	dc.b	$4b	; z$1237	LD C,E
	dc.b	$4b	; z$1238	LD C,E
	dc.b	$4b	; z$1239	LD C,E
	dc.b	$4c	; z$123A	LD C,H
	dc.b	$4c	; z$123B	LD C,H
	dc.b	$4d	; z$123C	LD C,L
	dc.b	$4d	; z$123D	LD C,L
	dc.b	$4e	; z$123E	LD C,(HL)
	dc.b	$7f	; z$123F	LD A,A
	dc.b	$00	; z$1240	NOP
	dc.b	$00	; z$1241	NOP
	dc.b	$08	; z$1242	EX AF,AF'
	dc.b	$08	; z$1243	EX AF,AF'
	dc.b	$08	; z$1244	EX AF,AF'
	dc.b	$10	; z$1245	DJNZ z1257
	dc.b	$10	; z$1246
	dc.b	$18	; z$1247	JR z1261
	dc.b	$18	; z$1248
	dc.b	$18	; z$1249	JR z126B
	dc.b	$20	; z$124A
	dc.b	$20	; z$124B	JR NZ,z1275
	dc.b	$28	; z$124C
	dc.b	$28	; z$124D	JR Z,z1277
	dc.b	$28	; z$124E
	dc.b	$30	; z$124F	JR NC,z1281
	dc.b	$30	; z$1250
	dc.b	$30	; z$1251	JR NC,z128B
	dc.b	$38	; z$1252
	dc.b	$38	; z$1253	JR C,z128D
	dc.b	$38	; z$1254
	dc.b	$38	; z$1255	JR C,z128F
	dc.b	$38	; z$1256
	dc.b	$40	; z$1257	LD B,B
	dc.b	$40	; z$1258	LD B,B
	dc.b	$40	; z$1259	LD B,B
	dc.b	$40	; z$125A	LD B,B
	dc.b	$40	; z$125B	LD B,B
	dc.b	$40	; z$125C	LD B,B
	dc.b	$48	; z$125D	LD C,B
	dc.b	$48	; z$125E	LD C,B
	dc.b	$48	; z$125F	LD C,B
	dc.b	$48	; z$1260	LD C,B
	dc.b	$48	; z$1261	LD C,B
	dc.b	$48	; z$1262	LD C,B
	dc.b	$48	; z$1263	LD C,B
	dc.b	$50	; z$1264	LD D,B
	dc.b	$50	; z$1265	LD D,B
	dc.b	$50	; z$1266	LD D,B
	dc.b	$50	; z$1267	LD D,B
	dc.b	$50	; z$1268	LD D,B
	dc.b	$50	; z$1269	LD D,B
	dc.b	$50	; z$126A	LD D,B
	dc.b	$50	; z$126B	LD D,B
	dc.b	$58	; z$126C	LD E,B
	dc.b	$58	; z$126D	LD E,B
	dc.b	$58	; z$126E	LD E,B
	dc.b	$58	; z$126F	LD E,B
	dc.b	$58	; z$1270	LD E,B
	dc.b	$58	; z$1271	LD E,B
	dc.b	$58	; z$1272	LD E,B
	dc.b	$58	; z$1273	LD E,B
	dc.b	$58	; z$1274	LD E,B
	dc.b	$60	; z$1275	LD H,B
	dc.b	$60	; z$1276	LD H,B
	dc.b	$60	; z$1277	LD H,B
	dc.b	$60	; z$1278	LD H,B
	dc.b	$60	; z$1279	LD H,B
	dc.b	$60	; z$127A	LD H,B
	dc.b	$60	; z$127B	LD H,B
	dc.b	$68	; z$127C	LD L,B
	dc.b	$68	; z$127D	LD L,B
	dc.b	$70	; z$127E	LD (HL),B
	dc.b	$78	; z$127F	LD A,B
	dc.b	$33	; z$1280	INC SP
	dc.b	$0c	; z$1281	INC C
	dc.b	$f0	; z$1282	RET P
	dc.b	$c0	; z$1283	RET NZ
	dc.b	$21	; z$1284	LD HL,$0502
	dc.b	$02	; z$1285
	dc.b	$05	; z$1286
	dc.b	$08	; z$1287	EX AF,AF'
	dc.b	$01	; z$1288	LD BC,$2406
	dc.b	$06	; z$1289
	dc.b	$24	; z$128A
	dc.b	$77	; z$128B	LD (HL),A
	dc.b	$05	; z$128C	DEC B
	dc.b	$0c	; z$128D	INC C
	dc.b	$72	; z$128E	LD (HL),D
	dc.b	$06	; z$128F	LD B,$00
	dc.b	$00	; z$1290
	dc.b	$f4	; z$1291	CALL P,z0000
	dc.b	$00	; z$1292
	dc.b	$00	; z$1293
	dc.b	$05	; z$1294	DEC B
	dc.b	$f0	; z$1295	RET P
	dc.b	$c0	; z$1296	RET NZ
	dc.b	$18	; z$1297	JR z129D
	dc.b	$04	; z$1298
	dc.b	$07	; z$1299	RLCA
	dc.b	$18	; z$129A	JR z129F
	dc.b	$03	; z$129B
	dc.b	$07	; z$129C	RLCA
	dc.b	$13	; z$129D	INC DE
	dc.b	$02	; z$129E	LD (BC),A
	dc.b	$07	; z$129F	RLCA
	dc.b	$13	; z$12A0	INC DE
	dc.b	$01	; z$12A1	LD BC,$0007
	dc.b	$07	; z$12A2
	dc.b	$00	; z$12A3
	dc.b	$f4	; z$12A4	CALL P,z0005
	dc.b	$05	; z$12A5
	dc.b	$00	; z$12A6
	dc.b	$3c	; z$12A7	INC A
	dc.b	$f0	; z$12A8	RET P
	dc.b	$c0	; z$12A9	RET NZ
	dc.b	$14	; z$12AA	INC D
	dc.b	$01	; z$12AB	LD BC,$1808
	dc.b	$08	; z$12AC
	dc.b	$18	; z$12AD
	dc.b	$02	; z$12AE	LD (BC),A
	dc.b	$09	; z$12AF	ADD HL,BC
	dc.b	$1f	; z$12B0	RRA
	dc.b	$01	; z$12B1	LD BC,$180A
	dc.b	$0a	; z$12B2
	dc.b	$18	; z$12B3
	dc.b	$02	; z$12B4	LD (BC),A
	dc.b	$09	; z$12B5	ADD HL,BC
	dc.b	$00	; z$12B6	NOP
	dc.b	$f4	; z$12B7	CALL P,z0005
	dc.b	$05	; z$12B8
	dc.b	$00	; z$12B9
	dc.b	$05	; z$12BA	DEC B
	dc.b	$f0	; z$12BB	RET P
	dc.b	$c0	; z$12BC	RET NZ
	dc.b	$2b	; z$12BD	DEC HL
	dc.b	$01	; z$12BE	LD BC,$1407
	dc.b	$07	; z$12BF
	dc.b	$14	; z$12C0
	dc.b	$08	; z$12C1	EX AF,AF'
	dc.b	$0b	; z$12C2	DEC BC
	dc.b	$17	; z$12C3	RLA
	dc.b	$04	; z$12C4	INC B
	dc.b	$0b	; z$12C5	DEC BC
	dc.b	$11	; z$12C6	LD DE,$0B01
	dc.b	$01	; z$12C7
	dc.b	$0b	; z$12C8
	dc.b	$00	; z$12C9	NOP
	dc.b	$f4	; z$12CA	CALL P,z0000
	dc.b	$00	; z$12CB
	dc.b	$00	; z$12CC
	dc.b	$34	; z$12CD	INC (HL)
	dc.b	$f0	; z$12CE	RET P
	dc.b	$c0	; z$12CF	RET NZ
	dc.b	$1f	; z$12D0	RRA
	dc.b	$3f	; z$12D1	CCF
	dc.b	$0c	; z$12D2	INC C
	dc.b	$0f	; z$12D3	RRCA
	dc.b	$01	; z$12D4	LD BC,$1F0D
	dc.b	$0d	; z$12D5
	dc.b	$1f	; z$12D6
	dc.b	$01	; z$12D7	LD BC,$160E
	dc.b	$0e	; z$12D8
	dc.b	$16	; z$12D9
	dc.b	$01	; z$12DA	LD BC,$000F
	dc.b	$0f	; z$12DB
	dc.b	$00	; z$12DC
	dc.b	$f4	; z$12DD	CALL P,z0000
	dc.b	$00	; z$12DE
	dc.b	$00	; z$12DF
	dc.b	$34	; z$12E0	INC (HL)
	dc.b	$f0	; z$12E1	RET P
	dc.b	$c0	; z$12E2	RET NZ
	dc.b	$1a	; z$12E3	LD A,(DE)
	dc.b	$31	; z$12E4	LD SP,$1110
	dc.b	$10	; z$12E5
	dc.b	$11	; z$12E6
	dc.b	$52	; z$12E7	LD D,D
	dc.b	$11	; z$12E8	LD DE,$5020
	dc.b	$20	; z$12E9
	dc.b	$50	; z$12EA
	dc.b	$12	; z$12EB	LD (DE),A
	dc.b	$0b	; z$12EC	DEC BC
	dc.b	$30	; z$12ED	JR NC,z1300
	dc.b	$11	; z$12EE
	dc.b	$00	; z$12EF	NOP
	dc.b	$f4	; z$12F0	CALL P,z0005
	dc.b	$05	; z$12F1
	dc.b	$00	; z$12F2
	dc.b	$33	; z$12F3	INC SP
	dc.b	$f0	; z$12F4	RET P
	dc.b	$c0	; z$12F5	RET NZ
	dc.b	$16	; z$12F6	LD D,$01
	dc.b	$01	; z$12F7
	dc.b	$13	; z$12F8	INC DE
	dc.b	$13	; z$12F9	INC DE
	dc.b	$02	; z$12FA	LD (BC),A
	dc.b	$14	; z$12FB	INC D
	dc.b	$1d	; z$12FC	DEC E
	dc.b	$01	; z$12FD	LD BC,$0515
	dc.b	$15	; z$12FE
	dc.b	$05	; z$12FF
	dc.b	$02	; z$1300	LD (BC),A
	dc.b	$16	; z$1301	LD D,$00
	dc.b	$00	; z$1302
	dc.b	$e8	; z$1303	RET PE
	dc.b	$00	; z$1304	NOP
	dc.b	$00	; z$1305	NOP
	dc.b	$03	; z$1306	INC BC
	dc.b	$f0	; z$1307	RET P
	dc.b	$c0	; z$1308	RET NZ
	dc.b	$26	; z$1309	LD H,$0A
	dc.b	$0a	; z$130A
	dc.b	$13	; z$130B	INC DE
	dc.b	$25	; z$130C	DEC H
	dc.b	$03	; z$130D	INC BC
	dc.b	$17	; z$130E	RLA
	dc.b	$08	; z$130F	EX AF,AF'
	dc.b	$02	; z$1310	LD (BC),A
	dc.b	$18	; z$1311	JR z131F
	dc.b	$0c	; z$1312
	dc.b	$01	; z$1313	LD BC,$0019
	dc.b	$19	; z$1314
	dc.b	$00	; z$1315
	dc.b	$e8	; z$1316	RET PE
	dc.b	$00	; z$1317	NOP
	dc.b	$00	; z$1318	NOP
	dc.b	$38	; z$1319	JR C,z130B
	dc.b	$f0	; z$131A
	dc.b	$c0	; z$131B	RET NZ
	dc.b	$25	; z$131C	DEC H
	dc.b	$02	; z$131D	LD (BC),A
	dc.b	$1a	; z$131E	LD A,(DE)
	dc.b	$0b	; z$131F	DEC BC
	dc.b	$00	; z$1320	NOP
	dc.b	$1b	; z$1321	DEC DE
	dc.b	$0d	; z$1322	DEC C
	dc.b	$00	; z$1323	NOP
	dc.b	$1c	; z$1324	INC E
	dc.b	$0c	; z$1325	INC C
	dc.b	$01	; z$1326	LD BC,$001D
	dc.b	$1d	; z$1327
	dc.b	$00	; z$1328
	dc.b	$f4	; z$1329	CALL P,z0000
	dc.b	$00	; z$132A
	dc.b	$00	; z$132B
	dc.b	$09	; z$132C	ADD HL,BC
	dc.b	$f0	; z$132D	RET P
	dc.b	$c0	; z$132E	RET NZ
	dc.b	$16	; z$132F	LD D,$0F
	dc.b	$0f	; z$1330
	dc.b	$1e	; z$1331	LD E,$30
	dc.b	$30	; z$1332
	dc.b	$04	; z$1333	INC B
	dc.b	$1f	; z$1334	RRA
	dc.b	$20	; z$1335	JR NZ,z1338
	dc.b	$01	; z$1336
	dc.b	$20	; z$1337	JR NZ,z1345
	dc.b	$0c	; z$1338
	dc.b	$01	; z$1339	LD BC,$0021
	dc.b	$21	; z$133A
	dc.b	$00	; z$133B
	dc.b	$e8	; z$133C	RET PE
	dc.b	$00	; z$133D	NOP
	dc.b	$00	; z$133E	NOP
	dc.b	$3b	; z$133F	DEC SP
	dc.b	$f0	; z$1340	RET P
	dc.b	$c0	; z$1341	RET NZ
	dc.b	$01	; z$1342	LD BC,$2214
	dc.b	$14	; z$1343
	dc.b	$22	; z$1344
	dc.b	$15	; z$1345	DEC D
	dc.b	$03	; z$1346	INC BC
	dc.b	$23	; z$1347	INC HL
	dc.b	$08	; z$1348	EX AF,AF'
	dc.b	$02	; z$1349	LD (BC),A
	dc.b	$24	; z$134A	INC H
	dc.b	$10	; z$134B	DJNZ z134E
	dc.b	$01	; z$134C
	dc.b	$25	; z$134D	DEC H
	dc.b	$00	; z$134E	NOP
	dc.b	$f4	; z$134F	CALL P,z0000
	dc.b	$00	; z$1350
	dc.b	$00	; z$1351
	dc.b	$3c	; z$1352	INC A
	dc.b	$f0	; z$1353	RET P
	dc.b	$c0	; z$1354	RET NZ
	dc.b	$28	; z$1355	JR Z,z1365
	dc.b	$0e	; z$1356
	dc.b	$26	; z$1357	LD H,$15
	dc.b	$15	; z$1358
	dc.b	$02	; z$1359	LD (BC),A
	dc.b	$27	; z$135A	DAA
	dc.b	$1e	; z$135B	LD E,$04
	dc.b	$04	; z$135C
	dc.b	$28	; z$135D	JR Z,z136B
	dc.b	$0c	; z$135E
	dc.b	$02	; z$135F	LD (BC),A
	dc.b	$29	; z$1360	ADD HL,HL
	dc.b	$00	; z$1361	NOP
	dc.b	$f4	; z$1362	CALL P,z0000
	dc.b	$00	; z$1363
	dc.b	$00	; z$1364
	dc.b	$03	; z$1365	INC BC
	dc.b	$f0	; z$1366	RET P
	dc.b	$c0	; z$1367	RET NZ
	dc.b	$0b	; z$1368	DEC BC
	dc.b	$02	; z$1369	LD (BC),A
	dc.b	$2a	; z$136A	LD HL,($010D)
	dc.b	$0d	; z$136B
	dc.b	$01	; z$136C
	dc.b	$2b	; z$136D	DEC HL
	dc.b	$23	; z$136E	INC HL
	dc.b	$0b	; z$136F	DEC BC
	dc.b	$2a	; z$1370	LD HL,($0100)
	dc.b	$00	; z$1371
	dc.b	$01	; z$1372
	dc.b	$2c	; z$1373	INC L
	dc.b	$00	; z$1374	NOP
	dc.b	$00	; z$1375	NOP
	dc.b	$00	; z$1376	NOP
	dc.b	$00	; z$1377	NOP
	dc.b	$3d	; z$1378	DEC A
	dc.b	$f0	; z$1379	RET P
	dc.b	$c0	; z$137A	RET NZ
	dc.b	$10	; z$137B	DJNZ z137E
	dc.b	$01	; z$137C
	dc.b	$2d	; z$137D	DEC L
	dc.b	$00	; z$137E	NOP
	dc.b	$01	; z$137F	LD BC,$032E
	dc.b	$2e	; z$1380
	dc.b	$03	; z$1381
	dc.b	$02	; z$1382	LD (BC),A
	dc.b	$2f	; z$1383	CPL
	dc.b	$07	; z$1384	RLCA
	dc.b	$09	; z$1385	ADD HL,BC
	dc.b	$2f	; z$1386	CPL
	dc.b	$00	; z$1387	NOP
	dc.b	$00	; z$1388	NOP
	dc.b	$00	; z$1389	NOP
	dc.b	$00	; z$138A	NOP
	dc.b	$2b	; z$138B	DEC HL
	dc.b	$f0	; z$138C	RET P
	dc.b	$c0	; z$138D	RET NZ
	dc.b	$1d	; z$138E	DEC E
	dc.b	$61	; z$138F	LD H,C
	dc.b	$30	; z$1390	JR NC,z13B2
	dc.b	$20	; z$1391
	dc.b	$02	; z$1392	LD (BC),A
	dc.b	$30	; z$1393	JR NC,z13CB
	dc.b	$36	; z$1394
	dc.b	$23	; z$1395	INC HL
	dc.b	$30	; z$1396	JR NC,z1398
	dc.b	$00	; z$1397
	dc.b	$02	; z$1398	LD (BC),A
	dc.b	$31	; z$1399	LD SP,$0000
	dc.b	$00	; z$139A
	dc.b	$00	; z$139B
	dc.b	$00	; z$139C	NOP
	dc.b	$00	; z$139D	NOP
	dc.b	$04	; z$139E	INC B
	dc.b	$f0	; z$139F	RET P
	dc.b	$c0	; z$13A0	RET NZ
	dc.b	$16	; z$13A1	LD D,$07
	dc.b	$07	; z$13A2
	dc.b	$32	; z$13A3	LD ($0500),A
	dc.b	$00	; z$13A4
	dc.b	$05	; z$13A5
	dc.b	$33	; z$13A6	INC SP
	dc.b	$20	; z$13A7	JR NZ,z1422
	dc.b	$79	; z$13A8
	dc.b	$32	; z$13A9	LD ($7100),A
	dc.b	$00	; z$13AA
	dc.b	$71	; z$13AB
	dc.b	$33	; z$13AC	INC SP
	dc.b	$00	; z$13AD	NOP
	dc.b	$00	; z$13AE	NOP
	dc.b	$00	; z$13AF	NOP
	dc.b	$00	; z$13B0	NOP
	dc.b	$3c	; z$13B1	INC A
	dc.b	$f0	; z$13B2	RET P
	dc.b	$c0	; z$13B3	RET NZ
	dc.b	$07	; z$13B4	RLCA
	dc.b	$0f	; z$13B5	RRCA
	dc.b	$34	; z$13B6	INC (HL)
	dc.b	$08	; z$13B7	EX AF,AF'
	dc.b	$00	; z$13B8	NOP
	dc.b	$35	; z$13B9	DEC (HL)
	dc.b	$16	; z$13BA	LD D,$02
	dc.b	$02	; z$13BB
	dc.b	$36	; z$13BC	LD (HL),$00
	dc.b	$00	; z$13BD
	dc.b	$00	; z$13BE	NOP
	dc.b	$37	; z$13BF	SCF
	dc.b	$00	; z$13C0	NOP
	dc.b	$00	; z$13C1	NOP
	dc.b	$00	; z$13C2	NOP
	dc.b	$00	; z$13C3	NOP
	dc.b	$00	; z$13C4	NOP
	dc.b	$f0	; z$13C5	RET P
	dc.b	$c0	; z$13C6	RET NZ
	dc.b	$2d	; z$13C7	DEC L
	dc.b	$02	; z$13C8	LD (BC),A
	dc.b	$38	; z$13C9	JR C,z13E8
	dc.b	$1d	; z$13CA
	dc.b	$0f	; z$13CB	RRCA
	dc.b	$39	; z$13CC	ADD HL,SP
	dc.b	$10	; z$13CD	DJNZ z13D2
	dc.b	$03	; z$13CE
	dc.b	$3a	; z$13CF	LD A,($0107)
	dc.b	$07	; z$13D0
	dc.b	$01	; z$13D1
	dc.b	$3b	; z$13D2	DEC SP
	dc.b	$00	; z$13D3	NOP
	dc.b	$00	; z$13D4	NOP
	dc.b	$02	; z$13D5	LD (BC),A
	dc.b	$00	; z$13D6	NOP
	dc.b	$3b	; z$13D7	DEC SP
	dc.b	$f0	; z$13D8	RET P
	dc.b	$c0	; z$13D9	RET NZ
	dc.b	$05	; z$13DA	DEC B
	dc.b	$0c	; z$13DB	INC C
	dc.b	$3c	; z$13DC	INC A
	dc.b	$0a	; z$13DD	LD A,(BC)
	dc.b	$07	; z$13DE	RLCA
	dc.b	$3d	; z$13DF	DEC A
	dc.b	$1d	; z$13E0	DEC E
	dc.b	$79	; z$13E1	LD A,C
	dc.b	$3e	; z$13E2	LD A,$00
	dc.b	$00	; z$13E3
	dc.b	$72	; z$13E4	LD (HL),D
	dc.b	$3f	; z$13E5	CCF
	dc.b	$00	; z$13E6	NOP
	dc.b	$00	; z$13E7	NOP
	dc.b	$00	; z$13E8	NOP
	dc.b	$00	; z$13E9	NOP
	dc.b	$39	; z$13EA	ADD HL,SP
	dc.b	$d0	; z$13EB	RET NC
	dc.b	$c0	; z$13EC	RET NZ
	dc.b	$00	; z$13ED	NOP
	dc.b	$01	; z$13EE	LD BC,$7F40
	dc.b	$40	; z$13EF
	dc.b	$7f	; z$13F0
	dc.b	$00	; z$13F1	NOP
	dc.b	$00	; z$13F2	NOP
	dc.b	$2e	; z$13F3	LD L,$79
	dc.b	$79	; z$13F4
	dc.b	$41	; z$13F5	LD B,C
	dc.b	$0c	; z$13F6	INC C
	dc.b	$78	; z$13F7	LD A,B
	dc.b	$42	; z$13F8	LD B,D
	dc.b	$00	; z$13F9	NOP
	dc.b	$00	; z$13FA	NOP
	dc.b	$00	; z$13FB	NOP
	dc.b	$00	; z$13FC	NOP
	dc.b	$39	; z$13FD	ADD HL,SP
	dc.b	$b0	; z$13FE	OR B
	dc.b	$c0	; z$13FF	RET NZ
	dc.b	$00	; z$1400	NOP
	dc.b	$01	; z$1401	LD BC,$7F40
	dc.b	$40	; z$1402
	dc.b	$7f	; z$1403
	dc.b	$00	; z$1404	NOP
	dc.b	$00	; z$1405	NOP
	dc.b	$2c	; z$1406	INC L
	dc.b	$79	; z$1407	LD A,C
	dc.b	$41	; z$1408	LD B,C
	dc.b	$08	; z$1409	EX AF,AF'
	dc.b	$78	; z$140A	LD A,B
	dc.b	$43	; z$140B	LD B,E
	dc.b	$00	; z$140C	NOP
	dc.b	$00	; z$140D	NOP
	dc.b	$00	; z$140E	NOP
	dc.b	$00	; z$140F	NOP
	dc.b	$3c	; z$1410	INC A
	dc.b	$f0	; z$1411	RET P
	dc.b	$c0	; z$1412	RET NZ
	dc.b	$28	; z$1413	JR Z,z1417
	dc.b	$02	; z$1414
	dc.b	$44	; z$1415	LD B,H
	dc.b	$0c	; z$1416	INC C
	dc.b	$01	; z$1417	LD BC,$2845
	dc.b	$45	; z$1418
	dc.b	$28	; z$1419
	dc.b	$72	; z$141A	LD (HL),D
	dc.b	$44	; z$141B	LD B,H
	dc.b	$18	; z$141C	JR z148F
	dc.b	$71	; z$141D
	dc.b	$45	; z$141E	LD B,L
	dc.b	$00	; z$141F	NOP
	dc.b	$00	; z$1420	NOP
	dc.b	$00	; z$1421	NOP
	dc.b	$00	; z$1422	NOP
	dc.b	$04	; z$1423	INC B
	dc.b	$f0	; z$1424	RET P
	dc.b	$c0	; z$1425	RET NZ
	dc.b	$12	; z$1426	LD (DE),A
	dc.b	$14	; z$1427	INC D
	dc.b	$46	; z$1428	LD B,(HL)
	dc.b	$16	; z$1429	LD D,$14
	dc.b	$14	; z$142A
	dc.b	$47	; z$142B	LD B,A
	dc.b	$12	; z$142C	LD (DE),A
	dc.b	$08	; z$142D	EX AF,AF'
	dc.b	$46	; z$142E	LD B,(HL)
	dc.b	$16	; z$142F	LD D,$04
	dc.b	$04	; z$1430
	dc.b	$47	; z$1431	LD B,A
	dc.b	$00	; z$1432	NOP
	dc.b	$00	; z$1433	NOP
	dc.b	$00	; z$1434	NOP
	dc.b	$00	; z$1435	NOP
	dc.b	$04	; z$1436	INC B
	dc.b	$f0	; z$1437	RET P
	dc.b	$c0	; z$1438	RET NZ
	dc.b	$07	; z$1439	RLCA
	dc.b	$06	; z$143A	LD B,$48
	dc.b	$48	; z$143B
	dc.b	$03	; z$143C	INC BC
	dc.b	$01	; z$143D	LD BC,$1549
	dc.b	$49	; z$143E
	dc.b	$15	; z$143F
	dc.b	$01	; z$1440	LD BC,$034A
	dc.b	$4a	; z$1441
	dc.b	$03	; z$1442
	dc.b	$00	; z$1443	NOP
	dc.b	$4b	; z$1444	LD C,E
	dc.b	$00	; z$1445	NOP
	dc.b	$00	; z$1446	NOP
	dc.b	$02	; z$1447	LD (BC),A
	dc.b	$00	; z$1448	NOP
	dc.b	$3b	; z$1449	DEC SP
	dc.b	$f0	; z$144A	RET P
	dc.b	$c0	; z$144B	RET NZ
	dc.b	$00	; z$144C	NOP
	dc.b	$08	; z$144D	EX AF,AF'
	dc.b	$4c	; z$144E	LD C,H
	dc.b	$20	; z$144F	JR NZ,z1460
	dc.b	$0f	; z$1450
	dc.b	$4d	; z$1451	LD C,L
	dc.b	$3d	; z$1452	DEC A
	dc.b	$0f	; z$1453	RRCA
	dc.b	$4e	; z$1454	LD C,(HL)
	dc.b	$04	; z$1455	INC B
	dc.b	$0c	; z$1456	INC C
	dc.b	$4f	; z$1457	LD C,A
	dc.b	$00	; z$1458	NOP
	dc.b	$00	; z$1459	NOP
	dc.b	$00	; z$145A	NOP
	dc.b	$00	; z$145B	NOP
	dc.b	$3b	; z$145C	DEC SP
	dc.b	$f0	; z$145D	RET P
	dc.b	$c0	; z$145E	RET NZ
	dc.b	$00	; z$145F	NOP
	dc.b	$08	; z$1460	EX AF,AF'
	dc.b	$4c	; z$1461	LD C,H
	dc.b	$20	; z$1462	JR NZ,z1473
	dc.b	$0f	; z$1463
	dc.b	$4d	; z$1464	LD C,L
	dc.b	$3d	; z$1465	DEC A
	dc.b	$0f	; z$1466	RRCA
	dc.b	$4e	; z$1467	LD C,(HL)
	dc.b	$06	; z$1468	LD B,$0C
	dc.b	$0c	; z$1469
	dc.b	$50	; z$146A	LD D,B
	dc.b	$00	; z$146B	NOP
	dc.b	$00	; z$146C	NOP
	dc.b	$00	; z$146D	NOP
	dc.b	$00	; z$146E	NOP
	dc.b	$3b	; z$146F	DEC SP
	dc.b	$f0	; z$1470	RET P
	dc.b	$c0	; z$1471	RET NZ
	dc.b	$04	; z$1472	INC B
	dc.b	$03	; z$1473	INC BC
	dc.b	$4c	; z$1474	LD C,H
	dc.b	$06	; z$1475	LD B,$01
	dc.b	$01	; z$1476
	dc.b	$4d	; z$1477	LD C,L
	dc.b	$22	; z$1478	LD ($4E04),HL
	dc.b	$04	; z$1479
	dc.b	$4e	; z$147A
	dc.b	$05	; z$147B	DEC B
	dc.b	$00	; z$147C	NOP
	dc.b	$51	; z$147D	LD D,C
	dc.b	$00	; z$147E	NOP
	dc.b	$00	; z$147F	NOP
	dc.b	$00	; z$1480	NOP
	dc.b	$00	; z$1481	NOP
	dc.b	$39	; z$1482	ADD HL,SP
	dc.b	$f0	; z$1483	RET P
	dc.b	$c0	; z$1484	RET NZ
	dc.b	$10	; z$1485	DJNZ z1494
	dc.b	$0d	; z$1486
	dc.b	$52	; z$1487	LD D,D
	dc.b	$25	; z$1488	DEC H
	dc.b	$06	; z$1489	LD B,$52
	dc.b	$52	; z$148A
	dc.b	$23	; z$148B	INC HL
	dc.b	$01	; z$148C	LD BC,$0052
	dc.b	$52	; z$148D
	dc.b	$00	; z$148E
	dc.b	$01	; z$148F	LD BC,$0053
	dc.b	$53	; z$1490
	dc.b	$00	; z$1491
	dc.b	$00	; z$1492	NOP
	dc.b	$00	; z$1493	NOP
	dc.b	$00	; z$1494	NOP
	dc.b	$14	; z$1495	INC D
	dc.b	$f0	; z$1496	RET P
	dc.b	$c0	; z$1497	RET NZ
	dc.b	$2a	; z$1498	LD HL,($540D)
	dc.b	$0d	; z$1499
	dc.b	$54	; z$149A
	dc.b	$10	; z$149B	DJNZ z14A1
	dc.b	$04	; z$149C
	dc.b	$55	; z$149D	LD D,L
	dc.b	$2c	; z$149E	INC L
	dc.b	$76	; z$149F	HALT
	dc.b	$54	; z$14A0	LD D,H
	dc.b	$10	; z$14A1	DJNZ z1514
	dc.b	$71	; z$14A2
	dc.b	$55	; z$14A3	LD D,L
	dc.b	$00	; z$14A4	NOP
	dc.b	$f4	; z$14A5	CALL P,z0001
	dc.b	$01	; z$14A6
	dc.b	$00	; z$14A7
	dc.b	$0c	; z$14A8	INC C
	dc.b	$f0	; z$14A9	RET P
	dc.b	$c0	; z$14AA	RET NZ
	dc.b	$2c	; z$14AB	INC L
	dc.b	$03	; z$14AC	INC BC
	dc.b	$05	; z$14AD	DEC B
	dc.b	$10	; z$14AE	DJNZ z14B1
	dc.b	$01	; z$14AF
	dc.b	$56	; z$14B0	LD D,(HL)
	dc.b	$24	; z$14B1	INC H
	dc.b	$7e	; z$14B2	LD A,(HL)
	dc.b	$05	; z$14B3	DEC B
	dc.b	$08	; z$14B4	EX AF,AF'
	dc.b	$48	; z$14B5	LD C,B
	dc.b	$57	; z$14B6	LD D,A
	dc.b	$00	; z$14B7	NOP
	dc.b	$f4	; z$14B8	CALL P,z0001
	dc.b	$01	; z$14B9
	dc.b	$00	; z$14BA
	dc.b	$39	; z$14BB	ADD HL,SP
	dc.b	$d0	; z$14BC	RET NC
	dc.b	$c0	; z$14BD	RET NZ
	dc.b	$00	; z$14BE	NOP
	dc.b	$01	; z$14BF	LD BC,$7F40
	dc.b	$40	; z$14C0
	dc.b	$7f	; z$14C1
	dc.b	$00	; z$14C2	NOP
	dc.b	$00	; z$14C3	NOP
	dc.b	$2c	; z$14C4	INC L
	dc.b	$79	; z$14C5	LD A,C
	dc.b	$41	; z$14C6	LD B,C
	dc.b	$08	; z$14C7	EX AF,AF'
	dc.b	$78	; z$14C8	LD A,B
	dc.b	$43	; z$14C9	LD B,E
	dc.b	$00	; z$14CA	NOP
	dc.b	$00	; z$14CB	NOP
	dc.b	$00	; z$14CC	NOP
	dc.b	$00	; z$14CD	NOP
	dc.b	$0c	; z$14CE	INC C
	dc.b	$f0	; z$14CF	RET P
	dc.b	$c0	; z$14D0	RET NZ
	dc.b	$22	; z$14D1	LD ($5844),HL
	dc.b	$44	; z$14D2
	dc.b	$58	; z$14D3
	dc.b	$13	; z$14D4	INC DE
	dc.b	$43	; z$14D5	LD B,E
	dc.b	$59	; z$14D6	LD E,C
	dc.b	$1c	; z$14D7	INC E
	dc.b	$72	; z$14D8	LD (HL),D
	dc.b	$59	; z$14D9	LD E,C
	dc.b	$10	; z$14DA	DJNZ z14DD
	dc.b	$01	; z$14DB
	dc.b	$5a	; z$14DC	LD E,D
	dc.b	$00	; z$14DD	NOP
	dc.b	$f4	; z$14DE	CALL P,z0000
	dc.b	$00	; z$14DF
	dc.b	$00	; z$14E0
	dc.b	$14	; z$14E1	INC D
	dc.b	$f0	; z$14E2	RET P
	dc.b	$c0	; z$14E3	RET NZ
	dc.b	$1a	; z$14E4	LD A,(DE)
	dc.b	$01	; z$14E5	LD BC,$105B
	dc.b	$5b	; z$14E6
	dc.b	$10	; z$14E7
	dc.b	$61	; z$14E8	LD H,C
	dc.b	$5c	; z$14E9	LD E,H
	dc.b	$1c	; z$14EA	INC E
	dc.b	$67	; z$14EB	LD H,A
	dc.b	$5d	; z$14EC	LD E,L
	dc.b	$10	; z$14ED	DJNZ z14F0
	dc.b	$01	; z$14EE
	dc.b	$5e	; z$14EF	LD E,(HL)
	dc.b	$00	; z$14F0	NOP
	dc.b	$f4	; z$14F1	CALL P,z0000
	dc.b	$00	; z$14F2
	dc.b	$00	; z$14F3
	dc.b	$3c	; z$14F4	INC A
	dc.b	$f0	; z$14F5	RET P
	dc.b	$c0	; z$14F6	RET NZ
	dc.b	$1c	; z$14F7	INC E
	dc.b	$72	; z$14F8	LD (HL),D
	dc.b	$5f	; z$14F9	LD E,A
	dc.b	$13	; z$14FA	INC DE
	dc.b	$72	; z$14FB	LD (HL),D
	dc.b	$60	; z$14FC	LD H,B
	dc.b	$21	; z$14FD	LD HL,$5F34
	dc.b	$34	; z$14FE
	dc.b	$5f	; z$14FF
	dc.b	$13	; z$1500	INC DE
	dc.b	$32	; z$1501	LD ($0060),A
	dc.b	$60	; z$1502
	dc.b	$00	; z$1503
	dc.b	$e8	; z$1504	RET PE
	dc.b	$01	; z$1505	LD BC,$2200
	dc.b	$00	; z$1506
	dc.b	$22	; z$1507
	dc.b	$f0	; z$1508	RET P
	dc.b	$c0	; z$1509	RET NZ
	dc.b	$28	; z$150A	JR Z,z1581
	dc.b	$75	; z$150B
	dc.b	$61	; z$150C	LD H,C
	dc.b	$32	; z$150D	LD ($6243),A
	dc.b	$43	; z$150E
	dc.b	$62	; z$150F
	dc.b	$1a	; z$1510	LD A,(DE)
	dc.b	$20	; z$1511	JR NZ,z1574
	dc.b	$61	; z$1512
	dc.b	$10	; z$1513	DJNZ z1545
	dc.b	$30	; z$1514
	dc.b	$63	; z$1515	LD H,E
	dc.b	$00	; z$1516	NOP
	dc.b	$00	; z$1517	NOP
	dc.b	$01	; z$1518	LD BC,$1200
	dc.b	$00	; z$1519
	dc.b	$12	; z$151A
	dc.b	$f0	; z$151B	RET P
	dc.b	$c0	; z$151C	RET NZ
	dc.b	$20	; z$151D	JR NZ,z1570
	dc.b	$51	; z$151E
	dc.b	$64	; z$151F	LD H,H
	dc.b	$2b	; z$1520	DEC HL
	dc.b	$05	; z$1521	DEC B
	dc.b	$65	; z$1522	LD H,L
	dc.b	$28	; z$1523	JR Z,z1555
	dc.b	$30	; z$1524
	dc.b	$66	; z$1525	LD H,(HL)
	dc.b	$0c	; z$1526	INC C
	dc.b	$30	; z$1527	JR NC,z1590
	dc.b	$67	; z$1528
	dc.b	$00	; z$1529	NOP
	dc.b	$00	; z$152A	NOP
	dc.b	$00	; z$152B	NOP
	dc.b	$00	; z$152C	NOP
	dc.b	$3c	; z$152D	INC A
	dc.b	$f0	; z$152E	RET P
	dc.b	$c0	; z$152F	RET NZ
	dc.b	$2a	; z$1530	LD HL,($683C)
	dc.b	$3c	; z$1531
	dc.b	$68	; z$1532
	dc.b	$12	; z$1533	LD (DE),A
	dc.b	$21	; z$1534	LD HL,$2069
	dc.b	$69	; z$1535
	dc.b	$20	; z$1536
	dc.b	$31	; z$1537	LD SP,$1068
	dc.b	$68	; z$1538
	dc.b	$10	; z$1539
	dc.b	$71	; z$153A	LD (HL),C
	dc.b	$6a	; z$153B	LD L,D
	dc.b	$00	; z$153C	NOP
	dc.b	$f4	; z$153D	CALL P,z0000
	dc.b	$00	; z$153E
	dc.b	$00	; z$153F
	dc.b	$12	; z$1540	LD (DE),A
	dc.b	$f0	; z$1541	RET P
	dc.b	$c0	; z$1542	RET NZ
	dc.b	$2f	; z$1543	CPL
	dc.b	$51	; z$1544	LD D,C
	dc.b	$64	; z$1545	LD H,H
	dc.b	$28	; z$1546	JR Z,z154D
	dc.b	$05	; z$1547
	dc.b	$65	; z$1548	LD H,L
	dc.b	$24	; z$1549	INC H
	dc.b	$30	; z$154A	JR NC,z15B2
	dc.b	$66	; z$154B
	dc.b	$0f	; z$154C	RRCA
	dc.b	$31	; z$154D	LD SP,$006B
	dc.b	$6b	; z$154E
	dc.b	$00	; z$154F
	dc.b	$00	; z$1550	NOP
	dc.b	$00	; z$1551	NOP
	dc.b	$00	; z$1552	NOP
	dc.b	$04	; z$1553	INC B
	dc.b	$f0	; z$1554	RET P
	dc.b	$c0	; z$1555	RET NZ
	dc.b	$07	; z$1556	RLCA
	dc.b	$06	; z$1557	LD B,$48
	dc.b	$48	; z$1558
	dc.b	$0c	; z$1559	INC C
	dc.b	$01	; z$155A	LD BC,$1549
	dc.b	$49	; z$155B
	dc.b	$15	; z$155C
	dc.b	$01	; z$155D	LD BC,$0C4A
	dc.b	$4a	; z$155E
	dc.b	$0c	; z$155F
	dc.b	$00	; z$1560	NOP
	dc.b	$4b	; z$1561	LD C,E
	dc.b	$00	; z$1562	NOP
	dc.b	$f4	; z$1563	CALL P,z0001
	dc.b	$01	; z$1564
	dc.b	$00	; z$1565
	dc.b	$28	; z$1566	JR Z,z1558
	dc.b	$f0	; z$1567
	dc.b	$c0	; z$1568	RET NZ
	dc.b	$1f	; z$1569	RRA
	dc.b	$08	; z$156A	EX AF,AF'
	dc.b	$6c	; z$156B	LD L,H
	dc.b	$22	; z$156C	LD ($6D33),HL
	dc.b	$33	; z$156D
	dc.b	$6d	; z$156E
	dc.b	$28	; z$156F	JR Z,z1574
	dc.b	$03	; z$1570
	dc.b	$5e	; z$1571	LD E,(HL)
	dc.b	$0c	; z$1572	INC C
	dc.b	$01	; z$1573	LD BC,$005C
	dc.b	$5c	; z$1574
	dc.b	$00	; z$1575
	dc.b	$f4	; z$1576	CALL P,z0001
	dc.b	$01	; z$1577
	dc.b	$00	; z$1578
	dc.b	$3a	; z$1579	LD A,($C0F0)
	dc.b	$f0	; z$157A
	dc.b	$c0	; z$157B
	dc.b	$20	; z$157C	JR NZ,z15B2
	dc.b	$34	; z$157D
	dc.b	$6e	; z$157E	LD L,(HL)
	dc.b	$18	; z$157F	JR z15E3
	dc.b	$62	; z$1580
	dc.b	$6f	; z$1581	LD L,A
	dc.b	$18	; z$1582	JR z15B8
	dc.b	$34	; z$1583
	dc.b	$70	; z$1584	LD (HL),B
	dc.b	$12	; z$1585	LD (DE),A
	dc.b	$32	; z$1586	LD ($0071),A
	dc.b	$71	; z$1587
	dc.b	$00	; z$1588
	dc.b	$e8	; z$1589	RET PE
	dc.b	$05	; z$158A	DEC B
	dc.b	$00	; z$158B	NOP
	dc.b	$3e	; z$158C	LD A,$F0
	dc.b	$f0	; z$158D
	dc.b	$c0	; z$158E	RET NZ
	dc.b	$24	; z$158F	INC H
	dc.b	$74	; z$1590	LD (HL),H
	dc.b	$72	; z$1591	LD (HL),D
	dc.b	$16	; z$1592	LD D,$01
	dc.b	$01	; z$1593
	dc.b	$73	; z$1594	LD (HL),E
	dc.b	$0f	; z$1595	RRCA
	dc.b	$71	; z$1596	LD (HL),C
	dc.b	$73	; z$1597	LD (HL),E
	dc.b	$0f	; z$1598	RRCA
	dc.b	$02	; z$1599	LD (BC),A
	dc.b	$73	; z$159A	LD (HL),E
	dc.b	$00	; z$159B	NOP
	dc.b	$f4	; z$159C	CALL P,z0005
	dc.b	$05	; z$159D
	dc.b	$00	; z$159E
	dc.b	$12	; z$159F	LD (DE),A
	dc.b	$f0	; z$15A0	RET P
	dc.b	$c0	; z$15A1	RET NZ
	dc.b	$2f	; z$15A2	CPL
	dc.b	$51	; z$15A3	LD D,C
	dc.b	$64	; z$15A4	LD H,H
	dc.b	$28	; z$15A5	JR Z,z15AC
	dc.b	$05	; z$15A6
	dc.b	$65	; z$15A7	LD H,L
	dc.b	$24	; z$15A8	INC H
	dc.b	$30	; z$15A9	JR NC,z1611
	dc.b	$66	; z$15AA
	dc.b	$0f	; z$15AB	RRCA
	dc.b	$31	; z$15AC	LD SP,$006B
	dc.b	$6b	; z$15AD
	dc.b	$00	; z$15AE
	dc.b	$00	; z$15AF	NOP
	dc.b	$08	; z$15B0	EX AF,AF'
	dc.b	$00	; z$15B1	NOP
	dc.b	$3e	; z$15B2	LD A,$F0
	dc.b	$f0	; z$15B3
	dc.b	$c0	; z$15B4	RET NZ
	dc.b	$24	; z$15B5	INC H
	dc.b	$74	; z$15B6	LD (HL),H
	dc.b	$72	; z$15B7	LD (HL),D
	dc.b	$16	; z$15B8	LD D,$01
	dc.b	$01	; z$15B9
	dc.b	$73	; z$15BA	LD (HL),E
	dc.b	$0f	; z$15BB	RRCA
	dc.b	$71	; z$15BC	LD (HL),C
	dc.b	$73	; z$15BD	LD (HL),E
	dc.b	$0f	; z$15BE	RRCA
	dc.b	$02	; z$15BF	LD (BC),A
	dc.b	$73	; z$15C0	LD (HL),E
	dc.b	$00	; z$15C1	NOP
	dc.b	$f4	; z$15C2	CALL P,z0009
	dc.b	$09	; z$15C3
	dc.b	$00	; z$15C4
	dc.b	$3b	; z$15C5	DEC SP
	dc.b	$f0	; z$15C6	RET P
	dc.b	$c0	; z$15C7	RET NZ
	dc.b	$01	; z$15C8	LD BC,$2214
	dc.b	$14	; z$15C9
	dc.b	$22	; z$15CA
	dc.b	$15	; z$15CB	DEC D
	dc.b	$03	; z$15CC	INC BC
	dc.b	$23	; z$15CD	INC HL
	dc.b	$08	; z$15CE	EX AF,AF'
	dc.b	$02	; z$15CF	LD (BC),A
	dc.b	$24	; z$15D0	INC H
	dc.b	$0c	; z$15D1	INC C
	dc.b	$01	; z$15D2	LD BC,$0025
	dc.b	$25	; z$15D3
	dc.b	$00	; z$15D4
	dc.b	$f4	; z$15D5	CALL P,z000A
	dc.b	$0a	; z$15D6
	dc.b	$00	; z$15D7
	dc.b	$3c	; z$15D8	INC A
	dc.b	$f0	; z$15D9	RET P
	dc.b	$c0	; z$15DA	RET NZ
	dc.b	$15	; z$15DB	DEC D
	dc.b	$03	; z$15DC	INC BC
	dc.b	$34	; z$15DD	INC (HL)
	dc.b	$06	; z$15DE	LD B,$06
	dc.b	$06	; z$15DF
	dc.b	$35	; z$15E0	DEC (HL)
	dc.b	$16	; z$15E1	LD D,$0B
	dc.b	$0b	; z$15E2
	dc.b	$36	; z$15E3	LD (HL),$02
	dc.b	$02	; z$15E4
	dc.b	$01	; z$15E5	LD BC,$0037
	dc.b	$37	; z$15E6
	dc.b	$00	; z$15E7
	dc.b	$00	; z$15E8	NOP
	dc.b	$00	; z$15E9	NOP
	dc.b	$00	; z$15EA	NOP
	dc.b	$30	; z$15EB	JR NC,z15DD
	dc.b	$f0	; z$15EC
	dc.b	$c0	; z$15ED	RET NZ
	dc.b	$10	; z$15EE	DJNZ z1620
	dc.b	$30	; z$15EF
	dc.b	$74	; z$15F0	LD (HL),H
	dc.b	$04	; z$15F1	INC B
	dc.b	$31	; z$15F2	LD SP,$2075
	dc.b	$75	; z$15F3
	dc.b	$20	; z$15F4
	dc.b	$31	; z$15F5	LD SP,$0475
	dc.b	$75	; z$15F6
	dc.b	$04	; z$15F7
	dc.b	$31	; z$15F8	LD SP,$0039
	dc.b	$39	; z$15F9
	dc.b	$00	; z$15FA
	dc.b	$0c	; z$15FB	INC C
	dc.b	$00	; z$15FC	NOP
	dc.b	$00	; z$15FD	NOP
	dc.b	$04	; z$15FE	INC B
	dc.b	$f0	; z$15FF	RET P
	dc.b	$c0	; z$1600	RET NZ
	dc.b	$1c	; z$1601	INC E
	dc.b	$06	; z$1602	LD B,$48
	dc.b	$48	; z$1603
	dc.b	$04	; z$1604	INC B
	dc.b	$01	; z$1605	LD BC,$1576
	dc.b	$76	; z$1606
	dc.b	$15	; z$1607
	dc.b	$01	; z$1608	LD BC,$044A
	dc.b	$4a	; z$1609
	dc.b	$04	; z$160A
	dc.b	$00	; z$160B	NOP
	dc.b	$76	; z$160C	HALT
	dc.b	$00	; z$160D	NOP
	dc.b	$f4	; z$160E	CALL P,z000A
	dc.b	$0a	; z$160F
	dc.b	$00	; z$1610
	dc.b	$33	; z$1611	INC SP
	dc.b	$f0	; z$1612	RET P
	dc.b	$c0	; z$1613	RET NZ
	dc.b	$16	; z$1614	LD D,$01
	dc.b	$01	; z$1615
	dc.b	$13	; z$1616	INC DE
	dc.b	$13	; z$1617	INC DE
	dc.b	$02	; z$1618	LD (BC),A
	dc.b	$14	; z$1619	INC D
	dc.b	$1d	; z$161A	DEC E
	dc.b	$01	; z$161B	LD BC,$0515
	dc.b	$15	; z$161C
	dc.b	$05	; z$161D
	dc.b	$02	; z$161E	LD (BC),A
	dc.b	$16	; z$161F	LD D,$00
	dc.b	$00	; z$1620
	dc.b	$00	; z$1621	NOP
	dc.b	$0b	; z$1622	DEC BC
	dc.b	$00	; z$1623	NOP
	dc.b	$33	; z$1624	INC SP
	dc.b	$f0	; z$1625	RET P
	dc.b	$c0	; z$1626	RET NZ
	dc.b	$16	; z$1627	LD D,$01
	dc.b	$01	; z$1628
	dc.b	$13	; z$1629	INC DE
	dc.b	$23	; z$162A	INC HL
	dc.b	$02	; z$162B	LD (BC),A
	dc.b	$14	; z$162C	INC D
	dc.b	$1d	; z$162D	DEC E
	dc.b	$0f	; z$162E	RRCA
	dc.b	$15	; z$162F	DEC D
	dc.b	$00	; z$1630	NOP
	dc.b	$0f	; z$1631	RRCA
	dc.b	$16	; z$1632	LD D,$00
	dc.b	$00	; z$1633
	dc.b	$00	; z$1634	NOP
	dc.b	$0c	; z$1635	INC C
	dc.b	$00	; z$1636	NOP
	dc.b	$38	; z$1637	JR C,z1629
	dc.b	$f0	; z$1638
	dc.b	$c0	; z$1639	RET NZ
	dc.b	$00	; z$163A	NOP
	dc.b	$07	; z$163B	RLCA
	dc.b	$57	; z$163C	LD D,A
	dc.b	$00	; z$163D	NOP
	dc.b	$03	; z$163E	INC BC
	dc.b	$44	; z$163F	LD B,H
	dc.b	$00	; z$1640	NOP
	dc.b	$01	; z$1641	LD BC,$0857
	dc.b	$57	; z$1642
	dc.b	$08	; z$1643
	dc.b	$00	; z$1644	NOP
	dc.b	$52	; z$1645	LD D,D
	dc.b	$00	; z$1646	NOP
	dc.b	$00	; z$1647	NOP
	dc.b	$0a	; z$1648	LD A,(BC)
	dc.b	$00	; z$1649	NOP
	dc.b	$5f	; z$164A	LD E,A
	dc.b	$00	; z$164B	NOP
	dc.b	$00	; z$164C	NOP
	dc.b	$00	; z$164D	NOP
	dc.b	$00	; z$164E	NOP
	dc.b	$1f	; z$164F	RRA
	dc.b	$04	; z$1650	INC B
	dc.b	$04	; z$1651	INC B
	dc.b	$35	; z$1652	DEC (HL)
	dc.b	$1f	; z$1653	RRA
	dc.b	$12	; z$1654	LD (DE),A
	dc.b	$04	; z$1655	INC B
	dc.b	$64	; z$1656	LD H,H
	dc.b	$1f	; z$1657	RRA
	dc.b	$18	; z$1658	JR z165A
	dc.b	$00	; z$1659
	dc.b	$2e	; z$165A	LD L,$00
	dc.b	$00	; z$165B
	dc.b	$00	; z$165C	NOP
	dc.b	$00	; z$165D	NOP
	dc.b	$00	; z$165E	NOP
	dc.b	$1f	; z$165F	RRA
	dc.b	$04	; z$1660	INC B
	dc.b	$04	; z$1661	INC B
	dc.b	$35	; z$1662	DEC (HL)
	dc.b	$1f	; z$1663	RRA
	dc.b	$12	; z$1664	LD (DE),A
	dc.b	$04	; z$1665	INC B
	dc.b	$64	; z$1666	LD H,H
	dc.b	$1f	; z$1667	RRA
	dc.b	$18	; z$1668	JR z166A
	dc.b	$00	; z$1669
	dc.b	$2e	; z$166A	LD L,$1A
	dc.b	$1a	; z$166B
	dc.b	$12	; z$166C	LD (DE),A
	dc.b	$00	; z$166D	NOP
	dc.b	$29	; z$166E	ADD HL,HL
	dc.b	$1d	; z$166F	DEC E
	dc.b	$80	; z$1670	ADD A,B
	dc.b	$00	; z$1671	NOP
	dc.b	$4b	; z$1672	LD C,E
	dc.b	$1f	; z$1673	RRA
	dc.b	$87	; z$1674	ADD A,A
	dc.b	$00	; z$1675	NOP
	dc.b	$99	; z$1676	SBC A,C
	dc.b	$50	; z$1677	LD D,B
	dc.b	$0e	; z$1678	LD C,$00
	dc.b	$00	; z$1679
	dc.b	$18	; z$167A	JR z169B
	dc.b	$1f	; z$167B
	dc.b	$11	; z$167C	LD DE,$8B04
	dc.b	$04	; z$167D
	dc.b	$8b	; z$167E
	dc.b	$1b	; z$167F	DEC DE
	dc.b	$08	; z$1680	EX AF,AF'
	dc.b	$0c	; z$1681	INC C
	dc.b	$87	; z$1682	ADD A,A
	dc.b	$1e	; z$1683	LD E,$07
	dc.b	$07	; z$1684
	dc.b	$04	; z$1685	INC B
	dc.b	$47	; z$1686	LD B,A
	dc.b	$1e	; z$1687	LD E,$0B
	dc.b	$0b	; z$1688
	dc.b	$00	; z$1689	NOP
	dc.b	$f8	; z$168A	RET M
	dc.b	$1f	; z$168B	RRA
	dc.b	$1f	; z$168C	RRA
	dc.b	$00	; z$168D	NOP
	dc.b	$03	; z$168E	INC BC
	dc.b	$11	; z$168F	LD DE,$001F
	dc.b	$1f	; z$1690
	dc.b	$00	; z$1691
	dc.b	$07	; z$1692	RLCA
	dc.b	$11	; z$1693	LD DE,$001F
	dc.b	$1f	; z$1694
	dc.b	$00	; z$1695
	dc.b	$0f	; z$1696	RRCA
	dc.b	$97	; z$1697	SUB A
	dc.b	$0f	; z$1698	RRCA
	dc.b	$00	; z$1699	NOP
	dc.b	$c0	; z$169A	RET NZ
	dc.b	$97	; z$169B	SUB A
	dc.b	$11	; z$169C	LD DE,$4E11
	dc.b	$11	; z$169D
	dc.b	$4e	; z$169E
	dc.b	$5f	; z$169F	LD E,A
	dc.b	$07	; z$16A0	RLCA
	dc.b	$07	; z$16A1	RLCA
	dc.b	$bf	; z$16A2	CP A
	dc.b	$1f	; z$16A3	RRA
	dc.b	$18	; z$16A4	JR z16AF
	dc.b	$09	; z$16A5
	dc.b	$29	; z$16A6	ADD HL,HL
	dc.b	$5f	; z$16A7	LD E,A
	dc.b	$0f	; z$16A8	RRCA
	dc.b	$02	; z$16A9	LD (BC),A
	dc.b	$96	; z$16AA	SUB (HL)
	dc.b	$9b	; z$16AB	SBC A,E
	dc.b	$15	; z$16AC	DEC D
	dc.b	$04	; z$16AD	INC B
	dc.b	$76	; z$16AE	HALT
	dc.b	$1f	; z$16AF	RRA
	dc.b	$1c	; z$16B0	INC E
	dc.b	$06	; z$16B1	LD B,$08
	dc.b	$08	; z$16B2
	dc.b	$5a	; z$16B3	LD E,D
	dc.b	$0d	; z$16B4	DEC C
	dc.b	$03	; z$16B5	INC BC
	dc.b	$5c	; z$16B6	LD E,H
	dc.b	$58	; z$16B7	LD E,B
	dc.b	$17	; z$16B8	RLA
	dc.b	$0e	; z$16B9	LD C,$3A
	dc.b	$3a	; z$16BA
	dc.b	$9e	; z$16BB	SBC A,(HL)
	dc.b	$17	; z$16BC	RLA
	dc.b	$07	; z$16BD	RLCA
	dc.b	$58	; z$16BE	LD E,B
	dc.b	$9e	; z$16BF	SBC A,(HL)
	dc.b	$0d	; z$16C0	DEC C
	dc.b	$0c	; z$16C1	INC C
	dc.b	$37	; z$16C2	SCF
	dc.b	$5f	; z$16C3	LD E,A
	dc.b	$18	; z$16C4	JR z16C6
	dc.b	$00	; z$16C5
	dc.b	$ff	; z$16C6	RST $38
	dc.b	$1f	; z$16C7	RRA
	dc.b	$0b	; z$16C8	DEC BC
	dc.b	$00	; z$16C9	NOP
	dc.b	$ff	; z$16CA	RST $38
	dc.b	$5f	; z$16CB	LD E,A
	dc.b	$07	; z$16CC	RLCA
	dc.b	$02	; z$16CD	LD (BC),A
	dc.b	$88	; z$16CE	ADC A,B
	dc.b	$1f	; z$16CF	RRA
	dc.b	$09	; z$16D0	ADD HL,BC
	dc.b	$02	; z$16D1	LD (BC),A
	dc.b	$88	; z$16D2	ADC A,B
	dc.b	$17	; z$16D3	RLA
	dc.b	$97	; z$16D4	SUB A
	dc.b	$03	; z$16D5	INC BC
	dc.b	$77	; z$16D6	LD (HL),A
	dc.b	$1f	; z$16D7	RRA
	dc.b	$87	; z$16D8	ADD A,A
	dc.b	$01	; z$16D9	LD BC,$5B94
	dc.b	$94	; z$16DA
	dc.b	$5b	; z$16DB
	dc.b	$94	; z$16DC	SUB H
	dc.b	$01	; z$16DD	LD BC,$1F74
	dc.b	$74	; z$16DE
	dc.b	$1f	; z$16DF
	dc.b	$97	; z$16E0	SUB A
	dc.b	$01	; z$16E1	LD BC,$5608
	dc.b	$08	; z$16E2
	dc.b	$56	; z$16E3
	dc.b	$0d	; z$16E4	DEC C
	dc.b	$03	; z$16E5	INC BC
	dc.b	$5c	; z$16E6	LD E,H
	dc.b	$94	; z$16E7	SUB H
	dc.b	$17	; z$16E8	RLA
	dc.b	$0e	; z$16E9	LD C,$0A
	dc.b	$0a	; z$16EA
	dc.b	$9e	; z$16EB	SBC A,(HL)
	dc.b	$0f	; z$16EC	RRCA
	dc.b	$05	; z$16ED	DEC B
	dc.b	$67	; z$16EE	LD H,A
	dc.b	$5b	; z$16EF	LD E,E
	dc.b	$0c	; z$16F0	INC C
	dc.b	$0a	; z$16F1	LD A,(BC)
	dc.b	$36	; z$16F2	LD (HL),$1F
	dc.b	$1f	; z$16F3
	dc.b	$17	; z$16F4	RLA
	dc.b	$0f	; z$16F5	RRCA
	dc.b	$0d	; z$16F6	DEC C
	dc.b	$5f	; z$16F7	LD E,A
	dc.b	$17	; z$16F8	RLA
	dc.b	$0f	; z$16F9	RRCA
	dc.b	$2e	; z$16FA	LD L,$5F
	dc.b	$5f	; z$16FB
	dc.b	$0d	; z$16FC	DEC C
	dc.b	$0d	; z$16FD	DEC C
	dc.b	$2a	; z$16FE	LD HL,($0F97)
	dc.b	$97	; z$16FF
	dc.b	$0f	; z$1700
	dc.b	$04	; z$1701	INC B
	dc.b	$48	; z$1702	LD C,B
	dc.b	$1d	; z$1703	DEC E
	dc.b	$01	; z$1704	LD BC,$1801
	dc.b	$01	; z$1705
	dc.b	$18	; z$1706
	dc.b	$1d	; z$1707	DEC E
	dc.b	$01	; z$1708	LD BC,$2801
	dc.b	$01	; z$1709
	dc.b	$28	; z$170A
	dc.b	$19	; z$170B	ADD HL,DE
	dc.b	$03	; z$170C	INC BC
	dc.b	$00	; z$170D	NOP
	dc.b	$22	; z$170E	LD ($050D),HL
	dc.b	$0d	; z$170F
	dc.b	$05	; z$1710
	dc.b	$00	; z$1711	NOP
	dc.b	$27	; z$1712	DAA
	dc.b	$1f	; z$1713	RRA
	dc.b	$07	; z$1714	RLCA
	dc.b	$00	; z$1715	NOP
	dc.b	$a0	; z$1716	AND B
	dc.b	$1f	; z$1717	RRA
	dc.b	$0f	; z$1718	RRCA
	dc.b	$04	; z$1719	INC B
	dc.b	$37	; z$171A	SCF
	dc.b	$1f	; z$171B	RRA
	dc.b	$16	; z$171C	LD D,$04
	dc.b	$04	; z$171D
	dc.b	$18	; z$171E	JR z173A
	dc.b	$1a	; z$171F
	dc.b	$11	; z$1720	LD DE,$9C11
	dc.b	$11	; z$1721
	dc.b	$9c	; z$1722
	dc.b	$1d	; z$1723	DEC E
	dc.b	$12	; z$1724	LD (DE),A
	dc.b	$13	; z$1725	INC DE
	dc.b	$98	; z$1726	SBC A,B
	dc.b	$1b	; z$1727	DEC DE
	dc.b	$0f	; z$1728	RRCA
	dc.b	$0f	; z$1729	RRCA
	dc.b	$29	; z$172A	ADD HL,HL
	dc.b	$1f	; z$172B	RRA
	dc.b	$0e	; z$172C	LD C,$0C
	dc.b	$0c	; z$172D
	dc.b	$5b	; z$172E	LD E,E
	dc.b	$1b	; z$172F	DEC DE
	dc.b	$09	; z$1730	ADD HL,BC
	dc.b	$06	; z$1731	LD B,$74
	dc.b	$74	; z$1732
	dc.b	$9f	; z$1733	SBC A,A
	dc.b	$0d	; z$1734	DEC C
	dc.b	$04	; z$1735	INC B
	dc.b	$54	; z$1736	LD D,H
	dc.b	$18	; z$1737	JR z1748
	dc.b	$0f	; z$1738
	dc.b	$0b	; z$1739	DEC BC
	dc.b	$36	; z$173A	LD (HL),$1F
	dc.b	$1f	; z$173B
	dc.b	$18	; z$173C	JR z1759
	dc.b	$1b	; z$173D
	dc.b	$7f	; z$173E	LD A,A
	dc.b	$1f	; z$173F	RRA
	dc.b	$02	; z$1740	LD (BC),A
	dc.b	$01	; z$1741	LD BC,$1F2D
	dc.b	$2d	; z$1742
	dc.b	$1f	; z$1743
	dc.b	$07	; z$1744	RLCA
	dc.b	$00	; z$1745	NOP
	dc.b	$a7	; z$1746	AND A
	dc.b	$1a	; z$1747	LD A,(DE)
	dc.b	$12	; z$1748	LD (DE),A
	dc.b	$16	; z$1749	LD D,$3D
	dc.b	$3d	; z$174A
	dc.b	$1f	; z$174B	RRA
	dc.b	$18	; z$174C	JR z1769
	dc.b	$1b	; z$174D
	dc.b	$7f	; z$174E	LD A,A
	dc.b	$1f	; z$174F	RRA
	dc.b	$07	; z$1750	RLCA
	dc.b	$00	; z$1751	NOP
	dc.b	$a7	; z$1752	AND A
	dc.b	$1d	; z$1753	DEC E
	dc.b	$10	; z$1754	DJNZ z1756
	dc.b	$00	; z$1755
	dc.b	$8d	; z$1756	ADC A,L
	dc.b	$1f	; z$1757	RRA
	dc.b	$12	; z$1758	LD (DE),A
	dc.b	$12	; z$1759	LD (DE),A
	dc.b	$5d	; z$175A	LD E,L
	dc.b	$1f	; z$175B	RRA
	dc.b	$0c	; z$175C	INC C
	dc.b	$0c	; z$175D	INC C
	dc.b	$df	; z$175E	RST $18
	dc.b	$1f	; z$175F	RRA
	dc.b	$14	; z$1760	INC D
	dc.b	$1a	; z$1761	LD A,(DE)
	dc.b	$dd	; z$1762	DB $IX, $1F
	dc.b	$1f	; z$1763
	dc.b	$09	; z$1764	ADD HL,BC
	dc.b	$02	; z$1765	LD (BC),A
	dc.b	$cb	; z$1766	RLC E
	dc.b	$1f	; z$1767
	dc.b	$10	; z$1768	DJNZ z177E
	dc.b	$14	; z$1769
	dc.b	$db	; z$176A	IN A,($1F)
	dc.b	$1f	; z$176B
	dc.b	$1b	; z$176C	DEC DE
	dc.b	$07	; z$176D	RLCA
	dc.b	$89	; z$176E	ADC A,C
	dc.b	$1f	; z$176F	RRA
	dc.b	$13	; z$1770	INC DE
	dc.b	$11	; z$1771	LD DE,$1F39
	dc.b	$39	; z$1772
	dc.b	$1f	; z$1773
	dc.b	$11	; z$1774	LD DE,$2502
	dc.b	$02	; z$1775
	dc.b	$25	; z$1776
	dc.b	$1f	; z$1777	RRA
	dc.b	$11	; z$1778	LD DE,$450B
	dc.b	$0b	; z$1779
	dc.b	$45	; z$177A
	dc.b	$1f	; z$177B	RRA
	dc.b	$1f	; z$177C	RRA
	dc.b	$00	; z$177D	NOP
	dc.b	$16	; z$177E	LD D,$1F
	dc.b	$1f	; z$177F
	dc.b	$1f	; z$1780	RRA
	dc.b	$04	; z$1781	INC B
	dc.b	$16	; z$1782	LD D,$1F
	dc.b	$1f	; z$1783
	dc.b	$1c	; z$1784	INC E
	dc.b	$00	; z$1785	NOP
	dc.b	$06	; z$1786	LD B,$5F
	dc.b	$5f	; z$1787
	dc.b	$11	; z$1788	LD DE,$D804
	dc.b	$04	; z$1789
	dc.b	$d8	; z$178A
	dc.b	$5f	; z$178B	LD E,A
	dc.b	$14	; z$178C	INC D
	dc.b	$0b	; z$178D	DEC BC
	dc.b	$18	; z$178E	JR z17EF
	dc.b	$5f	; z$178F
	dc.b	$10	; z$1790	DJNZ z17A2
	dc.b	$10	; z$1791
	dc.b	$5d	; z$1792	LD E,L
	dc.b	$1f	; z$1793	RRA
	dc.b	$0c	; z$1794	INC C
	dc.b	$0a	; z$1795	LD A,(BC)
	dc.b	$1f	; z$1796	RRA
	dc.b	$1b	; z$1797	DEC DE
	dc.b	$15	; z$1798	DEC D
	dc.b	$17	; z$1799	RLA
	dc.b	$cf	; z$179A	RST $08
	dc.b	$59	; z$179B	LD E,C
	dc.b	$0f	; z$179C	RRCA
	dc.b	$0e	; z$179D	LD C,$79
	dc.b	$79	; z$179E
	dc.b	$57	; z$179F	LD D,A
	dc.b	$10	; z$17A0	DJNZ z17AA
	dc.b	$08	; z$17A1
	dc.b	$47	; z$17A2	LD B,A
	dc.b	$1d	; z$17A3	DEC E
	dc.b	$11	; z$17A4	LD DE,$4602
	dc.b	$02	; z$17A5
	dc.b	$46	; z$17A6
	dc.b	$5f	; z$17A7	LD E,A
	dc.b	$12	; z$17A8	LD (DE),A
	dc.b	$02	; z$17A9	LD (BC),A
	dc.b	$96	; z$17AA	SUB (HL)
	dc.b	$1f	; z$17AB	RRA
	dc.b	$1f	; z$17AC	RRA
	dc.b	$05	; z$17AD	DEC B
	dc.b	$56	; z$17AE	LD D,(HL)
	dc.b	$12	; z$17AF	LD (DE),A
	dc.b	$11	; z$17B0	LD DE,$2708
	dc.b	$08	; z$17B1
	dc.b	$27	; z$17B2
	dc.b	$12	; z$17B3	LD (DE),A
	dc.b	$10	; z$17B4	DJNZ z17BD
	dc.b	$07	; z$17B5
	dc.b	$07	; z$17B6	RLCA
	dc.b	$59	; z$17B7	LD E,C
	dc.b	$1c	; z$17B8	INC E
	dc.b	$00	; z$17B9	NOP
	dc.b	$e6	; z$17BA	AND $5F
	dc.b	$5f	; z$17BB
	dc.b	$0c	; z$17BC	INC C
	dc.b	$00	; z$17BD	NOP
	dc.b	$e6	; z$17BE	AND $5F
	dc.b	$5f	; z$17BF
	dc.b	$03	; z$17C0	INC BC
	dc.b	$00	; z$17C1	NOP
	dc.b	$e6	; z$17C2	AND $1F
	dc.b	$1f	; z$17C3
	dc.b	$0e	; z$17C4	LD C,$00
	dc.b	$00	; z$17C5
	dc.b	$e7	; z$17C6	RST $20
	dc.b	$1f	; z$17C7	RRA
	dc.b	$01	; z$17C8	LD BC,$1401
	dc.b	$01	; z$17C9
	dc.b	$14	; z$17CA
	dc.b	$10	; z$17CB	DJNZ z17D0
	dc.b	$03	; z$17CC
	dc.b	$01	; z$17CD	LD BC,$1226
	dc.b	$26	; z$17CE
	dc.b	$12	; z$17CF
	dc.b	$04	; z$17D0	INC B
	dc.b	$03	; z$17D1	INC BC
	dc.b	$25	; z$17D2	DEC H
	dc.b	$0d	; z$17D3	DEC C
	dc.b	$08	; z$17D4	EX AF,AF'
	dc.b	$00	; z$17D5	NOP
	dc.b	$37	; z$17D6	SCF
	dc.b	$10	; z$17D7	DJNZ z17E1
	dc.b	$08	; z$17D8
	dc.b	$00	; z$17D9	NOP
	dc.b	$06	; z$17DA	LD B,$58
	dc.b	$58	; z$17DB
	dc.b	$01	; z$17DC	LD BC,$0503
	dc.b	$03	; z$17DD
	dc.b	$05	; z$17DE
	dc.b	$db	; z$17DF	IN A,($05)
	dc.b	$05	; z$17E0
	dc.b	$01	; z$17E1	LD BC,$9605
	dc.b	$05	; z$17E2
	dc.b	$96	; z$17E3
	dc.b	$01	; z$17E4	LD BC,$D601
	dc.b	$01	; z$17E5
	dc.b	$d6	; z$17E6
	dc.b	$96	; z$17E7	SUB (HL)
	dc.b	$0a	; z$17E8	LD A,(BC)
	dc.b	$01	; z$17E9	LD BC,$9A36
	dc.b	$36	; z$17EA
	dc.b	$9a	; z$17EB
	dc.b	$04	; z$17EC	INC B
	dc.b	$09	; z$17ED	ADD HL,BC
	dc.b	$25	; z$17EE	DEC H
	dc.b	$9a	; z$17EF	SBC A,D
	dc.b	$0c	; z$17F0	INC C
	dc.b	$08	; z$17F1	EX AF,AF'
	dc.b	$26	; z$17F2	LD H,$96
	dc.b	$96	; z$17F3
	dc.b	$09	; z$17F4	ADD HL,BC
	dc.b	$07	; z$17F5	RLCA
	dc.b	$27	; z$17F6	DAA
	dc.b	$4f	; z$17F7	LD C,A
	dc.b	$01	; z$17F8	LD BC,$D605
	dc.b	$05	; z$17F9
	dc.b	$d6	; z$17FA
	dc.b	$5f	; z$17FB	LD E,A
	dc.b	$09	; z$17FC	ADD HL,BC
	dc.b	$00	; z$17FD	NOP
	dc.b	$06	; z$17FE	LD B,$5F
	dc.b	$5f	; z$17FF
	dc.b	$0a	; z$1800	LD A,(BC)
	dc.b	$00	; z$1801	NOP
	dc.b	$09	; z$1802	ADD HL,BC
	dc.b	$1f	; z$1803	RRA
	dc.b	$14	; z$1804	INC D
	dc.b	$06	; z$1805	LD B,$05
	dc.b	$05	; z$1806
	dc.b	$1f	; z$1807	RRA
	dc.b	$10	; z$1808	DJNZ z180A
	dc.b	$00	; z$1809
	dc.b	$09	; z$180A	ADD HL,BC
	dc.b	$1f	; z$180B	RRA
	dc.b	$05	; z$180C	DEC B
	dc.b	$05	; z$180D	DEC B
	dc.b	$86	; z$180E	ADD A,(HL)
	dc.b	$5c	; z$180F	LD E,H
	dc.b	$1a	; z$1810	LD A,(DE)
	dc.b	$00	; z$1811	NOP
	dc.b	$06	; z$1812	LD B,$1F
	dc.b	$1f	; z$1813
	dc.b	$00	; z$1814	NOP
	dc.b	$06	; z$1815	LD B,$04
	dc.b	$04	; z$1816
	dc.b	$0f	; z$1817	RRCA
	dc.b	$08	; z$1818	EX AF,AF'
	dc.b	$08	; z$1819	EX AF,AF'
	dc.b	$07	; z$181A	RLCA
	dc.b	$1f	; z$181B	RRA
	dc.b	$08	; z$181C	EX AF,AF'
	dc.b	$08	; z$181D	EX AF,AF'
	dc.b	$3e	; z$181E	LD A,$1F
	dc.b	$1f	; z$181F
	dc.b	$05	; z$1820	DEC B
	dc.b	$06	; z$1821	LD B,$2E
	dc.b	$2e	; z$1822
	dc.b	$1f	; z$1823	RRA
	dc.b	$0c	; z$1824	INC C
	dc.b	$14	; z$1825	INC D
	dc.b	$45	; z$1826	LD B,L
	dc.b	$11	; z$1827	LD DE,$014F
	dc.b	$4f	; z$1828
	dc.b	$01	; z$1829
	dc.b	$01	; z$182A	LD BC,$0000
	dc.b	$00	; z$182B
	dc.b	$00	; z$182C
	dc.b	$00	; z$182D	NOP
	dc.b	$60	; z$182E	LD H,B
	dc.b	$11	; z$182F	LD DE,$0115
	dc.b	$15	; z$1830
	dc.b	$01	; z$1831
	dc.b	$01	; z$1832	LD BC,$6800
	dc.b	$00	; z$1833
	dc.b	$68	; z$1834
	dc.b	$18	; z$1835	JR z183F
	dc.b	$08	; z$1836
	dc.b	$01	; z$1837	LD BC,$0000
	dc.b	$00	; z$1838
	dc.b	$00	; z$1839
	dc.b	$60	; z$183A	LD H,B
	dc.b	$03	; z$183B	INC BC
	dc.b	$01	; z$183C	LD BC,$0005
	dc.b	$05	; z$183D
	dc.b	$00	; z$183E
	dc.b	$00	; z$183F	NOP
	dc.b	$70	; z$1840	LD (HL),B
	dc.b	$02	; z$1841	LD (BC),A
	dc.b	$05	; z$1842	DEC B
	dc.b	$02	; z$1843	LD (BC),A
	dc.b	$00	; z$1844	NOP
	dc.b	$00	; z$1845	NOP
	dc.b	$7f	; z$1846	LD A,A
	dc.b	$05	; z$1847	DEC B
	dc.b	$01	; z$1848	LD BC,$0001
	dc.b	$01	; z$1849
	dc.b	$00	; z$184A
	dc.b	$00	; z$184B	NOP
	dc.b	$68	; z$184C	LD L,B
	dc.b	$01	; z$184D	LD BC,$0101
	dc.b	$01	; z$184E
	dc.b	$01	; z$184F
	dc.b	$03	; z$1850	INC BC
	dc.b	$00	; z$1851	NOP
	dc.b	$68	; z$1852	LD L,B
	dc.b	$01	; z$1853	LD BC,$0201
	dc.b	$01	; z$1854
	dc.b	$02	; z$1855
	dc.b	$04	; z$1856	INC B
	dc.b	$00	; z$1857	NOP
	dc.b	$68	; z$1858	LD L,B
	dc.b	$01	; z$1859	LD BC,$0201
	dc.b	$01	; z$185A
	dc.b	$02	; z$185B
	dc.b	$06	; z$185C	LD B,$00
	dc.b	$00	; z$185D
	dc.b	$68	; z$185E	LD L,B
	dc.b	$01	; z$185F	LD BC,$0608
	dc.b	$08	; z$1860
	dc.b	$06	; z$1861
	dc.b	$00	; z$1862	NOP
	dc.b	$00	; z$1863	NOP
	dc.b	$68	; z$1864	LD L,B
	dc.b	$01	; z$1865	LD BC,$0308
	dc.b	$08	; z$1866
	dc.b	$03	; z$1867
	dc.b	$07	; z$1868	RLCA
	dc.b	$00	; z$1869	NOP
	dc.b	$60	; z$186A	LD H,B
	dc.b	$03	; z$186B	INC BC
	dc.b	$02	; z$186C	LD (BC),A
	dc.b	$06	; z$186D	LD B,$0A
	dc.b	$0a	; z$186E
	dc.b	$00	; z$186F	NOP
	dc.b	$68	; z$1870	LD L,B
	dc.b	$01	; z$1871	LD BC,$0304
	dc.b	$04	; z$1872
	dc.b	$03	; z$1873
	dc.b	$0a	; z$1874	LD A,(BC)
	dc.b	$00	; z$1875	NOP
	dc.b	$68	; z$1876	LD L,B
	dc.b	$01	; z$1877	LD BC,$0001
	dc.b	$01	; z$1878
	dc.b	$00	; z$1879
	dc.b	$0b	; z$187A	DEC BC
	dc.b	$00	; z$187B	NOP
	dc.b	$68	; z$187C	LD L,B
	dc.b	$01	; z$187D	LD BC,$0004
	dc.b	$04	; z$187E
	dc.b	$00	; z$187F
	dc.b	$0a	; z$1880	LD A,(BC)
	dc.b	$00	; z$1881	NOP
	dc.b	$68	; z$1882	LD L,B
	dc.b	$01	; z$1883	LD BC,$0311
	dc.b	$11	; z$1884
	dc.b	$03	; z$1885
	dc.b	$03	; z$1886	INC BC
	dc.b	$00	; z$1887	NOP
	dc.b	$68	; z$1888	LD L,B
	dc.b	$01	; z$1889	LD BC,$0711
	dc.b	$11	; z$188A
	dc.b	$07	; z$188B
	dc.b	$0d	; z$188C	DEC C
	dc.b	$00	; z$188D	NOP
	dc.b	$08	; z$188E	EX AF,AF'
	dc.b	$9f	; z$188F	SBC A,A
	dc.b	$18	; z$1890	JR z183F
	dc.b	$ad	; z$1891
	dc.b	$18	; z$1892	JR z184A
	dc.b	$b6	; z$1893
	dc.b	$18	; z$1894	JR z185C
	dc.b	$c6	; z$1895
	dc.b	$18	; z$1896	JR z1872
	dc.b	$da	; z$1897
	dc.b	$18	; z$1898	JR z187C
	dc.b	$e2	; z$1899
	dc.b	$18	; z$189A	JR z188F
	dc.b	$f3	; z$189B
	dc.b	$18	; z$189C	JR z1895
	dc.b	$f7	; z$189D
	dc.b	$18	; z$189E	JR z18A7
	dc.b	$07	; z$189F
	dc.b	$15	; z$18A0	DEC D
	dc.b	$25	; z$18A1	DEC H
	dc.b	$35	; z$18A2	DEC (HL)
	dc.b	$45	; z$18A3	LD B,L
	dc.b	$5f	; z$18A4	LD E,A
	dc.b	$6f	; z$18A5	LD L,A
	dc.b	$7f	; z$18A6	LD A,A
	dc.b	$8f	; z$18A7	ADC A,A
	dc.b	$9f	; z$18A8	SBC A,A
	dc.b	$af	; z$18A9	XOR A
	dc.b	$bf	; z$18AA	CP A
	dc.b	$cf	; z$18AB	RST $08
	dc.b	$d0	; z$18AC	RET NC
	dc.b	$32	; z$18AD	LD ($1222),A
	dc.b	$22	; z$18AE
	dc.b	$12	; z$18AF
	dc.b	$08	; z$18B0	EX AF,AF'
	dc.b	$14	; z$18B1	INC D
	dc.b	$24	; z$18B2	INC H
	dc.b	$34	; z$18B3	INC (HL)
	dc.b	$44	; z$18B4	LD B,H
	dc.b	$50	; z$18B5	LD D,B
	dc.b	$03	; z$18B6	INC BC
	dc.b	$13	; z$18B7	INC DE
	dc.b	$23	; z$18B8	INC HL
	dc.b	$31	; z$18B9	LD SP,$5141
	dc.b	$41	; z$18BA
	dc.b	$51	; z$18BB
	dc.b	$61	; z$18BC	LD H,C
	dc.b	$71	; z$18BD	LD (HL),C
	dc.b	$81	; z$18BE	ADD A,C
	dc.b	$91	; z$18BF	SUB C
	dc.b	$a1	; z$18C0	AND C
	dc.b	$b1	; z$18C1	OR C
	dc.b	$c1	; z$18C2	POP BC
	dc.b	$d1	; z$18C3	POP DE
	dc.b	$e1	; z$18C4	POP HL
	dc.b	$f0	; z$18C5	RET P
	dc.b	$41	; z$18C6	LD B,C
	dc.b	$31	; z$18C7	LD SP,$1121
	dc.b	$21	; z$18C8
	dc.b	$11	; z$18C9
	dc.b	$08	; z$18CA	EX AF,AF'
	dc.b	$1f	; z$18CB	RRA
	dc.b	$1f	; z$18CC	RRA
	dc.b	$2f	; z$18CD	CPL
	dc.b	$2f	; z$18CE	CPL
	dc.b	$3f	; z$18CF	CCF
	dc.b	$3f	; z$18D0	CCF
	dc.b	$4f	; z$18D1	LD C,A
	dc.b	$5f	; z$18D2	LD E,A
	dc.b	$6f	; z$18D3	LD L,A
	dc.b	$7f	; z$18D4	LD A,A
	dc.b	$8f	; z$18D5	ADC A,A
	dc.b	$9f	; z$18D6	SBC A,A
	dc.b	$af	; z$18D7	XOR A
	dc.b	$bf	; z$18D8	CP A
	dc.b	$c0	; z$18D9	RET NZ
	dc.b	$00	; z$18DA	NOP
	dc.b	$00	; z$18DB	NOP
	dc.b	$00	; z$18DC	NOP
	dc.b	$00	; z$18DD	NOP
	dc.b	$00	; z$18DE	NOP
	dc.b	$00	; z$18DF	NOP
	dc.b	$00	; z$18E0	NOP
	dc.b	$00	; z$18E1	NOP
	dc.b	$01	; z$18E2	LD BC,$01F1
	dc.b	$f1	; z$18E3
	dc.b	$01	; z$18E4
	dc.b	$f1	; z$18E5	POP SP
	dc.b	$01	; z$18E6	LD BC,$01F1
	dc.b	$f1	; z$18E7
	dc.b	$01	; z$18E8
	dc.b	$f1	; z$18E9	POP SP
	dc.b	$01	; z$18EA	LD BC,$01F1
	dc.b	$f1	; z$18EB
	dc.b	$01	; z$18EC
	dc.b	$f1	; z$18ED	POP SP
	dc.b	$01	; z$18EE	LD BC,$01F1
	dc.b	$f1	; z$18EF
	dc.b	$01	; z$18F0
	dc.b	$f1	; z$18F1	POP SP
	dc.b	$00	; z$18F2	NOP
	dc.b	$03	; z$18F3	INC BC
	dc.b	$13	; z$18F4	INC DE
	dc.b	$23	; z$18F5	INC HL
	dc.b	$30	; z$18F6	JR NC,z189A
	dc.b	$a2	; z$18F7
	dc.b	$92	; z$18F8	SUB D
	dc.b	$84	; z$18F9	ADD A,H
	dc.b	$74	; z$18FA	LD (HL),H
	dc.b	$68	; z$18FB	LD L,B
	dc.b	$58	; z$18FC	LD E,B
	dc.b	$48	; z$18FD	LD C,B
	dc.b	$38	; z$18FE	JR C,z1920
	dc.b	$20	; z$18FF
	dc.b	$0e	; z$1900	LD C,$1D
	dc.b	$1d	; z$1901
	dc.b	$19	; z$1902	ADD HL,DE
	dc.b	$1e	; z$1903	LD E,$19
	dc.b	$19	; z$1904
	dc.b	$2b	; z$1905	DEC HL
	dc.b	$19	; z$1906	ADD HL,DE
	dc.b	$2f	; z$1907	CPL
	dc.b	$19	; z$1908	ADD HL,DE
	dc.b	$3f	; z$1909	CCF
	dc.b	$19	; z$190A	ADD HL,DE
	dc.b	$52	; z$190B	LD D,D
	dc.b	$19	; z$190C	ADD HL,DE
	dc.b	$7d	; z$190D	LD A,L
	dc.b	$19	; z$190E	ADD HL,DE
	dc.b	$9e	; z$190F	SBC A,(HL)
	dc.b	$19	; z$1910	ADD HL,DE
	dc.b	$a7	; z$1911	AND A
	dc.b	$19	; z$1912	ADD HL,DE
	dc.b	$b2	; z$1913	OR D
	dc.b	$19	; z$1914	ADD HL,DE
	dc.b	$be	; z$1915	CP (HL)
	dc.b	$19	; z$1916	ADD HL,DE
	dc.b	$c7	; z$1917	RST $00
	dc.b	$19	; z$1918	ADD HL,DE
	dc.b	$cd	; z$1919	CALL zD319
	dc.b	$19	; z$191A
	dc.b	$d3	; z$191B
	dc.b	$19	; z$191C	ADD HL,DE
	dc.b	$00	; z$191D	NOP
	dc.b	$f9	; z$191E	LD SP,HL
	dc.b	$04	; z$191F	INC B
	dc.b	$04	; z$1920	INC B
	dc.b	$00	; z$1921	NOP
	dc.b	$00	; z$1922	NOP
	dc.b	$08	; z$1923	EX AF,AF'
	dc.b	$ff	; z$1924	RST $38
	dc.b	$ff	; z$1925	RST $38
	dc.b	$fc	; z$1926	CALL M,zFF10
	dc.b	$10	; z$1927
	dc.b	$ff	; z$1928
	dc.b	$26	; z$1929	LD H,$19
	dc.b	$19	; z$192A
	dc.b	$40	; z$192B	LD B,B
	dc.b	$f8	; z$192C	RET M
	dc.b	$ff	; z$192D	RST $38
	dc.b	$fa	; z$192E	JP M,zF012
	dc.b	$12	; z$192F
	dc.b	$f0	; z$1930
	dc.b	$ff	; z$1931	RST $38
	dc.b	$04	; z$1932	INC B
	dc.b	$12	; z$1933	LD (DE),A
	dc.b	$00	; z$1934	NOP
	dc.b	$04	; z$1935	INC B
	dc.b	$22	; z$1936	LD ($0400),HL
	dc.b	$00	; z$1937
	dc.b	$04	; z$1938
	dc.b	$32	; z$1939	LD ($3500),A
	dc.b	$00	; z$193A
	dc.b	$35	; z$193B
	dc.b	$42	; z$193C	LD B,D
	dc.b	$00	; z$193D	NOP
	dc.b	$fa	; z$193E	JP M,z1F01
	dc.b	$01	; z$193F
	dc.b	$1f	; z$1940
	dc.b	$00	; z$1941	NOP
	dc.b	$01	; z$1942	LD BC,$0522
	dc.b	$22	; z$1943
	dc.b	$05	; z$1944
	dc.b	$01	; z$1945	LD BC,$0211
	dc.b	$11	; z$1946
	dc.b	$02	; z$1947
	dc.b	$01	; z$1948	LD BC,$FF22
	dc.b	$22	; z$1949
	dc.b	$ff	; z$194A
	dc.b	$01	; z$194B	LD BC,$0330
	dc.b	$30	; z$194C
	dc.b	$03	; z$194D
	dc.b	$01	; z$194E	LD BC,$FF30
	dc.b	$30	; z$194F
	dc.b	$ff	; z$1950
	dc.b	$fa	; z$1951	JP M,z0005
	dc.b	$05	; z$1952
	dc.b	$00	; z$1953
	dc.b	$00	; z$1954	NOP
	dc.b	$f9	; z$1955	LD SP,HL
	dc.b	$02	; z$1956	LD (BC),A
	dc.b	$fd	; z$1957	DB $IY, $04
	dc.b	$04	; z$1958
	dc.b	$0c	; z$1959	INC C
	dc.b	$ff	; z$195A	RST $38
	dc.b	$ff	; z$195B	RST $38
	dc.b	$0c	; z$195C	INC C
	dc.b	$01	; z$195D	LD BC,$FE00
	dc.b	$00	; z$195E
	dc.b	$fe	; z$195F
	dc.b	$fd	; z$1960	DB $IY, $04
	dc.b	$04	; z$1961
	dc.b	$0c	; z$1962	INC C
	dc.b	$ff	; z$1963	RST $38
	dc.b	$ff	; z$1964	RST $38
	dc.b	$0c	; z$1965	INC C
	dc.b	$01	; z$1966	LD BC,$FE00
	dc.b	$00	; z$1967
	dc.b	$fe	; z$1968
	dc.b	$f9	; z$1969	LD SP,HL
	dc.b	$01	; z$196A	LD BC,$04FD
	dc.b	$fd	; z$196B
	dc.b	$04	; z$196C
	dc.b	$18	; z$196D	JR z196D
	dc.b	$fe	; z$196E
	dc.b	$ff	; z$196F	RST $38
	dc.b	$18	; z$1970	JR z1974
	dc.b	$02	; z$1971
	dc.b	$00	; z$1972	NOP
	dc.b	$fe	; z$1973	CP $18
	dc.b	$18	; z$1974
	dc.b	$fd	; z$1975	DB $IY, $FF
	dc.b	$ff	; z$1976
	dc.b	$18	; z$1977	JR z197C
	dc.b	$03	; z$1978
	dc.b	$00	; z$1979	NOP
	dc.b	$ff	; z$197A	RST $38
	dc.b	$74	; z$197B	LD (HL),H
	dc.b	$19	; z$197C	ADD HL,DE
	dc.b	$01	; z$197D	LD BC,$FEE0
	dc.b	$e0	; z$197E
	dc.b	$fe	; z$197F
	dc.b	$01	; z$1980	LD BC,$0710
	dc.b	$10	; z$1981
	dc.b	$07	; z$1982
	dc.b	$01	; z$1983	LD BC,$FA10
	dc.b	$10	; z$1984
	dc.b	$fa	; z$1985
	dc.b	$01	; z$1986	LD BC,$01B0
	dc.b	$b0	; z$1987
	dc.b	$01	; z$1988
	dc.b	$01	; z$1989	LD BC,$FED0
	dc.b	$d0	; z$198A
	dc.b	$fe	; z$198B
	dc.b	$01	; z$198C	LD BC,$0600
	dc.b	$00	; z$198D
	dc.b	$06	; z$198E
	dc.b	$01	; z$198F	LD BC,$F4D0
	dc.b	$d0	; z$1990
	dc.b	$f4	; z$1991
	dc.b	$01	; z$1992	LD BC,$FE50
	dc.b	$50	; z$1993
	dc.b	$fe	; z$1994
	dc.b	$01	; z$1995	LD BC,$04B0
	dc.b	$b0	; z$1996
	dc.b	$04	; z$1997
	dc.b	$01	; z$1998	LD BC,$FC00
	dc.b	$00	; z$1999
	dc.b	$fc	; z$199A
	dc.b	$ff	; z$199B	RST $38
	dc.b	$7d	; z$199C	LD A,L
	dc.b	$19	; z$199D	ADD HL,DE
	dc.b	$f8	; z$199E	RET M
	dc.b	$03	; z$199F	INC BC
	dc.b	$ff	; z$19A0	RST $38
	dc.b	$f8	; z$19A1	RET M
	dc.b	$03	; z$19A2	INC BC
	dc.b	$ff	; z$19A3	RST $38
	dc.b	$ff	; z$19A4	RST $38
	dc.b	$9e	; z$19A5	SBC A,(HL)
	dc.b	$19	; z$19A6	ADD HL,DE
	dc.b	$f9	; z$19A7	LD SP,HL
	dc.b	$04	; z$19A8	INC B
	dc.b	$01	; z$19A9	LD BC,$0C00
	dc.b	$00	; z$19AA
	dc.b	$0c	; z$19AB
	dc.b	$01	; z$19AC	LD BC,$F400
	dc.b	$00	; z$19AD
	dc.b	$f4	; z$19AE
	dc.b	$ff	; z$19AF	RST $38
	dc.b	$a9	; z$19B0	XOR C
	dc.b	$19	; z$19B1	ADD HL,DE
	dc.b	$fb	; z$19B2	EI
	dc.b	$80	; z$19B3	ADD A,B
	dc.b	$fe	; z$19B4	CP $0C
	dc.b	$0c	; z$19B5
	dc.b	$20	; z$19B6	JR NZ,z19B8
	dc.b	$00	; z$19B7
	dc.b	$20	; z$19B8	JR NZ,z19BA
	dc.b	$00	; z$19B9
	dc.b	$00	; z$19BA	NOP
	dc.b	$ff	; z$19BB	RST $38
	dc.b	$60	; z$19BC	LD H,B
	dc.b	$19	; z$19BD	ADD HL,DE
	dc.b	$f8	; z$19BE	RET M
	dc.b	$05	; z$19BF	DEC B
	dc.b	$f0	; z$19C0	RET P
	dc.b	$f8	; z$19C1	RET M
	dc.b	$05	; z$19C2	DEC B
	dc.b	$f0	; z$19C3	RET P
	dc.b	$ff	; z$19C4	RST $38
	dc.b	$be	; z$19C5	CP (HL)
	dc.b	$19	; z$19C6	ADD HL,DE
	dc.b	$35	; z$19C7	DEC (HL)
	dc.b	$00	; z$19C8	NOP
	dc.b	$ff	; z$19C9	RST $38
	dc.b	$ff	; z$19CA	RST $38
	dc.b	$c7	; z$19CB	RST $00
	dc.b	$19	; z$19CC	ADD HL,DE
	dc.b	$65	; z$19CD	LD H,L
	dc.b	$90	; z$19CE	SUB B
	dc.b	$ff	; z$19CF	RST $38
	dc.b	$ff	; z$19D0	RST $38
	dc.b	$cd	; z$19D1	CALL z8519
	dc.b	$19	; z$19D2
	dc.b	$85	; z$19D3
	dc.b	$03	; z$19D4	INC BC
	dc.b	$00	; z$19D5	NOP
	dc.b	$fa	; z$19D6	JP M,zDE03
	dc.b	$03	; z$19D7
	dc.b	$de	; z$19D8
	dc.b	$19	; z$19D9	ADD HL,DE
	dc.b	$df	; z$19DA	RST $18
	dc.b	$19	; z$19DB	ADD HL,DE
	dc.b	$e8	; z$19DC	RET PE
	dc.b	$19	; z$19DD	ADD HL,DE
	dc.b	$00	; z$19DE	NOP
	dc.b	$f9	; z$19DF	LD SP,HL
	dc.b	$04	; z$19E0	INC B
	dc.b	$04	; z$19E1	INC B
	dc.b	$ff	; z$19E2	RST $38
	dc.b	$fc	; z$19E3	CALL M,zFF0A
	dc.b	$0a	; z$19E4
	dc.b	$ff	; z$19E5
	dc.b	$e3	; z$19E6	EX (SP),HL
	dc.b	$19	; z$19E7	ADD HL,DE
	dc.b	$f9	; z$19E8	LD SP,HL
	dc.b	$02	; z$19E9	LD (BC),A
	dc.b	$10	; z$19EA	DJNZ z19EB
	dc.b	$ff	; z$19EB
	dc.b	$fc	; z$19EC	CALL M,zFF20
	dc.b	$20	; z$19ED
	dc.b	$ff	; z$19EE
	dc.b	$ec	; z$19EF	CALL PE,z0019
	dc.b	$19	; z$19F0
	dc.b	$00	; z$19F1
	dc.b	$20	; z$19F2	JR NZ,z1A0B
	dc.b	$17	; z$19F3
	dc.b	$10	; z$19F4	DJNZ z19F6
	dc.b	$00	; z$19F5
	dc.b	$04	; z$19F6	INC B
	dc.b	$00	; z$19F7	NOP
	dc.b	$10	; z$19F8	DJNZ z1A15
	dc.b	$1b	; z$19F9
	dc.b	$50	; z$19FA	LD D,B
	dc.b	$00	; z$19FB	NOP
	dc.b	$48	; z$19FC	LD C,B
	dc.b	$00	; z$19FD	NOP
	dc.b	$10	; z$19FE	DJNZ z1A0C
	dc.b	$0c	; z$19FF
	dc.b	$10	; z$1A00	DJNZ z1A02
	dc.b	$00	; z$1A01
	dc.b	$1c	; z$1A02	INC E
	dc.b	$00	; z$1A03	NOP
	dc.b	$20	; z$1A04	JR NZ,z1A12
	dc.b	$0c	; z$1A05
	dc.b	$10	; z$1A06	DJNZ z1A08
	dc.b	$00	; z$1A07
	dc.b	$20	; z$1A08	JR NZ,z1A0A
	dc.b	$00	; z$1A09
	dc.b	$10	; z$1A0A	DJNZ z1A18
	dc.b	$0c	; z$1A0B
	dc.b	$10	; z$1A0C	DJNZ z1A0E
	dc.b	$00	; z$1A0D
	dc.b	$24	; z$1A0E	INC H
	dc.b	$00	; z$1A0F	NOP
	dc.b	$20	; z$1A10	JR NZ,z1A22
	dc.b	$10	; z$1A11
	dc.b	$10	; z$1A12	DJNZ z1A14
	dc.b	$00	; z$1A13
	dc.b	$0e	; z$1A14	LD C,$00
	dc.b	$00	; z$1A15
	dc.b	$20	; z$1A16	JR NZ,z1A2A
	dc.b	$12	; z$1A17
	dc.b	$10	; z$1A18	DJNZ z1A1A
	dc.b	$00	; z$1A19
	dc.b	$03	; z$1A1A	INC BC
	dc.b	$00	; z$1A1B	NOP
	dc.b	$10	; z$1A1C	DJNZ z1A31
	dc.b	$13	; z$1A1D
	dc.b	$09	; z$1A1E	ADD HL,BC
	dc.b	$00	; z$1A1F	NOP
	dc.b	$07	; z$1A20	RLCA
	dc.b	$00	; z$1A21	NOP
	dc.b	$10	; z$1A22	DJNZ z1A38
	dc.b	$14	; z$1A23
	dc.b	$90	; z$1A24	SUB B
	dc.b	$00	; z$1A25	NOP
	dc.b	$0e	; z$1A26	LD C,$00
	dc.b	$00	; z$1A27
	dc.b	$20	; z$1A28	JR NZ,z1A3F
	dc.b	$15	; z$1A29
	dc.b	$50	; z$1A2A	LD D,B
	dc.b	$00	; z$1A2B	NOP
	dc.b	$54	; z$1A2C	LD D,H
	dc.b	$00	; z$1A2D	NOP
	dc.b	$10	; z$1A2E	DJNZ z1A46
	dc.b	$16	; z$1A2F
	dc.b	$50	; z$1A30	LD D,B
	dc.b	$00	; z$1A31	NOP
	dc.b	$48	; z$1A32	LD C,B
	dc.b	$00	; z$1A33	NOP
	dc.b	$10	; z$1A34	DJNZ z1A4C
	dc.b	$16	; z$1A35
	dc.b	$10	; z$1A36	DJNZ z1A38
	dc.b	$00	; z$1A37
	dc.b	$54	; z$1A38	LD D,H
	dc.b	$00	; z$1A39	NOP
	dc.b	$20	; z$1A3A	JR NZ,z1A53
	dc.b	$17	; z$1A3B
	dc.b	$50	; z$1A3C	LD D,B
	dc.b	$00	; z$1A3D	NOP
	dc.b	$14	; z$1A3E	INC D
	dc.b	$00	; z$1A3F	NOP
	dc.b	$20	; z$1A40	JR NZ,z1A59
	dc.b	$17	; z$1A41
	dc.b	$10	; z$1A42	DJNZ z1A44
	dc.b	$00	; z$1A43
	dc.b	$1a	; z$1A44	LD A,(DE)
	dc.b	$00	; z$1A45	NOP
	dc.b	$20	; z$1A46	JR NZ,z1A5F
	dc.b	$17	; z$1A47
	dc.b	$90	; z$1A48	SUB B
	dc.b	$00	; z$1A49	NOP
	dc.b	$22	; z$1A4A	LD ($1000),HL
	dc.b	$00	; z$1A4B
	dc.b	$10	; z$1A4C
	dc.b	$18	; z$1A4D	JR z19D9
	dc.b	$8a	; z$1A4E
	dc.b	$00	; z$1A4F	NOP
	dc.b	$47	; z$1A50	LD B,A
	dc.b	$00	; z$1A51	NOP
	dc.b	$10	; z$1A52	DJNZ z1A6D
	dc.b	$19	; z$1A53
	dc.b	$8e	; z$1A54	ADC A,(HL)
	dc.b	$00	; z$1A55	NOP
	dc.b	$47	; z$1A56	LD B,A
	dc.b	$00	; z$1A57	NOP
	dc.b	$20	; z$1A58	JR NZ,z1A74
	dc.b	$1a	; z$1A59
	dc.b	$10	; z$1A5A	DJNZ z1A5C
	dc.b	$00	; z$1A5B
	dc.b	$12	; z$1A5C	LD (DE),A
	dc.b	$00	; z$1A5D	NOP
	dc.b	$10	; z$1A5E	DJNZ z1A7E
	dc.b	$1e	; z$1A5F
	dc.b	$50	; z$1A60	LD D,B
	dc.b	$00	; z$1A61	NOP
	dc.b	$09	; z$1A62	ADD HL,BC
	dc.b	$00	; z$1A63	NOP
	dc.b	$10	; z$1A64	DJNZ z1A90
	dc.b	$2a	; z$1A65
	dc.b	$50	; z$1A66	LD D,B
	dc.b	$00	; z$1A67	NOP
	dc.b	$5f	; z$1A68	LD E,A
	dc.b	$00	; z$1A69	NOP
	dc.b	$20	; z$1A6A	JR NZ,z1A7D
	dc.b	$11	; z$1A6B
	dc.b	$90	; z$1A6C	SUB B
	dc.b	$00	; z$1A6D	NOP
	dc.b	$0f	; z$1A6E	RRCA
	dc.b	$00	; z$1A6F	NOP
	dc.b	$20	; z$1A70	JR NZ,z1A83
	dc.b	$11	; z$1A71
	dc.b	$50	; z$1A72	LD D,B
	dc.b	$00	; z$1A73	NOP
	dc.b	$08	; z$1A74	EX AF,AF'
	dc.b	$ff	; z$1A75	RST $38
	dc.b	$11	; z$1A76	LD DE,$0000
