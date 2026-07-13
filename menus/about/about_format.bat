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
echo %C_CYA%%C_BLD%         5. XEM TRUOC (PREVIEW) VA DINH DANG (FORMAT)  %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan
echo %C_YLW%  2.%C_RST% Preview (xem truoc)
echo %C_YLW%  3.%C_RST% Format (dinh dang that)
echo %C_YLW%  4.%C_RST% Cau truc rule YAML
echo %C_YLW%  5.%C_RST% Formatters (5 bo xu ly)
echo %C_YLW%  6.%C_RST% Ket hop nhieu rule
echo %C_YLW%  7.%C_RST% Vi du cu the
echo %C_YLW%  8.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto :tongquan
if "%SUB%"=="2" goto :preview
if "%SUB%"=="3" goto :format
if "%SUB%"=="4" goto :rulestruct
if "%SUB%"=="5" goto :formatters
if "%SUB%"=="6" goto :nhieuru
if "%SUB%"=="7" goto :vidu
if "%SUB%"=="8" goto :loixuly
if "%SUB%"=="0" exit /b
goto :menu

:tongquan
cls
echo.
echo %C_CYA%--- TONG QUAN ---%C_RST%
echo.
echo  %C_WHT%FormatEngine%C_RST% doc file Word, ap dung danh sach rules,
echo  va ghi file dau ra voi dinh dang moi.
echo.
echo  %C_CYA%2 che do:%C_RST%
echo  %C_YLW%  Preview (dry-run):%C_RST%  Xem thay doi, khong ghi file
echo  %C_YLW%  Format (that):%C_RST%     Ghi file dau ra moi
echo.
echo  %C_CYA%Parser:%C_RST%
echo  %C_GRY%  .docx  -> python-docx (nhanh, khong can Word)%C_RST%
echo  %C_GRY%  .doc   -> win32com (can Microsoft Word)%C_RST%
echo.
echo  %C_CYA%Luong xu ly:%C_RST%
echo  %C_GRY%1.%C_RST% Doc file -> ParsedDocument (paragraphs + runs)
echo  %C_GRY%2.%C_RST% SmartHeading: phat hieu + gan style moi
echo  %C_GRY%3.%C_RST% FontFormatter: ap dung font/size/bold/color
echo  %C_GRY%4.%C_RST% SpacingFormatter: line spacing + space before/after
echo  %C_GRY%5.%C_RST% AlignmentFormatter: can le trai/giua/phai/justify
echo  %C_GRY%6.%C_RST% HeadingFormatter: dat heading level
echo  %C_GRY%7.%C_RST% Luu file dau ra (neu khong phai dry-run)
echo.
echo  %C_CYA%Thong bao thay doi:%C_RST%  ChangeReporter hien thi
echo  so luong thay doi moi formatter.
echo.
pause
goto :menu

:preview
cls
echo.
echo %C_CYA%--- PREVIEW (XEM TRUOC) ---%C_RST%
echo.
echo  Xem truoc ket qua dinh dang ma khong ghi file goc.
echo.
echo %C_CYA%  CLI:%C_RST%
echo  %C_WHT%python src/main.py preview "file.docx" -r rules/default.yaml%C_RST%
echo.
echo %C_CYA%  Menu:%C_RST%
echo  %C_GRY%1.%C_RST% Chay %C_WHT%run.bat%C_RST%
echo  %C_GRY%2.%C_RST% Menu 2 -> Chon 1 - Xem truoc
echo  %C_GRY%3.%C_RST% Nhap file + chon rule
echo.
echo %C_CYA%  Tham so:%C_RST%
echo  %C_YLW%input%C_RST%          File .doc/.docx can xem
echo  %C_YLW%-r, --rules%C_RST%   File rule YAML (da tach dau phay)
echo.
echo %C_CYA%  Ket qua:%C_RST%
echo  File duoc tao trong thu muc outputs/ voi ten %C_WHT%preview_*.docx%C_RST%
echo  Hoac hien thi thong bao thay doi ma khong tao file.
echo.
echo %C_CYA%  Luu y:%C_RST%
echo  %C_GRY%-%C_RST% Preview = "python src/main.py format --dry-run"
echo  %C_GRY%-%C_RST% Khong anh huong den file goc
echo  %C_GRY%-%C_RST% Co the dung nhieu lan de kiem tra
echo.
pause
goto :menu

