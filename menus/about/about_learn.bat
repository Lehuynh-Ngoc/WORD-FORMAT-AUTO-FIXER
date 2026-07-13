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
echo  %C_BLD%%C_CYA  HOC FORMATTING TU FILE MAU              %C_RST%
echo  %C_BLD%%C_CYA  Learn - Style Learner                    %C_RST%
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo.
echo  %C_GRN%[1]%C_RST%  Tong quan - Learn la gi?
echo  %C_GRN%[2]%C_RST%  Cach dung - CLI va Menu
echo  %C_GRN%[3]%C_RST%  Vi du thuc te
echo  %C_GRN%[4]%C_RST%  Meo hieu qua
echo  %C_GRN%[5]%C_RST%  Xu ly loi pho bien
echo  %C_GRN%[6]%C_RST%  Cau truc rule YAML
echo  %C_GRN%[7]%C_RST%  Quy trinh 5 buoc
echo  %C_GRN%[8]%C_RST%  So sanh Learn vs Makerule
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
if "%choice%"=="8" goto page8
if "%choice%"=="0" goto end
goto menu

:page1
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  TONG QUAN - LEARN LA GI?                  %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%StyleLearner%C_RST% la chuc nang hoc format tu file mau Word.
echo  No phan tich file mau .docx cua ban, trich xuat thong tin
echo  format va tu dong tao file rule YAML danh cho FormatEngine.
echo.
echo  %C_BLD%Nguyen ly hoat dong:%C_RST%
echo  - Doc file mau .docx bang python-docx
echo  - Duyet tung doan van trong file
echo  - Phan tich font, size, mau sac, can le, khoang cach
echo  - Phat hieu cac style: Normal, Title, Heading 1-5
echo  - Trich xuat mau SmartHeading neu co
echo  - Tong hop va xuat file rule YAML hoan chinh
echo.
echo  %C_BLD%Thanh phan duoc trich xuat:%C_RST%
echo  - Font: ten, kich thuoc, dam, nghieng, mau sac
echo  - Can le: trai, phai, giua, deu hai ben
echo  - Khoang cach: dong, truoc doan, sau doan
echo  - Indent: thut dong dau tien
echo  - Style level: heading 1-5, title, subtitle, normal
echo.
echo  %C_BLD%Noi dung file rule output:%C_RST%
echo  - settings: thong so mac dinh cho tat ca style
echo  - styles: thong so chi tiet tung style
echo  - smart_heading: regex patterns phat hieu tieu de
echo.
pause
goto menu

:page2
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  CACH DUNG - CLI VA MENU                   %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%1. Lenh CLI truc tiep:%C_RST%
echo  python src/main.py learn "duong\den\mau.docx"
echo  python src/main.py learn "mau.docx" -o rules/my_rule.yaml
echo.
echo  %C_BLD%2. Qua Menu giao dien:%C_RST%
echo  - Mo run.bat
echo  - Chon Menu 1 - Hoc & Cau hinh
echo  - Chon 1 - Hoc tu file mau
echo  - Nhap duong dan file mau
echo  - Chon noi luu rule
echo.
echo  %C_BLD%3. Tham so chi tiet:%C_RST%
echo  - Input: duong dan file mau .docx bat buoc
echo  - -o: duong dan xuat rule, mac dinh rules/learned_rules.yaml
echo  - File output phai co duoi .yaml
echo.
echo  %C_BLD%4. Yeu cau he thong:%C_RST%
echo  - Python 3.8+
echo  - python-docx da cai
echo  - File mau phai la .docx
echo  - Khong ho tro file .doc cu
echo.
pause
goto menu

:page3
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  VI DU THUC TE                              %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Vi du 1: File mau don gian%C_RST%
echo  - File: mau_bao_cao.docx
echo  - Noi dung: TNR 13, can le deu, khoang cach 1.5
echo  - Ket qua rule YAML:
echo    settings:
echo      font_name: Times New Roman
echo      font_size: 13
echo      alignment: justify
echo      line_spacing: 1.5
echo.
echo  %C_BLD%Vi du 2: File mau co Heading%C_RST%
echo  - File: mau_luan_van.docx
echo  - Chua "Chuong 1: Giai thieu" voi TNR 16 Bold
echo  - Ket qua rule:
echo    styles:
echo      Heading 1:
echo        font_size: 16
echo        bold: true
echo        font_name: Times New Roman
echo.
echo  %C_BLD%Vi du 3: File mau phuc tap%C_RST%
echo  - File: mau_hoc_ba.docx
echo  - Nhieu style: Normal, Heading 1-3, Title, Quote
echo  - Rule mo ta tung style rieng biet
echo  - Co the chinh sua them sau khi learn
echo.
echo  %C_BLD%Vi du 4: File mau voi SmartHeading%C_RST%
echo  - File: mau_de_an.docx
echo  - Phat hieu "Chuong 1:", "1.1", "1.2.3"
echo  - Rule tao them smart_heading patterns
echo.
pause
goto menu

