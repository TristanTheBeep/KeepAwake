# 🟧 KeepAwake Utility
Tristan's KeepAwake Utility is a lightweight alternative to tools like Caffeine or Mouse Jiggler. It is designed to circumvent security restrictions that disallow .exe or unknown applications by running in PowerShell. 

It operates by preventing your system from sleeping by pressing the unused `F15` key at regular intervals.

## 🚀 Getting Started

1. **Right-click** `FirstRun.ps1` → **Run with PowerShell**
2. Shortcut `LaunchKeepAwake.lnk` will be created automatically (I did it this way since I could not get Windows to update existing shortcuts with the custom Icon. That way when you pin the shortcut you can have a cute icon :D)
3. Use this shortcut going forward
4. KeepAwake will autostart to the system tray. To access its features simply right click the tray icon.

## 🔧 Features
- ⏱️ Presses `F15` every 1, 5, or 10 minutes
- 🛠️ Runs silently in the **system tray**
- 💤 **Pause** feature to temporarily stop inputs
- 🚫 Requires no install or admin access

## ⚠️ Why Pause Exists
Some programs (remote tools, games, keyboard utilities) may unexpectedly react to `F15`.  
Use **Pause** if you experience issues while using your system

> 🎨 Theme:  
> Background: `#233D4D`  
> Accent / Buttons: `#FE7F2D`
