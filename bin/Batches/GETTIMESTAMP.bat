:GETTIMESTAMP
	FOR /F "tokens=2" %%i IN ('date /t') DO SET dateVal=%%i

	SET DATESTAMP=%dateVal:~0,2%-%dateVal:~3,2%-%dateVal:~6,4%
	SET TIMESTAMP=%TIME:~0,2%;%TIME:~3,2%;%TIME:~6,2%

	SET DATEANDTIME=%DATESTAMP%, %TIMESTAMP%
	SET "%~1=%DATEANDTIME%"

GOTO:EOF