@echo off
setlocal enabledelayedexpansion
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "C_CYA=%ESC%[36m" & set "C_YLW=%ESC%[33m" & set "C_GRN=%ESC%[32m"
set "C_RED=%ESC%[31m" & set "C_GRY=%ESC%[90m" & set "C_WHT=%ESC%[37m"
set "C_BLD=%ESC%[1m" & set "C_RST=%ESC%[0m"

:menu
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%         3. TAO RULE THU CONG                          %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan
echo %C_YLW%  2.%C_RST% Cach dung (CLI + Menu)
echo %C_YLW%  3.%C_RST% Danh sach 19 style mac dinh
echo %C_YLW%  4.%C_RST% Moi thong so chi tiet
echo %C_YLW%  5.%C_RST% Vi du file YAML
echo %C_YLW%  6.%C_RST% Meo va loi ich
echo %C_YLW%  7.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto :tongquan
if "%SUB%"=="2" goto :cachdung
if "%SUB%"=="3" goto :danhmuc
if "%SUB%"=="4" goto :thongso
if "%SUB%"=="5" goto :vidu
if "%SUB%"=="6" goto :meo
if "%SUB%"=="7" goto :loixuly
if "%SUB%"=="0" exit /b
goto :menu

:tongquan
cls
echo.
echo %C_CYA%--- TONG QUAN ---%C_RST%
echo.
echo  %C_WHT%Tao rule dinh dang theo y muon%C_RST% ma khong can
echo  phan tich file mau. Nguoi dung chon style tu Word,
echo  nhap thong so tung muc (font, size, spacing...) va
echo  ung dung tu dong tao file rule YAML.
echo.
echo %C_YLW%  Uu diem so voi learn:%C_RST%
echo  %C_GRY%-%C_RST% Day du quyen kiem soat moi thong so
echo  %C_GRY%-%C_RST% Khong can file mau mau
echo  %C_GRY%-%C_RST% Tao rule cho bat ky style nao (Normal, Heading 1-9,
echo    Title, Subtitle, List Bullet, Quote, Table Grid, Header...)
echo  %C_GRY%-%C_RST% Moi rule tu dong them heading level neu la Heading
echo.
echo %C_YLW%  File duoc tao:%C_RST%  rules/custom_rules.yaml
echo.
pause
goto :menu

:cachdung
cls
echo.
echo %C_CYA%--- CACH DUNG ---%C_RST%
echo.
echo %C_CYA%  Cach 1: CLI truc tiep%C_RST%
echo  %C_WHT%python src/cli/maker.py%C_RST%
echo.
echo %C_CYA%  Cach 2: Qua run.bat%C_RST%
echo  %C_GRY%1.%C_RST% Chay %C_WHT%run.bat%C_RST%
echo  %C_GRY%2.%C_RST% Menu 1 - Hoc va Cau hinh
echo  %C_GRY%3.%C_RST% Chon 2 - Tao rule thu cong
echo.
echo %C_CYA%  Quy trinh:%C_RST%
echo  %C_GRY%1.%C_RST% Chon style tu danh sach (Normal, Heading 1-9...)
echo  %C_GRY%2.%C_RST% Nhap thong so: font name, size, bold, italic, color
echo  %C_GRY%3.%C_RST% Nhap thong so paragraph: alignment, spacing, indent
echo  %C_GRY%4.%C_RST% Chon them style khac hoac dung lai
echo  %C_GRY%5.%C_RST% Dat ten file -> tao rules/custom_rules.yaml
echo.
echo %C_CYA%  Vi du nhanh:%C_RST%
echo  %C_WHT%Style:%C_RST% Normal
echo  %C_WHT%Font:%C_RST%  Times New Roman, 13pt, mau 000000
echo  %C_WHT%Bold:%C_RST%   Khong
echo  %C_WHT%Align:%C_RST%  justify (4)
echo  %C_WHT%Spacing:%C_RST% 1.5, truoc 6pt, sau 6pt
echo.
pause
goto :menu

