@echo off
setlocal

pushd "%~dp0"

set "PROMPT=Continue executing todos.json and mark progress as you go."
set "PROMPT=%PROMPT% If everything in todos.json is done, continue working on the assembly in the most productive way while preserving a bit-perfect rebuild, keeping todos.json updated, and choosing the next maturity-improving step yourself."
set "PROMPT=%PROMPT% After every non-trivial change or completed task, run cmd /c verify.bat plus the repo checks in todos.json, and fix the cause of any failure instead of reverting unrelated work."
set "PROMPT=%PROMPT% Prioritize visible progress on the large still-opaque mid and late ROM regions, but do not treat the current bank/blob file names, address-stamped module names, or temporary slice boundaries as sacred. Replace them when better ownership and structure are proven."
set "PROMPT=%PROMPT% Use ROM-order splits as a means, not the end state: once code, data families, or subsystem ownership are proven, rename and reorganize temporary bank-local files into intentional modules like gameplay, items, strings, script, mapdata, gfxdata, sound, save/state, or other real subsystem owners while preserving byte identity."
set "PROMPT=%PROMPT% Use a final-form maintained disassembly standard: prefer stable subsystem modules, file headers, documented table formats, and human-meaningful filenames over proliferating bank-local address fragments, and keep ROM-order wrapper files thin once better ownership is proven."
set "PROMPT=%PROMPT% Continuously establish what each opaque range actually is. Maintain and improve a whole-ROM ownership inventory that classifies remaining blocks as code, levels/maps, room or tilemap data, compressed graphics, palette or render metadata, text/dialogue, script/event data, sound/Z80 resources, pointer or descriptor tables, or fill/padding, with conservative evidence and confidence notes."
set "PROMPT=%PROMPT% When a file named like bank080000_mid_front.asm or bank040000_payload_mid.asm becomes understandable, rename or absorb it into a semantic owner immediately: mapdata, gfxdata, strings, script, sound, items, gameplay, states, shop/inn data, credits, or another proven subsystem/asset family."
set "PROMPT=%PROMPT% Do not create new address-stamped, direction-stamped, or blob-like ASM fragments unless no better owner is yet defensible. If a temporary ROM-order slice is unavoidable, record the intended future owner, likely content type, and evidence still needed to rename it."
set "PROMPT=%PROMPT% The target quality is a mature maintained disassembly: source files should read like maintained modules with file headers, section structure, stable labels, function-purpose comments where useful, documented table formats, and clear explanations for ROM-layout artifacts such as cross-file continuations or misplaced data islands."
set "PROMPT=%PROMPT% Do not stop at merely proving that bytes are text-like or table-like. Prefer source-authored routines, jump tables, pointer tables, string/name tables, script/dialogue regions, menu/state dispatchers, save structures, compressed block loaders, graphics metadata, and other structured formats whenever the ROM bytes and control flow support a conservative split."
set "PROMPT=%PROMPT% When semantics are proven, replace raw magic numbers, raw RAM or I/O addresses, repeated VDP patterns, and raw struct offsets with shared constants or macros in game_constants.asm, hw_constants.asm, sound_constants.asm, ram_addresses.asm, or macros.asm instead of leaving unexplained immediates in place."
set "PROMPT=%PROMPT% Prefer terminology proven by actual ROM bytes, control flow, table structure, and repeated behavior. Use Wonder Boy in Monster World domain knowledge from guides and text dumps as supporting evidence, but keep uncertain names structural or system-level rather than forcing story/location-specific guesses. Also, once names stop being the best available temporary fit, replace them with better subsystem or domain names instead of preserving legacy placeholders for continuity's sake."
set "PROMPT=%PROMPT% Separate confirmed in-ROM terminology, behavior-based inference, and secondary-source aliases. Record aliases, uncertainty, and stronger future rename candidates in docs or worklogs instead of baking weak guesses into symbol names."
set "PROMPT=%PROMPT% Name and organize things the way a human maintainer would want to edit them later: shop and inn flows, inventory and magic menus, quiz question banks, ocarina melodies, signpost/dialogue banks, item and equipment names, spell tables, pointer lists, dispatch tables, task/state records, save/load structures, and loader-owned asset families are better targets than vague blob names."
set "PROMPT=%PROMPT% Treat levels/maps and graphics as first-class classification goals: identify which blobs are overworld/town/dungeon layouts, object placement, compressed art, sprite sets, UI tiles, palettes, animation descriptors, or loader metadata, and move them toward those owners instead of leaving them as anonymous bank slices."
set "PROMPT=%PROMPT% When a module becomes understandable, improve readability inside the source itself: add concise file-level context, document entry points and calling conventions when non-obvious, annotate table entry layouts, and explain why physically misplaced code or data must remain where it is in ROM order."
set "PROMPT=%PROMPT% Keep source splits in ROM order. Reserve data/ for still-opaque blobs and src/ for source-authored assembly. Prefer stable labels, explicit table boundaries, typed record families, readable string ownership, and comments that preserve reverse-engineering evidence without cluttering obvious instructions."
set "PROMPT=%PROMPT% Treat coarse extracted .bin files as a failure mode, not an acceptable endpoint. If a blob contains significant 68k code or significant annotateable structured data such as price tables, pointer tables, string/name tables, script records, or other maintainable formats, convert it into source-authored .asm promptly instead of leaving the discovery trapped in comments, notes, or external tools."
set "PROMPT=%PROMPT% Use wonderboy.lst and direct byte comparison against original/wonderboy.bin whenever needed to keep new source-authored code/data byte-perfect. When the assembler's preferred syntax would change bytes, preserve the original encoding explicitly and document why."
set "PROMPT=%PROMPT% When new evidence is found, update the most relevant notes in docs/research_log.md, docs/open_questions.md, worklogs, and todos.json so future passes inherit the reasoning instead of repeating the same analysis."
set "PROMPT=%PROMPT% Every iteration should leave the repo closer to a full mature disassembly: fewer anonymous blobs, fewer placeholder labels, fewer bad address-derived filenames, more subsystem-level ownership, better constants and macros, clearer documentation, and a still bit-perfect rebuild."

:loop
echo.
echo ==================================================
echo Autopilot iteration started at %date% %time%
echo ==================================================
call opencode run --dir "%CD%" "%PROMPT%"
echo Autopilot iteration finished with exit code %errorlevel%
timeout /t 2 /nobreak >nul
goto loop
