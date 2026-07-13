import re
from typing import List
from ..core.rules import FormatRule
from ..parsers.base import ParsedDocument
from .base import BaseFormatter


HEADING_PATTERNS = [
    (re.compile(r'^(?:CHƯƠNG|Chương|CHUONG|Chuong)\s+[IVXLCDM\d]+[\s\:\.,]'), 1),
    (re.compile(r'^(?:CHƯƠNG|Chương|CHUONG|Chuong)\s+\d+[\s\:\.,]'), 1),
    (re.compile(r'^(?:Chương|CHƯƠNG)\s+\d+'), 1),
    (re.compile(r'^Phần\s+[IVXLCDM\d]+[\s\:\.,]'), 1),
    (re.compile(r'^Phần\s+\d+[\s\:\.,]'), 1),
    (re.compile(r'^PHẦN\s+\d+[\s\:\.,]'), 1),
    (re.compile(r'^\d+\.\d+\.\d+\.\d+[\s\:\.,]'), 4),
    (re.compile(r'^\d+\.\d+\.\d+[\s\:\.,]'), 3),
    (re.compile(r'^\d+\.\d+[\s\:\.,]'), 2),
    (re.compile(r'^I+\s+[\.,]'), 1),
    (re.compile(r'^MỤC\s+LỤC', re.UNICODE), 1),
    (re.compile(r'^TÀI\s+LIỆU\s+THAM\s+KHẢO', re.UNICODE), 1),
    (re.compile(r'^PHỤ\s+LỤC', re.UNICODE), 1),
    (re.compile(r'^LỜI\s+MỞ\s+ĐẦU', re.UNICODE), 1),
    (re.compile(r'^LỜI\s+NÓI\s+ĐẦU', re.UNICODE), 1),
    (re.compile(r'^KẾT\s+LUẬN', re.UNICODE), 1),
    (re.compile(r'^DANH\s+MỤC', re.UNICODE), 1),
]

TITLE_PATTERNS = [
    (re.compile(r'^(?:BÁO\s+CÁO|ĐỒ\s+ÁN|LUẬN\s+VĂN|TIỂU\s+LUẬN|LUẬN\s+ÁN|KHÓA\s+LUẬN|CHUYÊN\s+ĐỀ)\s', re.UNICODE), "Title"),
    (re.compile(r'^BỘ\s+GIÁO\s+DỤC', re.UNICODE), "Title"),
    (re.compile(r'^TRƯỜNG\s+ĐẠI\s+HỌC', re.UNICODE), "Title"),
]

SUBTITLE_PATTERNS = [
    (re.compile(r'^Ngành\s*:', re.UNICODE), "Subtitle"),
    (re.compile(r'^Chuyên\s+ngành\s*:', re.UNICODE), "Subtitle"),
    (re.compile(r'^Giảng\s+viên\s+hướng\s+dẫn', re.UNICODE), "Subtitle"),
    (re.compile(r'^Sinh\s+viên\s+thực\s+hiện', re.UNICODE), "Subtitle"),
    (re.compile(r'^GVHD\s*:'), "Subtitle"),
    (re.compile(r'^SVTH\s*:'), "Subtitle"),
]


class SmartHeadingFormatter(BaseFormatter):
    def apply(
        self, doc: ParsedDocument, rules: List[FormatRule]
    ) -> List[str]:
        changes = []

        custom_patterns = []
        for rule in rules:
            target_style = None
            if rule.heading.style:
                target_style = rule.heading.style
            elif rule.heading.level:
                target_style = f"Heading {rule.heading.level}"

            if not target_style:
                continue

            if rule.conditions.pattern:
                try:
                    custom_patterns.append(
                        (re.compile(rule.conditions.pattern), target_style)
                    )
                except re.error:
                    pass
            elif rule.conditions.text_contains:
                custom_patterns.append(
                    (re.compile(re.escape(rule.conditions.text_contains)), target_style)
                )

        for para in doc.paragraphs:
            text = para.text.strip()
            if not text:
                continue

            new_style = None
            for pat, val in custom_patterns:
                if pat.search(text):
                    new_style = val
                    break
            if new_style is None:
                for pat, val in HEADING_PATTERNS:
                    if pat.search(text):
                        new_style = f"Heading {val}"
                        break
            if new_style is None:
                for pat, val in TITLE_PATTERNS:
                    if pat.search(text):
                        new_style = val
                        break
            if new_style is None:
                for pat, val in SUBTITLE_PATTERNS:
                    if pat.search(text):
                        new_style = val
                        break

            if new_style and para.style_name != new_style:
                old_style = para.style_name
                para.style_name = new_style
                changes.append(
                    f"  SmartHeading [{text[:40]}]: {old_style} -> {new_style}"
                )

        return changes
