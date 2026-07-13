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

POPULAR_STYLES = [
    "Normal", "Title", "Subtitle",
    "Heading 1", "Heading 2", "Heading 3", "Heading 4", "Heading 5",
    "List Bullet", "List Number",
    "Quote", "Intense Quote",
    "Table Grid", "TOC Heading",
    "Header", "Footer",
    "Caption", "Bibliography",
]


def prompt(prompt_text: str, default: str = "") -> str:
    if default:
        val = input(f"  {CYA}{prompt_text}{RST} {GRY}(Enter = {default}){RST}: ").strip()
        return val if val else default
    val = input(f"  {CYA}{prompt_text}{RST}: ").strip()
    return val if val else ""


def prompt_float(prompt_text: str, default: float = None) -> float:
    while True:
        val = prompt(prompt_text, str(default) if default else "")
        if not val:
            return None
        try:
            return float(val)
        except ValueError:
            print(f"  {RED}[!]{RST} Nhap so, duoc: {val}")


def prompt_bool(prompt_text: str, default: bool = None) -> bool:
    val = prompt(f"{prompt_text} {GRY}(y/n){RST}", "y" if default else "n")
    return val.lower() in ("y", "yes", "1", "true")


def prompt_alignment(default: str = "justify") -> str:
    print(f"  {YLW}1={RST}left  {YLW}2={RST}center  {YLW}3={RST}right  {YLW}4={RST}justify")
    val = input(f"  {CYA}Chon (1-4, Enter = {default}){RST}: ").strip()
    m = {"1": "left", "2": "center", "3": "right", "4": "justify"}
    return m.get(val, default)


def pick_style_name() -> str:
    print(f"\n  {CYA}Chon style tu danh sach hoac nhap ten tu do:{RST}")
    print()
    cols = 3
    for i, name in enumerate(POPULAR_STYLES, 1):
        print(f"  {YLW}{i:>2}.{RST} {name:<20}", end="")
        if i % cols == 0:
            print()
    print()
    print(f"  {GRY}Nhap so de chon, hoac nhap ten style tuy y{RST}")
    print(f"  {GRY}(vd: 'List Bullet 2', 'TOC 3', 'Normal (Web)'){RST}")

    val = input(f"  {CYA}Style name{RST}: ").strip()
    if not val:
        return ""

    try:
        idx = int(val)
        if 1 <= idx <= len(POPULAR_STYLES):
            return POPULAR_STYLES[idx - 1]
    except ValueError:
        pass

    return val


def get_default_size(style_name: str) -> float:
    sn = style_name.lower()
    if sn == "normal":
        return 13.0
    if sn.startswith("heading"):
        return 14.0
    if sn in ("title",):
        return 16.0
    if sn in ("subtitle",):
        return 14.0
    return 13.0


def get_default_bold(style_name: str) -> bool:
    sn = style_name.lower()
    if sn.startswith("heading"):
        return True
    if sn in ("title", "subtitle"):
        return True
    return False


def get_default_alignment(style_name: str) -> str:
    sn = style_name.lower()
    if sn == "normal":
        return "justify"
    if sn in ("title", "subtitle"):
        return "center"
    return "left"


def get_default_space_before(style_name: str) -> float:
    sn = style_name.lower()
    if sn == "normal":
        return 6.0
    if sn == "heading 1":
        return 18.0
    if sn.startswith("heading"):
        return 12.0
    return 6.0


def get_default_space_after(style_name: str) -> float:
    sn = style_name.lower()
    if sn in ("title",):
        return 12.0
    if sn in ("subtitle",):
        return 6.0
    return 6.0


def configure_style(style_name: str) -> dict:
    print(f"\n  {CYA}--- {style_name} ---{RST}")

    font = {}
    para = {}

    font_name = prompt("Font name", "Times New Roman")
    if font_name:
        font["name"] = font_name

    font_size = prompt_float("Font size", get_default_size(style_name))
    if font_size:
        font["size"] = font_size

    if prompt_bool("Bold", get_default_bold(style_name)):
        font["bold"] = True

    if prompt_bool("Italic", False):
        font["italic"] = True

    color = prompt("Mau chu (hex, vd: 000000)", "000000")
    if color:
        font["color"] = color

    align = prompt_alignment(get_default_alignment(style_name))
    if align:
        para["alignment"] = align

    line_spacing = prompt_float("Line spacing", 1.5)
    if line_spacing:
        para["line_spacing"] = line_spacing

    space_before = prompt_float("Space before (pt)", get_default_space_before(style_name))
    if space_before:
        para["space_before"] = space_before

    space_after = prompt_float("Space after (pt)", get_default_space_after(style_name))
    if space_after:
        para["space_after"] = space_after

    first_line = prompt_float("First line indent (cm, Enter = bo qua)")
    if first_line:
        para["first_line_indent"] = first_line

    rule = {
        "name": f"{style_name} - custom",
        "target": "paragraph",
        "conditions": {"style": style_name},
        "actions": {},
    }
    if font:
        rule["actions"]["font"] = font
    if para:
        rule["actions"]["paragraph"] = para
    if style_name.startswith("Heading"):
        try:
            level = int(style_name.replace("Heading ", "").strip())
            rule["actions"]["heading"] = {"level": level}
        except ValueError:
            pass
    elif style_name == "Title":
        rule["actions"]["heading"] = {"style": "Title"}
    elif style_name == "Subtitle":
        rule["actions"]["heading"] = {"style": "Subtitle"}

    return rule


def run():
    print()
    print(f"{CYA}{'=' * 50}{RST}")
    print(f"{CYA}{BLD}  TAO RULE DINH DANG THEO Y MUON          {RST}")
    print(f"{CYA}{'=' * 50}{RST}")
    print()
    print(f"  {GRY}Nhap ten style tu Word de tao rule.{RST}")
    print(f"  {GRY}Co the nhap bat ky style nao: Normal, Heading 1-9,{RST}")
    print(f"  {GRY}Title, Subtitle, List Bullet, Quote, Table Grid...{RST}")
    print(f"  {GRY}De trong khi chon style = dung lai.{RST}")

    rules = []
    configured_styles = set()

    while True:
        style_name = pick_style_name()
        if not style_name:
            break
        if style_name in configured_styles:
            print(f"  {RED}[!]{RST} Style '{style_name}' da duoc cau hinh truoc do.")
            continue
        configured_styles.add(style_name)

        rule = configure_style(style_name)
        rules.append(rule)
        print(f"\n  {GRN}[OK]{RST} Da them rule cho '{style_name}'")

        more = prompt(f"Tiep tuc them style? (y/n)", "y")
        if more.lower() not in ("y", "yes"):
            break

    if not rules:
        print(f"\n  {RED}[!]{RST} Khong co style nao duoc cau hinh.")
        return

    print(f"\n  {GRY}Da cau hinh {len(rules)} style:{RST}")
    for r in rules:
        print(f"    - {r['name']}")

    data = {"rules": rules}
    name = prompt("\nTen file rule (khong can .yaml)", "custom_rules")
    path = os.path.join(os.path.dirname(__file__), "..", "..", "rules", f"{name}.yaml")
    os.makedirs(os.path.dirname(os.path.abspath(path)), exist_ok=True)

    with open(path, "w", encoding="utf-8") as f:
        yaml.dump(data, f, allow_unicode=True, default_flow_style=False, sort_keys=False)

    print(f"\n  {GRN}[OK]{RST} Da tao: {WHT}{path}{RST}")
    print(f"  {GRY}Dung: python src/main.py format input.docx -r {name}.yaml{RST}")
    print()


if __name__ == "__main__":
    run()
