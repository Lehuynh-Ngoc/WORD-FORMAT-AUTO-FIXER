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
echo %C_CYA%%C_BLD%  HOC FORMATTING TU FILE MAU - StyleLearner             %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan - Learn la gi?
echo %C_YLW%  2.%C_RST% Cach dung - CLI va Menu
echo %C_YLW%  3.%C_RST% Vi du thuc te
echo %C_YLW%  4.%C_RST% Meo hieu qua
echo %C_YLW%  5.%C_RST% Xu ly loi pho bien
echo %C_YLW%  6.%C_RST% Quy trinh 5 buoc
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
echo %C_CYA%%C_BLD%  TONG QUAN - LEARN LA GI?                               %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%StyleLearner%C_RST% la chuc nang hoc format tu file mau Word.
echo No phan tich file mau .docx cua ban, trich xuat thong tin
echo format va tu dong tao file rule YAML danh cho FormatEngine.
echo.
echo %C_BLD%Source code:%C_RST% src/core/learner.py
echo - Class StyleLearner: hoc tu file mau, xuat YAML
echo - Class StyleProfile: luu tru thong tin 1 style
echo.
echo %C_BLD%Nguyen ly hoat dong:%C_RST%
echo 1. Doc file mau .docx bang python-docx qua parser
echo 2. Duyet tung doan van, phan tich theo style_name
echo 3. Dem font, size, bold, italic, mau sac, can le
echo 4. Dem line_spacing, space_before, space_after
echo 5. Ap dung nguyen tac: font pho bien nhat = chon
echo 6. Bold ratio > 50%% thi danh dau bold
echo 7. Italic ratio > 50%% thi danh dau italic
echo 8. Chi lay style co >= 2 mau (min_samples = 2)
echo 9. Xuat file YAML voi cau truc rules: []
echo.
echo %C_BLD%Thanh phan duoc trich xuat:%C_RST%
echo - Font: name, size, bold, italic, color
echo - Paragraph: alignment, line_spacing, space_before, space_after
echo - Heading: level tu style_name (Heading 1 = level 1)
echo - Conditions: style name de match
echo.
echo %C_BLD%Noi dung file rule output:%C_RST%
echo - rules: mang cac rule, moi rule co:
echo   + name: "StyleName - learned"
echo   + target: "paragraph"
echo   + conditions: style: "StyleName"
echo   + actions: font + paragraph + heading
echo.
pause
goto :menu

:page2
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CACH DUNG - CLI VA MENU                                %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%1. Lenh CLI truc tiep:%C_RST%
echo   python src/main.py learn "duong\den\mau.docx"
echo.
echo   Hoc tu file mau, xuat vao rules/learned_rules.yaml
echo.
echo %C_BLD%2. Chi dinh file output:%C_RST%
echo   python src/main.py learn "mau.docx" -o rules/my_rule.yaml
echo.
echo   Chi dinh ten file rule output tuy y
echo.
echo %C_BLD%3. Qua Menu giao dien:%C_RST%
echo   - Mo run.bat
echo   - Chon Menu 1 - Hoc & Cau hinh
echo   - Chon 1 - Hoc tu file mau
echo   - Nhap duong dan file mau
echo   - Chon noi luu rule
echo.
echo %C_BLD%4. Tham so CLI:%C_RST%
echo   - template: duong dan file mau .docx, bat buoc
echo   - -o: duong dan xuat rule, mac dinh rules/{ten}_rules.yaml
echo   - File output phai co duoi .yaml
echo.
echo %C_BLD%5. Yeu cau he thong:%C_RST%
echo   - Python 3.8+
echo   - python-docx da cai
echo   - File mau phai la .docx (khong ho tro .doc)
echo.
echo %C_BLD%6. Dung sau khi learn:%C_RST%
echo   python src/main.py format input.docx -r learned_rules.yaml
echo.
pause
goto :menu

:page3
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  VI DU THUC TE                                           %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Vi du 1: File mau don gian - Bao cao%CRST%
echo   File: mau_bao_cao.docx
echo   Noi dung: TNR 13, can le deu, khoang cach 1.5
echo   Ket qua rule:
echo     rules:
echo       - name: "Normal - learned"
echo         conditions: {style: Normal}
echo         actions:
echo           font: {name: Times New Roman, size: 13}
echo           paragraph: {alignment: justify, line_spacing: 1.5}
echo.
echo %C_BLD%Vi du 2: File mau co Heading - Luan van%CRST%
echo   File: mau_luan_van.docx
echo   Chua "Chuong 1: Giai thieu" voi TNR 16 Bold
echo   Ket qua: rule rieng cho Heading 1 voi font_size: 16, bold: true
echo.
echo %C_BLD%Vi du 3: File mau phuc tap - Hoc bong%CRST%
echo   File: mau_hoc_ba.docx
echo   Nhieu style: Normal, Heading 1-3, Title, Quote
echo   Rule mo ta tung style rieng biet
echo   Co the chinh sua them sau khi learn
echo.
echo %C_BLD%Vi du 4: Command thuc te%CRST%
echo   python src/main.py learn "mau_luan_van.docx" -o rules/luan_van.yaml
echo   Ket qua: rules/luan_van.yaml voi 5-10 rules
echo   Dung: python src/main.py format input.docx -r luan_van.yaml
echo.
pause
goto :menu

