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
echo %C_CYA%%C_BLD%         12. THONG TIN TAC GIA                        %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo  %C_WHT%Ten ung dung:%C_RST%     Word Format Auto-Fixer (wordfix)
echo  %C_WHT%Phien ban:%C_RST%        2.0
echo  %C_WHT%Tac gia:%C_RST%         Le Huynh Ngoc
echo  %C_WHT%GitHub:%C_RST%          https://github.com/Lehuynh-Ngoc
echo  %C_WHT%Repo:%C_RST%            https://github.com/Lehuynh-Ngoc/WORD-FORMAT-AUTO-FIXER
echo.
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo %C_CYA%  MO TA%RST%
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo.
echo  Cong cu CLI giup dinh dang van ban Word tu dong,
echo  ho tro AI dich thuat va tao van ban.
echo.
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo %C_CYA%  CHUC NANG CHINH%RST%
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo.
echo  %C_GRN%1.%C_RST%  Dinh dang tu dong theo rules YAML (12 subcommands)
echo  %C_GRN%2.%C_RST%  SmartHeading: phat hieu tieu de tu noi dung
echo  %C_GRN%3.%C_RST%  Learn: hoc tu file mau -> tao rule YAML
echo  %C_GRN%4.%C_RST%  Clone: copy toan bo dinh dang tu template
echo  %C_GRN%5.%C_RST%  AI: 5 providers, multi-model, dich 19 ngon ngu
echo  %C_GRN%6.%C_RST%  Word Counter: dem tu/trang/thoi gian doc
echo  %C_GRN%7.%C_RST%  Document Generator: tao van ban Word bang AI
echo.
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo %C_CYA%  CONG NGHE%RST%
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo.
echo  Python 3.10+  |  python-docx  |  pywin32  |  PyYAML
echo  AI: urllib (stdlib)  |  5 providers  |  4 models/provider
echo.
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo %C_CYA%  TAI NGUON%RST%
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo.
echo  %C_WHT%https://github.com/Lehuynh-Ngoc/WORD-FORMAT-AUTO-FIXER%C_RST%
echo.
echo  %C_GRY%Dong gop, bao loi, goi y tinh nang: GitHub Issues%C_RST%
echo.
echo.
pause
