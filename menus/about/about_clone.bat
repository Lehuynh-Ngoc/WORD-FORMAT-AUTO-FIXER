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
echo  %C_BLD%%C_CYA  CLONE + CLONE-PREVIEW                     %C_RST%
echo  %C_BLD%%C_CYA  Clone - Sao chep dinh dang                 %C_RST%
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo.
echo  %C_GRN%[1]%C_RST%  Tong quan - Clone la gi?
echo  %C_GRN%[2]%C_RST%  Clone vs Clone-preview
echo  %C_GRN%[3]%C_RST%  Quy trinh hoat dong
echo  %C_GRN%[4]%C_RST%  Cach dung
echo  %C_GRN%[5]%C_RST%  Tinh nang ho tro
echo  %C_GRN%[6]%C_RST%  Vi du thuc te
echo  %C_GRN%[7]%C_RST%  Xu ly loi
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
echo  %C_BLD%%C_CYA  TONG QUAN - CLONE LA GI?                   %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%CloneEngine%C_RST% sao chep toan bo dinh dang tu file
echo  template sang file moi. Khong chi dinh dang van ban
echo  ma con ca cau truc trang, header, footer...
echo.
echo  %C_BLD%Nguyen ly hoat dong:%C_RST%
echo  - Su dung Microsoft Word COM - win32com
echo  - Copy template thanh file moi
echo  - Xoa noi dung file copy
echo  - Dua noi dung file target vao
echo  - Giu nguyen toan bo dinh dang
echo  - Luu file output
echo.
echo  %C_BLD%Khac voi Format:%C_RST%
echo  - Format: dinh dang van ban theo rules
echo  - Clone: sao chep cau truc trang va template
echo  - Clone ho tro nhieu tinh nang hon
echo  - Can Microsoft Word cai dat
echo.
echo  %C_BLD%Yeu cau he thong:%C_RST%
echo  - Microsoft Word da cai dat
echo  - Python 3.8+
echo  - win32com da cai
echo.
pause
goto menu

:page2
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  CLONE VS CLONE-PREVIEW                     %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Clone%C_RST% - Sao chep hoan chinh
echo  - Copy template + dung noi dung target
echo  - Luu file output ngay lap tuc
echo  - Khong mo Word de review
echo  - Nhanh, phu hop xu ly hang loat
echo.
echo  %C_BLD%Clone-preview%C_RST% - Xem truoc truoc khi luu
echo  - Copy template + dung noi dung target
echo  - Mo Word de ban review
echo  - Ban kiem tra, chinh sua neu can
echo  - Luu thu cong khi hai long
echo  - An toan, tranh sai sot
echo.
echo  %C_BLD%Khi nao dung nao:%C_RST%
echo  - Clone: chac chan, khong can review
echo  - Clone-preview: can kiem tra truoc
echo  - Dung clone-preview lan dau
echo  - Dung clone khi da quen voi quy trinh
echo.
echo  %C_BLD%Luu y:%C_RST%
echo  - Ca hai deu can Microsoft Word
echo  - Clone-preview mo Word, ban tu dong luu
echo  - Khong dong Word khi dang preview
echo.
pause
goto menu

:page3
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  QUY TRINH HOAT DONG                       %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_GRN%Buoc 1%C_RST% - Copy template
echo  - Doc file template.docx
echo  - Copy thanh file tam
echo  - Giu nguyen toan bo cau truc
echo.
echo  %C_GRN%Buoc 2%C_RST% - Xoa noi dung
echo  - Mo file copy
echo  - Xoa tat ca doan van
echo  - Giu nguyen header, footer
echo  - Giu nguyen style definitions
echo.
echo  %C_GRN%Buoc 3%C_RST% - Dua noi dung target
echo  - Doc file target.docx
echo  - Copy tung doan van
echo  - Chen vao file copy
echo  - Dung lai mau sac ban dau
echo.
echo  %C_GRN%Buoc 4%C_RST% - Luu output
echo  - Luu file output.docx
echo  - Dong Word COM
echo  - Bao cao ket qua
echo.
echo  %C_BLD%Tong thoi gian:%C_RST% 2-5 giay tuy kich thuoc file
echo.
pause
goto menu

