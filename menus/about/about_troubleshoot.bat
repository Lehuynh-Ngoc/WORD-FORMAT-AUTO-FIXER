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
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo  %C_BLD%%C_CYA  XU LY LOI PHO BIEN                        %C_RST%
echo  %C_BLD%%C_CYA  Troubleshoot - Huong dan loi               %C_RST%
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo.
echo  %C_GRN%[1]%C_RST%  Loi cai dat - Installation
echo  %C_GRN%[2]%C_RST%  Loi format - Format errors
echo  %C_GRN%[3]%C_RST%  Loi clone - Clone errors
echo  %C_GRN%[4]%C_RST%  Loi AI - AI provider errors
echo  %C_GRN%[5]%C_RST%  Loi batch file - BAT errors
echo  %C_GRN%[6]%C_RST%  Luu y quan trong
echo  %C_GRN%[7]%C_RST%  Checklist truoc khi bao loi
echo.
echo  %C_YLW%[0]%C_RST%  Quay lai
echo.
set /p "choice=  %C_CYA%Chon: %C_RST%"

if "%choice%"=="1" goto page1
if "%choice%"=="2" goto page2
if "%choice%"=="3" goto page3
if "%choice%"=="4" goto page4
if "%choice%"=="5" goto page5
if "%choice%"=="6" goto page6
if "%choice%"=="7" goto page7
if "%choice%"=="0" goto end
goto menu

:page1
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  LOI CAI DAT - INSTALLATION                  %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_RED%Loi 1: python is not recognized%C_RST%
echo  - Nguyen nhan: Python chua them vao PATH
echo  - Giai phap 1: Cai dat Python, chon "Add to PATH"
echo  - Giai phap 2: Them thu manually vao PATH
echo  - Kiem tra: python --version
echo.
echo  %C_RED%Loi 2: ModuleNotFoundError%C_RST%
echo  - Nguyen nhan: Chua cai dependencies
echo  - Giai phap: pip install -r requirements.txt
echo  - Kiem tra: pip list
echo  - Module chinh: python-docx, pywin32, pyyaml, requests
echo.
echo  %C_RED%Loi 3: Access denied%C_RST%
echo  - Nguyen nhan: Khong co quyen cai dat
echo  - Giai phap 1: Chay terminal voi quyen Admin
echo  - Giai phap 2: Dung pip install --user
echo  - Giai phap 3: Tao virtual environment
echo.
echo  %C_RED%Loi 4: pip is not recognized%C_RST%
echo  - Nguyen nhan: pip chua them vao PATH
echo  - Giai phap: python -m pip install -r requirements.txt
echo  - Hoac: py -m pip install -r requirements.txt
echo.
echo  %C_RED%Loi 5: Visual C++ required%C_RST%
echo  - Nguyen nhan: pywin32 can Visual C++ Build Tools
echo  - Giai phap: Cai Visual C++ Build Tools
echo  - Hoac: pip install pywin32-prebuilt
echo.
pause
goto menu

:page2
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  LOI FORMAT - FORMAT ERRORS                  %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_RED%Loi 1: FileNotFoundError%C_RST%
echo  - Nguyen nhan: File input khong ton tai
echo  - Giai phap: Kiem tra lai duong dan
echo  - Dung "" cho path co dau cach
echo  - Kiem tra file co dung dinh dang .docx
echo.
echo  %C_RED%Loi 2: No rules matched%C_RST%
echo  - Nguyen nhan: Rule khong match voi file
echo  - Giai phap: Kiem tra rule file
echo  - Dung default.yaml cho Viet Nam
echo  - Chinh sua rule cho phu hop
echo.
echo  %C_RED%Loi 3: Output directory not found%C_RST%
echo  - Nguyen nhan: Thu muc outputs/ khong ton tai
echo  - Giai phap: Tao thu muc outputs/ truoc
echo  - Hoac: chay init de tao cau truc
echo  - Kiem tra duong dan output
echo.
echo  %C_RED%Loi 4: Invalid YAML format%C_RST%
echo  - Nguyen nhan: Rule file sai dinh dang
echo  - Giai phap: Mo file YAML kiem tra
echo  - Dung text editor co syntax highlighting
echo  - Kiem tra indent va dau hai cham
echo.
echo  %C_RED%Loi 5: Permission denied%C_RST%
echo  - Nguyen nhan: File dang mo trong Word
echo  - Giai phap: Dong file Word truoc khi format
echo  - Kiem tra quyen ghi thu muc output
echo.
pause
goto menu

