import os
import shutil
import time
import tempfile
import logging
import pythoncom
import win32com.client

logger = logging.getLogger("wordfix")

WD_FORMATS = {
    ".doc": 0,
    ".dot": 1,
    ".docx": 12,
    ".docm": 13,
    ".dotx": 14,
    ".dotm": 15,
    ".pdf": 17,
}

WD_PASTE_ORIGINAL = 16

RPC_E_CALL_REJECTED = -2147418111
MAX_RETRIES = 10
RETRY_DELAY = 1


def _com_call(func, *args, **kwargs):
    for attempt in range(MAX_RETRIES):
        try:
            return func(*args, **kwargs)
        except pythoncom.com_error as e:
            if e.hresult == RPC_E_CALL_REJECTED and attempt < MAX_RETRIES - 1:
                logger.debug(f"COM busy, retry {attempt + 1}/{MAX_RETRIES}...")
                pythoncom.PumpWaitingMessages()
                time.sleep(RETRY_DELAY * (attempt + 1))
                continue
            raise


def _start_word(visible=False):
    try:
        word = win32com.client.DispatchEx("Word.Application")
    except Exception:
        try:
            word = win32com.client.gencache.EnsureDispatch("Word.Application")
        except Exception as e:
            raise RuntimeError(
                "Khong the khoi tao Microsoft Word. "
                "Vui long cai dat Microsoft Word tren may tinh.\n"
                f"Chi tiet: {e}"
            ) from e
    word.Visible = visible
    word.DisplayAlerts = False
    word.ScreenUpdating = False
    return word


def _safe_quit_word(word):
    try:
        if word:
            word.ScreenUpdating = True
            word.Quit()
    except Exception:
        pass


def _format_com_error(e):
    try:
        hex_hresult = f"0x{e.hresult & 0xFFFFFFFF:08X}"
    except Exception:
        hex_hresult = str(e.hresult)
    return f"{hex_hresult} - {e.strerror or 'Unknown error'}"


def _strip_all_content(doc):
    full_range = doc.Range()
    if full_range.Start < full_range.End:
        full_range.Delete()
    if doc.Paragraphs.Count > 0:
        full_range2 = doc.Range()
        if full_range2.Start < full_range2.End:
            full_range2.Delete()


class CloneEngine:
    def __init__(self, visible: bool = False):
        self.visible = visible

    def clone(self, template_path: str, target_path: str, output_path: str, preview_only: bool = False) -> str:
        abs_template = os.path.abspath(template_path)
        abs_target = os.path.abspath(target_path)
        abs_output = os.path.abspath(output_path)

        if not os.path.exists(abs_template):
            raise FileNotFoundError(f"Template not found: {abs_template}")
        if not os.path.exists(abs_target):
            raise FileNotFoundError(f"Target not found: {abs_target}")

        output_dir = os.path.dirname(abs_output)
        if output_dir and not os.path.exists(output_dir):
            os.makedirs(output_dir, exist_ok=True)
            logger.info(f"Created output directory: {output_dir}")

        template_ext = os.path.splitext(abs_template)[1].lower()
        output_ext = os.path.splitext(abs_output)[1].lower()
        save_format = WD_FORMATS.get(output_ext, 12)

        fd, tmp_clean = tempfile.mkstemp(suffix=template_ext)
        os.close(fd)

        pythoncom.CoInitialize()
        word = None
        try:
            shutil.copy2(abs_template, tmp_clean)
            logger.debug(f"Template copied to temp: {tmp_clean}")

            word = _start_word(self.visible)

            logger.debug("Step 1: Stripping template content...")
            _com_call(word.Documents.Open, tmp_clean)
            _strip_all_content(word.ActiveDocument)
            _com_call(word.ActiveDocument.Save)
            _com_call(word.ActiveDocument.Close, False)

            logger.debug("Step 2: Copying target content to clipboard...")
            _com_call(word.Documents.Open, abs_target)
            _com_call(word.Selection.WholeStory)
            _com_call(word.Selection.Copy)
            _com_call(word.ActiveDocument.Close, False)

            logger.debug("Step 3: Pasting into cleaned template...")
            _com_call(word.Documents.Add, tmp_clean)
            _com_call(word.Selection.PasteAndFormat, WD_PASTE_ORIGINAL)

            if preview_only:
                preview_dir = tempfile.mkdtemp(prefix="wordfix_preview_")
                preview_path = os.path.join(preview_dir, os.path.basename(abs_output))
                logger.debug(f"Step 4 (preview): Saving to temp: {preview_path}")
                _com_call(word.ActiveDocument.SaveAs, preview_path, save_format)
                _com_call(word.ActiveDocument.Close, False)
                word.Visible = True
                word.DisplayAlerts = True
                word.ScreenUpdating = True
                logger.info(f"Preview file: {preview_path}")
                logger.info("Word is now visible. Review the document, then close Word.")
                logger.info(f"After reviewing, the preview file will be at: {preview_path}")
                return preview_path
            else:
                logger.debug(f"Step 4: Saving output to: {abs_output}")
                _com_call(word.ActiveDocument.SaveAs, abs_output, save_format)
                _com_call(word.ActiveDocument.Close, False)

                if not os.path.exists(abs_output):
                    raise RuntimeError(f"Failed to create output file: {abs_output}")

                logger.info(f"Clone completed: {abs_output}")
                return abs_output

        except pythoncom.com_error as e:
            error_msg = _format_com_error(e)
            raise RuntimeError(f"Word COM error: {error_msg}") from e

        finally:
            _safe_quit_word(word)
            pythoncom.CoUninitialize()
            if os.path.exists(tmp_clean):
                try:
                    os.remove(tmp_clean)
                except OSError:
                    pass
