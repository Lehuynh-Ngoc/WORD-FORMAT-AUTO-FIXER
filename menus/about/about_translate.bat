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
echo  %C_BLD%%C_CYA  DICH THUAT FILE WORD                      %C_RST%
echo  %C_BLD%%C_CYA  Translate - AI Translation                %C_RST%
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo.
echo  %C_GRN%[1]%C_RST%  Tong quan - Translate la gi?
echo  %C_GRN%[2]%C_RST%  19 Ngon ngu ho tro
echo  %C_GRN%[3]%C_RST%  Quy trinh batch translation
echo  %C_GRN%[4]%C_RST%  Giu nguyen format
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
echo  %C_BLD%%C_CYA  TONG QUAN - TRANSLATE LA GI?               %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Translator%C_RST% dich van ban trong file Word
echo  su dung AI provider. Giu nguyen toan bo dinh dang
echo  goc: font, bold, italic, heading, mau sac...
echo.
echo  %C_BLD%Nguyen ly hoat dong:%C_RST%
echo  - Doc file Word bang python-docx
echo  - Trich xuat tung doan van
echo  - Gui den AI de dich
echo  - Nhan ket qua dich
echo  - Ghi lai vao file Word voi format goc
echo.
echo  %C_BLD%Chat luong:%C_RST%
echo  - Dich chinh xac cho van ban Viet-Anh
echo  - Giu nguyen cau truc van ban
echo  - Phu hop van ban hoc thuat, cong van
echo  - Can AI provider hoat dong
echo.
echo  %C_BLD%Yeu cau:%C_RST%
echo  - Python 3.8+
echo  - python-docx
echo  - Mot AI provider da cai dat
echo  - API key hop le
echo.
pause
goto menu

:page2
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  19 NGON NGU HO TRO                         %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_GRN%Chau A:%C_RST%
echo   - vi  - Tieng Viet
echo   - zh  - Tieng Trung
echo   - ja  - Tieng Nhat
echo   - ko  - Tieng Han
echo   - th  - Tieng Thai
echo   - id  - Tieng Indonesia
echo   - ms  - Tieng Malaysia
echo   - hi  - Tieng Hindi
echo   - ar  - Tieng Arab
echo   - tr  - Tieng Tho Nhi Ky
echo.
echo  %C_YLW%Chau Au:%C_RST%
echo   - en  - Tieng Anh
echo   - fr  - Tieng Phap
echo   - de  - Tieng Duc
echo   - es  - Tieng Tay Ban Nha
echo   - it  - Tieng Y
echo   - pt  - Tieng Bo Dao Nha
echo   - ru  - Tieng Nga
echo   - pl  - Tieng Ba Lan
echo   - nl  - Tieng Ha Lan
echo   - sv  - Tieng Thuy Dien
echo.
echo  %C_BLD%Code ngon ngu:%C_RST% 2 ky tu, viet thuong
echo  Mac dinh: dich sang tieng Viet -l vi
echo.
pause
goto menu

:page3
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  QUY TRINH BATCH TRANSLATION                %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Buoc 1: Chia batch%C_RST%
echo  - Doc toan bo van ban
echo  - Chia thanh cac chunk 3000 ky tu
echo  - Moi chunk giu nguyen cau truc doan
echo  - Dau ===PARA_SEP=== phan biet doan
echo.
echo  %C_BLD%Buoc 2: Gui dich theo batch%C_RST%
echo  - Gui tung chunk den AI
echo  - Nhan ket qua dich
echo  - Kiem tra so luong doan khop
echo  - Neu khop -> tiep tuc
echo.
echo  %C_BLD%Buoc 3: Fallback individual%C_RST%
echo  - Neu batch mismatch -> fallback
echo  - Dich tung doan rieng le
echo  - Dam bao khong mat doan nao
echo  - Xu ly loi cho tung doan
echo.
echo  %C_BLD%Buoc 4: Ghi ket qua%C_RST%
echo  - Ghi dich vao file Word moi
echo  - Giu nguyen font, bold, italic
echo  - Giu nguyen heading, mau sac
echo  - Luu file output
echo.
pause
goto menu