:page3
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  LOI CLONE - CLONE ERRORS                    %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_RED%Loi 1: Cannot initialize Word COM%C_RST%
echo  - Nguyen nhan: Microsoft Word khong cai dat
echo  - Giai phap: Cai dat Microsoft Word/Office
echo  - Kiem tra: Word co mo duoc khong
echo  - Alternative: dung Format thay the
echo.
echo  %C_RED%Loi 2: COM busy%C_RST%
echo  - Nguyen nhan: Word dang xu ly tac vu khac
echo  - Giai phap: Dong tat ca file Word
echo  - Doi 5 giay roi thu lai
echo  - Khoi dong lai Word neu can
echo  - Tranh chay nhieu clone cung luc
echo.
echo  %C_RED%Loi 3: Template not found%C_RST%
echo  - Nguyen nhan: File template khong ton tai
echo  - Giai phap: Kiem tra lai duong dan
echo  - Dung "" cho path co dau cach
echo  - Kiem tra file co dung dinh dang .docx
echo.
echo  %C_RED%Loi 4: Access denied%C_RST%
echo  - Nguyen nhan: File dang mo hoac khong co quyen
echo  - Giai phap: Dong file truoc khi clone
echo  - Kiem tra quyen ghi thu muc output
echo  - Chay voi quyen Admin neu can
echo.
echo  %C_RED%Loi 5: pywin32 not installed%C_RST%
echo  - Nguyen nhan: Chua cai pywin32
echo  - Giai phap: pip install pywin32
echo  - Kiem tra: python -c "import win32com.client"
echo.
pause
goto menu

:page4
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  LOI AI - AI PROVIDER ERRORS                 %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_RED%Loi 1: No active provider%C_RST%
echo  - Nguyen nhan: Chua cai dat provider nao
echo  - Giai phap: Cai dat provider truoc
echo  - python src/main.py settings
echo  - Them provider voi API key hop le
echo.
echo  %C_RED%Loi 2: API key invalid%C_RST%
echo  - Nguyen nhan: API key sai hoac het han
echo  - Giai phap: Kiem tra lai key
echo  - Vao trang chu provider lay key moi
echo  - Cap nhat key qua settings
echo.
echo  %C_RED%Loi 3: Rate limited%C_RST%
echo  - Nguyen nhan: Qua nhieu request
echo  - Giai phap: Doi 1 phut roi thu lai
echo  - Giam tan suat goi API
echo  - Dung provider khac
echo.
echo  %C_RED%Loi 4: Batch count mismatch%C_RST%
echo  - Nguyen nhan: So doan dich khac so doan goc
echo  - Giai phap: He thong tu dong fallback
echo  - Dich tung doan rieng le
echo  - Kiem tra ket qua cuoi cung
echo.
echo  %C_RED%Loi 5: Network error%C_RST%
echo  - Nguyen nhan: Mat ket noi mang
echo  - Giai phap: Kiem tra ket noi internet
echo  - Thu lai sau 30 giay
echo  - Dung VPN neu bi chan
echo.
pause
goto menu