:danhmuc
cls
echo.
echo %C_CYA%--- DANH SACH 19 STYLE MAC DINH ---%C_RST%
echo.
echo  %C_CYA%Document structure:%C_RST%
echo  %C_YLW% 1.%C_RST% Normal            %C_GRY%Doan van chinh%RST%
echo  %C_YLW% 2.%C_RST% Title             %C_GRY%Tieu de lon%RST%
echo  %C_YLW% 3.%C_RST% Subtitle          %C_GRY%Tieu de phu%RST%
echo  %C_YLW% 4.%C_RST% Heading 1         %C_GRY%Chuong/Muc lon%RST%
echo  %C_YLW% 5.%C_RST% Heading 2         %C_GRY%Muc con%RST%
echo  %C_YLW% 6.%C_RST% Heading 3         %C_GRY%Muc con cap 3%RST%
echo  %C_YLW% 7.%C_RST% Heading 4         %C_GRY%Muc con cap 4%RST%
echo  %C_YLW% 8.%C_RST% Heading 5         %C_GRY%Cap 5 (hiem)%RST%
echo.
echo  %C_CYA%Lists:%C_RST%
echo  %C_YLW% 9.%C_RST% List Bullet       %C_GRY%Danh sach dau cham%RST%
echo  %C_YLW%10.%C_RST% List Number       %C_GRY%Danh sach so%RST%
echo.
echo  %C_CYA%Special:%C_RST%
echo  %C_YLW%11.%C_RST% Quote             %C_GRY%Trich dan%RST%
echo  %C_YLW%12.%C_RST% Intense Quote     %C_GRY%Trich dan dam%RST%
echo  %C_YLW%13.%C_RST% Table Grid        %C_GRY%Bang co khung%RST%
echo  %C_YLW%14.%C_RST% TOC Heading       %C_GRY%Tieu de muc luc%RST%
echo.
echo  %C_CYA%Header/Footer:%C_RST%
echo  %C_YLW%15.%C_RST% Header            %C_GRY%Dau trang%RST%
echo  %C_YLW%16.%C_RST% Footer            %C_GRY%Chan trang%RST%
echo.
echo  %C_CYA%Other:%C_RST%
echo  %C_YLW%17.%C_RST% Caption           %C_GRY%Chu thich hinh anh%RST%
echo  %C_YLW%18.%C_RST% Bibliography      %C_GRY%Tai lieu tham khao%RST%
echo.
echo  %C_GRY%Co the nhap ten style tuy y: "List Bullet 2", "TOC 3",%RST%
echo  %C_GRY%"Normal (Web)", "Heading 6", "Subtitle 2"...%RST%
echo.
pause
goto :menu

:thongso
cls
echo.
echo %C_CYA%--- MOI THONG SO CHI TIET ---%C_RST%
echo.
echo %C_CYA%  Font settings:%C_RST%
echo  %C_YLW%  name%C_RST%       Ten font (Times New Roman, Arial, Calibri...)
echo  %C_YLW%  size%C_RST%       Kich thuoc (13, 14, 16... co phay: 13.5)
echo  %C_YLW%  bold%C_RST%       In dam (true/false)
echo  %C_YLW%  italic%C_RST%     In nghieng (true/false)
echo  %C_YLW%  color%C_RST%      Mau chu hex (000000 = den, FFFFFF = trang)
echo.
echo %C_CYA%  Paragraph settings:%C_RST%
echo  %C_YLW%  alignment%C_RST%  Can le (1=left, 2=center, 3=right, 4=justify)
echo  %C_YLW%  line_spacing%C_RST%  Khoang cach dong (1.0, 1.5, 2.0)
echo  %C_YLW%  space_before%C_RST%  Khoang cach truoc doan (pt): 6, 12, 18
echo  %C_YLW%  space_after%C_RST%   Khoang cach sau doan (pt): 6, 12
echo  %C_YLW%  first_line_indent%C_RST%  Le dong dau tinh bang cm (1.27 = 1 tab)
echo.
echo %C_CYA%  Heading settings (tu dong):%C_RST%
echo  Neu style la "Heading X" -> tu dong them %C_WHT%heading.level = X%C_RST%
echo  Neu la "Title" -> tu dong them %C_WHT%heading.style = "Title"%C_RST%
echo.
echo %C_CYA%  Gia tri mac dinh theo style:%C_RST%
echo  %C_GRY%  Normal:      TNR 13, justify, spacing 1.5, space 6/6%C_RST%
echo  %C_GRY%  Heading 1:   TNR 14, bold, left, space 18/12%C_RST%
echo  %C_GRY%  Heading 2:   TNR 13, bold, left, space 12/6%C_RST%
echo  %C_GRY%  Heading 3:   TNR 13, bold, left, space 12/6%C_RST%
echo  %C_GRY%  Heading 4:   TNR 13, bold+italic, left, space 6/3%C_RST%
echo  %C_GRY%  Title:       TNR 16, bold, center, space 0/12%C_RST%
echo  %C_GRY%  Subtitle:    TNR 14, center, space 0/6%C_RST%
echo.
pause
goto :menu

