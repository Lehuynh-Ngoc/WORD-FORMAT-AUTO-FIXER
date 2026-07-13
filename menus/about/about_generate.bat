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
echo  %C_BLD%%C_CYA  TAO VAN BAN AI                             %C_RST%
echo  %C_BLD%%C_CYA  DocGenerator - AI Document Builder        %C_RST%
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo.
echo  %C_GRN%[1]%C_RST%  Tong quan - Generate la gi?
echo  %C_GRN%[2]%C_RST%  19 Loai van ban ho tro
echo  %C_GRN%[3]%C_RST%  Quy trinh Q&A
echo  %C_GRN%[4]%C_RST%  Dinh dang output
echo  %C_GRN%[5]%C_RST%  Cach dung
echo  %C_GRN%[6]%C_RST%  Vi du thuc te
echo  %C_GRN%[7]%C_RST%  Meo va loi
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
echo  %C_BLD%%C_CYA  TONG QUAN - GENERATE LA GI?                %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%DocGenerator%C_RST% tao van ban Word hoan chinh
echo  su dung AI. Quy trinh hoi dap: AI dat cau hoi,
echo  ban tra loi, AI viet noi dung theo cau tra loi.
echo.
echo  %C_BLD%Nguyen ly hoat dong:%C_RST%
echo  - Chon loai van ban can tao
echo  - AI dat cac cau hoi lien quan
echo  - Ban tra loi tung cau hoi
echo  - AI viet noi dung dua tren tra loi
echo  - Dinh dang van ban theo mau
echo  - Luu thanh file .docx
echo.
echo  %C_BLD%Uu diem:%C_RST%
echo  - Tao van ban nhanh, tiet kiem thoi gian
echo  - Dinh dang chuan, chinh xac
echo  - Phu hop van ban Viet Nam
echo  - 19 loai van ban pho bien
echo.
echo  %C_BLD%Yeu cau:%C_RST%
echo  - Python 3.8+
echo  - AI provider da cai dat
echo  - API key hop le
echo.
pause
goto menu

:page2
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  19 LOAI VAN BAN HO TRO                     %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_GRN%Van ban hanh chinh:%C_RST%
echo   1.  Don xin phep
echo   2.  Don xin viec
echo   3.  Thu ming
echo   4.  Cong van
echo   5.  Quyet dinh
echo   6.  Thong bao
echo.
echo  %C_YLW%Van ban hoc thuat:%C_RST%
echo   7.  Bao cao
echo   8.  De cuong
echo   9.  Luan van
echo  10.  Phuc trinh
echo  11.  Bieu mau
echo.
echo  %C_CYA%Van ban cong ty:%C_RST%
echo  12.  Bien ban hop
echo  13.  Phieu bien ban
echo  14.  Phieu giao viec
echo  15.  Ho so xin viec
echo  16.  Hoc bong
echo.
echo  %C_GRN%Khac:%C_RST%
echo  17.  Bai viet
echo  18.  Bao cao tong hop
echo  19.  Van ban tuy chinh
echo.
pause
goto menu

:page3
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  QUY TRINH Q&A                              %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_GRN%Buoc 1%C_RST% - Chon loai van ban
echo  - Hien thi danh sach 19 loai
echo  - Ban chon loai can tao
echo  - AI hieu yeu cau loai do
echo.
echo  %C_GRN%Buoc 2%C_RST% - AI dat cau hoi
echo  - AI hoi ve noi dung can thiet
echo  - Moi loai co cau hoi khac nhau
echo  - Vi du: ten nguoi gui, ten nguoi nhan...
echo.
echo  %C_GRN%Buoc 3%C_RST% - Ban tra loi
echo  - Nhap tung cau hoi
echo  - Cang chi tiet, noi dung cang tot
echo  - Co the bo qua cau hoi khong can
echo.
echo  %C_GRN%Buoc 4%C_RST% - AI viet noi dung
echo  - Dua tren cau tra loi
echo  - Tao noi dung van ban
echo  - Dinh dang theo loai van ban
echo  - Them heading, title, bold...
echo.
echo  %C_GRN%Buoc 5%C_RST% - Luu file
echo  - Tao file .docx
echo  - Dinh dang TNR 13, title 16 bold center
echo  - Heading 14 bold
echo  - Luu vao outputs/
echo.
pause
goto menu

