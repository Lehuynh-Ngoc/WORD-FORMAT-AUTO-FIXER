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

:about
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     THONG TIN UNG DUNG                   %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo Chon de xem chi tiet:
echo.
echo %C_GRY%--- CO SO ---%C_RST%
echo %C_YLW%  1.%C_RST% Gioi thieu chung
echo %C_YLW%  2.%C_RST% Hoc formatting tu file mau
echo %C_YLW%  3.%C_RST% Tao rule thu cong
echo %C_YLW%  4.%C_RST% Cau hinh SmartHeading
echo %C_YLW%  5.%C_RST% Xem truoc va Dinh dang
echo %C_YLW%  6.%C_RST% Clone dinh dang
echo %C_GRY%--- AI ---%C_RST%
echo %C_YLW%  7.%C_RST% AI Provider (API key, models)
echo %C_YLW%  8.%C_RST% Dich thuat file Word
echo %C_YLW%  9.%C_RST% Tao van ban bang AI
echo %C_GRY%--- Tien ich ---%C_RST%
echo %C_YLW% 10.%C_RST% Dem tu va trang
echo %C_YLW% 11.%C_RST% Khoi tao / Reset du an
echo %C_YLW% 12.%C_RST% Thong tin tac gia
echo %C_RED%  0.%C_RST% Quay lai
echo %C_GRY%--------------------------------------------%C_RST%
echo.
set /p SUB="%C_YLW%Nhap so (0-12): %C_RST%"

if "%SUB%"=="1" goto :about_gioithieu
if "%SUB%"=="2" goto :about_learn
if "%SUB%"=="3" goto :about_makerule
if "%SUB%"=="4" goto :about_smart
if "%SUB%"=="5" goto :about_format
if "%SUB%"=="6" goto :about_clone
if "%SUB%"=="7" goto :about_ai
if "%SUB%"=="8" goto :about_translate
if "%SUB%"=="9" goto :about_generate
if "%SUB%"=="10" goto :about_count
if "%SUB%"=="11" goto :about_initreset
if "%SUB%"=="12" goto :about_tacgia
if "%SUB%"=="0" exit /b
goto :about

:about_gioithieu
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     GIOI THIEU CHUNG                     %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_YLW%  Ten ung dung:%C_RST% Word Format Auto-Fixer (wordfix)
echo %C_YLW%  Phien ban:%C_RST% 2.0
echo %C_YLW%  Cong nghe:%C_RST% Python, python-docx, win32com, AI API
echo.
echo  %C_WHT%Ung dung giup nguoi dung dinh dang, dich thuat,%C_RST%
echo  %C_WHT%va tao van ban Word (.doc/.docx) toan dien,%C_RST%
echo  %C_WHT%ho tro AI va nhieu provider.%C_RST%
echo.
echo %C_CYA%  Chuc nang chinh:%C_RST%
echo  %C_GRY%-%C_RST% Dinh dang theo rule YAML (font, spacing, heading...)
echo  %C_GRY%-%C_RST% SmartHeading: phat hien tieu de tu noi dung
echo  %C_GRY%-%C_RST% Clone toan bo dinh dang tu file mau
echo  %C_GRY%-%C_RST% Clone-preview: xem truoc truoc khi luu
echo  %C_GRY%-%C_RST% Dem tu, ky tu, dong, trang, thoi gian doc
echo  %C_GRY%-%C_RST% Dich file Word sang 19 ngon ngu bang AI
echo  %C_GRY%-%C_RST% Tao van ban Word bang AI (19 loai van ban)
echo  %C_GRY%-%C_RST% Quan ly nhieu AI provider + model
echo  %C_GRY%-%C_RST% Khoi tao / Reset du an
echo.
echo %C_CYA%  12 subcommands:%C_RST%
echo  %C_GRY%format, preview, learn, clone, clone-preview,%C_RST%
echo  %C_GRY%list-rules, count, translate, settings, generate,%C_RST%
echo  %C_GRY%init, reset%C_RST%
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

:about_ai
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     AI PROVIDER (API KEY, MODELS)        %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Quan ly API key va model cho cac AI provider.
echo.
echo %C_YLW%  Provider ho tro:%C_RST%
echo  %C_GRY%-%C_RST% OpenAI (GPT-4o, GPT-4o-mini, GPT-4-turbo...)
echo  %C_GRY%-%C_RST% Google Gemini (2.5-flash, 2.0-flash, 1.5-pro...)
echo  %C_GRY%-%C_RST% Anthropic Claude (Sonnet 4, 3.5 Sonnet, 3.5 Haiku...)
echo  %C_GRY%-%C_RST% DeepSeek (deepseek-chat, deepseek-reasoner)
echo  %C_GRY%-%C_RST% Custom API (tu nhap URL + key)
echo.
echo %C_YLW%  Chuc nang:%C_RST%
echo  %C_GRY%-%C_RST% Multi-model moi provider
echo  %C_GRY%-%C_RST% Chon model hoat dong
echo  %C_GRY%-%C_RST% Kiem tra API key live (hop le/sai/het credit)
echo  %C_GRY%-%C_RST% Them/sua/xoa custom API
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 4 - Cai dat -^> Chon 1
echo  %C_GRY%2.%C_RST% Chon provider can cai dat
echo  %C_GRY%3.%C_RST% Nhap API key, chon model
echo.
pause
goto :about

