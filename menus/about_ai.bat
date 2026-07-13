@echo off
setlocal enabledelayedexpansion
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "C_CYA=%ESC%[36m" & set "C_YLW=%ESC%[33m" & set "C_GRN=%ESC%[32m"
set "C_RED=%ESC%[31m" & set "C_GRY=%ESC%[90m" & set "C_WHT=%ESC%[37m"
set "C_BLD=%ESC%[1m" & set "C_RST=%ESC%[0m"

:menu
cls
echo.
echo %C_CYA%============================================================%C_RST%
echo %C_CYA%%C_BLD%         7. AI PROVIDER - QUAN LY API KEY VA MODELS     %C_RST%
echo %C_CYA%============================================================%C_RST%
echo.
echo %C_GRY%  Chon muc de xem:%C_RST%
echo.
echo %C_YLW%  1.%C_RST% Tong quan he thong
echo %C_YLW%  2.%C_RST% 5 Provider mac dinh
echo %C_YLW%  3.%C_RST% Custom API
echo %C_YLW%  4.%C_RST% Quan ly models
echo %C_YLW%  5.%C_RST% API Key status
echo %C_YLW%  6.%C_RST% Cach dung (Menu + CLI)
echo %C_YLW%  7.%C_RST% File cau hinh
echo %C_YLW%  8.%C_RST% Xu ly loi
echo %C_RED%  0.%C_RST% Quay lai
echo.
set /p SUB="%C_YLW%Chon: %C_RST%"

if "%SUB%"=="1" goto :tongquan
if "%SUB%"=="2" goto :providers
if "%SUB%"=="3" goto :custom
if "%SUB%"=="4" goto :models
if "%SUB%"=="5" goto :status
if "%SUB%"=="6" goto :cachdung
if "%SUB%"=="7" goto :config
if "%SUB%"=="8" goto :loixuly
if "%SUB%"=="0" exit /b
goto :menu

:tongquan
cls
echo.
echo %C_CYA%--- TONG QUAN HE THONG ---%C_RST%
echo.
echo  %C_WHT%AI Provider System%C_RST% quan ly API keys, models va
echo  status cho cac nha cung cap AI.
echo.
echo %C_CYA%  Architecture:%C_RST%
echo  %C_GRY%  ProviderConfig:%C_RST%  Ten, display_name, api_key, base_url
echo  %C_GRY%                 models: List[ModelInfo], status, credit_info%C_RST%
echo  %C_GRY%  ModelInfo:      name, is_active (co 1 model active)%C_RST%
echo  %C_GRY%  APIStatus:      VALID, LOW_CREDIT, INVALID, ERROR, UNCHECKED%C_RST%
echo.
echo %C_CYA%  Features:%C_RST%
echo  %C_GRY%-%C_RST% Multi-model per provider (them/sua/xoa model)
echo  %C_GRY%-%C_RST% Quick model select (chon nhanh)
echo  %C_GRY%-%C_RST% API key check live (test ket noi that)
echo  %C_GRY%-%C_RST% Custom API (them provider tuy y)
echo  %C_GRY%-%C_RST% Status colors: xanh=hop le, vang=het, do=sai
echo  %C_GRY%-%C_RST% Tu dong tao config tu template khi chay lan dau
echo.
echo %C_CYA%  Luu y quan trong:%C_RST%
echo  %C_GRY%  p.model la property (khong phai field)%C_RST%
echo  %C_GRY%  -> tra ve model dang active trong list models%C_RST%
echo  %C_GRY%  Provider hoat dong = co api_key + status VALID/UNCHECKED%C_RST%
echo.
pause
goto :menu

