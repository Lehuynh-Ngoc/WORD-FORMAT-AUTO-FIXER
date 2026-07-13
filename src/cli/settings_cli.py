import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", ".."))

from src.core.ai_config import (
    get_all_providers,
    save_provider,
    check_api_key,
    get_provider_status_color,
    get_provider_status_label,
    set_active_model,
    add_model_to_provider,
    remove_model_from_provider,
    rename_model_in_provider,
    add_custom_provider,
    remove_custom_provider,
    ProviderConfig,
    DEFAULT_MODELS,
)

ESC = "\033"
CYA = f"{ESC}[36m"
YLW = f"{ESC}[33m"
GRN = f"{ESC}[32m"
RED = f"{ESC}[31m"
GRY = f"{ESC}[90m"
WHT = f"{ESC}[37m"
BLD = f"{ESC}[1m"
RST = f"{ESC}[0m"


def _clear():
    os.system("cls" if os.name == "nt" else "clear")


def _show_all_providers():
    providers = get_all_providers()
    print()
    print(f"  {YLW}{'#':<4} {'Provider':<22} {'Status':<18} {'Model':<25}{RST}")
    print(f"  {YLW}{'-'*4} {'-'*22} {'-'*18} {'-'*25}{RST}")
    for i, (name, p) in enumerate(providers.items(), 1):
        color = get_provider_status_color(p.status)
        status_label = get_provider_status_label(p.status)
        active = p.model or "---"
        tag = f" {GRY}[custom]{RST}" if name not in DEFAULT_MODELS else ""
        print(
            f"  {WHT}{i:<4}{RST} {p.display_name:<22} "
            f"{color}{status_label:<18}{RST} {active}{tag}"
        )
    print()


def _pick_provider(prompt: str = "Chon provider"):
    providers = get_all_providers()
    names = list(providers.keys())
    for i, name in enumerate(names, 1):
        p = providers[name]
        tag = f" {GRY}[custom]{RST}" if name not in DEFAULT_MODELS else ""
        print(f"  {YLW}{i}.{RST} {p.display_name} {GRY}({p.model}){RST}{tag}")
    print(f"  {RED}0.{RST} Huy")
    print()
    try:
        choice = int(input(f"  {YLW}{prompt} (0-{len(names)}): {RST}"))
    except (ValueError, EOFError):
        return None
    if choice == 0 or choice > len(names):
        return None
    return names[choice - 1]


# ─── MAIN MENU ──────────────────────────────────────────────

def run():
    while True:
        _clear()
        print()
        print(f"{CYA}  ============================================{RST}")
        print(f"{CYA}{BLD}     CAI DAT AI PROVIDER                      {RST}")
        print(f"{CYA}  ============================================{RST}")
        print()
        _show_all_providers()
        print(f"  {GRY}--------------------------------------------{RST}")
        print(f"  {YLW}1.{RST} Chon model hoat dong (nhanh)")
        print(f"  {YLW}2.{RST} Quan ly provider (API key, models, custom)")
        print(f"  {YLW}3.{RST} Kiem tra tat ca API keys")
        print(f"  {RED}0.{RST} Quay lai")
        print(f"  {GRY}--------------------------------------------{RST}")
        print()

        choice = input(f"  {YLW}Nhap so (0-3): {RST}").strip()

        if choice == "1":
            _menu_quick_select_model()
            input(f"\n  {GRY}Enter de tiep tuc...{RST}")
        elif choice == "2":
            _menu_manage_providers()
        elif choice == "3":
            _menu_check_all()
            input(f"\n  {GRY}Enter de tiep tuc...{RST}")
        elif choice == "0":
            break
        else:
            print(f"  {RED}So khong hop le{RST}")
            time.sleep(1)


# ─── 1. CHON MODEL NHANH ──────────────────────────────────

