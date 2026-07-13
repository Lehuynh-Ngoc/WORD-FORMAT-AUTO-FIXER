@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ANSI color codes
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "C_CYA=%ESC%[36m"
set "C_YLW=%ESC%[33m"
set "C_GRN=%ESC%[32m"
set "C_RED=%ESC%[31m"
set "C_GRY=%ESC%[90m"
set "C_WHT=%ESC%[37m"
set "C_BLD=%ESC%[1m"
set "C_RST=%ESC%[0m"

set ROOT=%~dp0
cd /d "%ROOT%"

:: Kiem tra Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo %C_RED%[LOI]%C_RST% Python chua duoc cai dat!
    echo Vui long cai dat Python 3.10+ tu python.org
    echo.
    pause
    exit /b 1
)

:: Kiem tra thu vien
python -c "import docx; import yaml" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo %C_YLW%[DANG]%C_RST% Cai dat thu vien can thiet...
    pip install -r requirements.txt
    echo.
)

set RULE_FILE=

:: Dem file mau trong thu muc mau/ (dat truoc de menu doc duoc)
set MAU_COUNT=0
for %%f in (mau\*.doc mau\*.docx) do set /A MAU_COUNT+=1

:: ===================================================================
:: MAIN MENU
:: ===================================================================
:menu
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%      WORD FORMAT AUTO-FIXER              %C_RST%
echo %C_CYA%      Tu dong dinh dang file Word         %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_GRY%  File can sua:  %C_RST%%C_RED%(nhap khi chon chuc nang)%C_RST%
echo %C_GRY%  File mau:      %C_RST%%C_CYA%%MAU_COUNT% file trong thu muc mau\/%C_RST%
echo %C_GRY%  Ket qua xuat:  %C_RST%%C_CYA%outputs\/ folder%C_RST%
echo.
echo %C_GRY%--------------------------------------------%C_RST%
echo %C_YLW%  1.%C_RST% Hoc va Cau hinh
echo %C_YLW%  2.%C_RST% Dinh dang va Clone
echo %C_YLW%  3.%C_RST% Tien ich
echo %C_YLW%  4.%C_RST% Thong tin ung dung
echo %C_YLW%  5.%C_RST% Cai dat
echo %C_RED%  0.%C_RST% Thoat
echo %C_GRY%--------------------------------------------%C_RST%
echo.
set /p CHOICE="%C_YLW%Nhap so (0-5): %C_RST%"

if "%CHOICE%"=="1" goto :menu_hoc
if "%CHOICE%"=="2" goto :menu_dinhdang
if "%CHOICE%"=="3" goto :menu_tienich
if "%CHOICE%"=="4" goto :about
if "%CHOICE%"=="5" goto :menu_caidat
if "%CHOICE%"=="0" exit /b

echo %C_RED%So khong hop le, vui long nhap lai.%C_RST%
timeout /t 2 >nul
goto :menu

:: ===================================================================
:: SUBMENU 1 - HOC & CAU HINH
:: ===================================================================
:menu_hoc
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    HOC VA CAU HINH                      %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo Chon chuc nang:
echo.
echo %C_YLW%  1.%C_RST% Hoc formatting tu file mau
echo %C_GRY%     (Phan tich file mau, tu dong tao rule)%C_RST%
echo.
echo %C_YLW%  2.%C_RST% Tao rule thu cong
echo %C_GRY%     (Nhap thong so font, spacing, alignment)%C_RST%
echo.
echo %C_YLW%  3.%C_RST% Cau hinh SmartHeading patterns
echo %C_GRY%     (Them regex de phat hien tieu de va gan style)%C_RST%
echo.
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Nhap so (0-3): %C_RST%"

if "%SUB%"=="1" goto :learn
if "%SUB%"=="2" goto :makerule
if "%SUB%"=="3" goto :smartconfig
if "%SUB%"=="0" goto :menu

goto :menu_hoc

:: ===================================================================
:: SUBMENU 2 - DINH DANG & CLONE
:: ===================================================================
:menu_dinhdang
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    DINH DANG VA CLONE                    %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo Chon chuc nang:
echo.
echo %C_YLW%  1.%C_RST% Xem truoc thay doi %C_GRY%(preview)%C_RST%
echo %C_GRY%     (Xem thay doi, khong ghi file)%C_RST%
echo.
echo %C_YLW%  2.%C_RST% Dinh dang file Word
echo %C_GRY%     (Chon file rule bat ky)%C_RST%
echo.
echo %C_YLW%  3.%C_RST% Dinh dang voi rule mac dinh
echo %C_GRY%     (Default / Academic / Smart patterns)%C_RST%
echo.
echo %C_YLW%  4.%C_RST% Clone dinh dang tu file mau
echo %C_GRY%     (Section, header, watermark, TOC...)  %C_RST%
echo.
echo %C_YLW%  5.%C_RST% Xem truoc clone %C_GRY%(preview)%C_RST%
echo %C_GRY%     (Mo Word xem, roi hoi co luu)%C_RST%
echo.
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Nhap so (0-5): %C_RST%"

