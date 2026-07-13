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

:about
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%         THONG TIN UNG DUNG - BACH KHOA TOAN THU        %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Moi muc chua day du thong tin ve tung chuc nang,%C_RST%
echo %C_GRY%  cach dung, vi du, meo va xu ly loi.%C_RST%
echo.
echo %C_GRY%--- CO SO ---                                                           %C_RST%
echo %C_YLW%  1. %C_RST%Gioi thieu chung - Tong quan du an
echo %C_YLW%  2. %C_RST%Hoc formatting tu file mau
echo %C_YLW%  3. %C_RST%Tao rule thu cong
echo %C_YLW%  4. %C_RST%Cau hinh SmartHeading patterns
echo %C_YLW%  5. %C_RST%Xem truoc (Preview) va Dinh dang (Format)
echo %C_YLW%  6. %C_RST%Clone dinh dang + Clone-preview
echo %C_GRY%--- AI ---                                                              %C_RST%
echo %C_YLW%  7. %C_RST%AI Provider - Quan ly API key va models
echo %C_YLW%  8. %C_RST%Dich thuat file Word
echo %C_YLW%  9. %C_RST%Tao van ban bang AI
echo %C_GRY%--- Tien ich ---                                                       %C_RST%
echo %C_YLW% 10. %C_RST%Dem tu va trang
echo %C_YLW% 11. %C_RST%Khoi tao / Reset du an
echo %C_YLW% 12. %C_RST%Thong tin tac gia
echo %C_YLW% 13. %C_RST%Xu ly loi pho bien (Troubleshooting)
echo %C_RED%   0. %C_RST%Quay lai
echo %C_GRY%------------------------------------------------------------%C_RST%
echo.
set /p SUB="%C_YLW%Nhap so (0-13): %C_RST%"

if "%SUB%"=="1" call menus\about_gioithieu.bat
if "%SUB%"=="2" call menus\about_learn.bat
if "%SUB%"=="3" call menus\about_makerule.bat
if "%SUB%"=="4" call menus\about_smart.bat
if "%SUB%"=="5" call menus\about_format.bat
if "%SUB%"=="6" call menus\about_clone.bat
if "%SUB%"=="7" call menus\about_ai.bat
if "%SUB%"=="8" call menus\about_translate.bat
if "%SUB%"=="9" call menus\about_generate.bat
if "%SUB%"=="10" call menus\about_count.bat
if "%SUB%"=="11" call menus\about_initreset.bat
if "%SUB%"=="12" call menus\about_tacgia.bat
if "%SUB%"=="13" call menus\about_troubleshoot.bat
if "%SUB%"=="0" exit /b
goto :about
