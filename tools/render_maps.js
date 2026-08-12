#!/usr/bin/env node
// render_maps.js — render the extracted 32x32 tilemaps as colored PNGs.
//
// Each map value indexes into the scene's VRAM tileset (0-255). We render
// with the raw tile blocks as the tileset (map value N -> Nth tile of the
// concatenated tag-$01 blocks) and a chosen decoded palette.
//
// USAGE: node tools/render_maps.js [paletteIndex] [outDir] [firstN]
const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const DIR = path.resolve(__dirname, '..');
const rom = fs.readFileSync(path.join(DIR, 'game.rom'));

const palIdx = parseInt(process.argv[2] || '0', 10);
const outDir = process.argv[3] || path.join(DIR, 'maps', 'png');
const firstN = parseInt(process.argv[4] || '99999', 10);
fs.mkdirSync(outDir, { recursive: true });

// decode palette
function decodePalette(idx) {
  const base = 0x599C + idx * 17;
  const field = (rom[base] << 8) | rom[base + 1];
  const colors = [0x0000];
  for (let c = 0; c < 15; c++) {
    const byte = rom[base + 2 + c];
    colors.push(((byte & 7) << 1) | ((byte & 0x38) << 2) | ((byte & 0xC0) << 3) | ((field >> c) & 1 ? 0x800 : 0));
  }
  return colors;
}
function toRGB(w) {
  const r = (w >> 1) & 7, g = (w >> 5) & 7, b = (w >> 9) & 7;
  return [Math.round(r * 255 / 7), Math.round(g * 255 / 7), Math.round(b * 255 / 7)];
}
const pal = decodePalette(palIdx);

// build full tileset from tag-$01 blocks
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

// PNG writer (RGB)
const crcT = [];
for (let n = 0; n < 256; n++) { let c = n; for (let k = 0; k < 8; k++) c = c & 1 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1; crcT[n] = c; }
const crc = (b) => { let c = 0xFFFFFFFF; for (let i = 0; i < b.length; i++) c = crcT[(c ^ b[i]) & 0xFF] ^ (c >>> 8); return (c ^ 0xFFFFFFFF) >>> 0; };
const chunk = (type, data) => { const len = Buffer.alloc(4); len.writeUInt32BE(data.length); const td = Buffer.concat([Buffer.from(type, 'ascii'), data]); const cc = Buffer.alloc(4); cc.writeUInt32BE(crc(td)); return Buffer.concat([len, td, cc]); };
function writePNG(p, w, h, rgb) {
  const ihdr = Buffer.alloc(13); ihdr.writeUInt32BE(w, 0); ihdr.writeUInt32BE(h, 4); ihdr[8] = 8; ihdr[9] = 2;
  const raw = Buffer.alloc((w * 3 + 1) * h);
  for (let y = 0; y < h; y++) { raw[y * (w * 3 + 1)] = 0; rgb.copy(raw, y * (w * 3 + 1) + 1, y * w * 3, (y + 1) * w * 3); }
  fs.writeFileSync(p, Buffer.concat([Buffer.from([0x89,0x50,0x4E,0x47,0x0D,0x0A,0x1A,0x0A]), chunk('IHDR', ihdr), chunk('IDAT', zlib.deflateSync(raw)), chunk('IEND', Buffer.alloc(0))]));
}

// render each map
const mapsDir = path.join(DIR, 'maps');
const files = fs.readdirSync(mapsDir).filter(f => f.endsWith('.bin')).sort();
let count = 0;
for (const f of files.slice(0, firstN)) {
  const map = fs.readFileSync(path.join(mapsDir, f));
  const W = 32 * 8, H = 32 * 8;
  const rgb = Buffer.alloc(W * H * 3);
  for (let y = 0; y < 32; y++) for (let x = 0; x < 32; x++) {
    const idx = map[y * 32 + x];
    const px = tilePx(tiles[idx % tiles.length] || Buffer.alloc(32));
    for (let ty = 0; ty < 8; ty++) for (let tx = 0; tx < 8; tx++) {
      const v = px[ty * 8 + tx];
      const [r, g, b] = toRGB(pal[v] || 0);
      const o = ((y * 8 + ty) * W + x * 8 + tx) * 3;
      rgb[o] = r; rgb[o + 1] = g; rgb[o + 2] = b;
    }
  }
  writePNG(path.join(outDir, f.replace('.bin', '.png')), W, H, rgb);
  count++;
}
console.log('rendered', count, 'maps to', outDir, 'with palette', palIdx);
