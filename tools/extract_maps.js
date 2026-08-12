#!/usr/bin/env node
// extract_maps.js — decode all tag=$02 32x32 tilemaps (tree+LZSS at $6D9C)
// into maps/ as .bin files + render each to a PNG tileset preview.
//
// USAGE: node extract_maps.js [--png] [--all]
const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const DIR = path.resolve(__dirname, '..');
const rom = fs.readFileSync(path.join(DIR, 'game.rom'));
const src = fs.readFileSync(path.join(DIR, 'tools/decompress_tag02.js'), 'utf8');
eval(src.replace(/main\(\);[\s\S]*$/, ''));

const mapsDir = path.join(DIR, 'maps');
fs.mkdirSync(mapsDir, { recursive: true });

// all tag-$02 record addresses
const addrs = [];
for (let off = 0x41000; off < 0x41B40; off += 4) {
  const tag = rom[off];
  const addr = (rom[off + 1] << 16) | (rom[off + 2] << 8) | rom[off + 3];
  if (tag === 2) addrs.push(addr);
}
addrs.sort((a, b) => a - b);
const uniq = [...new Set(addrs)];

const manifest = [];
for (let i = 0; i < uniq.length; i++) {
  const addr = uniq[i];
  const res = decompress(rom, addr);
  const name = 'map_' + addr.toString(16).toUpperCase();
  fs.writeFileSync(path.join(mapsDir, name + '.bin'), res.data);
  manifest.push({ address: '0x' + addr.toString(16), file: name + '.bin', size: res.data.length });
}
fs.writeFileSync(path.join(mapsDir, 'manifest.json'), JSON.stringify(manifest, null, 1));
console.log('wrote', manifest.length, 'maps to maps/');

// PNG rendering: lay out each map's 32x32 tiles with a grayscale palette using
// the raw tile blocks as a tileset (map values index into VRAM tiles).
if (process.argv.includes('--png')) {
  const blocks = [];
  for (let off = 0x41000; off < 0x41B40; off += 4) {
    const tag = rom[off];
    const a = (rom[off + 1] << 16) | (rom[off + 2] << 8) | rom[off + 3];
    if (tag === 1) blocks.push(a);
  }
  blocks.sort((a, b) => a - b);
  const tiles = [];
  for (const b of [...new Set(blocks)]) for (let t = 0; t < 38; t++) tiles.push(rom.slice(b + t * 32, b + t * 32 + 32));
  function tilePx(tile) {
    const px = new Uint8Array(64);
    for (let y = 0; y < 8; y++) for (let p = 0; p < 4; p++) {
      const byte = tile[y * 4 + p];
      for (let x = 0; x < 8; x++) if ((byte >> (7 - x)) & 1) px[y * 8 + x] |= 1 << p;
    }
    return px;
  }
  const crcT = [];
  for (let n = 0; n < 256; n++) { let c = n; for (let k = 0; k < 8; k++) c = c & 1 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1; crcT[n] = c; }
  const crc = (b) => { let c = 0xFFFFFFFF; for (let i = 0; i < b.length; i++) c = crcT[(c ^ b[i]) & 0xFF] ^ (c >>> 8); return (c ^ 0xFFFFFFFF) >>> 0; };
  const chunk = (type, data) => { const len = Buffer.alloc(4); len.writeUInt32BE(data.length); const td = Buffer.concat([Buffer.from(type, 'ascii'), data]); const cc = Buffer.alloc(4); cc.writeUInt32BE(crc(td)); return Buffer.concat([len, td, cc]); };
  function writePNG(p, w, h, pixels, plte) {
    const sig = Buffer.from([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]);
    const ihdr = Buffer.alloc(13); ihdr.writeUInt32BE(w, 0); ihdr.writeUInt32BE(h, 4); ihdr[8] = 8; ihdr[9] = 3;
    const plteB = Buffer.alloc(plte.length * 3);
    plte.forEach(([r, g, b], i) => { plteB[i * 3] = r; plteB[i * 3 + 1] = g; plteB[i * 3 + 2] = b; });
    const raw = Buffer.alloc((w + 1) * h);
    for (let y = 0; y < h; y++) { raw[y * (w + 1)] = 0; for (let x = 0; x < w; x++) raw[y * (w + 1) + 1 + x] = pixels[y * w + x]; }
    fs.writeFileSync(p, Buffer.concat([sig, chunk('IHDR', ihdr), chunk('PLTE', plteB), chunk('IDAT', zlib.deflateSync(raw)), chunk('IEND', Buffer.alloc(0))]));
  }
  const plte = [];
  for (let i = 0; i < 16; i++) { const v = Math.round(i * 255 / 15); plte.push([v, v, v]); }
  const MW = 32 * 8, MH = 32 * 8;
  const pixels = new Uint8Array(MW * MH);
  for (const m of manifest.slice(0, 12)) {
    const map = fs.readFileSync(path.join(mapsDir, m.file));
    pixels.fill(0);
    for (let y = 0; y < 32; y++) for (let x = 0; x < 32; x++) {
      const idx = map[y * 32 + x];
      const tile = tiles[idx % tiles.length] || Buffer.alloc(32);
      const px = tilePx(tile);
      for (let ty = 0; ty < 8; ty++) for (let tx = 0; tx < 8; tx++) pixels[(y * 8 + ty) * MW + x * 8 + tx] = px[ty * 8 + tx];
    }
    writePNG(path.join(mapsDir, m.file.replace('.bin', '.png')), MW, MH, pixels, plte);
  }
  console.log('rendered preview PNGs for first 12 maps');
}
