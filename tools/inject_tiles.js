#!/usr/bin/env node
// inject_tiles.js — write a modified PNG tileset back into the ROM's tile blocks.
//
// Inverse of tools/extract_tiles.js. The PNG must be laid out exactly as the
// extractor produces it: one row of 38 tiles per block, 20 blocks stacked
// (8px tiles). Each tile is 4bpp planar (16 colors, 32 bytes). Tile blocks are
// at fixed ROM addresses (tag=$01 records of the flagged table at $041000), so
// injection is a same-size overwrite — no pointers or alignment change.
//
// USAGE:
//   node tools/inject_tiles.js <tileset.png> <rom_out.bin>
//   --verify   also compare the produced tileset against the original ROM bytes
//
// Requires a palette embedded in the PNG (indexed PNG, 16 colors max).

const fs = require('fs');
const zlib = require('zlib');

function parsePNG(path) {
  const b = fs.readFileSync(path);
  let off = 8, w = 0, h = 0, bitDepth = 0, colorType = 0, idat = [], plte = null;
  while (off < b.length) {
    const len = b.readUInt32BE(off);
    const type = b.toString('ascii', off + 4, off + 8);
    const data = b.slice(off + 8, off + 8 + len);
    if (type === 'IHDR') { w = data.readUInt32BE(0); h = data.readUInt32BE(4); bitDepth = data[8]; colorType = data[9]; }
    else if (type === 'IDAT') idat.push(data);
    else if (type === 'PLTE') plte = data;
    off += 12 + len;
  }
  if (!plte) { throw new Error('PNG must be indexed (palette)'); }
  const rawpx = zlib.inflateSync(Buffer.concat(idat));
  const bpp = colorType === 3 ? 1 : colorType === 2 ? 3 : colorType === 6 ? 4 : 1;
  const stride = w * bpp;
  const out = Buffer.alloc(stride * h);
  let prev = Buffer.alloc(stride);
  for (let y = 0; y < h; y++) {
    const f = rawpx[y * (stride + 1)];
    const row = rawpx.slice(y * (stride + 1) + 1, (y + 1) * (stride + 1));
    const cur = out.slice(y * stride, (y + 1) * stride);
    for (let x = 0; x < stride; x++) {
      const a = x >= bpp ? cur[x - bpp] : 0, bv = prev[x], c = x >= bpp ? prev[x - bpp] : 0;
      let v = row[x];
      if (f === 1) v = (v + a) & 0xff;
      else if (f === 2) v = (v + bv) & 0xff;
      else if (f === 3) v = (v + ((a + bv) >> 1)) & 0xff;
      else if (f === 4) { const p = a + bv - c; const pa = Math.abs(p - a), pb = Math.abs(p - bv), pc = Math.abs(p - c); v = (v + (pa <= pb && pa <= pc ? a : pb <= pc ? bv : c)) & 0xff; }
      cur[x] = v;
    }
    prev = cur;
  }
  return { w, h, bpp, pix: out, plte: plte.length / 3 };
}

function encodeTile(indices) {
  // 4bpp planar: for each row, 4 planes x 1 byte (MSB first)
  const out = Buffer.alloc(32);
  for (let y = 0; y < 8; y++) {
    for (let p = 0; p < 4; p++) {
      let byte = 0;
      for (let x = 0; x < 8; x++) {
        const idx = indices[y * 8 + x];
        if (idx > 15) { throw new Error('tile pixel index > 15'); }
        if (idx & (1 << p)) byte |= 1 << (7 - x);
      }
      out[y * 4 + p] = byte;
    }
  }
  return out;
}

function main() {
  const pngPath = process.argv[2];
  const outPath = process.argv[3];
  const verify = process.argv.includes('--verify');
  const img = parsePNG(pngPath);
  const rom = fs.readFileSync('game.rom');

  // tile block addresses (same source as extractor)
  let blocks = [];
  for (let off = 0x41000; off < 0x41B40; off += 4) {
    const tag = rom[off];
    const addr = (rom[off + 1] << 16) | (rom[off + 2] << 8) | rom[off + 3];
    if (tag === 1) blocks.push(addr);
  }
  blocks.sort((a, b) => a - b);
  blocks = [...new Set(blocks)];
  const TILE_STRIDE = 38;
  const TILE_BYTES = 32;
  const expectedW = TILE_STRIDE * 8;
  const expectedH = blocks.length * 8;
  if (img.w !== expectedW || img.h !== expectedH) {
    throw new Error(`PNG size ${img.w}x${img.h} != expected ${expectedW}x${expectedH}`);
  }

  const out = Buffer.from(rom);
  let changed = 0;
  blocks.forEach((addr, bi) => {
    for (let t = 0; t < TILE_STRIDE; t++) {
      const indices = new Array(64);
      for (let y = 0; y < 8; y++) {
        for (let x = 0; x < 8; x++) {
          indices[y * 8 + x] = img.pix[(bi * 8 + y) * img.w + t * 8 + x];
        }
      }
      const tile = encodeTile(indices);
      const roff = addr + t * TILE_BYTES;
      for (let i = 0; i < TILE_BYTES; i++) {
        if (out[roff + i] !== tile[i]) { out[roff + i] = tile[i]; changed++; }
      }
    }
  });
  fs.writeFileSync(outPath, out);
  console.log('wrote', outPath, '| bytes changed:', changed);

  if (verify) {
    // verify: original tiles -> PNG -> back should be identical
    const verifyPng = fs.readFileSync(pngPath);
    // compare the injected bytes against the ORIGINAL rom bytes for the tile blocks
    let mismatches = 0;
    blocks.forEach((addr) => {
      for (let i = 0; i < TILE_STRIDE * TILE_BYTES; i++) {
        if (rom[addr + i] !== out[addr + i]) mismatches++;
      }
    });
    console.log('verify: bytes differing from original ROM:', mismatches);
  }
}

main();
