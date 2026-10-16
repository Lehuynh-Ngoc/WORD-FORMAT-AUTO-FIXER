import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import pytest

from src.core import ai_config
from src.core.ai_config import (
    add_custom_provider,
    delete_provider,
    get_all_providers,
    remove_custom_provider,
    _save_config,
    _load_config,
)


@pytest.fixture
def temp_config(tmp_path, monkeypatch):
    """Trien khai ai_config vao thu muc tam, khong dot chinh config that."""
    monkeypatch.setattr(ai_config, "CONFIG_DIR", str(tmp_path))
    monkeypatch.setattr(ai_config, "AI_CONFIG_FILE", str(tmp_path / "ai_keys.yaml"))
    monkeypatch.setattr(ai_config, "AI_CONFIG_TEMPLATE", str(tmp_path / "no_template.yaml"))
    return tmp_path


def test_delete_default_provider_writes_yaml_dicts(temp_config):
    """Bug #1: delete_provider cua provider mac dinh phai ghi dict, khong ghi object."""
    _save_config({
        "providers": {
            "deepseek": {
                "api_key": "sk-test",
                "base_url": "https://api.deepseek.com/v1",
                "models": [{"name": "deepseek-chat", "is_active": True}],
                "status": "valid",
            }
        }
    })

    assert delete_provider("deepseek") is True

    # File phai safe_load duoc (khong chua tag !!python/object)
    config = _load_config()
    models = config["providers"]["deepseek"]["models"]
    assert all(isinstance(m, dict) for m in models)
    assert models[0]["name"] == "deepseek-chat"

    # Va get_all_providers doc lai binh thuong
    p = get_all_providers()["deepseek"]
    assert p.api_key == ""
    assert p.model == "deepseek-chat"


def test_load_config_repairs_corrupted_file(temp_config):
    """Phong ve: file config cu chua tag ModelInfo object van doc duoc (tu repair)."""
    corrupted = (
        "providers:\n"
        "  openai:\n"
        "    api_key: sk-old\n"
        "    base_url: https://api.openai.com/v1\n"
        "    models:\n"
        "    - !!python/object:src.core.ai_config.ModelInfo\n"
        "      name: gpt-4o\n"
        "      is_active: true\n"
    )
    config_path = temp_config / "ai_keys.yaml"
    config_path.write_text(corrupted, encoding="utf-8")

    p = get_all_providers()["openai"]
    assert p.model == "gpt-4o"

    # Sau repair, file phai safe_load duoc
    config = _load_config()
    assert config["providers"]["openai"]["api_key"] == "sk-old"


def test_add_custom_provider_duplicate_name(temp_config):
    add_custom_provider("ollama", "Ollama", "http://localhost:11434/v1")
    with pytest.raises(ValueError):
        add_custom_provider("ollama", "Ollama 2", "http://other/v1")


def test_add_custom_provider_reserved_name(temp_config):
    with pytest.raises(ValueError):
        add_custom_provider("openai", "Fake OpenAI", "http://fake/v1")


def test_remove_custom_provider(temp_config):
    add_custom_provider("myapi", "My API", "http://x/v1")
    assert remove_custom_provider("myapi") is True
    assert remove_custom_provider("myapi") is False
    # Khong cho phep xoa provider mac dinh
    assert remove_custom_provider("openai") is False


def test_provider_model_property_roundtrip(temp_config):
    add_custom_provider("ollama", "Ollama", "http://x/v1", model="llama3")
    p = get_all_providers()["ollama"]
    assert p.model == "llama3"