def _menu_quick_select_model():
    _clear()
    print()
    print(f"{CYA}  ============================================{RST}")
    print(f"{CYA}{BLD}     CHON MODEL HOAT DONG                      {RST}")
    print(f"{CYA}  ============================================{RST}")
    print()

    name = _pick_provider()
    if not name:
        return

    providers = get_all_providers()
    p = providers[name]

    print()
    print(f"  {CYA}Provider:{RST} {p.display_name}")
    print(f"  {CYA}Model hien tai:{RST} {GRN}{p.model}{RST}")
    print()
    for j, m in enumerate(p.models, 1):
        marker = f" {GRN}<<-dang dung{RST}" if m.is_active else ""
        print(f"    {YLW}{j}.{RST} {m.name}{marker}")
    print(f"    {RED}0.{RST} Huy")
    print()

    try:
        choice = int(input(f"  {YLW}Chon model: {RST}"))
    except (ValueError, EOFError):
        return
    if choice == 0 or choice > len(p.models):
        return

    model_name = p.models[choice - 1].name
    set_active_model(name, model_name)
    print(f"  {GRN}[OK]{RST} Da chon: {model_name}")


# ─── 2. QUAN LY PROVIDER ──────────────────────────────────

def _menu_manage_providers():
    while True:
        _clear()
        print()
        print(f"{CYA}  ============================================{RST}")
        print(f"{CYA}{BLD}     QUAN LY PROVIDER                         {RST}")
        print(f"{CYA}  ============================================{RST}")
        print()
        _show_all_providers()
        print(f"  {YLW}1.{RST} Chon provider de quan ly")
        print(f"  {YLW}2.{RST} Them custom API moi")
        print(f"  {YLW}3.{RST} Xoa custom API")
        print(f"  {YLW}4.{RST} Kiem tra API key")
        print(f"  {RED}0.{RST} Quay lai")
        print()

        choice = input(f"  {YLW}Chon (0-4): {RST}").strip()

        if choice == "1":
            _menu_provider_detail()
        elif choice == "2":
            _menu_add_custom()
            input(f"\n  {GRY}Enter de tiep tuc...{RST}")
        elif choice == "3":
            _menu_delete_custom()
            input(f"\n  {GRY}Enter de tiep tuc...{RST}")
        elif choice == "4":
            _menu_check_single()
            input(f"\n  {GRY}Enter de tiep tuc...{RST}")
        elif choice == "0":
            break