:format
cls
echo.
echo %C_CYA%--- FORMAT (DINH DANG THAT) ---%C_RST%
echo.
echo  Dinh dang file Word va ghi file dau ra moi.
echo.
echo %C_CYA%  CLI:%C_RST%
echo  %C_WHT%python src/main.py format "input.docx" -o "output.docx" -r rules/default.yaml%C_RST%
echo.
echo %C_CYA%  Menu:%C_RST%
echo  %C_GRY%2.%C_RST% Format (chon rule)
echo  %C_GRY%3.%C_RST% Format mac dinh (default.yaml + smart_patterns.yaml)
echo.
echo %C_CYA%  Tham so:%C_RST%
echo  %C_YLW%input%C_RST%          File dau vao (.doc/.docx)
echo  %C_YLW%-o, --output%C_RST%  File dau ra (mac dinh: outputs/formatted_*.docx)
echo  %C_YLW%-r, --rules%C_RST%   Rule YAML (mac dinh: default.yaml + smart_patterns.yaml)
echo.
echo %C_CYA%  Rule mac dinh khi khong chi dinh -r:%C_RST%
echo  %C_GRY%1.%C_RST% smart_patterns.yaml (neu co)
echo  %C_GRY%2.%C_RST% default.yaml
echo.
echo %C_CYA%  Luu y:%C_RST%
echo  %C_GRY%-%C_RST% File goc KHONG bi thay doi
echo  %C_GRY%-%C_RST% File dau ra duoc tao moi
echo  %C_GRY%-%C_RST% Luon dung preview truoc khi format that
echo.
pause
goto :menu

:rulestruct
cls
echo.
echo %C_CYA%--- CAU TRUC RULE YAML ---%C_RST%
echo.
echo  %C_CYA%Cau truc co ban:%C_RST%
echo  %C_GRY%rules:%C_RST%
echo  %C_GRY%  - name: "Ten rule"%C_RST%
echo  %C_GRY%    target: paragraph%C_RST%
echo  %C_GRY%    conditions:%C_RST%
echo  %C_GRY%      style: "Normal"       %C_GRY%(theo style)%C_RST%
echo  %C_GRY%      pattern: "regex"      %C_GRY%(theo noi dung)%C_RST%
echo  %C_GRY%      text_contains: "text"  %C_GRY%(chua chuoi)%C_RST%
echo  %C_GRY%    actions:%C_RST%
echo  %C_GRY%      font:%C_RST%
echo  %C_GRY%        name: "Times New Roman"%C_RST%
echo  %C_GRY%        size: 13%C_RST%
echo  %C_GRY%        bold: true%C_RST%
echo  %C_GRY%        italic: false%C_RST%
echo  %C_GRY%        color: "000000"%C_RST%
echo  %C_GRY%      paragraph:%C_RST%
echo  %C_GRY%        alignment: "justify"%C_RST%
echo  %C_GRY%        line_spacing: 1.5%C_RST%
echo  %C_GRY%        space_before: 6%C_RST%
echo  %C_GRY%        space_after: 6%C_RST%
echo  %C_GRY%        first_line_indent: 1.27%C_RST%
echo  %C_GRY%      heading:%C_RST%
echo  %C_GRY%        level: 1%C_RST%
echo.
echo  %C_CYA%Conditions (3 loai):%C_RST%
echo  %C_YLW%  style:%C_RST%      Phu hop style name cua Word
echo  %C_YLW%  pattern:%C_RST%     Regex matching noi dung doan
echo  %C_YLW%  text_contains:%C_RST% Chua chuoi cu the
echo.
echo  %C_CYA%Actions (3 nhom):%C_RST%
echo  %C_YLW%  font:%C_RST%        name, size, bold, italic, color
echo  %C_YLW%  paragraph:%C_RST%   alignment, line_spacing, space_*, indent
echo  %C_YLW%  heading:%C_RST%     level (1-9) hoac style ("Title")
echo.
pause
goto :menu

:formatters
cls
echo.
echo %C_CYA%--- 5 FORMATTERS (BO XU LY) ---%C_RST%
echo.
echo %C_YLW%  1. SmartHeadingFormatter (chay dau tien)%C_RST%
echo  %C_GRY%Phat hieu tieu de tu noi dung bang regex.%C_RST%
echo  %C_GRY%Dung custom patterns tu rules/smart_patterns.yaml%C_RST%
echo  %C_GRY%va built-in patterns (Chuong, so.dinh.dang...).%C_RST%
echo.
echo %C_YLW%  2. FontFormatter%C_RST%
echo  %C_GRY%Ap dung font name, size, bold, italic, color.%C_RST%
echo  %C_GRY%Chi ap dung khi rule co actions.font.%C_RST%
echo.
echo %C_YLW%  3. SpacingFormatter%C_RST%
echo  %C_GRY%Dat line spacing (1.0, 1.5, 2.0).%C_RST%
echo  %C_GRY%Dat space before/after (pt).%C_RST%
echo  %C_GRY%Dat first_line_indent (cm).%C_RST%
echo.
echo %C_YLW%  4. AlignmentFormatter%C_RST%
echo  %C_GRY%Can le: left, center, right, justify.%C_RST%
echo.
echo %C_YLW%  5. HeadingFormatter (chay cuoi)%C_RST%
echo  %C_GRY%Dat heading level (1-9) hoac style (Title).%C_RST%
echo  %C_GRY%Dung python-docx heading properties.%C_RST%
echo.
echo  %C_CYA%Thu tu:%C_RST%  Smart -> Font -> Spacing -> Alignment -> Heading
echo  %C_GRY%Moi formatter chi xu ly cac rule co actions tuong ung.%C_RST%
echo.
pause
goto :menu

