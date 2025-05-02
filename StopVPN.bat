@echo off

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Stopping VPN services...

echo Stopping WireGuard tunnel...
"C:\Program Files\WireGuard\wireguard.exe" /uninstalltunnelservice SEEYUH

echo Closing Proxifier...
taskkill /F /IM proxifier.exe >nul 2>&1

echo Closing Tor...
taskkill /F /IM tor.exe >nul 2>&1

taskkill /F /IM wscript.exe >nul 2>&1

exit
