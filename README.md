# Word Format Auto-Fixer (wordfix)

CLI tool tự động định dạng file Word (.doc/.docx) theo rule YAML, clone từ file mẫu, đếm từ, dịch thuật, và tạo văn bản bằng AI.  
Chạy trên Windows, cần Python 3.10+ và Microsoft Word (cho clone mode).

## Cài đặt

```bash
pip install -r requirements.txt
```

## Dùng nhanh

### Menu tương tác
```bash
run.bat
```
- **Menu 1:** Học từ mẫu, tạo rule thủ công, cấu hình SmartHeading
- **Menu 2:** Preview, format, clone, clone-preview
- **Menu 3:** Danh sách rules, tests, đếm từ/trang, dịch thuật, tạo văn bản AI
- **Menu 4:** Quản lý AI providers (API key, models, custom API), Init/Reset project
- **Menu 5:** Thông tin (14 trang百科 về từng chức năng)

### CLI

```bash
# Định dạng
python src/main.py format "input.docx" -o outputs/output.docx -r rules/default.yaml
python src/main.py format "input.docx" --dry-run
python src/main.py format "input.docx" -r "rules/default.yaml,rules/smart_patterns.yaml"

# Clone toàn bộ định dạng
python src/main.py clone "file_mau.doc" "input.docx" -o outputs/output.docx
python src/main.py clone-preview "file_mau.doc" "input.docx"

# Học từ file mẫu → rule YAML
python src/main.py learn "mau.docx" -o rules/my_rules.yaml

# Đếm từ, ký tự, dòng, trang
python src/main.py count "input.docx"

# Dịch file Word sang ngôn ngữ khác (19 ngôn ngữ)
python src/main.py translate "input.docx" -l en
python src/main.py translate "input.docx" -l zh -o outputs/translated.docx

# Tạo văn bản Word bằng AI
python src/main.py generate

# Quản lý AI providers
python src/main.py settings

# Khởi tạo project mới
python src/main.py init

# Reset project về mặc định
python src/main.py reset
```

## AI Features

### Quản lý AI Provider

Hỗ trợ 5 provider: **OpenAI, Google Gemini, Anthropic Claude, DeepSeek, Custom API**.

```bash
python src/main.py settings
```

Mỗi provider có:
- Nhiều model, chọn model hoạt động
- API key + base URL riêng
- Kiểm tra key live (green=valid, yellow=low, red=invalid)
- Custom API: tự thêm/xóa provider tuỳ ý

### Dịch thuật

```bash
python src/main.py translate "input.docx" -l en
```
- 19 ngôn ngữ: vi, en, zh, ja, ko, fr, de, es, it, pt, ru, th, id, ms, ar, hi, tr, pl, nl
- Batch translation (3000 chars/chunk), giữ nguyên format

### Đếm từ

```bash
python src/main.py count "input.docx"
```
- Paragraphs, lines, words, characters (có/không dấu cách)
- Số trang ước tính + thực tế (qua Word COM)
- Thời gian đọc (tiếng Việt/Tiếng Anh)

### Tạo văn bản AI

```bash
python src/main.py generate
```
- Nhập loại văn bản → AI đặt câu hỏi → thu thập thông tin → tạo file .docx
- 19 loại văn bản phổ biến: đơn xin việc, báo cáo thực tập, quyết định...

## Rule YAML

```yaml
rules:
  - name: "Normal text"
    target: paragraph
    conditions:
      style: "Normal"
      text_contains: "mục"
      pattern: "^MỤC\\s+\\d+"
    actions:
      font:
        name: "Times New Roman"
        size: 13
      paragraph:
        alignment: "justify"
        line_spacing: 1.5
    heading:
      level: 2
```

**Điều kiện:** `style`, `text_contains`, `pattern` (regex).  
**HeadingAction:** `level` (int) hoặc `style` (str - bất kỳ style nào).  
**Custom patterns** (qua `smart_config.py`) chạy trước built-in patterns.

