#!/usr/bin/env node
// decompress_tiles.js — implement + test the tag=$00 tile decompressor.
//
// The flagged-table loader at $6BC4 dispatches:
//   tag $00 -> stream loader at $6BFC (this file: RLE/bitmask + pattern+planar)
//   tag $01 -> direct copy 0x400 bytes
//   tag $02 -> tree builder at $6D9C
// Each stream block holds 32 tiles. Tile = 32 bytes, 4bpp planar.
// Control byte per tile:
//   0x00       -> next 32 bytes are the literal tile
//   0x01-0x7F  -> RLE: value fill-byte/mask pairs, then literals for uncovered bits
//   0x80-0xFF  -> pattern expansion (4 planes x 8 bytes) + nibble->planar spread
// USAGE: node decompress_tiles.js <romOffsetHex>

const fs = require('fs');
const rom = fs.readFileSync('game.rom');

// lookup tables $6D1C, $6D3C, $6D5C, $6D7C (16 words each)
const tables = [];
for (let t = 0; t < 4; t++) {
  const off = 0x6D1C + t * 0x20;
  const w = [];
  for (let i = 0; i < 16; i++) w.push((rom[off + i * 2] << 8) | rom[off + i * 2 + 1]);
  tables.push(w);
}

function swap16(v) { return ((v & 0xff) << 8) | (v >> 8); }

function decompress(rom, srcOff) {
  const out = [];
  let A1 = 0;
  for (let tile = 0; tile < 32; tile++) {
    const ctrl = rom[srcOff++];
    if (ctrl === 0) {
      for (let i = 0; i < 32; i++) out[A1 + i] = rom[srcOff++];
      A1 += 32;
    } else if (ctrl & 0x80) {
      // pattern expansion path
      const pattern = new Uint8Array(32);
      let D0 = ctrl;
      let D1 = rom[srcOff++];
      for (let pass = 0; pass < 4; pass++) {
        let A3 = pass * 8;
        let bit = D1 & 1; D1 = D1 >> 1;
        let b1 = D1 & 1; D1 = D1 >> 1;
        if (b1 === 0) {
          const D3 = rom[srcOff++];
          let d3 = D3;
          for (let k = 0; k < 8; k++) {
            let D5 = bit;
            if (d3 & 1) D5 = rom[srcOff++];
            pattern[A3 + k] = D5;
            d3 = d3 >> 1;
          }
        } else {
          for (let k = 0; k < 8; k++) pattern[A3 + k] = bit;
        }
        if (D0 & 1) {
          // XOR pass over the 8 bytes just written
          for (let k = 7; k > 0; k--) pattern[A3 + k] ^= pattern[A3 + k - 1];
        }
        D0 = D0 >> 1;
      }
      // nibble -> planar spread
      for (let i = 0; i < 8; i++) {
        let D1 = 0;
        for (let t = 0; t < 4; t++) {
          const byte = pattern[t * 8 + i];
          let D2 = byte;
          let D3 = (D2 >> 3) & 0x1e;
          D1 = (D1 | (t === 0 ? tables[0][D3] : t === 1 ? tables[1][D3] : t === 2 ? tables[2][D3] : tables[3][D3]));
          D1 = swap16(D1);
          D2 = D2 & 0xf;
          const v = t === 0 ? tables[0][D2 * 2] : t === 1 ? tables[1][D2 * 2] : t === 2 ? tables[2][D2 * 2] : tables[3][D2 * 2];
          D1 = (D1 | v);
          D1 = swap16(D1);
        }
        const b = [(D1 >>> 24) & 0xff, (D1 >>> 16) & 0xff, (D1 >>> 8) & 0xff, D1 & 0xff];
        for (let k = 0; k < 4; k++) out[A1 + k] = b[k];
        A1 += 4;
      }
    } else {
      // RLE/bitmask path
      let runs = ctrl; // dbf D0 runs ctrl times (D0 = ctrl-1)
      let OR = 0;
      for (let r = 0; r < runs; r++) {
        const D1 = rom[srcOff++];
        const mask = (rom[srcOff] << 24) | (rom[srcOff + 1] << 16) | (rom[srcOff + 2] << 8) | rom[srcOff + 3];
        srcOff += 4;
        OR |= mask;
        let A2 = A1;
        let m = mask;
        while (m !== 0) {
          if (m & 0x80000000) out[A2] = D1;
          A2++;
          m = m << 1;
        }
      }
      let comp = ~OR;
      let A2 = A1;
      while (comp !== 0) {
        if (comp & 0x80000000) out[A2] = rom[srcOff++];
        A2++;
        comp = comp << 1;
      }
      A1 += 32;
    }
  }
  return { data: out, next: srcOff };
}