:page4
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  MEO HIEU QUA                                            %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Meo 1: Chuan bi file mau tot%CRST%
echo   - Dung file da dinh dang hoan chinh
echo   - Dam bao moi doan van dung dung style
echo   - Cang nhieu style trong mau, rule cang day du
echo   - Tranh file mau bi loi format
echo.
echo %C_BLD%Meo 2: Dung preview sau khi learn%CRST%
echo   - Chay format voi rule moi tren file mau goc
echo   - python src/main.py format "mau.docx" -r rules/my.yaml --dry-run
echo   - So sanh ket qua voi file goc
echo   - Dieu chinh rule neu khong hai long
echo.
echo %C_BLD%Meo 3: Chinh sua rule tay%CRST%
echo   - Rule tu dong chi la khoi dau
echo   - Mo file YAML bang text editor
echo   - Them, sua, xoa cac thong so can thiet
echo   - Bo sung cac style dac biet neu thieu
echo.
echo %C_BLD%Meo 4: Ket hop voi Makerule%CRST%
echo   - Learn de tao khung co ban
echo   - Dung Makerule de chinh chi tiet
echo   - Ket hop hai cong cu tot nhat
echo.
echo %C_BLD%Meo 5: Test nhieu file%CRST%
echo   - Test rule tren nhieu file khac nhau
echo   - Dam bao rule phu hop voi moi loai van ban
echo   - Dieu chinh chung de dat ket qua tot nhat
echo.
pause
goto :menu

:page5
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  XU LY LOI PHO BIEN                                     %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_RED%Loi 1: FileNotFoundError%CRST%
echo   Nguyen nhan: File mau khong ton tai tai duong dan
echo   Giai phap: Kiem tra lai duong dan dung chinh xac
echo   Luu y: Dung "" cho path co dau cach
echo   Vi du: learn "C:\My Files\mau.docx"
echo.
echo %C_RED%Loi 2: No rules generated%CRST%
echo   Nguyen nhan: File mau khong co format ro rang
echo   Giai phap: Dung file mau co style ro rang, co it nhat 2 doan van
echo   Luu y: Chi lay style co >= 2 mau (min_samples = 2)
echo.
echo %C_RED%Loi 3: Cannot read .doc file%CRST%
echo   Nguyen nhan: Chi ho tro file .docx
echo   Giai phap: Mo file bang Word, chon Save As -> .docx
echo   Luu y: Dung clone de chuyen doi .doc -> .docx
echo.
echo %C_RED%Loi 4: Permission denied%CRST%
echo   Nguyen nhan: File dang mo trong Word hoac khong co quyen
echo   Giai phap: Dong file truoc khi learn
echo   Kiem tra quyen truy cap thu muc output
echo.
echo %C_RED%Loi 5: ModuleNotFoundError%CRST%
echo   Nguyen nhan: Chua cai python-docx
echo   Giai phap: pip install -r requirements.txt
echo.
pause
goto :menu

:page6
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  QUY TRINH 5 BUOC                                       %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRN%Buoc 1%CRST% - Chuan bi file mau
echo   - Dinh dang file mau theo y muon
echo   - Dam bao cac style ro rang, khong nhap lan
echo   - Moi doan van dung dung style
echo.
echo %C_GRN%Buoc 2%CRST% - Chay lenh learn
echo   CLI: python src/main.py learn "mau.docx"
echo   Hoac: run.bat -> Menu 1 -> Chon 1
echo   Doi qua trinh hoan tat
echo.
echo %C_GRN%Buoc 3%CRST% - Kiem tra rule
echo   - Mo file YAML da tao
echo   - Doc va hieu noi dung rule
echo   - Chinh sua thong so neu can thiet
echo   - Them style dac biet neu thieu
echo.
echo %C_GRN%Buoc 4%CRST% - Test voi dry-run
echo   python src/main.py format "test.docx" -r rules/my.yaml --dry-run
echo   Xem truoc ket qua, khong ghi file
echo   Kiem tra tung doan van co dung khong
echo.
echo %C_GRN%Buoc 5%CRST% - Ap dung that
echo   python src/main.py format "input.docx" -r rules/my.yaml -o output.docx
echo   Kiem tra ket qua cuoi cung
echo   Dung preview de verify
echo.
pause
goto :menu
