'			  (o o)
'	.__ __ooO--(_)--Ooo__ ____  ________
'	|__| ____   ______   /_   |/  _____/
'	|  |/    \ /  ___/    |   /   __  \ 
'	|  |   |  \\___ \     |   \  |__\  \
'	|__|___|  /____  >____|___|\_____  /
'			\/     \/_____/          \/ 
' Created by Ins_16 - ins16publick@gmail.com
'
' Script find and delete all version Total Commander
' Version 0.2.4 EN Last update 25.02.2016 WinAll
' MIT License http://www.opensource.org/licenses/mit-license.php
' You run this script at your own risk!
' -----------------------------------------------------------------------
' Function list
' - The cleaning information will be saved into the Log (%TEMP%)
' - Close all TC process before cleaning
' - Delete unknow versions too
' - Delete links from desktop, quicklaunch, startmenu..
' - Clean registry data
' - Clean files from temp and appdata folders
' - Clean autorun
' - Run in silent mode without message boxes (/silent)
' -----------------------------------------------------------------------

' Global enviroments
Set WshShell = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
' System enviroment
AllUsersProfile = WshShell.ExpandEnvironmentStrings("%AllUsersProfile%")
UserProfile = WshShell.ExpandEnvironmentStrings("%UserProfile%")
ProgramFiles = WshShell.ExpandEnvironmentStrings("%ProgramFiles%")
Temp = WshShell.ExpandEnvironmentStrings("%Temp%")
AppData = WshShell.ExpandEnvironmentStrings("%AppData%")
' Usersapce enviroment
SendTo = WshShell.SpecialFolders(SendTo)
Autorun = WshShell.SpecialFolders(Startup)
Desktop = WshShell.SpecialFolders(Desktop)
StartMenu = WshShell.SpecialFolders(StartMenu)
Programs = WshShell.SpecialFolders(Programs)
' Allusers enviroment
AllUsersAutorun = WshShell.SpecialFolders(AllUsersStartup)
AllUsersDesktop = WshShell.SpecialFolders(AllUsersDesktop)
AllUsersStartMenu = WshShell.SpecialFolders(AllUsersStartMenu)
AllUsersPrograms = WshShell.SpecialFolders(AllUsersPrograms)
'-----------------------------------------------------------------------

' MESSAGES
' In order to translate this script to other language.Translate all string entries bellow to the desired language.
MSG_Help = "Script find and delete all version Total Commander. Support commands" & VbCrLf & "/silent - run script in silent mode without message boxes" & VbCrLf & "/version- show script version and build date" & VbCrLf & "/commands - show all supported commands"
CONST MSG_StartClean = "Delete previous versions TC?"
CONST MSG_Commands = "Support commands /help, /version, /silent, /commands"
CONST MSG_Version = "0.2.4"
CONST wshYesNoDialog = 4
CONST MSG_Founded = "Founded "
CONST MSG_NotFound = "Not Found "
CONST MSG_Remove_Ask = "You are sure want delete them?"
CONST MSG_Abort_Del = "User abort deleting "
CONST MSG_Removed = " Removed "
CONST MSG_ErrorCheckfile = "Checkfiles not found."
CONST MSG_DefDel = "Default TC locations cleaned. "
CONST MSG_DefFold = "Find unknow TC version. Delete default folder TC destination?"
CONST MSG_Prockilled = "All Totalcmd process closed."
CONST MSG_LinksCleaned = "All links cleaned."
CONST MSG_KeyRemoved = " Registry key removed"
CONST MSG_RegistryCleaned = "Registry cleaned"
CONST MSG_Finish = "Clean TC finished"
'-----------------------------------------------------------------------

' Use ProgramFiles + dict item
' Add more checkfiles bellow
Set Checkfiles = CreateObject("Scripting.Dictionary")
Checkfiles.Add " InsPack", "\TotalCmd\Language\!readme.html"
Checkfiles.Add " InsPack_(upd18) ", "\TotalCmd\Language\Whatchanged.txt"
Checkfiles.Add " InsPack_(upd14-17) ", "\TotalCmd\Language\What's new.txt"
Checkfiles.Add " TCbyIns PrivateEdition ", "\Total Commander by INS\Create_links.cmd"
Checkfiles.Add " TCMAX ", "\Total Commander\TC-Links_D.vbs"
Checkfiles.Add " TechAdmin ", "\TotalCmd\Help\TechAdmin_Help.txt"
Checkfiles.Add " PE ", "\Total Commander\iniramdrv.exe"
Checkfiles.Add " SamLab ", "\Total Commander\SamLab.ws.url"
Checkfiles.Add " SamLab OSZonePack ", "\Total Commander\LANGUAGE\SamTCPP.bmp"
Checkfiles.Add " SamLab PowerPack ", "\Total Commander\LANGUAGE\wcmd_rus_lite.mnu"

' TC default destinations 
TCcmd_Folder = ProgramFiles + "\TotalCmd"
TCdef_Folder = ProgramFiles + "\Total Commander"
TCrootC = """C:\Total Commander"""
ArrTCdefFolders = Array(TCcmd_Folder,TCdef_Folder,TCrootC)

