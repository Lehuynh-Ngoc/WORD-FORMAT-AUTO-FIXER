from typing import List, Dict


C_CYA = "\033[36m"
C_GRN = "\033[32m"
C_YLW = "\033[33m"
C_GRY = "\033[90m"
C_WHT = "\033[37m"
C_BLD = "\033[1m"
C_RST = "\033[0m"

FORMATTER_COLORS = {
    "SmartHeadingFormatter": (C_CYA, "SmartHeading"),
    "FontFormatter": (C_YLW, "Font"),
    "SpacingFormatter": (C_GRN, "Spacing"),
    "AlignmentFormatter": (C_GRY, "Alignment"),
    "HeadingFormatter": (C_WHT, "Heading"),
}


class ChangeReporter:
    def __init__(self, input_path: str):
        self.input_path = input_path
        self.output_path: str = None
        self._changes: Dict[str, List[str]] = {}

    def add_changes(self, formatter_name: str, changes: List[str]):
        if changes:
            self._changes[formatter_name] = changes

    @property
    def total_changes(self) -> int:
        return sum(len(v) for v in self._changes.values())

    @property
    def has_changes(self) -> bool:
        return self.total_changes > 0

    def summary(self) -> str:
        if not self.has_changes:
            return f"{C_YLW}No changes needed.{C_RST}"

        lines = [f"{C_WHT}File: {C_RST}{self.input_path}"]
        if self.output_path:
            lines.append(f"{C_WHT}Output: {C_RST}{self.output_path}")
        lines.append(f"{C_BLD}Total changes: {self.total_changes}{C_RST}")
        lines.append("")

        for fmt_name, changes in self._changes.items():
            color, label = FORMATTER_COLORS.get(fmt_name, (C_WHT, fmt_name))
            lines.append(f"{color}{C_BLD}[{label}]{C_RST} ({len(changes)} changes)")
            for c in changes:
                if "->" in c:
                    parts = c.split("->", 1)
                    lines.append(f"  {parts[0]}{C_GRN}->{C_RST}{parts[1]}")
                else:
                    lines.append(f"  {c}")
            lines.append("")

        return "\n".join(lines)
