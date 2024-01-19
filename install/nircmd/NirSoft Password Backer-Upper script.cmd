@echo off
TITLE NirSoft Password Backer-Upper script
echo Please disable on-access virus scanners before running this tool!
rem Outpu files directory
set outdir=%USERPROFILE%\Desktop\passw_snaphot_%computername%\
rem Hack pause=seconds + 1
set seconds=1
if not exist %outdir% mkdir %outdir%
echo Backing Up FireFox Passwords...
start /wait "" "NirSoft\PasswordFox.exe" /shtml "%outdir%\FirefoxPasswords.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM PasswordFox.exe
echo Backing Up Internet Explorer Passwords...
start /wait "" "NirSoft\iepv.exe" /shtml "%outdir%\iePasswords.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM iepv.exe
echo Backing Up Google Chrome Passwords...
start /wait "" "NirSoft\ChromePass.exe" /shtml "%outdir%\ChromePasswords.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM ChromePass.exe
echo Backing Up Opera Passwords...
start /wait "" "NirSoft\OperaPassView.exe" /shtml "%outdir%\OperaPasswords.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM OperaPassView.exe
echo Backing Up Email Client Passwords...
start /wait "" "NirSoft\mailpv.exe" /shtml "%outdir%\Emails.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM mailpv.exe
echo Backing Up Outlook PST Passwords...
start /wait "" "NirSoft\PstPassword.exe" /shtml "%outdir%\OutlookPSTPasswords.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM PstPassword.exe
echo Backing Up Dial-Up Passwords...
start /wait "" "NirSoft\dialupass.exe" /shtml "%outdir%\DialUpPasswords.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM dialupass.exe
echo Backing Up Instant Messaging Passwords...
start /wait "" "NirSoft\mspass.exe" /shtml "%outdir%\InstantMessengerPasswords.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM mspass.exe
echo Backing Up Wireless Network Keys...
start /wait "" "NirSoft\WirelessKeyView.exe" /shtml "%outdir%\WiFiKeys.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM WirelessKeyView.exe
echo Backing Up Software Product Keys...
start /wait "" "NirSoft\ProduKey.exe" /shtml "%outdir%\SoftwareProductKeys.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM ProduKey.exe"
echo Backing Up Other Network Passwords...
start /wait "" "NirSoft\Netpass.exe" /shtml "%outdir%\Netpass.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM Netpass.exe
echo Backing Up Protected Storage Passwords...
start /wait "" "NirSoft\pspv.exe" /shtml "%outdir%\ProtectedStorage.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM pspv.exe
echo Remote Desktop Passes...
start /wait "" "NirSoft\rdpv.exe" /shtml "%outdir%\RemoteDesktop.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM rdpv.exe
echo LSA Secrets...
start /wait "" "NirSoft\lsasecretsview.exe" /shtml "%outdir%\RemoteDesktop.html"
ping -n %seconds% 127.0.0.1 > nul
taskkill /IM lsasecretsview.exe
echo.