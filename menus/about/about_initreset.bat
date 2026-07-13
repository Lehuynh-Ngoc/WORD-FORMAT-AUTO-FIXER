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
echo %C_CYA%%C_BLD%         11. KHOI TAO / RESET DU AN                    %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Init (khoi tao)
echo %C_YLW%  2.%C_RST% Reset (dat lai)
echo %C_YLW%  3.%C_RST% Cach dung
echo %C_YLW%  4.%C_RST% Luu y
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto :init
if "%SUB%"=="2" goto :reset
if "%SUB%"=="3" goto :cachdung
if "%SUB%"=="4" goto :luuy
if "%SUB%"=="0" exit /b
goto :menu

:init
cls
echo.
echo %C_CYA%--- INIT (KHOI TAO DU AN) ---%C_RST%
echo.
echo  Tao thu muc va file can thiet khi chua ton tai.
echo.
echo %C_CYA%  Thu muc duoc tao:%C_RST%
echo  %C_GRY%-%C_RST% config/          Chua API keys + template
echo  %C_GRY%-%C_RST% outputs/         Chua file dau ra
echo  %C_GRY%-%C_RST% mau/             Chua file mau cho clone
echo  %C_GRY%-%C_RST% rules/           Chua file rule YAML
echo.
echo %C_CYA%  File duoc tao:%C_RST%
echo  %C_GRY%-%C_RST% outputs/.gitkeep   De git theo thu muc trong
echo.
echo %C_CYA%  Luu y:%C_RST%
echo  %C_GRY%-%C_RST% Chi tao nhung gi CHUA ton tai
echo  %C_GRY%-%C_RST% Khong ghi de file da co
echo  %C_GRY%-%C_RST% ai_keys.yaml duoc tu dong tao tu template khi chay
echo.
pause
goto :menu

:reset
cls
echo.
echo %C_CYA%--- RESET (DAT LAI TRANG THAI) ---%C_RST%
echo.
echo  Xoa du lieu nguoi dung, giu nguyen file default.
echo.
echo %C_CYA%  Duoc XOA:%C_RST%
echo  %C_RED%-%C_RST% config/ai_keys.yaml          API keys (BI MAT!)
echo  %C_RED%-%C_RST% outputs/*                    Tat ca file dau ra
echo  %C_RED%-%C_RST% rules/learned_rules.yaml     Rule tu learn
echo  %C_RED%-%C_RST% rules/custom_rules.yaml      Rule thu cong
echo  %C_RED%-%C_RST% rules/smart_patterns.yaml    Cau hinh SmartHeading
echo.
echo %C_CYA%  DUOC GIU NGUYEN:%C_RST%
echo  %C_GRN%-%C_RST% rules/default.yaml           Rule mac dinh
echo  %C_GRN%-%C_RST% rules/academic.yaml          Rule hoc tap
echo  %C_GRN%-%C_RST% config/ai_keys_template.yaml Template (git tracked)
echo.
echo %C_CYA%  Ket qua:%C_RST%
echo  %C_GRY%-%C_RST% outputs/ duoc xoa sach, giu .gitkeep
echo  %C_GRY%-%C_RST% AI config xoa -> can setup lai API key
echo  %C_GRY%-%C_RST% Rules custom bi xoa -> can learn/tao lai
echo.
pause
goto :menu

:cachdung
cls
echo.
echo %C_CYA%--- CACH DUNG ---%C_RST%
echo.
echo %C_CYA%  CLI:%C_RST%
echo  %C_WHT%python src/main.py init%C_RST%      %C_GRY%Khoi tao%C_RST%
echo  %C_WHT%python src/main.py reset%C_RST%     %C_GRY%Reset%C_RST%
echo.
echo %C_CYA%  Menu (run.bat):%C_RST%
echo  %C_GRY%1.%C_RST% Chay %C_WHT%run.bat%C_RST%
echo  %C_GRY%2.%C_RST% Menu 4 - Cai dat
echo  %C_GRY%3.%C_RST% Chon 2 - Khoi tao du an  HOAC  Chon 3 - Reset
echo.
echo %C_CYA%  Khi nao dung?%C_RST%
echo  %C_GRY%-%C_RST% Lan dau cai dat:  chay init
echo  %C_GRY%-%C_RST% Muon bat dau lai: chay reset
echo  %C_GRY%-%C_RST% File bi thieu:    chay init
echo  %C_GRY%-%C_RST% Muon xoa sach:    chay reset
echo.
pause
goto :menu

:luuy
cls
echo.
echo %C_CYA%--- LUU Y ---%C_RST%
echo.
echo %C_RED%  Reset se XOA API keys!%C_RST%
echo  %C_GRY%Sau reset, can vao Menu 4 de nhap lai API key.%C_RST%
echo.
echo %C_RED%  Reset se XOA rules da hoc/tao!%C_RST%
echo  %C_GRY%Can chay learn hoac tao rule lai.%C_RST%
echo.
echo %C_RED%  Reset se XOA SmartHeading patterns!%C_RST%
echo  %C_GRY%Can cau hinh lai patterns.%C_RST%
echo.
echo %C_RED%  Reset se XOA tat ca outputs!%C_RST%
echo  %C_GRY%Luu file quan trong truoc khi reset.%C_RST%
echo.
echo  %C_CYA%  Reset KHONG xoa:%C_RST%
echo  %C_GRN%-%C_RST% default.yaml, academic.yaml (rule mac dinh)
echo  %C_GRN%-%C_RST% ai_keys_template.yaml (template)
echo  %C_GRN%-%C_RST% tat ca source code
echo  %C_GRN%-%C_RST% mau/, config/ (thu muc)
echo.
pause
goto :menu
