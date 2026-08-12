#!/usr/bin/env node
// decompress_tag02.js — Huffman tree + LZSS decompressor for tag=$02 payload records.
//
// Algorithm reverse-engineered from $6D9C-$6EA6 (loaders):
//   1. $6D9C-$6DE6  build a binary tree from the header bitstream
//      (bit=1 creates a node, bit=0 sets a token leaf)
//   2. $6DEA-$6E2C  LZSS loop: walk tree for tokens
//      token < $100  -> literal byte
//      token >= $100 -> match: len = token-$FD, dist token follows (walk tree)
//   3. $6E2E-$6E4C  tree walker; $6E4E/$6E76 bit/token readers
// Output length = 0x3FF = 1023 bytes per record.
//
// USAGE: node decompress_tag02.js <romOffsetHex>

const fs = require('fs');
const rom = fs.readFileSync('game.rom');

class BitReader {
  constructor(data, start) {
    this.data = data;
    this.pos = start + 1; // byte0 already loaded (move.b (A0)+,D0 in the loader)
    this.byte = data[start];
    this.bits = 7;
  }
  readBit() {
    if (this.bits === -1) { this.byte = this.data[this.pos++]; this.bits = 7; }
    const b = (this.byte >> this.bits) & 1;
    this.bits--;
    return b;
  }
  readBits(n) {
    let v = 0;
    for (let i = 0; i < n; i++) v = (v << 1) | this.readBit();
    return v;
  }
}

function decompress(rom, addr) {
  const r = new BitReader(rom, addr);
  const BASE = 0x8F0A;
  // node: { w0, w1 } where values are positive tokens or negative RAM-addr pointers
  const nodeAt = new Map();
  const getNode = (ram) => { if (!nodeAt.has(ram)) nodeAt.set(ram, {}); return nodeAt.get(ram); };

  // tree builder $6D9C
  r.readBit(); // entry does `add.b D0,D0` once (bit7 of byte0 discarded)
  let D3 = BASE;
  let A2ram = BASE;
  let D2 = 0; // 0 = fill w0, 2 = fill w1
  let D4 = 0; // node stack depth
  const stack = [];
  let created = 0;
  for (;;) {
    if (created > 4096) throw new Error('tree build diverged at bit pos ' + r.pos);
    const bit = r.readBit();
    if (bit === 1) {
      D3 += 4;
      created++;
      const cur = getNode(A2ram);
      if (D2 === 0) {
        stack.push(A2ram);
        D4++;
        cur.w0 = -D3; // pointer to child
      } else {
        cur.w1 = -D3;
        D2 = 0;
      }
      A2ram = D3;
    } else {
      const tok = readToken(r);
      const cur = getNode(A2ram);
      if (D2 === 0) {
        cur.w0 = tok;
        D2 = 2;
      } else {
        cur.w1 = tok;
        A2ram = stack.pop();
        D4--;
        if (D4 === -1) break;
      }
    }
  }

  // tree walker $6E2E
  const walk = () => {
    let A2ram = BASE;
    for (;;) {
      const bit = r.readBit();
      if (bit) A2ram += 2;
      const node = nodeAt.get(A2ram - (bit ? 2 : 0));
      let w = bit ? node.w1 : node.w0;
      if (w < 0) { A2ram = -w; continue; }
      if (w === 0x11F) return readToken(r);
      return w;
    }
  };

  // LZSS loop $6DEA
  const out = [];
  let count = 0x3FF;
  let iter = 0;
  for (;;) {
    if (++iter > 2000000) throw new Error('LZSS diverged; count=' + count + ' outlen=' + out.length);
    const tok = walk();
    if (!Number.isInteger(tok) || tok < 0 || tok > 0x11F) throw new Error('bad token ' + tok + ' at iter ' + iter);
    if (tok < 0x100) {
      out.push(tok);
      count--;
      if (count < 0) break;
    } else {
      let len = tok - 0xFD;
      const dist = walk();
      if (!Number.isInteger(dist) || dist < 0) throw new Error('bad dist ' + dist);
      const back = dist + 1;
      for (let i = 0; i < len; i++) {
        out.push(out[out.length - back]);
      }
      count -= len;
      if (count < 0) break;
    }
  }
  return { data: Buffer.from(out), next: r.pos, nodeCount: nodeAt.size };
}

function readToken(r) {
  // $6E4E: bit set -> $6E76 special (5-bit -> 0x100+); else 8-bit literal
  const bit = r.readBit();
  if (bit === 1) return 0x100 + r.readBits(5);
  return r.readBits(8);
}

function main() {
  const addr = parseInt(process.argv[2] || '41c00', 16);
  const res = decompress(rom, addr);
  console.log('decoded', res.data.length, 'bytes (', res.data.length / 32, 'tiles ), next offset:', res.next.toString(16), 'consumed:', res.next - addr, 'nodes:', res.nodeCount);
  // dump first 128 bytes as hex + words
  const hex = [];
  for (let i = 0; i < Math.min(res.data.length, 256); i += 16) {
    const row = [...res.data.slice(i, i + 16)].map(b => b.toString(16).padStart(2, '0')).join(' ');
    console.log('  ' + row);
  }
  fs.writeFileSync(`/tmp/wb_tag02_${addr.toString(16)}.bin`, res.data);
  console.log('wrote /tmp/wb_tag02_' + addr.toString(16) + '.bin');
}

main();
