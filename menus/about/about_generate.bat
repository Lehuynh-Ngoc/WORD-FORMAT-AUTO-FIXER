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
echo %C_CYA%%C_BLD%  TAO VAN BAN AI - DocGenerator                          %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan - Generate la gi?
echo %C_YLW%  2.%C_RST% Cach dung - CLI va Menu
echo %C_YLW%  3.%C_RST% 19 Loai van ban ho tro
echo %C_YLW%  4.%C_RST% Dinh dang output
echo %C_YLW%  5.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto page1
if "%SUB%"=="2" goto page2
if "%SUB%"=="3" goto page3
if "%SUB%"=="4" goto page4
if "%SUB%"=="5" goto page5
if "%SUB%"=="0" exit /b
goto :menu

:page1
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  TONG QUAN - GENERATE LA GI?                           %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%DocGenerator%C_RST% tao van ban Word hoan chinh
echo su dung AI. Quy trinh hoi dap: AI dat cau hoi,
echo ban tra loi, AI viet noi dung theo cau tra loi.
echo.
echo %C_BLD%Source code:%C_RST% src/core/doc_generator.py
echo - ask_ai_questions(): AI tao 4-8 cau hoi
echo - generate_document_content(): AI viet noi dung
echo - save_as_docx(): luu thanh file .docx
echo - _call_ai(): goi API theo provider
echo.
echo %C_BLD%Nguyen ly hoat dong:%C_RST%
echo 1. Chon loai van ban can tao
echo 2. GUI provider cau hoi: "Hoi thong tin de tao loai nay"
echo 3. Nhan 4-8 cau hoi tu AI (JSON format)
echo 4. Ban tra loi tung cau hoi
echo 5. GUI cau tra loi cho AI de viet noi dung
echo 6. Nhan noi dung markdown tu AI
echo 7. Parse markdown: # Title, ## Heading, plain text
echo 8. Tao file .docx voi dinh dang chuan
echo.
echo %C_BLD%Uu diem:%C_RST%
echo   - Tao van ban nhanh, tiet kiem thoi gian
echo   - Dinh dang chuan, chinh xac
echo   - Phu hop van ban Viet Nam
echo   - 19 loai van ban pho bien
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
echo %C_BLD%1. Lenh CLI:%C_RST%
echo   python src/main.py generate
echo   Mo giao dien tuong tac, chon loai van ban
echo.
echo %C_BLD%2. Chi dinh output:%C_RST%
echo   python src/main.py generate -o report.docx
echo.
echo %C_BLD%3. Qua Menu:%C_RST%
echo   Mo run.bat -> Menu 3 -> Chon Tao van ban AI
echo   Lam theo huong dan
echo.
echo %C_BLD%4. Quy trinh:%C_RST%
echo   - Chon loai: 1-19
echo   - Tra loi 4-8 cau hoi
echo   - Doi AI viet noi dung
echo   - Kiem tra ket qua
echo   - Luu file
echo.
echo %C_BLD%5. File output:%C_RST%
echo   Mac dinh: outputs/generated_{loai}.docx
echo   Ten file theo loai van ban
echo   Co the chi dinh ten khac voi -o
echo.
echo %C_BLD%6. Yeu cau:%C_RST%
echo   - AI provider da cai dat
echo   - API key hop le
echo   - Internet ket noi
echo.
pause
goto :menu

:page3
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  19 LOAI VAN BAN HO TRO                                 %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRN%Van ban hanh chinh:%CRST%
echo    1. Don xin phep        6. Thong bao
echo    2. Don xin viec
echo    3. Thu ming
echo    4. Cong van
echo    5. Quyet dinh
echo.
echo %C_YLW%Van ban hoc thuat:%CRST%
echo    7. Bao cao            11. Bieu mau
echo    8. De cuong
echo    9. Luan van
echo   10. Phuc trinh
echo.
echo %C_CYA%Van ban cong ty:%CRST%
echo   12. Bien ban hop       16. Ho so xin viec
echo   13. Phieu bien ban     17. Hoc bong
echo   14. Phieu giao viec
echo   15. Bai viet
echo.
echo %C_GRN%Khac:%CRST%
echo   18. Bao cao tong hop
echo   19. Van ban tuy chinh
echo.
pause
goto :menu

:page4
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  DINH DANG OUTPUT                                       %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo File output duoc dinh dang chuan bang python-docx:
echo.
echo %C_BLD%Van ban chinh - Normal:%C_RST%
echo   Font: Times New Roman, Size: 13
echo   Can le: justify, Line spacing: 1.5
echo   Space before: 0pt, Space after: 6pt
echo.
echo %C_BLD%Tieu de chinh - Title:%C_RST%
echo   Font: Times New Roman, Size: 16
echo   Bold: co, Can le: center
echo   Space before: 12pt, Space after: 12pt
echo.
echo %C_BLD%Tieu de muc - Heading 2:%C_RST%
echo   Font: Times New Roman, Size: 14
echo   Bold: co, Can le: left
echo   Space before: 12pt, Space after: 6pt
echo.
echo %C_BLD%Heading 3:%C_RST%
echo   Font: Times New Roman, Size: 13
echo   Bold: co, Can le: left
echo   Space before: 6pt, Space after: 3pt
echo.
echo %C_BLD%Bullet list:%C_RST%
echo   Style: List Bullet
echo   Font: Times New Roman, Size: 13
echo.
echo %C_BLD%Luu y:%C_RST% Dinh dang co the chinh sua
echo sau khi tao xong bang FormatEngine.
echo.
pause
goto :menu

:page5
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  XU LY LOI                                              %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_RED%Loi 1: No active provider%CRST%
echo   Nguyen nhan: Chua cai dat AI provider
echo   Giai phap: python src/main.py settings
echo   Them provider voi API key hop le
echo.
echo %C_RED%Loi 2: API key invalid%CRST%
echo   Nguyen nhan: Key sai hoac het han
echo   Giai phap: Cap nhat key moi qua settings
echo.
echo %C_RED%Loi 3: Output directory not found%CRST%
echo   Nguyen nhan: Thu muc outputs/ khong ton tai
echo   Giai phap: Tao thu muc truoc hoac chay init
echo.
echo %C_RED%Loi 4: Rate limited%CRST%
echo   Nguyen nhan: API bi gioi han
echo   Giai phap: Doi 1 phut, thu lai
echo   Dung provider khac
echo.
echo %C_RED%Loi 5: JSON parse error%CRST%
echo   Nguyen nhan: AI tra loi khong dung JSON
echo   Giai phap: Thu lai, AI co the tra loi tot hon
echo   Kiem tra ket noi mang on dinh
echo.
pause
goto :menu
