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
echo  %C_BLD%%C_CYA  AI PROVIDER SYSTEM                        %C_RST%
echo  %C_BLD%%C_CYA  AI Config - Quan ly AI providers          %C_RST%
echo  %C_BLD%%C_CYA==========================================%C_RST%
echo.
echo  %C_GRN%[1]%C_RST%  Tong quan - AI Provider la gi?
echo  %C_GRN%[2]%C_RST%  5 Providers ho tro
echo  %C_GRN%[3]%C_RST%  Multi-model & Status
echo  %C_GRN%[4]%C_RST%  CRUD - Them/Sua/Xoa
echo  %C_GRN%[5]%C_RST%  Cach dung
echo  %C_GRN%[6]%C_RST%  Config file ai_keys.yaml
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
echo  %C_BLD%%C_CYA  TONG QUAN - AI PROVIDER LA GI?             %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%AI Provider System%C_RST% quan ly cac dich vu AI
echo  ho tro dich thuat va tao van ban Word.
echo.
echo  %C_BLD%Chuc nang chinh:%C_RST%
echo  - Them/sua/xoa provider - OpenAI, Gemini, Claude...
echo  - Them/sua/xoa model cho tung provider
echo  - Kiem tra API key hop le
echo  - Chon model hoat dong
echo  - Luu cau hinh vao ai_keys.yaml
echo.
echo  %C_BLD%Nguyen ly:%C_RST%
echo  - Moi provider co API key rieng
echo  - Moi provider co nhieu model
echo  - Provider hoat dong dau tien = mac dinh
echo  - Status check qua API call that
echo  - Config luu tai config/ai_keys.yaml
echo.
echo  %C_BLD%Dung cho:%C_RST%
echo  - Dich thuat file Word - Translator
echo  - Tao van ban AI - DocGenerator
echo  - Tat ca tinh nang can AI provider
echo.
pause
goto menu

:page2
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  5 PROVIDERS HO TRO                         %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_GRN%1. OpenAI%C_RST% - Cong ty tao ra ChatGPT
echo  - gpt-4o          - Mo hinh moi nhat, tot nhat
echo  - gpt-4o-mini     - Nhanh, re hon
echo  - gpt-4-turbo     - Phien ban nhanh cua GPT-4
echo  - gpt-3.5-turbo   - Re, pho bien
echo.
echo  %C_CYA%2. Google Gemini%C_RST% - Cua Google
echo  - gemini-2.5-flash   - Mo hinh moi nhat
echo  - gemini-2.0-flash   - Nhanh, hieu qua
echo  - gemini-1.5-pro     - Mo hinh lon
echo  - gemini-1.5-flash   - Phien ban nhanh
echo.
echo  %C_YLW%3. Anthropic Claude%C_RST% - Cua Anthropic
echo  - claude-sonnet-4      - Mo hinh moi nhat
echo  - claude-3-5-sonnet   - Tot, pho bien
echo  - claude-3-5-haiku    - Nhanh, re
echo  - claude-3-haiku      - Phien ban nhe
echo.
echo  %C_RED%4. DeepSeek%C_RST% - Cua Trung Quoc
echo  - deepseek-chat    - Mo hinh chat chinh
echo  - deepseek-reasoner - Mo hinh ly luan
echo.
echo  %C_GRY%5. Custom API%C_RST% - API tuy chinh
echo  - Bat ky endpoint nao ho tro OpenAI format
echo  - Phu hop voi local LLM hoac API rieng
echo.
pause
goto menu

:page3
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  MULTI-MODEL & STATUS                       %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Multi-model per provider:%C_RST%
echo  - Moi provider co the co nhieu model
echo  - Moi model co ten va chi so rieng
echo  - p.model la property tra ve model active
echo  - Chi mot model duoc chon hoat dong
echo.
echo  %C_BLD%Status codes:%C_RST%
echo.
echo  %C_GRN%VALID%C_RST% - API key hop le, con tin
echo  - Hien thi mau xanh
echo  - San sang su dung
echo  - Du tien de chon
echo.
echo  %C_GRY%UNCHECKED%C_RST% - Chua kiem tra
echo  - Hien thi mau xam
echo  - Chua verify API key
echo  - Can check truoc khi dung
echo.
echo  %C_RED%INVALID%C_RST% - API key khong hop le
echo  - Hien thi mau do
echo  - Sai key da het han
echo  - Can cap nhat key moi
echo.
echo  %C_YLW%LOW_CREDIT%C_RST% - Con it tien
echo  - Hien thi mau vang
echo  - Con it quota
echo  - Can nap tien them
echo.
echo  %C_RED%ERROR%C_RST% - Loi ket noi
echo  - Hien thi mau do
echo  - Khong ket noi duoc
echo  - Kiem tra mang hoac key
echo.
pause
goto menu

