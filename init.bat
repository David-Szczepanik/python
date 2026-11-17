@echo off
setlocal
cd /d "%~dp0"

where uv >nul 2>nul
if errorlevel 1 (
    echo uv not installed:
    echo   powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    goto fail
)

if not exist pyproject.toml (
    uv init --bare --name python || goto fail
)

uv add jupyterlab ipykernel || goto fail

if not exist notebooks mkdir notebooks

echo.
echo uv run jupyter lab notebooks
pause
exit /b 0

:fail
echo.
echo Err
pause
exit /b 1
