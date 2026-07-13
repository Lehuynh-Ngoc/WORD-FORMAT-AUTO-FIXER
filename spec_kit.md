# Đặc tả dự án: Word Format Auto-Fixer

## 1. Tổng quan

**Tên:** Word Format Auto-Fixer  
**Mục đích:** CLI tool định dạng file Word (.doc/.docx), clone, đếm từ, dịch thuật, và tạo văn bản bằng AI.  
**Ngôn ngữ:** Python 3.10+  
**Yêu cầu:** Windows, Microsoft Word (cho clone mode và xử lý .doc)

### Chế độ xử lý

| Chế độ | Engine | Thư viện | Xử lý được |
|--------|--------|----------|------------|
| Format | FormatEngine | python-docx | Font, spacing, alignment, heading, SmartHeading |
| Clone | CloneEngine | win32com (DispatchEx) | Section, page setup, header/footer, watermark, TOC, columns, style |
| AI | AI providers | urllib (stdlib) | Dịch thuật, tạo văn bản, đếm từ, quản lý provider |

---

## 2. Kiến trúc

```
fomat_word/
├── run.bat                 # Batch menu (5 menu, ANSI color)
├── pyproject.toml
├── requirements.txt
├── AGENTS.md               # Hướng dẫn cho AI agent
├── spec_kit.md             # Đặc tả chi tiết dự án (file này)
├── README.md
│
├── config/
│   └── ai_keys.yaml        # API keys + models cho AI providers
│
├── mau/                    # File mẫu .doc/.docx cho clone mode
├── outputs/                # File đầu ra mặc định
│
├── rules/
│   ├── default.yaml        # Times New Roman 13, justify, 1.5
│   ├── academic.yaml       # Như default + first_line_indent
│   ├── smart_patterns.yaml # Custom pattern SmartHeading
│   └── learned_rules.yaml  # Tự sinh từ learn command
│
├── menus/
│   └── about/              # Menu 5 - Thông tin (14 file .bat)
│       ├── about.bat       # Menu chính About (gọi từ run.bat)
│       └── about_*.bat     # 13 trang百科 (gioithieu, learn, makerule...)
│
├── src/
│   ├── main.py             # Entry point (sys.path.insert + cli.handler.run)
│   │
│   ├── core/
│   │   ├── engine.py       # FormatEngine - điều phối formatter
│   │   ├── cloner.py       # CloneEngine - DispatchEx, retry, preview_only
│   │   ├── config.py       # ConfigLoader - đọc YAML, comma-separated
│   │   ├── rules.py        # FormatRule dataclass + rule_from_dict
│   │   ├── learner.py      # StyleLearner - học từ mẫu → YAML
│   │   ├── counter.py      # WordCounter - dem tu, ky tu, dong, trang
│   │   ├── translator.py   # Translator - dich van ban bang AI (batch chunks)
│   │   ├── doc_generator.py# DocGenerator - tao van ban bang AI
│   │   ├── ai_config.py    # AI provider CRUD, multi-model, API key check
│   │   └── init_reset.py   # Init/reset project logic
│   │
│   ├── formatters/
│   │   ├── base.py         # BaseFormatter (abstract)
│   │   ├── font.py         # FontFormatter
│   │   ├── spacing.py      # SpacingFormatter
│   │   ├── alignment.py    # AlignmentFormatter
│   │   ├── heading.py      # HeadingFormatter
│   │   └── smart_heading.py# SmartHeadingFormatter (regex)
│   │
│   ├── parsers/
│   │   ├── base.py         # BaseParser, ParsedDocument, ParsedParagraph
│   │   ├── docx_parser.py  # DocxParser (python-docx)
│   │   ├── doc_parser.py   # DocParser (win32com)
│   │   └── factory.py      # get_parser() theo extension
│   │
│   ├── cli/
│   │   ├── handler.py      # argparse (12 subcommands) + routing
│   │   ├── maker.py        # Tạo rule thủ công (interactive, 19 styles)
│   │   ├── rule_viewer.py  # Xem danh sách + chi tiết rules
│   │   ├── smart_config.py # Cấu hình SmartHeading patterns
│   │   ├── counter_cli.py  # Giao diện dem tu/trang
│   │   ├── translator_cli.py  # Giao diện dich thuat
│   │   ├── doc_generator_cli.py # Giao diện tao van ban AI
│   │   └── settings_cli.py # Quan ly AI providers (CRUD, models)
│   │
│   ├── utils/
│   │   ├── logger.py       # ColoredFormatter
│   │   └── reporter.py     # ChangeReporter
│   │
│   └── plugins/
│       └── manager.py      # Plugin loader
│
└── tests/
    └── test_basic.py       # Unit tests (pytest, 7 tests)
```

