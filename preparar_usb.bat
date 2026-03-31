@echo off
setlocal enabledelayedexpansion
title Preparación Inicial del USB Portable

:: --- CONFIGURACIÓN DE NOMBRES ---
set "ZIP_IDEA=intellij.zip"
set "ZIP_GIT=git.zip"
set "ZIP_JDK=jdk.zip"
set "ZIP_GH=gh.zip"

echo ====================================================
echo    ASISTENTE DE PREPARACION - ENTORNO PORTABLE
echo ====================================================
echo.

:: 1. Crear estructura de directorios
echo [+] Creando estructura de carpetas...
for %%d in (intellij git jdk gh workspace data\idea data\gradle data\gh_config) do (
    if not exist "%%d" mkdir "%%d"
)

:: 2. Función de descompresión
echo.
if exist "%ZIP_IDEA%" (
    echo [+] Descomprimiendo IntelliJ IDEA...
    powershell -command "Expand-Archive -Path '%ZIP_IDEA%' -DestinationPath 'intellij' -Force"
)
if exist "%ZIP_GIT%" (
    echo [+] Descomprimiendo Git Portable...
    powershell -command "Expand-Archive -Path '%ZIP_GIT%' -DestinationPath 'git' -Force"
)
if exist "%ZIP_JDK%" (
    echo [+] Descomprimiendo JDK...
    powershell -command "Expand-Archive -Path '%ZIP_JDK%' -DestinationPath 'jdk' -Force"
)
if exist "%ZIP_GH%" (
    echo [+] Descomprimiendo GitHub CLI...
    powershell -command "Expand-Archive -Path '%ZIP_GH%' -DestinationPath 'gh' -Force"
)

:: 3. Parche automático de idea.properties
echo.
echo [+] Aplicando configuracion de rutas relativas en IntelliJ...
set "PROP_FILE=intellij\bin\idea.properties"
if exist "%PROP_FILE%" (
    powershell -command "(Get-Content '%PROP_FILE%') -replace '# idea.config.path=', 'idea.config.path=${idea.home.path}/../data/idea/config' -replace '# idea.system.path=', 'idea.system.path=${idea.home.path}/../data/idea/system' -replace '# idea.plugins.path=', 'idea.plugins.path=${idea.home.path}/../data/idea/plugins' -replace '# idea.log.path=', 'idea.log.path=${idea.home.path}/../data/idea/log' | Set-Content '%PROP_FILE%'"
    echo [OK] Archivo idea.properties configurado.
)

echo.
echo [!] NOTA: GitHub CLI suele extraerse en una subcarpeta (ej: gh_2.x.x_windows_amd64).
echo     Para que el lanzador funcione, mueve el contenido de esa subcarpeta directamente a la carpeta 'gh' del USB.
echo.
echo ====================================================
echo    PROCESO COMPLETADO
echo ====================================================
pause
exit
