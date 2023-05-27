' =============================================== 
'  јвторы:     SkOle, Batya 
'  ќписание:   —оздает €рлыки на рабочем столе 
'  ѕараметры:  %L 
' =============================================== 

Option Explicit 

If WScript.Arguments.Count > 0 Then 
   Dim WSH, FSO, Desktop, F 
   Set WSH = CreateObject("Wscript.Shell") 
   Set FSO = CreateObject("Scripting.FileSystemObject") 
   Desktop = WSH.SpecialFolders("Desktop") 

   For Each F In Split(FSO.OpenTextFile(WScript.Arguments(0)).ReadAll, vbNewLine) 
     If FSO.FileExists(F) Or FSO.FolderExists(F) Then 
       With WSH.CreateShortcut(Desktop & "\" & FSO.GetBaseName(F) & ".lnk") 
         .TargetPath = F 
         .WorkingDirectory = FSO.GetParentFolderName(F) 
         .Save 
       End With 
     End If 
   Next 

   Set FSO = Nothing 
   Set WSH = Nothing 
End If 

WScript.Quit