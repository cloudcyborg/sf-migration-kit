SETLOCAL enableDelayedExpansion
SET orgchoice=%~1
SET n=0
FOR /F "tokens=1,2,3,4 delims=," %%a in (../orgs/orgs.csv) DO (
	SET /a n+=1			
)

FOR %%o IN (%orgchoice%) DO (
	IF %%o LSS 1 (
		CLS
		ECHO ERROR: No org associated with this choice : %%o
		ECHO.
		PAUSE
		EXIT
	)
	
	IF %%o GTR !n! (
		CLS
		ECHO ERROR: No org associated with this choice : %%o
		ECHO.
		PAUSE
		EXIT
	)
)
ENDLOCAL