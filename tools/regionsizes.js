#!/usr/bin/env node
// regionsizes.js — compare emitted region sizes vs ROM for each regions.json entry.
const fs = require('fs');
const rom = fs.readFileSync(process.argv[2]);
const out = fs.readFileSync('out.bin');
const regions = JSON.parse(fs.readFileSync('tools/regions.json', 'utf8'));
// out.bin layout: header ($0-$200) + data_rest ($200..). data_rest emits each
// region's module bytes at its ROM offset and gaps as identical raw bytes, so a
// region's offset in out = its ROM offset + the cumulative delta of all prior
// regions. Walk rom/out in parallel and anchor on the gap bytes that follow each
// region (gaps are byte-identical) to recover each module's emitted length.
let total = 0;
let romCursor = 0x200;
let outCursor = 0x200;
const items = regions.map(r => ({
  file: r.file, start: parseInt(r.start, 16), end: parseInt(r.end, 16)
})).sort((a, b) => a.start - b.start);
for (let i = 0; i < items.length; i++) {
  const r = items[i];
  if (r.start < romCursor) {
    console.log(`${r.file}: out of order / overlaps previous region`);
    process.exit(1);
  }
  const gap = r.start - romCursor;
  romCursor += gap;
  outCursor += gap;
  const romLen = r.end - r.start;
  const nextStart = items[i + 1] ? items[i + 1].start : rom.length;
  const gapAfter = nextStart - r.end;
  let outLen;
  if (gapAfter > 0) {
    const anchor = rom.subarray(r.end, nextStart);
    outLen = 0;
    while (outCursor + outLen + gapAfter <= out.length &&
           !out.subarray(outCursor + outLen, outCursor + outLen + gapAfter).equals(anchor)) {
      outLen++;
    }
  } else {
    outLen = romLen; // no anchor gap; assume correct (deltas roll into next)
  }
  const delta = outLen - romLen;
  total += delta;
  if (delta !== 0)
    console.log(`${r.file} ${r.start}-${r.end}: rom=${romLen} out=${outLen} delta=${delta}`);
  romCursor += romLen;
  outCursor += outLen;
}
console.log('total delta over all regions:', total, 'rom', rom.length, 'out', out.length);
