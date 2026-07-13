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
echo  %C_BLD%%C_CYA  INIT / RESET                               %C_RST%
echo  %C_BLD%%C_CYA  Khoi tao / Dat lai                        %C_RST%
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo.
echo  %C_GRN%[1]%C_RST%  Tong quan - Init & Reset la gi?
echo  %C_GRN%[2]%C_RST%  Init - Khoi tao cau truc
echo  %C_GRN%[3]%C_RST%  Reset - Dat lai cau hinh
echo  %C_GRN%[4]%C_RST%  Giu nguyen vs Xoa
echo  %C_GRN%[5]%C_RST%  Cach dung
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
echo  %C_BLD%%C_CYA  TONG QUAN - INIT & RESET LA GI?            %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Init%C_RST% - Khoi tao cau truc thu muc
echo  - Tao tat ca thu muc can thiet
echo  - Tao file cau hinh mac dinh
echo  - San sang su dung ngay
echo  - Khong anh huong file da co
echo.
echo  %C_BLD%Reset%C_RST% - Dat lai cau hinh
echo  - Xoa file cau hinh da thay doi
echo  - Xoa rule da hoc
echo  - Xoa file da xuat
echo  - Giu nguyen file goc
echo.
echo  %C_BLD%Khi nao dung:%C_RST%
echo  - Init: Lan dau su dung
echo  - Init: Them thu muc thieu
echo  - Reset: Muon bat dau lai
echo  - Reset: Cau hinh bi loi
echo.
echo  %C_BLD%Luu y quan trong:%C_RST%
echo  - Reset KHONG xoa file rule goc
echo  - Reset KHONG xoa ai_keys_template.yaml
echo  - Reset KHONG xoa default.yaml
echo  - Chi xoa file ban da tao/thay doi
echo.
pause
goto menu

:page2
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  INIT - KHOI TAO CAU TRUC                   %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Thu muc duoc tao:%C_RST%
echo.
echo  %C_GRN%config/%C_RST% - Cau hinh he thong
echo  - ai_keys.yaml: API key va models
echo  - ai_keys_template.yaml: mau cau hinh
echo.
echo  %C_GRN%outputs/%C_RST% - File dau ra
echo  - Cac file .docx da xuat
echo  - Cac file dich/thuat
echo.
echo  %C_GRN%mau/%C_RST% - File mau
echo  - File mau .docx de learn
echo  - File mau de test
echo.
echo  %C_GRN%rules/%C_RST% - Rule dinh dang
echo  - default.yaml: rule mac dinh
echo  - academic.yaml: rule hoc thuat
echo  - learned_rules.yaml: tu learn
echo  - custom_rule.yaml: tu tao
echo.
echo  %C_BLD%File duoc tao:%C_RST%
echo  - config/ai_keys.yaml tu template
echo  - rules/default.yaml co san
echo  - rules/academic.yaml co san
echo  - rules/smart_patterns.yaml co san
echo.
pause
goto menu

