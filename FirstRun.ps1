# === FirstRun.ps1 ===
# Creates a shortcut to launch KeepAwake.vbs with an icon, if it doesn't exist.
# For some reason I couldn't get PS to check the shortcut for the custom ico and update if it doesn't exist. PS just would not co-operate with windows cache so instead of having that in the KeepAwake.ps1 it was easier to create this firstrun file to create the shortcut for the user.

$shell = New-Object -ComObject WScript.Shell
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$shortcutPath = Join-Path $scriptDir "LaunchKeepAwake.lnk"
$targetPath = "$env:WINDIR\System32\wscript.exe"
$vbsRelative = "KeepAwake.vbs"
$iconPath = Join-Path $scriptDir "Icon.ico"

if (-not (Test-Path $shortcutPath)) {
    Write-Host "Creating shortcut: $shortcutPath"

    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $targetPath
    $shortcut.Arguments = "`"$vbsRelative`""
    $shortcut.WorkingDirectory = $scriptDir

    if (Test-Path $iconPath) {
        $shortcut.IconLocation = "$iconPath,0"
    }

    $shortcut.Save()

    if (Test-Path $shortcutPath) {
        Write-Host "Shortcut created successfully."
    } else {
        Write-Host "Failed to create shortcut."
    }
} else {
    Write-Host "Shortcut already exists. Skipping creation."
}
