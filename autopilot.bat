@echo off
setlocal

pushd "%~dp0"

set "PROMPT=Continue executing todos.json and mark progress as you go."
set "PROMPT=%PROMPT% If everything in todos.json is done, continue working on the assembly in the most productive way while preserving a bit-perfect rebuild, keeping todos.json updated, and choosing the next maturity-improving step yourself."
set "PROMPT=%PROMPT% After every non-trivial change or completed task, run cmd /c verify.bat plus the repo checks in todos.json, and fix the cause of any failure instead of reverting unrelated work."
set "PROMPT=%PROMPT% Prioritize visible progress on the large still-opaque mid and late ROM regions, but do not treat the current bank/blob file names, address-stamped module names, or temporary slice boundaries as sacred. Replace them when better ownership and structure are proven."
set "PROMPT=%PROMPT% Use ROM-order splits as a means, not the end state: once code, data families, or subsystem ownership are proven, rename and reorganize temporary bank-local files into intentional modules like gameplay, items, strings, script, mapdata, gfxdata, sound, save/state, or other real subsystem owners while preserving byte identity."
set "PROMPT=%PROMPT% The target quality is the mature sibling-project standard: source files should read like maintained disassembly modules with file headers, section structure, stable labels, function-purpose comments where useful, documented table formats, and clear explanations for ROM-layout artifacts such as cross-file continuations or misplaced data islands."
set "PROMPT=%PROMPT% Do not stop at merely proving that bytes are text-like or table-like. Prefer source-authored routines, jump tables, pointer tables, string/name tables, script/dialogue regions, menu/state dispatchers, save structures, compressed block loaders, graphics metadata, and other structured formats whenever the ROM bytes and control flow support a conservative split."
set "PROMPT=%PROMPT% When semantics are proven, replace raw magic numbers, raw RAM or I/O addresses, repeated VDP patterns, and raw struct offsets with shared constants or macros in game_constants.asm, hw_constants.asm, sound_constants.asm, ram_addresses.asm, or macros.asm instead of leaving unexplained immediates in place."
set "PROMPT=%PROMPT% Prefer terminology proven by actual ROM bytes, control flow, table structure, and repeated behavior. Use Wonder Boy in Monster World domain knowledge from guides and text dumps as supporting evidence, but keep uncertain names structural or system-level rather than forcing story/location-specific guesses. Also, once names stop being the best available temporary fit, replace them with better subsystem or domain names instead of preserving legacy placeholders for continuity's sake."
set "PROMPT=%PROMPT% Separate confirmed in-ROM terminology, behavior-based inference, and secondary-source aliases. Record aliases, uncertainty, and stronger future rename candidates in docs or worklogs instead of baking weak guesses into symbol names."
set "PROMPT=%PROMPT% Name and organize things the way a human maintainer would want to edit them later: shop and inn flows, inventory and magic menus, quiz question banks, ocarina melodies, signpost/dialogue banks, item and equipment names, spell tables, pointer lists, dispatch tables, task/state records, save/load structures, and loader-owned asset families are better targets than vague blob names."
set "PROMPT=%PROMPT% When a module becomes understandable, improve readability inside the source itself: add concise file-level context, document entry points and calling conventions when non-obvious, annotate table entry layouts, and explain why physically misplaced code or data must remain where it is in ROM order."
set "PROMPT=%PROMPT% Keep source splits in ROM order. Reserve data/ for still-opaque blobs and src/ for source-authored assembly. Prefer stable labels, explicit table boundaries, typed record families, readable string ownership, and comments that preserve reverse-engineering evidence without cluttering obvious instructions."
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
