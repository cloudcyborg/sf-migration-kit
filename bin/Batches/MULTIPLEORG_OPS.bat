:MULTIPLE_ORGS
	CLS
	SETLOCAL enableDelayedExpansion
	SET orgchoice=%~1
	SET option=%~2
	SET pfol=%~3

	SET n=0
	FOR /F "tokens=1,2,3,4 delims=," %%a in (../orgs/orgs.csv) DO (
		IF !n! NEQ 0 (
			SET nameArray[!n!]=%%a %%b %%c %%d			 
		)
		SET /a n+=1			
	)
	
	FOR %%o IN (%orgchoice%) DO (	
		IF %%o GTR 0 (
			IF %%o LSS !n! (
				
				SET org=!nameArray[%%o]!
				
				FOR /F "tokens=1,2,3,4 delims= " %%g in ("!org!") DO (
					SET orgname=%%g
					SET org_username=%%h
					SET org_password=%%i
					SET org_url=%%j
				)
				
				CALL :ANT_OP %option% "%pfol%" !orgname! !org_username! !org_password! !org_url!
				
			)
			
			IF %%o GTR !n! (
				ECHO.
				ECHO ****************************************
				ECHO ERROR: No org associated with this choice : %%o
				ECHO ****************************************
				ECHO.
			)
		)
		IF %%o LSS 1 (
			ECHO.
			ECHO ****************************************
			ECHO ERROR: No org associated with this choice : %%o
			ECHO ****************************************
			ECHO.
		)	
	)	
	ENDLOCAL
GOTO:EOF


:ANT_OP
SETLOCAL
SET option=%~1
SET pkgFolder=%~2
SET name=%~3
SET uname=%~4
SET pw=%~5
SET url=%~6

SET tmStamp=0
CALL Batches\GETTIMESTAMP.bat tmStamp

IF %option% == backup (
	ECHO.
	ECHO ****************************************
	ECHO Backing up  from %name% ...
	ECHO ****************************************
	ECHO.

	ant backup_from_org -DDirectory="%pkgFolder%" -DOrgname="%name%" -DUsername="%uname%" -DPassword="%pw%" -DUrl="%url%" -DTstamp="%tmStamp%"
)
IF %option% == retrieve (
	ECHO.
	ECHO ****************************************
	ECHO Retrieving from %name% ...
	ECHO ****************************************
	ECHO.
	ant retrieve_from_org -DDirectory="%pkgFolder%" -DOrgname="%name%" -DUsername="%uname%" -DPassword="%pw%" -DUrl="%url%"
)

IF %option% == validate (
	ECHO.
	ECHO ****************************************
	ECHO Validating on %name% ...
	ECHO ****************************************
	ECHO.
	ant validate_without_test_provided -DDirectory="%pkgFolder%" -DtStamp="%tmStamp%" -DOrgName="%orgname%" -DUsername="%org_username%" -DPassword="%org_password%" -DUrl="%org_url%"
)

IF %option% == tvalidate (
	
	SET tests=""
	CALL Batches\GETTESTS.bat tests "%pkgFolder%"
	
	ECHO.
	ECHO ****************************************
	ECHO Validating on %name% ...
	ECHO ****************************************
	ECHO.
	ant validate_with_test_provided -DDirectory="%pkgFolder%" -DtStamp="%tmStamp%" -DOrgName="%name%" -DUsername="%uname%" -DPassword="%pw%" -DUrl="%url%" -DTestClassNames="!tests!"
)

IF %option% == deploy (
	ECHO.
	ECHO ****************************************
	ECHO Deploying on %name% ...
	ECHO ****************************************
	ECHO.
	ant deploy_without_test_provided -DDirectory="%pkgFolder%" -DtStamp="%tmStamp%" -DOrgName="%name%" -DUsername="%uname%" -DPassword="%pw%" -DUrl="%url%"
)

IF %option% == tdeploy (
	SET tests=""
	CALL Batches\GETTESTS.bat tests "%pkgFolder%"
	
	ECHO.
	ECHO ****************************************
	ECHO Deploying on %name% ...
	ECHO ****************************************
	ECHO.

	ant deploy_with_test_provided -DDirectory="%pkgFolder%" -DtStamp="%tmStamp%" -DOrgName="%name%" -DUsername="%uname%" -DPassword="%pw%" -DUrl="%url%" -DTestClassNames="!tests!"
)

ENDLOCAL
GOTO:EOF

	