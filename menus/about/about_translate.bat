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
echo %C_CYA%%C_BLD%         8. DICH THUAT FILE WORD                       %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan
echo %C_YLW%  2.%C_RST% Cach dung (CLI + Menu)
echo %C_YLW%  3.%C_RST% 19 ngon ngu ho tro
echo %C_YLW%  4.%C_RST% Batch translation (giai doan 3000 ky tu)
echo %C_YLW%  5.%C_RST% Giu nguyen format
echo %C_YLW%  6.%C_RST% Fallback individual
echo %C_YLW%  7.%C_RST% Vi du cu the
echo %C_YLW%  8.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto :tongquan
if "%SUB%"=="2" goto :cachdung
if "%SUB%"=="3" goto :ngonngu
if "%SUB%"=="4" goto :batch
if "%SUB%"=="5" goto :format
if "%SUB%"=="6" goto :fallback
if "%SUB%"=="7" goto :vidu
if "%SUB%"=="8" goto :loixuly
if "%SUB%"=="0" exit /b
goto :menu

:tongquan
cls
echo.
echo %C_CYA%--- TONG QUAN ---%C_RST%
echo.
echo  %C_WHT%Translator%C_RST% dich file Word sang 19 ngon ngu bang AI.
echo  Giu nguyen toan bo format (font, bold, heading, spacing).
echo.
echo %C_CYA%  Nguyen hoat dong:%C_RST%
echo  %C_GRY%1.%C_RST% Doc file .docx bang python-docx
echo  %C_GRY%2.%C_RST% Lay tung doan van (paragraph)
echo  %C_GRY%3.%C_RST% Nhom thanh batch (3000 ky tu/batch)
echo  %C_GRY%4.%C_RST% Gui AI dich voi separator ===PARA_SEP===
echo  %C_GRY%5.%C_RST% AI tra ve batch dich voi cung separator
echo  %C_GRY%6.%C_RST% Gan lai text moi vao run goc (giu format)
echo  %C_GRY%7.%C_RST% Luu file .docx moi
echo.
echo %C_CYA%  AI Providers ho tro:%C_RST%
echo  %C_GRY%OpenAI, Gemini, Claude, DeepSeek, Custom API%C_RST%
echo.
echo %C_CYA%  Khong can Microsoft Word.%C_RST%
echo  Chi can Python + API key.
echo.
pause
goto :menu

:cachdung
cls
echo.
echo %C_CYA%--- CACH DUNG ---%C_RST%
echo.
echo %C_CYA%  CLI:%C_RST%
echo  %C_WHT%python src/main.py translate "input.docx" -l en%C_RST%
echo.
echo %C_CYA%  Menu:%C_RST%
echo  %C_GRY%1.%C_RST% Chay %C_WHT%run.bat%C_RST%
echo  %C_GRY%2.%C_RST% Menu 3 - Tien ich
echo  %C_GRY%3.%C_RST% Chon 4 - Dich thuat file Word
echo.
echo %C_CYA%  Tham so:%C_RST%
echo  %C_YLW%input%C_RST%          File .doc/.docx can dich
echo  %C_YLW%-l, --lang%C_RST%   Ma ngon ngu dich den (vd: en, zh, ja...)
echo  %C_YLW%-o, --output%C_RST% File dau ra (mac dinh: translated_*.docx)
echo  %C_YLW%-p, --provider%C_RST%  Provider cu the (mac dinh: provider hoat dong dau tien)
echo.
echo %C_CYA%  Vi du:%C_RST%
echo  %C_WHT%translate "baocao.docx" -l en%C_RST%           %C_GRY%-> Dich sang Anh%C_RST%
echo  %C_WHT%translate "baocao.docx" -l zh%C_RST%           %C_GRY%-> Dich sang Trung%C_RST%
echo  %C_WHT%translate "baocao.docx" -l ja -p openai%C_RST%  %C_GRY%-> Dung OpenAI%C_RST%
echo.
pause
goto :menu

