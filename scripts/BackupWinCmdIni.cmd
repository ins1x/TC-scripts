@title backup totalcmd settings files
@echo off
cd ..\..
echo Copy TotalCMd settings files to backup folder
set Wincmd_ini=%CD%\Wincmd.ini
set BackupFolder=%CD%\Backup
if not exist "%BackupFolder%" md "Backup"
copy "%Wincmd_ini%" "%BackupFolder%\Wincmd.ini_%DATE%.bak" /y
if errorlevel 0 echo %Wincmd_ini% to %BackupFolder% copying successfully done
if not exist "%BackupFolder%\Wincmd.ini_%DATE%.bak" echo "ERROR Backup not created"