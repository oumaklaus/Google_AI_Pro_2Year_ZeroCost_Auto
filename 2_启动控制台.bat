@echo off
chcp 936 >nul
title Google AI Pro (5 TB) Zero-Cost 2-Year Console
cd /d "%~dp0"
echo ======================================================================
echo   Starting the Google AI Pro (5 TB) Zero-Cost 2-Year Console...
echo   Console URL: http://127.0.0.1:8765
echo ======================================================================
start "" "http://127.0.0.1:8765"
python app.py
pause
