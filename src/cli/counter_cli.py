import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", ".."))

from src.core.counter import count_document

ESC = "\033"
CYA = f"{ESC}[36m"
YLW = f"{ESC}[33m"
GRN = f"{ESC}[32m"
RED = f"{ESC}[31m"
GRY = f"{ESC}[90m"
WHT = f"{ESC}[37m"
BLD = f"{ESC}[1m"
RST = f"{ESC}[0m"


def run():
    os.system("cls" if os.name == "nt" else "clear")
    print()
    print(f"{CYA}  ============================================{RST}")
    print(f"{CYA}{BLD}     DEM SO TU VA TRANG                        {RST}")
    print(f"{CYA}  ============================================{RST}")
    print()
    filepath = input(f"  {YLW}Nhap duong dan file Word: {RST}").strip()
    if not filepath:
        print(f"  {RED}[LOI]{RST} Chua nhap duong dan.")
        return

    if not os.path.exists(filepath):
        print(f"  {RED}[LOI]{RST} Khong tim thay file: {filepath}")
        return

    print()
    print(f"  {GRY}Dang phan tich...{RST}")
    print()

    try:
        result = count_document(filepath)
        print(f"  {CYA}{'=' * 46}{RST}")
        print(f"  {CYA}{BLD}  KET QUA DEM{RST}")
        print(f"  {CYA}{'=' * 46}{RST}")
        print()
        print(f"  {GRY}File:{RST} {WHT}{result.file_name}{RST}")
        print()
        print(f"  {YLW}--- So luong ---{RST}")
        print(f"  Doan (paragraphs):    {WHT}{result.paragraphs}{RST}")
        print(f"  Dong (lines):         {WHT}{result.lines}{RST}")
        print(f"  Tu (words):           {WHT}{result.words}{RST}")
        print(f"  Ky tu (khong space):  {WHT}{result.characters_no_space}{RST}")
        print(f"  Ky tu (co space):     {WHT}{result.characters_with_space}{RST}")
        print(f"  Trang (du dinh):      {WHT}{result.pages_estimated}{RST}")
        if result.pages_actual is not None:
            print(f"  Trang (thuc te):      {WHT}{result.pages_actual}{RST}")
        print()
        print(f"  {YLW}--- Thoi gian doc uoc tinh ---{RST}")
        print(f"  Tieng Viet (~200 tu/phut): {WHT}{result.reading_time_vi}{RST}")
        print(f"  English  (~250 tu/phut): {WHT}{result.reading_time_en}{RST}")
        print()
        print(f"  {YLW}--- Cau truc ---{RST}")
        print(f"  Sections: {WHT}{result.sections}{RST}")
        for level, count in sorted(result.headings.items()):
            print(f"  {level}: {WHT}{count}{RST}")
        if result.languages_detected:
            print()
            print(f"  {YLW}--- Ngon ngu phat hien ---{RST}")
            for lang in result.languages_detected:
                print(f"  - {lang}")
        print()

        save = input(f"  {YLW}Luu ket qua ra file? (y/N): {RST}").strip().lower()
        if save == "y":
            out_path = os.path.splitext(filepath)[0] + "_stats.txt"
            with open(out_path, "w", encoding="utf-8") as f:
                f.write(result.summary())
            print(f"  {GRN}[OK]{RST} Da luu: {WHT}{out_path}{RST}")

    except Exception as e:
        print(f"  {RED}[LOI]{RST} {e}")

    print()
    input(f"  {GRY}Enter de quay lai...{RST}")


if __name__ == "__main__":
    run()
