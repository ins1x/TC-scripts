REM Silent install all ext.
REM Use SilentKeyFinder(DMalgin) to find keys (plugins/archive/skf)
REM Last upd: 09.01.2016 - Del DopTools and add 7zip

REM 7Zip v9.30 alpha x86/x64 (7z SFX archive)
7Zip -y -gm2 -fm0
K-Lite_Codec_Pack.exe /VERYSILENT 
RuntimePack_Lite_x86_x64.exe -y -gm2 -fm0
REM Setup Microsoft Visual C++ Runtimes 2005-2013
MVC_Runtime_x86_x64 /s
REM Sandboxie 3.46 Final
REM Name:	TrT/TcT Crew
REM Key:	GA9GYDA
SandboxIeInstall /S