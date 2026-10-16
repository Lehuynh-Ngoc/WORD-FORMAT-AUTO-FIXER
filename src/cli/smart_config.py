import os
import re
import yaml

ESC = "\033"
CYA = f"{ESC}[36m"
YLW = f"{ESC}[33m"
GRN = f"{ESC}[32m"
RED = f"{ESC}[31m"
GRY = f"{ESC}[90m"
WHT = f"{ESC}[37m"
BLD = f"{ESC}[1m"
RST = f"{ESC}[0m"

CONFIG_DIR = os.path.join(os.path.dirname(__file__), "..", "..", "rules")
CONFIG_FILE = os.path.join(CONFIG_DIR, "smart_patterns.yaml")

BUILTIN_EXAMPLES = [
    ("^Bai\\s+\\d+", "Heading 2", "Bai hoc (VD: Bai 1, Bai 2...)"),
    ("^(CHUONG|Chuong)\\s+\\d+", "Heading 1", "Chuong tieng Viet"),
    ("^(GVHD|CBHD)\\s*:", "Subtitle", "Giao vien huong dan"),
    ("^(MSSV|Ma so sinh vien)\\s*:", "Subtitle", "Ma so sinh vien"),
]


def load_patterns():
    if not os.path.exists(CONFIG_FILE):
        return []
    with open(CONFIG_FILE, encoding="utf-8") as f:
        data = yaml.safe_load(f)
    if not data or "rules" not in data:
        return []
    result = []
    for r in data["rules"]:
        result.append({
            "name": r.get("name", ""),
            "pattern": r.get("conditions", {}).get("pattern", ""),
            "style": r.get("heading", {}).get("style", f"Heading {r.get('heading', {}).get('level', '')}"),
        })
    return result


def save_patterns(patterns):
    rules = []
    for p in patterns:
        style = p["style"]
        rule = {
            "name": p["name"],
            "conditions": {"pattern": p["pattern"]},
        }
        if style.startswith("Heading "):
            try:
                rule["heading"] = {"level": int(style.split()[-1])}
            except ValueError:
                rule["heading"] = {"style": style}
        else:
            rule["heading"] = {"style": style}
        rules.append(rule)

    os.makedirs(CONFIG_DIR, exist_ok=True)
    with open(CONFIG_FILE, "w", encoding="utf-8") as f:
        yaml.dump({"rules": rules}, f, allow_unicode=True, default_flow_style=False)
    print(f"  {GRN}[OK]{RST} Da luu {WHT}{len(patterns)}{RST} pattern vao {GRY}{CONFIG_FILE}{RST}")


def show_patterns(patterns):
    if not patterns:
        print(f"  {GRY}(khong co pattern nao){RST}")
        return
    print(f"  {YLW}{'STT':<5} {'Pattern regex':<40} {'Target style':<20}{RST}")
    print(f"  {GRY}{'---':<5} {'-------------':<40} {'------------':<20}{RST}")
    for i, p in enumerate(patterns, 1):
        pat = p["pattern"][:38] + ".." if len(p["pattern"]) > 38 else p["pattern"]
        print(f"  {WHT}{i:<5}{RST} {pat:<40} {CYA}{p['style']:<20}{RST}")


def add_pattern(patterns):
    print()
    pat = input(f"  {CYA}Pattern regex{RST}: ").strip()
    if not pat:
        print(f"  {RED}[LOI]{RST} Pattern khong duoc de trong")
        return

    try:
        re.compile(pat)
    except re.error as e:
        print(f"  {RED}[LOI]{RST} Regex khong hop le: {e}")
        return

    style = input(f"  {CYA}Target style{RST} {GRY}(Heading 1, Title, Subtitle...){RST}: ").strip()
    if not style:
        print(f"  {RED}[LOI]{RST} Style khong duoc de trong")
        return

    name = input(f"  {CYA}Mo ta{RST} {GRY}(Enter = tu dong){RST}: ").strip()
    if not name:
        name = f"Detect: {pat[:30]} -> {style}"

    patterns.append({"name": name, "pattern": pat, "style": style})
    print(f"  {GRN}[OK]{RST} Da them: {WHT}{pat}{RST} -> {CYA}{style}{RST}")


def remove_pattern(patterns):
    if not patterns:
        print(f"  {RED}[LOI]{RST} Khong co pattern nao de xoa")
        return

    show_patterns(patterns)
    print()
    try:
        idx = int(input(f"  {YLW}Nhap STT can xoa{RST} {GRY}(0 = huy){RST}: "))
    except ValueError:
        return
    if idx == 0:
        return
    if 1 <= idx <= len(patterns):
        removed = patterns.pop(idx - 1)
        print(f"  {GRN}[OK]{RST} Da xoa: {WHT}{removed['pattern']}{RST}")
    else:
        print(f"  {RED}[LOI]{RST} STT khong hop le")


