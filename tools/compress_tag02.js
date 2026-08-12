#!/usr/bin/env node
// compress_tag02.js — Huffman + LZSS compressor for tag=$02 tilemaps.
// Inverse of decompress_tag02.js. Round-trips: decompress(compress(data)) === data.
//
// USAGE: node compress_tag02.js <inFile> <romOffsetHex>

const fs = require('fs');

class BitWriter {
  constructor() { this.bits = []; }
  writeBit(b) { this.bits.push(b & 1); }
  writeBits(v, n) { for (let i = n - 1; i >= 0; i--) this.writeBit((v >> i) & 1); }
  writeBitsStr(s) { for (const c of s) this.writeBit(c === '1' ? 1 : 0); }
  bytes() {
    while (this.bits.length % 8) this.bits.push(0);
    const out = Buffer.alloc(this.bits.length / 8);
    for (let i = 0; i < this.bits.length; i++) out[i >> 3] |= this.bits[i] << (7 - (i & 7));
    return out;
  }
}

class HuffNode {
  constructor(sym, freq) { this.sym = sym; this.freq = freq; this.left = null; this.right = null; }
  get isLeaf() { return this.left === null; }
}

// Build Huffman tree from symbol frequencies
function buildHuffman(freqs) {
  const heap = [];
  for (const [sym, f] of Object.entries(freqs)) heap.push(new HuffNode(parseInt(sym), f));
  heap.sort((a, b) => a.freq - b.freq);
  while (heap.length > 1) {
    const a = heap.shift(), b = heap.shift();
    const p = new HuffNode(-1, a.freq + b.freq);
    p.left = a; p.right = b;
    // insert sorted
    let i = 0; while (i < heap.length && heap[i].freq < p.freq) i++;
    heap.splice(i, 0, p);
  }
  return heap[0];
}

// Emit tree in the decompressor's format. The ROOT is implicit: the stream
// encodes the root's two children (w0 then w1). An internal child is '1' then
// its own two children; a leaf child is '0' + token.
function emitChild(w, node) {
  if (node.isLeaf) {
    w.writeBit(0); // leaf marker
    if (node.sym >= 0x100) { w.writeBit(1); w.writeBits(node.sym - 0x100, 5); }
    else { w.writeBit(0); w.writeBits(node.sym, 8); }
    return;
  }
  w.writeBit(1);
  emitChild(w, node.left);
  emitChild(w, node.right);
}
function emitTree(w, root) {
  emitChild(w, root.left);
  emitChild(w, root.right);
}
function buildCodeMap(node, prefix, map) {
  if (node.isLeaf) { map[node.sym] = prefix; return; }
  buildCodeMap(node.left, prefix + '0', map);
  buildCodeMap(node.right, prefix + '1', map);
}

// Greedy LZSS: find longest match (len 3..34) within dist 1..255
function lzssEncode(data) {
  const tokens = []; // {type:'lit', v} | {type:'match', len, dist}
  const n = data.length;
  let pos = 0;
  while (pos < n) {
    let bestLen = 0, bestDist = 0;
    const maxDist = 255;
    for (let d = 1; d <= maxDist && pos - d >= 0; d++) {
      let l = 0;
      const maxL = Math.min(33, n - pos); // 0x100-0x11E match tokens; 0x11F is the escape
      while (l < maxL && data[pos + l] === data[pos - d + l]) l++;
      if (l > bestLen) { bestLen = l; bestDist = d; if (l >= 33) break; }
    }
    if (bestLen >= 3) {
      // decompressor: back = dist + 1, so store dist = offset - 1
      tokens.push({ type: 'match', len: bestLen, dist: bestDist - 1 });
      pos += bestLen;
    } else {
      tokens.push({ type: 'lit', v: data[pos] });
      pos += 1;
    }
  }
  return tokens;
}

function compress(data) {
  // 1. LZSS-encode
  const tokens = lzssEncode(data);
  // 2. frequencies over the symbol space (literals, match tokens, distances)
  const freqs = {};
  for (const t of tokens) {
    if (t.type === 'lit') freqs[t.v] = (freqs[t.v] || 0) + 1;
    else {
      const tok = t.len + 0xFD; // 3 -> 0x100, 34 -> 0x11F
      freqs[tok] = (freqs[tok] || 0) + 1;
      freqs[t.dist] = (freqs[t.dist] || 0) + 1;
    }
  }
  if (Object.keys(freqs).length === 0) freqs[0] = 1;
  // the decompressor always builds a 2-child root; guarantee >= 2 symbols
  if (Object.keys(freqs).length === 1) {
    const only = Object.keys(freqs)[0];
    freqs[only === '0' ? '1' : '0'] = 0;
  }
  // 3. Huffman
  const root = buildHuffman(freqs);
  const codes = {};
  buildCodeMap(root, '', codes);
  // 4. emit: 1 discard bit, then tree, then data
  const w = new BitWriter();
  w.writeBit(0); // the loader discards bit7 of byte0
  emitTree(w, root, codes);
  for (const t of tokens) {
    if (t.type === 'lit') {
      w.writeBitsStr(codes[t.v]);
    } else {
      w.writeBitsStr(codes[t.len + 0xFD]);
      w.writeBitsStr(codes[t.dist]);
    }
  }
  return w.bytes();
}

// decode a huffman-encoded match/literal from the code map string
// (helper used by nothing; kept for symmetry)

module.exports = { compress };

if (require.main === module) {
  const inFile = process.argv[2];
  const addr = process.argv[3] || '41c00';
  const data = fs.readFileSync(inFile);
  const out = compress(data);
  fs.writeFileSync('/tmp/wb_tag02_' + addr + '_comp.bin', out);
  console.log('compressed', data.length, '->', out.length, 'bytes');
  // round-trip check via decompressor
  const rom = fs.readFileSync('game.rom');
  const { decompress } = require('./decompress_tag02.js');
  // build a fake rom with the payload at the address
  const raddr = parseInt(addr, 16);
  const fake = Buffer.alloc(raddr + out.length + 16);
  rom.copy(fake, 0, 0, Math.min(rom.length, raddr + out.length + 16));
  out.copy(fake, raddr);
  const res = decompress(fake, raddr);
  const match = res.data.equals(data);
  console.log('round-trip:', match ? 'OK' : 'MISMATCH', match ? '' : '(got ' + res.data.length + ' bytes)');
  if (!match) {
    for (let i = 0; i < data.length; i++) if (data[i] !== res.data[i]) { console.log('first diff at', i, data[i], res.data[i]); break; }
  }
}
