import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", ".."))

from src.core.doc_generator import (
    ask_ai_questions,
    generate_document_content,
    save_as_docx,
)
from src.core.ai_config import get_active_provider, get_provider_status_color, get_provider_status_label

ESC = "\033"
CYA = f"{ESC}[36m"
YLW = f"{ESC}[33m"
GRN = f"{ESC}[32m"
RED = f"{ESC}[31m"
GRY = f"{ESC}[90m"
WHT = f"{ESC}[37m"
BLD = f"{ESC}[1m"
RST = f"{ESC}[0m"


DOC_TYPE_EXAMPLES = [
    "Don xin nghi phep",
    "Don xin viec",
    "Don xin doi lop",
    "Don xin cap bang",
    "Thu cam on",
    "Thu xin phep",
    "Bao cao thuc tap",
    "Luan van tot nghiep",
    "Phieu danh gia",
    "Quyet dinh bo nhiem",
    "Cong van",
    "Bien ban hop",
    "Ho so ung tuyen",
    "Thu moi hop",
    "Don khiem nay",
]


def run():
    os.system("cls" if os.name == "nt" else "clear")
    print()
    print(f"{CYA}  ============================================{RST}")
    print(f"{CYA}{BLD}     TAO VAN BAN BANG AI                      {RST}")
    print(f"{CYA}  ============================================{RST}")
    print()
    print(f"  {GRY}Nhap loai van ban, AI se hoi ban cac cau hoi")
    print(f"  de thu thap thong tin, sau do tao van ban.{RST}")
    print()

    provider = get_active_provider()
    if not provider:
        print(f"  {RED}[CANH BAO]{RST} Chua co AI provider hoat dong.")
        print(f"  {GRY}Vao Settings (5) de cai dat API key truoc.{RST}")
        print()
        input(f"  {GRY}Enter de quay lai...{RST}")
        return

    color = get_provider_status_color(provider.status)
    print(f"  {GRY}AI Provider:{RST} {color}{provider.display_name}{RST} ({provider.model})")
    print()
    print(f"  {CYA}Cac loai van ban pho bien:{RST}")
    for i, dt in enumerate(DOC_TYPE_EXAMPLES, 1):
        print(f"    {YLW}{i:>2}.{RST} {dt}")
    print()

    doc_type = input(f"  {CYA}Nhap loai van ban can tao: {RST}").strip()
    if not doc_type:
        print(f"  {RED}[LOI]{RST} Chua nhap loai van ban.")
        input(f"\n  {GRY}Enter de quay lai...{RST}")
        return

    print()
    print(f"  {GRY}Dang hoi AI cau hoi...{RST}")

    try:
        questions = ask_ai_questions(doc_type, provider)
    except Exception as e:
        print(f"\n  {RED}[LOI]{RST} Khong the ket noi AI: {e}")
        input(f"\n  {GRY}Enter de quay lai...{RST}")
        return

    if not questions:
        print(f"  {RED}[LOI]{RST} AI khong tra ve cau hoi nao.")
        input(f"\n  {GRY}Enter de quay lai...{RST}")
        return

    print(f"\n  {GRN}AI da dat {len(questions)} cau hoi.{RST}")
    print(f"  {GRY}Hay tra loi day du de van ban dung noi dung.{RST}")
    print(f"  {GRY}De trong = bo qua cau hoi do.{RST}")
    print()

    for q in questions:
        print(f"  {CYA}Cau hoi {q.id}:{RST} {q.text}")
        if q.hint:
            print(f"  {GRY}  Goi y: {q.hint}{RST}")
        answer = input(f"  {YLW}Tra loi: {RST}").strip()
        q.answer = answer
        print()

    answered = [q for q in questions if q.answer]
    if not answered:
        print(f"  {RED}[LOI]{RST} Ban chua tra loi cau hoi nao.")
        input(f"\n  {GRY}Enter de quay lai...{RST}")
        return

    print(f"  {GRY}Da nhan {len(answered)}/{len(questions)} tra loi.{RST}")
    print(f"  {GRY}Dang tao van ban...{RST}")
    print()

    try:
        title, content = generate_document_content(doc_type, questions, provider)
    except Exception as e:
        print(f"  {RED}[LOI]{RST} Khong the tao noi dung: {e}")
        input(f"\n  {GRY}Enter de quay lai...{RST}")
        return

    print(f"  {CYA}--- XEM TRUOC NOI DUNG ---{RST}")
    print()
    preview_lines = content.split("\n")[:30]
    for line in preview_lines:
        if line.startswith("##"):
            print(f"  {CYA}{line}{RST}")
        elif line.startswith("#"):
            print(f"  {BLD}{line}{RST}")
        elif line.strip():
            print(f"  {line}")
    if len(content.split("\n")) > 30:
        print(f"  {GRY}... (con nhieu noi dung hon){RST}")
    print()

    safe_name = "".join(c if c.isalnum() or c in " _-" else "_" for c in title)
    safe_name = safe_name.strip().replace(" ", "_")[:50]
    default_output = os.path.join("outputs", f"{safe_name}.docx")

    output = input(f"  {YLW}File dau ra (Enter = {default_output}): {RST}").strip()
    if not output:
        output = default_output

    try:
        result_path = save_as_docx(title, content, output)
        print(f"\n  {CYA}{'=' * 46}{RST}")
        print(f"  {CYA}{BLD}  TAO VAN BAN THANH CONG!{RST}")
        print(f"  {CYA}{'=' * 46}{RST}")
        print()
        print(f"  {GRY}Tieu de:{RST} {WHT}{title}{RST}")
        print(f"  {GRY}Cau hoi da tra loi:{RST} {WHT}{len(answered)}{RST}")
        print(f"  {GRY}File:{RST} {WHT}{result_path}{RST}")
        print()

        open_file = input(f"  {YLW}Mo file ngay? (Y/n): {RST}").strip().lower()
        if open_file != "n":
            os.startfile(result_path)

    except Exception as e:
        print(f"  {RED}[LOI]{RST} Khong the tao file: {e}")

    print()
    input(f"  {GRY}Enter de quay lai...{RST}")


if __name__ == "__main__":
    run()
