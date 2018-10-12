:SEARCH_PACKAGE_XML	
	CLS
	SET packageDir=%~1
	SET currentDir=%cd%
	CD /d %packageDir%

	DIR /b package.xml
	CLS
	IF %ERRORLEVEL% NEQ 0 (
		ECHO ERROR: package.xml is not present in this folder
		PAUSE
		EXIT
	)
	CD /d %currentDir%
GOTO:EOF