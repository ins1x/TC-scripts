REM @echo off
REM Скрипт интеграции TC в систему(авторегистрация, установка необходимых компонентов, драйверов)
REM Last UPD 10.01.2016:
REM + Tconsole, VD sample

REM Запоминаем текущюю папку
set inst=%CD%
REM Переход в корневой каталог TC
cd ../
set commander_path=%CD%
REM Выводит ярлыки на рабочий стол (32-64 bit)
start "%commander_path%\Plugins\TC utilits\CreateTCLinks.vbs"
REM Ассоциировать все архивы со встроенным 7z
regedit -s "%commander_path%\Plugins\wcx\Total7zip\extra\associations-7zip.reg"
REM Добавить PEStudio в контекстное меню
REM regedit -s "%commander_path%\Programm\Developer\PeStudio\PeStudioIntoExplorerContextMenu.reg"
REM Ammy Admin установка в системную директорию с выводом ярлыков
start "%commander_path%\Programm\Network\ammy\install.cmd"
REM Тихая установка TOR 
REM start "%commander_path%\Programm\Network\TOR\TorBrowser.exe /S"

REM Установка пользовательских программ в %programfiles%
REM Lightshot
xcopy /S /E /Y "%commander_path%\Programm\User\LightShot\*.*" "%Programfiles%\LightShot\"
cd %inst%
REM ImgBurn
xcopy /S /E /Y "%commander_path%\Programm\User\ImgBurn\*.*" "%Programfiles%\ImgBurn\"
cd %inst%
REM Aida64Extreme
xcopy /S /E /Y "%commander_path%\Programm\Tests\Aida64Extreme\*.*" "%Programfiles%\Aida64Extreme\"
cd %inst%
REM Enable TConsole sound
REM regedit -s "%commander_path%\Plugins\wfx\TConsole\TConsoleSound.reg"
REM VirtualDisk driver inst
REM regedit -s "%commander_path%\Plugins\wfx\VirtualDisk\VD_Driver\install.cmd"

REM C0de by Y0mO_o