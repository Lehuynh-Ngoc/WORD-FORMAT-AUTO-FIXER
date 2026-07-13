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
echo  %C_BLD%%C_CYA  DEM TU/TRANG                              %C_RST%
echo  %C_BLD%%C_CYA  Word Counter - Thong ke van ban            %C_RST%
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo.
echo  %C_GRN%[1]%C_RST%  Tong quan - WordCounter la gi?
echo  %C_GRN%[2]%C_RST%  Thong so duoc dem
echo  %C_GRN%[3]%C_RST%  Tinh toan trang
echo  %C_GRN%[4]%C_RST%  Thoi gian doc
echo  %C_GRN%[5]%C_RST%  Phat hieu ngon ngu
echo  %C_GRN%[6]%C_RST%  Cach dung
echo  %C_GRN%[7]%C_RST%  Vi du va loi
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
echo  %C_BLD%%C_CYA  TONG QUAN - WORDCOUNTER LA GI?             %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%WordCounter%C_RST% la cong cu thong ke noi dung file
echo  Word. Dem so tu, ky tu, dong, trang, va nhieu
echo  thong so khac.
echo.
echo  %C_BLD%Nguyen ly hoat dong:%C_RST%
echo  - Doc file Word bang python-docx
echo  - Dem tung doan van rieng
echo  - Tinh toan ky tu, tu, dong
echo  - Uoc tinh so trang
echo  - Phat hieu ngon ngu van ban
echo  - Xac dinh cau truc headings
echo.
echo  %C_BLD%Muc dich:%C_RST%
echo  - Dem so tu cho bao cao, luan van
echo  - Kiem tra do dai van ban
echo  - Thong ke noi dung file Word
echo  - Ho tro viec viet van ban
echo.
echo  %C_BLD%Yeu cau:%C_RST%
echo  - Python 3.8+
echo  - python-docx
echo  - File input .docx
echo.
pause
goto menu

:page2
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  THONG SO DUOC DEM                          %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_GRN%Co ban:%C_RST%
echo  - Doan van: so luong paragraph
echo  - Dong: so luong dong van ban
echo  - Tu: so luong tu
echo  - Ky tu co dau cach: ky tu gom ca space
echo  - Ky tu khong dau cach: chi ky tu thuong
echo.
echo  %C_YLW%Nang cao:%C_RST%
echo  - Trang uoc tinh: words / 250
echo  - Trang thuc te: qua Word COM neu co
echo  - Thoi gian doc Viet: ~200 tu/phut
echo  - Thoi gian doc Anh: ~250 tu/phut
echo.
echo  %C_CYA%Phat hieu:%C_RST%
echo  - Ngon ngu van ban: regex patterns
echo  - Headings: Heading 1-5
echo  - Sections: cau truc van ban
echo  - Images: so luong hinh anh
echo  - Tables: so luong bang
echo.
echo  %C_BLD%Luu y:%C_RST%
echo  - Dem khong gom header/footer
echo  - Dem gom footnotes
echo  - Trang uoc tinh gan dung 90%%
echo.
pause
goto menu

:page3
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  TINH TOAN TRANG                            %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%1. Trang uoc tinh - Tinh toan:%C_RST%
echo  - Cong thuc: so tu / 250
echo  - 250 tu = 1 trang A4 dung chuan
echo  - Nhanh, khong can Word
echo  - Gan dung voi thuc te 85-90%%
echo.
echo  %C_BLD%2. Trang thuc te - Word COM:%C_RST%
echo  - Su dung Microsoft Word COM
echo  - Dem chinh xac so trang
echo  - Can Microsoft Word cai dat
echo  - Chinh xac 100%%
echo.
echo  %C_BLD%So sanh:%C_RST%
echo  - Uoc tinh: 85-90%% chinh xac
echo  - Thuc te: 100%% chinh xac
echo  - Chenh lech: 1-2 trang
echo  - Phu thuoc vao format
echo.
echo  %C_BLD%Khi nao dung nao:%C_RST%
echo  - Uoc tinh: nhanh, khong can Word
echo  - Thuc te: chinh xac, can Word
echo  - Dung uoc tinh khi can nhanh
echo  - Dung thuc te khi can chinh xac
echo.
pause
goto menu