def _menu_provider_detail():
    name = _pick_provider("Chon provider de quan ly")
    if not name:
        return

    while True:
        providers = get_all_providers()
        p = providers[name]
        is_custom = name not in DEFAULT_MODELS

        print()
        print(f"  {CYA}========================================{RST}")
        print(f"  {CYA}{BLD}  {p.display_name.upper()}{RST}")
        print(f"  {CYA}========================================{RST}")
        print()

        masked = f"{p.api_key[:12]}...{p.api_key[-4:]}" if len(p.api_key) > 12 else (p.api_key or "(chua nhap)")
        color = get_provider_status_color(p.status)
        label = get_provider_status_label(p.status)
        print(f"  {GRY}Base URL:{RST}  {p.base_url}")
        print(f"  {GRY}API Key:{RST}   {masked}")
        print(f"  {GRY}Status:{RST}   {color}{label}{RST}")
        if p.credit_info:
            print(f"  {GRY}Info:{RST}     {color}{p.credit_info}{RST}")
        if is_custom:
            print(f"  {GRY}Loai:{RST}     {YLW}Custom API{RST}")
        print()

        print(f"  {CYA}Models:{RST}")
        for j, m in enumerate(p.models, 1):
            marker = f" {GRN}*dang dung{RST}" if m.is_active else ""
            print(f"    {YLW}{j}.{RST} {m.name}{marker}")
        print()

        print(f"  {YLW}1.{RST} Sua Base URL")
        print(f"  {YLW}2.{RST} Sua API Key")
        print(f"  {YLW}3.{RST} Chon model hoat dong")
        print(f"  {YLW}4.{RST} Them model")
        print(f"  {YLW}5.{RST} Doi ten model")
        print(f"  {YLW}6.{RST} Xoa model")
        print(f"  {YLW}7.{RST} Kiem tra API key")
        if is_custom:
            print(f"  {YLW}8.{RST} Doi ten custom provider")
        print(f"  {RED}0.{RST} Quay lai")
        print()

        choice = input(f"  {YLW}Chon: {RST}").strip()

        if choice == "1":
            print()
            new_url = input(f"  {CYA}Base URL moi (Enter = giu cu: {p.base_url}): {RST}").strip()
            if new_url:
                p.base_url = new_url
                save_provider(p)
                print(f"  {GRN}[OK]{RST} Da cap nhat base URL.")

        elif choice == "2":
            print()
            new_key = input(f"  {CYA}API key moi (Enter = giu cu): {RST}").strip()
            if new_key:
                p.api_key = new_key
                save_provider(p)
                print(f"  {GRN}[OK]{RST} Da cap nhat API key.")

        elif choice == "3":
            print()
            for j, m in enumerate(p.models, 1):
                marker = f" {GRN}*{RST}" if m.is_active else ""
                print(f"    {YLW}{j}.{RST} {m.name}{marker}")
            print(f"    {RED}0.{RST} Huy")
            print()
            try:
                c = int(input(f"  {YLW}Chon model: {RST}"))
            except (ValueError, EOFError):
                continue
            if 1 <= c <= len(p.models):
                set_active_model(name, p.models[c - 1].name)
                print(f"  {GRN}[OK]{RST} Da chon: {p.models[c - 1].name}")

        elif choice == "4":
            print()
            model_name = input(f"  {CYA}Ten model moi: {RST}").strip()
            if model_name:
                if add_model_to_provider(name, model_name):
                    print(f"  {GRN}[OK]{RST} Da them: {model_name}")
                else:
                    print(f"  {RED}[LOI]{RST} Model da ton tai.")

        elif choice == "5":
            print()
            if len(p.models) < 1:
                print(f"  {RED}[LOI]{RST} Khong co model nao.")
                continue
            for j, m in enumerate(p.models, 1):
                marker = f" {GRN}*{RST}" if m.is_active else ""
                print(f"    {YLW}{j}.{RST} {m.name}{marker}")
            print()
            try:
                c = int(input(f"  {YLW}Chon model can doi ten (0 = huy): {RST}"))
            except (ValueError, EOFError):
                continue
            if c == 0 or c > len(p.models):
                continue
            old_name = p.models[c - 1].name
            new_name = input(f"  {CYA}Ten moi cho '{old_name}': {RST}").strip()
            if new_name:
                rename_model_in_provider(name, old_name, new_name)
                print(f"  {GRN}[OK]{RST} Da doi: {old_name} -> {new_name}")

        elif choice == "6":
            print()
            if len(p.models) <= 1:
                print(f"  {RED}[LOI]{RST} Phai co it nhat 1 model.")
                continue
            for j, m in enumerate(p.models, 1):
                marker = f" {GRN}*{RST}" if m.is_active else ""
                print(f"    {YLW}{j}.{RST} {m.name}{marker}")
            print()
            try:
                c = int(input(f"  {YLW}Chon model can xoa (0 = huy): {RST}"))
            except (ValueError, EOFError):
                continue
            if c == 0 or c > len(p.models):
                continue
            model_name = p.models[c - 1].name
            confirm = input(f"  {RED}Xac nhan xoa '{model_name}'? (y/N): {RST}").strip().lower()
            if confirm == "y":
                remove_model_from_provider(name, model_name)
                print(f"  {GRN}[OK]{RST} Da xoa: {model_name}")

        elif choice == "7":
            print()
            print(f"  {GRY}Dang kiem tra...{RST}")
            result = check_api_key(name)
            c = get_provider_status_color(result.status)
            l = get_provider_status_label(result.status)
            print(f"  {c}{l}{RST}: {result.credit_info}")

        elif choice == "8" and is_custom:
            print()
            new_display = input(f"  {CYA}Ten hien thi moi (Enter = giu cu: {p.display_name}): {RST}").strip()
            if new_display:
                p.display_name = new_display
                save_provider(p)
                print(f"  {GRN}[OK]{RST} Da cap nhat ten.")

        elif choice == "0":
            break

        else:
            print(f"  {RED}Lua chon khong hop le{RST}")
            time.sleep(0.5)


