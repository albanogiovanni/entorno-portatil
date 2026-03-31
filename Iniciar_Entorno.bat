@echo off
setlocal
title Entorno de Desarrollo Portable (IntelliJ + Git + GitHub CLI)

:: 1. Detectar ruta del USB
set "USB_ROOT=%~dp0"
if "%USB_ROOT:~-1%"=="\" set "USB_ROOT=%USB_ROOT:~0,-1%"

:: 2. Definir rutas críticas
set "JAVA_HOME=%USB_ROOT%\jdk"
set "GIT_DIR=%USB_ROOT%\git"
set "GH_DIR=%USB_ROOT%\gh"
set "GRADLE_USER_HOME=%USB_ROOT%\data\gradle"
set "DATA_DIR=%USB_ROOT%\data"
set "GH_CONFIG_DIR=%DATA_DIR%\gh_config"

:: 3. Aislamiento Total (Redirigir carpetas de usuario al USB)
set "HOME=%DATA_DIR%"
set "USERPROFILE=%DATA_DIR%"
set "APPDATA=%DATA_DIR%\AppData\Roaming"
set "LOCALAPPDATA=%DATA_DIR%\AppData\Local"

:: 4. Configurar el PATH (Inyectar herramientas del USB)
:: Nota: Incluimos tanto la raíz de gh como su subcarpeta 'bin' por si acaso
set "PATH=%JAVA_HOME%\bin;%GIT_DIR%\cmd;%GIT_DIR%\bin;%GIT_DIR%\usr\bin;%GH_DIR%\bin;%GH_DIR%;%PATH%"

:: 5. Verificación básica en consola
echo ==========================================
echo    ENTORNO PORTABLE INICIADO
echo ==========================================
echo  JAVA:   %JAVA_HOME%
echo  GRADLE: %GRADLE_USER_HOME%
echo  GITHUB: %GH_CONFIG_DIR%
echo ==========================================

:: 6. Lanzar IntelliJ IDEA
cd /d "%USB_ROOT%\intellij\bin"
start "" "idea64.exe"

exit
