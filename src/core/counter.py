import os
import re
from dataclasses import dataclass, field
from typing import Optional

from src.parsers.factory import get_parser


WORDS_PER_PAGE = 250
CHARS_PER_MINUTE = 1000
WORDS_PER_MINUTE_VI = 200
WORDS_PER_MINUTE_EN = 250


@dataclass
class CountResult:
    file_path: str
    file_name: str = ""
    paragraphs: int = 0
    lines: int = 0
    words: int = 0
    characters_no_space: int = 0
    characters_with_space: int = 0
    pages_estimated: int = 0
    pages_actual: Optional[int] = None
    reading_time_vi: str = ""
    reading_time_en: str = ""
    sections: int = 0
    headings: dict = field(default_factory=dict)
    languages_detected: list = field(default_factory=list)

    def summary(self) -> str:
        lines = []
        lines.append(f"File: {self.file_name}")
        lines.append(f"")
        lines.append(f"--- So luong ---")
        lines.append(f"  Doan (paragraphs):    {self.paragraphs}")
        lines.append(f"  Dong (lines):         {self.lines}")
        lines.append(f"  Tu (words):           {self.words}")
        lines.append(f"  Ky tu (khong space):  {self.characters_no_space}")
        lines.append(f"  Ky tu (co space):     {self.characters_with_space}")
        lines.append(f"  Trang (du dinh):      {self.pages_estimated}")
        if self.pages_actual is not None:
            lines.append(f"  Trang (thuc te):      {self.pages_actual}")
        lines.append(f"")
        lines.append(f"--- Thoi gian doc ---")
        lines.append(f"  Tieng Viet (~200 tu/phut): {self.reading_time_vi}")
        lines.append(f"  English  (~250 tu/phut): {self.reading_time_en}")
        lines.append(f"")
        lines.append(f"--- Cau truc ---")
        lines.append(f"  Sections: {self.sections}")
        for level, count in sorted(self.headings.items()):
            lines.append(f"  {level}: {count}")
        if self.languages_detected:
            lines.append(f"")
            lines.append(f"--- Ngon ngu phat hien ---")
            for lang in self.languages_detected:
                lines.append(f"  - {lang}")
        return "\n".join(lines)


def _format_duration(minutes: float) -> str:
    if minutes < 1:
        return "< 1 phut"
    hours = int(minutes // 60)
    mins = int(minutes % 60)
    if hours == 0:
        return f"{mins} phut"
    if mins == 0:
        return f"{hours} gio"
    return f"{hours} gio {mins} phut"


def _detect_languages(text: str) -> list:
    langs = []
    vi_pattern = re.compile(
        r'[àáảãạăắằẳẵặâấầẩẫậèéẻẽẹêếềểễệìíỉĩịòóỏõọôốồổỗộơớờởỡợùúủũụưứừửữựỳýỷỹỵđÀÁẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬÈÉẺẼẸÊẾỀỂỄỆÌÍỈĨỊÒÓỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÙÚỦŨỤƯỨỪỬỮỰỲÝỶỸỴĐ]'
    )
    en_pattern = re.compile(r'\b[a-zA-Z]{3,}\b')
    if vi_pattern.search(text):
        langs.append("Tieng Viet")
    en_matches = en_pattern.findall(text)
    if len(en_matches) > 10:
        langs.append("English")
    return langs


def count_document(input_path: str) -> CountResult:
    parser = get_parser(input_path)
    doc = parser.read(input_path)

    result = CountResult(
        file_path=input_path,
        file_name=os.path.basename(input_path),
    )

    all_text_parts = []

    for para in doc.paragraphs:
        result.paragraphs += 1
        text = para.text
        if text.strip():
            result.lines += 1

        words = text.split()
        result.words += len(words)
        result.characters_no_space += len(text.replace(" ", "").replace("\t", ""))
        result.characters_with_space += len(text)

        all_text_parts.append(text)

        for run in para.runs:
            style = para.style_name or ""
            if style.startswith("Heading"):
                level = style
                result.headings[level] = result.headings.get(level, 0) + 1

    full_text = "\n".join(all_text_parts)
    result.languages_detected = _detect_languages(full_text)

    result.pages_estimated = max(1, -(-result.words // WORDS_PER_PAGE))

    if hasattr(doc.document, 'sections'):
        result.sections = len(doc.document.sections)

    try:
        import pythoncom
        import win32com.client
        pythoncom.CoInitialize()
        word = win32com.client.DispatchEx("Word.Application")
        word.Visible = False
        word.DisplayAlerts = False
        try:
            abs_path = os.path.abspath(input_path)
            wd_doc = word.Documents.Open(abs_path)
            result.pages_actual = wd_doc.ComputeStatistics(2)
            wd_doc.Close(False)
        except Exception:
            pass
        finally:
            try:
                word.Quit()
            except Exception:
                pass
            pythoncom.CoUninitialize()
    except Exception:
        pass

    minutes_vi = result.words / WORDS_PER_MINUTE_VI
    minutes_en = result.words / WORDS_PER_MINUTE_EN
    result.reading_time_vi = _format_duration(minutes_vi)
    result.reading_time_en = _format_duration(minutes_en)

    return result
