@echo off
REM Start TOTALCMD with custom setting file
start TOTALCMD.EXE /N /i="%CD%\wincmd.ini"
@exit