if "%SUB%"=="1" goto :preview
if "%SUB%"=="2" goto :format
if "%SUB%"=="3" goto :format_builtin
if "%SUB%"=="4" goto :clone
if "%SUB%"=="5" goto :clone_preview
if "%SUB%"=="0" goto :menu

goto :menu_dinhdang

:: ===================================================================
:: SUBMENU 3 - TIEN ICH
:: ===================================================================
:menu_tienich
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    TIEN ICH                              %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo Chon chuc nang:
echo.
echo %C_YLW%  1.%C_RST% Danh sach rules co san
echo %C_GRY%     (Xem file rule trong thu muc rules/)  %C_RST%
echo.
echo %C_YLW%  2.%C_RST% Chay unit tests
echo %C_GRY%     (Kiem tra tinh dung dan chuong trinh)%C_RST%
echo.
echo %C_YLW%  3.%C_RST% Dem so tu va trang
echo %C_GRY%     (Dem chi tiet: tu, ky tu, dong, trang)%C_RST%
echo.
echo %C_YLW%  4.%C_RST% Dich thuat file Word
echo %C_GRY%     (Dich toan bo bang AI)%C_RST%
echo.
echo %C_YLW%  5.%C_RST% Tao van ban bang AI
echo %C_GRY%     (AI hoi cau hoi, ban tra loi, AI tao file)%C_RST%
echo.
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Nhap so (0-5): %C_RST%"

if "%SUB%"=="1" goto :listrules
if "%SUB%"=="2" goto :runtests
if "%SUB%"=="3" goto :wordcount
if "%SUB%"=="4" goto :translate
if "%SUB%"=="5" goto :docgenerate
if "%SUB%"=="0" goto :menu

goto :menu_tienich

:: ===================================================================
:: CAC CHUC NANG CU THE
:: ===================================================================

:: --- HOC ---
:learn
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    HOC FORMATTING TU FILE MAU            %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
set /p LFINPUT="%C_YLW%Nhap duong dan file mau (.doc/.docx): %C_RST%"
if "%LFINPUT%"=="" (
    echo %C_RED%[LOI]%C_RST% Vui long nhap duong dan file.
    pause
    goto :menu_hoc
)
if not exist "%LFINPUT%" (
    echo %C_RED%[LOI]%C_RST% Khong tim thay file: %LFINPUT%
    pause
    goto :menu_hoc
)
set /p RNAME="%C_YLW%Ten rule (Enter = learned_rules): %C_RST%"
if "%RNAME%"=="" set RNAME=learned_rules
echo.
echo %C_GRY%  Dang hoc tu: %C_WHT%%LFINPUT%%C_RST%
echo.
python src\main.py learn "%LFINPUT%" -o "rules\%RNAME%.yaml"
if %errorlevel% equ 0 (
    echo.
    echo %C_GRN%[OK]%C_RST% Da tao %C_WHT%rules\%RNAME%.yaml%C_RST%
)
echo.
pause
goto :menu_hoc

:: --- MAKERULE ---
:makerule
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    TAO RULE THU CONG                     %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo Nhap gia tri cho tung style.
echo %C_GRY%De trong = bo qua style do.%C_RST%
echo.
python src\cli\maker.py
echo.
pause
goto :menu_hoc

:: --- SMARTCONFIG ---
:smartconfig
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    CAU HINH SMARTHEADING PATTERNS       %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo Them %C_YLW%pattern regex%C_RST% de tu dong phat hien
echo tieu de trong noi dung va gan style mong muon.
echo.
echo %C_GRY%File luu: rules/smart_patterns.yaml%C_RST%
echo.
pause
python src\cli\smart_config.py
echo.
pause
goto :menu_hoc

:: --- PREVIEW ---
:preview
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    XEM TRUOC THAY DOI                    %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
set /p FINPUT="%C_YLW%Nhap duong dan file can xem: %C_RST%"
if "%FINPUT%"=="" (
    echo %C_RED%[LOI]%C_RST% Vui long nhap duong dan file.
    pause
    goto :menu_dinhdang
)
if not exist "%FINPUT%" (
    echo %C_RED%[LOI]%C_RST% Khong tim thay file: %FINPUT%
    pause
    goto :menu_dinhdang
)
echo.
echo %C_GRY%  File: %C_WHT%%FINPUT%%C_RST%
echo.
python src\main.py preview "%FINPUT%"
echo.
pause
goto :menu_dinhdang

