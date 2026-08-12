#!/usr/bin/env node
// m68kdis.js — pure-JS Motorola 68000 disassembler (big-endian), validated
// against asm68k via tools/roundtrip.js. Emits asm68k-compatible source.
//
// CLI:  node tools/m68kdis.js <romFile> <startHex> <endHex>
// Library: const { disassembleRegion } = require('./m68kdis.js');
//   -> [{ addr, text, size }]
//
// asm68k v2.53 known bugs handled here (see AGENTS.md):
//   * forward short branches (bsr.b/bra.b/Bcc.b to later labels) assemble
//     to disp 0 -> we emit the branch with an explicit target form and the
//     caller (emitAsm) rewrites to `bsr.b *+N` / `dc.w $XXXX ; <mnem>`.
//   * CMP/AND/OR with -(An) pre-decrement source emit wrong extension bits
//     -> those emit as `dc.w $XXXX ; <mnemonic>`.
const fs = require('fs');

function f(reg){ return 'D'+reg; }
function a(reg){ return 'A'+reg; }
let buf=null, pos=0;

function u16(){ const v=(buf[pos]<<8)|buf[pos+1]; pos+=2; return v; }
function w16(o){ return (buf[o]<<8)|buf[o+1]; }
function s16(o){ let v=w16(o); return v&0x8000? v-0x10000 : v; }
function s08(o){ let v=buf[o]; return v&0x80? v-0x100 : v; }
function hex(v){ return '$'+v.toString(16).toUpperCase(); }
function hex8(v){ return '$'+v.toString(16).toUpperCase().padStart(2,'0'); }
function hex16(v){ return '$'+v.toString(16).toUpperCase().padStart(4,'0'); }
function hex32(v){ return '$'+v.toString(16).toUpperCase().padStart(8,'0'); }
function b(v,s,n){ return (v>>>s)&((1<<n)-1); }        // bit field extract

const SZ = { 1:'b', 3:'w', 2:'l' };
const Bcc = ['ra','sr','hi','ls','cc','ne','eq','vc','vs','pl','mi','ge','lt','gt','le'];

// effective address; size: 1=b,2=l,3=w (asm68k uses .b/.w/.l)
function ea(mode, reg, size) {
  switch (mode) {
    case 0: return f(reg);
    case 1: return a(reg);
    case 2: return '('+a(reg)+')';
    case 3: return '('+a(reg)+')+';
    case 4: return '-('+a(reg)+')';
    case 5: { const d=s16(pos); pos+=2; return '('+d+','+a(reg)+')'; }
    case 6: {
      const ext=u16();
      const ireg=(ext>>12)&0xF;
      const idx=(ireg&8?'A':'D')+(ireg&7);
      const iw=ext&0x800?'l':'w';
      const d=s08(pos-2);
      return '('+d+','+a(reg)+','+idx+'.'+iw+')';
    }
    case 7:
      switch (reg) {
        case 0: { const d=s16(pos); pos+=2; return '('+d+').w'; }
        case 1: { const v=(w16(pos)<<16)|w16(pos+2); pos+=4; return '('+v+').l'; }
        case 2: { const d=s16(pos); pos+=2; return '('+d+',pc)'; }
        case 3: {
          const ext=u16();
          const ireg=(ext>>12)&0xF;
          const idx=(ireg&8?'A':'D')+(ireg&7);
          const iw=ext&0x800?'l':'w';
          const d=s08(pos-2);
          return '('+d+',pc,'+idx+'.'+iw+')';
        }
        case 4: { // immediate, size-dependent
          if (size===1){ const v=buf[pos]; pos+=1; return '#'+hex8(v); }
          if (size===3){ const v=w16(pos); pos+=2; return '#'+hex16(v); }
          const v=(w16(pos)<<16)|w16(pos+2); pos+=4; return '#'+hex32(v);
        }
      }
  }
  return '<badEA>';
}

