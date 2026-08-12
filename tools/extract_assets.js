#!/usr/bin/env node
// extract_assets.js — extract editable assets from game.rom into assets/.
//   assets/tiles.png     — the 20 tile blocks (760 tiles, 4bpp planar)
//   assets/palettes.json — the 252 packed palettes (display-layout words)
// Extraction is lossless: regen_assets.js re-encodes these back to the exact
// ROM bytes (round-trip verified bit-perfect).
//
// USAGE: node tools/extract_assets.js

const fs = require('fs');
const path = require('path');
const DIR = path.resolve(__dirname, '..');
const rom = fs.readFileSync(path.join(DIR, 'game.rom'));
const assetsDir = path.join(DIR, 'assets');
fs.mkdirSync(assetsDir, { recursive: true });

// ---- tile blocks (tag $01 records in flagged table at $041000) ----
const blocks = [];
for (let off = 0x41000; off < 0x41B40; off += 4) {
  const tag = rom[off];
  const addr = (rom[off + 1] << 16) | (rom[off + 2] << 8) | rom[off + 3];
  if (tag === 1) blocks.push(addr);
}
blocks.sort((a, b) => a - b);
const unique = [...new Set(blocks)];
fs.writeFileSync(path.join(assetsDir, 'tile_blocks.json'),
  JSON.stringify({ addresses: unique.map(a => '0x' + a.toString(16)) }, null, 1));

// write tiles.png (indexed 8-bit, 38 tiles per row, one row per block)
// reuse the extractor's PNG writer by requiring it with a stub main
const extSrc = fs.readFileSync(path.join(DIR, 'tools/extract_tiles.js'), 'utf8')
  .replace(/main\(\);[\s\S]*$/, '');
eval(extSrc);
// extract_tiles.js main reads game.rom relative to cwd; re-run its logic inline
{
  const TILES_PER_ROW = 38;
  const W = TILES_PER_ROW * 8;
  const H = unique.length * 8;
  const pixels = new Uint8Array(W * H);
  const plte = [];
  for (let i = 0; i < 16; i++) { const v = Math.round(i * 255 / 15); plte.push([v, v, v]); }
  unique.forEach((b, bi) => {
    for (let t = 0; t < 38; t++) {
      const px = decodeTile(rom, b + t * 32);
      for (let y = 0; y < 8; y++) {
        const dst = (bi * 8 + y) * W + t * 8;
        for (let x = 0; x < 8; x++) pixels[dst + x] = px[y * 8 + x];
      }
    }
  });
  writeIndexedPNG(path.join(assetsDir, 'tiles.png'), W, H, pixels, plte);
}

// ---- palettes ----
const palettes = [];
for (let i = 0; i < 252; i++) {
  const base = 0x599C + i * 17;
  const field = (rom[base] << 8) | rom[base + 1];
  const colors = [0x0000];
  for (let c = 0; c < 15; c++) {
    const byte = rom[base + 2 + c];
    const r = (byte & 7) << 1;
    const g = (byte & 0x38) << 2;
    const b = ((byte & 0xC0) << 3) | ((field >> c) & 1 ? 0x800 : 0);
    colors.push(r | g | b);
  }
  palettes.push({
    index: i,
    field: [rom[base], rom[base + 1]], // raw bytes; bit 15 of byte0 is unused by colors — preserved for bit-exact rebuild
    colors: colors.map(w => w.toString(16).toUpperCase().padStart(4, '0'))
  });
}
fs.writeFileSync(path.join(assetsDir, 'palettes.json'), JSON.stringify(palettes, null, 1));

console.log('extracted assets: tiles.png (' + unique.length + ' blocks), palettes.json (' + palettes.length + ' palettes), tile_blocks.json');
