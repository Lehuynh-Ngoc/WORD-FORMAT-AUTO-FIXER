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
echo  %C_BLD%%C_CYA  TAC GIA                                    %C_RST%
echo  %C_BLD%%C_CYA  Author - Le Huynh Ngoc                    %C_RST%
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo.
echo  %C_GRN%[1]%C_RST%  Tong quan
echo  %C_GRN%[2]%C_RST%  Thong tin tac gia
echo  %C_GRN%[3]%C_RST%  Du an GitHub
echo  %C_GRN%[4]%C_RST%  Tinh nang chinh
echo  %C_GRN%[5]%C_RST%  Phien ban & License
echo  %C_GRN%[6]%C_RST%  Lien he & Ho tro
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
if "%choice%"=="0" goto end
goto menu

:page1
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  TONG QUAN                                   %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%WORD-FORMAT-AUTO-FIXER%C_RST% la cong cu tuyen
echo  tinh dinh dang van ban Word. Duoc tao boi
echo  Le Huynh Ngoc voi muc dich giup nguoi dung
echo  dinh dang van ban nhanh chong, chinh xac.
echo.
echo  %C_BLD%Tam nhin:%C_RST%
echo  - Dinh dang van ban Viet Nam chuan
echo  - Tieng Viet, de su dung
echo  - Open source, mien phi
echo  - Dong gop cong dong
echo.
echo  %C_BLD%Gia tri:%C_RST%
echo  - Tiet kiem thoi gian dinh dang
echo  - Dam bao chuan format
echo  - Ho tro nhieu loai van ban
echo  - AI ho tro dich va tao van ban
echo.
echo  %C_BLD%Phat trien:%C_RST%
echo  - Bat dau tu van ban don gian
echo  - Mo rong AI features
echo  - Them loai van ban
echo  - Cai thien UX
echo.
pause
goto menu

:page2
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  THONG TIN TAC GIA                          %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Ten:%C_RST% Le Huynh Ngoc
echo.
echo  %C_BLD%GitHub:%C_RST% https://github.com/Lehuynh-Ngoc
echo  - Follow de theo doi cap nhat
echo  - Xem cac du an khac
echo  - Dong gop y kien
echo.
echo  %C_BLD%Nguon:%C_RST% Le Huynh Ngoc
echo  - Sinh vien/cong nhan IT
echo  - Yeu thich phat trien ung dung
echo  - Tap trung vao cong cu van ban
echo.
echo  %C_BLD%Dong gop:%C_RST%
echo  - Tao va duy tri du an
echo  - Hieu ung moi tinh nang
echo  - Ho tro nguoi dung
echo  - Review code
echo.
echo  %C_BLD%Muc tieu:%C_RST%
echo  - Tao cong cu dinh dang tot nhat Viet Nam
echo  - Mien phi, open source
echo  - De su dung cho moi nguoi
echo.
pause
goto menu

:page3
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  DU AN GITHUB                               %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Repository:%C_RST%
echo  https://github.com/Lehuynh-Ngoc/WORD-FORMAT-AUTO-FIXER
echo.
echo  %C_BLD%Ten du an:%C_RST%
echo  WORD-FORMAT-AUTO-FIXER
echo.
echo  %C_BLD%Mo ta:%C_RST%
echo  - Cong cu dinh dang van ban Word tu dong
echo  - Ho tro Vietnamese Word formatting
echo  - AI-powered translation va document generation
echo.
echo  %C_BLD%Features chinh:%C_RST%
echo  - Format theo rules YAML
echo  - Learn tu file mau
echo  - Clone dinh dang tu template
echo  - SmartHeading detection
echo  - AI translation 19 ngon ngu
echo  - AI document generation 19 loai
echo  - Word counter
echo  - Interactive CLI + Menu
echo.
echo  %C_BLD%Star:%C_RST% Neu thay hay, star cho tac gia
echo  - Dong gop dong luc phat trien
echo  - Giup du an duoc biet den
echo.
pause
goto menu

:page4
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  TINH NANG CHINH                            %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_GRN%1. Format Engine%C_RST%
echo  - Dinh dang theo rules YAML
echo  - Font, size, bold, italic, color
echo  - Alignment, line spacing, indent
echo  - Heading, Normal, Title, Quote
echo.
echo  %C_GRN%2. Clone Engine%C_RST%
echo  - Sao chep dinh dang tu template
echo  - Section, margin, header, footer
echo  - Watermark, TOC, columns
echo  - Can Microsoft Word
echo.
echo  %C_GRN%3. SmartHeading%C_RST%
echo  - Phat hieu tieu de tu dong
echo  - Regex patterns
echo  - Built-in + Custom patterns
echo  - 19 loai van ban Viet
echo.
echo  %C_GRN%4. AI Features%C_RST%
echo  - 5 AI providers
echo  - Multi-model
echo  - Translation 19 ngon ngu
echo  - Document generation 19 loai
echo.
echo  %C_GRN%5. Utility%C_RST%
echo  - Word counter
echo  - Style learner
echo  - Rule maker
echo  - Interactive CLI
echo.
pause
goto menu

:page5
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  PHIEN BAN & LICENSE                        %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Phien ban:%C_RST%
echo  - 1.0.0 - Phien ban dau tien
echo  - Phat trien lien tuc
echo  - Cap nhat moi
echo.
echo  %C_BLD%License:%C_RST%
echo  - Open Source
echo  - Mien phi su dung
echo  - Dong gop duoc hoan nghenh
echo.
echo  %C_BLD%Yeu cau he thong:%C_RST%
echo  - Python 3.8+
echo  - Microsoft Word - cho clone
echo  - Internet - cho AI features
echo  - Windows 10/11
echo.
echo  %C_BLD%Dependencies:%C_RST%
echo  - python-docx - docx processing
echo  - pywin32 - Word COM
echo  - pyyaml - rule files
echo  - requests - API calls
echo.
echo  %C_BLD%Cai dat:%C_RST%
echo  - pip install -r requirements.txt
echo  - Hoac qua run.bat
echo.
pause
goto menu

:page6
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  LIEN HE & HO TRO                           %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%GitHub:%C_RST%
echo  https://github.com/Lehuynh-Ngoc
echo  - Xem du an khac
echo  - Theo doi cap nhat
echo.
echo  %C_BLD%Repository:%C_RST%
echo  https://github.com/Lehuynh-Ngoc/WORD-FORMAT-AUTO-FIXER
echo  - Source code day du
echo  - Documentation
echo  - Issues & Bug reports
echo.
echo  %C_BLD%Cach ho tro:%C_RST%
echo  - Star repository neu thich
echo  - Fork va dong gop code
echo  - Bao cao loi qua Issues
echo  - De y kien, goi y
echo  - Chia se voi nguoi khac
echo.
echo  %C_BLD%Feedback:%C_RST%
echo  - Mo Issues tren GitHub
echo  - Mo ta loi cu the
echo  - De step reproduce
echo  - Attach file mau neu co
echo.
echo  %C_BLD%Dong gop code:%C_RST%
echo  - Fork repository
echo  - Tao branch moi
echo  - Pull request
echo  - Code review
echo.
pause
goto menu

:end
endlocal
exit /b 0
