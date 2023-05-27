'=====================================================================
' Создание папки по имени файла и перемещение в нее файла
' Может быть выделено несколько файлов

' Для создания папок в текущей панели
' в параметрах вызова из TC должно быть прописано:
' %L

' Для создания папок в противоположной панели
' в параметрах вызова из TC должно быть прописано:
' %L "%T"
'=====================================================================

If WScript.Arguments.Count = 0 Then
MsgBox "Не указаны параметры!", vbOKOnly + vbError, "Внимание!"
Wscript.Quit
End If

Dim TempFile, FSO, SelFile
Set FSO = CreateObject("Scripting.FileSystemObject")
Set TempFile = FSO.OpenTextFile(WScript.Arguments(0), 1)

Dim FileName, FilePath, DashInName, NewFilePath
Do While Not TempFile.AtEndOfStream
Set SelFile = FSO.GetFile(TempFile.ReadLine)
FileName = FSO.GetBaseName(SelFile)
FilePath = SelFile.ParentFolder
If WScript.Arguments.Count > 1 Then
NewFilePath = WScript.Arguments(1) & FileName
Else
NewFilePath = FilePath & "\" & FileName
End If
If Not FSO.FolderExists(NewFilePath) Then
FSO.CreateFolder(NewFilePath)
End If
If Not FSO.FileExists(NewFilePath & "\" & FileName) Then
FSO.MoveFile SelFile, NewFilePath & "\"
Else
MsgBox "Уже существует файл " & FileName & " в папке " & NewFilePath, vbOKOnly + vbExclamation, "Внимание!"
End If
Loop
Set TempFile = Nothing
Set FSO = Nothing
Set SelFile = Nothing
Wscript.Quit