:vidu
cls
echo.
echo %C_CYA%--- VI DU FILE YAML ---%C_RST%
echo.
echo  %C_CYA%Dang co ban:%C_RST%
echo  %C_GRY%rules:%C_RST%
echo  %C_GRY%  - name: "Normal - custom"%C_RST%
echo  %C_GRY%    target: paragraph%C_RST%
echo  %C_GRY%    conditions:%C_RST%
echo  %C_GRY%      style: "Normal"%C_RST%
echo  %C_GRY%    actions:%C_RST%
echo  %C_GRY%      font:%C_RST%
echo  %C_GRY%        name: "Times New Roman"%C_RST%
echo  %C_GRY%        size: 13%C_RST%
echo  %C_GRY%        bold: false%C_RST%
echo  %C_GRY%        color: "000000"%C_RST%
echo  %C_GRY%      paragraph:%C_RST%
echo  %C_GRY%        alignment: "justify"%C_RST%
echo  %C_GRY%        line_spacing: 1.5%C_RST%
echo  %C_GRY%        space_before: 6%C_RST%
echo  %C_GRY%        space_after: 6%C_RST%
echo.
echo  %C_CYA%Dang voi Heading:%C_RST%
echo  %C_GRY%  - name: "Heading 1 - custom"%C_RST%
echo  %C_GRY%    target: paragraph%C_RST%
echo  %C_GRY%    conditions:%C_RST%
echo  %C_GRY%      style: "Heading 1"%C_RST%
echo  %C_GRY%    actions:%C_RST%
echo  %C_GRY%      font:%C_RST%
echo  %C_GRY%        name: "Times New Roman"%C_RST%
echo  %C_GRY%        size: 14%C_RST%
echo  %C_GRY%        bold: true%C_RST%
echo  %C_GRY%      paragraph:%C_RST%
echo  %C_GRY%        alignment: "left"%C_RST%
echo  %C_GRY%        space_before: 18%C_RST%
echo  %C_GRY%        space_after: 12%C_RST%
echo  %C_GRY%      heading:%C_RST%
echo  %C_GRY%        level: 1%C_RST%
echo.
echo  %C_CYA%Ap dung:%C_RST%
echo  %C_WHT%python src/main.py format "file.docx" -r rules/custom_rules.yaml%C_RST%
echo.
pause
goto :menu

:meo
cls
echo.
echo %C_CYA%--- MEO VA LOI ICH ---%C_RST%
echo.
echo %C_YLW%  1. Ket hop voi learn%C_RST%
echo  Tao rule thu cong cho cac style chinh (Normal, Heading 1-3),
echo  dung learn de hoc style phu (List, Quote, TOC...).
echo  Ket noi: %C_WHT%-r "rules/custom_rules.yaml,rules/learned.yaml"%C_RST%
echo.
echo %C_YLW%  2. Chinh sua file YAML thu cong%C_RST%
echo  File YAML co the mo bang text editor (VS Code, Notepad++)
echo  de chinh sua thong so sau khi tao.
echo.
echo %C_YLW%  3. Dung first_line_indent cho van hoc%C_RST%
echo  %C_WHT%first_line_indent: 1.27%C_RST% = le 1cm (hoac 1.5cm)
echo  Phu hop cho luan van, bao cao hoc tap.
echo.
echo %C_YLW%  4. Mau hex pho bien%C_RST%
echo  %C_GRY%000000 = den, 333333 = xam dam, 666666 = xam%RST%
echo  %C_GRY%FFFFFF = trang, FF0000 = do, 0000FF = xanh%RST%
echo.
echo %C_YLW%  5. Style tuy y%C_RST%
echo  Khong gioi han 19 style. Co the nhap bat ky ten style
echo  nao co san trong file Word (List Bullet 2, TOC 3...).
echo.
pause
goto :menu

:loixuly
cls
echo.
echo %C_CYA%--- XU LY LOI ---%C_RST%
echo.
echo %C_RED%  Loi: "Cannot find style 'X'%C_RST%
echo  %C_GRY%-%C_RST% Style khong ton tai trong file Word dich
echo  %C_GRY%-%C_RST% Mo Word, kiem tra style names trong Styles pane
echo.
echo %C_RED%  Loi: YAML parse error%C_RST%
echo  %C_GRY%-%C_RST% Sai dinh dang YAML (thieu dau hai cham, sai thu tuc)
echo  %C_GRY%-%C_RST% Dung YAML validator de kiem tra
echo  %C_GRY%-%C_RST% Luu y: tab khong duoc dung (chi duoc dung space)
echo.
echo %C_RED%  Loi: "File not found"%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra ten file rule dung chua
echo  %C_GRY%-%C_RST% File phai nam trong thu muc rules/
echo.
pause
goto :menu
