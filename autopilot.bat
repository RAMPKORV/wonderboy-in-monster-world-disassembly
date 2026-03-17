@echo off
setlocal

pushd "%~dp0"

set "PROMPT=Continue executing todos.json and mark progress as you go."
set "PROMPT=%PROMPT% If everything in todos.json is done, continue working on the assembly in the most productive way while preserving a bit-perfect rebuild and keeping todos.json updated."
set "PROMPT=%PROMPT% Prioritize visible progress on the still-opaque ROM banks left as data/rom/bank_020000_03ffff.bin, data/rom/bank_040000_07ffff.bin, and data/rom/bank_080000_0bffff.bin."
set "PROMPT=%PROMPT% Do not leave a whole bank as one monolithic incbin when it can be split into ROM-order source files, smaller sliced incbins, and named modules included from src/rom_body.asm."
set "PROMPT=%PROMPT% The main goal is not just finding hardcoded strings: make the disassembly human-readable, clean, maintainable, and well-documented in the style of mature bit-perfect projects."
set "PROMPT=%PROMPT% Favor source-authored code, jump tables, pointer tables, string/name tables, script/dialogue regions, menu data, compressed blocks, graphics metadata, and other structured formats whenever the ROM bytes and control flow support a conservative split."
set "PROMPT=%PROMPT% Use Wonder Boy in Monster World domain knowledge from GameFAQs guides and text dumps as evidence and context, but do not overfit labels to a hardcoded checklist of known names."
set "PROMPT=%PROMPT% Prefer terminology proven by actual ROM bytes, control flow, table structure, and repeated behavior. If a higher-level game concept is still uncertain, keep labels functional and system-level instead of forcing a location, boss, shop, or story-specific name."
set "PROMPT=%PROMPT% Separate confirmed in-ROM terminology, behavior-based inference, and secondary-source aliases. Record aliases and uncertainty in docs or worklogs instead of baking weak guesses into symbol names."
set "PROMPT=%PROMPT% Name things by structure and role first: shop text tables, inn/save prompts, quiz question banks, ocarina or melody script blocks, item and equipment name tables, spell tables, pointer lists, dispatch tables, state records, and format loaders are better first targets than vague blob names."
set "PROMPT=%PROMPT% Use recurring domain cues to identify regions: inventory and magic menus, AP/DP/SP or GOLD UI, shop buy/sell flows, inn/save flows, Sphinx quiz text, signposts, Ocarina door melodies, progression gates around items like Trident, Bracelet, Old Axe or Fire-Urn, Gold Gem, Blue Gem, and the Pygmy gear set, plus location and boss script clusters."
set "PROMPT=%PROMPT% Keep source splits in ROM order. Reserve data/ for still-opaque blobs and src/ for source-authored assembly. Prefer stable labels, explicit table boundaries, and compact comments that explain calling conventions, invariants, encodings, ownership evidence, or ROM-layout artifacts without cluttering obvious code."
set "PROMPT=%PROMPT% When new evidence is found, update the most relevant notes in docs/research_log.md, docs/open_questions.md, worklogs, and todos.json so future passes inherit the reasoning instead of repeating the same analysis."
set "PROMPT=%PROMPT% Every iteration should leave the repo in a better state for humans: fewer anonymous blobs, clearer labels, cleaner module boundaries, sharper documentation, and a still bit-perfect rebuild."

:loop
echo.
echo ==================================================
echo Autopilot iteration started at %date% %time%
echo ==================================================
call opencode run --dir "%CD%" "%PROMPT%"
echo Autopilot iteration finished with exit code %errorlevel%
timeout /t 2 /nobreak >nul
goto loop
