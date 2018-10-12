:VALIDATE_OR_DEPLOY
	
	SET pkgFolder=%~1
	
	:START
	SET validateOption=0
	CALL Batches\OPT_FOR_VALIDATION.bat validateOption
	
	CLS
	SET pDir=%~1
	
	
	SET headerString="Select your org"
	CALL Batches\DISPLAY_ORGS.bat %headerString%
	
	SET /P orgChoice=Enter your choice: 
	CALL Batches\VALIDATE_ORG_CHOICE.bat "%orgChoice%"
	
	SET /P testClassOption=Test classes specified?(y/n): 
	
	IF %testClassOption% NEQ n (
		IF %testClassOption% NEQ y (
			CALL Batches\INVALID_INPUT.bat
			GOTO:START
		)
		CALL Batches\SEARCH_TEST_FILE.bat "%pkgFolder%"
	)
	
	SET confirmMsg=""	
	
	IF %validateOption% == 1 (
		SET confirmMsg="You are validating on the orgs below:"
	)
	
	IF %validateOption% == 0 (
		SET confirmMsg="You are deploying to the orgs below:"
	)
	
	
	SET confirmVar=0
	CALL Batches\CONFIRM.bat %testClassOption% %confirmMsg% confirmVar "%orgChoice%"
	
	
	IF %confirmVar%==0 (
		GOTO:START
	)
	IF %confirmVar%==1 (		

		IF %validateOption% == 1 (
			
			IF %testClassOption% == n (				
				CALL Batches\MULTIPLEORG_OPS.bat "%orgChoice%" validate "%pkgFolder%"
			)
			IF %testClassOption% == y (
				CALL Batches\MULTIPLEORG_OPS.bat "%orgChoice%" tvalidate "%pkgFolder%"
			)
		)
		
		IF %validateOption% == 0 (
		
			IF %testClassOption% == n (				
				CALL Batches\MULTIPLEORG_OPS.bat "%orgChoice%" deploy "%pkgFolder%" 		
			)
			IF %testClassOption% == y (
				CALL Batches\MULTIPLEORG_OPS.bat "%orgChoice%" tdeploy "%pkgFolder%"
			)
		)		
		PAUSE

	)
	
GOTO:EOF