:: --- FORMAT ---
:format
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    DINH DANG FILE WORD                   %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_CYA%  File mau co san: %C_RST%
set /A IDX=0
for %%f in (mau\*.doc mau\*.docx) do (
    set /A IDX+=1
    set "FILE!IDX!=%%f"
    echo %C_YLW%    !IDX!.%C_RST% %%~nxf
)
echo %C_RED%    0.%C_RST% Quay lai
echo.
if !IDX! equ 0 goto :format_nofile
echo   %C_YLW%Chon so hoac nhap duong dan file Word:%C_RST%
set /p "FINPUT=  %C_CYA%^> %C_RST%"
if "!FINPUT!"=="0" goto :menu_dinhdang
if "!FINPUT!"=="" goto :menu_dinhdang
set "FINPUT_FILE="
for /L %%i in (1,1,!IDX!) do (
    if "!FINPUT!"=="%%i" set "FINPUT_FILE=!FILE%%i!"
)
if "!FINPUT_FILE!"=="" set "FINPUT_FILE=!FINPUT!"
goto :format_have_file

:format_nofile
echo   %C_RED%(khong co file mau trong thu muc mau\)%C_RST%
echo   %C_YLW%Nhap duong dan file Word:%C_RST%
set /p "FINPUT_FILE=  %C_CYA%^> %C_RST%"
if "!FINPUT_FILE!"=="" goto :menu_dinhdang

:format_have_file
if not exist "!FINPUT_FILE!" (
    echo.
    echo   %C_RED%[LOI]%C_RST% Khong tim thay file: !FINPUT_FILE!
    pause
    goto :menu_dinhdang
)
echo %C_GRY%  File: %C_WHT%!FINPUT_FILE!%C_RST%
echo.
echo %C_CYA%  Rules co san:%C_RST%
set /A RIDX=0
for %%r in (rules\*.yaml rules\*.yml) do (
    set /A RIDX+=1
    set "RULE!RIDX!=%%r"
    echo %C_YLW%    !RIDX!.%C_RST% %%~nxr
)
echo.
if !RIDX! equ 0 goto :format_rule_nofile
echo   %C_YLW%Chon so hoac nhap ten file rule:%C_RST%
set /p "RULE_CHOICE=  %C_CYA%^> %C_RST%"
if "!RULE_CHOICE!"=="0" goto :menu_dinhdang
if "!RULE_CHOICE!"=="" set RULE_CHOICE=1
set "RULE_FILE="
for /L %%i in (1,1,!RIDX!) do (
    if "!RULE_CHOICE!"=="%%i" set "RULE_FILE=!RULE%%i!"
)
if "!RULE_FILE!"=="" set "RULE_FILE=rules\!RULE_CHOICE!"
goto :format_have_rule

:format_rule_nofile
echo   %C_RED%(khong co file rule nao)%C_RST%
set /p RULE_FILE="%C_YLW%Nhap file rule:%C_RST%"
if "!RULE_FILE!"=="" set RULE_FILE=rules\default.yaml

:format_have_rule
if not exist "!RULE_FILE!" (
    if exist "rules\!RULE_FILE!" (
        set "RULE_FILE=rules\!RULE_FILE!"
    ) else (
        echo %C_RED%[LOI]%C_RST% Khong tim thay file rule: !RULE_FILE!
        pause
        goto :menu_dinhdang
    )
)
set /p OUTFILE="%C_YLW%File dau ra (Enter = outputs/output.docx): %C_RST%"
if "%OUTFILE%"=="" set OUTFILE=outputs/output.docx
echo.
echo %C_GRY%  Rule: %C_WHT%!RULE_FILE!%C_RST%
echo %C_GRY%  Output: %C_WHT%%OUTFILE%%C_RST%
echo.
python src\main.py format "!FINPUT_FILE!" -o "%OUTFILE%" -r "!RULE_FILE!"
if %errorlevel% equ 0 (
    echo.
    echo %C_GRN%[OK]%C_RST% File da duoc dinh dang: %C_WHT%%OUTFILE%%C_RST%
)
echo.
pause
goto :menu_dinhdang

:: --- FORMAT BUILTIN ---
:format_builtin
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    DINH DANG VOI RULE MAC DINH          %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo Chon rule:
echo.
echo %C_YLW%  1.%C_RST% Default %C_GRY%(Times New Roman 13, justify, 1.5)%C_RST%
echo %C_YLW%  2.%C_RST% Academic %C_GRY%(nhu Default + thut dau dong)%C_RST%
echo %C_YLW%  3.%C_RST% Default + Smart patterns %C_GRY%(ket hop)%C_RST%
echo %C_YLW%  4.%C_RST% Chon rule khac tu danh sach
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Nhap so (0-4): %C_RST%"
if "%SUB%"=="0" goto :menu_dinhdang
if "%SUB%"=="1" set RULE_FILE=rules\default.yaml
if "%SUB%"=="2" set RULE_FILE=rules\academic.yaml
if "%SUB%"=="3" set RULE_FILE=rules\default.yaml,rules\smart_patterns.yaml
if "%SUB%"=="4" goto :format_builtin_pick
if "%RULE_FILE%"=="" goto :format_builtin
goto :format_builtin_have_rule

