:SEARCH_TEST_FILE

	SET packageDir=%~1
	SET currentDir=%cd%
	
	CD /d %packageDir%
	
	DIR /b run.tests	
	IF %ERRORLEVEL% NEQ 0 (
		CLS
		ECHO ERROR: test file is not present in this folder
		PAUSE
		EXIT
	)
	CD /d %currentDir%	

GOTO:EOF