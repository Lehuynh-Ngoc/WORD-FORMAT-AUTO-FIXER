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
echo %C_CYA%%C_BLD%  DICH THUAT FILE WORD - Translator                     %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan - Translate la gi?
echo %C_YLW%  2.%C_RST% Cach dung - CLI va Menu
echo %C_YLW%  3.%C_RST% 19 Ngon ngu ho tro
echo %C_YLW%  4.%C_RST% Batch translation
echo %C_YLW%  5.%C_RST% Giu nguyen format
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
echo %C_CYA%%C_BLD%  TONG QUAN - TRANSLATE LA GI?                          %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Translator%C_RST% dich van ban trong file Word
echo su dung AI provider. Giu nguyen toan bo dinh dang
echo goc: font, bold, italic, heading, mau sac...
echo.
echo %C_BLD%Source code:%C_RST% src/core/translator.py
echo - translate_document(): ham chinh
echo - _translate_batch(): dich theo chunk
echo - _translate_individual(): fallback
echo - _call_api(): goi API theo provider
echo - CHUNK_SIZE = 3000 ky tu
echo.
echo %C_BLD%Nguyen ly hoat dong:%C_RST%
echo 1. Doc file Word bang python-docx qua parser
echo 2. Trich xuat tung doan van (paragraph)
echo 3. Bo qua doan trong < 2 ky tu
echo 4. Chia thanh cac chunk 3000 ky tu
echo 5. Gui tung chunk den AI voi PARA_SEP
echo 6. Nhan ket qua, kiem tra so luong doan
echo 7. Neu batch mismatch -> fallback individual
echo 8. Ghi lai vao file Word voi format goc
echo.
echo %C_BLD%Yeu cau:%C_RST%
echo   - Python 3.8+
echo   - python-docx
echo   - Mot AI provider da cai dat
echo   - API key hop le
echo.
pause
goto :menu

:page2
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CACH DUNG - CLI VA MENU                               %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%1. Dich sang tieng Viet:%C_RST%
echo   python src/main.py translate "input.docx" -l vi
echo.
echo %C_BLD%2. Dich sang tieng Anh:%C_RST%
echo   python src/main.py translate "input.docx" -l en
echo.
echo %C_BLD%3. Dich sang Trung Quoc:%C_RST%
echo   python src/main.py translate "input.docx" -l zh
echo.
echo %C_BLD%4. Chi dinh provider:%C_RST%
echo   python src/main.py translate "input.docx" -l en -p openai
echo.
echo %C_BLD%5. Chi dinh output:%C_RST%
echo   python src/main.py translate "input.docx" -l fr -o report_fr.docx
echo.
echo %C_BLD%6. Qua Menu:%C_RST%
echo   Mo run.bat -> Menu 3 -> Chon Dich thuat
echo   Chon file, chon ngon ngu, doi qua trinh
echo.
echo %C_BLD%7. Tham so:%C_RST%
echo   - input: duong dan file .docx, bat buoc
echo   - -l:   ngon ngu dich den, bat buoc
echo   - -s:   ngon ngu nguon (Enter = tu dong detect)
echo   - -o:   file output, mac dinh {input}_{lang}.docx
echo   - -p:   provider (openai, gemini, claude, deepseek, custom)
echo.
pause
goto :menu

:page3
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  19 NGON NGU HO TRO                                     %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRN%Chau A:%CRST%
echo   vi  - Tieng Viet        zh  - Tieng Trung
echo   ja  - Tieng Nhat        ko  - Tieng Han
echo   th  - Tieng Thai        id  - Tieng Indonesia
echo   ms  - Tieng Malaysia    hi  - Tieng Hindi
echo   ar  - Tieng Arab        tr  - Tieng Tho Nhi Ky
echo.
echo %C_YLW%Chau Au:%CRST%
echo   en  - Tieng Anh         fr  - Tieng Phap
echo   de  - Tieng Duc         es  - Tieng Tay Ban Nha
echo   it  - Tieng Y           pt  - Tieng Bo Dao Nha
echo   ru  - Tieng Nga         pl  - Tieng Ba Lan
echo   nl  - Tieng Ha Lan      sv  - Tieng Thuy Dien
echo.
echo %C_BLD%Code ngon ngu:%C_RST% 2 ky tu, viet thuong
echo Mac dinh: dich sang tieng Viet voi -l vi
echo.
pause
goto :menu

