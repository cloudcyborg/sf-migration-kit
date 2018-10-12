SETLOCAL enableDelayedExpansion
SET org=%~1

SET n=0
FOR /F "tokens=1,2,3,4 delims=," %%a in (../orgs/orgs.csv) DO (
	IF !n! NEQ 0 (
		SET nameArray[!n!]=%%a
					 
	)
	SET /a n+=1			
)

SET x=1
FOR %%m IN (%org%) DO (
	IF %%m GTR 0 (
		IF %%m LSS !n! (
			ECHO         !x! - !nameArray[%%m]!
			ECHO.
			SET /a x+=1
		)		
	)
)

ENDLOCAL
GOTO:EOF

