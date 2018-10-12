:OPT_FOR_BACKUP
	CLS
	SET headerString="Backup or Retrieve?"
	CALL Batches\MENUHEADER.bat %headerString%
	
	ECHO.
	ECHO                1 - Retrieve
	ECHO.
	ECHO                2 - Backup
	ECHO.                
	ECHO.
	
	SET /P valOption=Type your choice number then press ENTER: 
	
	
	IF %valOption% == 1 (
		SET "%~1=0"
		GOTO:EOF
	)
	
	IF %valOption% == 2 (
		SET "%~1=1"
		GOTO:EOF
	)
	
	CALL Batches\INVALID_INPUT.bat
	
GOTO:OPT_FOR_BACKUP