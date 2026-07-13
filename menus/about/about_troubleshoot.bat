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
echo %C_CYA%%C_BLD%  XU LY LOI PHO BIEN - Troubleshoot                     %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Loi cai dat - Installation
echo %C_YLW%  2.%C_RST% Loi format - Format errors
echo %C_YLW%  3.%C_RST% Loi clone - Clone errors
echo %C_YLW%  4.%C_RST% Loi AI - AI provider errors
echo %C_YLW%  5.%C_RST% Checklist truoc khi bao loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto page1
if "%SUB%"=="2" goto page2
if "%SUB%"=="3" goto page3
if "%SUB%"=="4" goto page4
if "%SUB%"=="5" goto page5
if "%SUB%"=="0" exit /b
goto :menu

:page1
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  LOI CAI DAT - INSTALLATION                            %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_RED%Loi 1: python is not recognized%CRST%
echo   Nguyen nhan: Python chua them vao PATH
echo   Giai phap: Cai dat Python, chon "Add to PATH"
echo   Kiem tra: python --version
echo.
echo %C_RED%Loi 2: ModuleNotFoundError%CRST%
echo   Nguyen nhan: Chua cai dependencies
echo   Giai phap: pip install -r requirements.txt
echo   Kiem tra: pip list
echo   Module chinh: python-docx, pywin32, pyyaml
echo.
echo %C_RED%Loi 3: Access denied%CRST%
echo   Nguyen nhan: Khong co quyen cai dat
echo   Giai phap 1: Chay terminal voi quyen Admin
echo   Giai phap 2: Dung pip install --user
echo   Giai phap 3: Tao virtual environment
echo.
echo %C_RED%Loi 4: pip is not recognized%CRST%
echo   Nguyen nhan: pip chua them vao PATH
echo   Giai phap: python -m pip install -r requirements.txt
echo   Hoac: py -m pip install -r requirements.txt
echo.
echo %C_RED%Loi 5: Visual C++ required%CRST%
echo   Nguyen nhan: pywin32 can Visual C++ Build Tools
echo   Giai phap: Cai Visual C++ Build Tools
echo   Hoac: pip install pywin32-prebuilt
echo.
pause
goto :menu

:page2
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  LOI FORMAT - FORMAT ERRORS                            %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_RED%Loi 1: FileNotFoundError%CRST%
echo   Nguyen nhan: File input khong ton tai
echo   Giai phap: Kiem tra lai duong dan
echo   Dung "" cho path co dau cach
echo.
echo %C_RED%Loi 2: No rules matched%CRST%
echo   Nguyen nhan: Rule khong match voi file
echo   Giai phap: Kiem tra rule file
echo   Dung default.yaml cho Viet Nam
echo   Chinh sua rule cho phu hop
echo.
echo %C_RED%Loi 3: Output directory not found%CRST%
echo   Nguyen nhan: Thu muc outputs/ khong ton tai
echo   Giai phap: Tao thu muc outputs/ truoc
echo   Hoac: python src/main.py init
echo.
echo %C_RED%Loi 4: Invalid YAML format%CRST%
echo   Nguyen nhan: Rule file sai dinh dang
echo   Giai phap: Mo file YAML kiem tra indent
echo   Dung text editor co syntax highlighting
echo.
echo %C_RED%Loi 5: Permission denied%CRST%
echo   Nguyen nhan: File dang mo trong Word
echo   Giai phap: Dong file Word truoc khi format
echo.
pause
goto :menu

:page3
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  LOI CLONE - CLONE ERRORS                              %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_RED%Loi 1: Cannot initialize Word COM%CRST%
echo   Nguyen nhan: Microsoft Word khong cai dat
echo   Giai phap: Cai dat Microsoft Word/Office
echo   Alternative: dung Format thay the
echo.
echo %C_RED%Loi 2: COM busy%CRST%
echo   Nguyen nhan: Word dang xu ly tac vu khac
echo   Giai phap: Dong tat ca file Word
echo   Doi 5 giay roi thu lai
echo   CloneEngine tu dong retry (max 10 lan)
echo.
echo %C_RED%Loi 3: Template not found%CRST%
echo   Nguyen nhan: File template khong ton tai
echo   Giai phap: Kiem tra lai duong dan
echo   Dung "" cho path co dau cach
echo.
echo %C_RED%Loi 4: Access denied%CRST%
echo   Nguyen nhan: File dang mo hoac khong co quyen
echo   Giai phap: Dong file truoc khi clone
echo   Kiem tra quyen ghi thu muc output
echo.
echo %C_RED%Loi 5: pywin32 not installed%CRST%
echo   Nguyen nhan: Chua cai pywin32
echo   Giai phap: pip install -r requirements.txt
echo   Kiem tra: python -c "import win32com.client"
echo.
pause
goto :menu

:page4
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  LOI AI - AI PROVIDER ERRORS                           %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_RED%Loi 1: No active provider%CRST%
echo   Nguyen nhan: Chua cai dat provider nao
echo   Giai phap: python src/main.py settings
echo   Them provider voi API key hop le
echo.
echo %C_RED%Loi 2: API key invalid%CRST%
echo   Nguyen nhan: Key sai hoac het han
echo   Giai phap: Vao trang chu provider lay key moi
echo   Cap nhat key qua settings
echo.
echo %C_RED%Loi 3: Rate limited%CRST%
echo   Nguyen nhan: Qua nhieu request
echo   Giai phap: Doi 1 phut roi thu lai
echo   Giam tan suat goi API
echo   Dung provider khac
echo.
echo %C_RED%Loi 4: Batch count mismatch%CRST%
echo   Nguyen nhan: So doan dich khac so doan goc
echo   Giai phap: He thong tu dong fallback
echo   Dich tung doan rieng le
echo.
echo %C_RED%Loi 5: Network error%CRST%
echo   Nguyen nhan: Mat ket noi mang
echo   Giai phap: Kiem tra internet, thu lai
echo   Dung VPN neu bi chan
echo.
pause
goto :menu

:page5
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CHECKLIST TRUOC KHI BAO LOI                           %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRN%1. Kiem tra Python:%CRST%
echo   python --version
echo   pip list
echo   python -c "import docx"
echo   python -c "import yaml"
echo   python -c "import win32com.client"
echo.
echo %C_GRN%2. Kiem tra file:%CRST%
echo   File input ton tai?
echo   File input la .docx?
echo   File rule hop le?
echo   Thu muc output ton tai?
echo.
echo %C_GRN%3. Kiem tra AI:%CRST%
echo   Provider da cai dat?
echo   API key hop le?
echo   Ket noi mang on dinh?
echo   Status la VALID?
echo.
echo %C_GRN%4. Kiem tra Word:%CRST%
echo   Microsoft Word cai dat?
echo   Word dang chay? Dong truoc khi clone
echo   pywin32 hoat dong?
echo.
echo %C_GRN%5. Kiem tra BAT:%CRST%
echo   Khong co & trong set?
echo   Khong co goto trong if/else?
echo   ANSI mau ho tro?
echo   Code page: chcp 65001
echo.
echo %C_BLD%Sau khi kiem tra het:%C_RST% moi bao loi
echo de nhan duoc ho tro nhanh nhat.
echo.
pause
goto :menu