---

## 3. FormatEngine chi tiết

### 3.1 Luồng xử lý

```
Input .doc/.docx
  → get_parser() → parser.read()
  → FormatEngine.format(rules)
    → SmartHeadingFormatter.apply()    # 1. Phát hiện heading từ text
    → FontFormatter.apply()            # 2. Font name, size, bold, italic, color
    → SpacingFormatter.apply()         # 3. Line spacing, space before/after
    → AlignmentFormatter.apply()       # 4. Left, center, right, justify
    → HeadingFormatter.apply()         # 5. Gán Heading style level
  → parser.save() (nếu không dry-run)
  → reporter.summary()
```

### 3.2 docx_parser.py save()

`save()` ghi lại style, alignment, spacing, và run-level formatting. Cho phép format heading style mà không mất định dạng.

---

## 4. SmartHeadingFormatter

`src/formatters/smart_heading.py` - Dùng regex tự động phát hiện heading từ nội dung.

### 4.1 Built-in patterns

| Pattern | Style |
|---------|-------|
| CHƯƠNG/Chương + [IVXLCDM\|\d] | Heading 1 |
| Phần/PHẦN + [IVXLCDM\|\d] | Heading 1 |
| I, II, III... | Heading 1 |
| MỤC LỤC, TÀI LIỆU THAM KHẢO, KẾT LUẬN... | Heading 1 |
| \d+.\d+ | Heading 2 |
| \d+.\d+.\d+ | Heading 3 |
| \d+.\d+.\d+.\d+ | Heading 4 |
| BÁO CÁO..., LUẬN VĂN..., ĐỒ ÁN... | Title |
| Ngành:, GVHD:, SVTH:... | Subtitle |

### 4.2 Custom patterns

Thêm qua `smart_config.py`, lưu tại `rules/smart_patterns.yaml`. Priority: Custom → Built-in → Title → Subtitle.

---

## 5. CloneEngine

`src/core/cloner.py` - Sao chép toàn bộ định dạng Word từ template sang target.

### 5.1 Quy trình

1. Copy template → file temp
2. Open temp trong Word process riêng (`DispatchEx("Word.Application")`)
3. Xoá nội dung template (WholeStory → Delete, giữ section/page setup)
4. Save & Close template sạch
5. Open target → Copy toàn bộ nội dung
6. Documents.Add(template_sạch) → PasteAndFormat(16) = wdFormatOriginalFormatting
7. SaveAs output

### 5.2 Clone-preview

```bash
python src/main.py clone-preview "template.doc" "target.docx"
```
Mở Word cho người dùng xem kết quả trước khi lưu. Hỏi "Luu file?" → Yes/No.

### 5.3 Xử lý lỗi

- Retry tới 10 lần khi gặp `RPC_E_CALL_REJECTED` (Word bận)
- `pythoncom.PumpWaitingMessages()` giữa các lần retry
- `ScreenUpdating = False` để tăng tốc

---

## 6. ConfigLoader

`src/core/config.py` - Đọc và merge nhiều file rule YAML.

```bash
-r "rules/default.yaml,rules/smart_patterns.yaml"
```