// ---- render decompressed tiles ----
function renderTilePNG(tiles, path) {
  const n = tiles.length / 32;
  const TILES_PER_ROW = 32;
  const W = 32 * 8, H = Math.ceil(n / TILES_PER_ROW) * 8;
  // grayscale placeholder palette
  const plte = [];
  for (let i = 0; i < 16; i++) { const v = Math.round(i * 255 / 15); plte.push([v, v, v]); }
  const pixels = new Uint8Array(W * H);
  for (let t = 0; t < n; t++) {
    for (let y = 0; y < 8; y++) {
      for (let p = 0; p < 4; p++) {
        const byte = tiles[t * 32 + y * 4 + p];
        for (let x = 0; x < 8; x++) {
          const bit = (byte >> (7 - x)) & 1;
          if (bit) {
            const px = (Math.floor(t / 32) * 8 + y) * W + (t % 32) * 8 + x;
            pixels[px] |= 1 << p;
          }
        }
      }
    }
  }
  // PNG write
  const zlib = require('zlib');
  const crcT = [];
  for (let n2 = 0; n2 < 256; n2++) { let c = n2; for (let k = 0; k < 8; k++) c = c & 1 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1; crcT[n2] = c; }
  const crc32 = (b) => { let c = 0xFFFFFFFF; for (let i = 0; i < b.length; i++) c = crcT[(c ^ b[i]) & 0xFF] ^ (c >>> 8); return (c ^ 0xFFFFFFFF) >>> 0; };
  const chunk = (type, data) => { const len = Buffer.alloc(4); len.writeUInt32BE(data.length); const td = Buffer.concat([Buffer.from(type, 'ascii'), data]); const crc = Buffer.alloc(4); crc.writeUInt32BE(crc32(td)); return Buffer.concat([len, td, crc]); };
  const ihdr = Buffer.alloc(13); ihdr.writeUInt32BE(W, 0); ihdr.writeUInt32BE(H, 4); ihdr[8] = 8; ihdr[9] = 3;
  const plteB = Buffer.alloc(48); plte.forEach(([r, g, b], i) => { plteB[i * 3] = r; plteB[i * 3 + 1] = g; plteB[i * 3 + 2] = b; });
  const raw = Buffer.alloc((W + 1) * H);
  for (let y = 0; y < H; y++) { raw[y * (W + 1)] = 0; for (let x = 0; x < W; x++) raw[y * (W + 1) + 1 + x] = pixels[y * W + x]; }
  const idat = zlib.deflateSync(raw);
  fs.writeFileSync(path, Buffer.concat([Buffer.from([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]), chunk('IHDR', ihdr), chunk('PLTE', plteB), chunk('IDAT', idat), chunk('IEND', Buffer.alloc(0))]));
}

function main() {
  const addr = parseInt(process.argv[2] || '437ef', 16);
  const res = decompress(rom, addr);
  console.log('decompressed', res.data.length, 'bytes,', res.data.length / 32, 'tiles, next offset:', res.next.toString(16));
  renderTilePNG(res.data, `/tmp/wb_decomp_${addr.toString(16)}.png`);
  console.log('wrote /tmp/wb_decomp_' + addr.toString(16) + '.png');
  // sanity: distinct tiles
  const seen = new Set();
  for (let t = 0; t < res.data.length / 32; t++) {
    seen.add(Buffer.from(res.data.slice(t * 32, t * 32 + 32)).toString('hex'));
  }
  console.log('distinct tiles:', seen.size);
}

main();
