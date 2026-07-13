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
echo  %C_BLD%%C_CYA  TAO RULE THU CONG                         %C_RST%
echo  %C_BLD%%C_CYA  Makerule - Interactive Rule Builder       %C_RST%
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo.
echo  %C_GRN%[1]%C_RST%  Tong quan - Makerule la gi?
echo  %C_GRN%[2]%C_RST%  19 Style mac dinh
echo  %C_GRN%[3]%C_RST%  Thong so co the cau hinh
echo  %C_GRN%[4]%C_RST%  Vi du YAML format
echo  %C_GRN%[5]%C_RST%  Cach dung - CLI va Menu
echo  %C_GRN%[6]%C_RST%  Meo tao rule tot
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
echo  %C_BLD%%C_CYA  TONG QUAN - MAKERULE LA GI?                %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Makerule%C_RST% la cong cu tao rule YAML thu cong
echo  giao dien tuong tac. Ban chon style, nhap thong so,
echo  va cong cu tao file rule YAML hoan chinh tu dong.
echo.
echo  %C_BLD%Nguyen ly hoat dong:%C_RST%
echo  - Hien thi danh sach cac style co san
echo  - Ban chon style can cau hinh
echo  - Nhap tung thong so cho style do
echo  - Tong hop va xuat file YAML
echo  - Kiem tra tinh hop le cua rule
echo.
echo  %C_BLD%Uu diem:%C_RST%
echo  - Khong can hieu YAML
echo  - Giao dien don gian, de su dung
echo  - Tao rule nhanh chong
echo  - Phu hop voi yeu cau cu the
echo.
echo  %C_BLD%Phu hop khi:%C_RST%
echo  - Ban biet chinh xac thong so can thiet
echo  - Muon tao rule tuy chinh
echo  - Khong co file mau de learn
echo  - Can tao rule nhanh cho 1 loai van ban
echo.
pause
goto menu

:page2
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  19 STYLE MAC DINH                          %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  Makerule ho tro 19 style pho bien trong Word:
echo.
echo  %C_YLW%--- Van ban co ban --- %C_RST%
echo   1. Normal         - Doan van binh thuong
echo   2. Title          - Tieu de chinh cua van ban
echo   3. Subtitle       - Tieu de phu
echo.
echo  %C_YLW%--- Tieu de --- %C_RST%
echo   4. Heading 1      - Tieu de cap 1 - Chuong
echo   5. Heading 2      - Tieu de cap 2 - Muc
echo   6. Heading 3      - Tieu de cap 3 - Tieumuc
echo   7. Heading 4      - Tieu de cap 4
echo   8. Heading 5      - Tieu de cap 5
echo.
echo  %C_YLW%--- Danh sach --- %C_RST%
echo   9. List Bullet    - Danh dau dau cham
echo  10. List Number    - Danh dau so
echo.
echo  %C_YLW%--- Trich dan --- %C_RST%
echo  11. Quote          - Trich dan thong thuong
echo  12. Intense Quote  - Trich dan noi bat
echo.
echo  %C_YLW%--- Bieu mau --- %C_RST%
echo  13. Table Grid     - Khung bang
echo  14. TOC Heading    - Tieu de muc luc
echo  15. Header         - Dau trang
echo  16. Footer         - Cuoi trang
echo  17. Caption        - Chuthich hinh anh
echo  18. Bibliography   - Tai lieu tham khao
echo.
pause
goto menu

:page3
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  THONG SO CO THE CAU HINH                   %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Font:%C_RST%
echo  - font_name: Ten font, vi du Times New Roman, Arial
echo  - font_size: Kich thuoc, vi du 13, 14, 16
echo  - bold: true/false - Dam
echo  - italic: true/false - Nghieng
echo  - color: Mau sac hex, vi du #000000, #FF0000
echo.
echo  %C_BLD%Can le & Khoang cach:%C_RST%
echo  - alignment: justify/center/left/right
echo  - line_spacing: Khoang cach dong, vi du 1.0, 1.5, 2.0
echo  - space_before: Khoang cach truoc doan, don vi pt
echo  - space_after: Khoang cach sau doan, don vi pt
echo  - first_line_indent: Thut dong dau, don vi pt
echo.
echo  %C_BLD%Style dac biet:%C_RST%
echo  - heading_level: Cap do heading 1-5
echo  - page_break_before: Xuong trang truoc
echo  - keep_with_next: Giu khong ngan
echo  - widow_control: Quan ly dong mo
echo.
echo  %C_BLD%Mau sac pho bien:%C_RST%
echo  - #000000 - Den
echo  - #FF0000 - Do
echo  - #0000FF - Xanh duong
echo  - #008000 - Xanh la
echo  - #808080 - Xam
echo.
pause
goto menu

