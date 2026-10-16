import argparse
import os
import sys


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="wordfix",
        description="Word Format Auto-Fixer - CLI tool định dạng file Word",
    )
    parser.add_argument(
        "-v", "--verbose",
        action="store_true",
        help="Hiển thị log chi tiết",
    )

    sub = parser.add_subparsers(dest="command", required=True)

    fmt = sub.add_parser("format", help="Định dạng file Word theo rules")
    fmt.add_argument("input", help="Đường dẫn file .doc hoặc .docx đầu vào")
    fmt.add_argument("-o", "--output", help="Đường dẫn file đầu ra (mặc định: input_formatted.ext)")
    fmt.add_argument(
        "-r", "--rules",
        default="default.yaml",
        help="File rules YAML (mặc định: default.yaml)",
    )
    fmt.add_argument(
        "--dry-run",
        action="store_true",
        help="Preview thay đổi mà không ghi file",
    )

    ls = sub.add_parser("list-rules", help="Liệt kê các file rules có sẵn")

    prev = sub.add_parser("preview", help="Xem trước thay đổi (alias format --dry-run)")
    prev.add_argument("input", help="Đường dẫn file Word")
    prev.add_argument("-r", "--rules", default="default.yaml", help="File rules YAML")

    learn = sub.add_parser("learn", help="Học formatting từ file mẫu, tạo rule YAML")
    learn.add_argument("template", help="Đường dẫn file .doc/.docx mẫu đã format chuẩn")
    learn.add_argument("-o", "--output", help="Đường dẫn file rules YAML đầu ra (mặc định: rules/{template}_rules.yaml)")

    clone = sub.add_parser("clone", help="Clone toàn bộ định dạng từ template sang target (section, page setup, header/footer, watermark, style...)")
    clone.add_argument("template", help="File mẫu đã format chuẩn (.doc/.docx)")
    clone.add_argument("target", help="File cần áp dụng định dạng (.doc/.docx)")
    clone.add_argument("-o", "--output", help="Đường dẫn file đầu ra (mặc định: target_cloned.ext)")

    clone_prev = sub.add_parser("clone-preview", help="Xem trước kết quả clone — mở Word cho bạn xem, rồi hỏi có lưu không")
    clone_prev.add_argument("template", help="File mẫu đã format chuẩn (.doc/.docx)")
    clone_prev.add_argument("target", help="File cần áp dụng định dạng (.doc/.docx)")
    clone_prev.add_argument("-o", "--output", help="Đường dẫn file lưu (mặc định: target_cloned.ext)")

    cnt = sub.add_parser("count", help="Dem so tu, ky tu, dong, trang cua file Word")
    cnt.add_argument("input", help="Duong dan file Word (.doc/.docx)")
    cnt.add_argument("-o", "--output", help="Luu ket qua ra file (mac dinh: khong luu)")

    trl = sub.add_parser("translate", help="Dich toan bo noi dung file Word sang ngon ngu khac")
    trl.add_argument("input", help="Duong dan file Word can dich")
    trl.add_argument("-l", "--lang", required=True, help="Ma ngon ngu dich (vi, en, zh, ja, ko, fr, de, es...)")
    trl.add_argument("-s", "--source", default="", help="Ma ngon ngu nguon (Enter = tu dong detect)")
    trl.add_argument("-o", "--output", help="Duong dan file dau ra")
    trl.add_argument("-p", "--provider", default="", help="AI provider (openai, gemini, claude, deepseek, custom)")

    settings = sub.add_parser("settings", help="Cai dat API keys cho cac AI provider")

    gen = sub.add_parser("generate", help="Tao van ban Word bang AI — AI hoi cau hoi, ban tra loi, AI tao van ban")
    gen.add_argument("-o", "--output", help="Duong dan file dau ra")

    sub.add_parser("init", help="Khoi tao du an — tao thu muc, copy config mac dinh")
    reset = sub.add_parser("reset", help="Reset ve trang thai mac dinh — xoa API keys, rules hoc, file dau ra")
    reset.add_argument(
        "-y", "--yes",
        action="store_true",
        help="Xac nhan tu dong, khong hoi nua",
    )

    return parser