def run():
    patterns = load_patterns()

    while True:
        os.system("cls" if os.name == "nt" else "clear")
        print()
        print(f"{CYA}  ============================================{RST}")
        print(f"{CYA}{BLD}     CAU HINH SMARTHEADING DETECTION          {RST}")
        print(f"{CYA}  ============================================{RST}")
        print(f"  Them pattern de {GRY}tu dong phat hien tieu de{RST}")
        print(f"  bang regex va gan style mong muon.")
        print()
        print(f"  {CYA}Pattern hien tai:{RST}")
        show_patterns(patterns)
        print()
        print(f"  {GRY}--------------------------------------------{RST}")
        print(f"  {YLW}1.{RST} Xem built-in patterns {GRY}co san{RST}")
        print(f"  {YLW}2.{RST} Them pattern moi")
        print(f"  {YLW}3.{RST} Xoa pattern")
        print(f"  {YLW}4.{RST} Xem vi du pattern mau")
        print(f"  {YLW}5.{RST} Luu & chay preview")
        print(f"  {RED}0.{RST} Quay lai")
        print(f"  {GRY}--------------------------------------------{RST}")
        print()
        choice = input(f"  {YLW}Nhap so (0-5): {RST}").strip()

        if choice == "1":
            print()
            print(f"  {CYA}Built-in patterns{RST} {GRY}(khong the sua):{RST}")
            print(f"  {YLW}Pattern{RST}                                    {YLW}Style{RST}")
            print(f"  {GRY}-------{RST}                                    {GRY}-----{RST}")
            print(f"  {WHT}CHUONG/Chuong 1, PHAN 1 ...{RST}      -> {CYA}Heading 1{RST}")
            print(f"  {WHT}Muc luc, Tai lieu tham khao ...{RST}   -> {CYA}Heading 1{RST}")
            print(f"  {WHT}Ket luan, Loi mo dau ...{RST}          -> {CYA}Heading 1{RST}")
            print(f"  {WHT}1.1, 1.2, 2.1 ...{RST}                -> {CYA}Heading 2{RST}")
            print(f"  {WHT}1.1.1, 2.1.3 ...{RST}                 -> {CYA}Heading 3{RST}")
            print(f"  {WHT}1.1.1.1, 2.1.3.2 ...{RST}             -> {CYA}Heading 4{RST}")
            print(f"  {WHT}Bao cao, Do an, Luan van ...{RST}     -> {CYA}Title{RST}")
            print(f"  {WHT}Nganh:, GVHD:, SVTH: ...{RST}         -> {CYA}Subtitle{RST}")
            input(f"\n  {GRY}Enter de tiep tuc...{RST}")

        elif choice == "2":
            add_pattern(patterns)

        elif choice == "3":
            remove_pattern(patterns)

        elif choice == "4":
            print()
            print(f"  {CYA}Cac pattern mau:{RST}")
            for ex in BUILTIN_EXAMPLES:
                print(f"  {WHT}{ex[0]:35s}{RST} -> {CYA}{ex[1]:15s}{RST} {GRY}({ex[2]}){RST}")
            print()
            if input(f"  {YLW}Them mau nay? (y/N): {RST}").strip().lower() == "y":
                added = 0
                for ex in BUILTIN_EXAMPLES:
                    exists = any(p["pattern"] == ex[0] for p in patterns)
                    if not exists:
                        patterns.append({
                            "name": ex[2],
                            "pattern": ex[0],
                            "style": ex[1],
                        })
                        added += 1
                        print(f"  {GRN}[OK]{RST} Da them: {WHT}{ex[0]}{RST} -> {CYA}{ex[1]}{RST}")
                if added == 0:
                    print(f"  {GRY}(tat ca da ton tai){RST}")
            input(f"\n  {GRY}Enter de tiep tuc...{RST}")

        elif choice == "5":
            save_patterns(patterns)
            print()
            inp = input(f"  {YLW}Nhap file Word de preview{RST} {GRY}(Enter = bo qua){RST}: ").strip()
            if inp:
                import subprocess
                import sys
                subprocess.call([
                    sys.executable, os.path.join("src", "main.py"),
                    "preview", inp, "-r", "rules/smart_patterns.yaml",
                ])
            input(f"\n  {GRY}Enter de tiep tuc...{RST}")

        elif choice == "0":
            save_patterns(patterns)
            break

        else:
            print(f"  {RED}So khong hop le{RST}")
            import time
            time.sleep(1)


if __name__ == "__main__":
    run()