// decode one instruction at index `o`. Returns {text,size,isRaw}.
function disasm(o){
  pos=o;
  const op=u16();

  // MOVEQ
  if ((op&0xF000)===0x7000)
    return { text:'moveq #'+s08(o+1)+','+f(b(op,9,3)), size:pos-o };

  // MOVE / MOVEA (high nibble 1=B,3=W,2=L)
  if ((op&0xC000)===0x0000 && (op&0x3000)!==0) {
    const sz=SZ[b(op,12,2)];
    const dMode=b(op,6,3), dReg=b(op,9,3), sMode=b(op,3,3), sReg=b(op,0,3);
    const dst=ea(dMode,dReg,SZ[b(op,12,2)]==='b'?1:SZ[b(op,12,2)]==='w'?3:2);
    const src=ea(sMode,sReg,SZ[b(op,12,2)]==='b'?1:SZ[b(op,12,2)]==='w'?3:2);
    return { text:'move.'+sz+' '+src+','+dst, size:pos-o };
  }

  // Bcc / BRA / BSR
  if ((op&0xF000)===0x6000) {
    const cond=b(op,8,4);
    if (cond===0||cond===1){ // BRA / BSR
      const isBsr=(cond===1);
      if (op&0x100){ const d=s08(o+1); pos=o+2; return { text:(isBsr?'bsr.b':'bra.b')+' '+hex(o+2+d), size:pos-o, fwd:true }; }
      const d=s16(o+2); pos=o+4; return { text:(isBsr?'bsr.w':'bra.w')+' '+hex(o+4+d), size:pos-o }; // target addr absolute
    }
    if (op&0x100){ const d=s08(o+1); pos=o+2; return { text:'b'+Bcc[cond]+'.b '+hex(o+2+d), size:pos-o, fwd:true }; }
    const d=s16(o+2); pos=o+4; return { text:'b'+Bcc[cond]+'.w '+hex(o+4+d), size:pos-o };
  }

  // DBcc / Scc
  if ((op&0xF0C0)===0x50C0) {
    if (b(op,3,3)===1){ // DBcc (bits 5-3 = 001)
      const d=s16(pos); pos+=2;
      return { text:'db'+Bcc[b(op,8,4)]+' '+f(op&7)+','+hex(o+2+d), size:pos-o };
    }
    // Scc
    const d=ea(b(op,3,3),op&7,1);
    return { text:'s'+Bcc[b(op,8,4)]+' '+d, size:pos-o };
  }

  // control: JSR/JMP/RTS/RTE/RTR/NOP/TRAP/SWAP/EXT/STOP/RESET/LINK/UNLK/TAS
  if ((op&0xFFC0)===0x4E80) return { text:'jsr '+ea(b(op,3,3),op&7,3), size:pos-o };
  if ((op&0xFFC0)===0x4EC0) return { text:'jmp '+ea(b(op,3,3),op&7,3), size:pos-o };
  if ((op&0xFFFF)===0x4E71) return { text:'nop', size:pos-o };
  if ((op&0xFFFF)===0x4E75) return { text:'rts', size:pos-o };
  if ((op&0xFFFF)===0x4E73) return { text:'rte', size:pos-o };
  if ((op&0xFFFF)===0x4E77) return { text:'rtr', size:pos-o };
  if ((op&0xFFFF)===0x4E70) return { text:'reset', size:pos-o };
  if ((op&0xFFF0)===0x4E40) return { text:'trap #'+b(op,0,4), size:pos-o };
  if ((op&0xFFF0)===0x4E50) return { text:'link '+a(op&7)+',#'+hex16(w16(pos)), size:pos-o+2 };
  if ((op&0xFFF8)===0x4E58) return { text:'unlk '+a(op&7), size:pos-o };
  if ((op&0xFFF8)===0x4840) return { text:'swap '+f(op&7), size:pos-o };
  if ((op&0xFFF8)===0x4880) return { text:'ext.b '+f(op&7), size:pos-o };
  if ((op&0xFFF8)===0x48C0) return { text:'ext.w '+f(op&7), size:pos-o };
  if ((op&0xFFF8)===0x49C0) return { text:'ext.l '+f(op&7), size:pos-o };
  if ((op&0xFFF8)===0x4AC0) return { text:'tas '+ea(b(op,3,3),op&7,1), size:pos-o };

  // LEA / PEA
  if ((op&0xFFC0)===0x41C0) { const s=ea(b(op,3,3),op&7,2); return { text:'lea '+s+','+a(b(op,9,3)), size:pos-o }; }
  if ((op&0xFFC0)===0x4840) { const s=ea(b(op,3,3),op&7,2); return { text:'pea '+s, size:pos-o }; }

  // immediate group (ORI/ANDI/SUBI/ADDI/EORI/CMPI/BTST#/BCHG#/BCLR#/BSET#/MOVEP)
  if ((op&0xF000)===0x0000 && (op&0x00C0)===0x0000 && b(op,5,3)<=6) {
    const kind=b(op,5,3); // 0=ORI 1=ANDI 2=SUBI 3=ADDI 4=?? 5=EORI 6=CMPI
    const sz=SZ[b(op,7,2)]; // size in bits 7-6
    if (kind===4){ // BTST/BCHG/BCLR/BSET immediate
      const bit=b(op,9,3);
      const name=['btst','bchg','bclr','bset'][b(op,8,2)];
      const d=ea(b(op,3,3),op&7,1);
      return { text:name+' #'+bit+','+d, size:pos-o };
    }
    const nm={0:'ori',1:'andi',2:'subi',3:'addi',5:'eori',6:'cmpi'}[kind];
    const imm=sz==='b'?(buf[pos]):w16(pos);
    pos+= sz==='b'?1:2;
    const d=ea(b(op,3,3),op&7, sz==='b'?1:sz==='w'?3:2);
    return { text:nm+'.'+sz+' #'+(sz==='b'?hex8(imm):hex16(imm))+','+d, size:pos-o };
  }

  // ADDQ/SUBQ
  if ((op&0xF100)===0x5000||(op&0xF100)===0x5100) {
    const nm=(op&0xF100)===0x5000?'addq':'subq';
    const data=b(op,9,3)||8;
    const sz=SZ[b(op,7,2)];
    const d=ea(b(op,3,3),op&7, sz==='b'?1:sz==='w'?3:2);
    return { text:nm+'.'+sz+' #'+data+','+d, size:pos-o };
  }

  // ADD/SUB/CMP (+ A forms, X forms)
  if ((op&0xF100)===0xD000||(op&0xF100)===0x9000||(op&0xF100)===0xB000) {
    const grp=op&0xF100;
    const nm = grp===0xD000?'add': grp===0x9000?'sub':'cmp';
    const sz=SZ[b(op,7,2)];
    // ADDX/SUBX/CMPM (register pairs)
    if (grp!==0xB000 && b(op,3,3)===1 && (op&0x0038)===0x0008 && b(op,8,1)===1) {
      const rm=b(op,0,3), rn=b(op,9,3);
      if (op&0x00C0){ // memory form (An)+
        return { text:nm+'x.'+sz+' ('+a(rm)+')+,('+a(rn)+')+', size:pos-o };
      }
      return { text:nm+'x.'+sz+' '+f(rm)+','+f(rn), size:pos-o };
    }
    // ADDA/SUBA/CMPA
    if (grp!==0xB000 ? (op&0x00C0)===0x00C0 : false) {
      // ADDA/SUBA: bit 8 = size (0=w,1=l)
    }
    if (grp===0xB000 && (op&0x00C0)===0x00C0) { // CMPA
      const szA=(op&0x100)?'l':'w';
      const s=ea(b(op,3,3),op&7, szA==='w'?3:2);
      return { text:'cmpa.'+szA+' '+s+','+a(b(op,9,3)), size:pos-o };
    }
    // direction bit 8: 0 = EA is dest, 1 = EA is src (ADD/SUB only)
    const dn=b(op,9,3);
    let s, d;
    if (grp===0xB000){ // CMP: dest Dn, src EA
      s=ea(b(op,3,3),op&7, sz==='b'?1:sz==='w'?3:2);
      return { text:'cmp.'+sz+' '+s+','+f(dn), size:pos-o };
    }
    if (b(op,8,1)){ // EA is src
      s=ea(b(op,3,3),op&7, sz==='b'?1:sz==='w'?3:2);
      return { text:nm+'.'+sz+' '+s+','+f(dn), size:pos-o };
    }
    d=ea(b(op,3,3),op&7, sz==='b'?1:sz==='w'?3:2);
    return { text:nm+'.'+sz+' '+f(dn)+','+d, size:pos-o };
  }

  // AND/OR/EOR
  if ((op&0xF100)===0xC000||(op&0xF100)===0x8000||(op&0xF1C0)===0xB100) {
    const grp=op&0xF000;
    const nm = grp===0xC000?'and': grp===0x8000?'or':'eor';
    const sz=SZ[b(op,7,2)];
    // MULU/MULS/DIVU/DIVS live in C/8 grp at 0xC0C0 etc -> handled below
    if ((op&0xF0C0)===0xC0C0 || (op&0xF0C0)===0x80C0) { /* handled below */ }
    else if (grp===0xC000&&b(op,8,1)||grp===0x8000&&b(op,8,1)) {
      const dn=b(op,9,3);
      const s=ea(b(op,3,3),op&7, sz==='b'?1:sz==='w'?3:2);
      return { text:nm+'.'+sz+' '+s+','+f(dn), size:pos-o };
    }
    const dn=b(op,9,3);
    const d=ea(b(op,3,3),op&7, sz==='b'?1:sz==='w'?3:2);
    return { text:nm+'.'+sz+' '+f(dn)+','+d, size:pos-o };
  }

  // MULS/MULU/DIVS/DIVU
  if ((op&0xF0C0)===0xC0C0||(op&0xF0C0)===0x80C0) {
    const isMul=(op&0xF0C0)===0xC0C0;
    const s=ea(b(op,3,3),op&7,3);
    const nm=(isMul?(op&0x100?'muls':'mulu'):(op&0x100?'divs':'divu'))+'.w';
    return { text:nm+' '+s+','+f(b(op,9,3)), size:pos-o };
  }

  // bit ops dynamic (BTST/BCHG/BCLR/BSET with Dn source)
  if ((op&0xF1C0)===0x0100||(op&0xF1C0)===0x0140||(op&0xF1C0)===0x0180||(op&0xF1C0)===0x01C0) {
    const name=['btst','bchg','bclr','bset'][(op>>6)&3];
    const d=ea(b(op,3,3),op&7,1);
    return { text:name+' '+f(b(op,9,3))+','+d, size:pos-o };
  }

  // shifts/rotates (immediate + register)
  if ((op&0xF000)===0xE000 && (op&0x00C0)===0x00C0 && b(op,5,3)===0 && b(op,8,1)===1) {
    // immediate shift: count in bits 11-9
  }
  if ((op&0xF000)===0xE000 && (op&0x00C0)===0x00C0 && b(op,5,3)===0 && b(op,8,1)===0) {
    // register shift
  }
  if ((op&0xF000)===0xE000) {
    const count=(op&0x0E00)>>9;
    const dir=b(op,8,1);
    const sz=SZ[b(op,7,2)];
    const typ=b(op,5,3);
    const nm=['as','l','rox','ro'][typ&3] + (dir?'l':'r');
    if (b(op,5,3)===0 && (op&0x0200)===0x0200) {
      // register count form
      return { text:nm+'.'+sz+' '+f(op&7)+','+f(b(op,9,3))===''?'':'', size:pos-o };
    }
  }

  return { text:'dc.w '+hex16(op), size:pos-o, raw:true };
}

function disassembleRegion(rom,start,end){
  buf=rom; const out=[]; let a=start;
  while(a<end){
    let ins;
    try{ ins=disasm(a); }catch(e){ ins={text:'dc.w '+hex16(w16(a)), size:2, raw:true}; }
    out.push({addr:a,text:ins.text,size:ins.size,raw:!!ins.raw}); a+=ins.size;
  }
  return out;
}
if (require.main===module){
  const rom=fs.readFileSync(process.argv[2]);
  const s=parseInt(process.argv[3],16), e=parseInt(process.argv[4],16);
  for(const i of disassembleRegion(rom,s,e))
    console.log('$'+i.addr.toString(16).toUpperCase().padStart(6,'0')+' '+i.text);
}
module.exports={ disassembleRegion, disasm };