' Logfile init
' Output log to %TEMP%
LogFileName = Temp + "\DELETETC_Log.txt"
' Output log in script directory
' LogFileName = "DELETE_Log.txt"
Set Logfile = fso.OpenTextFile(LogFileName, 8, True)

Function DeleteFolder(path)
	'Simple function to delete folders
	if FSO.FolderExists(path) then
		' Method 1. Default VBS deleting method 
		' Unstable can't delete some files in subfolder, don't use it
		'Set GetDelFolder = FSO.GetFolder(path)
		'GetDelFolder.Delete
		
		' Method 2. Recursive deleting files (shell mode)
		'cmd = "cmd /c del /s /q /f """ + path + """
		'WshShell.Run cmd, 0, True
		' Delete folder with all subfolders and files
		cmd = "cmd /c rmdir """ + path + """ /s /q"
		WshShell.Run cmd, 0, True
		
		' Method 3. External script run
		' Sample content remove_tc.cmd :
		' 	If exist "c:\Program Files\TotalCmd\" rmdir "c:\Program Files\TotalCmd\" /s /q
		' 	If exist "C:\Program Files\Total Commander" rmdir "C:\Program Files\Total Commander" /s /q
		' Uncomment bellow if you want use it
		' Run this script
		'cmd = "remove_tc.cmd"
		'WshShell.Exec cmd
		
		Logfile.WriteLine (now() & " - " & path & " " & MSG_Removed)
	end if
End Function

Function ParseAndDeleteFolder(path)
	' Parse path, and delete root folder
	ArrTCPath = Split(path, "\")
	' Get tc root directory from checkfile
	Del_folder = ArrTCPath(0) + "\" + ArrTCPath(1) + "\" + ArrTCPath(2)
	DeleteFolder(Del_folder)
End Function

Function KillProc()
	' Kill all TC opened processes
	cmd = "cmd /c taskkill /IM Totalcmd.exe* /F"
	WshShell.Run cmd, 0, True
	Logfile.WriteLine (now() & " - " & MSG_Prockilled)
End Function

Function CleanRegistry()
	' Clean all TC registry data
	On Error Resume Next
	
	' Reserved for autorun clean (not used)
	'arRunKeys = Array ("Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run", _ 
	'"Software\Microsoft\Windows\CurrentVersion\Run", _  
	'"Software\Microsoft\Windows\CurrentVersion\RunOnce", _ 
	 '"Software\Microsoft\Windows\CurrentVersion\RunOnce\Setup", _ 
	 '"Software\Microsoft\Windows\CurrentVersion\RunOnceEx", _ 
	 '"Software\Microsoft\Windows\CurrentVersion\RunServices", _ 
	 '"Software\Microsoft\Windows\CurrentVersion\RunServicesOnce", _ 
	 '"Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run")
	
	ArrRegKeys = Array("HKEY_LOCAL_MACHINE\SOFTWARE\Ghisler","HKEY_CURRENT_USER\SOFTWARE\Ghisler")
	
	For Each key in ArrRegKeys
		WshShell.RegDelete key
		Logfile.WriteLine (now() & " - " & key & MSG_KeyRemoved)
	Next
	
	Logfile.WriteLine (now() & " - " & MSG_RegistryCleaned)
End Function

Function Delete_links(SelectUserProfile)
	' Delete TC Links from start menu, desktop, quicklaunch, sendTo, autorun
	' SelectUserProfile = "AllUsers" or "User" set user profiles to search link files
	
	' Array content default link names.
	ArrLinks = Array("\Total Commander.lnk", "\Total Commander (by ins).lnk", "\TotalCmd.lnk", "\TC.lnk", "\TC32.lnk", "\TC64.lnk","\TotalCommander.lnk")
	
	for each link in ArrLinks
		' Set default link folders (SendTo,Quick Launch,Desktop,Autorun,StartMenu)
		UserStartMenuLink = StartMenu & link
		AllUserStartMenuLink = AllUsersStartMenu & link
		UserDesktopLink = Desktop & link
		AllUserDesktopLink = AllUsersDesktop & link 
		UserQuickLaunchLink = UserProfile & "\Application Data\Microsoft\Internet Explorer\Quick Launch" & link
		AllUserQuickLaunchLink = AllUserProfile & "\Application Data\Internet Explorer\Quick Launch" & link
		UserSendTo = SendTo & link
		UserAutorun = Startup & link
		AllUserAutorun = AllUsersStartup & link
		
		' Declare folders to search link files(All users profile or only for current user)
		Select case SelectUserProfile
			case "AllUsers"
				ArrLinkFolders = Array(UserStartMenuLink,AllUserStartMenuLink,UserDesktopLink,AllUserDesktopLink,UserQuickLaunchLink,AllUserQuickLaunchLink,UserSendTo,UserAutorun,AllUserAutorun)
			case "User"
				ArrLinkFolders = Array(UserStartMenuLink,UserDesktopLink,UserQuickLaunchLink,UserSendTo,UserAutorun)
		End Select
		
		' Check and clear link from ArrLinkFolders Array
		for each linkfolder in ArrLinkFolders
			if fso.FileExists (linkfolder) then
				' Debug message
				' MsgBox linkfolder
				fso.DeleteFile linkfolder, True
				Logfile.WriteLine (now() & " - " & linkfolder & " " & MSG_Removed)
			end if
		Next
		
	Next
	Logfile.WriteLine (now() & " - " & MSG_LinksCleaned)
End Function

Function CleanTempFiles()
	' Remove temporary files from appdata
	' Files and folders list
	AppDataGHISLERFold = AppData + "\GHISLER"
	Data_tcFold = Temp + "\_tc"
	
	ArrTempFolders = Array(AppDataGHISLERFold,Data_tcFold)
	
	For Each item in ArrTempFolders
		if FSO.FolderExists(item) then
			Set Folder = FSO.GetFolder(item)
			Folder.Delete
			Logfile.WriteLine (now() & " - " & item & " " & MSG_Removed)
		end if
		if FSO.FileExists(item) then
			Set File = FSO.GetFile(item)
			File.Delete
			Logfile.WriteLine (now() & " - " & item & " " & MSG_Removed)
		end if
	Next
End function

Function Cleaner(Silent_mode)
	' Detect installed versions Total Commander, and remove them.
	
	Dim Cnt : Cnt = -1 ' counter
	for each i in Checkfiles
		' Get dict keys and start counter
		Cnt = Cnt + 1
		TCv = Checkfiles.Keys
		TC_Version = TCv(Cnt)
		Checkfile = ProgramFiles + Checkfiles.item(i)
		if fso.FileExists (Checkfile) then
			Logfile.WriteLine (now() & " - " & TC_Version & MSG_Founded)
			if Silent_mode = False then 
				intMB = WshShell.Popup(TC_Version & MSG_Founded & MSG_Remove_Ask,, WScript.ScriptName, wshYesNoDialog)
				Select case intMB
					case vbNo
						Logfile.WriteLine (now() & " - " & MSG_Abort_Del & Checkfile)
					case vbYes
						' #Debug info MsgBox(MSG_Remove_Ask & TC_Version)
						ParseAndDeleteFolder(Checkfile)
						Logfile.WriteLine (now() & " - " & MSG_Removed & TC_Version)		
				End Select
			else
				' Silent delete
				ParseAndDeleteFolder(Checkfile)
				Logfile.WriteLine (now() & " - " & MSG_Removed & TC_Version)
			end if
		else
			' #Debug info
			' Logfile.WriteLine (now() & " - " & MSG_ErrorCheckfile)
			WScript.Sleep 100
		end if
	Next
	
	'Delete unknow versions
	WScript.Sleep 1000
	if Silent_mode = False then 
		for each folder in ArrTCdefFolders
			if FSO.FolderExists(folder) then
				intMB = WshShell.Popup(MSG_DefFold,, WScript.ScriptName, wshYesNoDialog)
				Select case intMB
					case vbNo
						Logfile.WriteLine (now() & " - " & MSG_Abort_Del & folder)
					case vbYes
						DeleteFolder(folder)
						Logfile.WriteLine (now() & " - " & MSG_DefDel & folder)
				End Select
			end if
		next
	else
		' Silent delete
		for each folder in ArrTCdefFolders
			if FSO.FolderExists(folder) then
				DeleteFolder(folder)
				Logfile.WriteLine (now() & " - " & MSG_DefDel & folder)
			end if
		next
	end if
	
	'Finnish message	
	MsgBox(MSG_Finish)
End Function

Function Start(Silent_mode)
	' Prepairing. Call subfunctions
	if Silent_mode = False then 
		answ = WshShell.Popup(MSG_StartClean,, WScript.ScriptName, wshYesNoDialog)
		Select case answ
			case vbNo
				Wscript.Quit 0
			case vbYes
				KillProc() 'Close all TC windows
				' Delete_links("User") 'Delete Desktop,startmenu,quicklaunch links for current user
				Delete_links("AllUsers") 'Delete Desktop,startmenu,quicklaunch links for all users
				CleanRegistry() 'Clean windows registry
				CleanTempFiles() 'Clean temporary files and folders
				Cleaner(False) 'Clean TC and ask before deleting
		End Select
	else
		'Silent mode
		KillProc() 'Close all TC windows
		Delete_links("AllUsers") 'Delete Desktop,startmenu,quicklaunch links for all users
		CleanRegistry() 'Clean windows registry
		CleanTempFiles() 'Clean temporary files and folders
		Cleaner(True) 'Clean TC without messages
	end if
End Function

Function ArgParse()
	' Argument Parser
	If WScript.Arguments.Count > 0 then
		For Each Argument In WScript.Arguments
			Select case Argument
				case "/help" MsgBox(MSG_Help)
				case "/h" MsgBox(MSG_Help)
				case "--help" MsgBox(MSG_Help)
				case "/commands" MsgBox(MSG_Commands)
				case "/version" MsgBox(MSG_Version)
				case "/silent" Start(True)
			End Select
		Next
	else
		Start(False)
	End if
End Function

' Start argument parsing
ArgParse()