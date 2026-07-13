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
echo %C_RED%  6.%C_RST% Reset du an
echo %C_GRY%     (Xoa API keys, rules hoc, file dau ra)%C_RST%
echo.
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Nhap so (0-6): %C_RST%"

if "%SUB%"=="1" goto :listrules
if "%SUB%"=="2" goto :runtests
if "%SUB%"=="3" goto :wordcount
if "%SUB%"=="4" goto :translate
if "%SUB%"=="5" goto :docgenerate
if "%SUB%"=="6" goto :resetproject
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

:: --- KHOI TAO DU AN ---
:initproject
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    KHOI TAO DU AN                          %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
python src/main.py init
echo.
pause
goto :menu_caidat

:: --- RESET DU AN ---
:resetproject
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    RESET DU AN                             %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_RED%  Canh bao: Se xoa API keys, rules hoc, file dau ra!%C_RST%
echo %C_GRY%  Rules mac dinh (default.yaml, academic.yaml) se duoc giu nguyen.%C_RST%
echo.
set /p CONFIRM="%C_YLW%Nhap 'y' de xac nhan reset: %C_RST%"
if /I not "%CONFIRM%"=="y" goto :menu_tienich
echo.
python src/main.py reset
echo.
pause
goto :menu_tienich

:: --- RESET DU AN (tu Cai dat) ---
:resetcaidat
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%    RESET DU AN                             %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_RED%  Canh bao: Se xoa API keys, rules hoc, file dau ra!%C_RST%
echo %C_GRY%  Rules mac dinh (default.yaml, academic.yaml) se duoc giu nguyen.%C_RST%
echo.
set /p CONFIRM="%C_YLW%Nhap 'y' de xac nhan reset: %C_RST%"
if /I not "%CONFIRM%"=="y" goto :menu_caidat
echo.
python src/main.py reset
echo.
pause
goto :menu_caidat

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
echo %C_YLW%  2.%C_RST% Khoi tao du an
echo %C_GRY%     (Tao thu muc, copy config mac dinh)%C_RST%
echo.
echo %C_RED%  3.%C_RST% Reset du an
echo %C_GRY%     (Xoa API keys, rules hoc, file dau ra)%C_RST%
echo.
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Nhap so (0-3): %C_RST%"

if "%SUB%"=="1" goto :aisettings
if "%SUB%"=="2" goto :initproject
if "%SUB%"=="3" goto :resetcaidat
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
call menus\about\about.bat
goto :menu
