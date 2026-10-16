import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from src.core.ai_config import ProviderConfig, ModelInfo
from src.core import translator
from src.core.translator import (
    _call_api,
    _call_with_prompt,
    _translate_batch,
    _translate_individual,
    LANGUAGES,
)


def make_provider(name="custom", model="test-model"):
    return ProviderConfig(
        name=name,
        display_name=name.title(),
        api_key="test-key",
        base_url="http://localhost/v1",
        models=[ModelInfo(name=model, is_active=True)],
    )


def test_custom_provider_name_routes_to_custom_call(monkeypatch):
    """Bug #2: provider custom co ten tuy y (khong chi 'custom') phai duoc dispatch."""
    called = {}

    def fake_call_custom(provider, system_prompt, user_text):
        called["prompt"] = system_prompt
        called["text"] = user_text
        return "translated"

    monkeypatch.setattr(translator, "_call_custom", fake_call_custom)

    provider = make_provider(name="ollama")
    result = _call_api(provider, "xin chao", "en")

    assert result == "translated"
    assert called["text"] == "xin chao"


def test_known_providers_still_route_correctly(monkeypatch):
    def fake_openai(provider, system_prompt, user_text):
        return "openai-result"

    monkeypatch.setattr(translator, "_call_openai", fake_openai)
    provider = make_provider(name="openai")
    assert _call_api(provider, "text", "en") == "openai-result"


def test_translate_batch_uses_separator_system_prompt(monkeypatch):
    """Bug #3: prompt batch (chua ===PARA_SEP===) phai duoc gui di, khong bi bo qua."""
    captured = {}

    def fake_call_with_prompt(provider, system_prompt, text):
        captured["system_prompt"] = system_prompt
        captured["text"] = text
        n = len(text.split("===PARA_SEP==="))
        return "===PARA_SEP===".join([f"para{i}" for i in range(n)])

    monkeypatch.setattr(translator, "_call_with_prompt", fake_call_with_prompt)

    provider = make_provider()
    texts = ["dong mot", "dong hai", "dong ba"]
    result, errors = _translate_batch(provider, texts, "en")

    assert "===PARA_SEP===" in captured["system_prompt"]
    assert captured["text"].count("===PARA_SEP===") == 2
    assert result == ["para0", "para1", "para2"]
    assert errors == 0


def test_translate_batch_api_failure_counts_errors(monkeypatch):
    def fake_call_with_prompt(provider, system_prompt, text):
        raise ConnectionError("network down")

    monkeypatch.setattr(translator, "_call_with_prompt", fake_call_with_prompt)

    provider = make_provider()
    texts = ["mot", "hai"]
    result, errors = _translate_batch(provider, texts, "en")

    assert result == texts  # giu nguyen text goc
    assert errors == 2      # moi doan = 1 loi


def test_translate_individual_counts_errors(monkeypatch):
    def fake_call_api(provider, text, target_lang, source_lang=""):
        if text == "loi":
            raise ConnectionError("fail")
        return f"ok-{text}"

    monkeypatch.setattr(translator, "_call_api", fake_call_api)

    provider = make_provider()
    result, errors = _translate_individual(provider, ["tot", "loi", "tot2"], "en")

    assert result == ["ok-tot", "loi", "ok-tot2"]
    assert errors == 1


def test_batch_mismatch_falls_back_to_individual(monkeypatch):
    def fake_call_with_prompt(provider, system_prompt, text):
        return "khong co separator"  # gay mismatch

    monkeypatch.setattr(translator, "_call_with_prompt", fake_call_with_prompt)

    def fake_call_api(provider, text, target_lang, source_lang=""):
        return f"individual-{text}"

    monkeypatch.setattr(translator, "_call_api", fake_call_api)

    provider = make_provider()
    result, errors = _translate_batch(provider, ["a", "b"], "en")

    assert result == ["individual-a", "individual-b"]
    assert errors == 0


def test_languages_no_duplicate_behavior():
    # "ko" chi xuat hien mot lan, gia tri dung
    assert LANGUAGES["ko"] == "Tieng Han"
    assert len([k for k in LANGUAGES if k == "ko"]) == 1