:format_builtin_pick
echo.
echo %C_CYA%  Rules co san:%C_RST%
set /A RIDX=0
for %%r in (rules\*.yaml rules\*.yml) do (
    set /A RIDX+=1
    set "RULE!RIDX!=%%r"
    echo %C_YLW%    !RIDX!.%C_RST% %%~nxr
)
echo.
if !RIDX! equ 0 goto :format_builtin_pick_nofile
echo   %C_YLW%Chon so hoac nhap ten file rule:%C_RST%
set /p "RULE_CHOICE=  %C_CYA%^> %C_RST%"
if "!RULE_CHOICE!"=="0" goto :menu_dinhdang
if "!RULE_CHOICE!"=="" goto :format_builtin
set "RULE_FILE="
for /L %%i in (1,1,!RIDX!) do (
    if "!RULE_CHOICE!"=="%%i" set "RULE_FILE=!RULE%%i!"
)
if "!RULE_FILE!"=="" set "RULE_FILE=rules\!RULE_CHOICE!"
goto :format_builtin_check_rule

:format_builtin_pick_nofile
echo   %C_RED%(khong co file rule nao)%C_RST%
set /p RULE_FILE="%C_YLW%Nhap file rule:%C_RST%"
if "!RULE_FILE!"=="" goto :format_builtin

:format_builtin_check_rule
if not exist "!RULE_FILE!" (
    if exist "rules\!RULE_FILE!" (
        set "RULE_FILE=rules\!RULE_FILE!"
    ) else (
        echo   %C_RED%[LOI]%C_RST% Khong tim thay: !RULE_FILE!
        pause
        goto :menu_dinhdang
    )
)

:format_builtin_have_rule
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    DINH DANG VOI !RULE_FILE!  %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_CYA%  File mau co san: %C_RST%
set /A IDX=0
for %%f in (mau\*.doc mau\*.docx) do (
    set /A IDX+=1
    set "FILE!IDX!=%%f"
    echo %C_YLW%    !IDX!.%C_RST% %%~nxf
)
echo %C_RED%    0.%C_RST% Quay lai
echo.
if !IDX! equ 0 goto :format_builtin_nofile
echo   %C_YLW%Chon so hoac nhap duong dan file Word:%C_RST%
set /p "FINPUT=  %C_CYA%^> %C_RST%"
if "!FINPUT!"=="0" goto :menu_dinhdang
if "!FINPUT!"=="" goto :menu_dinhdang
set "FINPUT_FILE="
for /L %%i in (1,1,!IDX!) do (
    if "!FINPUT!"=="%%i" set "FINPUT_FILE=!FILE%%i!"
)
if "!FINPUT_FILE!"=="" set "FINPUT_FILE=!FINPUT!"
goto :format_builtin_have_file

:format_builtin_nofile
echo   %C_RED%(khong co file mau trong thu muc mau\)%C_RST%
echo   %C_YLW%Nhap duong dan file Word:%C_RST%
set /p "FINPUT_FILE=  %C_CYA%^> %C_RST%"
if "!FINPUT_FILE!"=="" goto :menu_dinhdang

:format_builtin_have_file
if not exist "!FINPUT_FILE!" (
    echo.
    echo   %C_RED%[LOI]%C_RST% Khong tim thay file: !FINPUT_FILE!
    pause
    goto :menu_dinhdang
)
echo %C_GRY%  File: %C_WHT%!FINPUT_FILE!%C_RST%
set /p OUTFILE="%C_YLW%File dau ra (Enter = outputs/output.docx): %C_RST%"
if "%OUTFILE%"=="" set OUTFILE=outputs/output.docx
echo %C_GRY%  Output: %C_WHT%%OUTFILE%%C_RST%
echo.
python src\main.py format "!FINPUT_FILE!" -o "%OUTFILE%" -r "!RULE_FILE!"
if %errorlevel% equ 0 (
    echo.
    echo %C_GRN%[OK]%C_RST% File da duoc dinh dang: %C_WHT%%OUTFILE%%C_RST%
)
echo.
pause
goto :menu_dinhdang

:: --- CLONE ---
:clone
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    CLONE DINH DANG TU FILE MAU          %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo  Clone toan bo dinh dang %C_GRY%(section, page setup,%C_RST%
echo  header/footer, watermark, style, column, TOC...)%C_RST%
echo  %C_GRY%tu file mau trong thu muc mau\/ sang file can sua.%C_RST%
echo.
echo %C_CYA%  File mau co san: %C_RST%
set /A IDX=0
for %%f in (mau\*.doc mau\*.docx) do (
    set /A IDX+=1
    set "FILE!IDX!=%%f"
    echo %C_YLW%    !IDX!.%C_RST% %%~nxf
)
echo %C_RED%    0.%C_RST% Quay lai
echo.
if !IDX! equ 0 goto :clone_nofile
echo   %C_YLW%Chon so hoac nhap duong dan file mau:%C_RST%
set /p "CLONE_CHOICE=  %C_CYA%^> %C_RST%"
if "!CLONE_CHOICE!"=="0" goto :menu_dinhdang
if "!CLONE_CHOICE!"=="" goto :menu_dinhdang
set "CLONE_FILE="
for /L %%i in (1,1,!IDX!) do (
    if "!CLONE_CHOICE!"=="%%i" set "CLONE_FILE=!FILE%%i!"
)
if "!CLONE_FILE!"=="" set "CLONE_FILE=!CLONE_CHOICE!"
goto :clone_have_file