:page4
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  BATCH TRANSLATION                                     %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Buoc 1: Chia batch%CRST%
echo   - Doc toan bo van ban tu file Word
echo   - Chia thanh cac chunk 3000 ky tu
echo   - Moi chunk giu nguyen cau truc doan
echo   - Dau ===PARA_SEP=== phan biet doan
echo.
echo %C_BLD%Buoc 2: Gui dich theo batch%CRST%
echo   - Gui tung chunk den AI provider
echo   - Nhan ket qua dich
echo   - Tach ket qua bang ===PARA_SEP===
echo   - Kiem tra: so doan dich == so doan goc
echo   - Neu khop -> tiep tuc
echo.
echo %C_BLD%Buoc 3: Fallback individual%CRST%
echo   - Neu batch count mismatch -> fallback
echo   - Dich tung doan rieng le
echo   - Dam bao khong mat doan nao
echo   - Xu ly loi cho tung doan
echo.
echo %C_BLD%Buoc 4: Ghi ket qua%CRST%
echo   - Ghi dich vao file Word moi
echo   - Giu nguyen font, bold, italic
echo   - Giu nguyen heading, mau sac
echo   - Luu file output
echo.
echo %C_BLD%Luu y:%CRST% Doi voi doan ngan (< 2 ky tu) se bi bo qua
echo Chenh lech 5-10 phan tram ky tu la binh thuong
echo.
pause
goto :menu

:page5
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  GIU NGUYEN FORMAT                                     %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo Translator giu nguyen toan bo format goc:
echo.
echo %C_GRN%Font:%CRST%
echo   Ten font goc -> giu nguyen
echo   Kich thuoc goc -> giu nguyen
echo   Mau sac goc -> giu nguyen
echo.
echo %C_GRN%Style:%CRST%
echo   Bold goc -> giu nguyen
echo   Italic goc -> giu nguyen
echo   Underline goc -> giu nguyen
echo   Strikethrough goc -> giu nguyen
echo.
echo %C_GRN%Cau truc:%CRST%
echo   Heading level -> giu nguyen
echo   List format -> giu nguyen
echo   Table structure -> giu nguyen
echo   Page breaks -> giu nguyen
echo.
echo %C_GRN%Thuc hien:%CRST%
echo   - Chi thay doi text trong run dau tien
echo   - Cac run sau bi xoa (text = "")
echo   - Giu nguyen toan bo formatting goc
echo.
echo %C_BLD%Luu y:%CRST% Chi noi dung van ban duoc dich
echo Dinh dang hoan toan khong thay doi.
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
echo %C_RED%Loi 1: No active provider%CRST%
echo   Nguyen nhan: Chua cai dat provider nao
echo   Giai phap: python src/main.py settings
echo   Them provider voi API key hop le
echo.
echo %C_RED%Loi 2: API key invalid%CRST%
echo   Nguyen nhan: Key sai hoac da het han
echo   Giai phap: Cap nhat key moi qua settings
echo   Kiem tra: python src/main.py settings
echo.
echo %C_RED%Loi 3: Rate limited%CRST%
echo   Nguyen nhan: Qua nhieu request
echo   Giai phap: Doi 1 phut roi thu lai
echo   Dung provider khac hoac giam tan suat
echo.
echo %C_RED%Loi 4: Batch count mismatch%CRST%
echo   Nguyen nhan: So doan dich khac so doan goc
echo   Giai phap: He thong tu dong fallback
echo   Dich tung doan rieng le
echo.
echo %C_RED%Loi 5: Network error%CRST%
echo   Nguyen nhan: Mat ket noi mang
echo   Giai phap: Kiem tra internet, thu lai
echo   Dung VPN neu bi chan
echo.
pause
goto :menu
