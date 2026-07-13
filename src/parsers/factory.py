import os
from typing import List
from src.parsers.base import BaseParser
from src.parsers.docx_parser import DocxParser
from src.parsers.doc_parser import DocParser


PARSERS: List[BaseParser] = [DocxParser(), DocParser()]


def get_parser(path: str) -> BaseParser:
    for p in PARSERS:
        if p.can_handle(path):
            return p
    raise ValueError(
        f"Unsupported file format: {path}. "
        f"Supported: .docx, .doc"
    )
