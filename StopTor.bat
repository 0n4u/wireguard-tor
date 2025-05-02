@echo off

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Stopping Tor stuff...

echo Closing Proxifier...
taskkill /F /IM proxifier.exe >nul 2>&1

echo Closing Tor...
taskkill /F /IM tor.exe >nul 2>&1

echo All done. Tor is fully stopped.
pause
exit
