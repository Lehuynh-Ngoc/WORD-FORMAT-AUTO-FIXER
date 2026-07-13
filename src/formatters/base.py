from abc import ABC, abstractmethod
from typing import List
from ..core.rules import FormatRule
from ..parsers.base import ParsedDocument


class BaseFormatter(ABC):
    @abstractmethod
    def apply(
        self, doc: ParsedDocument, rules: List[FormatRule]
    ) -> List[str]:
        ...

    def _match_rules(
        self, style_name: str, text: str, rules: List[FormatRule]
    ) -> List[FormatRule]:
        return [
            r for r in rules
            if r.target in ("paragraph", "run")
            and r.applies_to(style_name, text)
        ]
