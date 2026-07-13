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
echo %C_CYA%%C_BLD%  INIT / RESET                                           %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Init - Khoi tao cau truc
echo %C_YLW%  2.%C_RST% Reset - Dat lai cau hinh
echo %C_YLW%  3.%C_RST% Cach dung - CLI va Menu
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto page1
if "%SUB%"=="2" goto page2
if "%SUB%"=="3" goto page3
if "%SUB%"=="0" exit /b
goto :menu

:page1
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  INIT - KHOI TAO CAU TRUC                              %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Source code:%C_RST% src/core/init_reset.py
echo - init_project(): tao thu muc va file
echo - DEFAULT_DIRS: config, outputs, mau, rules
echo - DEFAULT_FILES: ai_keys_template.yaml
echo.
echo %C_BLD%Thu muc duoc tao:%C_RST%
echo.
echo %C_GRN%config/%CRST% - Cau hinh he thong
echo   ai_keys.yaml:         API key va models
echo   ai_keys_template.yaml: mau cau hinh
echo.
echo %C_GRN%outputs/%CRST% - File dau ra
echo   Cac file .docx da xuat
echo   Cac file dich/thuat
echo.
echo %C_GRN%mau/%CRST% - File mau
echo   File mau .docx de learn
echo   File mau de test
echo.
echo %C_GRN%rules/%CRST% - Rule dinh dang
echo   default.yaml:     rule mac dinh
echo   academic.yaml:    rule hoc thuat
echo   learned_rules.yaml: tu learn
echo   custom_rule.yaml: tu tao
echo.
echo %C_BLD%File duoc tao:%C_RST%
echo   - ai_keys.yaml tu template
echo   - outputs/.gitkeep
echo   - Chi tao file moi, khong ghi de file cu
echo.
echo %C_BLD%Yeu cau:%C_RST%
echo   - Khong can gi dac biet
echo   - Chay tu thu muc goc project
echo.
pause
goto :menu

:page2
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  RESET - DAT LAI CAU HINH                              %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Source code:%C_RST% src/core/init_reset.py
echo - reset_project(): xoa file theo pattern
echo - RESET_DELETE_PATTERNS: 5 pattern
echo - RESET_KEEP_FILES: default.yaml, academic.yaml
echo.
echo %C_RED%File duoc xoa khi Reset:%CRST%
echo.
echo   1. Cau hinh AI:
echo      config/ai_keys.yaml
echo      API key da nhap bi xoa
echo.
echo   2. File da xuat:
echo      outputs/* (tat ca file .docx)
echo      Khong the phuc hoi
echo.
echo   3. Rule da hoc:
echo      rules/learned_rules.yaml
echo      Co the learn lai
echo.
echo   4. Rule tuy chinh:
echo      rules/custom_rules.yaml
echo      Can tao lai
echo.
echo   5. Smart patterns:
echo      rules/smart_patterns.yaml
echo      Co the tao lai
echo.
echo %C_GRN%GIU NGUYEN:%CRST%
echo   rules/default.yaml - rule mac dinh
echo   rules/academic.yaml - rule hoc thuat
echo   config/ai_keys_template.yaml - mau
echo   src/ - nguon code
echo   tests/ - test files
echo   run.bat - menu giao dien
echo.
pause
goto :menu

:page3
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CACH DUNG - CLI VA MENU                               %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%1. Init:%C_RST%
echo   python src/main.py init
echo   Tao tat ca thu muc va file cau hinh mac dinh
echo.
echo %C_BLD%2. Reset:%C_RST%
echo   python src/main.py reset
echo   Xoa file cau hinh, giu lai file goc
echo.
echo %C_BLD%3. Qua Menu:%C_RST%
echo   Mo run.bat -> Menu 3
echo   Chon Init hoac Reset
echo   Xac nhan thao tac
echo.
echo %C_BLD%4. Kiem tra cau truc:%C_RST%
echo   Chay init de kiem tra thu muc co day du
echo   Init khong ghi de file cu
echo   Chi tao file/thu muc thieu
echo.
echo %C_BLD%5. Sau Init:%C_RST%
echo   - Cai dat: pip install -r requirements.txt
echo   - Cai dat AI provider
echo   - Bat dau su dung
echo.
echo %C_BLD%6. Truoc khi Reset:%C_RST%
echo   - Backup du lieu can thiet
echo   - chac chan muon reset
echo   - Dong Word truoc khi reset
echo.
pause
goto :menu
