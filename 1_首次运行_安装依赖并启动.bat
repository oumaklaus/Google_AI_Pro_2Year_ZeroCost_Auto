@echo off
chcp 936 >nul
title Google AI Pro (5 TB) Zero-Cost 2-Year Console - Setup and Launch
cd /d "%~dp0"
echo ======================================================================
echo   Checking and installing Python dependencies (fastapi, uvicorn, playwright)...
echo ======================================================================
python -m pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
echo.
echo ======================================================================
echo   Starting the web console (http://127.0.0.1:8765) ...
echo ======================================================================
start "" "http://127.0.0.1:8765"
python app.py
pause