:ngonngu
cls
echo.
echo %C_CYA%--- 19 NGON NGU HO TRO ---%C_RST%
echo.
echo  %C_YLW%  Ma    Ten ngon ngu%C_RST%
echo  %C_GRY%  ---   ---------------%C_RST%
echo  %C_WHT%  vi    Tieng Viet%C_RST%
echo  %C_WHT%  en    English%C_RST%
echo  %C_WHT%  zh    Tieng Trung%C_RST%
echo  %C_WHT%  ja    Tieng Nhat%C_RST%
echo  %C_WHT%  ko    Tieng Han%C_RST%
echo  %C_WHT%  fr    Tieng Phap%C_RST%
echo  %C_WHT%  de    Tieng Duc%C_RST%
echo  %C_WHT%  es    Tieng Tay Ban Nha%C_RST%
echo  %C_WHT%  pt    Tieng Bo Dao Nha%C_RST%
echo  %C_WHT%  ru    Tieng Nga%C_RST%
echo  %C_WHT%  ar    Tieng Arab%C_RST%
echo  %C_WHT%  th    Tieng Thai%C_RST%
echo  %C_WHT%  id    Tieng Indonesian%C_RST%
echo  %C_WHT%  ms    Tieng Malaysia%C_RST%
echo  %C_WHT%  it    Tieng Y%C_RST%
echo  %C_WHT%  nl    Tieng Ha Lan%C_RST%
echo  %C_WHT%  sv    Tieng Thuy Dien%C_RST%
echo  %C_WHT%  pl    Tieng Ba Lan%C_RST%
echo  %C_WHT%  tr    Tieng Tho Nhi Ky%C_RST%
echo.
echo  %C_GRY%Dung ma ngon ngu 2 ky tu (vi, en, zh, ja...)%C_RST%
echo.
pause
goto :menu

:batch
cls
echo.
echo %C_CYA%--- BATCH TRANSLATION (3000 KY TU) ---%C_RST%
echo.
echo  De toi uu, nhieu doan van duoc gui cung 1 luc.
echo.
echo %C_CYA%  Quy trinh:%C_RST%
echo  %C_GRY%1.%C_RST% Doc tat ca doan van, loc bo doan trong (< 2 ky tu)
echo  %C_GRY%2.%C_RST% Nhom thanh batch (toi da 3000 ky tu/batch)
echo  %C_GRY%3.%C_RST% Moi batch: them separator ===PARA_SEP=== giua cac doan
echo  %C_GRY%4.%C_RST% Gui AI voi system prompt dich
echo  %C_GRY%5.%C_RST% AI tra ve ket qua voi cung separator
echo  %C_GRY%6.%C_RST% Split ket qua, gan vao tung doan goc
echo.
echo %C_CYA%  Vi du batch:%C_RST%
echo  %C_GRY%Input:  "Xin chao. ===PARA_SEP=== Cam on. ===PARA_SEP=== Tam biet."%C_RST%
echo  %C_GRY%Output: "Hello. ===PARA_SEP=== Thank you. ===PARA_SEP=== Goodbye."%C_RST%
echo.
echo  %C_CYA%Loi ich:%C_RST%  Giam so lan goi API, nhanh hon 5-10x
echo.
pause
goto :menu

:format
cls
echo.
echo %C_CYA%--- GIU NGUYEN FORMAT ---%C_RST%
echo.
echo  Translator giu nguyen toan bo format goc cua file Word.
echo.
echo %C_CYA%  Format duoc giu:%C_RST%
echo  %C_GRY%-%C_RST% Font name, size, bold, italic
echo  %C_GRY%-%C_RST% Mau chu (color)
echo  %C_GRY%-%C_RST% Heading styles (Heading 1-9, Title, Subtitle)
echo  %C_GRY%-%C_RST% Line spacing, alignment
echo  %C_GRY%-%C_RST% Toan bo paragraph format
echo.
echo %C_CYA%  Cach thuc hien:%C_RST%
echo  %C_GRY%-%C_RST% Chi thay doi text cua run dau tien
echo  %C_GRY%-%C_RST% Xoa text cua cac run con lai
echo  %C_GRY%-%C_RST% Giu nguyen toan bo Run objects (font, format)
echo  %C_GRY%-%C_RST% Neu khong co run -> gan truc tiep vao paragraph.text
echo.
echo  %C_CYA%Luu y:%C_RST%
echo  %C_GRY%-%C_RST% Neu file goc co nhieu language (VI+EN), dich het
echo  %C_GRY%-%C_RST% Dau mau tieng Viet co the bi thay doi tuy AI
echo.
pause
goto :menu

