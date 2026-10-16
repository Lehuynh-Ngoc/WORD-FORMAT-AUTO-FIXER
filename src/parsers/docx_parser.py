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


def iter_document_paragraphs(doc):
    """Yield moi paragraph theo dung thu tu document — gom ca paragraph trong bang (table).

    Duyet truc tiep XML body de giu thu tu that (doan - bang - doan...),
    vi doc.paragraphs chi tra ve cac doan o cap body.
    Cell merge (ngang/doc) co the xuat hien nhieu lan trong row.cells — dedup bang
    id(cell._tc) de khong doc/trung ghi 2 lan.
    """
    from docx.table import Table
    from docx.text.paragraph import Paragraph

    for child in doc.element.body.iterchildren():
        tag = child.tag
        if tag.endswith("}p"):
            yield Paragraph(child, doc)
        elif tag.endswith("}tbl"):
            table = Table(child, doc)
            for row in table.rows:
                seen = set()
                for cell in row.cells:
                    if id(cell._tc) in seen:
                        continue
                    seen.add(id(cell._tc))
                    for para in cell.paragraphs:
                        yield para


class DocxParser(BaseParser):
    def can_handle(self, path: str) -> bool:
        ext = os.path.splitext(path)[1].lower()
        return ext in (".docx",)

    def read(self, path: str) -> ParsedDocument:
        doc = Document(path)
        result = ParsedDocument(path)
        result.document = doc

        for para in iter_document_paragraphs(doc):
            pp = ParsedParagraph(
                style_name=para.style.name if para.style else "",
                text=para.text,
            )
            pp.source = para  # giu tham chiếu de save() ghi dung cho (gồm table)

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

        # Thu tu paragraph nhu khi read (gồm table) — dung cho fallback khi khong co source
        all_paras = list(iter_document_paragraphs(document))

        for i, pp in enumerate(doc.paragraphs):
            # uu tien tham chiếu source (dung cho ca paragraph trong table),
            # fallback theo thu tu neu parser khac tao ParsedDocument thu cong
            para = getattr(pp, "source", None)
            if para is None:
                if i >= len(all_paras):
                    break
                para = all_paras[i]

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

            # Ghi tro lai text neu bi sua (vi du: dich thuac) — truoc day save()
            # chi ghi style/font, lam cho translate ra file giong nhu ban dau.
            if len(para.runs) == len(pp.runs):
                for run, pr in zip(para.runs, pp.runs):
                    if pr.text != run.text:
                        run.text = pr.text
            elif pp.text and pp.text != para.text:
                para.text = pp.text

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
