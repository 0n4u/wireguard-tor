# Installation Guide for VPN + Tor Setup ( Yes I used chatgpt to make this readme look good sue me )

This installation guide will walk you through setting up WireGuard and Tor for a secure, anonymous browsing experience. Follow the steps carefully for a smooth setup.

**Note**: This installation can be a bit tricky. If you’re stuck, I recommend checking the video guide and reading through the instructions thoroughly.

## Video Guide
[Watch the Video Guide](https://cdn.discordapp.com/attachments/1361146227496058961/1361187376684204063/0413.mp4?ex=68163bc8&is=6814ea48&hm=2b22f9013fa9656561e88c25cab5f406ba109a942a2628f717e57ffe4df4d830&)

---

## Prerequisites

1. **[Tor](https://www.torproject.org/dist/torbrowser/14.0.9/tor-browser-windows-x86_64-portable-14.0.9.exe)**  
   You need Tor installed on your system for the script to work properly.

2. **[WireGuard](https://download.wireguard.com/windows-client/wireguard-installer.exe)**  
   WireGuard is essential for setting up the VPN tunnel.

---

## Installation Steps

### 1. Install WireGuard
- Start by downloading and installing WireGuard. It’s the easiest part of the setup process.
  
### 2. Install Tor
- Download and run the Tor installer.
- Place the Tor folder in a location that’s easy to access, like your desktop or downloads folder.
- After installation, move the Tor folder to `C:\Program Files` so it’s located at `C:\Program Files\Tor Browser`.

### 3. Install Proxifier
- Download and install the Proxifier software to the default location.

### 4. Configure WireGuard
- You need a Telegram account to access a free Warp+ VPN config.
- Join the [Warp+ Telegram Channel](https://t.me/warpplus) and generate a Warp+ config by following the instructions.
- After generating the key, download the `wg-config.conf` file and place it in your Documents folder.

### 5. Run Tor
- Navigate to `C:\Program Files\Tor Browser\Browser\TorBrowser\Tor` and run `tor.exe` at least once to set it up.

### 6. Edit .bat Files
- There are two important batch files you need to configure: `StartVPN.bat` and `StartTor.bat`.
  
    **Example of `StartVPN.bat`:**
    ```batch
    echo Launching Proxifier...
    start /min "" "YOUR PATH TO\LaunchProxifier.vbs"
    timeout /t 2 /nobreak >nul
    ```

    Make sure all the files are in the same folder and update the path in the batch file accordingly.

### 7. Set File Paths
- Edit the configuration file to set the paths for WireGuard, Tor, and other components:

    ```batch
    set "WIREGUARD_PATH=C:\Program Files\WireGuard"
    set "TOR_PATH=C:\Program Files\Tor Browser\Browser\TorBrowser\Tor"
    set "CONFIG_PATH=YOUR PATH TO\wg-config.conf"
    set "TORRC_PATH=YOUR PATH TO\torrc"
    set "PROXIFIER_PATH=YOUR PATH TO\LaunchProxifier.vbs"
    set "ASCII_ART_PATH=YOUR PATH TO\ascii.txt"
    set "IPDATA_API_URL=https://api.ipdata.co/?api-key=8701de3ac942a16e52762033f240682911128f1d6a0a2e31cc70bbb9"
    ```

    Replace `YOUR PATH TO` with the actual path where the files are stored.

---

## Proxifier Configuration

### 8. Configure Proxifier
1. Open Proxifier and go to **Profile > Proxy Servers**.
2. Add a new proxy with the following settings:
   - **Address**: `127.0.0.1:9050`
   - **Protocol**: SOCKS Version 5.

3. Set up proxification rules:
   - **Exclude WireGuard/Tor**: In **Applications**, add:
     ```
     firefox.exe; nmhproxy.exe; plugin-container.exe; updater.exe; tor.exe; wireguard.exe; wg.exe
     ```
     - Set **Action** to **Direct**.

   - **All Applications**: Create a rule for all applications with the following settings:
     - **Application**: `*`
     - **Target Hosts**: `*`
     - **Action**: **Proxy Socks 127.0.0.1**.

---

## WireGuard Configuration

### 9. WireGuard Config File
Here’s a sample WireGuard config file to use:

```ini
[Interface]
MTU = 1480
PostUp = ip rule add from 172.16.0.2 table 128 && ip route add default via 172.16.0.1 dev wg0 && echo "WARP tunnel up" >> warp_log.txt
PostDown = ip rule del from 172.16.0.2 table 128 && echo "WARP tunnel down" >> warp_log.txt

[Peer]
PersistentKeepalive = 25
