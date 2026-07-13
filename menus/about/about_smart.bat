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
echo %C_CYA%%C_BLD%         4. CAU HINH SMARTHEADING DETECTION            %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan
echo %C_YLW%  2.%C_RST% Built-in patterns (mac dinh)
echo %C_YLW%  3.%C_RST% Cach tao custom pattern
echo %C_YLW%  4.%C_RST% Regex mau (vi du)
echo %C_YLW%  5.%C_RST% Thu tu uu tien
echo %C_YLW%  6.%C_RST% Cach dung (Menu)
echo %C_YLW%  7.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto :tongquan
if "%SUB%"=="2" goto :builtin
if "%SUB%"=="3" goto :custom
if "%SUB%"=="4" goto :regex
if "%SUB%"=="5" goto :uutien
if "%SUB%"=="6" goto :cachdung
if "%SUB%"=="7" goto :loixuly
if "%SUB%"=="0" exit /b
goto :menu

:tongquan
cls
echo.
echo %C_CYA%--- TONG QUAN ---%C_RST%
echo.
echo  %C_WHT%SmartHeading tu dong phat hien tieu de%C_RST% tu noi dung
echo  van ban bang regex, khong can phu thuoc vao style Word.
echo.
echo  %C_CYA%Nguyen hoat dong:%C_RST%
echo  %C_GRY%1.%C_RST% Doc tung doan van trong file .docx
echo  %C_GRY%2.%C_RST% Kiem tra noi dung voi danh sach regex patterns
echo  %C_GRY%3.%C_RST% Neu match -> gan style tuong ung (Heading 1, Title...)
echo  %C_GRY%4.%C_RST% File duoc luu voi style moi truoc khi format
echo.
echo  %C_CYA%Uu diem:%C_RST%
echo  %C_GRY%-%C_RST% Phat hieu "Chuong 1", "1.2.3", "MUC LUC"... chinh xac
echo  %C_GRY%-%C_RST% Ho tro tieng Viet (dau mau, chu hoa)
echo  %C_GRY%-%C_RST% Co the them pattern tuy y cho ngon ngu/format khac
echo  %C_GRY%-%C_RST% Chay truoc cac formatter khac (priority cao nhat)
echo.
echo  %C_CYA%File cau hinh:%C_RST%  rules/smart_patterns.yaml
echo.
pause
goto :menu

:builtin
cls
echo.
echo %C_CYA%--- BUILT-IN PATTERNS (MAC DINH) ---%C_RST%
echo.
echo  %C_CYA%Heading 1 (Chuong/Muc lon):%C_RST%
echo  %C_GRY%  CHUONG/Chuong + so (Chuong 1, Chuong IV)%C_RST%
echo  %C_GRY%  Phan + so (Phan I, Phan 1)%C_RST%
echo  %C_GRY%  MUC LUC, TAI LIEU THAM KHAO, PHU LUC%C_RST%
echo  %C_GRY%  LOI MO DAU, KET LUAN, DANH MUC%C_RST%
echo.
echo  %C_CYA%Heading 2 (Muc con):%C_RST%
echo  %C_GRY%  So.dinh.dang (1.1, 2.3, 5.2)%C_RST%
echo.
echo  %C_CYA%Heading 3 (Muc con cap 3):%C_RST%
echo  %C_GRY%  So.dinh.dang.3 (1.2.3, 2.1.1)%C_RST%
echo.
echo  %C_CYA%Heading 4 (Muc con cap 4):%C_RST%
echo  %C_GRY%  So.dinh.dang.4 (1.2.3.4, 2.1.3.2)%C_RST%
echo.
echo  %C_CYA%Title:%C_RST%
echo  %C_GRY%  BAO CAO, DO AN, LUAN VAN, TIEU LUAN, LUAN AN%C_RST%
echo  %C_GRY%  KHOA LUAN, CHUYEN DE, BO GIAO DUC%C_RST%
echo  %C_GRY%  TRUONG DAI HOC...%C_RST%
echo.
echo  %C_CYA%Subtitle:%C_RST%
echo  %C_GRY%  Nganh:, Chuyen nganh:, GVHD:, SVTH:%C_RST%
echo  %C_GRY%  Giao vien huong dan:, Sinh vien thuc hien:%C_RST%
echo.
pause
goto :menu

:custom
cls
echo.
echo %C_CYA%--- CACH TAO CUSTOM PATTERN ---%C_RST%
echo.
echo  %C_CYA%Buoc 1: Mo menu cau hinh%C_RST%
echo  %C_WHT%run.bat%RST% -> Menu 1 -> Chon 4
echo.
echo  %C_CYA%Buoc 2: Chon "2. Them pattern moi"%C_RST%
echo.
echo  %C_CYA%Buoc 3: Nhap thong tin:%C_RST%
echo  %C_GRY%  Pattern regex:  Dang bieu thuc chinh quy (regex)%C_RST%
echo  %C_GRY%  Target style:   Style Word can gan (Heading 1, Title...)%C_RST%
echo  %C_GRY%  Mo ta:          Ten mo ta (Enter = tu dong)%C_RST%
echo.
echo  %C_CYA%Buoc 4: Luu va test%C_RST%
echo  Chon 5 de luu, nhap file Word de preview.
echo.
echo  %C_CYA%Buoc 5: Xac nhan trong format%C_RST%
echo  File rule rules/smart_patterns.yaml duoc tu dong
echo  tich hop khi chay format voi rule nay.
echo.
pause
goto :menu

