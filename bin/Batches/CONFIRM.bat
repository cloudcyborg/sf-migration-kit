:CONFIRM

	SET testClasses=%~1
	SET confirmMsg=%~2
	SET usingTestClass=No
	SET orgs=%~4
	
	IF %testClasses% == y (
		SET usingTestClass=Yes
	)
	
	CLS
	SET headerString="Confirm"
	CALL Batches\MENUHEADER.bat %headerString%
	ECHO         %confirmMsg%
	ECHO.
	ECHO.
	CALL Batches\DISPLAY_SELECTED_ORGS.bat "%orgs%"
	ECHO.                
	ECHO         Test classes   
	ECHO.        Specified?     : %usingTestClass%
	ECHO.
	

	SET /P option=Press y to proceed. Press any other key to go back:  
		
	IF %option% == y (
		SET "%~3=1"
	)
	IF %option% NEQ y (
		SET "%~3=0"
	)
	
GOTO:EOF