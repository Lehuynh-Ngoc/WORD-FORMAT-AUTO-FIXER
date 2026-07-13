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
echo %C_CYA%%C_BLD%  TAO RULE THU CONG - Makerule                          %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan - Makerule la gi?
echo %C_YLW%  2.%C_RST% 18 Style mac dinh ho tro
echo %C_YLW%  3.%C_RST% Thong so co the cau hinh
echo %C_YLW%  4.%C_RST% Vi du YAML format
echo %C_YLW%  5.%C_RST% Cach dung - CLI va Menu
echo %C_YLW%  6.%C_RST% Meo tao rule tot
echo %C_YLW%  7.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto page1
if "%SUB%"=="2" goto page2
if "%SUB%"=="3" goto page3
if "%SUB%"=="4" goto page4
if "%SUB%"=="5" goto page5
if "%SUB%"=="6" goto page6
if "%SUB%"=="7" goto page7
if "%SUB%"=="0" exit /b
goto :menu

:page1
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  TONG QUAN - MAKERULE LA GI?                           %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Makerule%C_RST% la cong cu tao rule YAML thu cong
echo giao dien tuong tac. Ban chon style, nhap thong so,
echo va cong cu tao file rule YAML hoan chinh tu dong.
echo.
echo %C_BLD%Source code:%C_RST% src/cli/maker.py
echo - Ham run(): giao dien tuong tac chinh
echo - POPULAR_STYLES: 18 style mac dinh
echo - configure_style(): cau hinh 1 style
echo.
echo %C_BLD%Nguyen ly hoat dong:%C_RST%
echo 1. Hien thi danh sach 18 style pho bien
echo 2. Ban nhap ten style hoac chon tu danh sach
echo 3. Nhap tung thong so: font, size, bold, italic...
echo 4. Cong cu tao rule dict tu thong so
echo 5. Xuat file YAML hoan chinh
echo.
echo %C_BLD%Uu diem:%C_RST%
echo - Khong can hieu YAML
echo - Giao dien don gian, de su dung
echo - Tao rule nhanh chong
echo - Phu hop voi yeu cau cu the
echo.
echo %C_BLD%Phu hop khi:%C_RST%
echo - Ban biet chinh xac thong so can thiet
echo - Muon tao rule tuy chinh
echo - Khong co file mau de learn
echo - Can tao rule nhanh cho 1 loai van ban
echo.
pause
goto :menu

:page2
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  18 STYLE MAC DINH HO TRO                               %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo Makerule ho tro 18 style pho bien trong Word:
echo.
echo %C_YLW%--- Van ban co ban --- %C_RST%
echo   1. Normal          - Doan van binh thuong
echo   2. Title           - Tieu de chinh cua van ban
echo   3. Subtitle        - Tieu de phu
echo.
echo %C_YLW%--- Tieu de --- %C_RST%
echo   4. Heading 1       - Tieu de cap 1 - Chuong
echo   5. Heading 2       - Tieu de cap 2 - Muc
echo   6. Heading 3       - Tieu de cap 3 - Tieumuc
echo   7. Heading 4       - Tieu de cap 4
echo   8. Heading 5       - Tieu de cap 5
echo.
echo %C_YLW%--- Danh sach --- %C_RST%
echo   9. List Bullet     - Danh dau dau cham
echo  10. List Number     - Danh dau so
echo.
echo %C_YLW%--- Trich dan --- %C_RST%
echo  11. Quote           - Trich dan thong thuong
echo  12. Intense Quote   - Trich dan noi bat
echo.
echo %C_YLW%--- Bieu mau --- %C_RST%
echo  13. Table Grid      - Khung bang
echo  14. TOC Heading     - Tieu de muc luc
echo  15. Header          - Dau trang
echo  16. Footer          - Cuoi trang
echo  17. Caption         - Chuthich hinh anh
echo  18. Bibliography    - Tai lieu tham khao
echo.
echo %C_BLD%Luu y:%C_RST% Co the nhap ten style tuy y bat ky
echo Vi du: "List Bullet 2", "TOC 3", "Normal (Web)"
echo.
pause
goto :menu

:page3
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  THONG SO CO THE CAU HINH                               %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Font:%C_RST%
echo   font_name:   Ten font, mac dinh "Times New Roman"
echo   font_size:   Kich thuoc, vi du 13, 14, 16
echo   bold:        true/false - Dam
echo   italic:      true/false - Nghieng
echo   color:       Mau sac hex, vi du 000000, FF0000
echo.
echo %C_BLD%Can le & Khoang cach:%C_RST%
echo   alignment:        left / center / right / justify
echo   line_spacing:     Khoang cach dong, vi du 1.0, 1.5, 2.0
echo   space_before:     Khoang cach truoc doan, don vi pt
echo   space_after:      Khoang cach sau doan, don vi pt
echo   first_line_indent: Thut dong dau, don vi cm
echo.
echo %C_BLD%Mac dinh theo style:%C_RST%
echo   Normal:   TNR 13, justify, line_spacing 1.5
echo   Heading:  TNR 14, bold, left
echo   Title:    TNR 16, bold, center
echo   Subtitle: TNR 14, bold, center
echo.
echo %C_BLD%Mau sac pho bien:%C_RST%
echo   000000 - Den     FF0000 - Do
echo   0000FF - Xanh duong   008000 - Xanh la
echo.
pause
goto :menu

