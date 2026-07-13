# Hướng dẫn cho Agent

## Cấu trúc dự án
```
fomat_word/
├── run.bat                 # Menu giao diện (5 menu chính, ANSI color)
├── pyproject.toml          # Project config + dependencies
├── requirements.txt        # pip install -r requirements.txt
├── AGENTS.md               # Tài liệu này
├── README.md
│
├── config/
│   └── ai_keys.yaml        # API keys + models cho các AI provider
│
├── mau/                    # File mẫu .doc/.docx cho clone mode
├── outputs/                # File đầu ra mặc định
├── rules/                  # File YAML cấu hình rule
│   ├── default.yaml        # Times New Roman 13, justify, 1.5
│   ├── academic.yaml       # Như default + first_line_indent
│   ├── smart_patterns.yaml # Custom pattern SmartHeading
│   └── learned_rules.yaml  # Tự sinh từ learn command
│
├── src/
│   ├── main.py             # Entry point (sys.path.insert + cli.handler.run)
│   │
│   ├── core/
│   │   ├── engine.py       # FormatEngine + PluginManager
│   │   ├── cloner.py       # CloneEngine - win32com DispatchEx, preview_only
│   │   ├── config.py       # ConfigLoader - đọc YAML, comma-separated
│   │   ├── rules.py        # FormatRule dataclass + rule_from_dict
│   │   ├── learner.py      # StyleLearner - học từ mẫu → YAML
│   │   ├── counter.py      # WordCounter - dem tu, ky tu, dong, trang
│   │   ├── translator.py   # Translator - dich van ban bang AI (batch chunks)
│   │   ├── doc_generator.py# DocGenerator - tao van ban bang AI
│   │   └── ai_config.py    # AI provider CRUD, multi-model, API key check
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
│   │   ├── handler.py      # argparse (10 subcommands) + routing
│   │   ├── maker.py        # Tạo rule thủ công (interactive)
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
    └── test_basic.py       # Unit tests (pytest)
```

## Cách dùng
```bash
pip install -r requirements.txt

# CLI trực tiếp
python src/main.py format input.docx -o output.docx -r rules/default.yaml
python src/main.py format input.docx --dry-run
python src/main.py list-rules
python src/main.py learn template.docx -o rules/my.yaml
python src/main.py clone template.doc target.docx -o output.docx
python src/main.py clone-preview template.doc target.docx
python src/main.py count input.docx
python src/main.py translate input.docx -l en
python src/main.py settings
python src/main.py generate

# Menu giao diện
run.bat

# Tests
python -m pytest tests/ -v
```

## run.bat Menu
- **Menu 1 - Hoc & Cau hinh:** Hoc tu mau, tao rule thu cong, cau hinh SmartHeading
- **Menu 2 - Dinh dang & Clone:** Preview, format (chon rule), format mac dinh, clone, clone-preview
- **Menu 3 - Tien ich:** Danh sach rules, unit tests, dem so tu/trang, dich thuat, tao van ban AI
- **Menu 4 - Cai dat:** Quan ly AI providers (API key, models, custom API, kiem tra)
- **Menu 5 - Thong tin:** About, gioi thieu tung chuc nang

**Luu ý batch:** Dung `goto` thay vi `if/else` block cho flow control. Khong dat `goto` ben trong `if/else` `(...)` block — gay crash cmd.exe tren mot so Windows.

## Subcommands

| Subcommand | Mo ta | Gui can |
|------------|-------|---------|
| `format` | Dinh dang theo rules | Input file, rule file(s) |
| `preview` | Xem truoc (alias format --dry-run) | Input file |
| `list-rules` | Liệt kê rules co san | Khong |
| `learn` | Hoc tu file mau → rule YAML | Template file |
| `clone` | Clone dinh dang tu template | Template + target |
| `clone-preview` | Xem truoc ket qua clone | Template + target |
| `count` | Dem tu, ky tu, dong, trang | Input file |
| `translate` | Dich van ban bang AI | Input file, target lang |
| `settings` | Quan ly AI providers | Khong (interactive) |
| `generate` | Tao van ban Word bang AI | Khong (interactive) |

## Hai che do xu ly

| Che do | Engine | Thu vien | Xu ly duoc |
|--------|--------|----------|-----------|
| Format | FormatEngine | python-docx | Font, spacing, alignment, heading, SmartHeading |
| Clone | CloneEngine | win32com | Section, page setup, header/footer, watermark, TOC, columns, style |

## AI Features

### AI Provider System (`ai_config.py`)
- Multi-model per provider (OpenAI, Gemini, Claude, DeepSeek, Custom API)
- CRUD: them/sua/xoa provider, them/sua/xoa model, chon model hoat dong
- API key check live, status colors (green=valid, yellow=low, red=invalid)
- Config luu tai `config/ai_keys.yaml`
- Provider hoat dong dau tien co key hop le se duoc chon tu dong

### Translate (`translator.py`)
- Batch translation voi chunk 3000 ky tu
- 19 ngon ngu: vi, en, zh, ja, ko, fr, de, es, it, pt, ru, th, id, ms, ar, hi, tr, pl, nl
- Giu nguyen format (font, bold, heading...)
- Individual fallback khi batch mismatch

### Word Counter (`counter.py`)
- Dem: paragraphs, lines, words, chars (co/khong dau cach)
- Trang ước tính + trang thuc te (qua Word COM neu co)
- Thoi gian doc (tieng Viet/Tieng Anh)
- Phat hieu ngon ngu, struct headings

### Document Generator (`doc_generator.py`)
- AI dat cau hoi theo loai van ban (19 loai pho bien)
- Thu thap tra loi tu nguoi dung
- Tao noi dung voi formatting (heading, title, bold, page break)
- Luu thanh .docx

## Quy tac khi code
1. Khong them thu vien moi neu khong can thiet
2. Code moi phai theo pattern cua module tuong tu
3. Luon kiem tra voi `--dry-run` truoc khi format that
4. Bao cao thay doi qua `ChangeReporter`
5. Plugin moi ke thua `BaseFormatter` va dang ky vao `FormatEngine`
6. CLI tools trong `src/cli/` can co `if __name__ == "__main__": run()`
7. ANSI color codes: `ESC[36m`=cyan, `ESC[33m`=yellow, `ESC[32m`=green, `ESC[31m`=red, `ESC[90m`=gray, `ESC[37m`=white, `ESC[0m`=reset
8. Provider hoat dong = provider co `api_key` + `status` in (VALID, UNCHECKED)
9. `p.model` la property (khong phai field) — tra ve model dang active

## Test
```bash
python -m pytest tests/ -v --no-header --override-ini="addopts="
```
7 tests: rule parsing, conditions, config loader, engine init.
