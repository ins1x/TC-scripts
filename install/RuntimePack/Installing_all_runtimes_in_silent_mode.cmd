REM Silent install Runtimes.
REM Use SilentKeyFinder(DMalgin) to find keys (plugins/archive/skf)

REM 7Zip v9.30 alpha x86/x64 (7z SFX archive)
REM 7Zip -y -gm2 -fm0
K-Lite_Codec_Pack.exe /VERYSILENT 
REM RuntimePack does not contain Microsoft Visual C++ libraries
RuntimePack_Lite_x86_x64.exe -y -gm2 -fm0
REM Setup Microsoft Visual C++ Runtimes 2005-2013
MVC_Runtime_x86_x64 /s