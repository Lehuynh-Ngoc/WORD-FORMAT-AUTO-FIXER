import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", ".."))

from src.core.translator import translate_document, get_supported_languages, LANGUAGES
from src.core.ai_config import get_all_providers, get_active_provider, get_provider_status_color, get_provider_status_label

ESC = "\033"
CYA = f"{ESC}[36m"
YLW = f"{ESC}[33m"
GRN = f"{ESC}[32m"
RED = f"{ESC}[31m"
GRY = f"{ESC}[90m"
WHT = f"{ESC}[37m"
BLD = f"{ESC}[1m"
RST = f"{ESC}[0m"


def show_languages():
    langs = get_supported_languages()
    print()
    print(f"  {YLW}{'STT':<5} {'Ma':<6} {'Ten ngon ngu':<20}{RST}")
    print(f"  {YLW}{'---':<5} {'--':<6} {'---------------':<20}{RST}")
    for i, (code, name) in enumerate(langs.items(), 1):
        print(f"  {WHT}{i:<5}{RST} {code:<6} {name}")


def run():
    os.system("cls" if os.name == "nt" else "clear")
    print()
    print(f"{CYA}  ============================================{RST}")
    print(f"{CYA}{BLD}     DICH THUAT FILE WORD                      {RST}")
    print(f"{CYA}  ============================================{RST}")
    print()

    provider = get_active_provider()
    if provider:
        color = get_provider_status_color(provider.status)
        print(f"  {GRY}AI Provider hien tai:{RST} {color}{provider.display_name}{RST}")
        print(f"  {GRY}Model:{RST} {provider.model}")
    else:
        print(f"  {RED}[CANH BAO]{RST} Chua co AI provider hoat dong.")
        print(f"  {GRY}Vao Settings (4) de cai dat API key truoc.{RST}")
        print()

    filepath = input(f"\n  {YLW}Nhap duong dan file Word can dich: {RST}").strip()
    if not filepath:
        print(f"  {RED}[LOI]{RST} Chua nhap duong dan.")
        return
    if not os.path.exists(filepath):
        print(f"  {RED}[LOI]{RST} Khong tim thay file: {filepath}")
        return

    show_languages()
    lang_choice = input(f"\n  {YLW}Chon ngon ngu dich (ma, vd: en, vi, zh): {RST}").strip().lower()
    if not lang_choice:
        print(f"  {RED}[LOI]{RST} Chua chon ngon ngu.")
        return
    if lang_choice not in LANGUAGES:
        print(f"  {RED}[LOI]{RST} Ngon ngu '{lang_choice}' khong ho tro.")
        print(f"  {GRY}Nhap lai ma ngon ngu: en, vi, zh, ja, ko, fr, de, es...{RST}")
        return

    source_choice = input(f"  {YLW}Ngon ngu nguon (Enter = tu dong detect): {RST}").strip().lower()
    if source_choice and source_choice not in LANGUAGES:
        print(f"  {RED}[LOI]{RST} Ngon ngu '{source_choice}' khong ho tro.")
        return

    output = os.path.splitext(filepath)[0] + f"_{lang_choice}.docx"
    out_input = input(f"  {YLW}File dau ra (Enter = {os.path.basename(output)}): {RST}").strip()
    if out_input:
        output = out_input

    print()
    print(f"  {GRY}File:{RST} {WHT}{filepath}{RST}")
    print(f"  {GRY}Dich sang:{RST} {WHT}{LANGUAGES.get(lang_choice, lang_choice)}{RST}")
    if source_choice:
        print(f"  {GRY}Nguon:{RST} {WHT}{LANGUAGES.get(source_choice, source_choice)}{RST}")
    else:
        print(f"  {GRY}Nguon:{RST} {WHT}Tu dong detect{RST}")
    print(f"  {GRY}Output:{RST} {WHT}{output}{RST}")
    print()
    print(f"  {YLW}Dang dich... (vui long cho, co the mat vai phut){RST}")
    print()

    try:
        result = translate_document(
            input_path=filepath,
            output_path=output,
            target_lang=lang_choice,
            source_lang=source_choice or "",
        )
        print(f"  {CYA}{'=' * 46}{RST}")
        print(f"  {CYA}{BLD}  DICH THANH CONG!{RST}")
        print(f"  {CYA}{'=' * 46}{RST}")
        print()
        print(f"  {GRY}Da dich:{RST} {WHT}{result.translated_paragraphs}{RST}/{result.total_paragraphs} doan")
        if result.skipped_paragraphs > 0:
            print(f"  {GRY}Bo qua:{RST} {result.skipped_paragraphs} doan trong")
        if result.errors > 0:
            print(f"  {RED}Loi:{RST} {result.errors} doan")
        print(f"  {GRY}File:{RST} {WHT}{result.output_path}{RST}")
        print()

    except ValueError as e:
        print(f"  {RED}[LOI]{RST} {e}")
    except Exception as e:
        print(f"  {RED}[LOI]{RST} Dich that bai: {e}")

    print()
    input(f"  {GRY}Enter de quay lai...{RST}")


if __name__ == "__main__":
    run()
