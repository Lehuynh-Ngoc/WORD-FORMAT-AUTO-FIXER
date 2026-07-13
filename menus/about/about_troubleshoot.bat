@echo off
setlocal enabledelayedexpansion
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "C_CYA=%ESC%[36m"
set "C_YLW=%ESC%[33m"
set "C_GRN=%ESC%[32m"
set "C_RED=%ESC%[31m"
set "C_GRY=%ESC%[90m"
set "C_WHT=%ESC%[37m"
set "C_BLD=%ESC%[1m"
set "C_RST=%ESC%[0m"

:menu
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%         13. XU LY LOI PHO BIEN                       %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon loai loi de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Loi cai dat / run.bat
echo %C_YLW%  2.%C_RST% Loi format / preview
echo %C_YLW%  3.%C_RST% Loi clone
echo %C_YLW%  4.%C_RST% Loi AI (translate, generate, settings)
echo %C_YLW%  5.%C_RST% Loi test / code
echo %C_YLW%  6.%C_RST% Loi Windows / bat file
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto :caidat
if "%SUB%"=="2" goto :format
if "%SUB%"=="3" goto :clone
if "%SUB%"=="4" goto :ai
if "%SUB%"=="5" goto :code
if "%SUB%"=="6" goto :windows
if "%SUB%"=="0" exit /b
goto :menu

:caidat
cls
echo.
echo %C_CYA%--- LOI CAI DAT / RUN.BAT ---%C_RST%
echo.
echo %C_RED%  1. "python is not recognized"%C_RST%
echo  %C_GRY%-%C_RST% Chua cai Python hoac khong them vao PATH
echo  %C_GRY%-%C_RST% Cai Python 3.10+ tu python.org
echo  %C_GRY%-%C_RST% Tick "Add Python to PATH" khi cai
echo  %C_GRY%-%C_RST% Kiem tra: %C_WHT%python --version%C_RST%
echo.
echo %C_RED%  2. "pip is not recognized"%C_RST%
echo  %C_GRY%-%C_RST% Dung: %C_WHT%python -m pip install -r requirements.txt%C_RST%
echo.
echo %C_RED%  3. "ModuleNotFoundError: No module named 'docx'"%C_RST%
echo  %C_GRY%-%C_RST% Chua cai requirements
echo  %C_GRY%-%C_RST% Chay: %C_WHT%pip install -r requirements.txt%C_RST%
echo.
echo %C_RED%  4. "Access is denied" (run.bat)%C_RST%
echo  %C_GRY%-%C_RST% Chuot phai -> Run as administrator
echo  %C_GRY%-%C_RST% Hoac cai dat o thu muc khong can admin
echo.
echo %C_RED%  5. run.bat khong hien thi mau%RST%
echo  %C_GRY%-%C_RST% Windows Terminal ho tro ANSI colors
echo  %C_GRY%-%C_RST% cmd.exe cu co the khong ho tro
echo  %C_GRY%-%C_RST% Dung Windows Terminal hoac VS Code terminal
echo.
pause
goto :menu

:format
cls
echo.
echo %C_CYA%--- LOI FORMAT / PREVIEW ---%C_RST%
echo.
echo %C_RED%  1. "File not found"%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra lai duong dan file
echo  %C_GRY%-%C_RST% Dung quotes: %C_WHT%format "D:\files\doc.docx"%C_RST%
echo  %C_GRY%-%C_RST% Dung slash nghich (/) hoac backslash (\)
echo.
echo %C_RED%  2. "No rules matched"%C_RST%
echo  %C_GRY%-%C_RST% Style name khong trung khop
echo  %C_GRY%-%C_RST% Kiem tra ten style: %C_WHT%list-rules%C_RST%
echo  %C_GRY%-%C_RST% Dung preview truoc de kiem tra
echo.
echo %C_RED%  3. "File format not supported"%C_RST%
echo  %C_GRY%-%C_RST% Chi ho tro .doc va .docx
echo  %C_GRY%-%C_RST% Khong ho tro .pdf, .rtf, .odt
echo.
echo %C_RED%  4. "Output directory not found"%C_RST%
echo  %C_GRY%-%C_RST% Chua tao thu muc outputs/
echo  %C_GRY%-%C_RST% Chay: %C_WHT%python src/main.py init%C_RST%
echo.
echo %C_RED%  5. Format khong thay doi%RST%
echo  %C_GRY%-%C_RST% Rule conditions khong match style nao
echo  %C_GRY%-%C_RST% Dung preview de xem co thay doi gi khong
echo  %C_GRY%-%C_RST% Kiem tra file rule dung chua
echo.
pause
goto :menu

:clone
cls
echo.
echo %C_CYA%--- LOI CLONE ---%C_RST%
echo.
echo %C_RED%  1. "Cannot initialize Word COM"%C_RST%
echo  %C_GRY%-%C_RST% Can cai Microsoft Word tren Windows
echo  %C_GRY%-%C_RST% Word phai duoc kich hoat (khong phai trial)
echo  %C_GRY%-%C_RST% Dong tat ca Word truoc khi chay
echo.
echo %C_RED%  2. "COM busy / RPC_E_CALL_REJECTED"%C_RST%
echo  %C_GRY%-%C_RST% Tu dong retry 10 lan (delay tang dan)
echo  %C_GRY%-%C_RST% Neu van loi: dong tat ca Word, thu lai
echo  %C_GRY%-%C_RST% Khoi dong lai may neu can
echo.
echo %C_RED%  3. "Template not found"%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra template path dung chua
echo  %C_GRY%-%C_RST% File phai ton tai va mo duoc
echo.
echo %C_RED%  4. "Output format not supported"%C_RST%
echo  %C_GRY%-%C_RST% Chi ho tro: .doc, .docx, .dot, .dotx, .dotm, .pdf
echo  %C_GRY%-%C_RST% Dinh dang khac -> tu dong chuyen thanh .docx
echo.
pause
goto :menu

