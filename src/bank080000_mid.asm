; ROM range: 0x098000-0x09F776
; Conservative split of the first non-fill tail-bank island. The front 0x098000-0x0991FF
; span still begins with a strongly Z80/opcode-dense code body rather than plain 68k or
; obvious asset data, but it no longer stays monolithic: the final 0x185 bytes are now
; explicit as two odd-aligned little-endian word lookup tables and one trailing zero byte.
; The next 0x099200-0x09991F span is also split separately because it is structurally cleaner:
; monotone byte bands, a fixed 19-byte record family, smaller mixed/control tails, and a short
; local-offset/word trailer leading into the already split descriptor-header region plus the
; adjacent fixed-record layout band. The larger command region still keeps its front lead-in
; and bank-local offset table explicit before the denser command records, and the formerly
; monolithic trailing command body at 0x09A348-0x09F776 remains divided into three ROM-order
; source windows, each further split at every proven local 0xFF terminator so the
; command-record cadence is explicit even before the subsystem owner is clearer.

	include "src/bank080000_mid_z80_program.asm"

Bank080000_PreDescriptorStructuredData_099200:
	include "src/bank080000_mid_front.asm"

Bank080000_StructuredDescriptorAndLayoutRecords_099920:
	include "src/bank080000_mid_descriptors.asm"

	include "src/bank080000_mid_command_front.asm"

Bank080000_FFTerminatedCommandRecordWindowFront_09A348:
	include "src/bank080000_mid_command_tail_front.asm"

Bank080000_FFTerminatedCommandRecordWindowMid_09C008:
	include "src/bank080000_mid_command_tail_mid.asm"

Bank080000_FFTerminatedCommandRecordWindowTail_09E028:
	include "src/bank080000_mid_command_tail_tail.asm"
