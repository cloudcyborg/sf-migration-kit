@echo off
:MIGRATE
	SET pkgFolder=%~1
	
	:START	
	SET headerString="Retrieve from Which org?"
	CALL Batches\DISPLAY_ORGS.bat %headerString%
	
	SET /P srcOrg=Enter your choice: 
	CALL Batches\PREVENT_MULTIPLE_ORGS.bat "%srcOrg%"
	
	SET headerString="Deploy to which org?"
	CALL Batches\DISPLAY_ORGS.bat %headerString%
	
	SET /P destOrg=Enter your choice: 
	CALL Batches\PREVENT_MULTIPLE_ORGS.bat "%destOrg%"
	
	SET validateOption=0
	CALL Batches\OPT_FOR_VALIDATION.bat validateOption
	
	ECHO.
	SET /P testClassOption=Test classes specified?(y/n): 
	
	IF %testClassOption% NEQ n (
		IF %testClassOption% NEQ y (
			CALL Batches\INVALID_INPUT.bat
			GOTO:START
		)
		CALL Batches\SEARCH_TEST_FILE.bat "%pkgFolder%"
	)
	
	SETLOCAL enableDelayedExpansion

	IF %ERRORLEVEL% == 0 (	
		
		CALL Batches\MULTIPLEORG_OPS.bat %srcOrg% retrieve "%pkgFolder%"
		
		IF %validateOption% == 1 (
			IF %testClassOption% == n (
				CALL Batches\MULTIPLEORG_OPS.bat "%destOrg%" validate "%pkgFolder%"
			)
			IF %testClassOption% == y (
				CALL Batches\MULTIPLEORG_OPS.bat "%destOrg%" tvalidate "%pkgFolder%"
			)
		)
		
		IF %validateOption% == 0 (
			ECHO.
			SET /P backupOption="Do you want a backup of target org? (y/n):"
			
			IF !backupOption! == y (
				CALL Batches\MULTIPLEORG_OPS.bat "%destOrg%" backup "%pkgFolder%"
			)			
			IF %testClassOption% == n (
				CALL Batches\MULTIPLEORG_OPS.bat "%destOrg%" deploy "%pkgFolder%"
			)
			IF %testClassOption% == y (
				CALL Batches\MULTIPLEORG_OPS.bat "%destOrg%" tdeploy "%pkgFolder%"
			)
		)
		
		PAUSE
	)
	ENDLOCAL
GOTO:EOF