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
echo %C_CYA%%C_BLD%         9. TAO VAN BAN BANG AI                       %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan
echo %C_YLW%  2.%C_RST% Cach dung (CLI + Menu)
echo %C_YLW%  3.%C_RST% 19 loai van ban
echo %C_YLW%  4.%C_RST% Quy trinh Q&A
echo %C_YLW%  5.%C_RST% Dinh dang file dau ra
echo %C_YLW%  6.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto :tongquan
if "%SUB%"=="2" goto :cachdung
if "%SUB%"=="3" goto :loaivanban
if "%SUB%"=="4" goto :quytrinh
if "%SUB%"=="5" goto :dinh dang
if "%SUB%"=="6" goto :loixuly
if "%SUB%"=="0" exit /b
goto :menu

:tongquan
cls
echo.
echo %C_CYA%--- TONG QUAN ---%C_RST%
echo.
echo  %C_WHT%DocGenerator%C_RST% tao van ban Word moi bang AI.
echo  Ung dung dat cau hoi, thu thap tra loi, roi AI
echo  viet noi dung day du va luu thanh .docx.
echo.
echo %C_CYA%  Quy trinh 3 buoc:%C_RST%
echo  %C_GRY%1.%C_RST% Chon loai van ban (19 loai)
echo  %C_GRY%2.%C_RST% Tra loi cau hoi tu AI (4-8 cau hoi)
echo  %C_GRY%3.%C_RST% AI viet noi dung -> luu file .docx
echo.
echo %C_CYA%  Cong nghe:%C_RST%
echo  %C_GRY%-%C_RST% AI tinh cau hoi theo loai van ban
echo  %C_GRY%-%C_RST% AI viet noi dung dang markdown
echo  %C_GRY%-%C_RST% python-docx chuyen markdown -> .docx
echo  %C_GRY%-%C_RST% Dinh mac dinh: TNR 13, justify, 1.5
echo.
echo %C_CYA%  Khong can Microsoft Word.%C_RST%
echo.
pause
goto :menu

:cachdung
cls
echo.
echo %C_CYA%--- CACH DUNG ---%C_RST%
echo.
echo %C_CYA%  CLI:%C_RST%
echo  %C_WHT%python src/main.py generate%C_RST%
echo.
echo %C_CYA%  Menu:%C_RST%
echo  %C_GRY%1.%C_RST% Chay %C_WHT%run.bat%C_RST%
echo  %C_GRY%2.%C_RST% Menu 3 - Tien ich
echo  %C_GRY%3.%C_RST% Chon 6 - Tao van ban Word bang AI
echo.
echo %C_CYA%  Quy trinh:%C_RST%
echo  %C_GRY%1.%C_RST% Chon loai van ban tu danh sach 19 loai
echo  %C_GRY%2.%C_RST% AI dat 4-8 cau hoi (tieng Viet)
echo  %C_GRY%3.%C_RST% Ban tra loi tung cau hoi
echo  %C_GRY%4.%C_RST% AI viet noi dung day du
echo  %C_GRY%5.%C_RST% File duoc tao: outputs/generated_*.docx
echo.
echo %C_CYA%  Luu y:%C_RST%
echo  %C_GRY%-%C_RST% Can AI provider hoat dong (API key hop le)
echo  %C_GRY%-%C_RST% Tra loi 越 chi tiet, noi dung 越 tot
echo.
pause
goto :menu

:loaivanban
cls
echo.
echo %C_CYA%--- 19 LOAI VAN BAN ---%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Bao cao               %C_YLW% 11.%C_RST% Don xin viec
echo %C_YLW%  2.%C_RST% Don xin phep           %C_YLW% 12.%C_RST% Ho so xin viec
echo %C_YLW%  3.%C_RST% Thu ming               %C_YLW% 13.%C_RST% Biên bản hop
echo %C_YLW%  4.%C_RST% Phieu bien ban         %C_YLW% 14.%C_RST% Quyet dinh
echo %C_YLW%  5.%C_RST% Quyet dinh             %C_YLW% 15.%C_RST% Cong van
echo %C_YLW%  6.%C_RST% Cong van               %C_YLW% 16.%C_RST% Phieu giao viec
echo %C_YLW%  7.%C_RST% Hoc bong               %C_YLW% 17.%C_RST% Bieu mau
echo %C_YLW%  8.%C_RST% Phuc trinh             %C_YLW% 18.%C_RST% Luan van (outline)
echo %C_YLW%  9.%C_RST% De cuong               %C_YLW% 19.%C_RST% Thong bao
echo %C_YLW% 10.%C_RST% Luan van               %C_GRY%     va nhieu loai khac...%C_RST%
echo.
echo  %C_GRY%Moi loai co cau hoi rieng phu hop voi noi dung.%C_RST%
echo.
pause
goto :menu

