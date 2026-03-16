@echo off
setlocal enabledelayedexpansion

set EXPECTED_HASH=6b2ac36f624f914ad26e32baa87d1253aea9dcfc13d2a5842ecdd2bd4a7a43b9
set ROM_FILE=out.bin

echo Building ROM...
call asm68k /k /p /o ae- wonderboy.asm,out.bin,,wonderboy.lst
if errorlevel 1 (
    echo BUILD FAILED
    exit /b 1
)

echo.
echo Verifying ROM hash...
for /f "skip=1 tokens=*" %%a in ('certutil -hashfile %ROM_FILE% SHA256 2^>nul') do (
    if not defined ACTUAL_HASH (
        set "ACTUAL_HASH=%%a"
    )
)

set "ACTUAL_HASH=!ACTUAL_HASH: =!"

if /i "!ACTUAL_HASH!"=="!EXPECTED_HASH!" (
    echo.
    echo ========================================
    echo   BUILD VERIFIED - ROM IS BIT-PERFECT
    echo ========================================
    echo Hash: !ACTUAL_HASH!
    exit /b 0
) else (
    echo.
    echo ========================================
    echo   VERIFICATION FAILED - ROM MISMATCH
    echo ========================================
    echo Expected: !EXPECTED_HASH!
    echo Actual:   !ACTUAL_HASH!
    exit /b 1
)
