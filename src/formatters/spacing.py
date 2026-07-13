from typing import List
from ..core.rules import FormatRule
from ..parsers.base import ParsedDocument
from .base import BaseFormatter


class SpacingFormatter(BaseFormatter):
    def apply(
        self, doc: ParsedDocument, rules: List[FormatRule]
    ) -> List[str]:
        changes = []
        for para in doc.paragraphs:
            matched = self._match_rules(para.style_name, para.text, rules)
            if not matched:
                continue
            for rule in matched:
                c = self._apply_spacing(para, rule)
                if c:
                    changes.append(c)
        return changes

    def _apply_spacing(self, para, rule: FormatRule) -> str:
        parts = []
        p = rule.paragraph
        if p.line_spacing is not None and para.line_spacing != p.line_spacing:
            para.line_spacing = p.line_spacing
            parts.append(f"line_spacing={p.line_spacing}")
        if p.space_before is not None and para.space_before != p.space_before:
            para.space_before = p.space_before
            parts.append(f"space_before={p.space_before}")
        if p.space_after is not None and para.space_after != p.space_after:
            para.space_after = p.space_after
            parts.append(f"space_after={p.space_after}")
        if p.first_line_indent is not None:
            para.first_line_indent = p.first_line_indent
            parts.append(f"first_line_indent={p.first_line_indent}")
        if parts:
            text = para.text[:40]
            return f"  Spacing [{text}]: {', '.join(parts)}"
        return None