:clone_nofile
echo   %C_RED%(khong co file mau trong thu muc mau\)%C_RST%
echo   %C_YLW%Nhap duong dan file mau:%C_RST%
set /p "CLONE_FILE=  %C_CYA%^> %C_RST%"
if "!CLONE_FILE!"=="" goto :menu_dinhdang

:clone_have_file
if not exist "!CLONE_FILE!" (
    echo.
    echo   %C_RED%[LOI]%C_RST% Khong tim thay file mau: !CLONE_FILE!
    pause
    goto :menu_dinhdang
)
echo.
echo   %C_YLW%File can dinh dang:%C_RST% %C_GRY%(0 = quay lai)%C_RST%
set /p "CLONE_TARGET=  %C_CYA%^> %C_RST%"
if "!CLONE_TARGET!"=="0" goto :menu_dinhdang
if "!CLONE_TARGET!"=="" (
    echo   %C_RED%[LOI]%C_RST% Vui long nhap file can dinh dang.
    pause
    goto :menu_dinhdang
)
if not exist "!CLONE_TARGET!" (
    echo.
    echo   %C_RED%[LOI]%C_RST% Khong tim thay file: !CLONE_TARGET!
    pause
    goto :menu_dinhdang
)
echo.
echo   %C_YLW%File dau ra (Enter = outputs\cloned.docx):%C_RST%
set /p "CLONE_OUT=  %C_CYA%^> %C_RST%"
if "!CLONE_OUT!"=="" set "CLONE_OUT=outputs\cloned.docx"
echo.
echo   %C_GRY%Template:%C_RST% %C_WHT%!CLONE_FILE!%C_RST%
echo   %C_GRY%Target:  %C_RST% %C_WHT%!CLONE_TARGET!%C_RST%
echo   %C_GRY%Output:  %C_RST% %C_WHT%!CLONE_OUT!%C_RST%
echo.
echo   %C_YLW%Dang clone... (vui long cho)%C_RST%
echo.
python src\main.py clone "!CLONE_FILE!" "!CLONE_TARGET!" -o "!CLONE_OUT!"
if !errorlevel! equ 0 (
    echo.
    echo   %C_GRN%[OK]%C_RST% Da clone thanh cong: %C_WHT%!CLONE_OUT!%C_RST%
) else (
    echo.
    echo   %C_RED%[LOI]%C_RST% Clone that bai. Vui long kiem tra:
    echo   %C_RED%-%C_RST% File mau co dinh dang Word dung khong?
    echo   %C_RED%-%C_RST% Microsoft Word da cai dat chua?
    echo   %C_RED%-%C_RST% File co dang mo trong Word khong?
)
echo.
pause
goto :menu_dinhdang

:: --- CLONE PREVIEW ---
:clone_preview
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    XEM TRUOC CLONE                       %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo  Mo Word de xem ket qua clone %C_GRY%(khong ghi file)%C_RST%
echo  Sau do hoi ban co luu khong.
echo.
echo %C_CYA%  File mau co san: %C_RST%
set /A IDX=0
for %%f in (mau\*.doc mau\*.docx) do (
    set /A IDX+=1
    set "FILE!IDX!=%%f"
    echo %C_YLW%    !IDX!.%C_RST% %%~nxf
)
echo %C_RED%    0.%C_RST% Quay lai
echo.
if !IDX! equ 0 goto :clone_preview_nofile
echo   %C_YLW%Chon so hoac nhap duong dan file mau:%C_RST%
set /p "CLONE_PREV_CHOICE=  %C_CYA%^> %C_RST%"
if "!CLONE_PREV_CHOICE!"=="0" goto :menu_dinhdang
if "!CLONE_PREV_CHOICE!"=="" goto :menu_dinhdang
set "CLONE_PREV_FILE="
for /L %%i in (1,1,!IDX!) do (
    if "!CLONE_PREV_CHOICE!"=="%%i" set "CLONE_PREV_FILE=!FILE%%i!"
)
if "!CLONE_PREV_FILE!"=="" set "CLONE_PREV_FILE=!CLONE_PREV_CHOICE!"
goto :clone_preview_have_file

:clone_preview_nofile
echo   %C_RED%(khong co file mau trong thu muc mau\)%C_RST%
echo   %C_YLW%Nhap duong dan file mau:%C_RST%
set /p "CLONE_PREV_FILE=  %C_CYA%^> %C_RST%"
if "!CLONE_PREV_FILE!"=="" goto :menu_dinhdang

