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
echo %C_CYA%%C_BLD%         10. DEM TU VA TRANG                          %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan
echo %C_YLW%  2.%C_RST% Cach dung (CLI + Menu)
echo %C_YLW%  3.%C_RST% Thong so dem duoc
echo %C_YLW%  4.%C_RST% Trang uoc tinh vs thuc te
echo %C_YLW%  5.%C_RST% Thoi gian doc
echo %C_YLW%  6.%C_RST% Phat hieu ngon ngu
echo %C_YLW%  7.%C_RST% Cau truc headings
echo %C_YLW%  8.%C_RST% Vi du + Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto :tongquan
if "%SUB%"=="2" goto :cachdung
if "%SUB%"=="3" goto :thongso
if "%SUB%"=="4" goto :trang
if "%SUB%"=="5" goto :thoigian
if "%SUB%"=="6" goto :ngonngu
if "%SUB%"=="7" goto :headings
if "%SUB%"=="8" goto :viduloi
if "%SUB%"=="0" exit /b
goto :menu

:tongquan
cls
echo.
echo %C_CYA%--- TONG QUAN ---%C_RST%
echo.
echo  %C_WHT%WordCounter%C_RST% dem so tu, ky tu, dong, trang va thoi gian
echo  doc cua file Word. Phat hieu cau truc headings va
echo  ngon ngu su dung.
echo.
echo %C_CYA%  Cong nghe:%C_RST%
echo  %C_GRY%-%C_RST% Python: doc file, dem paragraphs, words, chars
echo  %C_GRY%-%C_RST% Word COM: dem trang thuc te (neu co Microsoft Word)
echo  %C_GRY%-%C_RST% Regex: phat hieu ngon ngu (VI/EN)
echo.
echo %C_CYA%  Khong can Microsoft Word.%C_RST%  Trang thuc te chi co
echo  khi cai Word. Khong co Word -> chi dem duoc uoc tinh.
echo.
pause
goto :menu

:cachdung
cls
echo.
echo %C_CYA%--- CACH DUNG ---%C_RST%
echo.
echo %C_CYA%  CLI:%C_RST%
echo  %C_WHT%python src/main.py count "input.docx"%C_RST%
echo.
echo %C_CYA%  Menu:%C_RST%
echo  %C_GRY%1.%C_RST% Chay %C_WHT%run.bat%C_RST%
echo  %C_GRY%2.%C_RST% Menu 3 - Tien ich
echo  %C_GRY%3.%C_RST% Chon 3 - Dem so tu/trang
echo.
echo %C_CYA%  Tham so:%C_RST%
echo  %C_YLW%input%C_RST%  File .doc/.docx can dem
echo.
echo %C_CYA%  Ket qua hien thi:%C_RST%
echo  %C_GRY%  So doan, dong, tu, ky tu (co/khong space)%C_RST%
echo  %C_GRY%  Trang uoc tinh + trang thuc te (neu co Word)%C_RST%
echo  %C_GRY%  Thoi gian doc (VI: 200 tu/ph, EN: 250 tu/ph)%C_RST%
echo  %C_GRY%  So section, headings theo level%C_RST%
echo  %C_GRY%  Ngon ngu phat hien%C_RST%
echo.
pause
goto :menu

:thongso
cls
echo.
echo %C_CYA%--- THONG SO DEM DUOC ---%C_RST%
echo.
echo  %C_YLW%  So luong:%C_RST%
echo  %C_GRY%  paragraphs:    So doan van (ca doan trong)%C_RST%
echo  %C_GRY%  lines:         So dong co noi dung (khong tinh dong trong)%C_RST%
echo  %C_GRY%  words:         So tu (tach theo khoang trang)%C_RST%
echo  %C_GRY%  chars_no_space: Ky tu khong tinh khoang trang/tab%C_RST%
echo  %C_GRY%  chars_with_space: Ky tu tinh ca khoang trang%C_RST%
echo.
echo  %C_YLW%  Trang:%C_RST%
echo  %C_GRY%  pages_estimated: words / 250 (uong tinh)%C_RST%
echo  %C_GRY%  pages_actual:    Trang that su qua Word COM (neu co)%C_RST%
echo.
echo  %C_YLW%  Thoi gian doc:%C_RST%
echo  %C_GRY%  reading_time_vi:  words / 200 tu/phut%C_RST%
echo  %C_GRY%  reading_time_en:  words / 250 tu/phut%C_RST%
echo.
echo  %C_YLW%  Cau truc:%C_RST%
echo  %C_GRY%  sections:    So section trong file%C_RST%
echo  %C_GRY%  headings:    So Heading theo level (Heading 1: 5, Heading 2: 12...)%C_RST%
echo.
echo  %C_YLW%  Ngon ngu:%C_RST%
echo  %C_GRY%  languages_detected:  Tieng Viet, English...%C_RST%
echo.
pause
goto :menu

:trang
cls
echo.
echo %C_CYA%--- TRANG UOC TINH VS THUC TE ---%C_RST%
echo.
echo %C_CYA%  Uoc tinh (khong can Word):%C_RST%
echo  %C_GRY%Cong thuc: pages = ceil(words / 250)%C_RST%
echo  %C_GRY%Tuc la 250 tu = 1 trang (trung binh)%C_RST%
echo  %C_GRY%-> Dung cho file van ban thong thuong%C_RST%
echo  %C_GRY%-> Khong chinh xac voi file nhieu bang/hinh%C_RST%
echo.
echo %C_CYA%  Thuc te (can Microsoft Word):%C_RST%
echo  %C_GRY%Su dung Word COM: doc.ComputeStatistics(2)%C_RST%
echo  %C_GRY%-> Tinh chinh xac 100%% trang%C_RST%
echo  %C_GRY%-> Can Microsoft Word da cai + kich hoat%C_RST%
echo  %C_GRY%-> Tu dong fallback neu khong co Word%C_RST%
echo.
echo %C_CYA%  So sanh:%C_RST%
echo  %C_GRY%Uoc tinh:  1000 tu = 4 trang%C_RST%
echo  %C_GRY%Thuc te:   Co the 3-5 trang tuy layout, margin, font size%C_RST%
echo.
pause
goto :menu

