import os
from docx import Document
from docx.shared import Pt, Emu, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from src.parsers.base import BaseParser, ParsedDocument, ParsedParagraph, ParsedRun


ALIGN_MAP = {
    WD_ALIGN_PARAGRAPH.LEFT: "left",
    WD_ALIGN_PARAGRAPH.CENTER: "center",
    WD_ALIGN_PARAGRAPH.RIGHT: "right",
    WD_ALIGN_PARAGRAPH.JUSTIFY: "justify",
    None: None,
}
ALIGN_REVERSE = {v: k for k, v in ALIGN_MAP.items() if v is not None}


def _emu_to_pt(value) -> float:
    if value is None:
        return None
    return value / 12700


def _pt_to_emu(value: float) -> int:
    return int(value * 12700)


class DocxParser(BaseParser):
    def can_handle(self, path: str) -> bool:
        ext = os.path.splitext(path)[1].lower()
        return ext in (".docx",)

    def read(self, path: str) -> ParsedDocument:
        doc = Document(path)
        result = ParsedDocument(path)
        result.document = doc

        for para in doc.paragraphs:
            pp = ParsedParagraph(
                style_name=para.style.name if para.style else "",
                text=para.text,
            )

            pf = para.paragraph_format
            if pf.alignment:
                pp.alignment = ALIGN_MAP.get(pf.alignment)
            if pf.line_spacing:
                pp.line_spacing = pf.line_spacing
            pp.space_before = _emu_to_pt(pf.space_before)
            pp.space_after = _emu_to_pt(pf.space_after)
            pp.first_line_indent = _emu_to_pt(pf.first_line_indent)

            for run in para.runs:
                pr = ParsedRun()
                pr.text = run.text
                if run.font:
                    pr.font_name = run.font.name
                    if run.font.size:
                        pr.font_size = run.font.size.pt
                    pr.bold = run.font.bold
                    pr.italic = run.font.italic
                    if run.font.color and run.font.color.rgb:
                        pr.color = str(run.font.color.rgb)
                pp.runs.append(pr)

            result.paragraphs.append(pp)

        return result

    def save(self, doc: ParsedDocument, output_path: str):
        document = doc.document or Document()

        for i, pp in enumerate(doc.paragraphs):
            if i >= len(document.paragraphs):
                break
            para = document.paragraphs[i]

            try:
                if pp.style_name and pp.style_name != para.style.name:
                    if pp.style_name in document.styles:
                        para.style = document.styles[pp.style_name]
            except Exception:
                pass

            pf = para.paragraph_format
            if pp.alignment and pp.alignment in ALIGN_REVERSE:
                pf.alignment = ALIGN_REVERSE[pp.alignment]
            if pp.line_spacing is not None:
                pf.line_spacing = pp.line_spacing
            if pp.space_before is not None:
                pf.space_before = _pt_to_emu(pp.space_before)
            if pp.space_after is not None:
                pf.space_after = _pt_to_emu(pp.space_after)
            if pp.first_line_indent is not None:
                pf.first_line_indent = _pt_to_emu(pp.first_line_indent)

            for j, pr in enumerate(pp.runs):
                if j >= len(para.runs):
                    break
                run = para.runs[j]
                f = run.font
                if pr.font_name is not None:
                    f.name = pr.font_name
                if pr.font_size is not None:
                    f.size = Pt(pr.font_size)
                if pr.bold is not None:
                    f.bold = pr.bold
                if pr.italic is not None:
                    f.italic = pr.italic
                if pr.color is not None:
                    try:
                        f.color.rgb = RGBColor(*bytes.fromhex(pr.color))
                    except Exception:
                        pass

        document.save(output_path)
