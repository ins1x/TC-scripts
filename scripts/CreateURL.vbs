' CreateURL VBS version - Script creates .url files by inputted url.
Set fso = CreateObject("Scripting.FileSystemObject") 
Set WshShell = CreateObject("WScript.Shell")
CD = WshShell.CurrentDirectory
link = InputBox ("введите полную ссылку например http://google.com/example/url, по ней в текущей папке будет создан .url файл","CreateURL v0.3.1 by Ins_16")

my_arr = split(link, "/")
url = my_arr(2)
outfile = CD & "/" & url & ".url"
my_arr(1) = my_arr(2)
Redim Preserve my_arr(1)

favicon = my_arr(0) & "//" & my_arr(1) 

Set f = FSO.OpenTextFile(outfile,8,true,0)
f.WriteLine "[InternetShortcut]"
f.WriteLine "URL=" & link 
f.WriteLine "IconFile=" & favicon & "/favicon.ico"
f.WriteLine "IconIndex=1"