:clone_preview_have_file
if not exist "!CLONE_PREV_FILE!" (
    echo.
    echo   %C_RED%[LOI]%C_RST% Khong tim thay file mau: !CLONE_PREV_FILE!
    pause
    goto :menu_dinhdang
)
echo.
echo   %C_YLW%File can dinh dang:%C_RST% %C_GRY%(0 = quay lai)%C_RST%
set /p "CLONE_PREV_TARGET=  %C_CYA%^> %C_RST%"
if "!CLONE_PREV_TARGET!"=="0" goto :menu_dinhdang
if "!CLONE_PREV_TARGET!"=="" (
    echo   %C_RED%[LOI]%C_RST% Vui long nhap file can dinh dang.
    pause
    goto :menu_dinhdang
)
if not exist "!CLONE_PREV_TARGET!" (
    echo.
    echo   %C_RED%[LOI]%C_RST% Khong tim thay file: !CLONE_PREV_TARGET!
    pause
    goto :menu_dinhdang
)
echo.
echo   %C_YLW%File dau ra (Enter = outputs\cloned.docx):%C_RST%
set /p "CLONE_PREV_OUT=  %C_CYA%^> %C_RST%"
if "!CLONE_PREV_OUT!"=="" set "CLONE_PREV_OUT=outputs\cloned.docx"
echo.
echo   %C_GRY%Template:%C_RST% %C_WHT%!CLONE_PREV_FILE!%C_RST%
echo   %C_GRY%Target:  %C_RST% %C_WHT%!CLONE_PREV_TARGET!%C_RST%
echo   %C_GRY%Output:  %C_RST% %C_WHT%!CLONE_PREV_OUT!%C_RST%
echo.
echo   %C_YLW%Dang mo Word de xem truoc...%C_RST%
echo.
python src\main.py clone-preview "!CLONE_PREV_FILE!" "!CLONE_PREV_TARGET!" -o "!CLONE_PREV_OUT!"
if !errorlevel! equ 0 (
    echo.
    echo   %C_GRN%[OK]%C_RST% Da hoan thanh preview.
) else (
    echo.
    echo   %C_RED%[LOI]%C_RST% Preview that bai. Vui long kiem tra:
    echo   %C_RED%-%C_RST% File mau co dinh dang Word dung khong?
    echo   %C_RED%-%C_RST% Microsoft Word da cai dat chua?
    echo   %C_RED%-%C_RST% File co dang mo trong Word khong?
)
echo.
pause
goto :menu_dinhdang

:: --- LIST RULES ---
:listrules
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    DANH SACH RULES CO SAN               %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
python src\cli\rule_viewer.py
echo.
pause
goto :menu_tienich

:: --- TESTS ---
:runtests
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    CHAY UNIT TESTS                       %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
python -m pytest tests\ -v --no-header --override-ini="addopts="
echo.
pause
goto :menu_tienich

:: --- WORD COUNT ---
:wordcount
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    DEM SO TU VA TRANG                     %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
python src\cli\counter_cli.py
echo.
pause
goto :menu_tienich

:: --- TRANSLATE ---
:translate
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    DICH THUAT FILE WORD                    %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
python src\cli\translator_cli.py
echo.
pause
goto :menu_tienich

:: --- TAO VAN BAN BANG AI ---
:docgenerate
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    TAO VAN BAN BANG AI                     %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
python src\cli\doc_generator_cli.py
echo.
pause
goto :menu_tienich

:: ===================================================================
:: SUBMENU 5 - CAI DAT
:: ===================================================================
:menu_caidat
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    CAI DAT                                %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo Chon chuc nang:
echo.
echo %C_YLW%  1.%C_RST% Quan ly AI Provider
echo %C_GRY%     (API key, models, custom API, kiem tra)%C_RST%
echo.
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Nhap so (0-1): %C_RST%"

if "%SUB%"=="1" goto :aisettings
if "%SUB%"=="0" goto :menu

goto :menu_caidat

:: --- AI SETTINGS ---
:aisettings
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    CAI DAT AI PROVIDER                     %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
python src\cli\settings_cli.py
echo.
pause
goto :menu_caidat

:: ===================================================================
:: ABOUT / THONG TIN UNG DUNG
:: ===================================================================
:about
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     THONG TIN UNG DUNG                   %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo Chon de xem chi tiet:
echo.
echo %C_GRY%--------------------------------------------%C_RST%
echo %C_YLW%  1.%C_RST% Gioi thieu chung
echo %C_YLW%  2.%C_RST% Chuc nang: Hoc formatting tu file mau
echo %C_YLW%  3.%C_RST% Chuc nang: Tao rule thu cong
echo %C_YLW%  4.%C_RST% Chuc nang: Cau hinh SmartHeading
echo %C_YLW%  5.%C_RST% Chuc nang: Xem truoc va Dinh dang
echo %C_YLW%  6.%C_RST% Chuc nang: Clone dinh dang
echo %C_YLW%  7.%C_RST% Chuc nang: Tien ich
echo %C_YLW%  8.%C_RST% Thong tin tac gia
echo %C_RED%  0.%C_RST% Quay lai
echo %C_GRY%--------------------------------------------%C_RST%
echo.
set /p SUB="%C_YLW%Nhap so (0-8): %C_RST%"

