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
echo %C_CYA%%C_BLD%         1. GIOI THIEU CHUNG                          %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_YLW%  Ten ung dung:%C_RST% Word Format Auto-Fixer (wordfix)
echo %C_YLW%  Phien ban:%C_RST%    2.0
echo %C_YLW%  Ngon ngu:%C_RST%     Python 3.10+
echo %C_YLW%  He dieu hanh:%C_RST% Windows (can Microsoft Word cho clone)
echo %C_YLW%  GitHub:%C_RST%       https://github.com/Lehuynh-Ngoc/WORD-FORMAT-AUTO-FIXER
echo.
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo %C_CYA%  MUC DICH%C_RST%
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo.
echo  %C_WHT%Cong cu CLI giup nguoi dung:%C_RST%
echo  %C_GRY%-%C_RST% Dinh dang van ban Word theo rule YAML
echo  %C_GRY%-%C_RST% SmartHeading: tu dong phat hien tieu de tu noi dung
echo  %C_GRY%-%C_RST% Clone toan bo dinh dang tu file mau sang file khac
echo  %C_GRY%-%C_RST% Dem tu, ky tu, dong, trang, thoi gian doc
echo  %C_GRY%-%C_RST% Dich file Word sang 19 ngon ngu bang AI
echo  %C_GRY%-%C_RST% Tao van ban Word moi bang AI (19 loai van ban)
echo  %C_GRY%-%C_RST% Quan ly nhieu AI provider voi nhieu model
echo.
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo %C_CYA%  CAI DAT%C_RST%
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo.
echo  %C_GRY%1.%C_RST% Cai Python 3.10+ tren Windows
echo  %C_GRY%2.%C_RST% Clone repo: %C_WHT%git clone https://github.com/Lehuynh-Ngoc/WORD-FORMAT-AUTO-FIXER.git%C_RST%
echo  %C_GRY%3.%C_RST% Chay: %C_WHT%pip install -r requirements.txt%C_RST%
echo  %C_GRY%4.%C_RST% Chay menu: %C_WHT%run.bat%C_RST% hoac CLI: %C_WHT%python src/main.py --help%C_RST%
echo.
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo %C_CYA%  12 SUBCOMMANDS%C_RST%
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo.
echo  %C_YLW%format%C_RST%      Dinh dang file theo rules
echo  %C_YLW%preview%C_RST%     Xem truoc (khong ghi file)
echo  %C_YLW%learn%C_RST%       Hoc tu file mau, tao rule YAML
echo  %C_YLW%clone%C_RST%       Clone toan bo dinh dang tu template
echo  %C_YLW%clone-preview%C_RST% Xem truoc ket qua clone
echo  %C_YLW%list-rules%C_RST%  Xem danh sach rules
echo  %C_YLW%count%C_RST%       Dem tu, ky tu, dong, trang
echo  %C_YLW%translate%C_RST%   Dich file Word sang ngon ngu khac
echo  %C_YLW%settings%C_RST%    Quan ly AI providers
echo  %C_YLW%generate%C_RST%    Tao van ban Word bang AI
echo  %C_YLW%init%C_RST%        Khoi tao du an
echo  %C_YLW%reset%C_RST%       Reset ve trang thai mac dinh
echo.
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo %C_CYA%  CAU TRUC THU MUC%C_RST%
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo.
echo  %C_WHT%fomat_word/%C_RST%
echo  %C_GRY%  run.bat              Menu giao dien (5 menu)%C_RST%
echo  %C_GRY%  menus/               Thong tin ung dung%C_RST%
echo  %C_GRY%  config/              API keys + models%C_RST%
echo  %C_GRY%  mau/                 File mau cho clone%C_RST%
echo  %C_GRY%  outputs/             File dau ra%C_RST%
echo  %C_GRY%  rules/               File rule YAML%C_RST%
echo  %C_GRY%  src/core/            Engine, AI, counter, translator%C_RST%
echo  %C_GRY%  src/formatters/      Font, spacing, alignment, heading%C_RST%
echo  %C_GRY%  src/parsers/         DocxParser, DocParser%C_RST%
echo  %C_GRY%  src/cli/             CLI handlers, interactive tools%C_RST%
echo  %C_GRY%  tests/               Unit tests (7 tests)%C_RST%
echo.
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo %C_CYA%  CONG NGHE%C_RST%
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo.
echo  %C_GRY%python-docx%C_RST%  Doc/ghi .docx (format mode)
echo  %C_GRY%pywin32%C_RST%      COM API (clone mode, .doc, page count)
echo  %C_GRY%PyYAML%C_RST%       Doc/ghi rule YAML, AI config
echo  %C_GRY%pytest%C_RST%       Unit tests
echo  %C_GRY%urllib%C_RST%       AI API calls (stdlib, khong can them)
echo.
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo %C_CYA%  CHE DO XU LY%C_RST%
echo %C_CYA%  %- - - - - - - - - - - - - - - - - - - - - - - - - - - - -%C_RST%
echo.
echo  %C_YLW%Format mode:%C_RST%  python-docx - Font, spacing, alignment, heading
echo  %C_YLW%Clone mode:%C_RST%   win32com - Section, header, watermark, TOC, style
echo  %C_YLW%AI mode:%C_RST%      urllib - Dich thuat, tao van ban, dem tu
echo.
echo.
pause