def _menu_add_custom():
    _clear()
    print()
    print(f"{CYA}  ============================================{RST}")
    print(f"{CYA}{BLD}     THEM CUSTOM API                           {RST}")
    print(f"{CYA}  ============================================{RST}")
    print()

    c_name = input(f"  {CYA}Ten viet tat (VD: myapi, ollama): {RST}").strip()
    c_display = input(f"  {CYA}Ten hien thi (VD: My Custom API): {RST}").strip()
    c_url = input(f"  {CYA}Base URL (VD: https://api.example.com/v1): {RST}").strip()
    c_key = input(f"  {CYA}API key (Enter = khong): {RST}").strip()
    c_model = input(f"  {CYA}Model mac dinh (Enter = default): {RST}").strip()

    if not c_name or not c_url:
        print(f"  {RED}[LOI]{RST} Can it nhat ten va URL.")
        return

    try:
        add_custom_provider(c_name, c_display or c_name.title(), c_url, c_key, c_model or "default")
        print(f"  {GRN}[OK]{RST} Da tao custom API: {c_name}")
    except ValueError as e:
        print(f"  {RED}[LOI]{RST} {e}")


def _menu_delete_custom():
    _clear()
    print()
    print(f"{CYA}  ============================================{RST}")
    print(f"{CYA}{BLD}     XOA CUSTOM API                           {RST}")
    print(f"{CYA}  ============================================{RST}")
    print()

    providers = get_all_providers()
    customs = {n: p for n, p in providers.items() if n not in DEFAULT_MODELS}
    if not customs:
        print(f"  {GRY}Khong co custom API nao.{RST}")
        return

    names = list(customs.keys())
    for i, n in enumerate(names, 1):
        p = customs[n]
        print(f"    {YLW}{i}.{RST} {p.display_name} {GRY}({n}){RST}")
    print(f"    {RED}0.{RST} Huy")
    print()

    try:
        c = int(input(f"  {YLW}Chon: {RST}"))
    except (ValueError, EOFError):
        return
    if c == 0 or c > len(names):
        return

    sel_name = names[c - 1]
    confirm = input(f"  {RED}Xac nhan xoa '{sel_name}'? (y/N): {RST}").strip().lower()
    if confirm == "y":
        remove_custom_provider(sel_name)
        print(f"  {GRN}[OK]{RST} Da xoa: {sel_name}")


def _menu_check_single():
    _clear()
    print()
    print(f"{CYA}  ============================================{RST}")
    print(f"{CYA}{BLD}     KIEM TRA API KEY                         {RST}")
    print(f"{CYA}  ============================================{RST}")
    print()

    name = _pick_provider()
    if not name:
        return

    providers = get_all_providers()
    p = providers[name]
    if not p.api_key:
        print(f"  {RED}[LOI]{RST} Chua nhap API key.")
        return

    print(f"  {GRY}Dang kiem tra {p.display_name} ({p.model})...{RST}")
    result = check_api_key(name)
    c = get_provider_status_color(result.status)
    l = get_provider_status_label(result.status)
    print(f"  {c}{l}{RST}: {result.credit_info}")


# ─── 3. KIEM TRA TAT CA ───────────────────────────────────

def _menu_check_all():
    _clear()
    print()
    print(f"{CYA}  ============================================{RST}")
    print(f"{CYA}{BLD}     KIEM TRA TAT CA API KEYS                  {RST}")
    print(f"{CYA}  ============================================{RST}")
    print()

    providers = get_all_providers()
    for name, p in providers.items():
        if not p.api_key:
            print(f"  {GRY}{p.display_name}: Chua nhap key{RST}")
            continue
        print(f"  {GRY}Dang kiem tra {p.display_name} ({p.model})...{RST}", end="", flush=True)
        result = check_api_key(name)
        color = get_provider_status_color(result.status)
        label = get_provider_status_label(result.status)
        print(f"\r  {color}{label:<20}{RST} {p.display_name}: {result.credit_info}")
        time.sleep(0.5)

    print()
    print(f"  {GRN}Hoan tat!{RST}")


if __name__ == "__main__":
    run()