:about_translate
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     DICH THUAT FILE WORD                  %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Dich toan bo noi dung file Word sang ngon ngu khac
echo  bang AI, giu nguyen format (font, bold, heading...).
echo.
echo %C_YLW%  Ngon ngu ho tro:%C_RST%
echo  %C_GRY%vi, en, zh, ja, ko, fr, de, es, it, pt,%C_RST%
echo  %C_GRY%ru, th, id, ms, ar, hi, tr, pl, nl%C_RST%
echo  %C_GRY%(19 ngon ngu)%C_RST%
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 3 - Tien ich -^> Chon 4
echo  %C_GRY%2.%C_RST% Nhap file Word can dich
echo  %C_GRY%3.%C_RST% Chon ngon ngu dich (VD: en, zh, ja)
echo  %C_GRY%4.%C_RST% Chon AI provider
echo  %C_GRY%5.%C_RST% Xem truoc va luu file dich
echo.
echo %C_YLW%  Luu y:%C_RST%
echo  %C_GRY%-%C_RST% Can API key hop le (xem muc 7)
echo  %C_GRY%-%C_RST% Batch 3000 ky tu/chunk, giu format goc
echo.
pause
goto :about

:about_generate
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     TAO VAN BAN BANG AI                   %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  AI hoi cau hoi de thu thap thong tin,
echo  sau do tao van ban Word voi format chuan.
echo.
echo %C_YLW%  19 loai van ban:%C_RST%
echo  %C_GRY%Don xin viec, don xin nghi phep, bao cao thuc tap,%C_RST%
echo  %C_GRY%luan van tot nghiep, thu cam on, quyet dinh...%C_RST%
echo.
echo %C_YLW%  Quy trinh:%C_RST%
echo  %C_GRY%1.%C_RST% Nhap loai van ban
echo  %C_GRY%2.%C_RST% AI dat 5-10 cau hoi
echo  %C_GRY%3.%C_RST% Ban tra loi tung cau hoi
echo  %C_GRY%4.%C_RST% AI tao noi dung + format
echo  %C_GRY%5.%C_RST% Luu thanh .docx
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 3 - Tien ich -^> Chon 5
echo  %C_GRY%2.%C_RST% Nhap loai van ban
echo  %C_GRY%3.%C_RST% Tra loi cac cau hoi
echo  %C_GRY%4.%C_RST% Xem truoc va luu
echo.
pause
goto :about

:about_count
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     DEM TU VA TRANG                       %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Dem chi tiet cac thong so cua file Word.
echo.
echo %C_YLW%  Thong so dem duoc:%C_RST%
echo  %C_GRY%-%C_RST% So doan van (paragraphs)
echo  %C_GRY%-%C_RST% So dong (lines)
echo  %C_GRY%-%C_RST% So tu (words)
echo  %C_GRY%-%C_RST% Ky tu co/khong dau cach
echo  %C_GRY%-%C_RST% So trang (thuc te qua Word COM)
echo  %C_GRY%-%C_RST% Thoi gian doc (tieng Viet/Tieng Anh)
echo  %C_GRY%-%C_RST% Ngon ngu phat hien
echo  %C_GRY%-%C_RST% Cau truc headings
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 3 - Tien ich -^> Chon 3
echo  %C_GRY%2.%C_RST% Nhap file Word
echo  %C_GRY%3.%C_RST% Xem ket qua chi tiet
echo.
pause
goto :about

:about_initreset
cls
echo.
echo %C_CYA%============================================%C_RST%
echo %C_CYA%%C_BLD%     KHOI TAO / RESET DU AN                %C_RST%
echo %C_CYA%============================================%C_RST%
echo.
echo %C_CYA%  --- Khoi tao (init) ---%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Tao thu muc va file can thiet khi clone ve may moi.
echo.
echo %C_YLW%  Thuc hien:%C_RST%
echo  %C_GRY%-%C_RST% Tao thu muc: config, outputs, mau, rules
echo  %C_GRY%-%C_RST% Copy ai_keys_template.yaml -^> ai_keys.yaml
echo  %C_GRY%-%C_RST% Tao .gitkeep trong outputs/
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%python src/main.py init%C_RST%
echo  hoac Menu 4 -^> Chon 2
echo.
echo %C_CYA%  --- Reset ---%C_RST%
echo.
echo %C_YLW%  Cong dung:%C_RST%
echo  Xoa du lieu nguoi dung, giu nguyen file mac dinh.
echo.
echo %C_YLW%  Du lieu bi xoa:%C_RST%
echo  %C_GRY%-%C_RST% config/ai_keys.yaml (API keys)
echo  %C_GRY%-%C_RST% outputs/ (file dau ra)
echo  %C_GRY%-%C_RST% rules/learned_rules.yaml
echo  %C_GRY%-%C_RST% rules/custom_rules.yaml
echo  %C_GRY%-%C_RST% rules/smart_patterns.yaml
echo.
echo %C_YLW%  Du lieu giu nguyen:%C_RST%
echo  %C_GRY%-%C_RST% rules/default.yaml, academic.yaml
echo  %C_GRY%-%C_RST% mau/, src/, tests/, run.bat...
echo.
echo %C_YLW%  Cach dung:%C_RST%
echo  %C_GRY%python src/main.py reset%C_RST%
echo  hoac Menu 3 -^> Chon 6, hoac Menu 4 -^> Chon 3
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
echo  %C_YLW%GitHub:%C_RST% https://github.com/Lehuynh-Ngoc
echo.
echo  Ung dung duoc phat trien nham giup nguoi
echo  dung dinh dang, dich thuat, va tao van ban
echo  Word mot cach nhanh chong voi ho tro AI.
echo.
echo  %C_GRY%12 subcommands | 5 AI providers | 19 ngon ngu%C_RST%
echo  %C_GRY%19 loai van ban | 7 unit tests%C_RST%
echo.
pause
goto :about