:fallback
cls
echo.
echo %C_CYA%--- FALLBACK INDIVIDUAL ---%C_RST%
echo.
echo  Neu batch translation bi loi (sai so luong paragraph),
echo  tu dong chuyen sang dich tung doan rieng le.
echo.
echo %C_CYA%  Nguyen nhan fallback:%C_RST%
echo  %C_GRY%-%C_RST% AI them bot separator ===PARA_SEP===
echo  %C_GRY%-%C_RST% AI them ghi chu, giai thich
echo  %C_GRY%-%C_RST% AI ket nhap 2 doan thanh 1
echo.
echo %C_CYA%  Quy trinh fallback:%C_RST%
echo  %C_GRY%1.%C_RST% Phat hieu: so paragraph dich != so paragraph goc
echo  %C_GRY%2.%C_RST% Log canh bao: "Batch response count mismatch"
echo  %C_GRY%3.%C_RST% Chay _translate_individual() cho tung doan
echo  %C_GRY%4.%C_RST% Moi doan: gui 1 request, nhan 1 response
echo  %C_GRY%5.%C_RST% Neu loi -> giu nguyen text goc
echo.
echo  %C_CYA%Luu y:%C_RST%  Fallback cham hon (nhieu request hon)
echo  nhung dam bao dung so luong paragraph.
echo.
pause
goto :menu

:vidu
cls
echo.
echo %C_CYA%--- VI DU CU THE ---%C_RST%
echo.
echo %C_CYA%  Vi du 1: Dich don gian%C_RST%
echo  %C_WHT%python src/main.py translate "baocao_vi.docx" -l en%C_RST%
echo  %C_GRY%-> File "translated_baocao_vi_en.docx" (Anh)%C_RST%
echo.
echo %C_CYA%  Vi du 2: Dich sang Trung, dung OpenAI%C_RST%
echo  %C_WHT%python src/main.py translate "baocao.docx" -l zh -p openai%C_RST%
echo  %C_GRY%-> File "translated_baocao_zh.docx" (Trung)%C_RST%
echo.
echo %C_CYA%  Vi du 3: Dich va dat ten file%C_RST%
echo  %C_WHT%python src/main.py translate "baocao.docx" -l ja -o "baocao_nhat.docx"%C_RST%
echo  %C_GRY%-> File "baocao_nhat.docx" (Nhat)%C_RST%
echo.
echo %C_CYA%  Vi du 4: Qua run.bat%C_RST%
echo  %C_GRY%1.%C_RST% run.bat -> Menu 3 -> Chon 4
echo  %C_GRY%2.%C_RST% Nhap file, chon ngon ngu, chon provider
echo  %C_GRY%3.%C_RST% Cho AI dich -> Xem ket qua
echo.
pause
goto :menu

:loixuly
cls
echo.
echo %C_CYA%--- XU LY LOI ---%C_RST%
echo.
echo %C_RED%  Loi: "No active AI provider found"%C_RST%
echo  %C_GRY%-%C_RST% Chua setup API key
echo  %C_GRY%-%C_RST% Vao Menu 4 -> Quan ly provider -> Nhap key
echo  %C_GRY%-%C_RST% Kiem tra status: can VALID hoac UNCHECKED
echo.
echo %C_RED%  Loi: "API key is invalid"%C_RST%
echo  %C_GRY%-%C_RST% Key sai hoac het han -> tao key moi
echo.
echo %C_RED%  Loi: "Rate limited (429)"%C_RST%
echo  %C_GRY%-%C_RST% Qua nhieu request -> cho 1-5 phut
echo  %C_GRY%-%C_RST% Hoac chuyen sang provider khac (-p)
echo.
echo %C_RED%  Loi: "Batch count mismatch"%C_RST%
echo  %C_GRY%-%C_RST% Tu dong fallback sang dich tung doan
echo  %C_GRY%-%C_RST% Ket qua van dung nhung cham hon
echo.
echo %C_RED%  File dich bi mat format%C_RST%
echo  %C_GRY%-%C_RST% File goc co format phuc tap (table, shape...)
echo  %C_GRY%-%C_RST% Chi text duoc dich, khong phai toan bo object
echo.
echo %C_RED%  Dich sai nghia%C_RST%
echo  %C_GRY%-%C_RST% Chuyen sang model manh hon (gpt-4o, claude-sonnet-4)%C_RST%
echo  %C_GRY%-%C_RST% Hoac them nguon dich (-l vi en de dich sang EN)%C_RST%
echo.
pause
goto :menu
