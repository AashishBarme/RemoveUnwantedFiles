@echo off
set "batchRoot=%~dp0"
set "scriptPath=\Logic\Run.ps1"
set "sPath=%batchRoot%%scriptPath%"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%sPath%'"
pause