@echo off
setlocal

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Starting Tor...
start "" /B "C:\Program Files\Tor Browser\Browser\TorBrowser\Tor\tor.exe" -f "C:\Users\Admin\Documents\VPN\torrc"
timeout /t 10 /nobreak >nul

tasklist | findstr tor.exe >nul
if %errorLevel% neq 0 (
    echo ERROR: Tor did not start correctly. Check tor_log.txt for more details.
    exit /b
)

echo Launching Proxifier...
start /min "" "C:\\PATHTOYOUR\VPN\LaunchProxifier.vbs"
timeout /t 2 /nobreak >nul

echo All services started successfully.
exit /b
