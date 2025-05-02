( This installation is kinda difficult I would recommend watching video and read guide ) 
Video Guide: https://cdn.discordapp.com/attachments/1361146227496058961/1361187376684204063/0413.mp4?ex=68163bc8&is=6814ea48&hm=2b22f9013fa9656561e88c25cab5f406ba109a942a2628f717e57ffe4df4d830&

1. Make sure you have [tor](https://www.torproject.org/dist/torbrowser/14.0.9/tor-browser-windows-x86_64-portable-14.0.9.exe) installed as well as [wireguard](https://download.wireguard.com/windows-client/wireguard-installer.exe)

2. Download wireguard first (its the easiest)
 
3. Download tor this one needs to be put in a specific location for the script to work. Make sure for now when you run the installer make sure the location of tor is on your desktop or in your downloads for now where it is easy to get to.

4. Drag your downloaded tor folder into "C:\Program Files" afterwards it should look like "C:\Program Files\Tor Browser"

5. Install the Proxifier provided and install to default location.

6. Now everything should be downloaded first lets start with gettings wireguard configured. Make sure you have a telegram. and join this channel https://t.me/warpplus it gives (hacked) warp+ configs with bajillion storage on them (basically infinite)

7. Once in the telegram there should be alot of warp+ keys but below it should say Free VPN Config. P R E S S I T. afterwards press Generate, it might make you join a different channel just do it then you can leave right after its generated once its generated it should look something like this 
" ✅ Successfully generated key!

🔐 Key: SUCK-MY-BALLS-NIGGA (1923837100 GB)

✨ If you enjoy free keys, please, make a donation to us (https://t.me/akamemoe/62)! It will help us to maintain this bot."

Above the message should be a file named wg-config.conf

8. After downloading I would recommend putting it in your Documents folder

9. Now make sure you go to "C:\Program Files\Tor Browser\Browser\TorBrowser\Tor" and run tor.exe at least once

10. Now your basically set for the most part now its time for editing the .bat files to get to the right file locations

11. You only have to change StartVPN.bat and StartTor.bat

12. 
"echo Launching Proxifier...
start /min "" "YOUR PATH TO\LaunchProxifier.vbs"
timeout /t 2 /nobreak >nul"

Make sure all the files are in a folder and put the path to where you save it to

13. 
"
set "WIREGUARD_PATH=C:\Program Files\WireGuard"
set "TOR_PATH=C:\Program Files\Tor Browser\Browser\TorBrowser\Tor"
set "CONFIG_PATH=YOUR PATH TO\replacename.conf"
set "TORRC_PATH=YOUR PATH TO\torrc"
set "PROXIFIER_PATH=YOUR PATH TO\LaunchProxifier.vbs"
set "ASCII_ART_PATH=YOUR PATH TO\ascii.txt"
set "IPDATA_API_URL=https://api.ipdata.co/?api-key=8701de3ac942a16e52762033f240682911128f1d6a0a2e31cc70bbb9"
"
and do the same for these ( if your retarded look at the video guide )

14. probably the hardest part if you don't get this right it wont work. 100% look at video guide for this.

15. Go into Proxifier, at the top it should say profile then proxy servers.

16. Add a new proxy server with the Address being 127.0.0.1:9050 and make sure the protocol is SOCKS Version 5

17. Next go into profile once more and press Proxification Rules make a new one name whatever you want I named it exlude wireguard/tor and in the Applications put this list 
"firefox.exe; nmhproxy.exe; plugin-container.exe; updater.exe; tor.exe; wireguard.exe; wg.exe" 
leave everything else the way it is but change the action at the bottom to Direct

18. Make another Proxification rule named All and inside put for Application and Target hosts "*" and for action put Proxy Socks 127.0.0.1

Wireguard stuff

[Interface]
MTU = 1480
PostUp = ip rule add from 172.16.0.2 table 128 && ip route add default via 172.16.0.1 dev wg0 && echo "WARP tunnel up" >> warp_log.txt
PostDown = ip rule del from 172.16.0.2 table 128 && echo "WARP tunnel down" >> warp_log.txt

[Peer]
PersistentKeepalive = 25
