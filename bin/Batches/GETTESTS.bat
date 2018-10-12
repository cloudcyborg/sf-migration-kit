:GETTESTS
	SETLOCAL 
	SET rowCount=0
	SET packageDir=%~2
	SET currentDir=%cd%
	CD /d %packageDir%
	
	FOR /f "tokens=1" %%a IN (run.tests) DO (
		SET tnames=%%a
		SET /a rowCount+=1
	)
	
	IF %rowCount% GTR 1 (
		ECHO Your tests file needs to have only a single row of test class names.
		PAUSE.
		EXIT
	)
	
	IF %rowCount% == 0 (
		ECHO Your tests file doesnt contain any tests.
		PAUSE.
		EXIT
	)
	CD /d %currentDir%
	ENDLOCAL & SET "%~1=%tnames%"

GOTO:EOF
	
    