@ECHO Off
SETLOCAL EnableDelayedExpansion

SET fileName="*.log"
SET filesCount=0
SET filesSize=0
SET sizeFormatted=bytes

ECHO Searching for %fileName% files...

:: Loop through files (recurse subfolders) to find all files by filename mask
FOR /R . %%i IN (%fileName%) DO CALL :DeleteFile "%%i"

:: Get human readable format by splitting number by digits
:: e.g. "42 155 075" insted of "42155075"
FOR %%i IN (1 1000 1000000 1000000000) DO (
	SET /A chunk=%filesSize%/%%i
	SET chunk=!chunk:~-3!
	IF !chunk! EQU 0 IF %%i EQU 1 SET sizeFormatted=0 bytes
	IF !chunk! GTR 0 SET sizeFormatted=!chunk! !sizeFormatted!
)

ECHO __________________________________________________
ECHO Found files count: %filesCount%; size: %sizeFormatted%
ECHO.
ECHO Press any key to exit...
PAUSE > nul
EXIT

:DeleteFile
SET /A filesCount+=1
SET /A filesSize+=%~z1
ECHO %1
DEL %1
