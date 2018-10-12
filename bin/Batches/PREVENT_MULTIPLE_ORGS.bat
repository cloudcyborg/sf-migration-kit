:PREVENT_MULTIPLE_ORGS
	SETLOCAL
	SET choices=%~1
	SET orgCount=0
	
	FOR %%c IN (%choices%) DO (
		SET test=%%c	
		SET /a orgCount +=1	
	)
	
	IF %orgCount% GTR 1 (
		ECHO.
		ECHO ERROR: You cannot perform this operation on multiple orgs.
		PAUSE
		EXIT
	)

	ENDLOCAL
GOTO:EOF