:ai
cls
echo.
echo %C_CYA%--- LOI AI (TRANSLATE, GENERATE, SETTINGS) ---%C_RST%
echo.
echo %C_RED%  1. "No active AI provider found"%C_RST%
echo  %C_GRY%-%C_RST% Chua setup API key
echo  %C_GRY%-%C_RST% Vao Menu 4 -> Quan ly provider -> Nhap key
echo  %C_GRY%-%C_RST% Kiem tra status: VALID hoac UNCHECKED
echo.
echo %C_RED%  2. "API key is invalid (401)"%C_RST%
echo  %C_GRY%-%C_RST% Key sai hoac het han
echo  %C_GRY%-%C_RST% Tao lai key tai trang cua provider
echo  %C_GRY%-%C_RST% Kiem tra: co them khoang trang/thua ky tu?
echo.
echo %C_RED%  3. "Rate limited (429)"%C_RST%
echo  %C_GRY%-%C_RST% Qua nhieu request -> cho 1-5 phut
echo  %C_GRY%-%C_RST% Chuyen sang provider khac (-p)
echo  %C_GRY%-%C_RST% Nang len plan cao hon
echo.
echo %C_RED%  4. "Connection error"%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra internet
echo  %C_GRY%-%C_RST% Kiem tra firewall / proxy
echo  %C_GRY%-%C_RST% VPN co the chan ket noi
echo  %C_GRY%-%C_RST% Kiem tra base URL dung chua
echo.
echo %C_RED%  5. "Batch count mismatch" (translate)%C_RST%
echo  %C_GRY%-%C_RST% Tu dong fallback sang dich tung doan
echo  %C_GRY%-%C_RST% Ket qua van dung nhung cham hon
echo.
echo %C_RED%  6. "Failed to parse AI response" (generate)%C_RST%
echo  %C_GRY%-%C_RST% AI tra ve khong phai JSON
echo  %C_GRY%-%C_RST% Thu lai voi model khac
echo.
pause
goto :menu

:code
cls
echo.
echo %C_CYA%--- LOI TEST / CODE ---%C_RST%
echo.
echo %C_RED%  1. Test that bai%RST%
echo  %C_GRY%-%C_RST% Chay: %C_WHT%python -m pytest tests/ -v%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra pass/failed cu the
echo  %C_GRY%-%C_RST% Doc error message de biet loi o dau
echo.
echo %C_RED%  2. "ModuleNotFoundError" khi import%RST%
echo  %C_GRY%-%C_RST% Chua cai requirements
echo  %C_GRY%-%C_RST% Chay: %C_WHT%pip install -r requirements.txt%C_RST%
echo.
echo %C_RED%  3. "AttributeError" trong source code%RST%
echo  %C_GRY%-%C_RST% Co the la model property, khong phai field
echo  %C_GRY%-%C_RST% Kiem tra: %C_WHT%p.model%C_RST% (property tra ve active model)
echo.
echo %C_RED%  4. Import error khi chay CLI%RST%
echo  %C_GRY%-%C_RST% Chay tu root: %C_WHT%python src/main.py ...%C_RST%
echo  %C_GRY%-%C_RST% Khong cd vao src/ roi chay
echo.
pause
goto :menu

:windows
cls
echo.
echo %C_CYA%--- LOI WINDOWS / BAT FILE ---%C_RST%
echo.
echo %C_RED%  1. run.bat crash khi chon menu%RST%
echo  %C_GRY%-%C_RST% KHONG dat goto ben trong if/else (...) block
echo  %C_GRY%-%C_RST% Dung goto cho flow control (khong dung if block)
echo  %C_GRY%-%C_RST% Cmd.exe bi crash neu goto trong nested block
echo.
echo %C_RED%  2. Khong hien thi mau ANSI%RST%
echo  %C_GRY%-%C_RST% Dung Windows Terminal (ho tro ANSI)
echo  %C_GRY%-%C_RST% cmd.exe cu co the khong ho tro
echo  %C_GRY%-%C_RST% PowerShell 5.1: ho tro ANSI
echo.
echo %C_RED%  3. "Access is denied"%RST%
echo  %C_GRY%-%C_RST% Chuot phai -> Run as administrator
echo  %C_GRY%-%C_RST% Hoac cai o thu muc khong can admin
echo.
echo %C_RED%  4. Duong dan qua dai%RST%
echo  %C_GRY%-%C_RST% Windows gioi han 260 ky tu (MAX_PATH)
echo  %C_GRY%-%C_RST% Dat project gan root: C:\wordfix\...
echo  %C_GRY%-%C_RST% Hoac bat Long Paths trong Windows
echo.
echo %C_RED%  5. File .doc khong mo duoc%RST%
echo  %C_GRY%-%C_RST% Can Microsoft Word da cai
echo  %C_GRY%-%C_RST% Word phai duoc kich hoat (khong phai trial)
echo  %C_GRY%-%C_RST% Dong tat ca Word truoc khi chay
echo.
echo %C_RED%  6. Vietnamese characters bi loi%RST%
echo  %C_GRY%-%C_RST% File .bat can luu UTF-8 with BOM
echo  %C_GRY%-%C_RST% Dung VS Code de edit: Save with Encoding -> UTF-8 BOM
echo  %C_GRY%-%C_RST% Command Prompt: chcp 65001 de ho tro UTF-8
echo.
pause
goto :menu
