import os
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

RULES_DIR = os.path.join(os.path.dirname(__file__), "..", "..", "rules")


def get_rule_files():
    if not os.path.isdir(RULES_DIR):
        return []
    return [
        f for f in os.listdir(RULES_DIR)
        if f.endswith((".yaml", ".yml"))
    ]


def load_rule_file(filename):
    path = os.path.join(RULES_DIR, filename)
    if not os.path.exists(path):
        return None
    with open(path, encoding="utf-8") as f:
        data = yaml.safe_load(f)
    if not data or "rules" not in data:
        return []
    return data["rules"]


def show_rule_detail(filename):
    rules = load_rule_file(filename)
    if rules is None:
        print(f"\n  {RED}[LOI]{RST} Khong the doc file: {filename}")
        return

    print()
    print(f"  {CYA}{'=' * 46}{RST}")
    print(f"  {CYA}{BLD}  CHI TIET: {filename}{RST}")
    print(f"  {CYA}{'=' * 46}{RST}")
    print(f"  {GRY}Tong so rules: {WHT}{len(rules)}{RST}")
    print()

    if not rules:
        print(f"  {GRY}(file trong, khong co rule nao){RST}")
        return

    for i, rule in enumerate(rules, 1):
        name = rule.get("name", "(khong ten)")
        target = rule.get("target", "?")
        conditions = rule.get("conditions", {})
        actions = rule.get("actions", {})

        print(f"  {YLW}{i}.{RST} {WHT}{name}{RST}")
        print(f"     {GRY}Target:{RST} {target}")

        if conditions:
            cond_parts = []
            for k, v in conditions.items():
                cond_parts.append(f"{k}={v}")
            print(f"     {GRY}Dieu kien:{RST} {CYA}{', '.join(cond_parts)}{RST}")

        if actions:
            font = actions.get("font", {})
            para = actions.get("paragraph", {})
            heading = actions.get("heading", {})

            if font:
                font_parts = []
                if font.get("name"):
                    font_parts.append(f"font={WHT}{font['name']}{RST}")
                if font.get("size"):
                    font_parts.append(f"size={WHT}{font['size']}{RST}")
                if font.get("bold"):
                    font_parts.append(f"{WHT}bold{RST}")
                if font.get("italic"):
                    font_parts.append(f"{WHT}italic{RST}")
                if font.get("color"):
                    font_parts.append(f"color={WHT}#{font['color']}{RST}")
                if font_parts:
                    print(f"     {GRY}Font:{RST}   {', '.join(font_parts)}")

            if para:
                para_parts = []
                if para.get("alignment"):
                    para_parts.append(f"align={WHT}{para['alignment']}{RST}")
                if para.get("line_spacing"):
                    para_parts.append(f"spacing={WHT}{para['line_spacing']}{RST}")
                if para.get("space_before") is not None:
                    para_parts.append(f"trc={WHT}{para['space_before']}pt{RST}")
                if para.get("space_after") is not None:
                    para_parts.append(f"sau={WHT}{para['space_after']}pt{RST}")
                if para.get("first_line_indent") is not None:
                    para_parts.append(f"thu= {WHT}{para['first_line_indent']}cm{RST}")
                if para_parts:
                    print(f"     {GRY}Doan:{RST}   {', '.join(para_parts)}")

            if heading:
                if heading.get("level"):
                    print(f"     {GRY}Level:{RST}  {WHT}Heading {heading['level']}{RST}")
                elif heading.get("style"):
                    print(f"     {GRY}Style:{RST}  {WHT}{heading['style']}{RST}")

        print()


def run():
    files = get_rule_files()

    while True:
        os.system("cls" if os.name == "nt" else "clear")
        print()
        print(f"{CYA}  ============================================{RST}")
        print(f"{CYA}{BLD}    DANH SACH RULES CO SAN                   {RST}")
        print(f"{CYA}  ============================================{RST}")
        print()
        print(f"  {GRY}Thu muc:{RST} {WHT}{RULES_DIR}{RST}")
        print()

        if not files:
            print(f"  {RED}(khong co file rule nao){RST}")
        else:
            print(f"  {YLW}{'STT':<5} {'File':<25} {'So rules':<10} {GRY}Mo ta{RST}")
            print(f"  {YLW}{'---':<5} {'----':<25} {'---------':<10} {'-----'}{RST}")
            for i, f in enumerate(files, 1):
                rules = load_rule_file(f)
                count = len(rules) if rules else 0
                desc = ""
                if count > 0:
                    names = [r.get("name", "") for r in rules[:2]]
                    desc = ", ".join(names)
                    if count > 2:
                        desc += f" {GRY}...{RST}"
                print(f"  {WHT}{i:<5}{RST} {f:<25} {GRN}{count:<10}{RST} {GRY}{desc}{RST}")

        print()
        print(f"  {GRY}--------------------------------------------{RST}")
        print(f"  {YLW}1-{len(files)}.{RST} Xem chi tiet file rule")
        print(f"  {RED}0.{RST} Quay lai")
        print(f"  {GRY}--------------------------------------------{RST}")
        print()

        choice = input(f"  {YLW}Nhap so: {RST}").strip()

        if choice == "0":
            break

        try:
            idx = int(choice)
        except ValueError:
            print(f"  {RED}So khong hop le{RST}")
            import time
            time.sleep(1)
            continue

        if 1 <= idx <= len(files):
            show_rule_detail(files[idx - 1])
            input(f"\n  {GRY}Enter de tiep tuc...{RST}")
        else:
            print(f"  {RED}So khong hop le{RST}")
            import time
            time.sleep(1)


if __name__ == "__main__":
    run()
