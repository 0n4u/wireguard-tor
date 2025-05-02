@echo off
setlocal enabledelayedexpansion

set "WIREGUARD_PATH=C:\Program Files\WireGuard"
set "TOR_PATH=C:\Program Files\Tor Browser\Browser\TorBrowser\Tor"
set "CONFIG_PATH=C:\PATHTOYOUR\NAME.conf"
set "TORRC_PATH=C:\PATHTOYOUR\VPN\torrc"
set "PROXIFIER_PATH=C:\PATHTOYOUR\VPN\LaunchProxifier.vbs"
set "ASCII_ART_PATH=C:\PATHTOYOUR\VPN\ascii.txt"
set "IPDATA_API_URL=https://api.ipdata.co/?api-key=8701de3ac942a16e52762033f240682911128f1d6a0a2e31cc70bbb9"

color 07
cls

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Checking WireGuard connection status...
set "HANDSHAKE_FOUND=false"

for /f "tokens=1,* delims=:" %%A in ('"%WIREGUARD_PATH%\wg.exe" show') do (
    set "line=%%A"
    echo !line! | findstr /i "latest handshake" >nul
    if !errorlevel! == 0 (
        echo %%B | findstr /r "[0-9]" >nul
        if !errorlevel! == 0 (
            set "HANDSHAKE_FOUND=true"
        )
    )
)

if "!HANDSHAKE_FOUND!"=="true" (
    echo WireGuard is already connected. Skipping WireGuard start.
) else (
    echo WireGuard is not connected. Starting connection...
    call "%WIREGUARD_PATH%\wireguard.exe" /installtunnelservice "%CONFIG_PATH%"
    timeout /t 5 /nobreak >nul

    set "HANDSHAKE_FOUND=false"
    for /f "tokens=1,* delims=:" %%A in ('"%WIREGUARD_PATH%\wg.exe" show') do (
        set "line=%%A"
        echo !line! | findstr /i "latest handshake" >nul
        if !errorlevel! == 0 (
            echo %%B | findstr /r "[0-9]" >nul
            if !errorlevel! == 0 (
                set "HANDSHAKE_FOUND=true"
            )
        )
    )

    if "!HANDSHAKE_FOUND!"=="true" (
        echo WireGuard started successfully.
    ) else (
        echo WireGuard did not start correctly.
    )
)

echo Starting Tor with configuration file...
start "" /B "%TOR_PATH%\tor.exe" -f "%TORRC_PATH%"
timeout /t 10 /nobreak >nul
tasklist | findstr tor.exe >nul
if %errorLevel% neq 0 (
    echo Tor did not start correctly.
) else (
    echo Tor started successfully.
)

echo Launching Proxifier...
start /min "" "%PROXIFIER_PATH%"
timeout /t 2 /nobreak >nul

cls
timeout /t 2 /nobreak >nul
timeout /t 3 /nobreak >nul
mode con: cols=46 lines=29

color 0A

type "%ASCII_ART_PATH%"

powershell -Command "$c = [Console]::ForegroundColor; [Console]::ForegroundColor = 'White'; Write-Host ' overdose.'; [Console]::ForegroundColor = $c"

set URL=%IPDATA_API_URL%
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    $ip = 'Not available'; ^
    $country = 'Not available'; ^
    $city = 'Not available'; ^
    $region = 'Not available'; ^
    $provider = 'Not available'; ^
    $timezone = 'Not available'; ^
    try { ^
        $response = Invoke-RestMethod -Uri '%URL%'; ^
        if ($response.ip) { $ip = $response.ip }; ^
        if ($response.country_name) { $country = $response.country_name }; ^
        if ($response.city) { $city = $response.city }; ^
        if ($response.region) { $region = $response.region }; ^
        if ($response.asn.name) { $provider = $response.asn.name }; ^
        if ($response.time_zone.name) { $timezone = $response.time_zone.name }; ^
    } catch { ^
        Write-Host 'Error: Unable to fetch data from API.'; ^
        Write-Host '--------------------------------------'; ^
    }; ^
    Write-Host '--------------------------------------'; ^
    Write-Host ' IP: ' $ip; ^
    Write-Host ' Country: ' $country; ^
    Write-Host ' City: ' $city; ^
    Write-Host ' Region: ' $region; ^
    Write-Host ' ISP / Provider: ' $provider; ^
    Write-Host ' Time Zone: ' $timezone; ^
    Write-Host '--------------------------------------'

pause >nul
exit