:page3
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  RESET - DAT LAI CAU HINH                   %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_RED%File duoc xoa khi Reset:%C_RST%
echo.
echo  %C_RED%1. Cau hinh AI:%C_RST%
echo  - config/ai_keys.yaml
echo  - API key da nhap
echo  - Cau hinh models da thiet lap
echo.
echo  %C_RED%2. File da xuat:%C_RST%
echo  - outputs/*.docx
echo  - Tat ca file da xuat
echo  - Khong the phuc hoi
echo.
echo  %C_RED%3. Rule da hoc:%C_RST%
echo  - rules/learned_rules.yaml
echo  - Rule tu learn
echo  - Co the learn lai
echo.
echo  %C_RED%4. Rule tuy chinh:%C_RST%
echo  - rules/custom_rule.yaml
echo  - Rule ban tao thu cong
echo  - Can tao lai
echo.
echo  %C_RED%5. Smart patterns:%C_RST%
echo  - rules/smart_patterns.yaml
echo  - Custom patterns
echo  - Co the tao lai
echo.
pause
goto menu

:page4
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  GIU NGUYEN VS XOA                          %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_GRN%GIU NGUYEN - Reset khong anh huong:%C_RST%
echo  - rules/default.yaml - rule mac dinh
echo  - rules/academic.yaml - rule hoc thuat
echo  - rules/smart_patterns.yaml - patterns
echo  - config/ai_keys_template.yaml - mau
echo  - src/ - nguon code
echo  - tests/ - test files
echo  - run.bat - menu giao dien
echo  - pyproject.toml - cau truc project
echo  - requirements.txt - dependencies
echo.
echo  %C_RED%XOA - Reset anh huong:%C_RST%
echo  - config/ai_keys.yaml - cau hinh AI
echo  - outputs/* - file da xuat
echo  - rules/learned_rules.yaml - rule hoc
echo  - rules/custom_rule.yaml - rule tay
echo  - rules/smart_patterns.yaml - patterns
echo.
echo  %C_BLD%Muc dich:%C_RST%
echo  - Giu lai file goc, rule mau
echo  - Xoa file ban da tao/thay doi
echo  - Tra ve trang thai ban dau
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
echo  %C_BLD%1. Init:%C_RST%
echo  python src/main.py init
echo  - Tao tat ca thu muc
echo  - Tao file cau hinh mac dinh
echo  - San sang su dung
echo.
echo  %C_BLD%2. Reset:%C_RST%
echo  python src/main.py reset
echo  - Xoa file cau hinh
echo  - Giu lai file goc
echo  - Tra ve trang thai ban dau
echo.
echo  %C_BLD%3. Qua Menu:%C_RST%
echo  - Mo run.bat -> Menu 3
echo  - Chon Init hoac Reset
echo  - Xac nhan thao tac
echo.
echo  %C_BLD%4. Yeu cau:%C_RST%
echo  - Init: khong can gi dac biet
echo  - Reset: chac chan muon reset
echo  - Backup du lieu truoc khi reset
echo.
echo  %C_BLD%5. Sau Init:%C_RST%
echo  - Cai dat requirements.txt
echo  - Cai dat AI provider
echo  - Bat dau su dung
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
echo  %C_BLD%Vi du 1: Lan dau su dung%C_RST%
echo  - Chay init
echo  - Thu muc duoc tao day du
echo  - ai_keys.yaml tu template
echo  - Rule goc san sang
echo  - Cai dat requirements.txt
echo  - Bat dau su dung
echo.
echo  %C_BLD%Vi du 2: Reset sau khi thay doi%C_RST%
echo  - Da thay doi nhieu rule
echo  - Muon quay lai mac dinh
echo  - Chay reset
echo  - Rule goc duoc giu lai
echo  - Rule hoc/tay bi xoa
echo  - Hoc lai tu dau
echo.
echo  %C_BLD%Vi du 3: Reset de cai dat lai AI%C_RST%
echo  - API key bi loi
echo  - Muon cai dat lai provider
echo  - Chay reset
echo  - ai_keys.yaml bi xoa
echo  - Tao lai tu template
echo  - Nhap key moi
echo.
echo  %C_BLD%Vi du 4: Kiem tra cau truc%C_RST%
echo  - Chay init
echo  - Kiem tra thu muc co day du
echo  - Kiem tra file co ton tai
echo  - Them thu muc thieu
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
echo  %C_RED%Loi 1: Permission denied%C_RST%
echo  - Nguyen nhan: Khong co quyen ghi
echo  - Giai phap: Chay voi quyen Administrator
echo  - Kiem tra quyen thu muc
echo.
echo  %C_RED%Loi 2: File already exists%C_RST%
echo  - Nguyen nhan: File da ton tai
echo  - Giai phap: Init khong ghi de file cu
echo  - Chi tao file moi
echo  - Dung reset de xoa file cu
echo.
echo  %C_RED%Loi 3: Directory not found%C_RST%
echo  - Nguyen nhan: Thu muc cha khong ton tai
echo  - Giai phap: Kiem tra thu muc hien tai
echo  - Chay init tu thu muc goc
echo.
echo  %C_RED%Loi 4: Reset that bai%C_RST%
echo  - Nguyen nhan: File dang mo trong Word
echo  - Giai phap: Dong Word truoc khi reset
echo  - Kiem tra quyen truy cap
echo.
echo  %C_RED%Loi 5: Template not found%C_RST%
echo  - Nguyen nhan: ai_keys_template.yaml thieu
echo  - Giai phap: Kiem tra file template
echo  - File template can co trong config/
echo.
pause
goto menu

:end
endlocal
exit /b 0
