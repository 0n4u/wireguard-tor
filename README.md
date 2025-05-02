```markdown
# Installation Guide for VPN + Tor Setup  
*(Yes, I used ChatGPT to make this README look good – sue me)*

This guide will walk you through setting up WireGuard and Tor to ensure a secure and anonymous browsing experience. Follow each step carefully for a smooth setup.

> **Note**: This installation can be tricky, so if you encounter issues, feel free to consult the video guide or read through the instructions thoroughly.

---

## 🎥 Video Guide

[Watch the Video Guide](https://cdn.discordapp.com/attachments/1361146227496058961/1361187376684204063/0413.mp4?ex=68163bc8&is=6814ea48&hm=2b22f9013fa9656561e88c25cab5f406ba109a942a2628f717e57ffe4df4d830&)

---

## 📋 Prerequisites

Before starting, make sure you have the following installed:

1. **[Tor](https://www.torproject.org/dist/torbrowser/14.0.9/tor-browser-windows-x86_64-portable-14.0.9.exe)**  
   The Tor Browser is necessary for anonymous browsing.

2. **[WireGuard](https://download.wireguard.com/windows-client/wireguard-installer.exe)**  
   WireGuard VPN is essential for encrypting your internet traffic.

---

## ⚙️ Installation Steps

### 1. Install WireGuard

Start by downloading and installing WireGuard. This step is simple, and you can follow the on-screen instructions to complete the installation.

### 2. Install Tor

- Download and run the [Tor installer](https://www.torproject.org/dist/torbrowser/14.0.9/tor-browser-windows-x86_64-portable-14.0.9.exe).
- Place the Tor folder in a location that's easy to access, such as your desktop or the Downloads folder.
- After installation, move the Tor folder to `C:\Program Files\Tor Browser`.

### 3. Install Proxifier

- Download and install [Proxifier](https://www.proxifier.com/), and let it install to the default location.

### 4. Configure WireGuard

To set up WireGuard, you'll need a Telegram account to access a free Warp+ VPN configuration.

1. Join the [Warp+ Telegram Channel](https://t.me/warpplus).
2. Follow the instructions there to generate a Warp+ configuration.
3. Once you have the key, download the `wg-config.conf` file and place it in your **Documents** folder.

### 5. Run Tor

Navigate to `C:\Program Files\Tor Browser\Browser\TorBrowser\Tor` and run `tor.exe` at least once to ensure proper setup.

### 6. Edit `.bat` Files

There are two key batch files that need editing: `StartVPN.bat` and `StartTor.bat`.

#### Example of `StartTor.bat`:
echo Launching Proxifier...
start /min "" "PATHTOYOUR\LaunchProxifier.vbs"
timeout /t 2 /nobreak >nul


Make sure all the files are in the same folder, and update the path in the batch file to reflect your file locations.

### 7. Set File Paths

Edit the configuration file to set the correct paths for WireGuard, Tor, and other components.

#### Example of `StartVPN.bat`:
set "WIREGUARD_PATH=C:\Program Files\WireGuard"
set "TOR_PATH=C:\Program Files\Tor Browser\Browser\TorBrowser\Tor"
set "CONFIG_PATH=PATHTOYOUR\wg-config.conf"
set "TORRC_PATH=PATHTOYOUR\torrc"
set "PROXIFIER_PATH=PATHTOYOUR\LaunchProxifier.vbs"
set "ASCII_ART_PATH=PATHTOYOUR\ascii.txt"
set "IPDATA_API_URL=https://api.ipdata.co/?api-key=8701de3ac942a16e52762033f240682911128f1d6a0a2e31cc70bbb9"


Replace `PATHTOYOUR` with the actual path where the files are stored.

---

## 🔧 Proxifier Configuration

### 8. Configure Proxifier

1. Open Proxifier and go to **Profile > Proxy Servers**.
2. Add a new proxy with the following settings:
   - **Address**: `127.0.0.1:9050`
   - **Protocol**: SOCKS Version 5.

3. Set up proxification rules:
   - **Exclude WireGuard/Tor**: In **Applications**, add:

     firefox.exe; nmhproxy.exe; plugin-container.exe; updater.exe; tor.exe; wireguard.exe; wg.exe

     - Set **Action** to **Direct**.

   - **All Applications**: Create a rule for all applications with the following settings:
     - **Application**: *
     - **Target Hosts**: *
     - **Action**: **Proxy Socks 127.0.0.1**.

---

## ⚡ WireGuard Configuration

### 9. WireGuard Config File

To be clear, do **not** REPLACE the config file; just add this to it.

```ini
[Interface]
MTU = 1480
PostUp = ip rule add from 172.16.0.2 table 128 && ip route add default via 172.16.0.1 dev wg0 && echo "WARP tunnel up" >> warp_log.txt
PostDown = ip rule del from 172.16.0.2 table 128 && echo "WARP tunnel down" >> warp_log.txt

[Peer]
PersistentKeepalive = 25
```

---
```
