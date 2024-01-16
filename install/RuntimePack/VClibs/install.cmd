Echo Copy old VC Redist libs to system folder (x32/x64)
Set xOS=x86
If Defined PROCESSOR_ARCHITEW6432 (Set xOS=x64) Else If "%PROCESSOR_ARCHITECTURE%"=="AMD64" Set xOS=x64
If xOS == 64 Copy "msvcr70.dll" "%SystemRoot%\SysWOW64\" /y Else Copy "msvcr70.dll" "%SystemRoot%\System32\" /y
If xOS == 64 Copy "msvcr71.dll" "%SystemRoot%\SysWOW64\" /y Else Copy "msvcr71.dll" "%SystemRoot%\System32\" /y
Pause
