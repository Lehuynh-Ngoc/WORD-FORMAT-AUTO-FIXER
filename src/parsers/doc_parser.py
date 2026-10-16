import os
import shutil
import tempfile
import pythoncom
import win32com.client
from src.parsers.base import BaseParser, ParsedDocument, ParsedParagraph, ParsedRun


class DocParser(BaseParser):
    def can_handle(self, path: str) -> bool:
        ext = os.path.splitext(path)[1].lower()
        return ext in (".doc",)

    def read(self, path: str) -> ParsedDocument:
        pythoncom.CoInitialize()
        abs_path = os.path.abspath(path)
        tmp_copy = os.path.join(
            tempfile.gettempdir(),
            f"~wordfix_{os.path.basename(path)}"
        )
        self._temp_path = os.path.splitext(tmp_copy)[0] + ".docx"

        word = None
        try:
            shutil.copy2(abs_path, tmp_copy)
            word = win32com.client.DispatchEx("Word.Application")
            word.Visible = False
            word.DisplayAlerts = False
            word.ScreenUpdating = False

            doc = word.Documents.Open(tmp_copy)
            doc.SaveAs(self._temp_path, FileFormat=12)
            doc.Close()
        finally:
            if word:
                try:
                    word.Quit()
                except Exception:
                    pass
            pythoncom.CoUninitialize()
            try:
                os.remove(tmp_copy)
            except OSError:
                pass

        from src.parsers.docx_parser import DocxParser
        return DocxParser().read(self._temp_path)

    def save(self, doc: ParsedDocument, output_path: str):
        output_ext = os.path.splitext(output_path)[1].lower()

        from src.parsers.docx_parser import DocxParser
        temp_path = self._temp_path if hasattr(self, '_temp_path') else os.path.join(
            tempfile.gettempdir(),
            f"~wordfix_save_{os.path.basename(output_path)}x"
        )
        DocxParser().save(doc, temp_path)

        if output_ext == ".docx":
            shutil.move(temp_path, output_path)
            return

        pythoncom.CoInitialize()
        word = None
        try:
            word = win32com.client.DispatchEx("Word.Application")
            word.Visible = False
            word.DisplayAlerts = False
            word.ScreenUpdating = False

            wd = word.Documents.Open(os.path.abspath(temp_path))
            wd.SaveAs(os.path.abspath(output_path), FileFormat=0)
            wd.Close()
        except ImportError:
            shutil.move(temp_path, output_path.replace(".doc", ".docx"))
            return
        finally:
            if word:
                try:
                    word.Quit()
                except Exception:
                    pass
            pythoncom.CoUninitialize()

        try:
            if os.path.exists(temp_path):
                os.remove(temp_path)
        except PermissionError:
            pass