def run(args_list: list = None):
    from src.utils.logger import setup_logger
    from src.core.config import ConfigLoader
    from src.core.engine import FormatEngine

    # Console cp1252 (Windows) khong encode duoc tieng Viet -> thay the ky tu la loi
    for stream in (sys.stdout, sys.stderr):
        try:
            if stream and stream.encoding and stream.encoding.lower().replace("-", "") != "utf8":
                stream.reconfigure(errors="replace")
        except Exception:
            pass

    parser = build_parser()
    args = parser.parse_args(args_list)
    logger = setup_logger(verbose=args.verbose)

    if args.command == "list-rules":
        cl = ConfigLoader()
        rules = cl.list_rule_files()
        if not rules:
            logger.info("No rule files found in rules/ directory.")
        else:
            logger.info("Available rule files:")
            for r in rules:
                logger.info(f"  - {r}")
        return

    if args.command == "learn":
        from src.core.learner import StyleLearner

        if not os.path.exists(args.template):
            logger.error(f"Template file not found: {args.template}")
            sys.exit(1)

        logger.info(f"Learning formatting from: {args.template}")
        learner = StyleLearner()
        output_path, count = learner.learn_to_yaml(args.template, args.output)
        logger.info(f"Learned {count} style rules")
        logger.info(f"Saved to: {output_path}")
        logger.info("Use: python src/main.py format input.docx -r " + os.path.basename(output_path))
        return

    if args.command == "clone":
        from src.core.cloner import CloneEngine

        if not os.path.exists(args.template):
            logger.error(f"Template file not found: {args.template}")
            sys.exit(1)
        if not os.path.exists(args.target):
            logger.error(f"Target file not found: {args.target}")
            sys.exit(1)

        output = args.output
        if not output:
            base, ext = os.path.splitext(args.target)
            output = f"{base}_cloned{ext}"

        if output == args.target:
            logger.error("Output cannot be the same as target. Use -o to specify different path.")
            sys.exit(1)

        logger.info(f"Template: {args.template}")
        logger.info(f"Target: {args.target}")
        logger.info(f"Output: {output}")
        logger.info("Cloning formatting... (this may take a moment)")

        try:
            engine = CloneEngine()
            result = engine.clone(args.template, args.target, output)
            logger.info(f"Done! File saved to: {result}")
        except RuntimeError as e:
            logger.error(str(e))
            sys.exit(1)
        except Exception as e:
            logger.error(f"Clone failed: {e}")
            if args.verbose:
                import traceback
                traceback.print_exc()
            sys.exit(1)
        return

    if args.command == "clone-preview":
        from src.core.cloner import CloneEngine
        import shutil

        if not os.path.exists(args.template):
            logger.error(f"Template file not found: {args.template}")
            sys.exit(1)
        if not os.path.exists(args.target):
            logger.error(f"Target file not found: {args.target}")
            sys.exit(1)

        output = args.output
        if not output:
            base, ext = os.path.splitext(args.target)
            output = f"{base}_cloned{ext}"

        logger.info(f"Template: {args.template}")
        logger.info(f"Target: {args.target}")
        logger.info("Opening preview in Word... (review the document, then close Word)")

        try:
            engine = CloneEngine()
            preview_path = engine.clone(args.template, args.target, output, preview_only=True)
            print()
            print(f"  Preview file: {preview_path}")
            print(f"  Word is now open. Review the result, then close Word.")
            print()

            input("  Press Enter after closing Word to continue...")

            save = input(f"  Save this result to '{output}'? (y/N): ").strip().lower()
            if save in ("y", "yes"):
                shutil.copy2(preview_path, output)
                logger.info(f"Saved to: {output}")
            else:
                logger.info("Discarded preview. No file saved.")

            try:
                os.remove(preview_path)
                os.rmdir(os.path.dirname(preview_path))
            except OSError:
                pass

        except RuntimeError as e:
            logger.error(str(e))
            sys.exit(1)
        except Exception as e:
            logger.error(f"Clone preview failed: {e}")
            if args.verbose:
                import traceback
                traceback.print_exc()
            sys.exit(1)
        return

    if args.command == "count":
        from src.core.counter import count_document

        if not os.path.exists(args.input):
            logger.error(f"Input file not found: {args.input}")
            sys.exit(1)

        logger.info(f"Counting: {args.input}")
        try:
            result = count_document(args.input)
            print("\n" + result.summary())
            if args.output:
                with open(args.output, "w", encoding="utf-8") as f:
                    f.write(result.summary())
                logger.info(f"Saved stats to: {args.output}")
        except Exception as e:
            logger.error(f"Count failed: {e}")
            sys.exit(1)
        return

    if args.command == "translate":
        from src.core.translator import translate_document, LANGUAGES

        if not os.path.exists(args.input):
            logger.error(f"Input file not found: {args.input}")
            sys.exit(1)

        if args.lang not in LANGUAGES:
            logger.error(f"Unsupported language: {args.lang}")
            logger.info(f"Supported: {', '.join(LANGUAGES.keys())}")
            sys.exit(1)

        output = args.output
        if not output:
            base, ext = os.path.splitext(args.input)
            output = f"{base}_{args.lang}{ext}"

        logger.info(f"Translating: {args.input}")
        logger.info(f"Target language: {LANGUAGES.get(args.lang, args.lang)}")
        logger.info(f"Output: {output}")

        try:
            result = translate_document(
                input_path=args.input,
                output_path=output,
                target_lang=args.lang,
                source_lang=args.source,
                provider_name=args.provider,
            )
            logger.info(f"Translated {result.translated_paragraphs}/{result.total_paragraphs} paragraphs")
            logger.info(f"Saved to: {result.output_path}")
        except ValueError as e:
            logger.error(str(e))
            sys.exit(1)
        except Exception as e:
            logger.error(f"Translation failed: {e}")
            if args.verbose:
                import traceback
                traceback.print_exc()
            sys.exit(1)
        return

    if args.command == "settings":
        from src.cli.settings_cli import run as settings_run
        settings_run()
        return

    if args.command == "generate":
        from src.cli.doc_generator_cli import run as generate_run
        generate_run()
        return

    if args.command == "init":
        from src.core.init_reset import init_project
        dirs, files = init_project()
        if not dirs and not files:
            logger.info("Du an da duoc khoi tao day du.")
        else:
            for d in dirs:
                logger.info(f"Tao thu muc: {d}/")
            for f in files:
                logger.info(f"Tao file: {f}")
            logger.info("Khoi tao hoan tat!")
        return

    if args.command == "reset":
        from src.core.init_reset import reset_project, _abs
        import glob as _glob

        will_delete = []
        for pattern in [
            "config/ai_keys.yaml",
            "outputs/*",
            "rules/learned_rules.yaml",
            "rules/custom_rules.yaml",
            "rules/smart_patterns.yaml",
        ]:
            for match in _glob.glob(_abs(pattern)):
                if os.path.isfile(match):
                    will_delete.append(os.path.relpath(match))

        if not will_delete:
            logger.info("Khong co gi de reset.")
            return

        logger.warning("=== RESET DU AN — cac file se bi XOA ===")
        for f in will_delete:
            logger.warning(f"  - {f}")

        if not args.yes:
            confirm = input("  Xac nhan reset? (y/N): ").strip().lower()
            if confirm not in ("y", "yes"):
                logger.info("Huy reset. Khong co gi thay doi.")
                return

        deleted, kept = reset_project()
        logger.info("=== RESET DU AN ===")
        for f in deleted:
            logger.info(f"Xoa: {f}")
        logger.info(f"Giu nguyen: {', '.join(kept)}")
        logger.info("Reset hoan tat! Chay 'init' neu can khoi tao lai.")
        return

    if args.command == "preview":
        args.dry_run = True
        args.output = None

    if not os.path.exists(args.input):
        logger.error(f"Input file not found: {args.input}")
        sys.exit(1)

    output = args.output
    if not output:
        base, ext = os.path.splitext(args.input)
        output = f"{base}_formatted{ext}"

    if output == args.input and not args.dry_run:
        logger.error("Output cannot be the same as input. Use -o to specify a different path.")
        sys.exit(1)

    logger.info(f"Loading rules: {args.rules}")
    cl = ConfigLoader()
    try:
        rules = cl.load_rules(args.rules)
    except FileNotFoundError as e:
        logger.error(str(e))
        sys.exit(1)
    logger.info(f"Loaded {len(rules)} rules")

    engine = FormatEngine()
    if args.verbose:
        logger.info(f"Formatters: {[type(f).__name__ for f in engine.formatters]}")

    logger.info(f"Reading: {args.input}")
    if args.dry_run:
        logger.info("Mode: DRY RUN (no file will be written)")
    else:
        logger.info(f"Output: {output}")

    try:
        reporter = engine.format(args.input, output, rules, dry_run=args.dry_run)
    except Exception as e:
        logger.error(f"Format failed: {e}")
        if args.verbose:
            import traceback
            traceback.print_exc()
        sys.exit(1)

    print("\n" + reporter.summary())

    if args.dry_run and reporter.has_changes:
        logger.info(f"Use 'format' command to apply {reporter.total_changes} changes.")
