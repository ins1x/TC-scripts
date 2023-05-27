' Created by Ins_16 - Script deleting old vesion links on programs folder and desktop
' Create Total Commander links on Desktop and StartMenu (32 and 64 bit platform)
' Version 0.3 fixed bug - links created to AllUsers, and delete older links
On Error Resume Next

Set WshShell = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

AllUsersProfile = WshShell.ExpandEnvironmentStrings("%AllUsersProfile%")
UserProfile = WshShell.ExpandEnvironmentStrings("%UserProfile%")
ProgramFiles = WshShell.ExpandEnvironmentStrings("%ProgramFiles%")

OldLinkName = "Total Commander (by ins).lnk"
LinkName = "TotalCmd.lnk"

fso.DeleteFile UserProfile & "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\" & OldLinkName, True
fso.DeleteFile UserProfile & "\Desktop\" & OldLinkName, True

' 32-bit system
if fso.FileExists ("C:\Program Files (x86)\TotalCmd\TotalCmd.exe") then
	Set WshShortcut = WshShell.CreateShortcut(AllUsersProfile & "\Microsoft\Windows\Start Menu\Programs\" & LinkName)
	WshShortcut.Description = "Total Commander (by ins_16)"
	WshShortcut.TargetPath = "C:\Program Files (x86)\TotalCmd\TotalCmd.exe"
	WshShortcut.WindowStyle = 1
	WshShortcut.Save
end if
if fso.FileExists ("C:\Program Files (x86)\TotalCmd\TotalCmd.exe") then
	Set WshShortcut = WshShell.CreateShortcut(AllUsersProfile & "\Desktop\" & LinkName)
	WshShortcut.Description = "Total Commander (by ins_16)"
	WshShortcut.TargetPath = "C:\Program Files (x86)\TotalCmd\TotalCmd.exe"
	WshShortcut.WindowStyle = 1
	WshShortcut.Save
end if

' 64-bit system
if fso.FileExists ("C:\Program Files\TotalCmd\TotalCmd.exe") then
	Set WshShortcut = WshShell.CreateShortcut(AllUsersProfile & "\Microsoft\Windows\Start Menu\Programs\" & LinkName)
	WshShortcut.Description = "Total Commander (by ins_16)"
	WshShortcut.TargetPath = "C:\Program Files\TotalCmd\TotalCmd.exe"
	WshShortcut.WindowStyle = 1
	WshShortcut.Save
end if
if fso.FileExists ("C:\Program Files\TotalCmd\TotalCmd.exe") then
	Set WshShortcut = WshShell.CreateShortcut(AllUsersProfile & "\Desktop\" & LinkName)
	WshShortcut.Description = "Total Commander (by ins_16)"
	WshShortcut.TargetPath = "C:\Program Files\TotalCmd\TotalCmd.exe"
	WshShortcut.WindowStyle = 1
	WshShortcut.Save
end if
