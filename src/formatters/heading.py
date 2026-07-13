from typing import List
from ..core.rules import FormatRule
from ..parsers.base import ParsedDocument
from .base import BaseFormatter


class HeadingFormatter(BaseFormatter):
    def apply(
        self, doc: ParsedDocument, rules: List[FormatRule]
    ) -> List[str]:
        changes = []
        for para in doc.paragraphs:
            matched = self._match_rules(para.style_name, para.text, rules)
            for rule in matched:
                c = self._apply_heading(para, rule)
                if c:
                    changes.append(c)
        return changes

    def _apply_heading(self, para, rule: FormatRule) -> str:
        h = rule.heading
        if h.level is not None:
            new_style = f"Heading {h.level}"
            if para.style_name != new_style:
                old_style = para.style_name
                para.style_name = new_style
                text = para.text[:40]
                return (
                    f"  Heading [{text}]: "
                    f"{old_style} -> {new_style}"
                )
        return None
