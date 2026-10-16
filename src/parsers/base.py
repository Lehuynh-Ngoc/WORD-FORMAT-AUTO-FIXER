from abc import ABC, abstractmethod
from typing import List, Optional
from docx import Document


class ParsedDocument:
    def __init__(self, path: str):
        self.path = path
        self.document: Optional[Document] = None
        self.paragraphs: List[ParsedParagraph] = []


class ParsedParagraph:
    def __init__(self, style_name: str = "", text: str = ""):
        self.style_name = style_name
        self.text = text
        self.runs: List[ParsedRun] = []
        self.alignment: Optional[str] = None
        self.line_spacing: Optional[float] = None
        self.space_before: Optional[float] = None
        self.space_after: Optional[float] = None
        self.first_line_indent: Optional[float] = None
        self.source = None  # tham chiếu paragraph goc (python-docx) neu co


class ParsedRun:
    def __init__(self):
        self.text: str = ""
        self.font_name: Optional[str] = None
        self.font_size: Optional[float] = None
        self.bold: Optional[bool] = None
        self.italic: Optional[bool] = None
        self.color: Optional[str] = None


class BaseParser(ABC):
    @abstractmethod
    def read(self, path: str) -> ParsedDocument:
        ...

    @abstractmethod
    def save(self, doc: ParsedDocument, output_path: str):
        ...

    @abstractmethod
    def can_handle(self, path: str) -> bool:
        ...
