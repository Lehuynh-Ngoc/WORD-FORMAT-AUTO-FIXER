import os
import json
import logging
import urllib.request
import urllib.error
from typing import Optional, List, Tuple
from dataclasses import dataclass

from src.parsers.factory import get_parser
from src.parsers.base import ParsedDocument
from src.core.ai_config import (
    get_active_provider,
    get_all_providers,
    ProviderConfig,
    APIStatus,
)

logger = logging.getLogger("wordfix")

LANGUAGES = {
    "vi": "Tieng Viet",
    "en": "English",
    "zh": "Tieng Trung",
    "ja": "Tieng Nhat",
    "ko": "Tieng Han",
    "fr": "Tieng Phap",
    "de": "Tieng Duc",
    "es": "Tieng Tay Ban Nha",
    "pt": "Tieng Bo Dao Nha",
    "ru": "Tieng Nga",
    "ar": "Tieng Arab",
    "th": "Tieng Thai",
    "id": "Tieng Indonesian",
    "ms": "Tieng Malaysia",
    "ko": "Tieng Han",
    "it": "Tieng Y",
    "nl": "Tieng Ha Lan",
    "sv": "Tieng Thuy Dien",
    "pl": "Tieng Ba Lan",
    "tr": "Tieng Tho Nhi Ky",
}

CHUNK_SIZE = 3000


@dataclass
class TranslateResult:
    total_paragraphs: int = 0
    translated_paragraphs: int = 0
    skipped_paragraphs: int = 0
    errors: int = 0
    output_path: str = ""
    source_lang: str = ""
    target_lang: str = ""


def _call_api(provider: ProviderConfig, text: str, target_lang: str, source_lang: str = "") -> str:
    lang_name = LANGUAGES.get(target_lang, target_lang)
    source_hint = f" from {LANGUAGES.get(source_lang, source_lang)}" if source_lang else ""

    system_prompt = (
        f"You are a professional translator. Translate the following text to {lang_name}{source_hint}. "
        f"Rules:\n"
        f"- Translate ONLY the text, do not add explanations\n"
        f"- Keep the same meaning and tone\n"
        f"- Keep proper nouns, technical terms, acronyms as-is if commonly kept\n"
        f"- Return ONLY the translated text, nothing else\n"
    )

    if provider.name == "openai":
        return _call_openai(provider, system_prompt, text)
    elif provider.name == "gemini":
        return _call_gemini(provider, system_prompt, text)
    elif provider.name == "claude":
        return _call_claude(provider, system_prompt, text)
    elif provider.name == "deepseek":
        return _call_deepseek(provider, system_prompt, text)
    elif provider.name == "custom":
        return _call_custom(provider, system_prompt, text)
    else:
        raise ValueError(f"Unsupported provider: {provider.name}")


def _call_openai(provider: ProviderConfig, system_prompt: str, user_text: str) -> str:
    payload = json.dumps({
        "model": provider.model,
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_text},
        ],
        "temperature": 0.3,
    }).encode()

    req = urllib.request.Request(
        f"{provider.base_url}/chat/completions",
        data=payload,
        headers={
            "Authorization": f"Bearer {provider.api_key}",
            "Content-Type": "application/json",
        },
    )
    resp = urllib.request.urlopen(req, timeout=120)
    data = json.loads(resp.read().decode())
    return data["choices"][0]["message"]["content"].strip()


def _call_gemini(provider: ProviderConfig, system_prompt: str, user_text: str) -> str:
    full_prompt = f"{system_prompt}\n\nText to translate:\n{user_text}"
    payload = json.dumps({
        "contents": [{"parts": [{"text": full_prompt}]}],
        "generationConfig": {"temperature": 0.3},
    }).encode()

    req = urllib.request.Request(
        f"{provider.base_url}/models/{provider.model}:generateContent?key={provider.api_key}",
        data=payload,
        headers={"Content-Type": "application/json"},
    )
    resp = urllib.request.urlopen(req, timeout=120)
    data = json.loads(resp.read().decode())
    return data["candidates"][0]["content"]["parts"][0]["text"].strip()


def _call_claude(provider: ProviderConfig, system_prompt: str, user_text: str) -> str:
    payload = json.dumps({
        "model": provider.model,
        "max_tokens": 4096,
        "system": system_prompt,
        "messages": [{"role": "user", "content": user_text}],
        "temperature": 0.3,
    }).encode()

    req = urllib.request.Request(
        f"{provider.base_url}/messages",
        data=payload,
        headers={
            "x-api-key": provider.api_key,
            "anthropic-version": "2023-06-01",
            "Content-Type": "application/json",
        },
    )
    resp = urllib.request.urlopen(req, timeout=120)
    data = json.loads(resp.read().decode())
    return data["content"][0]["text"].strip()


def _call_deepseek(provider: ProviderConfig, system_prompt: str, user_text: str) -> str:
    payload = json.dumps({
        "model": provider.model,
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_text},
        ],
        "temperature": 0.3,
    }).encode()

    req = urllib.request.Request(
        f"{provider.base_url}/chat/completions",
        data=payload,
        headers={
            "Authorization": f"Bearer {provider.api_key}",
            "Content-Type": "application/json",
        },
    )
    resp = urllib.request.urlopen(req, timeout=120)
    data = json.loads(resp.read().decode())
    return data["choices"][0]["message"]["content"].strip()