:page4
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  MEO HIEU QUA                               %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Meo 1: Chuan bi file mau tot%C_RST%
echo  - Dung file da dinh dang hoan chinh
echo  - Dam bao moi doan van dung dung style
echo  - Tranh file mau bi loi format
echo  - Cang nhieu style trong mau, rule cang day du
echo.
echo  %C_BLD%Meo 2: Dung preview sau khi learn%C_RST%
echo  - Chay format voi rule moi tren file mau goc
echo  - Dung --dry-run de xem truoc
echo  - So sanh ket qua voi file goc
echo  - Dieu chinh rule neu khong hai long
echo.
echo  %C_BLD%Meo 3: Chinh sua rule tay%C_RST%
echo  - Rule tu dong chi la khoi dau
echo  - Mo file YAML bang text editor
echo  - Them, sua, xoa cac thong so can thiet
echo  - Bo sung cac style dac biet
echo.
echo  %C_BLD%Meo 4: Ket hop voi Makerule%C_RST%
echo  - Learn de tao khung co ban
echo  - Dung Makerule de chinh chi tiet
echo  - Ket hop hai cong cu tot nhat
echo.
echo  %C_BLD%Meo 5: Test nhieu file%C_RST%
echo  - Test rule tren nhieu file khac nhau
echo  - Dam bao rule phu hop voi moi loai van ban
echo  - Dieu chinh chung de dat ket qua tot nhat
echo.
pause
goto menu

:page5
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  XU LY LOI PHO BIEN                         %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_RED%Loi 1: FileNotFoundError%C_RST%
echo  - Nguyen nhan: File mau khong ton tai tai duong dan
echo  - Giai phap: Kiem tra lai duong dan dung chinh xac
echo  - Dung "" cho path co dau cach
echo  - Vi du: learn "C:\My Files\mau.docx"
echo.
echo  %C_RED%Loi 2: No rules generated%C_RST%
echo  - Nguyen nhan: File mau khong co format ro rang
echo  - Giai phap: Dung file mau co style ro rang
echo  - Dam bao file co dung cau truc Word
echo  - Kiem tra file co bi huong khong
echo.
echo  %C_RED%Loi 3: Cannot read .doc file%C_RST%
echo  - Nguyen nhan: Chi ho tro file .docx
echo  - Giai phap: Mo file bang Word
echo  - Chon Save As -> Word Document .docx
echo  - Hoac dung clone de chuyen doi
echo.
echo  %C_RED%Loi 4: Permission denied%C_RST%
echo  - Nguyen nhan: File dang mo trong Word hoac khong co quyen
echo  - Giai phap: Dong file truoc khi learn
echo  - Kiem tra quyen truy cap thu muc output
echo.
echo  %C_RED%Loi 5: ModuleNotFoundError%C_RST%
echo  - Nguyen nhan: Chua cai python-docx
echo  - Giai phap: pip install python-docx
echo  - Hoac: pip install -r requirements.txt
echo.
pause
goto menu

:page6
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  CAU TRUC RULE YAML                         %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%File rule YAML co 3 phan chinh:%C_RST%
echo.
echo  %C_YLW%--- Phan 1: settings - Mac dinh --- %C_RST%
echo  settings:
echo    font_name: Times New Roman
echo    font_size: 13
echo    alignment: justify
echo    line_spacing: 1.5
echo    space_before: 0
echo    space_after: 0
echo    first_line_indent: 0
echo.
echo  %C_YLW%--- Phan 2: styles - Chi tiet --- %C_RST%
echo  styles:
echo    Normal:
echo      font_name: Times New Roman
echo      font_size: 13
echo      alignment: justify
echo    Heading 1:
echo      font_size: 16
echo      bold: true
echo      font_name: Times New Roman
echo    Title:
echo      font_size: 16
echo      bold: true
echo      alignment: center
echo.
echo  %C_YLW%--- Phan 3: smart_heading - Regex --- %C_RST%
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

:page7
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  QUY TRINH 5 BUOC                           %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_GRN%Buoc 1%C_RST% - Chuan bi file mau
echo  - Dinh dang file mau theo y muon
echo  - Dam bao cac style ro rang, khong nhap lan
echo  - Moi doan van dung dung style
echo.
echo  %C_GRN%Buoc 2%C_RST% - Chay lenh learn
echo  - CLI: python src/main.py learn "mau.docx"
echo  - Hoac: Menu 1 -> Chon 1
echo  - Doi qua trinh hoan tat
echo.
echo  %C_GRN%Buoc 3%C_RST% - Kiem tra rule
echo  - Mo file YAML da tao
echo  - Doc va hieu noi dung rule
echo  - Chinh sua thong so neu can thiet
echo  - Them style dac biet neu thieu
echo.
echo  %C_GRN%Buoc 4%C_RST% - Test voi dry-run
echo  - python src/main.py format "test.docx" -r rules/my.yaml --dry-run
echo  - Xem truoc ket qua, khong ghi file
echo  - Kiem tra tung doan van co dung khong
echo.
echo  %C_GRN%Buoc 5%C_RST% - Ap dung that
echo  - python src/main.py format "input.docx" -r rules/my.yaml -o output.docx
echo  - Kiem tra ket qua cuoi cung
echo  - Dung preview de verify
echo.
pause
goto menu

:page8
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  SO SANH LEARN VS MAKERULE                  %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Learn%C_RST% - Tu dong tu file mau
echo  + Tu phan tich, khong can nhap thu cong
echo  + Nhanh voi file mau co san
echo  + Phat hieu duoc nhieu style tu dong
echo  - Chi chinh xac nhu file mau
echo  - Khong hieu duoc y dinh cua nguoi dung
echo.
echo  %C_BLD%Makerule%C_RST% - Thu cong tuy chinh
echo  + Dang ky hoan toan theo y muon
echo  + Dang ky chi tiet tung thong so
echo  + Phu hop voi yeu cau dac biet
echo  - Mat nhieu thoi gian nhap lieu
echo  - Can hieu ro thong so format
echo.
echo  %C_BLD%Goi y%C_RST%:
echo  - Dung Learn de tao khung co ban
echo  - Dung Makerule de chinh sua chi tiet
echo  - Ket hop hai cong cu de dat ket qua tot nhat
echo.
pause
goto menu

:end
endlocal
exit /b 0
