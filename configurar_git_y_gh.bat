@echo off
setlocal
title Configuracion Inicial de Git y GitHub

:: 1. Detectar ruta del USB
set "USB_ROOT=%~dp0"
if "%USB_ROOT:~-1%"=="\" set "USB_ROOT=%USB_ROOT:~0,-1%"

:: 2. Configurar entorno portable para esta sesion
set "DATA_DIR=%USB_ROOT%\data"
set "HOME=%DATA_DIR%"
set "USERPROFILE=%DATA_DIR%"
set "GH_CONFIG_DIR=%DATA_DIR%\gh_config"
set "PATH=%USB_ROOT%\jdk\bin;%USB_ROOT%\git\cmd;%USB_ROOT%\git\bin;%USB_ROOT%\gh\bin;%PATH%"

echo ====================================================
echo    CONFIGURACION DE GIT Y GITHUB (PORTABLE)
echo ====================================================
echo.

:: --- CONFIGURACION DE GIT ---
set /p "GIT_NAME=Introduce tu Nombre (ej: Juan Perez): "
set /p "GIT_EMAIL=Introduce tu Email (ej: juan@example.com): "

echo.
echo [+] Configurando Git globalmente en el USB...
git config --global user.name "%GIT_NAME%"
git config --global user.email "%GIT_EMAIL%"
git config --global core.autocrlf true

echo.
echo [OK] Git configurado:
git config --global user.name
git config --global user.email
echo.

:: --- CONFIGURACION DE GITHUB CLI ---
echo ====================================================
echo.
echo ¿Quieres iniciar sesion en GitHub ahora? (S/N)
set /p "LOGIN_GH="

if /i "%LOGIN_GH%"=="S" (
    echo [+] Iniciando proceso de autenticacion de GitHub CLI...
    echo [!] Sigue las instrucciones en el navegador.
    gh auth login
)

echo.
echo ====================================================
echo    CONFIGURACION FINALIZADA
echo ====================================================
echo Ahora puedes cerrar esta ventana y usar 'Iniciar_Entorno.bat'.
echo.
pause
exit
