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
echo  %C_BLD%%C_CYA  SMARTHEADING DETECTION                    %C_RST%
echo  %C_BLD%%C_CYA  Smart - Phat hieu tieu de tu dong         %C_RST%
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo.
echo  %C_GRN%[1]%C_RST%  Tong quan - SmartHeading la gi?
echo  %C_GRN%[2]%C_RST%  Built-in patterns
echo  %C_GRN%[3]%C_RST%  Custom patterns - Tu tao
echo  %C_GRN%[4]%C_RST%  Thu tu uu tien
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
echo  %C_BLD%%C_CYA  TONG QUAN - SMARTHEADING LA GI?            %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%SmartHeadingFormatter%C_RST% la formatter dac biet
echo  phat hieu tieu de tu dong bang regex patterns.
echo.
echo  %C_BLD%Nguyen ly hoat dong:%C_RST%
echo  - Duyet tung doan van trong file Word
echo  - So sanh noi dung voi cac regex pattern
echo  - Neu khop -> ap dung style tuong ung
echo  - Chuyen doan van thanh heading/title
echo.
echo  %C_BLD%Vi du:%C_RST%
echo  - Doan van "Chuong 1: Giai thieu" duoc phat hieu
echo  - Ap dung style Heading 1
echo  - Font, size, bold duoc ap dung tu rule
echo.
echo  %C_BLD%Uu diem:%C_RST%
echo  - Khong can danh dau tay tung tieu de
echo  - Tu dong phat hieu cau truc van ban
echo  - Hoat dong voi moi loai van ban Viet
echo  - Tan xuat cao voi van ban hoc thuat
echo.
pause
goto menu

:page2
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  BUILT-IN PATTERNS                         %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_YLW%--- Heading 1 - Chuong --- %C_RST%
echo  Pattern: "Chuong \d+"
echo  Vi du: Chuong 1, Chuong 2, Chuong 12
echo  Style ap dung: Heading 1
echo.
echo  %C_YLW%--- Heading 2 - Muc con --- %C_RST%
echo  Pattern: "\d+\.\d+"
echo  Vi du: 1.1, 2.3, 12.5
echo  Style ap dung: Heading 2
echo.
echo  %C_YLW%--- Heading 3 - Tieumuc --- %C_RST%
echo  Pattern: "\d+\.\d+\.\d+"
echo  Vi du: 1.1.1, 2.3.4, 1.2.5
echo  Style ap dung: Heading 3
echo.
echo  %C_YLW%--- Heading 4 - Cap 4 --- %C_RST%
echo  Pattern: "\d+\.\d+\.\d+\.\d+"
echo  Vi du: 1.1.1.1, 2.3.4.5
echo  Style ap dung: Heading 4
echo.
echo  %C_YLW%--- Title - Tieu de chinh --- %C_RST%
echo  Pattern: "Bao cao|Do an|Luan van|De cuong"
echo  Vi du: Bao cao thuc tap, Do an tot nghiep
echo  Style ap dung: Title
echo.
echo  %C_YLW%--- Subtitle - Tieu de phu --- %C_RST%
echo  Pattern: "Nganh:|GVHD:|GV huong dan:|De tai:"
echo  Vi du: Nganh: CNTT, GVHD: Nguyen Van A
echo  Style ap dung: Subtitle
echo.
pause
goto menu

:page3
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  CUSTOM PATTERNS - TU TAO                   %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  Ban co the tao regex pattern rieng de phat hieu
echo  tieu de theo y muon.
echo.
echo  %C_BLD%Cach them custom pattern:%C_RST%
echo  1. Mo run.bat -> Menu 1 -> Chon 3
echo  2. Nhap regex pattern
echo  3. Chon style ap dung
echo  4. Luu vao rule file
echo.
echo  %C_BLD%Vi du custom patterns:%C_RST%
echo  - "Muc \d+"       -> Heading 2
echo  - "Phan \d+"      -> Heading 1
echo  - "Bai \d+"       -> Heading 2
echo  - "Chuong \d+"    -> Heading 1
echo  - "Soan thao"     -> Subtitle
echo.
echo  %C_BLD%Regex co ban trong batch:%C_RST%
echo  - \d+   = mot so hoac nhieu so
echo  - \w+   = mot chu hoac nhieu chu
echo  - .*    = bat ky ky tu nao
echo  - |     = hoac
echo  - \s+   = khoang cach
echo.
echo  %C_BLD%Luu y:%C_RST%
echo  - Pattern phai la regex hop le
echo  - Thu tu pattern quan trong
echo  - Pattern dau tien khop se duoc ap dung
echo.
pause
goto menu

