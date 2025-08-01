Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

scriptPath = objFSO.GetParentFolderName(WScript.ScriptFullName)
objShell.Run "powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & scriptPath & "\KeepAwake.ps1""", 0