## SmartHeading - tự động phát hiện tiêu đề

| Pattern | Style |
|---------|-------|
| CHƯƠNG/Chương + số | Heading 1 |
| 1.1, 2.1 | Heading 2 |
| 1.1.1, 2.1.3 | Heading 3 |
| KẾT LUẬN, TÀI LIỆU THAM KHẢO, MỤC LỤC... | Heading 1 |
| BÁO CÁO..., LUẬN VĂN..., ĐỒ ÁN... | Title |
| Ngành:, GVHD:, SVTH:... | Subtitle |

## Clone mode

Clone toàn bộ định dạng từ template sang target qua win32com:

- Section, page setup, header/footer, watermark
- TOC, columns, page numbering, style definitions
- Clone-preview: xem trước trước khi lưu
- Retry logic khi Word bận (RPC_E_CALL_REJECTED)

## Cấu trúc thư mục

```
fomat_word/
├── run.bat                 # Menu giao diện (5 menu)
├── config/
│   └── ai_keys.yaml        # API keys + models
├── mau/                    # File mẫu cho clone
├── outputs/                # File đầu ra
├── rules/                  # File YAML rule
│   ├── default.yaml        # Times New Roman 13, justify, 1.5
│   ├── academic.yaml       # Như default + thụt đầu dòng
│   ├── smart_patterns.yaml # Pattern do người dùng tạo
│   └── learned_rules.yaml  # Tự sinh từ learn command
├── menus/
│   └── about/              # Menu 5 - Thông tin (14 file .bat)
│       ├── about.bat       # Menu chính About
│       └── about_*.bat     # 13 trang百科 (gioithieu, learn, makerule...)
├── src/
│   ├── main.py             # Entry point
│   ├── core/
│   │   ├── engine.py       # FormatEngine (python-docx)
│   │   ├── cloner.py       # CloneEngine (win32com)
│   │   ├── config.py       # ConfigLoader
│   │   ├── rules.py        # FormatRule dataclass
│   │   ├── learner.py      # Học từ file mẫu
│   │   ├── counter.py      # Đếm từ/trang
│   │   ├── translator.py   # Dịch file Word bằng AI
│   │   ├── doc_generator.py# Tạo văn bản bằng AI
│   │   ├── ai_config.py    # Quản lý AI providers
│   │   └── init_reset.py   # Init/reset project
│   ├── parsers/
│   │   ├── base.py, docx_parser.py, doc_parser.py, factory.py
│   ├── formatters/
│   │   ├── base.py, font.py, spacing.py, alignment.py
│   │   ├── heading.py, smart_heading.py
│   ├── cli/
│   │   ├── handler.py      # CLI argparse (12 subcommands)
│   │   ├── maker.py        # Tạo rule tương tác
│   │   ├── rule_viewer.py  # Xem danh sách rules
│   │   ├── smart_config.py # Cấu hình SmartHeading
│   │   ├── counter_cli.py  # Giao diện đếm từ
│   │   ├── translator_cli.py # Giao diện dịch thuật
│   │   ├── doc_generator_cli.py # Giao diện tạo văn bản AI
│   │   └── settings_cli.py # Quản lý AI providers
│   ├── utils/
│   │   ├── logger.py, reporter.py
│   └── plugins/
│       └── manager.py
└── tests/test_basic.py     # Unit tests (7 tests)
```

## Luồng xử lý

**Format:** Input → Parser → Engine load rules → Formatter áp dụng → Parser ghi file → Reporter

**Clone:** Template + Target → Copy template → Word process riêng → Xoá nội dung → Paste target → SaveAs

**Dịch:** Input → Parser → Translator (AI batch 3000 chars, giữ format) → Parser ghi file

**Tạo văn bản:** User nhập loại → AI đặt câu hỏi → Thu thập thông tin → AI tạo nội dung → Save as .docx