if "%SUB%"=="1" goto :about_gioithieu
if "%SUB%"=="2" goto :about_learn
if "%SUB%"=="3" goto :about_makerule
if "%SUB%"=="4" goto :about_smart
if "%SUB%"=="5" goto :about_format
if "%SUB%"=="6" goto :about_clone
if "%SUB%"=="7" goto :about_tienich
if "%SUB%"=="8" goto :about_tacgia
if "%SUB%"=="0" goto :menu
goto :about

:about_gioithieu
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     GIOI THIEU CHUNG                     %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_YLW%  Ten ung dung:%C_RST% Auto-Format for Word
echo %C_YLW%  Phien ban:%C_RST% 1.0
echo %C_YLW%  Cong nghe:%C_RST% Python, python-docx, win32com
echo.
echo  %C_WHT%Ung dung giup nguoi dung dinh dang nhanh%C_RST%
echo  %C_WHT%van ban Word (.doc/.docx) theo chuan mong muon%C_RST%
echo  %C_WHT%ma khong can thao tac thu cong tung paragraph.%C_RST%
echo.
echo %C_CYA%  Van de giai quyet:%C_RST%
echo  %C_GRY%-%C_RST% Mat nhieu thoi gian format thu cong
echo  %C_GRY%-%C_RST% Khong dong nhat font, size, spacing
echo  %C_GRY%-%C_RST% Tieu de khong dung Heading style
echo  %C_GRY%-%C_RST% Can ap dung dinh dang giong file mau
echo.
echo %C_CYA%  Giai phap:%C_RST%
echo  %C_GRY%-%C_RST% Hoc dinh dang tu file mau co san
echo  %C_GRY%-%C_RST% Phat hien tieu de thong minh bang noi dung
echo  %C_GRY%-%C_RST% Clone toan bo dinh dang (section, header, TOC...)
echo  %C_GRY%-%C_RST% Ho tro ca .doc va .docx
echo.
pause
goto :about

:about_learn
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     HOC FORMATTING TU FILE MAU           %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Phan tich file Word da format chuan,
echo  tu dong tao file rule YAML de ap dung lai.
echo.
echo %C_YLW%  Loi ich:%C_RST%
echo  %C_GRY%-%C_RST% Khong can nho thong so font/size/spacing
echo  %C_GRY%-%C_RST% Chi can 1 file mau la co the ap dung cho nhieu file
echo  %C_GRY%-%C_RST% Rule tao ra co the chinh sua thu cong sau do
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 1 - Hoc va Cau hinh -^> Chon 1
echo  %C_GRY%2.%C_RST% Nhap duong dan file mau (.doc hoac .docx)
echo  %C_GRY%3.%C_RST% Dat ten file rule (Enter = learned_rules)
echo  %C_GRY%4.%C_RST% Ket qua: %C_WHT%rules/ten_rule.yaml%C_RST%
echo.
echo %C_YLW%  Luu y:%C_RST%
echo  %C_GRY%-%C_RST% File mau cang chuan, rule cang tot
echo  %C_GRY%-%C_RST% Sau khi hoc, dung Preview de kiem tra
echo.
pause
goto :about

:about_makerule
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     TAO RULE THU CONG                    %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Tu dong tao file rule bang cach nhap thong so
echo  dinh dang cho tung style.
echo.
echo %C_YLW%  Loi ich:%C_RST%
echo  %C_GRY%-%C_RST% Kiem soat hoan toan thong so dinh dang
echo  %C_GRY%-%C_RST% Khong can file mau
echo  %C_GRY%-%C_RST% Khong can viet YAML thu cong
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 1 - Hoc va Cau hinh -^> Chon 2
echo  %C_GRY%2.%C_RST% Nhap gia tri cho tung muc
echo  %C_GRY%3.%C_RST% De trong = bo qua
echo.
echo %C_YLW%  Thong so co the nhap:%C_RST%
echo  %C_GRY%-%C_RST% Font: Ten, co chu, dam, nghieng, mau
echo  %C_GRY%-%C_RST% Spacing: Khoang cach dong, truoc, sau
echo  %C_GRY%-%C_RST% Alignment: Can le (trai, phai, giua, deu)
echo  %C_GRY%-%C_RST% First line indent: Thut dau dong
echo.
pause
goto :about