:thoigian
cls
echo.
echo %C_CYA%--- THOI GIAN DOC ---%C_RST%
echo.
echo  Tinh theo toc do doc trung binh:
echo.
echo %C_YLW%  Tieng Viet:%C_RST%  200 tu/phut
echo  %C_GRY% -> 500 tu = 2.5 phut, 2000 tu = 10 phut%C_RST%
echo.
echo %C_YLW%  English:%C_RST%     250 tu/phut
echo  %C_GRY%  -> 500 tu = 2 phut, 2000 tu = 8 phut%C_RST%
echo.
echo  %C_CYA%  Dinh dang:%C_RST%
echo  %C_GRY%  < 1 phut  -> "< 1 phut"%C_RST%
echo  %C_GRY%  5 phut    -> "5 phut"%C_RST%
echo  %C_GRY%  65 phut   -> "1 gio 5 phut"%C_RST%
echo  %C_GRY%  120 phut  -> "2 gio"%C_RST%
echo.
echo  %C_CYA%  Luu y:%C_RST%
echo  %C_GRY%-%C_RST% Day la thoi gian doc thuan, khong tinh nghi
echo  %C_GRY%-%C_RST% Thuc te co the cham hon (hoc, nghi, ghi chu)
echo.
pause
goto :menu

:ngonngu
cls
echo.
echo %C_CYA%--- PHAT HIU NGON NGU ---%C_RST%
echo.
echo  Su dung regex de phat hieu ngon ngu chinh.
echo.
echo %C_CYA%  Tieng Viet:%C_RST%
echo  %C_GRY%  Regex: kiem tra ky tu dau mau Viet (a, e, o, u...)%C_RST%
echo  %C_GRY%  Neu tim thay -> "Tieng Viet"%C_RST%
echo.
echo %C_CYA%  English:%C_RST%
echo  %C_GRY%  Regex: word boundary + 3+ ky tu a-z%A-Z%C_RST%
echo  %C_GRY%  Neu > 10 tu Anh -> "English"%C_RST%
echo.
echo %C_CYA%  Ket qua:%C_RST%
echo  %C_GRY%  Co the phat hieu ca 2 ngon ngu (VI + EN)%C_RST%
echo  %C_GRY%  File tron hop -> hien thi ca hai%C_RST%
echo.
pause
goto :menu

:headings
cls
echo.
echo %C_CYA%--- CAU TRUC HEADINGS ---%C_RST%
echo.
echo  Dem so luong headings theo level.
echo.
echo %C_CYA%  Cach phat hieu:%C_RST%
echo  %C_GRY%  Kiem tra style name cua moi paragraph%C_RST%
echo  %C_GRY%  Neu style name bat dau bang "Heading" -> dem%C_RST%
echo  %C_GRY%  Luu theo level: "Heading 1", "Heading 2"...%C_RST%
echo.
echo %C_CYA%  Vi du ket qua:%C_RST%
echo  %C_GRY%  Sections: 3%C_RST%
echo  %C_GRY%  Heading 1: 5  (5 chuong)%C_RST%
echo  %C_GRY%  Heading 2: 12 (12 muc con)%C_RST%
echo  %C_GRY%  Heading 3: 8  (8 muc con cap 3)%C_RST%
echo.
echo  %C_CYA%  Luu y:%C_RST%  Chi dem headings co style Word chuan.
echo  Neu text la "1.1" nhung khong dat style "Heading 2" -> khong dem.
echo.
pause
goto :menu

:viduloi
cls
echo.
echo %C_CYA%--- VI DU + XU LY LOI ---%C_RST%
echo.
echo %C_CYA%  Vi du:%C_RST%
echo  %C_WHT%python src/main.py count "baocao.docx"%C_RST%
echo  %C_GRY%  File: baocao.docx%C_RST%
echo  %C_GRY%  Doan: 45, Dong: 120, Tu: 3500%C_RST%
echo  %C_GRY%  Ky tu (khong space): 18000, Ky tu (co space): 21000%C_RST%
echo  %C_GRY%  Trang (du dinh): 14, Trang (thuc te): 16%C_RST%
echo  %C_GRY%  Thoi gian doc VI: 17 phut 30 giay%C_RST%
echo  %C_GRY%  Thoi gian doc EN: 14 phut%C_RST%
echo  %C_GRY%  Sections: 1, Heading 1: 5, Heading 2: 12%C_RST%
echo  %C_GRY%  Ngon ngu: Tieng Viet, English%C_RST%
echo.
echo %C_RED%  Loi: "File not found"%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra lai duong dan file
echo  %C_GRY%-%C_RST% Dung quotes: %C_WHT%count "D:\files\baocao.docx"%C_RST%
echo.
echo %C_RED%  Loi: "Cannot read .doc file"%C_RST%
echo  %C_GRY%-%C_RST% Can Microsoft Word cho .doc
echo  %C_GRY%-%C_RST% .docx khong can Word (python-docx)
echo.
pause
goto :menu