:page4
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  GIU NGUYEN FORMAT                          %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  Translator giu nguyen toan bo format goc:
echo.
echo  %C_GRN%Font:%C_RST%
echo  - Ten font goc -> giu nguyen
echo  - Kich thuoc goc -> giu nguyen
echo  - Mau sac goc -> giu nguyen
echo.
echo  %C_GRN%Style:%C_RST%
echo  - Bold goc -> giu nguyen
echo  - Italic goc -> giu nguyen
echo  - Underline goc -> giu nguyen
echo  - Strikethrough goc -> giu nguyen
echo.
echo  %C_GRN%Cau truc:%C_RST%
echo  - Heading level -> giu nguyen
echo  - List format -> giu nguyen
echo  - Table structure -> giu nguyen
echo  - Page breaks -> giu nguyen
echo.
echo  %C_GRN%Mau sac:%C_RST%
echo  - Mau van ban goc -> giu nguyen
echo  - Mau background -> giu nguyen
echo  - Mau heading -> giu nguyen
echo.
echo  %C_BLD%Luu y:%C_RST% Chi noi dung van ban duoc dich
echo  Dinh dang hoan toan khong thay doi.
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
echo  %C_BLD%1. Dich sang tieng Viet:%C_RST%
echo  python src/main.py translate "input.docx" -l vi
echo.
echo  %C_BLD%2. Dich sang tieng Anh:%C_RST%
echo  python src/main.py translate "input.docx" -l en
echo.
echo  %C_BLD%3. Dich sang Trung Quoc:%C_RST%
echo  python src/main.py translate "input.docx" -l zh
echo.
echo  %C_BLD%4. Qua Menu:%C_RST%
echo  - Mo run.bat -> Menu 3
echo  - Chon Dich thuat
echo  - Chon file can dich
echo  - Chon ngon ngu dich den
echo  - Doi qua trinh
echo.
echo  %C_BLD%5. Tham so:%C_RST%
echo  - -l: ngon ngu dich den, bat buoc
echo  - -o: file output, mac dinh outputs/
echo  - Input file: .docx bat buoc
echo.
echo  %C_BLD%6. Yeu cau:%C_RST%
echo  - AI provider da cai dat
echo  - API key hop le
echo  - File input ton tai
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
echo  %C_BLD%Vi du 1: Dich don xin phep Viet -> Anh%C_RST%
echo  - Input: don_xin_phep_vi.docx
echo  - Output: don_xin_phep_en.docx
echo  - Noi dung: "Toi de nghi..." -> "I propose..."
echo  - Format: TNR 13, justify giu nguyen
echo.
echo  %C_BLD%Vi du 2: Dich bao cao Anh -> Viet%C_RST%
echo  - Input: report_en.docx
echo  - Output: report_vi.docx
echo  - Noi dung: "This report..." -> "Bao cao nay..."
echo  - Heading, bold, italic giu nguyen
echo.
echo  %C_BLD%Vi du 3: Dich luan van Phap -> Viet%C_RST%
echo  - Input: memoire_fr.docx
echo  - Output: memoire_vi.docx
echo  - Noi dung: "Ce memoire..." -> "Luan van nay..."
echo  - TOC, header, footer giu nguyen
echo.
echo  %C_BLD%Vi du 4: Dich phieu bien banNhieu ngon ngu%C_RST%
echo  - Input: bien_ban.docx
echo  - Dich sang Anh, Nhat, Trung
echo  - 3 file output rieng biet
echo  - Format goc hoan toan giu nguyen
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
echo  %C_BLD%Meo 1: Chon ngon ngu chinh xac%C_RST%
echo  - Dung dung ma ngon ngu 2 ky tu
echo  - en, vi, zh, ja, ko...
echo  - Sai ma -> dich sai ngon ngu
echo.
echo  %C_BLD%Meo 2: Kiem tra provider%C_RST%
echo  - Dam bao provider hoat dong
echo  - Kiem tra API key con han
echo  - Chon provider tot nhat
echo.
echo  %C_BLD%Meo 3: File nho thi nhanh%C_RST%
echo  - File nho < 10 trang -> nhanh
echo  - File lon > 50 trang -> cham
echo  - Chenh lech 5-10 phan tram ky tu la binh thuong
echo.
echo  %C_RED%Loi pho bien:%C_RST%
echo.
echo  %C_RED%No active provider%C_RST%
echo  - Chua cai dat provider nao
echo  - Cai dat provider truoc khi dich
echo  - Kiem tra API key hop le
echo.
echo  %C_RED%Batch count mismatch%C_RST%
echo  - So doan dich khac so doan goc
echo  - He thong tu dong fallback
echo  - Dich tung doan rieng le
echo.
echo  %C_RED%API key invalid%C_RST%
echo  - Key sai hoac da het han
echo  - Cap nhat key moi
echo  - Dung provider khac
echo.
pause
goto menu

:end
endlocal
exit /b 0