:page4
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  THU TU UU TIEN                            %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  Khi nhieu pattern khop voi cung 1 doan van,
echo  thu tu uu tien quyet dinh style nao duoc ap dung:
echo.
echo  %C_RED%1. Custom patterns - Uu tien cao nhat%C_RST%
echo  - Pattern ban tao rieng
echo  - Luon duoc kiem tra dau tien
echo  - Co the ghi de built-in patterns
echo.
echo  %C_YLW%2. Heading patterns - Uu tien thu hai%C_RST%
echo  - Chuong \d+ -> Heading 1
echo  - \d+\.\d+ -> Heading 2
echo  - \d+\.\d+\.\d+ -> Heading 3
echo  - \d+\.\d+\.\d+\.\d+ -> Heading 4
echo.
echo  %C_GRN%3. Title patterns - Uu tien thu ba%C_RST%
echo  - Bao cao|Do an|Luan van|De cuong -> Title
echo.
echo  %C_CYA%4. Subtitle patterns - Uu tien thap nhat%C_RST%
echo  - Nganh:|GVHD: -> Subtitle
echo.
echo  %C_BLD%Vi du:%C_RST%
echo  - Doan "Chuong 1: Bao cao tong hop"
echo  - Khop Heading 1 va khop Title
echo  - Ket qua: Heading 1 vi uu tien cao hon
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
echo  %C_BLD%1. Bat dau su dung:%C_RST%
echo  - Mac dinh SmartHeading da bat
echo  - Khi format voi rule co smart_heading
echo  - SmartHeading tu dong hoat dong
echo.
echo  %C_BLD%2. Kiem tratheo cau hinh:%C_RST%
echo  - Mo rule file YAML
echo  - Kiem tra smart_heading.enabled: true
echo  - Xac nhan patterns
echo.
echo  %C_BLD%3. Them custom pattern:%C_RST%
echo  - Mo run.bat -> Menu 1 -> Chon 3
echo  - Nhap pattern regex
echo  - Chon style: Heading 1-5, Title, Subtitle
echo  - Luu vao rule
echo.
echo  %C_BLD%4. Tat SmartHeading:%C_RST%
echo  - Dat smart_heading.enabled: false
echo  - Hoac khong co smart_heading trong rule
echo  - Chi format theo style co san
echo.
echo  %C_BLD%5. Cau hinh tuy chon:%C_RST%
echo  - Chon patterns can thiet
echo  - Bo patterns khong can
echo  - Them patterns rieng
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
echo  %C_BLD%Vi du 1: Van ban hoc thuat%C_RST%
echo  - Input: "Chuong 1: Giai thieu ve AI"
echo  - Pattern match: "Chuong \d+"
echo  - Ket qua: Heading 1, TNR 16 Bold
echo.
echo  %C_BLD%Vi du 2: Van ban so phan%C_RST%
echo  - Input: "1.2.3. Phuong phap thu nghiem"
echo  - Pattern match: "\d+\.\d+\.\d+"
echo  - Ket qua: Heading 3, TNR 14 Bold
echo.
echo  %C_BLD%Vi du 3: Tieu de bao cao%C_RST%
echo  - Input: "Bao cao thuc tap cong nghe"
echo  - Pattern match: "Bao cao"
echo  - Ket qua: Title, TNR 16 Bold Center
echo.
echo  %C_BLD%Vi du 4: Thong tin sinh vien%C_RST%
echo  - Input: "Nganh: Cong nghe thong tin"
echo  - Pattern match: "Nganh:"
echo  - Ket qua: Subtitle, TNR 13 Italic
echo.
echo  %C_BLD%Vi du 5: Custom pattern%C_RST%
echo  - Pattern: "Bai \d+"
echo  - Input: "Bai 1: Luyen tap"
echo  - Ket qua: Heading 2, TNR 14 Bold
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
echo  %C_BLD%Meo 1: Thu tu pattern quan trong%C_RST%
echo  - Dat pattern quan trong nhat dau tien
echo  - Custom pattern luon truoc built-in
echo  - Test truoc khi ap dung
echo.
echo  %C_BLD%Meo 2: Regex chinh xac%C_RST%
echo  - Dung \d+ cho so
echo  - Dung .* cho bat ky
echo  - Test regex tren regex101.com
echo.
echo  %C_BLD%Meo 3: Phan biet heading level%C_RST%
echo  - Chuong \d+ -> Heading 1 muc lon nhat
echo  - \d+\.\d+ -> Heading 2 muc nho hon
echo  - \d+\.\d+\.\d+ -> Heading 3 nho hon nua
echo.
echo  %C_RED%Loi pho bien:%C_RST%
echo  - Regex sai syntax -> khong match
echo  - Pattern qua rong -> phat hieu nhieu qua
echo  - Pattern qua hep -> bo qua nhieu tieu de
echo  - Khong co smart_heading trong rule
echo.
echo  %C_BLD%Giai phap:%C_RST%
echo  - Test regex truoc khi them vao rule
echo  - Dung --dry-run de xem truoc
echo  - Chinh sua pattern cho phu hop
echo.
pause
goto menu

:end
endlocal
exit /b 0
