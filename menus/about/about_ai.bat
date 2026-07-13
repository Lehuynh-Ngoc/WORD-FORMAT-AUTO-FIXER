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
echo %C_CYA%%C_BLD%  AI PROVIDER SYSTEM                                     %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan - AI Provider la gi?
echo %C_YLW%  2.%C_RST% 5 Providers ho tro
echo %C_YLW%  3.%C_RST% Custom API + Models + Status
echo %C_YLW%  4.%C_RST% Cach dung - CLI va Menu
echo %C_YLW%  5.%C_RST% Config file ai_keys.yaml
echo %C_YLW%  6.%C_RST% Meo va loi
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
echo %C_CYA%%C_BLD%  TONG QUAN - AI PROVIDER LA GI?                        %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%AI Provider System%C_RST% quan ly cac dich vu AI
echo ho tro dich thuat va tao van ban Word.
echo.
echo %C_BLD%Source code:%C_RST% src/core/ai_config.py
echo - APIStatus enum: VALID, LOW_CREDIT, INVALID, ERROR, UNCHECKED
echo - ProviderConfig dataclass: name, api_key, models, status
echo - ModelInfo: name, is_active
echo - DEFAULT_MODELS: dict 5 providers
echo - DEFAULT_BASE_URLS: dict API endpoints
echo.
echo %C_BLD%Chuc nang chinh:%C_RST%
echo - Them/sua/xoa provider voi CRUD
echo - Them/sua/xoa model cho tung provider
echo - Kiem tra API key hop le qua API call that
echo - Chon model hoat dong (p.model la property)
echo - Luu cau hinh vao ai_keys.yaml
echo.
echo %C_BLD%Nguyen ly:%C_RST%
echo - Moi provider co API key rieng
echo - Moi provider co nhieu model
echo - Provider hoat dong dau tien = mac dinh
echo - Status check qua HTTP request that
echo - Config luu tai config/ai_keys.yaml
echo.
echo %C_BLD%Dung cho:%C_RST%
echo - Dich thuat file Word (Translator)
echo - Tao van ban AI (DocGenerator)
echo - Tat ca tinh nang can AI provider
echo.
pause
goto :menu

:page2
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  5 PROVIDERS HO TRO                                     %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRN%1. OpenAI%CRST% - platform.openai.com/api-keys
echo   gpt-4o            - Mo hinh moi nhat, tot nhat
echo   gpt-4o-mini       - Nhanh, re hon
echo   gpt-4-turbo       - Phien ban nhanh cua GPT-4
echo   gpt-3.5-turbo     - Re, pho bien
echo   Base URL: api.openai.com/v1
echo.
echo %C_CYA%2. Google Gemini%CRST% - aistudio.google.com/apikey
echo   gemini-2.5-flash   - Mo hinh moi nhat
echo   gemini-2.0-flash   - Nhanh, hieu qua
echo   gemini-1.5-pro     - Mo hinh lon
echo   gemini-1.5-flash   - Phien ban nhanh
echo   Base URL: generativelanguage.googleapis.com/v1beta
echo.
echo %C_YLW%3. Anthropic Claude%CRST% - console.anthropic.com
echo   claude-sonnet-4-20250514       - Mo hinh moi nhat
echo   claude-3-5-sonnet-20241022    - Tot, pho bien
echo   claude-3-5-haiku-20241022     - Nhanh, re
echo   claude-3-haiku-20240307       - Phien ban nhe
echo   Base URL: api.anthropic.com/v1
echo.
echo %C_RED%4. DeepSeek%CRST% - platform.deepseek.com
echo   deepseek-chat      - Mo hinh chat chinh
echo   deepseek-reasoner  - Mo hinh ly luan
echo   Base URL: api.deepseek.com/v1
echo.
echo %C_GRY%5. Custom API%CRST% - API tuy chinh
echo   Bat ky endpoint ho tro OpenAI format
echo   Phu hop voi local LLM hoac API rieng
echo   Can nhap base URL thu cong
echo.
pause
goto :menu