:page4
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  VI DU YAML FORMAT                                      %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_YLW%--- Rule mac dinh - settings --- %C_RST%
echo   settings:
echo     font_name: Times New Roman
echo     font_size: 13
echo     alignment: justify
echo     line_spacing: 1.5
echo     space_before: 0
echo     space_after: 0
echo.
echo %C_YLW%--- Rule voi Heading --- %C_RST%
echo   rules:
echo     - name: "Normal - custom"
echo       target: paragraph
echo       conditions:
echo         style: Normal
echo       actions:
echo         font: {name: Times New Roman, size: 13}
echo         paragraph: {alignment: justify, line_spacing: 1.5}
echo     - name: "Heading 1 - custom"
echo       target: paragraph
echo       conditions:
echo         style: Heading 1
echo       actions:
echo         font: {name: Times New Roman, size: 16, bold: true}
echo         paragraph: {space_before: 18, space_after: 12}
echo         heading: {level: 1}
echo.
echo %C_YLW%--- Luu y cau truc --- %C_RST%
echo   - name: ten rule
echo   - target: "paragraph" luon
echo   - conditions.style: ten style Word
echo   - actions.font: {name, size, bold, italic, color}
echo   - actions.paragraph: {alignment, line_spacing, space_before, space_after}
echo   - actions.heading: {level: 1-5}
echo.
pause
goto :menu

:page5
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CACH DUNG - CLI VA MENU                               %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%1. Lenh CLI:%C_RST%
echo   python src/main.py makerule
echo   Mo giao dien tuong tac, huong dan tung buoc
echo.
echo %C_BLD%2. Qua Menu giao dien:%C_RST%
echo   - Mo run.bat
echo   - Chon Menu 1 - Hoc & Cau hinh
echo   - Chon 2 - Tao rule thu cong
echo   - Lam theo huong dan
echo.
echo %C_BLD%3. Quy trinh tao rule:%C_RST%
echo   - Chon style can cau hinh (nhap ten hoac chon so)
echo   - Nhap font name, font size
echo   - Chon bold, italic
echo   - Chon alignment (1-4)
echo   - Nhap line_spacing, space_before, space_after
echo   - Xac nhan va luu
echo.
echo %C_BLD%4. File output:%C_RST%
echo   - Mac dinh: rules/custom_rules.yaml
echo   - Co the dat ten khac khi luu
echo   - San sang dung: python src/main.py format input.docx -r custom_rules.yaml
echo.
pause
goto :menu

:page6
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  MEO TAO RULE TOT                                      %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Meo 1: Bat dau don gian%CRST%
echo   - Chi cau hinh Normal truoc
echo   - Them heading sau
echo   - Don gian = it loi
echo.
echo %C_BLD%Meo 2: Dung thong so chuan Viet Nam%CRST%
echo   - TNR 13 la thong dung cho van ban Viet
echo   - Justify la can le mac dinh
echo   - Line spacing 1.5 la pho bien
echo.
echo %C_BLD%Meo 3: Test lien tuc%CRST%
echo   - Tao rule -> test --dry-run -> chinh sua
echo   - Khong ap dung rule chua test
echo   - Dung file mau de kiem tra
echo.
echo %C_BLD%Meo 4: Luu nhieu version%CRST%
echo   - rule_v1.yaml, rule_v2.yaml...
echo   - Co the quay lai version cu
echo   - So sanh ket qua giua cac version
echo.
echo %C_BLD%Meo 5: Xem rule mau%CRST%
echo   - Doc rules/default.yaml de hoc hoi
echo   - Doc rules/academic.yaml de them mau
echo   - Ap dung kinh nghiem tu rule mau
echo.
pause
goto :menu

:page7
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  XU LY LOI                                              %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_RED%Loi 1: File output not found%CRST%
echo   Nguyen nhan: Thu muc rules/ chua ton tai
echo   Giai phap: Tao thu muc rules/ truoc
echo   Hoac chay: python src/main.py init
echo.
echo %C_RED%Loi 2: Invalid YAML format%CRST%
echo   Nguyen nhan: Sai dinh dang YAML, indent sai
echo   Giai phap: Kiem tra indent 2 khoang, dau hai cham
echo   Dung text editor co syntax highlighting
echo.
echo %C_RED%Loi 3: Style not recognized%CRST%
echo   Nguyen nhan: Ten style khong dung Word format
echo   Giai phap: Dung dung ten style Word
echo   Xem danh sach 18 style ho tro tai page 2
echo.
echo %C_RED%Loi 4: Permission denied%CRST%
echo   Nguyen nhan: Khong co quyen ghi thu muc
echo   Giai phap: Kiem tra quyen truy cap
echo   Chay voi quyen Administrator neu can
echo.
pause
goto :menu
