@echo off
:INIT
mode con: cols=140 lines=2500

SET migOption="%~1"
SET batchFolder=%~dp0
SET pkgFolder=%cd%
CD %batchFolder%\bin

IF %migOption% == "retrieve" (
	CALL Batches\SEARCH_PACKAGE_XML.bat "%pkgFolder%"
	CALL Retrieve.bat "%pkgFolder%" 
) 

IF %migOption% == "deploy" (
	CALL Batches\SEARCH_PACKAGE_XML.bat "%pkgFolder%"
	CALL ValidateOrDeploy.bat "%pkgFolder%"
) 

IF %migOption% == "migrate" (
	CALL Batches\SEARCH_PACKAGE_XML.bat "%pkgFolder%"
	CALL Migrate.bat "%pkgFolder%"
) 