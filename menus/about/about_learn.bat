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
echo %C_CYA%%C_BLD%         2. HOC FORMATTING TU FILE MAU                  %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan
echo %C_YLW%  2.%C_RST% Cach dung (CLI + Menu)
echo %C_YLW%  3.%C_RST% Vi du cu the
echo %C_YLW%  4.%C_RST% Meo va loi ich
echo %C_YLW%  5.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto :tongquan
if "%SUB%"=="2" goto :cachdung
if "%SUB%"=="3" goto :vidu
if "%SUB%"=="4" goto :meo
if "%SUB%"=="5" goto :loixuly
if "%SUB%"=="0" exit /b
goto :menu

:tongquan
cls
echo.
echo %C_CYA%--- TONG QUAN ---%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Phan tich file Word da format chuan, trich xuat cac
echo  thong so dinh dang (font, size, spacing, alignment...)
echo  va tu dong tao file rule YAML de ap dung cho file khac.
echo.
echo %C_YLW%  File duoc tao:%C_RST%
echo  %C_WHT%rules/ten_rule.yaml%C_RST% chua danh sach rules
echo  voi moi rule la 1 style + thong so tuong ung.
echo.
echo %C_YLW%  Uu diem:%C_RST%
echo  %C_GRY%-%C_RST% Khong can nho thong so font/size/spacing
echo  %C_GRY%-%C_RST% Chi can 1 file mau chuan de ap dung cho nhieu file
echo  %C_GRY%-%C_RST% Rule co the chinh sua thu cong sau khi tao
echo  %C_GRY%-%C_RST% Ho tro ca .doc va .docx
echo.
pause
goto :menu

:cachdung
cls
echo.
echo %C_CYA%--- cach dung ---%C_RST%
echo.
echo %C_CYA%  Cach 1: CLI truc tiep%C_RST%
echo  %C_WHT%python src/main.py learn "mau.docx" -o rules/my_rules.yaml%C_RST%
echo.
echo %C_CYA%  Cach 2: Qua run.bat%C_RST%
echo  %C_GRY%1.%C_RST% Chay %C_WHT%run.bat%C_RST%
echo  %C_GRY%2.%C_RST% Menu 1 - Hoc va Cau hinh
echo  %C_GRY%3.%C_RST% Chon 1 - Hoc formatting tu file mau
echo  %C_GRY%4.%C_RST% Nhap duong dan file mau (.doc hoac .docx)
echo  %C_GRY%5.%C_RST% Dat ten file rule (Enter = learned_rules)
echo.
echo %C_CYA%  Tham so:%C_RST%
echo  %C_YLW%input%C_RST%         Duong dan file mau (.doc/.docx)
echo  %C_YLW%-o, --output%C_RST%  Ten file rule dau ra (mac dinh: learned_rules.yaml)
echo.
echo %C_CYA%  Quy trinh:%C_RST%
echo  %C_GRY%1.%C_RST% Doc file mau bang python-docx hoac win32com
echo  %C_GRY%2.%C_RST% Trich xuat thong so tung paragraph
echo  %C_GRY%3.%C_RST% Nhom theo style (Normal, Heading 1, Title...)
echo  %C_GRY%4.%C_RST% Tao rule YAML voi thong so trung binh/ro rang nhat
echo.
pause
goto :menu

:vidu
cls
echo.
echo %C_CYA%--- VI DU CU THE ---%C_RST%
echo.
echo %C_CYA%  Buoc 1: File mau "baocao.docx" co:%C_RST%
echo  %C_GRY%-%C_RST% Normal: Times New Roman 13pt, justify, 1.5
echo  %C_GRY%-%C_RST% Heading 1: Times New Roman 14pt, bold, left
echo  %C_GRY%-%C_RST% Title: Times New Roman 16pt, bold, center
echo.
echo %C_CYA%  Buoc 2: Chay learn:%C_RST%
echo  %C_WHT%python src/main.py learn "mau.docx" -o rules/baocao.yaml%C_RST%
echo.
echo %C_CYA%  Buoc 3: File tao ra "rules/baocao.yaml":%C_RST%
echo  %C_GRY%rules:%C_RST%
echo  %C_GRY%  - name: "Normal"%C_RST%
echo  %C_GRY%    target: paragraph%C_RST%
echo  %C_GRY%    conditions:%C_RST%
echo  %C_GRY%      style: "Normal"%C_RST%
echo  %C_GRY%    actions:%C_RST%
echo  %C_GRY%      font:%C_RST%
echo  %C_GRY%        name: "Times New Roman"%C_RST%
echo  %C_GRY%        size: 13%C_RST%
echo  %C_GRY%      paragraph:%C_RST%
echo  %C_GRY%        alignment: "justify"%C_RST%
echo  %C_GRY%        line_spacing: 1.5%C_RST%
echo.
echo %C_CYA%  Buoc 4: Ap dung cho file moi:%C_RST%
echo  %C_WHT%python src/main.py format "file_moi.docx" -r rules/baocao.yaml%C_RST%
echo.
pause
goto :menu

:meo
cls
echo.
echo %C_CYA%--- MEO VA LOI ICH ---%C_RST%
echo.
echo %C_YLW%  1. File mau cang chuan, rule cang tot%C_RST%
echo  Chi nen dung file da format dung 100%. Neu file mau
echo  bi loi format, rule se "hoc" sai theo.
echo.
echo %C_YLW%  2. Dung Preview de kiem tra truoc%C_RST%
echo  Sau khi tao rule, chay preview de xem thay doi
echo  truoc khi ap dung that: %C_WHT%python src/main.py preview "file.docx" -r rules/my.yaml%C_RST%
echo.
echo %C_YLW%  3. Ket hop nhieu rule file%C_RST%
echo  Co the ket hop rule hoc tu nhieu file mau:
echo  %C_WHT%-r "rules/mau1.yaml,rules/mau2.yaml"%C_RST%
echo.
echo %C_YLW%  4. Chinh sua rule thu cong sau khi tao%C_RST%
echo  File YAML co the mo bang text editor de chinh sua
echo  thu cong: thay doi font, size, spacing bat ky.
echo.
echo %C_YLW%  5. Ho tro ca .doc va .docx%C_RST%
echo  File mau co the la .doc hoac .docx. Ung dung tu dong
echo  chon parser phu hop (python-docx hoac win32com).
echo.
pause
goto :menu

:loixuly
cls
echo.
echo %C_CYA%--- XU LY LOI ---%C_RST%
echo.
echo %C_RED%  Loi: "File not found"%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra lai duong dan file mau
echo  %C_GRY%-%C_RST% Dung quotes: %C_WHT%learn "D:\files\mau.docx"%C_RST%
echo.
echo %C_RED%  Loi: "No rules generated"%C_RST%
echo  %C_GRY%-%C_RST% File mau qua ngan (< 3 doan van)
echo  %C_GRY%-%C_RST% File mau khong co format ro rang
echo.
echo %C_RED%  Loi: "Cannot read .doc file"%C_RST%
echo  %C_GRY%-%C_RST% Can cai Microsoft Word tren Windows
echo  %C_GRY%-%C_RST% Word phai duoc kich hoat (khong phai trial)
echo.
echo %C_RED%  Rule tao ra bi thieu style%C_RST%
echo  %C_GRY%-%C_RST% File mau chi co 1-2 style -> rule chi co 1-2 muc
echo  %C_GRY%-%C_RST% Dung file mau da format day du style
echo.
pause
goto :menu
