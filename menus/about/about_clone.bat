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
echo %C_CYA%%C_BLD%  CLONE DINH DANG TU TEMPLATE                            %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan - Clone la gi?
echo %C_YLW%  2.%C_RST% Clone vs Clone-preview
echo %C_YLW%  3.%C_RST% Quy trinh hoat dong
echo %C_YLW%  4.%C_RST% Cach dung - CLI va Menu
echo %C_YLW%  5.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto page1
if "%SUB%"=="2" goto page2
if "%SUB%"=="3" goto page3
if "%SUB%"=="4" goto page4
if "%SUB%"=="5" goto page5
if "%SUB%"=="0" exit /b
goto :menu

:page1
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  TONG QUAN - CLONE LA GI?                               %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%CloneEngine%C_RST% sao chep toan bo dinh dang tu file
echo template sang file moi. Khong chi dinh dang van ban
echo ma con ca cau truc trang, header, footer, watermark...
echo.
echo %C_BLD%Source code:%C_RST% src/core/cloner.py
echo - Class CloneEngine: clone() va clone(preview_only=True)
echo - Su dung win32com.client DispatchEx Word.Application
echo - COM retry voi RPC_E_CALL_REJECTED, max 10 retries
echo.
echo %C_BLD%Nguyen ly hoat dong:%C_RST%
echo 1. Copy template thanh file tam
echo 2. Mo file tam, xoa toan bo noi dung
echo   - Giu nguyen header, footer, style definitions
echo 3. Mo file target, copy toan bo noi dung
echo 4. Paste vao file tam voi PasteAndFormat (WD 16)
echo 5. Luu file output
echo.
echo %C_BLD%Khac voi Format:%C_RST%
echo   Format: dinh dang van ban theo rules (python-docx)
echo   Clone: sao chep cau truc trang va template (win32com)
echo   Clone ho tro: section, page setup, watermark, TOC, columns
echo.
echo %C_BLD%Yeu cau he thong:%C_RST%
echo   - Microsoft Word da cai dat
echo   - Python 3.8+
echo   - pywin32 da cai
echo.
pause
goto :menu

:page2
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CLONE VS CLONE-PREVIEW                                %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Clone%C_RST% - Sao chep hoan chinh
echo   - Copy template + dung noi dung target
echo   - Luu file output ngay lap tuc
echo   - Khong mo Word de review
echo   - Nhanh, phu hop xu ly hang loat
echo.
echo %C_BLD%Clone-preview%C_RST% - Xem truoc truoc khi luu
echo   - Copy template + dung noi dung target
echo   - Mo Word de ban review
echo   - Ban kiem tra, chinh sua neu can
echo   - Luu thu cong khi hai long
echo   - An toan, tranh sai sot
echo.
echo %C_BLD%Khi nao dung nao:%C_RST%
echo   Clone: chac chan, khong can review
echo   Clone-preview: can kiem tra truoc
echo   Dung clone-preview lan dau
echo   Dung clone khi da quen voi quy trinh
echo.
echo %C_BLD%Luu y:%C_RST%
echo   - Ca hai deu can Microsoft Word
echo   - Preview mo Word, ban tu dong luu khi dong
echo   - Khong dong Word khi dang preview
echo.
pause
goto :menu

:page3
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  QUY TRINH HOAT DONG                                   %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRN%Buoc 1%CRST% - Copy template
echo   - Doc file template.docx
echo   - Copy thanh file tam (tempfile.mktemp)
echo   - Giu nguyen toan bo cau truc
echo.
echo %C_GRN%Buoc 2%CRST% - Xoa noi dung
echo   - Mo file tam bang Word COM
echo   - Xoa tat ca doan van (Range.Delete)
echo   - Giu nguyen header, footer
echo   - Giu nguyen style definitions
echo.
echo %C_GRN%Buoc 3%CRST% - Copy noi dung target
echo   - Mo file target.docx
echo   - Selection.WholeStory -> Copy
echo   - Dong file target
echo.
echo %C_GRN%Buoc 4%CRST% - Paste vao template
echo   - Mo file tam
echo   - PasteAndFormat(WD_PASTE_ORIGINAL = 16)
echo   - Dung lai mau sac ban dau
echo.
echo %C_GRN%Buoc 5%CRST% - Luu output
echo   - SaveAs(output_path, save_format)
echo   - Dong Word COM
echo   - Xoa file tam
echo   - Bao cao ket qua
echo.
echo %C_BLD%Tong thoi gian:%C_RST% 2-5 giay tuy kich thuoc file
echo.
pause
goto :menu

:page4
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CACH DUNG - CLI VA MENU                               %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%1. Clone hoan chinh:%C_RST%
echo   python src/main.py clone "template.docx" "target.docx" -o output.docx
echo   Template: file mau can sao chep
echo   Target: file co noi dung
echo   Output: file ket qua
echo.
echo %C_BLD%2. Clone-preview:%C_RST%
echo   python src/main.py clone-preview "template.docx" "target.docx"
echo   Mo Word de review
echo   Kiem tra ket qua, luu thu cong
echo.
echo %C_BLD%3. Qua Menu:%C_RST%
echo   Mo run.bat -> Menu 2
echo   Chon Clone hoac Clone-preview
echo   Nhap duong dan khi yeu cau
echo.
echo %C_BLD%4. Tham so:%C_RST%
echo   - -o: duong dan xuat, mac dinh target_cloned.ext
echo   - Template: .docx hoac .doc
echo   - Target: .docx hoac .doc
echo   - Output khong duoc giong target
echo.
echo %C_BLD%5. Tinh nang ho tro:%C_RST%
echo   - Section va Page Setup: A4, margins, orientation
echo   - Header/Footer: noi dung, dinh dang
echo   - Watermark: van ban, hinh anh
echo   - TOC: muc luc tu dong
echo   - Columns: so cot trang
echo   - Style definitions: Normal, Heading, Quote...
echo.
pause
goto :menu

:page5
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  XU LY LOI                                              %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_RED%Loi 1: Cannot initialize Word COM%CRST%
echo   Nguyen nhan: Microsoft Word khong cai dat
echo   Giai phap: Cai dat Microsoft Word/Office
echo   Kiem tra: Word co mo duoc khong
echo   Alternative: dung Format thay the
echo.
echo %C_RED%Loi 2: COM busy - Word dang ban%CRST%
echo   Nguyen nhan: Word dang xu ly tac vu khac
echo   Giai phap: Dong tat ca file Word
echo   Doi 5 giay roi thu lai
echo   CloneEngine tu dong retry (max 10 lan)
echo.
echo %C_RED%Loi 3: Template not found%CRST%
echo   Nguyen nhan: File template khong ton tai
echo   Giai phap: Kiem tra lai duong dan
echo   Dung "" cho path co dau cach
echo.
echo %C_RED%Loi 4: Access denied%CRST%
echo   Nguyen nhan: File dang mo hoac khong co quyen
echo   Giai phap: Dong file truoc khi clone
echo   Kiem tra quyen ghi thu muc output
echo.
echo %C_RED%Loi 5: pywin32 not installed%CRST%
echo   Nguyen nhan: Chua cai pywin32
echo   Giai phap: pip install -r requirements.txt
echo   Kiem tra: python -c "import win32com.client"
echo.
pause
goto :menu
