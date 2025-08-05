# 🟧 Tristan's KeepAwake Utility
Tristan's KeepAwake Utility is a lightweight alternative to tools like Caffeine or Mouse Jiggler. It is designed to be usable when there are system security restrictions that disallow .exe or unknown applications by running in PowerShell. 

It operates by preventing your system from sleeping by pressing the unused `F15` key at regular intervals.

## Getting Started

1. **Right-click** `FirstRun.ps1` → **Run with PowerShell**
2. Shortcut `LaunchKeepAwake.lnk` will be created automatically (I did it this way since I could not get Windows to update pre-existing shortcuts with a custom icon. Doing it this way allows you to pin the shortcut wherever you like with the cute icon :D)
3. Use this shortcut going forward
4. KeepAwake will autostart to the system tray. To access its features simply right click the tray icon.

## Features
- Sends `F15` input every 1, 5, or 10 minutes
- Will run silently in the **system tray**
- Ability to **Pause** and temporarily stop inputs
- Requires no install or admin access

## Purpose for Pause?
Some programs (remote terminals, games, keyboard utilities) may react to `F15`.  
Use **Pause** if you experience issues while using your system

## Common Issues
 - Some users may see the below error:
````markdown
.\FirstRun.ps1: File C:\Users\User\Documents\KeepAwake\FirstRun.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ .\FirstRun.ps1
+ ~~~~~~~~~~~~~
+ CategoryInfo : SecurityError		: (:) [], PSSecurityException
+ FullyQualifiedErrorId 	: UnauthorizedAccess"
````
(This is because some systems may go a step further and block script execution entirely via execution policy. Most cases you should hopefully be able to get around it via the below instructions)

- First open powershell and run the below command: 
"Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass"
- After doing so, run FirstRun.ps1 from the same powershell window via .\
- Once complete you should see the below output:
````markdown
PS C:\Users\User\Documents\KeepAwake> Set-Execution Policy -Scope Process -ExecutionPolicy Bypass
PS C:\Users\User\Documents\KeepAwake> .\FirstRun.ps1
Creating shortcut: C:\Users\User\Documents\KeepAwake\LaunchKeepAwake.lnk
Shortcut created successfully.
````
After this you can use the LaunchKeepAwake shortcut going forward.

## Theme:  
> Background: `#233D4D`  
> Accent / Buttons: `#FE7F2D`
