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
echo %C_CYA%%C_BLD%  SMARTHEADING DETECTION                                  %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan - SmartHeading la gi?
echo %C_YLW%  2.%C_RST% Built-in patterns (HEADING/TITLE/SUBTITLE)
echo %C_YLW%  3.%C_RST% Custom patterns - Tu tao regex
echo %C_YLW%  4.%C_RST% Thu tu uu tien
echo %C_YLW%  5.%C_RST% Cach dung - CLI va Menu
echo %C_YLW%  6.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto page1
if "%SUB%"=="2" goto page2
if "%SUB%"=="3" goto page3
if "%SUB%"=="4" goto page4
if "%SUB%"=="5" goto page5
if "%SUB%"=="6" goto page6
if "%SUB%"=="0" exit /b
goto :menu

:page1
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  TONG QUAN - SMARTHEADING LA GI?                       %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%SmartHeadingFormatter%C_RST% la formatter dac biet
echo phat hieu tieu de tu dong bang regex patterns.
echo.
echo %C_BLD%Source code:%C_RST% src/formatters/smart_heading.py
echo - HEADING_PATTERNS: 16 built-in patterns
echo - TITLE_PATTERNS: 7 title patterns
echo - SUBTITLE_PATTERNS: 6 subtitle patterns
echo.
echo %C_BLD%Nguyen ly hoat dong:%C_RST%
echo 1. Duyet tung doan van trong file Word
echo 2. Kiem tra custom patterns truoc (uu tien cao nhat)
echo 3. Kiem tra HEADING_PATTERNS: Chuong, so phan
echo 4. Kiem tra TITLE_PATTERNS: Bao cao, Do an, Luan van
echo 5. Kiem tra SUBTITLE_PATTERNS: Nganh:, GVHD:
echo 6. Neu khop -> ap dung style tuong ung
echo 7. Chi thay doi style_name, khong thay doi font
echo.
echo %C_BLD%Vi du:%C_RST%
echo - "Chuong 1: Giai thieu" -> Heading 1
echo - "1.2.3. Phuong phap" -> Heading 3
echo - "Bao cao thuc tap" -> Title
echo - "Nganh: CNTT" -> Subtitle
echo.
echo %C_BLD%Uu diem:%C_RST%
echo - Khong can danh dau tay tung tieu de
echo - Tu dong phat hieu cau truc van ban
echo - Hoat dong voi moi loai van ban Viet
echo - Ho tro custom patterns tuy y
echo.
pause
goto :menu

:page2
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  BUILT-IN PATTERNS                                     %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_YLW%--- HEADING_PATTERNS --- %C_RST%
echo   1. "Chuong + so罗马数字" -> Heading 1
echo      Vi du: Chuong I, Chuong IV, Chuong XII
echo   2. "Chuong + so arabic" -> Heading 1
echo      Vi du: Chuong 1, Chuong 12, Chuong 100
echo   3. "Phan + so罗马数字" -> Heading 1
echo      Vi du: Phan I, Phan II
echo   4. "Phan + so arabic" -> Heading 1
echo      Vi du: Phan 1, Phan 2
echo   5. "So.phan.so" (4 cap) -> Heading 4
echo      Vi du: 1.1.1.1, 2.3.4.5
echo   6. "So.phan.so" (3 cap) -> Heading 3
echo      Vi du: 1.1.1, 2.3.4
echo   7. "So.phan" (2 cap) -> Heading 2
echo      Vi du: 1.1, 2.3, 12.5
echo   8. "I+." (so La Ma) -> Heading 1
echo      Vi du: I., II., III.
echo   9. "MUC LUC" -> Heading 1
echo  10. "TAI LIEU THAM KHAO" -> Heading 1
echo  11. "PHU LUC" -> Heading 1
echo  12. "LOI MO DAU" -> Heading 1
echo  13. "LOI NOI DAU" -> Heading 1
echo  14. "KET LUAN" -> Heading 1
echo  15. "DANH MUC" -> Heading 1
echo.
echo %C_YLW%--- TITLE_PATTERNS --- %C_RST%
echo   "BAO CAO" / "DO AN" / "LUAN VAN" / "TIEU LUAN" / "LUAN AN" / "KHOA LUAN" -> Title
echo   "BO GIAO DUC" -> Title
echo   "TRUONG DAI HOC" -> Title
echo.
echo %C_YLW%--- SUBTITLE_PATTERNS --- %C_RST%
echo   "Nganh:" / "Chuyen nganh:" / "GVHD:" / "SVTH:" -> Subtitle
echo   "Giang vien huong dan" / "Sinh vien thuc hien" -> Subtitle
echo.
pause
goto :menu

