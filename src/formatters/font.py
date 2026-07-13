from typing import List
from ..core.rules import FormatRule
from ..parsers.base import ParsedDocument, ParsedRun
from .base import BaseFormatter


class FontFormatter(BaseFormatter):
    def apply(
        self, doc: ParsedDocument, rules: List[FormatRule]
    ) -> List[str]:
        changes = []
        for para in doc.paragraphs:
            matched = self._match_rules(para.style_name, para.text, rules)
            if not matched:
                continue
            for run in para.runs:
                for rule in matched:
                    c = self._apply_font(run, rule)
                    if c:
                        changes.append(c)
        return changes

    def _apply_font(self, run: ParsedRun, rule: FormatRule) -> str:
        parts = []
        f = rule.font
        if f.name is not None and run.font_name != f.name:
            run.font_name = f.name
            parts.append(f"font={f.name}")
        if f.size is not None and run.font_size != f.size:
            run.font_size = f.size
            parts.append(f"size={f.size}")
        if f.bold is not None and run.bold != f.bold:
            run.bold = f.bold
            parts.append(f"bold={f.bold}")
        if f.italic is not None and run.italic != f.italic:
            run.italic = f.italic
            parts.append(f"italic={f.italic}")
        if f.color is not None and run.color != f.color:
            run.color = f.color
            parts.append(f"color={f.color}")
        if parts:
            text = run.text[:40]
            return f"  Font [{text}]: {', '.join(parts)}"
        return None