:page4
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  VI DU YAML FORMAT                          %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_YLW%--- Rule mac dinh --- %C_RST%
echo  settings:
echo    font_name: Times New Roman
echo    font_size: 13
echo    alignment: justify
echo    line_spacing: 1.5
echo    space_before: 0
echo    space_after: 0
echo.
echo  %C_YLW%--- Rule voi Heading --- %C_RST%
echo  styles:
echo    Normal:
echo      font_name: Times New Roman
echo      font_size: 13
echo      alignment: justify
echo      line_spacing: 1.5
echo    Heading 1:
echo      font_name: Times New Roman
echo      font_size: 16
echo      bold: true
echo      space_before: 24
echo      space_after: 12
echo    Title:
echo      font_name: Times New Roman
echo      font_size: 16
echo      bold: true
echo      alignment: center
echo      space_after: 24
echo.
echo  %C_YLW%--- Rule voi SmartHeading --- %C_RST%
echo  smart_heading:
echo    enabled: true
echo    patterns:
echo      - pattern: "Chuong \d+"
echo        style: Heading 1
echo      - pattern: "\d+\.\d+"
echo        style: Heading 2
echo.
pause
goto menu

:page5
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  CACH DUNG - CLI VA MENU                    %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%1. Lenh CLI:%C_RST%
echo  python src/main.py makerule
echo  - Mo giao dien tuong tac
echo  - Danh sach style hien thi
echo  - Nhap thong so tung style
echo  - Xuat file YAML
echo.
echo  %C_BLD%2. Qua Menu giao dien:%C_RST%
echo  - Mo run.bat
echo  - Chon Menu 1 - Hoc & Cau hinh
echo  - Chon 2 - Tao rule thu cong
echo  - Lam theo huong dan
echo.
echo  %C_BLD%3. Quy trinh:%C_RST%
echo  - Chon style can cau hinh
echo  - Nhap ten font
echo  - Nhap kich thuoc font
echo  - Chon bold/italic
echo  - Chon can le
echo  - Nhap khoang cach
echo  - Xac nhan va luu
echo.
echo  %C_BLD%4. File output:%C_RST%
echo  - Mac dinh: rules/custom_rule.yaml
echo  - Co the chi dinh ten khac
echo  - San sang dung voi FormatEngine
echo.
pause
goto menu

:page6
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  MEO TAO RULE TOT                          %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Meo 1: Bat dau don gian%C_RST%
echo  - Chi cau hinh Normal truoc
echo  - Them heading sau
echo  - Don gian = it loi
echo.
echo  %C_BLD%Meo 2: Dung thong so chuan%C_RST%
echo  - TNR 13 la thong dung cho van ban Viet
echo  - Justify la can le mac dinh
echo  - Line spacing 1.5 la pho bien
echo.
echo  %C_BLD%Meo 3: Test lien tuc%C_RST%
echo  - Tao rule -> test --dry-run -> chinh sua
echo  - Khong ap dung rule chua test
echo  - Dung file mau de kiem tra
echo.
echo  %C_BLD%Meo 4: Luu nhieu version%C_RST%
echo  - rule_v1.yaml, rule_v2.yaml...
echo  - Co the quay lai version cu
echo  - So sanh ket qua giua cac version
echo.
echo  %C_BLD%Meo 5: Xem rule mau%C_RST%
echo  - Doc rules/default.yaml de hoc hoi
echo  - Doc rules/academic.yaml de them mau
echo  - Ap dung kinh nghiem tu rule mau
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
echo  %C_RED%Loi 1: File output not found%C_RST%
echo  - Nguyen nhan: Thu muc rules/ chua ton tai
echo  - Giai phap: Tao thu muc rules/ truoc
echo  - Hoac chay init de tao cau truc
echo.
echo  %C_RED%Loi 2: Invalid YAML format%C_RST%
echo  - Nguyen nhan: Sai dinh dang YAML
echo  - Giai phap: Kiem tra indent, dau hai cham
echo  - Dung text editor co syntax highlighting
echo.
echo  %C_RED%Loi 3: Style not recognized%C_RST%
echo  - Nguyen nhan: Ten style khong dung
echo  - Giai phap: Dung dung ten style Word
echo  - Xem danh sach 19 style ho tro
echo.
echo  %C_RED%Loi 4: Permission denied%C_RST%
echo  - Nguyen nhan: Khong co quyen ghi thu muc
echo  - Giai phap: Kiem tra quyen truy cap
echo  - Chay voi quyen Administrator neu can
echo.
pause
goto menu

:end
endlocal
exit /b 0