:page3
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CUSTOM PATTERNS - TU TAO REGEX                        %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo Ban co the tao regex pattern rieng de phat hieu
echo tieu de theo y muon.
echo.
echo %C_BLD%Cach them custom pattern:%C_RST%
echo 1. Mo rule file YAML
echo 2. Them conditions.pattern cho rule
echo 3. Them heading.style hoac heading.level
echo.
echo %C_BLD%Vi du custom pattern trong YAML:%C_RST%
echo   rules:
echo     - name: "Bai hoc"
echo       target: paragraph
echo       conditions:
echo         pattern: "Bai \\d+"
echo       actions:
echo         font: {name: Times New Roman, size: 14, bold: true}
echo         heading: {level: 2}
echo.
echo %C_BLD%Them custom pattern qua SmartConfig:%C_RST%
echo   run.bat -> Menu 1 -> Chon 3
echo   Nhap regex pattern, chon style ap dung
echo.
echo %C_BLD%Regex co ban:%C_RST%
echo   \\d+   = mot so hoac nhieu so
echo   \\w+   = mot chu hoac nhieu chu
echo   .*    = bat ky ky tu nao
echo   |     = hoac
echo   \\s+   = khoang cach
echo   ^     = bat dau dong
echo.
echo %C_BLD%Luu y:%C_RST%
echo - Pattern phai la regex hop le
echo - Thu tu pattern quan trong
echo - Pattern dau tien khop se duoc ap dung
echo - Test regex tren regex101.com truoc khi them
echo.
pause
goto :menu

:page4
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  THU TU UU TIEN                                        %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo Khi nhieu pattern khop voi cung 1 doan van,
echo thu tu uu tien quyet dinh style nao duoc ap dung:
echo.
echo %C_RED%1. Custom patterns - Uu tien cao nhat%CRST%
echo   - Pattern ban tao rieng trong rule YAML
echo   - Luon duoc kiem tra dau tien
echo   - Co the ghi de built-in patterns
echo.
echo %C_YLW%2. HEADING_PATTERNS - Uu tien thu hai%CRST%
echo   - Chuong \\d+ -> Heading 1
echo   - \\d+\\.\\d+ -> Heading 2
echo   - \\d+\\.\\d+\\.\\d+ -> Heading 3
echo   - \\d+\\.\\d+\\.\\d+\\.\\d+ -> Heading 4
echo   - MUC LUC, KET LUAN, PHU LUC -> Heading 1
echo.
echo %C_GRN%3. TITLE_PATTERNS - Uu tien thu ba%CRST%
echo   - BAO CAO, DO AN, LUAN VAN -> Title
echo   - BO GIAO DUC, TRUONG DAI HOC -> Title
echo.
echo %C_CYA%4. SUBTITLE_PATTERNS - Uu tien thap nhat%CRST%
echo   - Nganh:, GVHD:, SVTH: -> Subtitle
echo.
echo %C_BLD%Vi du:%C_RST%
echo   Doan "Chuong 1: Bao cao tong hop"
echo   -> Khop Heading 1 va khop Title
echo   -> Ket qua: Heading 1 vi uu tien cao hon
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
echo %C_BLD%1. Mac dinh SmartHeading da bat%CRST%
echo   Khi format voi rule co smart_heading, SmartHeading tu dong hoat dong
echo.
echo %C_BLD%2. Kiem tra cau hinh rule:%C_RST%
echo   Mo rule file YAML, kiem tra:
echo   smart_heading:
echo     enabled: true
echo     patterns: [...]
echo.
echo %C_BLD%3. Them custom pattern qua Menu:%C_RST%
echo   run.bat -> Menu 1 -> Chon 3 - Cau hinh SmartHeading
echo   Nhap pattern regex, chon style: Heading 1-5, Title, Subtitle
echo.
echo %C_BLD%4. Tat SmartHeading:%C_RST%
echo   Dat smart_heading.enabled: false
echo   Hoac khong co smart_heading trong rule
echo   Chi format theo style co san
echo.
echo %C_BLD%5. Lenh format voi rule%CRST%
echo   python src/main.py format input.docx -r rules/default.yaml
echo   python src/main.py format input.docx -r rules/academic.yaml --dry-run
echo.
echo %C_BLD%6. Cau hinh tuy chon%CRST%
echo   Chon patterns can thiet, bo patterns khong can
echo   Them patterns rieng cho van ban cua ban
echo.
pause
goto :menu

:page6
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  XU LY LOI                                              %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_RED%Loi 1: Regex sai syntax%CRST%
echo   Nguyen nhan: Pattern regex khong hop le
echo   Giai phap: Test regex tren regex101.com
echo   Dung \\ thay vi \ trong YAML
echo.
echo %C_RED%Loi 2: Pattern qua rong%CRST%
echo   Nguyen nhan: ".*" match tat ca
echo   Giai phap: Dung pattern cu the hon
echo   Vi du: "Chuong \\d+" thay vi ".*Chuong.*"
echo.
echo %C_RED%Loi 3: Pattern qua hep%CRST%
echo   Nguyen nhan: Bo qua nhieu tieu de
echo   Giai phap: Mở rộng pattern
echo   Them nhieu bien the hon
echo.
echo %C_RED%Loi 4: Khong co smart_heading trong rule%CRST%
echo   Nguyen nhan: Rule file khong cau hinh smart_heading
echo   Giai phap: Them smart_heading vao rule YAML
echo   Dat enabled: true
echo.
echo %C_RED%Loi 5: Style khong ton tai%CRST%
echo   Nguyen nhan: Style name khong dung trong Word
echo   Giai phap: Dung dung ten style Word
echo   Heading 1-5, Title, Subtitle, Normal
echo.
pause
goto :menu
