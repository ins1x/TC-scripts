rem this script generated by pySDgen
rem kill process
taskkill.exe /f /im LockHunterPortable.exe
DEL /F /Q "%TEMP%\LockHunter\*.*"
RD "%TEMP%\LockHunter" /S /Q
rem Suicide
DEL /F /Q %0