:page4
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  CRUD - THEM/SUA/XOA                        %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%1. Them provider moi:%C_RST%
echo  - Mo run.bat -> Menu 4
echo  - Chon "Them provider"
echo  - Nhap ten provider
echo  - Nhap API key
echo  - Chon model mac dinh
echo.
echo  %C_BLD%2. Them model moi:%C_RST%
echo  - Chon provider can them model
echo  - Nhap ten model
echo  - Xac nhan
echo  - Model moi them vao danh sach
echo.
echo  %C_BLD%3. Xoa model:%C_RST%
echo  - Chon provider
echo  - Chon model can xoa
echo  - Xac nhan xoa
echo  - Luu cau hinh
echo.
echo  %C_BLD%4. Doi ten model:%C_RST%
echo  - Chon provider
echo  - Chon model can doi ten
echo  - Nhap ten moi
echo  - Xac nhan
echo.
echo  %C_BLD%5. Chon model hoat dong:%C_RST%
echo  - Xem danh sach model
echo  - Chon model can kich hoat
echo  - Provider hoat dong dau tien = mac dinh
echo.
echo  %C_BLD%6. Kiem tra API key:%C_RST%
echo  - Gui request test den API
echo  - Cap nhat status
echo  - Hien thi ket qua
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
echo  %C_BLD%1. Lenh CLI:%C_RST%
echo  python src/main.py settings
echo  - Mo giao dien quan ly AI
echo  - Danh sach providers
echo  - Chon thao tac
echo.
echo  %C_BLD%2. Qua Menu:%C_RST%
echo  - Mo run.bat -> Menu 4
echo  - Cai dat AI providers
echo  - Chon thao tac can thuc hien
echo.
echo  %C_BLD%3. Quy trinh cai dat lan dau:%C_RST%
echo  - Chon provider muon dung
echo  - Nhap API key tu trang chu
echo  - Kiem tra key hop le
echo  - Chon model can su dung
echo  - Provider hoat dong dau tien = mac dinh
echo.
echo  %C_BLD%4. Nhan API key:%C_RST%
echo  - OpenAI: platform.openai.com/api-keys
echo  - Gemini: aistudio.google.com/apikey
echo  - Claude: console.anthropic.com
echo  - DeepSeek: platform.deepseek.com
echo.
echo  %C_BLD%5. Su dung khi dich/thuat:%C_RST%
echo  - Cai dat provider truoc
echo  - Chay dich thuat hoac tao van ban
echo  - Provider hoat dong duoc tu dong chon
echo.
pause
goto menu

:page6
cls
echo.
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo  %C_BLD%%C_CYA  CONFIG FILE AI_KEYS.YAML                   %C_RST%
echo  %C_BLD%%C_CYA=============================================%C_RST%
echo.
echo  %C_BLD%Vi tri:%C_RST% config/ai_keys.yaml
echo  - File cau hinh luu API key va models
echo  - Tu dong tao khi chay settings lan dau
echo  - Duoc gitignore - khong commit len git
echo.
echo  %C_BLD%Cau truc YAML:%C_RST%
echo  providers:
echo    openai:
echo      api_key: sk-xxxxxxxx
echo      active_model: gpt-4o
echo      status: VALID
echo      models:
echo        - gpt-4o
echo        - gpt-4o-mini
echo        - gpt-4-turbo
echo    gemini:
echo      api_key: AIzaxxxxxx
echo      active_model: gemini-2.5-flash
echo      status: VALID
echo      models:
echo        - gemini-2.5-flash
echo        - gemini-2.0-flash
echo.
echo  %C_BLD%Mac dinh:%C_RST%
echo  - Khi chua co file, tu dong tao tu template
echo  - Template: config/ai_keys_template.yaml
echo  - Tat ca key de trong, ban tu nhap
echo.
echo  %C_BLD%Luu y:%C_RST%
echo  - KHONG commit file nay len git
echo  - Chua co template -> tao tu dong
echo  - Cap nhat status khi thay doi key
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
echo  %C_BLD%Meo 1: Chon provider phu hop%C_RST%
echo  - OpenAI: chat tot, pho bien nhat
echo  - Gemini: mien phi nhieu, nhanh
echo  - Claude: van ban dai tot
echo  - DeepSeek: re, ly luan tot
echo.
echo  %C_BLD%Meo 2: Kiem tra key truoc khi dung%C_RST%
echo  - Luon check key moi nhap
echo  - Xem status mau xanh = OK
echo  - Dung provider VALID de dam bao
echo.
echo  %C_BLD%Meo 3: Quan ly nhieu provider%C_RST%
echo  - Cai dat nhieu provider
echo  - Chuyen doi khi provider loi
echo  - Dung provider tot nhat cho tung nhiem vu
echo.
echo  %C_RED%Loi pho bien:%C_RST%
echo  - API key invalid: kiem tra lai key
echo  - Rate limited: doi 1 phut, thu lai
echo  - No active provider: chon provider hop le
echo  - Network error: kiem tra ket noi mang
echo  - File corrupted: xoa file, tao lai tu template
echo.
pause
goto menu

:end
endlocal
exit /b 0
