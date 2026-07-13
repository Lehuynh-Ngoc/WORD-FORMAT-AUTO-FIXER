from typing import List
from ..core.rules import FormatRule
from ..parsers.base import ParsedDocument
from .base import BaseFormatter


class AlignmentFormatter(BaseFormatter):
    def apply(
        self, doc: ParsedDocument, rules: List[FormatRule]
    ) -> List[str]:
        changes = []
        for para in doc.paragraphs:
            matched = self._match_rules(para.style_name, para.text, rules)
            if not matched:
                continue
            for rule in matched:
                c = self._apply_alignment(para, rule)
                if c:
                    changes.append(c)
        return changes

    def _apply_alignment(self, para, rule: FormatRule) -> str:
        p = rule.paragraph
        if p.alignment is not None and para.alignment != p.alignment:
            para.alignment = p.alignment
            text = para.text[:40]
            return f"  Alignment [{text}]: {p.alignment}"
        return None
