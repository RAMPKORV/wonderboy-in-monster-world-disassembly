@echo off
setlocal

pushd "%~dp0"

set "PROMPT=Continue executing todos.json and mark progress as you go. If everything in todos.json is done, continue working on the assembly in the most productive way while preserving a bit-perfect rebuild and keeping todos.json updated."

:loop
echo.
echo ==================================================
echo Autopilot iteration started at %date% %time%
echo ==================================================
call opencode run --dir "%CD%" "%PROMPT%"
echo Autopilot iteration finished with exit code %errorlevel%
timeout /t 2 /nobreak >nul
goto loop
