#!/usr/bin/env node
// z80dis.js — Z80 disassembler for the Wonder Boy sound driver.
// Full standard Z80 ISA (CB/DD/FD/ED prefixes). Registers are decoded from
// the opcode (r = op>>3&7, rp = op>>4&3) — NOT from following bytes.
// USAGE: node tools/z80dis.js <romOffsetHex> <lengthHex>
const fs = require('fs');
const rom = fs.readFileSync('game.rom');

const R = ['B', 'C', 'D', 'E', 'H', 'L', '(HL)', 'A'];
const RP = ['BC', 'DE', 'HL', 'SP'];
const ALU = ['ADD A,', 'ADC A,', 'SUB ', 'SBC A,', 'AND ', 'XOR ', 'OR ', 'CP '];

class Dis {
  constructor(buf) { this.b = buf; this.pc = 0; this.out = []; }
  byte() { return this.b[this.pc++]; }
  word() { const lo = this.b[this.pc++], hi = this.b[this.pc++]; return (hi << 8) | lo; }
  rel() { const d = this.b[this.pc++]; return (this.pc + (d < 128 ? d : d - 256)); }
  imm8() { return '$' + this.byte().toString(16).toUpperCase().padStart(2, '0'); }
  imm16() { return '$' + this.word().toString(16).toUpperCase().padStart(4, '0'); }
  label(addr) { return 'z' + addr.toString(16).toUpperCase().padStart(4, '0'); }
  disp(pref) {
    const d = this.b[this.pc++];
    const sd = d < 128 ? d : d - 256;
    return '(' + pref + (sd < 0 ? '-' : '+') + Math.abs(sd).toString(16).toUpperCase() + ')';
  }
  dis() {
    while (this.pc < this.b.length) {
      const start = this.pc;
      const op = this.byte();
      let text;
      if (op === 0xCB) text = this.cb();
      else if (op === 0xDD) text = this.dix('IX');
      else if (op === 0xFD) text = this.dix('IY');
      else if (op === 0xED) text = this.ed();
      else text = this.main(op);
      this.out.push({ pc: start, bytes: this.pc - start, text });
    }
    return this.out;
  }
  main(op) {
    const r = () => R[op >> 3 & 7];
    const rp = () => RP[op >> 4 & 3];
    if (op === 0x00) return 'NOP';
    if (op === 0x07) return 'RLCA';
    if (op === 0x08) return 'EX AF,AF\'';
    if (op === 0x0F) return 'RRCA';
    if (op === 0x17) return 'RLA';
    if (op === 0x1F) return 'RRA';
    if (op === 0x27) return 'DAA';
    if (op === 0x2F) return 'CPL';
    if (op === 0x37) return 'SCF';
    if (op === 0x3F) return 'CCF';
    if (op === 0x76) return 'HALT';
    if (op === 0x02) return 'LD (BC),A';
    if (op === 0x0A) return 'LD A,(BC)';
    if (op === 0x12) return 'LD (DE),A';
    if (op === 0x1A) return 'LD A,(DE)';
    if (op === 0x22) return 'LD (' + this.imm16() + '),HL';
    if (op === 0x2A) return 'LD HL,(' + this.imm16() + ')';
    if (op === 0x32) return 'LD (' + this.imm16() + '),A';
    if (op === 0x3A) return 'LD A,(' + this.imm16() + ')';
    if (op === 0x34) return 'INC (HL)';
    if (op === 0x35) return 'DEC (HL)';
    if (op === 0x36) return 'LD (HL),' + this.imm8();
    if (op === 0x46) return 'LD B,(HL)';
    if (op === 0x4E) return 'LD C,(HL)';
    if (op === 0x56) return 'LD D,(HL)';
    if (op === 0x5E) return 'LD E,(HL)';
    if (op === 0x66) return 'LD H,(HL)';
    if (op === 0x6E) return 'LD L,(HL)';
    if (op === 0x7E) return 'LD A,(HL)';
    if (op === 0x86) return 'ADD A,(HL)';
    if (op === 0x8E) return 'ADC A,(HL)';
    if (op === 0x96) return 'SUB (HL)';
    if (op === 0x9E) return 'SBC A,(HL)';
    if (op === 0xA6) return 'AND (HL)';
    if (op === 0xAE) return 'XOR (HL)';
    if (op === 0xB6) return 'OR (HL)';
    if (op === 0xBE) return 'CP (HL)';
    if (op >= 0x40 && op <= 0x7F) {
      const d = op >> 3 & 7, s = op & 7;
      return 'LD ' + R[d] + ',' + R[s];
    }
    if (op >= 0x80 && op <= 0xBF) return ALU[op >> 3 & 7] + R[op & 7];
    switch (op) {
      case 0x01: return 'LD ' + rp() + ',' + this.imm16();
      case 0x03: return 'INC ' + rp();
      case 0x04: return 'INC ' + r();
      case 0x05: return 'DEC ' + r();
      case 0x06: return 'LD ' + r() + ',' + this.imm8();
      case 0x09: return 'ADD HL,' + rp();
      case 0x0B: return 'DEC ' + rp();
      case 0x0C: return 'INC ' + r();
      case 0x0D: return 'DEC ' + r();
      case 0x0E: return 'LD ' + r() + ',' + this.imm8();
      case 0x10: return 'DJNZ ' + this.label(this.rel());
      case 0x11: return 'LD ' + rp() + ',' + this.imm16();
      case 0x13: return 'INC ' + rp();
      case 0x14: return 'INC ' + r();
      case 0x15: return 'DEC ' + r();
      case 0x16: return 'LD ' + r() + ',' + this.imm8();
      case 0x18: return 'JR ' + this.label(this.rel());
      case 0x19: return 'ADD HL,' + rp();
      case 0x1B: return 'DEC ' + rp();
      case 0x1C: return 'INC ' + r();
      case 0x1D: return 'DEC ' + r();
      case 0x1E: return 'LD ' + r() + ',' + this.imm8();
      case 0x20: return 'JR NZ,' + this.label(this.rel());
      case 0x21: return 'LD ' + rp() + ',' + this.imm16();
      case 0x23: return 'INC ' + rp();
      case 0x24: return 'INC ' + r();
      case 0x25: return 'DEC ' + r();
      case 0x26: return 'LD ' + r() + ',' + this.imm8();
      case 0x28: return 'JR Z,' + this.label(this.rel());
      case 0x29: return 'ADD HL,' + rp();
      case 0x2B: return 'DEC ' + rp();
      case 0x2C: return 'INC ' + r();
      case 0x2D: return 'DEC ' + r();
      case 0x2E: return 'LD ' + r() + ',' + this.imm8();
      case 0x30: return 'JR NC,' + this.label(this.rel());
      case 0x31: return 'LD ' + rp() + ',' + this.imm16();
      case 0x33: return 'INC ' + rp();
      case 0x3B: return 'DEC ' + rp();
      case 0x38: return 'JR C,' + this.label(this.rel());
      case 0x39: return 'ADD HL,' + rp();
      case 0x3C: return 'INC ' + r();
      case 0x3D: return 'DEC ' + r();
      case 0x3E: return 'LD ' + r() + ',' + this.imm8();
      case 0xC0: return 'RET NZ';
      case 0xC1: return 'POP ' + rp();
      case 0xC2: return 'JP NZ,' + this.label(this.word());
      case 0xC3: return 'JP ' + this.label(this.word());
      case 0xC4: return 'CALL NZ,' + this.label(this.word());
      case 0xC5: return 'PUSH ' + rp();
      case 0xC6: return 'ADD A,' + this.imm8();
      case 0xC7: return 'RST $00';
      case 0xC8: return 'RET Z';
      case 0xC9: return 'RET';
      case 0xCA: return 'JP Z,' + this.label(this.word());
      case 0xCC: return 'CALL Z,' + this.label(this.word());
      case 0xCD: return 'CALL ' + this.label(this.word());
      case 0xCE: return 'ADC A,' + this.imm8();
      case 0xCF: return 'RST $08';
      case 0xD0: return 'RET NC';
      case 0xD1: return 'POP ' + rp();
      case 0xD2: return 'JP NC,' + this.label(this.word());
      case 0xD3: return 'OUT (' + this.imm8() + '),A';
      case 0xD4: return 'CALL NC,' + this.label(this.word());
      case 0xD5: return 'PUSH ' + rp();
      case 0xD6: return 'SUB ' + this.imm8();
      case 0xD7: return 'RST $10';
      case 0xD8: return 'RET C';
      case 0xD9: return 'EXX';
      case 0xDA: return 'JP C,' + this.label(this.word());
      case 0xDB: return 'IN A,(' + this.imm8() + ')';
      case 0xDC: return 'CALL C,' + this.label(this.word());
      case 0xDE: return 'SBC A,' + this.imm8();
      case 0xDF: return 'RST $18';
      case 0xE0: return 'RET PO';
      case 0xE1: return 'POP ' + rp();
      case 0xE2: return 'JP PO,' + this.label(this.word());
      case 0xE3: return 'EX (SP),HL';
      case 0xE4: return 'CALL PO,' + this.label(this.word());
      case 0xE5: return 'PUSH ' + rp();
      case 0xE6: return 'AND ' + this.imm8();
      case 0xE7: return 'RST $20';
      case 0xE8: return 'RET PE';
      case 0xE9: return 'JP (HL)';
      case 0xEA: return 'JP PE,' + this.label(this.word());
      case 0xEB: return 'EX DE,HL';
      case 0xEC: return 'CALL PE,' + this.label(this.word());
      case 0xEE: return 'XOR ' + this.imm8();
      case 0xEF: return 'RST $28';
      case 0xF0: return 'RET P';
      case 0xF1: return 'POP ' + rp();
      case 0xF2: return 'JP P,' + this.label(this.word());
      case 0xF3: return 'DI';
      case 0xF4: return 'CALL P,' + this.label(this.word());
      case 0xF5: return 'PUSH ' + rp();
      case 0xF6: return 'OR ' + this.imm8();
      case 0xF7: return 'RST $30';
      case 0xF8: return 'RET M';
      case 0xF9: return 'LD SP,HL';
      case 0xFA: return 'JP M,' + this.label(this.word());
      case 0xFB: return 'EI';
      case 0xFC: return 'CALL M,' + this.label(this.word());
      case 0xFE: return 'CP ' + this.imm8();
      case 0xFF: return 'RST $38';
      default: return 'DB $' + op.toString(16).toUpperCase().padStart(2, '0');
    }
  }
  cb() {
    const op = this.byte();
    const b = op >> 6 & 7, y = op >> 3 & 7, z = op & 7;
    const rot = ['RLC ', 'RRC ', 'RL ', 'RR ', 'SLA ', 'SRA ', 'SLL ', 'SRL '];
    if (z === 6) {
      if (b < 4) return rot[b] + '(HL)';
      if (b === 6) return (y < 4 ? 'BIT ' + y + ',' : y === 4 ? 'RES 4,' : 'SET ' + y + ',') + '(HL)';
      return rot[b] + '(HL)';
    }
    if (b < 4) return rot[b] + R[y];
    if (b === 4) return 'SLA ' + R[y];
    if (b === 5) return 'SRA ' + R[y];
    if (b === 6) return (y < 4 ? 'BIT ' + y + ',' : y === 4 ? 'RES 4,' : 'SET ' + y + ',') + R[z];
    return 'SRL ' + R[y];
  }
  dix(pref) {
    const op = this.byte();
    if (op === 0xCB) {
      const d = this.byte();
      const sd = d < 128 ? d : d - 256;
      const op2 = this.byte();
      const b = op2 >> 6 & 7, y = op2 >> 3 & 7, z = op2 & 7;
      const mem = '(' + pref + (sd < 0 ? '-' : '+') + Math.abs(sd).toString(16).toUpperCase() + ')';
      const rot = ['RLC ', 'RRC ', 'RL ', 'RR ', 'SLA ', 'SRA ', 'SLL ', 'SRL '];
      if (b < 4) return rot[b] + mem;
      if (b === 6) return (y < 4 ? 'BIT ' + y + ',' : y === 4 ? 'RES 4,' : 'SET ' + y + ',') + mem;
      return rot[b] + mem;
    }
    if (op >= 0x40 && op <= 0x7F) {
      const d = this.byte();
      const src = R[op >> 3 & 7], dst = R[op & 7];
      if ((op & 7) === 6) return 'LD ' + src + ',' + this.disp(pref);
      if ((op >> 3 & 7) === 6) return 'LD ' + this.disp(pref) + ',' + dst;
      return 'LD ' + src + ',' + dst;
    }
    if (op >= 0x80 && op <= 0xBF) return ALU[op >> 3 & 7] + this.disp(pref);
    switch (op) {
      case 0x09: return 'ADD ' + pref + ',BC';
      case 0x19: return 'ADD ' + pref + ',DE';
      case 0x29: return 'ADD ' + pref + ',' + pref;
      case 0x39: return 'ADD ' + pref + ',SP';
      case 0x21: return 'LD ' + pref + ',' + this.imm16();
      case 0x22: return 'LD (' + this.imm16() + '),' + pref;
      case 0x23: return 'INC ' + pref;
      case 0x24: return 'INC ' + pref + 'H';
      case 0x25: return 'DEC ' + pref + 'H';
      case 0x26: return 'LD ' + pref + 'H,' + this.imm8();
      case 0x2A: return 'LD ' + pref + ',(' + this.imm16() + ')';
      case 0x2B: return 'DEC ' + pref;
      case 0x2C: return 'INC ' + pref + 'L';
      case 0x2D: return 'DEC ' + pref + 'L';
      case 0x2E: return 'LD ' + pref + 'L,' + this.imm8();
      case 0x34: this.byte(); return 'INC ' + this.disp(pref);
      case 0x35: this.byte(); return 'DEC ' + this.disp(pref);
      case 0x36: return 'LD ' + this.disp(pref) + ',' + this.imm8();
      case 0xE1: return 'POP ' + pref;
      case 0xE5: return 'PUSH ' + pref;
      case 0xE9: return 'JP (' + pref + ')';
      default: return 'DB $' + pref + ', $' + op.toString(16).toUpperCase().padStart(2, '0');
    }
  }
  ed() {
    const op = this.byte();
    const p = () => RP[op >> 4 & 3];
    const r = () => R[op >> 3 & 7];
    if (op === 0x46 || op === 0x4E) return 'IM 0';
    if (op === 0x56) return 'IM 1';
    if (op === 0x5E) return 'IM 2';
    if (op === 0x4D) return 'RETI';
    if (op === 0x45) return 'RETN';
    if (op === 0x44) return 'NEG';
    if (op === 0x47) return 'LD I,A';
    if (op === 0x4F) return 'LD R,A';
    if (op === 0x57) return 'LD A,I';
    if (op === 0x5F) return 'LD A,R';
    if (op === 0x67) return 'RRD';
    if (op === 0x6F) return 'RLD';
    if ((op & 0xC7) === 0x40) return 'IN ' + r() + ',(C)';
    if ((op & 0xC7) === 0x41) return 'OUT (C),' + r();
    if ((op & 0xC7) === 0x42) return 'SBC HL,' + p();
    if ((op & 0xC7) === 0x4A) return 'ADC HL,' + p();
    if ((op & 0xCF) === 0x43) return 'LD (' + this.imm16() + '),' + p();
    if ((op & 0xCF) === 0x4B) return 'LD ' + p() + ',(' + this.imm16() + ')';
    if (op === 0xA0) return 'LDI';
    if (op === 0xB0) return 'LDIR';
    if (op === 0xA8) return 'LDD';
    if (op === 0xB8) return 'LDDR';
    if (op === 0xA1) return 'CPI';
    if (op === 0xB1) return 'CPIR';
    if (op === 0xA9) return 'CPD';
    if (op === 0xB9) return 'CPDR';
    if (op === 0xA2) return 'INI';
    if (op === 0xB2) return 'INIR';
    if (op === 0xAA) return 'IND';
    if (op === 0xBA) return 'INDR';
    if (op === 0xA3) return 'OUTI';
    if (op === 0xB3) return 'OTIR';
    if (op === 0xAB) return 'OUTD';
    if (op === 0xBB) return 'OTDR';
    return 'DB $ED, $' + op.toString(16).toUpperCase().padStart(2, '0');
  }
}
function main() {
  const start = parseInt(process.argv[2] || '98000', 16);
  const len = parseInt(process.argv[3] || '1a76', 16);
  const d = new Dis(rom.slice(start, start + len));
  for (const i of d.dis()) {
    console.log('$' + i.pc.toString(16).toUpperCase().padStart(4, '0') + '\t' + i.text);
  }
}
main();