**Xử lý lỗi:** File không tồn tại → warning + tiếp tục. Không load được file nào → raise `FileNotFoundError`.

**Rule resolution:** 1) Path tuyệt đối → dùng trực tiếp. 2) Path chứa `/` hoặc `\` → `os.path.abspath()`. 3) Tên file trần → lookup trong `rules/`.

---

## 7. Rule system

`src/core/rules.py` - FormatRule dataclass.

### 7.1 Fields

| Field | Type | Mô tả |
|-------|------|-------|
| `name` | str | Tên rule |
| `target` | str | paragraph / run / document |
| `conditions.style` | str | Khớp style name |
| `conditions.text_contains` | str | Khớp substring |
| `conditions.pattern` | str | Regex (re.search) |
| `font` | FontAction | name, size, bold, italic, color |
| `paragraph` | ParagraphAction | alignment, line_spacing, space_before, space_after, first_line_indent |
| `heading` | HeadingAction | level (int) hoặc style (str) |

### 7.2 Rule mặc định

| Thuộc tính | default.yaml | academic.yaml |
|-----------|-------------|---------------|
| Font | Times New Roman | Times New Roman |
| Size Normal | 13pt | 13pt |
| Size Heading 1 | 14pt | 14pt |
| Line spacing | 1.5 | 1.5 |
| Alignment Normal | Justify | Justify |
| First line indent | - | 1.27cm (36pt) |
| Bold | Heading 1,2,3 | Heading 1,2,3 |

---

## 8. CLI

### 8.1 Subcommands

| Lệnh | Mô tả | Args |
|------|-------|------|
| `format` | Định dạng file với rules | input, `-o`, `-r`, `--dry-run` |
| `preview` | Alias `format --dry-run` | input |
| `learn` | Học formatting từ file mẫu | input, `-o` |
| `clone` | Clone full định dạng | template, target, `-o` |
| `clone-preview` | Xem trước clone | template, target |
| `list-rules` | Liệt kê file rule | - |
| `count` | Đếm từ/trang | input, `-o` |
| `translate` | Dịch file Word | input, `-l` lang, `-s` source, `-o`, `-p` provider |
| `settings` | Quản lý AI providers | (interactive) |
| `generate` | Tạo văn bản Word bằng AI | `-o` |
| `init` | Khởi tạo project mới | - |
| `reset` | Reset project về mặc định | - |

### 8.2 Interactive CLI tools

| Tool | Mô tả |
|------|-------|
| `maker.py` | Tạo rule thủ công (19 styles + free text, supports first_line_indent) |
| `rule_viewer.py` | Xem danh sách + chi tiết rules |
| `smart_config.py` | CRUD SmartHeading patterns |
| `counter_cli.py` | Đếm từ/trang (tương tác) |
| `translator_cli.py` | Dịch file Word (tương tác) |
| `doc_generator_cli.py` | Tạo văn bản bằng AI (tương tác) |
| `settings_cli.py` | Quản lý AI providers |

### 8.3 Logger

| Level | Màu |
|-------|-----|
| INFO | Xanh lá |
| WARNING | Vàng |
| ERROR | Đỏ |
| DEBUG | Xám |

Format: `HH:MM:SS [LEVEL] message`

### 8.4 Reporter

| Formatter | Màu |
|-----------|-----|
| SmartHeading | Cyan |
| Font | Vàng |
| Spacing | Xanh lá |
| Alignment | Xám |
| Heading | Trắng |

---

## 9. AI Provider System

### 9.1 Provider architecture

```
ai_config.py
├── ProviderConfig (name, display_name, api_key, base_url, models, status)
├── ModelInfo (name, is_active)
├── DEFAULT_MODELS per provider
├── CRUD: get_all, save, delete, add_custom, remove_custom
├── Model CRUD: set_active, add, remove, rename
└── API check: check_api_key() → per-provider HTTP validation
```

### 9.2 Supported providers

| Provider | Base URL | Default Models |
|----------|----------|----------------|
| OpenAI | api.openai.com/v1 | gpt-4o, gpt-4o-mini, gpt-4-turbo, gpt-3.5-turbo |
| Gemini | generativelanguage.googleapis.com/v1beta | gemini-2.5-flash, gemini-2.0-flash, gemini-1.5-pro, gemini-1.5-flash |
| Claude | api.anthropic.com/v1 | claude-sonnet-4-20250514, claude-3-5-sonnet-20241022, claude-3-5-haiku-20241022, claude-3-haiku-20240307 |
| DeepSeek | api.deepseek.com/v1 | deepseek-chat, deepseek-reasoner |
| Custom | user-defined | user-defined |

### 9.3 Multi-model

Mỗi provider có danh sách `models: List[ModelInfo]`. Mỗi model có `name` + `is_active`. `p.model` là `@property` trả về model đang active.

### 9.4 Status

| Status | Ý nghĩa |
|--------|----------|
| UNCHECKED | Chưa nhập key / chưa kiểm tra |
| VALID | Key hợp lệ |
| LOW_CREDIT | Hết credit / rate limit (429) |
| INVALID | Key sai (401) |
| ERROR | Lỗi kết nối |

### 9.5 Config

Lưu tại `config/ai_keys.yaml`. Backward compatible với format cũ (single `model:` field).

### 9.6 API check

- **OpenAI:** GET `/models` → count available models
- **Gemini:** GET `/models?key=` → count models
- **Claude:** POST `/messages` với "hi" → check response
- **DeepSeek:** GET `/models` → check auth
- **Custom:** POST `/chat/completions` với "hi" → check response

---

## 10. Translate

`src/core/translator.py` - Dịch file Word bằng AI, giữ nguyên format.

### 10.1 Quy trình

1. Parse file → danh sách paragraphs
2. Batch chunks (3000 chars/chunk) → translate qua AI
3. Nếu batch result mismatch count → fallback individual
4. Ghi lại text vào paragraph, giữ nguyên runs (font, bold...)

### 10.2 Ngôn ngữ hỗ trợ

vi, en, zh, ja, ko, fr, de, es, it, pt, ru, th, id, ms, ar, hi, tr, pl, nl

### 10.3 AI call

Dùng `_call_ai()` trong translator.py — gọi OpenAI-compatible chat completions API.

---

## 11. Word Counter

`src/core/counter.py` - Đếm các thông tin về file Word.

### 11.1 Thông tin đếm

| Metric | Mô tả |
|--------|-------|
| paragraphs | Số đoạn văn |
| lines | Số dòng (ước tính) |
| words | Số từ |
| chars_no_space | Ký tự không có dấu cách |
| chars_with_space | Ký tự có dấu cách |
| pages_estimated | Trang ước tính (40 dòng/trang) |
| pages_actual | Trang thực tế (qua Word COM) |
| reading_time_vi | Thời gian đọc tiếng Việt (500 wpm) |
| reading_time_en | Thời gian đọc tiếng Anh (250 wpm) |
| detected_language | Ngôn ngữ phát hiện |
| headings | Danh sách headings (level, text) |

---

## 12. Document Generator

`src/core/doc_generator.py` - Tạo văn bản Word bằng AI.

### 12.1 Quy trình

1. User nhập loại văn bản (đơn xin việc, báo cáo...)
2. AI generates 5-10 câu hỏi dựa trên loại
3. User trả lời từng câu hỏi
4. AI tạo nội dung với formatting (heading, title, bold, page break)
5. Lưu thành .docx

### 12.2 19 loại văn bản

Đơn xin việc, đơn xin nghỉ phép, đơn xin đổi lớp, đơn xin cấp bằng, thư cảm ơn, thư xin phép, báo cáo thực tập, luận văn tốt nghiệp, phiếu đánh giá, quyết định bổ nhiệm, công văn, biên bản họp, hồ sơ ứng tuyển, thư mời họp, đơn khiếu nại.

---

## 13. Menu (run.bat)

5 menu, ANSI color.

### 13.1 Cấu trúc

**Menu chính (1-5):**
1. Học & Cấu hình
2. Định dạng & Clone
3. Tiện ích
4. Cài đặt
5. Thông tin

**Học & Cấu hình (1-3):**
1. Học từ mẫu
2. Tạo rule thủ công
3. Cấu hình SmartHeading

**Định dạng & Clone (1-5):**
1. Xem trước thay đổi
2. Định dạng file Word (chọn rule)
3. Định dạng rule mặc định
4. Clone định dạng từ file mẫu
5. Clone-preview

**Tiện ích (1-5):**
1. Danh sách rules
2. Chạy unit tests
3. Đếm số từ/trang
4. Dịch thuật file Word
5. Tạo văn bản bằng AI

**Cài đặt (1-3):**
1. Quản lý AI Provider
2. Init - Khởi tạo project mới
3. Reset - Reset project về mặc định

**Thông tin (Menu 5):**
`run.bat` gọi `menus\about\about.bat` — 14 file .bat trong `menus/about/`
- `about.bat`: Menu chính About (13 lựa chọn)
- `about_gioithieu.bat`: Giới thiệu chi tiết dự án
- `about_learn.bat`: Hướng dẫn Learn
- `about_makerule.bat`: Hướng dẫn Makerule
- `about_smart.bat`: Hướng dẫn SmartHeading
- `about_format.bat`: Hướng dẫn Format
- `about_clone.bat`: Hướng dẫn Clone
- `about_ai.bat`: Hệ thống AI Provider
- `about_translate.bat`: Hướng dẫn Dịch thuật
- `about_generate.bat`: Hướng dẫn Tạo văn bản
- `about_count.bat`: Hướng dẫn Đếm từ
- `about_initreset.bat`: Hướng dẫn Init/Reset
- `about_tacgia.bat`: Thông tin Tác giả
- `about_troubleshoot.bat`: Xử lý sự cố

Mỗi file about_*.bat có sub-menu: Tổng quan → Cách dùng, Ví dụ, Mẹo, Xử lý lỗi.

### 13.2 Batch rules

- Dùng `goto` thay vì `if/else` block
- **KHÔNG** đặt `goto` bên trong `if/else` `(...)` block — gây crash
- **KHÔNG** dùng `&` trong echo — gây crash
- **KHÔNG** dùng `&` để chain `set` trên 1 dòng — ESC byte gây lỗi parse
- File .bat **KHÔNG** được có UTF-8 BOM (`EF BB BF`) — cmd.exe ăn 4 ký tự đầu, gây lỗi `'ocal' is not recognized`
- Delayed expansion (`!var!`) cho biến trong loop

---

## 14. Công nghệ

| Thư viện | Phiên bản | Mục đích |
|----------|-----------|----------|
| python-docx | ≥ 1.1.0 | Đọc/ghi .docx |
| pywin32 | ≥ 306 | COM API (clone, .doc, page count) |
| PyYAML | ≥ 6.0 | Đọc/ghi rule YAML, AI config |
| pytest | ≥ 7.0 | Unit tests |

**Không thêm dependency mới.** Tất cả AI calls dùng `urllib.request` (stdlib).

---

## 15. Hướng dẫn mở rộng

### Thêm formatter mới
1. Kế thừa `BaseFormatter` (`src/formatters/base.py`)
2. Implement `apply(self, doc, rules) → List[str]`
3. Thêm vào `FormatEngine.formatters` list

### Thêm rule mới
1. Tạo file `.yaml` trong `rules/`

### Plugin
1. Đặt file `.py` trong `src/plugins/`
2. Plugin manager tự động load

---

## 16. Phát triển sau

- [ ] Bulk processing (xử lý nhiều file cùng lúc)
- [ ] GUI (Tkinter / PyQt)
- [ ] Export PDF
- [ ] API server (FastAPI)
- [ ] Progress bar cho clone mode