:page5
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  LOI BATCH FILE - BAT ERRORS                 %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_RED%Loi 1: goto in if block%C_RST%
echo  - Nguyen nhan: goto nam trong if/else (...) block
echo  - Giai phap: Dung goto rieng, khong trong ()
echo  - cmd.exe crash tren mot so Windows
echo  - Luon dat goto ngoai if/else block
echo.
echo  %C_RED%Loi 2: ANSI colors khong hien%C_RST%
echo  - Nguyen nhan: Terminal khong ho tro ANSI
echo  - Giai phap: Dung Windows Terminal
echo  - Hoac: chay tren cmd.exe moi nhat
echo  - Azure Cloud Shell cung ho tro
echo.
echo  %C_RED%Loi 3: Vietnamese encoding%C_RST%
echo  - Nguyen nhan: Font khong ho tro Unicode
echo  - Giai phap: Dung Windows Terminal
echo  - Dat font: Consolas hoac Lucida Console
echo  - Dat code page: chcp 65001
echo.
echo  %C_RED%Loi 4: & in set commands%C_RST%
echo  - Nguyen nhan: Su dung & de chain set
echo  - Giai phap: Moi set tren mot dong rieng
echo  - KHONG BAO GIO dung & voi set
echo  - Vi du dung: set "A=1" moi dong
echo.
echo  %C_RED%Loi 5: Parentheses in echo%C_RST%
echo  - Nguyen nhan: ( ) trong echo bi cmd interpret
echo  - Giai phap: Tranh dung () trong echo text
echo  - Dung thay the: viet lai khong co ()
echo  - Hoac: dung ^ de escape
echo.
pause
goto menu

:page6
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  LUU Y QUAN TRONG                           %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_YLW%1. BAT file rules:%C_RST%
echo  - KHONG dung & de chain set commands
echo  - Moi set phai tren mot dong rieng
echo  - KHONG dat goto ben trong if/else (...) block
echo  - Dung goto thay vi if/else cho flow control
echo  - %% cho percent trong for loops
echo  - Tranh () trong echo text
echo.
echo  %C_YLW%2. Vietnamese encoding:%C_RST%
echo  - Dung Windows Terminal
echo  - Font: Consolas hoac Lucida Console
echo  - Code page: chcp 65001
echo  - File .bat dung UTF-8
echo.
echo  %C_YLW%3. File paths:%C_RST%
echo  - Dung "" cho path co dau cach
echo  - Dung / hoac \ de phan tach
echo  - Kiem tra file ton tai truoc khi dung
echo.
echo  %C_YLW%4. Python:%C_RST%
echo  - Dung python, khong phai py
echo  - Kiem tra version: python --version
echo  - Kiem tra packages: pip list
echo.
echo  %C_YLW%5. Word COM:%C_RST%
echo  - Can Microsoft Word cai dat
echo  - Dong Word truoc khi su dung COM
echo  - Kiem tra: python -c "import win32com.client"
echo.
pause
goto menu

:page7
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  CHECKLIST TRUOC KHI BAO LOI                 %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_GRN%1. Kiem tra Python:%C_RST%
echo  - python --version
echo  - pip list
echo  - python -c "import docx"
echo  - python -c "import yaml"
echo  - python -c "import win32com.client"
echo.
echo  %C_GRN%2. Kiem tra file:%C_RST%
echo  - File input ton tai?
echo  - File input la .docx?
echo  - File rule hop le?
echo  - Thu muc output ton tai?
echo.
echo  %C_GRN%3. Kiem tra AI:%C_RST%
echo  - Provider da cai dat?
echo  - API key hop le?
echo  - Ket noi mang on dinh?
echo  - Status la VALID?
echo.
echo  %C_GRN%4. Kiem tra Word:%C_RST%
echo  - Microsoft Word cai dat?
echo  - Word dang chay?
echo  - Dong Word truoc khi clone
echo  - pywin32 hoat dong?
echo.
echo  %C_GRN%5. Kiem tra BAT:%C_RST%
echo  - Khong co & trong set?
echo  - Khong co () trong echo?
echo  - Khong co goto trong if?
echo  - ANSI mau ho tro?
echo.
echo  %C_BLD%Sau khi kiem tra het:%C_RST% moi bao loi
echo  de nhan duoc ho tro nhanh nhat.
echo.
pause
goto menu

:end
endlocal
exit /b 0
