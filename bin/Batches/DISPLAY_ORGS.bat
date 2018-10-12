:DISPLAY_ORGS
	CLS
	SET headerString="%~1"
	
	CALL Batches\MENUHEADER.bat %headerString%
	
	SETLOCAL enableDelayedExpansion
	
	SET n=0
	FOR /F "tokens=1,2,3,4 delims=," %%a in (../orgs/orgs.csv) DO (
		IF !n! NEQ 0 (
			SET nameArray[!n!]=%%a %%b %%c %%d
			ECHO                !n! - %%a
			ECHO.				 
		)
		SET /a n+=1			
	)
	ENDLOCAL
GOTO:EOF