:page3
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CUSTOM API + MODELS + STATUS                          %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Multi-model per provider:%C_RST%
echo - Moi provider co the co nhieu model
echo - Moi model co ten va is_active flag
echo - p.model la property tra ve model active
echo - Chi mot model duoc chon hoat dong
echo - Ham add_model_to_provider() them model moi
echo - Ham remove_model_from_provider() xoa model
echo - Ham rename_model_in_provider() doi ten model
echo - Ham set_active_model() chon model hoat dong
echo.
echo %C_BLD%Status codes:%C_RST%
echo.
echo %C_GRN%VALID%CRST%      - API key hop le, con tin
echo   Hien thi mau xanh, san sang su dung
echo.
echo %C_GRY%UNCHECKED%CRST%  - Chua kiem tra
echo   Hien thi mau xam, chua verify API key
echo.
echo %C_RED%INVALID%CRST%    - API key khong hop le
echo   Hien thi mau do, sai key da het han
echo.
echo %C_YLW%LOW_CREDIT%CRST% - Con it tien
echo   Hien thi mau vang, con it quota
echo.
echo %C_RED%ERROR%CRST%       - Loi ket noi
echo   Hien thi mau do, khong ket noi duoc
echo.
echo %C_BLD%Ham check_api_key:%C_RST%
echo - Gui request test den API provider
echo - Cap nhat status va credit_info
echo - Luu vao ai_keys.yaml
echo.
pause
goto :menu

:page4
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CACH DUNG - CLI VA MENU                               %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%1. Lenh CLI:%C_RST%
echo   python src/main.py settings
echo   Mo giao dien quan ly AI, chon thao tac
echo.
echo %C_BLD%2. Qua Menu:%C_RST%
echo   Mo run.bat -> Menu 4 - Cai dat
echo   Chon provider, nhap API key
echo.
echo %C_BLD%3. Quy trinh cai dat lan dau:%C_RST%
echo   - Chon provider muon dung
echo   - Nhap API key tu trang chu provider
echo   - Kiem tra key hop le (check_api_key)
echo   - Chon model can su dung
echo   - Provider hoat dong dau tien = mac dinh
echo.
echo %C_BLD%4. Nhan API key:%C_RST%
echo   OpenAI:  platform.openai.com/api-keys
echo   Gemini:  aistudio.google.com/apikey
echo   Claude:  console.anthropic.com
echo   DeepSeek: platform.deepseek.com
echo.
echo %C_BLD%5. Su dung khi dich/thuat:%C_RST%
echo   - Cai dat provider truoc
echo   - Chay dich thuat hoac tao van ban
echo   - Provider hoat dong duoc tu dong chon
echo   - Co the chi dinh: -p openai, -p gemini...
echo.
pause
goto :menu

:page5
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  CONFIG FILE AI_KEYS.YAML                              %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Vi tri:%C_RST% config/ai_keys.yaml
echo   - File cau hinh luu API key va models
echo   - Tu dong tao tu template khi chay settings lan dau
echo   - Duoc gitignore - khong commit len git
echo.
echo %C_BLD%Cau truc YAML:%C_RST%
echo   providers:
echo     openai:
echo       api_key: sk-xxxxxxxx
echo       base_url: https://api.openai.com/v1
echo       active_model: gpt-4o
echo       status: valid
echo       models:
echo         - name: gpt-4o
echo           is_active: true
echo         - name: gpt-4o-mini
echo           is_active: false
echo     gemini:
echo       api_key: AIzaxxxxxx
echo       base_url: https://generativelanguage.googleapis.com/v1beta
echo       status: valid
echo       models:
echo         - name: gemini-2.5-flash
echo           is_active: true
echo.
echo %C_BLD%Mac dinh:%C_RST%
echo   - Khi chua co file, tu dong copy tu template
echo   - Template: config/ai_keys_template.yaml
echo   - Tat ca key de trong, ban tu nhap
echo.
echo %C_BLD%Luu y:%C_RST%
echo   - KHONG commit file nay len git
echo   - Cap nhat status khi thay doi key
echo.
pause
goto :menu

:page6
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%  MEO VA LOI                                             %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_BLD%Meo 1: Chon provider phu hop%CRST%
echo   OpenAI: chat tot, pho bien nhat
echo   Gemini: mien phi nhieu, nhanh
echo   Claude: van ban dai tot
echo   DeepSeek: re, ly luan tot
echo.
echo %C_BLD%Meo 2: Kiem tra key truoc khi dung%CRST%
echo   Luon check key moi nhap
echo   Xem status mau xanh = OK
echo   Dung provider VALID de dam bao
echo.
echo %C_BLD%Meo 3: Quan ly nhieu provider%CRST%
echo   Cai dat nhieu provider
echo   Chuyen doi khi provider loi
echo   Dung provider tot nhat cho tung nhiem vu
echo.
echo %C_RED%Loi pho bien:%CRST%
echo.
echo %C_RED%API key invalid%CRST%   - Kiem tra lai key
echo %C_RED%Rate limited%CRST%      - Doi 1 phut, thu lai
echo %C_RED%No active provider%CRST% - Chon provider hop le
echo %C_RED%Network error%CRST%      - Kiem tra ket noi mang
echo %C_RED%File corrupted%CRST%     - Xoa file, chay init de tao lai
echo.
pause
goto :menu
