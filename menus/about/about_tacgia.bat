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

cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  TAC GIA - Le Huynh Ngoc                               %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%WORD-FORMAT-AUTO-FIXER%C_RST% la cong cu tuyen
echo tinh dinh dang van ban Word. Duoc tao boi
echo Le Huynh Ngoc voi muc dich giup nguoi dung
echo dinh dang van ban nhanh chong, chinh xac.
echo.
echo %C_BLD%GitHub:%C_RST%
echo   https://github.com/Lehuynh-Ngoc
echo.
echo %C_BLD%Repository:%C_RST%
echo   https://github.com/Lehuynh-Ngoc/WORD-FORMAT-AUTO-FIXER
echo.
echo %C_BLD%Tinh nang chinh:%C_RST%
echo   1. Format Engine    - Dinh dang theo rules YAML
echo   2. Clone Engine     - Sao chep dinh dang tu template
echo   3. SmartHeading     - Phat hieu tieu de tu dong
echo   4. AI Features      - 5 providers, dich 19 ngon ngu
echo   5. Word Counter     - Dem tu/trang/thoi gian doc
echo   6. Style Learner    - Hoc tu file mau
echo   7. Rule Maker       - Tao rule thu cong
echo   8. Doc Generator    - Tao van ban AI 19 loai
echo.
echo %C_BLD%Yeu cau he thong:%C_RST%
echo   - Python 3.8+
echo   - Microsoft Word - cho clone
echo   - Internet - cho AI features
echo   - Windows 10/11
echo.
echo %C_BLD%Dependencies:%C_RST%
echo   - python-docx  - docx processing
echo   - pywin32      - Word COM
echo   - pyyaml       - rule files
echo   - requests     - API calls
echo.
echo %C_BLD%Cai dat:%C_RST%
echo   pip install -r requirements.txt
echo.
echo %C_BLD%Dong gop:%C_RST%
echo   - Star repository neu thich
echo   - Fork va dong gop code
echo   - Bao cao loi qua Issues
echo   - De y kien, goi y
echo.
echo %C_BLD%Phien ban:%C_RST% Open Source - Mien phi su dung
echo.
echo.
pause
exit /b