def _call_custom(provider: ProviderConfig, system_prompt: str, user_text: str) -> str:
    payload = json.dumps({
        "model": provider.model,
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_text},
        ],
        "temperature": 0.3,
    }).encode()

    headers = {"Content-Type": "application/json"}
    if provider.api_key:
        headers["Authorization"] = f"Bearer {provider.api_key}"

    req = urllib.request.Request(
        f"{provider.base_url}/chat/completions",
        data=payload,
        headers=headers,
    )
    resp = urllib.request.urlopen(req, timeout=120)
    data = json.loads(resp.read().decode())
    return data["choices"][0]["message"]["content"].strip()


def translate_document(
    input_path: str,
    output_path: str,
    target_lang: str,
    source_lang: str = "",
    provider_name: str = "",
) -> TranslateResult:
    providers = get_all_providers()
    if provider_name:
        provider = providers.get(provider_name)
        if not provider or not provider.api_key:
            raise ValueError(f"Provider '{provider_name}' not found or no API key")
    else:
        provider = get_active_provider()
        if not provider:
            raise ValueError(
                "No active AI provider found. "
                "Please set up an API key in Settings first."
            )

    if provider.status == APIStatus.INVALID:
        raise ValueError(f"API key for {provider.display_name} is invalid")
    if provider.status == APIStatus.LOW_CREDIT:
        logger.warning(f"Warning: {provider.display_name} may be low on credits")

    parser = get_parser(input_path)
    doc = parser.read(input_path)

    result = TranslateResult(
        source_lang=source_lang or "auto",
        target_lang=target_lang,
    )

    paragraphs_to_translate = []
    for i, para in enumerate(doc.paragraphs):
        text = para.text.strip()
        if not text or len(text) < 2:
            result.skipped_paragraphs += 1
            continue
        paragraphs_to_translate.append((i, text))

    result.total_paragraphs = len(paragraphs_to_translate)
    logger.info(f"Translating {result.total_paragraphs} paragraphs with {provider.display_name}...")

    translated_map = {}
    batch = []
    batch_indices = []
    current_len = 0

    for idx, text in paragraphs_to_translate:
        if current_len + len(text) > CHUNK_SIZE and batch:
            translated = _translate_batch(provider, batch, target_lang, source_lang)
            for bi, t in zip(batch_indices, translated):
                translated_map[bi] = t
            batch = []
            batch_indices = []
            current_len = 0

        batch.append(text)
        batch_indices.append(idx)
        current_len += len(text)

    if batch:
        translated = _translate_batch(provider, batch, target_lang, source_lang)
        for bi, t in zip(batch_indices, translated):
            translated_map[bi] = t

    for idx, translated_text in translated_map.items():
        if idx < len(doc.paragraphs):
            para = doc.paragraphs[idx]
            original_text = para.text
            if para.runs:
                first_run = para.runs[0]
                first_run.text = translated_text
                for run in para.runs[1:]:
                    run.text = ""
            else:
                para.text = translated_text
            result.translated_paragraphs += 1

    output_dir = os.path.dirname(os.path.abspath(output_path))
    if output_dir and not os.path.exists(output_dir):
        os.makedirs(output_dir, exist_ok=True)

    parser.save(doc, output_path)
    result.output_path = output_path

    logger.info(
        f"Translation complete: {result.translated_paragraphs}/{result.total_paragraphs} paragraphs"
    )

    return result


def _translate_batch(
    provider: ProviderConfig,
    texts: List[str],
    target_lang: str,
    source_lang: str = "",
) -> List[str]:
    separator = "\n===PARA_SEP===\n"
    combined = separator.join(texts)

    lang_name = LANGUAGES.get(target_lang, target_lang)
    source_hint = f" from {LANGUAGES.get(source_lang, source_lang)}" if source_lang else ""

    system_prompt = (
        f"You are a professional translator. Translate each paragraph below to {lang_name}{source_hint}.\n"
        f"CRITICAL RULES:\n"
        f"- Each paragraph is separated by ===PARA_SEP===\n"
        f"- You MUST keep the exact same separators ===PARA_SEP=== in your output\n"
        f"- Translate ONLY the text content\n"
        f"- Do NOT add explanations, notes, or any extra text\n"
        f"- Output ONLY the translated paragraphs with separators\n"
    )

    try:
        result_text = _call_api(provider, combined, target_lang, source_lang)
    except Exception as e:
        logger.error(f"API call failed: {e}")
        return texts

    parts = result_text.split("===PARA_SEP===")
    parts = [p.strip() for p in parts]

    if len(parts) == len(texts):
        return parts

    logger.warning(
        f"Batch response count mismatch: expected {len(texts)}, got {len(parts)}. "
        f"Falling back to individual translation."
    )
    return _translate_individual(provider, texts, target_lang, source_lang)


def _translate_individual(
    provider: ProviderConfig,
    texts: List[str],
    target_lang: str,
    source_lang: str = "",
) -> List[str]:
    results = []
    for i, text in enumerate(texts):
        try:
            translated = _call_api(provider, text, target_lang, source_lang)
            results.append(translated)
            logger.debug(f"Translated paragraph {i+1}/{len(texts)}")
        except Exception as e:
            logger.error(f"Failed to translate paragraph {i+1}: {e}")
            results.append(text)
    return results


def get_supported_languages() -> dict:
    return LANGUAGES.copy()
