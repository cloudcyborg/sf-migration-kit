@echo off
:INSTALLDIR

SET installFolder=%~dp0
CLS

REM /* COMMANDS */
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SFRetrieve /f /d "Retrieve"
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SFRetrieve\command /f /d "%installFolder%Init.bat retrieve"

REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SFDeploy /f /d "Deploy"
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SFDeploy\command /f /d "%installFolder%Init.bat deploy"

REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SFMigrate /f /d "Migrate"
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SFMigrate\command /f /d "%installFolder%Init.bat migrate"

IF %ERRORLEVEL% NEQ 0 (
	CLS
	ECHO Please run this file as an administrator.
	PAUSE
	EXIT
)

CLS
SET /P allusers=Do you want to install for all users? (y/n): 

IF %allusers% == y (
	ECHO.
	ECHO Installing for all users...

	REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\Background\shell\SFMigration /f /v "MUIVerb" /t REG_SZ /d "SF Migration"
	REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\Background\shell\SFMigration /f /v "icon" /t REG_SZ /d "%installFolder%SF.ico"
	REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\Background\shell\SFMigration /f /v "SubCommands" /t REG_SZ /d "SFRetrieve;SFDeploy;SFMigrate"

	REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\LibraryFolder\background\shell\SFMigration /f /v "MUIVerb" /t REG_SZ /d "SF Migration"
	REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\LibraryFolder\background\shell\SFMigration /f /v "icon" /t REG_SZ /d "%installFolder%SF.ico"
	REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\LibraryFolder\background\shell\SFMigration /f /v "SubCommands" /t REG_SZ /d "SFRetrieve;SFDeploy;SFMigrate"
)

IF %allusers% NEQ y (
	ECHO.
	ECHO Installing for current user only...
	
	REG ADD HKEY_CURRENT_USER\Software\Classes\LibraryFolder\background\shell\SFMigration /f /v "MUIVerb" /t REG_SZ /d "SF Migration"
	REG ADD HKEY_CURRENT_USER\Software\Classes\LibraryFolder\background\shell\SFMigration /f /v "icon" /t REG_SZ /d "%installFolder%SF.ico"
	REG ADD HKEY_CURRENT_USER\Software\Classes\LibraryFolder\background\shell\SFMigration /f /v "SubCommands" /t REG_SZ /d "SFRetrieve;SFDeploy;SFMigrate"
	
	REG ADD HKEY_CURRENT_USER\Software\Classes\directory\background\shell\SFMigration /f /v "MUIVerb" /t REG_SZ /d "SF Migration"
	REG ADD HKEY_CURRENT_USER\Software\Classes\directory\background\shell\SFMigration /f /v "icon" /t REG_SZ /d "%installFolder%SF.ico"
	REG ADD HKEY_CURRENT_USER\Software\Classes\directory\background\shell\SFMigration /f /v "SubCommands" /t REG_SZ /d "SFRetrieve;SFDeploy;SFMigrate"
)

IF %ERRORLEVEL% == 0 (
	ECHO Installation Completed.
)
IF %ERRORLEVEL% NEQ 0 (
	ECHO Installation failed. You must run this file as an administrator.
)
PAUSE





