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
echo %C_CYA%%C_BLD%         6. CLONE DINH DANG + CLONE-PREVIEW             %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan
echo %C_YLW%  2.%C_RST% Clone (dinh dang that)
echo %C_YLW%  3.%C_RST% Clone-preview (xem truoc)
echo %C_YLW%  4.%C_RST% Quy trinh clone step-by-step
echo %C_YLW%  5.%C_RST% Giu nguyen noi dung
echo %C_YLW%  6.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto :tongquan
if "%SUB%"=="2" goto :clone
if "%SUB%"=="3" goto :preview
if "%SUB%"=="4" goto :quytrinh
if "%SUB%"=="5" goto :noidung
if "%SUB%"=="6" goto :loixuly
if "%SUB%"=="0" exit /b
goto :menu

:tongquan
cls
echo.
echo %C_CYA%--- TONG QUAN ---%C_RST%
echo.
echo  %C_WHT%CloneEngine%C_RST% copy TOAN BO dinh dang tu template sang file
echo  khac, bao gom: section, page setup, header, footer,
echo  watermark, TOC, columns, style, margins, orientation.
echo.
echo  %C_CYA%2 che do:%C_RST%
echo  %C_YLW%  Clone-preview:%C_RST%  Xem truoc, mo Word de review
echo  %C_YLW%  Clone:%C_RST%          Ghi file dau ra luon
echo.
echo  %C_CYA%Cong nghe:%C_RST%  win32com (COM API) - can Microsoft Word
echo  %C_CYA%Ho tro:%C_RST%     .doc, .docx, .dot, .dotx, .dotm, .pdf
echo.
echo  %C_CYA%Khac voi Format:%C_RST%
echo  %C_GRY%  Format: Ap dung rule len file goc (font, spacing)%C_RST%
echo  %C_GRY%  Clone:  Copy toan bo cau truc tu template (section, margin...)%C_RST%
echo.
pause
goto :menu

:clone
cls
echo.
echo %C_CYA%--- CLONE (DINH DANG THAT) ---%C_RST%
echo.
echo  Copy toan bo dinh dang tu template sang target,
echo  luu file dau ra ngay lap tuc.
echo.
echo %C_CYA%  CLI:%C_RST%
echo  %C_WHT%python src/main.py clone "template.docx" "target.docx" -o "output.docx"%C_RST%
echo.
echo %C_CYA%  Menu:%C_RST%
echo  %C_GRY%1.%C_RST% Chay %C_WHT%run.bat%C_RST%
echo  %C_GRY%2.%C_RST% Menu 2 -> Chon 6 - Clone dinh dang
echo  %C_GRY%3.%C_RST% Nhap template + target + output
echo.
echo %C_CYA%  Tham so:%C_RST%
echo  %C_YLW%template%C_RST%   File co dinh dung muon copy
echo  %C_YLW%target%C_RST%      File can copy noi dung
echo  %C_YLW%-o, --output%C_RST% File dau ra (mac dinh: outputs/cloned_*.docx)
echo.
echo %C_CYA%  Luu y:%C_RST%
echo  %C_GRY%-%C_RST% Can Microsoft Word da cai tren Windows
echo  %C_GRY%-%C_RST% Template va target nen cung dinh dang (.docx + .docx)
echo  %C_GRY%-%C_RST% Noi dung target duoc giu nguyen, chi copy format
echo.
pause
goto :menu

:preview
cls
echo.
echo %C_CYA%--- CLONE-PREVIEW (XEM TRUOC) ---%C_RST%
echo.
echo  Xem ket qua clone truoc khi ghi file. Word se mo
echo  de ban review, sau do save khi dong Word.
echo.
echo %C_CYA%  CLI:%C_RST%
echo  %C_WHT%python src/main.py clone-preview "template.docx" "target.docx" -o "output.docx"%C_RST%
echo.
echo %C_CYA%  Menu:%C_RST%
echo  %C_GRY%1.%C_RST% Chay %C_WHT%run.bat%C_RST%
echo  %C_GRY%2.%C_RST% Menu 2 -> Chon 5 - Clone-preview
echo  %C_GRY%3.%C_RST% Nhap template + target + output
echo.
echo %C_CYA%  Quy trinh:%C_RST%
echo  %C_GRY%1.%C_RST% Copy template vao file tam
echo  %C_GRY%2.%C_RST% Xoa noi dung template, giu format
echo  %C_GRY%3.%C_RST% Copy noi dung target vao template
echo  %C_GRY%4.%C_RST% Mo Word de review
echo  %C_GRY%5.%C_RST% Dong Word -> luu file dau ra
echo.
echo  %C_CYA%Luu y:%C_RST%  Preview file duoc tao trong %C_WHT%temp%RST%
echo.
pause
goto :menu