:regex
cls
echo.
echo %C_CYA%--- REGEX MAU (VI DU) ---%C_RST%
echo.
echo %C_CYA%  Tieng Viet:%C_RST%
echo  %C_WHT%^(CHUONG^|Chuong^)\\\s+\\\d+%C_RST%        -> Heading 1
echo  %C_GRY%  Matches: "Chuong 1", "CHUONG 3", "Chuong IV"%C_RST%
echo.
echo  %C_WHT%^\\d+\\.\\d+\\.\\d+                      %C_RST%  -> Heading 3
echo  %C_GRY%  Matches: "1.2.3", "5.1.2", "2.3.1"%C_RST%
echo.
echo  %C_WHT%^GVHD\\\s*:%C_RST%                       -> Subtitle
echo  %C_GRY%  Matches: "GVHD:", "GVHD: Nguyen Van A"%C_RST%
echo.
echo  %C_WHT%^(Bao cao^|Do an^|Luan van^)%C_RST%       -> Title
echo  %C_GRY%  Matches: "Bao cao cuoi ky", "Do an tot nghiep"%C_RST%
echo.
echo %C_CYA%  Tieng Anh:%C_RST%
echo  %C_WHT%^Chapter\\\s+\\\d+%C_RST%               -> Heading 1
echo  %C_GRY%  Matches: "Chapter 1", "Chapter 5"%C_RST%
echo.
echo  %C_WHT%^Section\\\s+\\\d+%C_RST%              -> Heading 2
echo  %C_GRY%  Matches: "Section 1.2", "Section 3"%C_RST%
echo.
echo %C_CYA%  Regex co ban:%C_RST%
echo  %C_GRY%^     = bat dau dong%C_RST%
echo  %C_GRY%\\s+  = 1 khoang trang tro len%C_RST%
echo  %C_GRY%\\d+  = 1 so tro len%C_RST%
echo  %C_GRY%(...)  = nhom bat buoc%C_RST%
echo  %C_GRY%|     = hoac%C_RST%
echo  %C_GRY%[...]  = 1 ky tu trong tap%C_RST%
echo  %C_GRY%+      = 1 lan tro len%C_RST%
echo  %C_GRY%*      = 0 lan tro len%C_RST%
echo  %C_GRY%?      = 0 hoac 1 lan%C_RST%
echo.
pause
goto :menu

:uutien
cls
echo.
echo %C_CYA%--- THU TU uu TIEN ---%C_RST%
echo.
echo  SmartHeading theo thu tu uu tien (match dau tien = dung):
echo.
echo  %C_YLW%  1. Custom patterns (tu rules/smart_patterns.yaml)%C_RST%
echo  %C_GRY%     -> Priority cao nhat, chay dau tien%C_RST%
echo  %C_GRY%     -> Dinh nghia boi nguoi dung qua menu%C_RST%
echo.
echo  %C_YLW%  2. Heading patterns (HEADING_PATTERNS)%C_RST%
echo  %C_GRY%     -> Chuong, Phan, so.dinh.dang (1.1, 1.2.3)%C_RST%
echo  %C_GRY%     -> MUC LUC, TAI LIEU THAM KHAO, KET LUAN...%C_RST%
echo.
echo  %C_YLW%  3. Title patterns (TITLE_PATTERNS)%C_RST%
echo  %C_GRY%     -> BAO CAO, DO AN, LUAN VAN, BO GIAO DUC...%C_RST%
echo.
echo  %C_YLW%  4. Subtitle patterns (SUBTITLE_PATTERNS)%C_RST%
echo  %C_GRY%     -> Nganh:, GVHD:, SVTH:, Giao vien huong dan%RST%
echo.
echo  %C_CYA%Luu y:%C_RST%
echo  Neu 1 doan match ca custom VA built-in -> custom duoc uu tien.
echo  Chi 1 style duoc gan (dau tien match).
echo.
pause
goto :menu

:cachdung
cls
echo.
echo %C_CYA%--- CACH DUNG ---%C_RST%
echo.
echo %C_CYA%  Cach 1: Qua run.bat%C_RST%
echo  %C_GRY%1.%C_RST% Chay %C_WHT%run.bat%C_RST%
echo  %C_GRY%2.%C_RST% Menu 1 -> Chon 4 - Cau hinh SmartHeading
echo  %C_GRY%3.%C_RST% Them pattern, luu, test voi file Word
echo.
echo %C_CYA%  Cach 2: Format voi SmartHeading%C_RST%
echo  %C_WHT%python src/main.py format "file.docx" -r rules/smart_patterns.yaml%C_RST%
echo.
echo %C_CYA%  Cach 3: Ket hop rule%C_RST%
echo  %C_WHT%python src/main.py format "file.docx" -r "rules/smart_patterns.yaml,rules/default.yaml"%C_RST%
echo.
echo  %C_GRY%SmartHeading chay TRUOC cac formatter khac.%C_RST%
echo  No se phat hieu va gan style, sau do Font/Spacing/
echo  Alignment se format theo style moi.
echo.
pause
goto :menu

:loixuly
cls
echo.
echo %C_CYA%--- XU LY LOI ---%C_RST%
echo.
echo %C_RED%  Regex khong match nhu mong doi%C_RST%
echo  %C_GRY%-%C_RST% Dung regex tester (regex101.com) de test truoc
echo  %C_GRY%-%C_RST% Kiem tra dau mau: ^ = bat dau dong
echo  %C_GRY%-%C_RST% Co the can them \b (word boundary)
echo.
echo %C_RED%  Style bi gan sai%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra thu tu uu tien (custom > heading > title)
echo  %C_GRY%-%C_RST% Chi 1 style duoc gan per doan
echo.
echo %C_RED%  SmartPatterns file khong ton tai%C_RST%
echo  %C_GRY%-%C_RST% Chua tao pattern nao -> file chua duoc tao
echo  %C_GRY%-%C_RST% Vao menu cau hinh de them pattern dau tien
echo.
pause
goto :menu
