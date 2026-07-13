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
echo %C_CYA%%C_BLD%  DEM TU/TRANG - WordCounter                             %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan - WordCounter la gi?
echo %C_YLW%  2.%C_RST% Cach dung - CLI va Menu
echo %C_YLW%  3.%C_RST% Thong so duoc dem
echo %C_YLW%  4.%C_RST% Tinh toan trang
echo %C_YLW%  5.%C_RST% Thoi gian doc
echo %C_YLW%  6.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto page1
if "%SUB%"=="2" goto page2
if "%SUB%"=="3" goto page3
if "%SUB%"=="4" goto page4
if "%SUB%"=="5" goto page5
if "%SUB%"=="6" goto page6
if "%SUB%"=="0" exit /b
goto :menu

:page1
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  TONG QUAN - WORDCOUNTER LA GI?                        %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%WordCounter%C_RST% la cong cu thong ke noi dung file
echo Word. Dem so tu, ky tu, dong, trang, va nhieu
echo thong so khac.
echo.
echo %C_BLD%Source code:%C_RST% src/core/counter.py
echo - count_document(): ham chinh
echo - CountResult dataclass: ket qua dem
echo - _detect_languages(): phat hieu ngon ngu
echo - _format_duration(): dinh dang thoi gian
echo.
echo %C_BLD%Nguyen ly hoat dong:%C_RST%
echo 1. Doc file Word bang python-docx qua parser
echo 2. Dem tung doan van rieng
echo 3. Tinh toan ky tu, tu, dong
echo 4. Uoc tinh so trang: words / 250
echo 5. Phat hieu ngon ngu bang regex
echo 6. Xac dinh cau truc headings
echo 7. Tinh thoi gian doc Viet va Anh
echo 8. Try Word COM de lay trang thuc te
echo.
echo %C_BLD%Yeu cau:%C_RST%
echo   - Python 3.8+
echo   - python-docx
echo   - File input .docx
echo   - Microsoft Word (cho trang thuc te)
echo.
pause
goto :menu

:page2
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CACH DUNG - CLI VA MENU                               %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%1. Lenh CLI:%C_RST%
echo   python src/main.py count "input.docx"
echo   Dem toan bo thong so, hien thi ket qua
echo.
echo %C_BLD%2. Luu ket qua ra file:%C_RST%
echo   python src/main.py count "input.docx" -o stats.txt
echo   Luu thong ke vao file text
echo.
echo %C_BLD%3. Qua Menu:%C_RST%
echo   Mo run.bat -> Menu 3
echo   Chon Dem so tu/trang
echo   Chon file can dem, xem ket qua
echo.
echo %C_BLD%4. Ket qua hien thi:%C_RST%
echo   - So luong: paragraphs, lines, words
echo   - Ky tu: co va khong dau cach
echo   - Trang: uoc tinh va thuc te
echo   - Thoi gian doc: Viet va Anh
echo   - Ngon ngu: phat hieu tu dong
echo   - Cau truc: headings, sections
echo.
echo %C_BLD%5. Tham so:%C_RST%
echo   - input: duong dan file .docx, bat buoc
echo   - -o:   file output, mac dinh khong luu
echo.
pause
goto :menu

:page3
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  THONG SO DUOC DEM                                     %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRN%Co ban:%CRST%
echo   Doan van (paragraphs):  so luong paragraph
echo   Dong (lines):           so luong dong co noi dung
echo   Tu (words):             so luong tu
echo   Ky tu (khong space):    chi ky tu thuong
echo   Ky tu (co space):       ky tu gom ca space
echo.
echo %C_YLW%Nang cao:%CRST%
echo   Trang uoc tinh:  words / 250 (WORDS_PER_PAGE)
echo   Trang thuc te:  qua Word COM neu co
echo   Sections:       so luong section trong file
echo   Headings:       so luong tung cap Heading 1-5
echo.
echo %C_CYA%Phat hieu:%CRST%
echo   Ngon ngu: regex pattern phat hieu Viet/Anh
echo   Headings: style_name bat dau bang "Heading"
echo   Images:   so luong hinh anh trong file
echo   Tables:   so luong bang trong file
echo.
echo %C_BLD%Luu y:%CRST%
echo   - Dem khong gom header/footer
echo   - Dem gom footnotes
echo   - Trang uoc tinh gan dung 85-90%%
echo.
pause
goto :menu

:page4
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  TINH TOAN TRANG                                       %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%1. Trang uoc tinh - Tinh toan:%C_RST%
echo   Cong thuc: words / 250 (WORDS_PER_PAGE = 250)
echo   250 tu = 1 trang A4 dung chuan
echo   Nhanh, khong can Microsoft Word
echo   Gan dung voi thuc te 85-90%%
echo.
echo %C_BLD%2. Trang thuc te - Word COM:%C_RST%
echo   Su dung Microsoft Word COM
echo   wd_doc.ComputeStatistics(2) = wdStatisticPages
echo   Dem chinh xac so trang
echo   Can Microsoft Word cai dat
echo   Chinh xac 100%%
echo.
echo %C_BLD%So sanh:%C_RST%
echo   Uoc tinh:  85-90%% chinh xac
echo   Thuc te:   100%% chinh xac
echo   Chenh lech: 1-2 trang phu thuoc format
echo.
echo %C_BLD%Khi nao dung nao:%C_RST%
echo   Uoc tinh: nhanh, khong can Word
echo   Thuc te:  chinh xac, can Word
echo   Dung uoc tinh khi can nhanh
echo   Dung thuc te khi can chinh xac
echo.
pause
goto :menu

:page5
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  THOI GIAN DOC                                          %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Tieng Viet%CRST% (WORDS_PER_MINUTE_VI = 200):
echo   1000 tu:   ~5 phut
echo   5000 tu:  ~25 phut
echo  10000 tu:  ~50 phut
echo  20000 tu: ~100 phut = 1 gio 40 phut
echo.
echo %C_BLD%Tieng Anh%CRST% (WORDS_PER_MINUTE_EN = 250):
echo   1000 tu:   ~4 phut
echo   5000 tu:  ~20 phut
echo  10000 tu:  ~40 phut
echo  20000 tu:  ~80 phut = 1 gio 20 phut
echo.
echo %C_BLD%Luu y:%CRST%
echo   - Toc do trung binh, co the chenh lech
echo   - Van ban hoc thuat doc cham hon
echo   - Van ban don gian doc nhanh hon
echo   - Ket qua la uoc tinh
echo.
echo %C_BLD%Tinh nang phat hieu:%C_RST%
echo   - Tu dong phat hieu ngon ngu
echo   - Tinh theo ngon ngu phat hien
echo   - Hien thi ca Viet va Anh
echo   - Dung regex patterns: ky tu dau Viet, word pattern Anh
echo.
pause
goto :menu

:page6
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  XU LY LOI                                              %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_RED%Loi 1: File not found%CRST%
echo   Nguyen nhan: File khong ton tai tai duong dan
echo   Giai phap: Kiem tra lai duong dan
echo   Dung "" cho path co dau cach
echo.
echo %C_RED%Loi 2: Cannot read file%CRST%
echo   Nguyen nhan: File bi hu hoac khong dung dinh dang
echo   Giai phap: Kiem tra file co mo duoc khong
echo   Dung file .docx
echo.
echo %C_RED%Loi 3: Word COM error%CRST%
echo   Nguyen nhan: Word khong cai dat
echo   Giai phap: Ket qua thuc te khong co
echo   Chi dem duoc uoc tinh
echo   Van hoat dong binh thuong
echo.
pause
goto :menu
