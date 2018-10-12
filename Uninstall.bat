@echo off
:UNINSTALL

ECHO Deleting registry entries...

REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SFRetrieve /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SFDeploy /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SFMigrate /f

IF %ERRORLEVEL% NEQ 0 (
	CLS
	ECHO Error uninstalling the tool. You need to run this batch file as an admin.
	PAUSE
	EXIT
)

REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\Background\shell\SFMigration /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\LibraryFolder\background\shell\SFMigration /f

REG DELETE HKEY_CURRENT_USER\Software\Classes\LibraryFolder\background\shell\SFMigration  /f
REG DELETE HKEY_CURRENT_USER\Software\Classes\directory\background\shell\SFMigration /f

CLS
ECHO Registries deleted. Now removing the files..
PAUSE

CD %~dp0
RMDIR bin /S /Q
DEL /Q *.*

CLS
ECHO Uninstalled successfully. Press any key to exit.
PAUSE