:about_smart
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     CAU HINH SMARTHEADING PATTERNS       %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Them pattern %C_GRN%(regex)%C_RST% de tu dong phat hien
echo  tieu de duoc format thu cong va gan style.
echo.
echo %C_YLW%  Vi du:%C_RST%
echo  "Chuong 1: Gioi thieu" %C_GRY%(%C_RST%dang Normal%C_GRY%)%C_RST%
echo  -^> Phat hien nho pattern: %C_GRN%Chuong \\d+%C_RST%
echo  -^> Tu dong gan style: %C_YLW%Heading 1%C_RST%
echo.
echo %C_YLW%  Loi ich:%C_RST%
echo  %C_GRY%-%C_RST% Tu dong chuan hoa tieu de toan bo file
echo  %C_GRY%-%C_RST% Giu dung thu tu heading level
echo  %C_GRY%-%C_RST% Khong can format lai thu cong
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 1 - Hoc va Cau hinh -^> Chon 3
echo  %C_GRY%2.%C_RST% Chon "Them pattern" -^> nhap regex + style
echo  %C_GRY%3.%C_RST% Save -^> dung Format de ap dung
echo.
echo %C_YLW%  Priority (uu tien):%C_RST%
echo  %C_GRY%1.%C_RST% Pattern nguoi dung nhap %C_GRN%(cao nhat)%C_RST%
echo  %C_GRY%2.%C_RST% Built-in: Chuong, Phan, 1.1, 1.1.1...
echo  %C_GRY%3.%C_RST% Built-in: Title, Subtitle
echo.
pause
goto :about

:about_format
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     XEM TRUOC VA DINH DANG              %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_CYA%  --- Preview (Xem truoc) ---%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Xem thay doi se duoc ap dung ma khong ghi file.
echo.
echo %C_YLW%  Loi ich:%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra truoc, dam bao dung y
echo  %C_GRY%-%C_RST% Phat hien loi som, tranh hong file
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 2 - Dinh dang va Clone -^> Chon 1
echo  %C_GRY%2.%C_RST% Nhap file Word can kiem tra
echo  %C_GRY%3.%C_RST% Xem danh sach thay doi
echo.
echo %C_CYA%  --- Dinh dang (Format) ---%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Ap dung rule len file Word, tu dong chuan hoa
echo  font, size, spacing, alignment, heading style.
echo.
echo %C_YLW%  Loi ich:%C_RST%
echo  %C_GRY%-%C_RST% Format hang loat, nhanh chong
echo  %C_GRY%-%C_RST% Dong nhat toan bo file
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 2 -^> Chon 2 (tuy chon) hoac 3 (mac dinh)
echo  %C_GRY%2.%C_RST% Nhap file Word
echo  %C_GRY%3.%C_RST% Chon file rule + ten file dau ra
echo  %C_GRY%4.%C_RST% Kiem tra ket qua
echo.
pause
goto :about

:about_clone
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     CLONE DINH DANG                      %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Sao chep toan bo dinh dang tu file mau sang
echo  file can dinh dang.
echo.
echo %C_YLW%  Cac thanh phan duoc clone:%C_RST%
echo  %C_GRY%-%C_RST% Section, Page setup (le, huong giay)
echo  %C_GRY%-%C_RST% Header, Footer, Watermark
echo  %C_GRY%-%C_RST% Table of Contents (TOC), Columns
echo  %C_GRY%-%C_RST% Style dinh nghia trong file
echo.
echo %C_YLW%  Loi ich:%C_RST%
echo  %C_GRY%-%C_RST% Giu nguyen bo cuc nhu file mau
echo  %C_GRY%-%C_RST% Xu ly duoc dinh dang dac biet
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 2 - Dinh dang va Clone -^> Chon 4
echo  %C_GRY%2.%C_RST% Nhap file mau (da format chuan)
echo  %C_GRY%3.%C_RST% Nhap file can dinh dang
echo  %C_GRY%4.%C_RST% Nhap ten file dau ra
echo.
echo %C_YLW%  Luu y:%C_RST%
echo  %C_GRY%-%C_RST% Can cai Microsoft Word
echo  %C_GRY%-%C_RST% Khong dong Word trong qua trinh clone
echo  %C_GRY%-%C_RST% File mau duoc giu nguyen
echo.
pause
goto :about

:about_tienich
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     TIEN ICH                              %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_CYA%  --- Danh sach rules co san ---%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Xem tat ca file rule trong thu muc rules/.
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 3 - Tien ich -^> Chon 1
echo.
echo %C_CYA%  --- Chay unit tests ---%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Kiem tra tinh dung dan cua chuong trinh.
echo.
echo %C_YLW%  Loi ich:%C_RST%
echo  %C_GRY%-%C_RST% Dam bao code hoat dong dung
echo  %C_GRY%-%C_RST% Phat hien loi sau khi cap nhat
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 3 - Tien ich -^> Chon 2
echo  %C_GRY%2.%C_RST% Xem ket qua: PASSED hoac FAILED
echo.
pause
goto :about

:about_tacgia
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     THONG TIN TAC GIA                    %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo  %C_YLW%Tac gia:%C_RST% Le Huynh Ngoc
echo.
echo  %C_YLW%Nam phat trien:%C_RST% 2026
echo.
echo  Ung dung duoc phat trien nham giup nguoi
echo  dung dinh dang van ban Word mot cach nhanh
echo  chong va chuan xac.
echo.
echo  %C_GRY%Lien he: (cap nhat sau)%C_RST%
echo.
pause
goto :about
