#!/usr/bin/env node
// extract_tiles.js — extract the game's 4bpp planar tile graphics to a PNG tileset.
//
// The tile blocks are the tag=$01 records of the flagged ROM-reference table at
// $041000: [tag byte][24-bit address]. Each block is 0x4C0 bytes = 38 tiles of
// 32 bytes each (4 bitplanes x 8 bytes, Genesis 4bpp planar).
//
// USAGE:
//   node tools/extract_tiles.js <out.png> [palette.json]
//   node tools/extract_tiles.js --manifest        # just list the tile blocks
//
// palette.json format (optional):
//   { "layout": "genesis"|"0eee", "colors": ["#RRGGBB", ...] }  (16 entries)
//   Defaults to a grayscale index palette so tile shapes are visible.

const fs = require('fs');
const zlib = require('zlib');

// ---- PNG writer (indexed 8-bit, so palette is embedded) ----
function crcTable() {
  const t = new Int32Array(256);
  for (let n = 0; n < 256; n++) {
    let c = n;
    for (let k = 0; k < 8; k++) c = c & 1 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1;
    t[n] = c;
  }
  return t;
}
const CRC = crcTable();
function crc32(buf) {
  let c = 0xFFFFFFFF;
  for (let i = 0; i < buf.length; i++) c = CRC[(c ^ buf[i]) & 0xFF] ^ (c >>> 8);
  return (c ^ 0xFFFFFFFF) >>> 0;
}
function chunk(type, data) {
  const len = Buffer.alloc(4); len.writeUInt32BE(data.length);
  const td = Buffer.concat([Buffer.from(type, 'ascii'), data]);
  const crc = Buffer.alloc(4); crc.writeUInt32BE(crc32(td));
  return Buffer.concat([len, td, crc]);
}
function writeIndexedPNG(path, w, h, pixels /* Uint8Array index per pixel */, plte /* array of [r,g,b] */) {
  const sig = Buffer.from([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]);
  const ihdr = Buffer.alloc(13);
  ihdr.writeUInt32BE(w, 0); ihdr.writeUInt32BE(h, 4);
  ihdr[8] = 8; ihdr[9] = 3; // 8-bit, indexed
  const plteB = Buffer.alloc(plte.length * 3);
  plte.forEach(([r, g, b], i) => { plteB[i * 3] = r; plteB[i * 3 + 1] = g; plteB[i * 3 + 2] = b; });
  const stride = w;
  const raw = Buffer.alloc((stride + 1) * h);
  for (let y = 0; y < h; y++) {
    raw[y * (stride + 1)] = 0; // filter none
    for (let x = 0; x < w; x++) raw[y * (stride + 1) + 1 + x] = pixels[y * stride + x];
  }
  const idat = zlib.deflateSync(raw);
  const png = Buffer.concat([sig, chunk('IHDR', ihdr), chunk('PLTE', plteB), chunk('IDAT', idat), chunk('IEND', Buffer.alloc(0))]);
  fs.writeFileSync(path, png);
}

// ---- find tile blocks via the flagged table at $041000 ----
function findTileBlocks(rom) {
  const blocks = [];
  for (let off = 0x41000; off < 0x41B40; off += 4) {
    const tag = rom[off];
    const addr = (rom[off + 1] << 16) | (rom[off + 2] << 8) | rom[off + 3];
    if (tag === 0 || tag === 0xFF || addr === 0) continue;
    if (tag === 1) blocks.push({ addr, name: 'tiles_' + addr.toString(16).toUpperCase() });
  }
  // sort by address, dedupe
  blocks.sort((a, b) => a.addr - b.addr);
  return blocks.filter((b, i) => i === 0 || b.addr !== blocks[i - 1].addr);
}

function decodeTile(rom, off) {
  // 4bpp planar: planes 0-3, each 8 bytes; plane byte for pixel row y at y*4+plane
  const px = new Uint8Array(64);
  for (let y = 0; y < 8; y++) {
    for (let p = 0; p < 4; p++) {
      const byte = rom[off + y * 4 + p];
      for (let x = 0; x < 8; x++) {
        const bit = (byte >> (7 - x)) & 1;
        if (bit) px[y * 8 + x] |= 1 << p;
      }
    }
  }
  return px;
}

function main() {
  const rom = fs.readFileSync('game.rom');
  const blocks = findTileBlocks(rom);
  if (process.argv.includes('--manifest')) {
    console.log('tile blocks (tag=$01 from flagged table at $041000):');
    for (const b of blocks) console.log('  $' + b.addr.toString(16) + '  ' + b.name);
    console.log('total tiles:', blocks.reduce((a, b) => a + 38, 0));
    return;
  }

  const outPng = process.argv[2] || '/tmp/wb_tiles.png';
  const palArg = process.argv[3];
  // build palette
  let plte;
  if (palArg) {
    const pj = JSON.parse(fs.readFileSync(palArg, 'utf8'));
    if (!pj.colors || pj.colors.length < 16) { console.error('palette needs >=16 colors'); process.exit(1); }
    plte = pj.colors.slice(0, 16).map(c => {
      const m = /^#?([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i.exec(c.trim());
      if (!m) { console.error('bad color ' + c); process.exit(1); }
      return [parseInt(m[1], 16), parseInt(m[2], 16), parseInt(m[3], 16)];
    });
  } else {
    // grayscale placeholder so tile shapes are visible
    plte = [];
    for (let i = 0; i < 16; i++) { const v = Math.round(i * 255 / 15); plte.push([v, v, v]); }
  }

  // arrange: each block as a row of 38 tiles, blocks stacked. 8px tiles.
  const TILES_PER_ROW = 38;
  const W = TILES_PER_ROW * 8;
  const H = blocks.length * 8;
  const pixels = new Uint8Array(W * H);
  blocks.forEach((b, bi) => {
    for (let t = 0; t < 38; t++) {
      const px = decodeTile(rom, b.addr + t * 32);
      for (let y = 0; y < 8; y++) {
        const dst = (bi * 8 + y) * W + t * 8;
        for (let x = 0; x < 8; x++) pixels[dst + x] = px[y * 8 + x];
      }
    }
  });
  writeIndexedPNG(outPng, W, H, pixels, plte);
  console.log('wrote', outPng, W + 'x' + H, '|', blocks.length, 'tile blocks');
}

main();