:page4
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  THOI GIAN DOC                              %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Tieng Viet:%C_RST%
echo  - Toc do doc: ~200 tu/phut
echo  - 1000 tu: ~5 phut
echo  - 5000 tu: ~25 phut
echo  - 10000 tu: ~50 phut
echo  - 20000 tu: ~100 phut = 1.7 gio
echo.
echo  %C_BLD%Tieng Anh:%C_RST%
echo  - Toc do doc: ~250 tu/phut
echo  - 1000 tu: ~4 phut
echo  - 5000 tu: ~20 phut
echo  - 10000 tu: ~40 phut
echo  - 20000 tu: ~80 phut = 1.3 gio
echo.
echo  %C_BLD%Luu y:%C_RST%
echo  - Toc do trung binh, co the chenh lech
echo  - Van ban hoc thuat doc cham hon
echo  - Van ban don gian doc nhanh hon
echo  - Ket qua la uoc tinh
echo.
echo  %C_BLD%Tinh nang:%C_RST%
echo  - Tu dong phat hieu ngon ngu
echo  - Tinh theo ngon ngu phat hien
echo  - Hien thi ca Viet va Anh
echo.
pause
goto menu

:page5
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  PHAT HIU NGON NGU                          %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Nguyen ly:%C_RST%
echo  - Dung regex patterns phat hieu ngon ngu
echo  - Kiem tra ky tu dac biet
echo  - Tinh ty le ky tu ngon ngu
echo  - Chon ngon ngu co ty le cao nhat
echo.
echo  %C_BLD%Ngon ngu ho tro:%C_RST%
echo  - Tieng Viet: a, a, e, o, o, u, ky tu dau
echo  - Tieng Anh: a-z, khong co ky tu dau
echo  - Tieng Trung: ky tu Han
echo  - Tieng Nhat: Hiragana, Katakana
echo  - Tieng Han: Hangul
echo.
echo  %C_BLD%Cau truc phat hieu:%C_RST%
echo  - Headings: Heading 1-5
echo  - Normal: doan van binh thuong
echo  - Title: tieu de chinh
echo  - Sections: cac muc trong van ban
echo  - Images: hinh anh trong file
echo  - Tables: bang trong file
echo.
echo  %C_BLD%Ket qua:%C_RST%
echo  - Ngon ngu phat hien: hien thi dau tien
echo  - Headings: so luong tung cap
echo  - Sections: tong so muc
echo.
pause
goto menu

:page6
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  CACH DUNG                                  %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%1. Lenh CLI:%C_RST%
echo  python src/main.py count "input.docx"
echo  - Dem toan bo thong so
echo  - Hien thi ket qua chi tiet
echo.
echo  %C_BLD%2. Qua Menu:%C_RST%
echo  - Mo run.bat -> Menu 3
echo  - Chon Dem so tu/trang
echo  - Chon file can dem
echo  - Xem ket qua
echo.
echo  %C_BLD%3. Ket qua hien thi:%C_RST%
echo  - Tong quan: paragraphs, lines, words
echo  - Ky tu: co va khong dau cach
echo  - Trang: uoc tinh va thuc te
echo  - Thoi gian doc: Viet va Anh
echo  - Ngon ngu: phat hien tu dong
echo.
echo  %C_BLD%4. Tham so:%C_RST%
echo  - Input: duong dan file .docx
echo  - Khong can tham so khac
echo  - Tu dong phat hieu ngon ngu
echo.
echo  %C_BLD%5. Output:%C_RST%
echo  - Hien thi truc tiep tren terminal
echo  - Khong tao file output
echo  - Format dep voi mau sac
echo.
pause
goto menu

:page7
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  VI DU VA LOI                               %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Vi du 1: Dem luan vanViet%C_RST%
echo  - File: luan_van.docx
echo  - 20000 tu, 80 trang uoc tinh
echo  - 78 trang thuc te
echo  - Thoi gian doc: 100 phut
echo  - Ngon ngu: Tieng Viet
echo.
echo  %C_BLD%Vi du 2: Dem bao cao Anh%C_RST%
echo  - File: report.docx
echo  - 5000 tu, 20 trang uoc tinh
echo  - 19 trang thuc te
echo  - Thoi gian doc: 20 phut
echo  - Ngon ngu: Tieng Anh
echo.
echo  %C_RED%Loi pho bien:%C_RST%
echo.
echo  %C_RED%File not found%C_RST%
echo  - File khong ton tai tai duong dan
echo  - Kiem tra lai duong dan
echo  - Dung "" cho path co dau cach
echo.
echo  %C_RED%Cannot read file%C_RST%
echo  - File bi hu hoac khong dung dinh dang
echo  - Kiem tra file co mo duoc khong
echo  - Dung file .docx
echo.
echo  %C_RED%Word COM error%C_RST%
echo  - Word khong cai dat
echo  - Ket qua thuc te khong co
echo  - Chi dem duoc uoc tinh
echo.
pause
goto menu

:end
endlocal
exit /b 0
