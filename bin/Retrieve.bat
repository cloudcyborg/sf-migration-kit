:RETRIEVE_FROM_ORG
	
	SET pkgFolder=%~1
	
	SET backupOption=0
	CALL Batches\OPT_FOR_BACKUP.bat backupOption
	
	SET headerString="Retrieve/backup from Which org?"

	CALL Batches\DISPLAY_ORGS.bat %headerString%
	
	SET /P orgChoice=Enter your choice: 
	
	IF %ERRORLEVEL% == 0 (
		IF %backupOption% == 0 (
		
			CALL Batches\PREVENT_MULTIPLE_ORGS.bat "%orgChoice%"
			CALL Batches\MULTIPLEORG_OPS.bat %orgChoice% retrieve "%pkgFolder%"
		)
		
		IF %backupOption% == 1 (		
			CALL Batches\MULTIPLEORG_OPS.bat "%orgChoice%" backup "%pkgFolder%"
		)
		PAUSE
	)
GOTO:EOF