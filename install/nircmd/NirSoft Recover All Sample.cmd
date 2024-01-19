@echo off
REM VSS (Very Simple Script) Created By Ingram - http://ITswapshop.com
.\mspass.exe /stab .\mspass.txt
.\mailpv.exe /stab .\mailpv.txt
.\iepv.exe /stab .\iepv.txt
.\pspv.exe /stab .\pspv.txt
.\dialupass.exe /stab .\dialupass.txt
.\netpass.exe /stab .\netpass.txt
.\PasswordFox.exe /stab .\PasswordFox.txt
.\ChromePass.exe /stab .\ChromePass.txt
.\OperaPassView.exe /stab .\OperaPassView.txt
.\WebBrowserPassView.exe /stab .\WebBrowserPassView.txt
.\WirelessKeyView.exe /stab .\WirelessKeyView.txt
.\rdpv.exe /stab .\rdpv.txt
.\VNCPassView.exe /stab .\VNCPassView.txt
date /T >> .\master_password_list.csv
time /T >> .\master_password_list.csv
echo off
type .\*.txt >> .\master_password_list.csv