:providers
cls
echo.
echo %C_CYA%--- 5 PROVIDER MAC DINH ---%C_RST%
echo.
echo %C_YLW%  1. OpenAI (GPT)%C_RST%
echo  %C_GRY%  Base URL:  https://api.openai.com/v1%C_RST%
echo  %C_GRY%  Models:    gpt-4o, gpt-4o-mini, gpt-4-turbo, gpt-3.5-turbo%C_RST%
echo  %C_GRY%  Auth:      Bearer token%C_RST%
echo  %C_GRY%  Check:     GET /models%C_RST%
echo.
echo %C_YLW%  2. Google Gemini%C_RST%
echo  %C_GRY%  Base URL:  https://generativelanguage.googleapis.com/v1beta%C_RST%
echo  %C_GRY%  Models:    gemini-2.5-flash, gemini-2.0-flash,%C_RST%
echo  %C_GRY%             gemini-1.5-pro, gemini-1.5-flash%C_RST%
echo  %C_GRY%  Auth:      API key (query param)%C_RST%
echo  %C_GRY%  Check:     GET /models?key=X%C_RST%
echo.
echo %C_YLW%  3. Anthropic Claude%C_RST%
echo  %C_GRY%  Base URL:  https://api.anthropic.com/v1%C_RST%
echo  %C_GRY%  Models:    claude-sonnet-4-20250514, claude-3-5-sonnet,%C_RST%
echo  %C_GRY%             claude-3-5-haiku, claude-3-haiku%C_RST%
echo  %C_GRY%  Auth:      x-api-key header%C_RST%
echo  %C_GRY%  Check:     POST /messages (gui "hi", nhan response)%C_RST%
echo.
echo %C_YLW%  4. DeepSeek%C_RST%
echo  %C_GRY%  Base URL:  https://api.deepseek.com/v1%C_RST%
echo  %C_GRY%  Models:    deepseek-chat, deepseek-reasoner%C_RST%
echo  %C_GRY%  Auth:      Bearer token%C_RST%
echo  %C_GRY%  Check:     GET /models%C_RST%
echo.
echo %C_YLW%  5. Custom API (tu tao)%C_RST%
echo  %C_GRY%  Base URL:  Nhap tuy y (VD: https://api.example.com/v1)%C_RST%
echo  %C_GRY%  Models:    Nhap tuy y%C_RST%
echo  %C_GRY%  Format:    OpenAI-compatible (/chat/completions)%C_RST%
echo  %C_GRY%  Auth:      Bearer token (neu co)%C_RST%
echo.
pause
goto :menu

:custom
cls
echo.
echo %C_CYA%--- CUSTOM API ---%C_RST%
echo.
echo  Them provider AI tuy y, ho tro moi API theo
echo  format OpenAI-compatible.
echo.
echo %C_CYA%  Cach them:%C_RST%
echo  %C_GRY%1.%C_RST% Menu 4 -> Chon 2 -> Chon 3 (Quan ly provider -> Them custom)
echo  %C_GRY%2.%C_RST% Nhap: ten viet tat, ten hien thi, base URL, API key, model
echo.
echo %C_CYA%  Vi du:%C_RST%
echo  %C_WHT%Ten:     ollama%C_RST%
echo  %C_WHT%Hien thi: Ollama Local%C_RST%
echo  %C_WHT%URL:     http://localhost:11434/v1%C_RST%
echo  %C_WHT%Key:     (de trong)%C_RST%
echo  %C_WHT%Model:   llama3%C_RST%
echo.
echo %C_CYA%  Dinh dang can thiet:%C_RST%
echo  %C_GRY%POST {base_url}/chat/completions%C_RST%
echo  %C_GRY%Body: {"model": "...", "messages": [...], "max_tokens": 10}%C_RST%
echo.
echo %C_CYA%  Cach xoa:%C_RST%
echo  %C_GRY%Menu 4 -> Chon 2 -> Chon 4 (Xoa custom)%C_RST%
echo  %C_GRY%-> Chi xoa duoc custom API (khong xoa default)%C_RST%
echo.
echo %C_CYA%  Cach doi ten:%C_RST%
echo  %C_GRY%Vao chi tiet custom provider -> Chon 8 (Doi ten)%C_RST%
echo.
pause
goto :menu

:models
cls
echo.
echo %C_CYA%--- QUAN LY MODELS ---%C_RST%
echo.
echo  Moi provider co the co nhieu model.
echo  Chi 1 model duoc "active" (dang dung) tai 1 thoi diem.
echo.
echo %C_CYA%  Cach chon model active:%C_RST%
echo  %C_GRY%Menu 4 -> Chon 1 (Chon model hoat dong nhanh)%C_RST%
echo  %C_GRY%-> Chon provider -> Chon model tu danh sach%RST%
echo.
echo %C_CYA%  Cach them model:%C_RST%
echo  %C_GRY%Vao chi tiet provider -> Chon 4 (Them model)%C_RST%
echo  %C_GRY%-> Nhap ten model (VD: gpt-4o-2024-05-13)%RST%
echo.
echo %C_CYA%  Cach xoa model:%C_RST%
echo  %C_GRY%Vao chi tiet provider -> Chon 6 (Xoa model)%C_RST%
echo  %C_GRY%-> Can it nhat 1 model con lai%RST%
echo.
echo %C_CYA%  Cach doi ten model:%C_RST%
echo  %C_GRY%Vao chi tiet provider -> Chon 5 (Doi ten)%C_RST%
echo  %C_GRY%-> Chon model -> Nhap ten moi%RST%
echo.
echo %C_CYA%  Mac dinh moi provider:%C_RST%
echo  %C_GRY%  OpenAI:   gpt-4o (active), gpt-4o-mini, gpt-4-turbo, gpt-3.5-turbo%C_RST%
echo  %C_GRY%  Gemini:   gemini-2.5-flash (active), gemini-2.0-flash, ...%C_RST%
echo  %C_GRY%  Claude:   claude-sonnet-4-20250514 (active), claude-3-5-sonnet, ...%C_RST%
echo  %C_GRY%  DeepSeek: deepseek-chat (active), deepseek-reasoner%C_RST%
echo.
pause
goto :menu

:status
cls
echo.
echo %C_CYA%--- API KEY STATUS ---%C_RST%
echo.
echo %C_YLW%  5 trang thai:%C_RST%
echo.
echo  %C_GRN%  VALID%C_RST%           API key hoat dong tot
echo      %C_GRY%-> Da test, ket noi thanh cong, co models kha dung%C_RST%
echo.
echo  %C_YLW%  UNCHECKED%C_RST%       Chua nhap API key
echo      %C_GRY%-> Mac dinh khi chua setup. Khong phai "INVALID"%C_RST%
echo      %C_GRY%-> Provider van co the hoat dong neu API key dung%C_RST%
echo.
echo  %C_RED%  INVALID%C_RST%         API key khong hop le
echo      %C_GRY%-> Da nhap key, server tra loi 401 (Unauthorized)%C_RST%
echo.
echo  %C_YLW%  LOW_CREDIT%C_RST%      Gan het credit / rate limited
echo      %C_GRY%-> Server tra loi 429 (Too Many Requests)%C_RST%
echo      %C_GRY%-> Thu lai sau vai phut hoac nang cap plan%C_RST%
echo.
echo  %C_RED%  ERROR%C_RST%           Loi ket noi
echo      %C_GRY%-> Khong ket noi duoc voi server%C_RST%
echo      %C_GRY%-> Kiem tra base URL, firewall, proxy%C_RST%
echo.
echo  %C_CYA%  Cach kiem tra:%C_RST%
echo  %C_GRY%  Menu 4 -> Chon 3 (Kiem tra tat ca)%C_RST%
echo  %C_GRY%  Hoac: vao chi tiet provider -> Chon 7%RST%
echo.
pause
goto :menu

:cachdung
cls
echo.
echo %C_CYA%--- CACH DUNG ---%C_RST%
echo.
echo %C_CYA%  Menu (run.bat):%C_RST%
echo  %C_GRY%1.%C_RST% Chay %C_WHT%run.bat%C_RST%
echo  %C_GRY%2.%C_RST% Menu 4 - Cai dat
echo  %C_GRY%3.%C_RST% Chon 1 - Quan ly AI providers
echo.
echo %C_CYA%  CLI:%C_RST%
echo  %C_WHT%python src/main.py settings%C_RST%
echo.
echo %C_CYA%  Menu 3 tuy chon:%C_RST%
echo  %C_YLW%  1.%C_RST% Chon model hoat dong (nhanh)
echo      %C_GRY%Chon provider -> Chon model tu danh sach%RST%
echo  %C_YLW%  2.%C_RST% Quan ly provider (day du)
echo      %C_GRY%Chon provider -> Chi tiet (URL, key, models, check)%RST%
echo      %C_GRY%Them custom, xoa custom, doi ten%RST%
echo  %C_YLW%  3.%C_RST% Kiem tra tat ca API keys
echo      %C_GRY%Test tung provider, hien thi status%RST%
echo.
echo  %C_CYA%Luu y:%C_RST%  Provider hoat dong dau tien co key hop le
echo  se duoc chon tu dong khi dung dich vu AI.
echo.
pause
goto :menu

:config
cls
echo.
echo %C_CYA%--- FILE CAU HINH ---%C_RST%
echo.
echo %C_CYA%  File:%C_RST%  config/ai_keys.yaml
echo.
echo %C_CYA%  Cau truc YAML:%C_RST%
echo  %C_GRY%providers:%C_RST%
echo  %C_GRY%  openai:%C_RST%
echo  %C_GRY%    api_key: "sk-..."%C_RST%
echo  %C_GRY%    base_url: "https://api.openai.com/v1"%C_RST%
echo  %C_GRY%    models:%C_RST%
echo  %C_GRY%      - name: "gpt-4o"%C_RST%
echo  %C_GRY%        is_active: true%C_RST%
echo  %C_GRY%      - name: "gpt-4o-mini"%C_RST%
echo  %C_GRY%        is_active: false%C_RST%
echo  %C_GRY%    status: "valid"%C_RST%
echo  %C_GRY%    last_checked: "2025-01-01 12:00:00"%C_RST%
echo  %C_GRY%    credit_info: "Hop le. 50 models."%C_RST%
echo.
echo %C_CYA%  Template:%C_RST%  config/ai_keys_template.yaml
echo  %C_GRY%providers: {}%C_RST%
echo.
echo %C_CYA%  Auto-creation:%C_RST%
echo  %C_GRY%-%C_RST% Neu ai_keys.yaml khong ton tai -> tu dong copy tu template
echo  %C_GRY%-%C_RST% Duoc thuc thi khi load config lan dau
echo.
echo %C_CYA%  Git:%C_RST%
echo  %C_GRY%  ai_keys.yaml       -> gitignored (an API keys)%C_RST%
echo  %C_GRY%  ai_keys_template.yaml -> tracked (safe)%C_RST%
echo.
pause
goto :menu

:loixuly
cls
echo.
echo %C_CYA%--- XU LY LOI ---%C_RST%
echo.
echo %C_RED%  Loi: "No active AI provider found"%C_RST%
echo  %C_GRY%-%C_RST% Chua co provider nao co API key hop le
echo  %C_GRY%-%C_RST% Vao Menu 4 -> Quan ly provider -> Nhap API key
echo  %C_GRY%-%C_RST% Kiem tra status: can VALID hoac UNCHECKED
echo.
echo %C_RED%  Loi: "API key is invalid (401)"%C_RST%
echo  %C_GRY%-%C_RST% API key sai hoac het han
echo  %C_GRY%-%C_RST% Tao lai key tai trang cua provider
echo  %C_GRY%-%C_RST% Kiem tra: co them khoang trang/thua ky tu?
echo.
echo %C_RED%  Loi: "Rate limited (429)"%C_RST%
echo  %C_GRY%-%C_RST% Qua nhieu request -> cho vai phut
echo  %C_GRY%-%C_RST% Nang len plan cao hon hoac giam tan suat
echo.
echo %C_RED%  Loi: "Connection error"%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra internet, firewall, proxy
echo  %C_GRY%-%C_RST% Kiem tra base URL dung chua
echo  %C_GRY%-%C_RST% VPN co the chan ket noi
echo.
echo %C_RED%  Provider custom khong hoat dong%C_RST%
echo  %C_GRY%-%C_RST% Kiem tra base URL dung format (OpenAI-compatible)
echo  %C_GRY%-%C_RST% Kiem tra model name dung chua
echo  %C_GRY%-%C_RST% Dung Menu 4 -> Kiem tra API key de test
echo.
pause
goto :menu