:quytrinh
cls
echo.
echo %C_CYA%--- QUY TRINH Q&A ---%C_RST%
echo.
echo %C_CYA%  Buoc 1: AI tinh cau hoi%C_RST%
echo  %C_GRY%System prompt: "Ban la cu dan van ban chuyen nghiep"%C_RST%
echo  %C_GRY%User: "Toi can tao loai van ban: [loai]"%C_RST%
echo  %C_GRY%AI tra ve JSON array: [{id, text, hint}]%C_RST%
echo  %C_GRY%-> 4-8 cau hoi, moi cau co hint giai thich%C_RST%
echo.
echo %C_CYA%  Buoc 2: Nguoi dung tra loi%C_RST%
echo  %C_GRY%Moi cau hoi duoc hien thi +%C_RST%
echo  %C_GRY%Nguoi dung nhap tra loi tu ban phim%C_RST%
echo  %C_GRY%Co the bo qua (Enter = khong tra loi)%C_RST%
echo.
echo %C_CYA%  Buoc 3: AI viet noi dung%C_RST%
echo  %C_GRY%Ket hop cau hoi + tra loi -> AI viet van ban%C_RST%
echo  %C_GRY%Format: markdown (# Tieu de, ## Muc, van ban)%C_RST%
echo  %C_GRY%Nguon: tieng Viet, trang trong, chuyen nghiep%C_RST%
echo.
echo %C_CYA%  Buoc 4: Luu file .docx%C_RST%
echo  %C_GRY%Chuyen markdown -> python-docx%C_RST%
echo  %C_GRY%# = Title (TNR 16, bold, center)%C_RST%
echo  %C_GRY%## = Heading 2 (TNR 14, bold, left)%C_RST%
echo  %C_GRY%### = Heading 3 (TNR 13, bold, left)%C_RST%
echo  %C_GRY%Van ban = Normal (TNR 13, justify, 1.5)%C_RST%
echo  %C_GRY%- ... = List Bullet%C_RST%
echo.
pause
goto :menu

:dinh dang
cls
echo.
echo %C_CYA%--- DINH DANG FILE DAU RA ---%C_RST%
echo.
echo  File duoc tao voi python-docx, dinh dang mac dinh:
echo.
echo %C_CYA%  Normal style:%C_RST%
echo  %C_GRY%  Font:     Times New Roman, 13pt, mau den%C_RST%
echo  %C_GRY%  Spacing:  1.5, space after 6pt%C_RST%
echo  %C_GRY%  Align:    justify%C_RST%
echo.
echo %C_CYA%  Title (#):%C_RST%
echo  %C_GRY%  Font:     Times New Roman, 16pt, bold, center%C_RST%
echo  %C_GRY%  Space:    before 12pt, after 12pt%C_RST%
echo.
echo %C_CYA%  Heading 2 (##):%C_RST%
echo  %C_GRY%  Font:     Times New Roman, 14pt, bold, left%C_RST%
echo  %C_GRY%  Space:    before 12pt, after 6pt%C_RST%
echo.
echo %C_CYA%  Heading 3 (###):%C_RST%
echo  %C_GRY%  Font:     Times New Roman, 13pt, bold, left%C_RST%
echo  %C_GRY%  Space:    before 6pt, after 3pt%C_RST%
echo.
echo %C_CYA%  List Bullet (-):%C_RST%
echo  %C_GRY%  Style:    List Bullet (mac dinh Word)%C_RST%
echo  %C_GRY%  Font:     Times New Roman, 13pt%C_RST%
echo.
echo  %C_CYA%Output:%C_RST%  outputs/generated_*.docx
echo.
pause
goto :menu

:loixuly
cls
echo.
echo %C_CYA%--- XU LY LOI ---%C_RST%
echo.
echo %C_RED%  Loi: "No active AI provider found"%C_RST%
echo  %C_GRY%-%C_RST% Can setup API key truoc
echo  %C_GRY%-%C_RST% Vao Menu 4 -> Quan ly provider -> Nhap key
echo.
echo %C_RED%  Loi: "Failed to parse AI response"%C_RST%
echo  %C_GRY%-%C_RST% AI tra ve khong phai JSON
echo  %C_GRY%-%C_RST% Thu lai voi model khac
echo.
echo %C_RED%  Loi: "File not created"%C_RST%
echo  %C_GRY%-%C_RST% Thu muc outputs/ chua duoc tao
echo  %C_GRY%-%C_RST% Chay: %C_WHT%python src/main.py init%C_RST%
echo.
echo %C_RED%  Noi dung khong day du%C_RST%
echo  %C_GRY%-%C_RST% Tra loi qua ngan -> AI viet ngan
echo  %C_GRY%-%C_RST% Tra loi chi tiet hon de AI viet nhieu hon
echo.
pause
goto :menu