:page4
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  CACH DUNG                                  %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%1. Clone hoan chinh:%C_RST%
echo  python src/main.py clone "template.docx" "target.docx" -o output.docx
echo  - Template: file mau can sao chep
echo  - Target: file co noi dung
echo  - Output: file ket qua
echo.
echo  %C_BLD%2. Clone-preview:%C_RST%
echo  python src/main.py clone-preview "template.docx" "target.docx"
echo  - Mo Word de review
echo  - Kiem tra ket qua
echo  - Luu thu cong
echo.
echo  %C_BLD%3. Qua Menu:%C_RST%
echo  - Mo run.bat -> Menu 2
echo  - Chon Clone hoac Clone-preview
echo  - Nhap duong dan khi yeu cau
echo.
echo  %C_BLD%4. Tham so:%C_RST%
echo  - -o: duong dan xuat, mac dinh outputs/
echo  - Template phai la .docx hoac .doc
echo  - Target phai la .docx hoac .doc
echo.
pause
goto menu

:page5
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  TINH NANG HO TRO                           %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  CloneEngine ho tro sao chep cac thanh phan sau:
echo.
echo  %C_GRN%1. Section va Page Setup%C_RST%
echo  - Kich thuoc trang: A4, A5, Letter...
echo  - Co le trang: tren, duoi, trai, phai
echo  - Huong trang: ngang/doc
echo  - Margins: top, bottom, left, right
echo.
echo  %C_GRN%2. Header va Footer%C_RST%
echo  - Noi dung header, footer
echo  - Dinh dang header, footer
echo  - First page header/footer
echo  - Odd/even page headers
echo.
echo  %C_GRN%3. Watermark%C_RST%
echo  - Watermark van ban
echo  - Watermark hinh anh
echo  - Muc do trong suot
echo.
echo  %C_GRN%4. TOC va Columns%C_RST%
echo  - Muc luc tu dong
echo  - So cot trang
echo  - Width cua tung cot
echo.
echo  %C_GRN%5. Styles%C_RST%
echo  - Style definitions tu template
echo  - Normal, Heading, Quote...
echo  - TNR, Arial, va cac font khac
echo.
pause
goto menu

:page6
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  VI DU THUC TE                              %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Vi du 1: Don xin phep%C_RST%
echo  - Template: mau_don_xin_phep.docx
echo  - Co header logo, footer trang so
echo  - Target: noi dung don
echo  - Ket qua: Don co dinh dang template
echo.
echo  %C_BLD%Vi du 2: Luan van%C_RST%
echo  - Template: mau_luan_van.docx
echo  - Co TOC, header, margins dac biet
echo  - Target: noi dung luan van
echo  - Ket qua: Luan van dung mau
echo.
echo  %C_BLD%Vi du 3: Bao cao cong ty%C_RST%
echo  - Template: mau_bao_cao.docx
echo  - Co watermark, header ngay
echo  - Target: noi dung bao cao
echo  - Ket qua: Bao cao chinh thuc
echo.
echo  %C_BLD%Vi du 4: Phieu bien ban%C_RST%
echo  - Template: mau_bien_ban.docx
echo  - Co cot ngang, footer
echo  - Target: noi dung bien ban
echo  - Ket qua: Bien ban dung mau
echo.
pause
goto menu

:page7
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  XU LY LOI                                  %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_RED%Loi 1: Cannot initialize Word COM%C_RST%
echo  - Nguyen nhan: Microsoft Word khong cai dat
echo  - Giai phap: Cai dat Microsoft Word
echo  - Hoac dung Office 365 Online
echo  - Kiem tra Word dang chay
echo.
echo  %C_RED%Loi 2: COM busy - Word dang ban%C_RST%
echo  - Nguyen nhan: Word dang mo file khac
echo  - Giai phap: Dong tat ca file Word
echo  - Doi 5 giay roi thu lai
echo  - Khoi dong lai Word neu can
echo.
echo  %C_RED%Loi 3: Template not found%C_RST%
echo  - Nguyen nhan: File template khong ton tai
echo  - Giai phap: Kiem tra lai duong dan
echo  - Dung "" cho path co dau cach
echo  - Kiem tra file ton tai khong
echo.
echo  %C_RED%Loi 4: Access denied%C_RST%
echo  - Nguyen nhan: File dang mo hoac khong co quyen
echo  - Giai phap: Dong file truoc khi clone
echo  - Kiem tra quyen ghi thu muc output
echo.
echo  %C_RED%Loi 5: Output directory not found%C_RST%
echo  - Nguyen nhan: Thu muc outputs/ chua ton tai
echo  - Giai phap: Tao thu muc outputs/ truoc
echo  - Hoac chay init de tao cau truc
echo.
pause
goto menu

:end
endlocal
exit /b 0