:quytrinh
cls
echo.
echo %C_CYA%--- QUY TRINH CLONE STEP-BY-STEP ---%C_RST%
echo.
echo %C_CYA%  Buoc 1: Copy template vao file tam%C_RST%
echo  %C_GRY%shutil.copy2(template, tmp_file)%C_RST%
echo  %C_GRY%-> Giu nguyen toan bo cau truc template%RST%
echo.
echo %C_CYA%  Buoc 2: Xoa noi dung template%C_RST%
echo  %C_GRY%word.Documents.Open(tmp_file)%C_RST%
echo  %C_GRY%full_range = doc.Range()%C_RST%
echo  %C_GRY%full_range.Delete()  -> Xoa moi noi dung%RST%
echo  %C_GRY%-> Chi giu lai cau truc (section, margin, header...)%RST%
echo.
echo %C_CYA%  Buoc 3: Copy noi dung target%C_RST%
echo  %C_GRY%word.Documents.Open(target)%C_RST%
echo  %C_GRY%Selection.WholeStory -> Selection.Copy%RST%
echo  %C_GRY%-> Copy toan bo noi dung vao clipboard%RST%
echo.
echo %C_CYA%  Buoc 4: Paste vao template%C_RST%
echo  %C_GRY%word.Documents.Add(tmp_file)%C_RST%
echo  %C_GRY%Selection.PasteAndFormat(WD_PASTE_ORIGINAL)%RST%
echo  %C_GRY%-> Paste voi format goc (khong reform)%RST%
echo.
echo %C_CYA%  Buoc 5: Luu file dau ra%C_RST%
echo  %C_GRY%ActiveDocument.SaveAs(output_path, save_format)%RST%
echo.
echo  %C_CYA%Retry mechanism:%C_RST%
echo  %C_GRY%COM API co the bi "busy" -> tu dong retry 10 lan%RST%
echo  %C_GRY%Delay tang dan: 1s, 2s, 3s...%RST%
echo.
pause
goto :menu

:noidung
cls
echo.
echo %C_CYA%--- GIU NGUYEN NOI DUNG ---%C_RST%
echo.
echo  Clone chi copy DINH DANG, noi dung target duoc giu nguyen.
echo.
echo %C_CYA%  Cac dinh duoc copy tu template:%C_RST%
echo  %C_GRY%-%C_RST% Page setup (margins, orientation, paper size)
echo  %C_GRY%-%C_RST% Sections (nhieu section)
echo  %C_GRY%-%C_RST% Header va Footer (noi dung + dinh dang)
echo  %C_GRY%-%C_RST% Watermark (hinh anh/van ban)
echo  %C_GRY%-%C_RST% Table of Contents (toc)
echo  %C_GRY%-%C_RST% Columns (nhieu cot)
echo  %C_GRY%-%C_RST% Styles (Normal, Heading 1-9, List...)
echo  %C_GRY%-%C_RST% Themes va Colors
echo  %C_GRY%-%C_RST% Numbering format
echo.
echo %C_CYA%  Noi dung duoc giu nguyen tu target:%C_RST%
echo  %C_GRY%-%C_RST% Toan bo van ban
echo  %C_GRY%-%C_RST% Hinh anh, bang, bieu do
echo  %C_GRY%-%C_RST% Hyperlinks, footnotes
echo  %C_GRY%-%C_RST% Toan bo noi dung khac
echo.
echo  %C_CYA%Luu y:%C_RST%  Style tu template co the anh huong den
echo  hien thi noi dung target neu khong trung khop.
echo.
pause
goto :menu

:loixuly
cls
echo.
echo %C_CYA%--- XU LY LOI ---%C_RST%
echo.
echo %C_RED%  Loi: "Cannot initialize Word COM"%C_RST%
echo  %C_GRY%-%C_RST% Can cai Microsoft Word tren Windows
echo  %C_GRY%-%C_RST% Word phai duoc kich hoat (khong phai trial)
echo  %C_GRY%-%C_RST% Dong tat ca Word truoc khi chay clone
echo.
echo %C_RED%  Loi: "COM busy / RPC_E_CALL_REJECTED"%C_RST%
echo  %C_GRY%-%C_RST% Word dang ban -> tu dong retry 10 lan
echo  %C_GRY%-%C_RST% Neu van loi, dong tat ca Word thu cong
echo  %C_GRY%-%C_RST% Khoi dong lai may neu can
echo.
echo %C_RED%  Loi: "Template not found"%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra lai duong dan template
echo  %C_GRY%-%C_RST% File phai ton tai va mo duoc
echo.
echo %C_RED%  Loi: "Output format not supported"%C_RST%
echo  %C_GRY%-%C_RST% Chi ho tro: .doc, .docx, .dot, .dotx, .dotm, .pdf
echo  %C_GRY%-%C_RST% Dinh dang khac se tu dong chuyen thanh .docx
echo.
pause
goto :menu
