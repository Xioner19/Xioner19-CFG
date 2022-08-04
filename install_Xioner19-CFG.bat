@ECHO OFF
Title Xioner19 CFG Installer
SET projectname=Xioner19-CFG

ECHO.&&ECHO.
ECHO                     [1mgithub.com/xioner19/%projectname%[0m
ECHO.&&ECHO.


REG QUERY "HKEY_CURRENT_USER\Software\Valve\Steam">NUL 2>NUL
IF ERRORLEVEL 1 GOTO NOREG

FOR /F "tokens=2* skip=2" %%a IN ('REG QUERY "HKEY_CURRENT_USER\Software\Valve\Steam" /v "SteamPath"') DO SET csgo=%%b



:CHECKDIR
SET "csgo=%csgo%/steamapps/common/counter-strike global offensive/"
IF NOT EXIST "%csgo%/csgo/" GOTO NODIR

ECHO Found game directory:
ECHO %csgo%
ECHO.
IF EXIST "%csgo%/csgo/cfg/autoexec.cfg" ( ECHO [1mUpdating files...[0m ) ELSE ( [1mECHO Installing...[0m )
ECHO.

CD /d %csgo%
ECHO [90m===============================================================================
curl -L -o xioner19.bat.tar.gz https://codeload.github.com/Xioner19/%projectname%/tar.gz/refs/heads/main


:DOWNLOADING
TASKLIST /fi "IMAGENAME eq curl.exe" >NUL
IF ERRORLEVEL 1 TIMEOUT /t 1 & GOTO DOWNLOADING

tar -xzf xioner19.bat.tar.gz --strip=1 %projectname%-main/csgo && DEL xioner19.bat.tar.gz
ECHO ===============================================================================[0m
ECHO.
ECHO [92mSuccess![0m
ECHO.
ECHO Press any key to exit...
PAUSE >NUL
GOTO:EOF

:NODIR
ECHO.
ECHO [91mERROR:[0m Could not find game directory at:
ECHO        %csgo%
ECHO.
ECHO Please enter your CS:GO Steam library directory: (E.g. '[1mD:/Steam Games[0m')
SET /p csgo=[7m^>: 
ECHO [0m
GOTO CHECKDIR

:NOREG
ECHO.
ECHO [91mERROR[0m: Could not find Steam installation!
ECHO.
ECHO Press any key to exit...
PAUSE >NUL
GOTO:EOF