:nhieuru
cls
echo.
echo %C_CYA%--- KET HOP NHIEU RULE ---%C_RST%
echo.
echo  Co the ket hop nhieu file rule de tong hop dinh dang.
echo.
echo %C_CYA%  Cach dung:%C_RST%
echo  %C_WHT%-r "rules/mau1.yaml,rules/mau2.yaml,rules/custom.yaml"%C_RST%
echo.
echo %C_CYA%  Vi du:%C_RST%
echo  %C_GRY% 1.%C_RST% smart_patterns.yaml  - Phat hieu tieu de
echo  %C_GRY% 2.%C_RST% default.yaml         - Dinh dang co ban
echo  %C_GRY% 3.%C_RST% custom_rules.yaml    - Style tuy y
echo.
echo  %C_CYA%Thu tu xu ly:%C_RST%
echo  %C_GRY%-%C_RST% Rule truoc duoc uu tien neu trung dieu kien
echo  %C_GRY%-%C_RST% Tat ca rule duoc ap dung theo thu tu trong file
echo  %C_GRY%-%C_RST% Rule tu nhieu file duoc gop vao danh sach chung
echo.
pause
goto :menu

:vidu
cls
echo.
echo %C_CYA%--- VI DU CU THE ---%C_RST%
echo.
echo %C_CYA%  Vi du 1: Format don gian%C_RST%
echo  %C_WHT%python src/main.py format "baocao.docx" -r rules/default.yaml%C_RST%
echo  %C_GRY%-> Ap dung default: TNR 13, justify, 1.5, Heading 14 bold...%C_RST%
echo.
echo %C_CYA%  Vi du 2: Preview truoc%C_RST%
echo  %C_WHT%python src/main.py preview "baocao.docx" -r rules/default.yaml%C_RST%
echo  %C_GRY%-> Xem thay doi, khong ghi file%RST%
echo.
echo %C_CYA%  Vi du 3: Format voi SmartHeading%C_RST%
echo  %C_WHT%python src/main.py format "baocao.docx" -r "rules/smart_patterns.yaml,rules/default.yaml"%C_RST%
echo  %C_GRY%-> Phat hieu "Chuong 1" -> Heading 1, roi format font/spacing%RST%
echo.
echo %C_CYA%  Vi du 4: Format mac dinh (Menu 2 -> Chon 3)%C_RST%
echo  %C_GRY%-> Tu dong dung default.yaml + smart_patterns.yaml%RST%
echo  %C_GRY%-> Khong can nhap rule thu cong%RST%
echo.
pause
goto :menu

:loixuly
cls
echo.
echo %C_CYA%--- XU LY LOI ---%C_RST%
echo.
echo %C_RED%  Loi: "No rules matched"%C_RST%
echo  %C_GRY%-%C_RST% Rule conditions khong match style nao trong file
echo  %C_GRY%-%C_RST% Kiem tra ten style dung chua (phan biet hoa/thuong)
echo.
echo %C_RED%  Loi: "File format not supported"%C_RST%
echo  %C_GRY%-%C_RST% Chi ho tro .doc va .docx
echo  %C_GRY%-%C_RST% .doc can Microsoft Word da cai
echo.
echo %C_RED%  Loi: "Output directory not found"%C_RST%
echo  %C_GRY%-%C_RST% Thu muc outputs/ chua duoc tao
echo  %C_GRY%-%C_RST% Chay: %C_WHT%python src/main.py init%C_RST%
echo.
echo %C_RED%  Loi: python-docx khong doc duoc file%C_RST%
echo  %C_GRY%-%C_RST% File bi loi hoac khong phai .docx
echo  %C_GRY%-%C_RST% Thu mo bang Word de kiem tra
echo.
pause
goto :menu