:page4
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  DINH DANG OUTPUT                           %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  File output duoc dinh dang chuan:
echo.
echo  %C_BLD%Van ban chinh:%C_RST%
echo  - Font: Times New Roman
echo  - Size: 13
echo  - Can le: justify
echo  - Line spacing: 1.5
echo.
echo  %C_BLD%Tieu de chinh - Title:%C_RST%
echo  - Font: Times New Roman
echo  - Size: 16
echo  - Bold: co
echo  - Can le: center
echo  - Space after: 24pt
echo.
echo  %C_BLD%Tieu de muc - Heading:%C_RST%
echo  - Font: Times New Roman
echo  - Size: 14
echo  - Bold: co
echo  - Space before: 12pt
echo  - Space after: 6pt
echo.
echo  %C_BLD%Dong co trang:%C_RST%
echo  - Top: 2cm
echo  - Bottom: 2cm
echo  - Left: 3cm
echo  - Right: 2cm
echo.
echo  %C_BLD%Luu y:%C_RST% Dinh dang co the chinh sua
echo  sau khi tao xong bang FormatEngine.
echo.
pause
goto menu

:page5
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  CACH DUNG                                  %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%1. Lenh CLI:%C_RST%
echo  python src/main.py generate
echo  - Mo giao dien tuong tac
echo  - Chon loai van ban
echo  - Tra loi cau hoi
echo  - Tao van ban
echo.
echo  %C_BLD%2. Qua Menu:%C_RST%
echo  - Mo run.bat -> Menu 3
echo  - Chon Tao van ban AI
echo  - Lam theo huong dan
echo.
echo  %C_BLD%3. Quy trinh:%C_RST%
echo  - Chon loai: 1-19
echo  - Tra loi 5-10 cau hoi
echo  - Doi AI viet noi dung
echo  - Kiem tra ket qua
echo  - Luu file
echo.
echo  %C_BLD%4. File output:%C_RST%
echo  - Mac dinh: outputs/generated_*.docx
echo  - Ten file theo loai van ban
echo  - Co the chi dinh ten khac
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
echo  - Loai: Don xin phep
echo  - Cau hoi: Ten, ly do, thoi gian
echo  - Tra loi: Nguyen Van A, phep ca nhan, 3 ngay
echo  - Ket qua: Don xin phep chinh thuc
echo.
echo  %C_BLD%Vi du 2: Bao cao thuc tap%C_RST%
echo  - Loai: Bao cao
echo  - Cau hoi: Ten, cong ty, thoi gian, noi dung
echo  - Tra loi: Chi tiet ve thuc tap
echo  - Ket qua: Bao cao 10+ trang
echo.
echo  %C_BLD%Vi du 3: Thu ming%n%n%C_RST%
echo  - Loai: Thu ming
echo  - Cau hoi: Ten, dia chi, noi dung
echo  - Tra loi: Thong tin nguoi gui/nhan
echo  - Ket qua: Thu ming chuan format
echo.
echo  %C_BLD%Vi du 4: Bien ban hop%C_RST%
echo  - Loai: Bien ban hop
echo  - Cau hoi: Thoi gian, dia diem, nguoi tham du
echo  - Tra loi: Thong tin cuoc hop
echo  - Ket qua: Bien ban chinh thuc
echo.
pause
goto menu

:page7
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  MEO VA LOI                                 %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Meo 1: Tra loi chi tiet%C_RST%
echo  - Cang nhieu thong tin, noi dung cang tot
echo  - Dung cau tra loi dai, mo ta
echo  - Tranh tra loi ngan nguoi
echo.
echo  %C_BLD%Meo 2: Chon dung loai%C_RST%
echo  - Chon loai phu hop voi yeu cau
echo  - Dung don xin phep cho don xin phep
echo  - Dung bao cao cho bao cao
echo.
echo  %C_BLD%Meo 3: Chinh sua sau khi tao%C_RST%
echo  - Tao xong co the chinh sua
echo  - Dung format de chinh dinh dang
echo  - Them/sua noi dung can thiet
echo.
echo  %C_RED%Loi pho bien:%C_RST%
echo.
echo  %C_RED%No active provider%C_RST%
echo  - Chua cai dat AI provider
echo  - Cai dat provider truoc khi generate
echo.
echo  %C_RED%API key invalid%C_RST%
echo  - Key sai hoac het han
echo  - Cap nhat key moi
echo.
echo  %C_RED%Output directory not found%C_RST%
echo  - Thu muc outputs/ khong ton tai
echo  - Tao thu muc truoc khi generate
echo.
echo  %C_RED%Rate limited%C_RST%
echo  - API bi gioi han
echo  - Doi 1 phut, thu lai
echo  - Dung provider khac
echo.
pause
goto menu

:end
endlocal
exit /b 0
