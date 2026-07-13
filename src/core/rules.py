from dataclasses import dataclass, field, asdict
from typing import Optional

TARGET_TYPES = ("paragraph", "run", "document")
ACTION_CATEGORIES = ("font", "paragraph_format", "heading")


@dataclass
class Condition:
    style: Optional[str] = None
    text_contains: Optional[str] = None
    pattern: Optional[str] = None


@dataclass
class FontAction:
    name: Optional[str] = None
    size: Optional[float] = None
    bold: Optional[bool] = None
    italic: Optional[bool] = None
    color: Optional[str] = None


@dataclass
class ParagraphAction:
    alignment: Optional[str] = None
    line_spacing: Optional[float] = None
    space_before: Optional[float] = None
    space_after: Optional[float] = None
    first_line_indent: Optional[float] = None


@dataclass
class HeadingAction:
    level: Optional[int] = None
    style: Optional[str] = None


@dataclass
class FormatRule:
    name: str
    target: str = "paragraph"
    conditions: Condition = field(default_factory=Condition)
    font: FontAction = field(default_factory=FontAction)
    paragraph: ParagraphAction = field(default_factory=ParagraphAction)
    heading: HeadingAction = field(default_factory=HeadingAction)

    def applies_to(self, style_name: str, text: str = "") -> bool:
        if self.conditions.style and style_name != self.conditions.style:
            return False
        if self.conditions.text_contains and self.conditions.text_contains not in text:
            return False
        if self.conditions.pattern:
            import re
            if not re.search(self.conditions.pattern, text):
                return False
        return True


def rule_from_dict(data: dict) -> FormatRule:
    cond = data.get("conditions", {}) or {}
    font_data = data.get("actions", {}).get("font", {}) or {}
    para_data = data.get("actions", {}).get("paragraph", {}) or {}
    head_data = data.get("heading", {}) or data.get("actions", {}).get("heading", {}) or {}

    return FormatRule(
        name=data.get("name", "Unnamed"),
        target=data.get("target", "paragraph"),
        conditions=Condition(
            style=cond.get("style"),
            text_contains=cond.get("text_contains"),
            pattern=cond.get("pattern"),
        ),
        font=FontAction(**font_data),
        paragraph=ParagraphAction(**para_data),
        heading=HeadingAction(**head_data),
    )
