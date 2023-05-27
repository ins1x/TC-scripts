REM @echo off
REM Скрипт очистки временных файлов TC и интегрированных программ в систему.
REM Last UPD 23.01.2016:
REM + Delete hist ini sections on wincmd.ini
REM + NPP
REM 10.01.2016:
REM + ImgBurn, Ollydbg, RevoUnist, Syn
REM 31.01.2016
REM + Delete license info from registry

REM Запоминаем текущюю папку
set inst=%CD%
REM Переход в корневой каталог TC
cd ../
set commander_path=%CD%
REM Очистка временного каталога TC
del /s /q /f "%TEMP%\_tc"
REM Удалить все настройки плагина Syn
cd %commander_path% 
del /q /f "Syn*.ini"
REM Утилиты:
REM Очистка ImgBurn
start "%commander_path%\Programm\User\ImgBurn\uninstall.cmd"
REM Удаляет udd файлы в Ollydbg
start "%commander_path%\Programm\Developer\Ollydbg\deleteudd.cmd"
REM Удаляет бэкапы созданные RevoUnist
del /q "%commander_path%\Programm\Security\RevoUnist\BackUps\*.reg"
REM Удяляет бэкапы Notepad++
del /q "%commander_path%\Programm\Developer\NPP\backup\*.*"
cd %inst%

REM !!!!! Untested 23.01.16
REM Удаляет историю из wincmd.ini .Необходимо чтобы утилита nircmd лежала в %commander_path%
nircmd inidelsec "wincmd.ini" "Command line history"
nircmd inidelsec "wincmd.ini" "RenameTemplates"
nircmd inidelsec "wincmd.ini" "SearchText"
nircmd inidelsec "wincmd.ini" "RightHistory"
nircmd inidelsec "wincmd.ini" "LeftHistory"

REM Удаляет информацию о регистрации
REM nircmd regdelkey "HKEY_LOCAL_MACHINE\SOFTWARE\Ghisler"
REM nircmd regdelkey "HKEY_CURRENT_USER\SOFTWARE\Ghisler"

REM C0de by Y0mO_o