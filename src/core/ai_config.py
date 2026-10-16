import os
import yaml
import logging
import time
from typing import Optional, Dict, Any, List
from dataclasses import dataclass, field
from enum import Enum

logger = logging.getLogger("wordfix")

CONFIG_DIR = os.path.join(os.path.dirname(__file__), "..", "..", "config")
AI_CONFIG_FILE = os.path.join(CONFIG_DIR, "ai_keys.yaml")
AI_CONFIG_TEMPLATE = os.path.join(CONFIG_DIR, "ai_keys_template.yaml")


class APIStatus(Enum):
    VALID = "valid"
    LOW_CREDIT = "low_credit"
    INVALID = "invalid"
    ERROR = "error"
    UNCHECKED = "unchecked"


@dataclass
class ModelInfo:
    name: str
    is_active: bool = False


@dataclass
class ProviderConfig:
    name: str
    display_name: str
    api_key: str = ""
    base_url: str = ""
    models: List[ModelInfo] = field(default_factory=list)
    status: APIStatus = APIStatus.UNCHECKED
    last_checked: str = ""
    credit_info: str = ""

    @property
    def model(self) -> str:
        for m in self.models:
            if m.is_active:
                return m.name
        return self.models[0].name if self.models else ""

    @model.setter
    def model(self, value: str):
        for m in self.models:
            m.is_active = (m.name == value)
        if not any(m.is_active for m in self.models) and value:
            self.models.append(ModelInfo(name=value, is_active=True))


DEFAULT_MODELS: Dict[str, List[str]] = {
    "openai": ["gpt-4o", "gpt-4o-mini", "gpt-4-turbo", "gpt-3.5-turbo"],
    "gemini": ["gemini-2.5-flash", "gemini-2.0-flash", "gemini-1.5-pro", "gemini-1.5-flash"],
    "claude": [
        "claude-sonnet-4-20250514",
        "claude-3-5-sonnet-20241022",
        "claude-3-5-haiku-20241022",
        "claude-3-haiku-20240307",
    ],
    "deepseek": ["deepseek-chat", "deepseek-reasoner"],
}

DEFAULT_BASE_URLS: Dict[str, str] = {
    "openai": "https://api.openai.com/v1",
    "gemini": "https://generativelanguage.googleapis.com/v1beta",
    "claude": "https://api.anthropic.com/v1",
    "deepseek": "https://api.deepseek.com/v1",
}

DEFAULT_DISPLAY_NAMES: Dict[str, str] = {
    "openai": "OpenAI (GPT)",
    "gemini": "Google Gemini",
    "claude": "Anthropic Claude",
    "deepseek": "DeepSeek",
}


def _models_from_list(names: List[str], active: str = "") -> List[ModelInfo]:
    if not active and names:
        active = names[0]
    return [ModelInfo(name=n, is_active=(n == active)) for n in names]


class _ModelInfoSafeLoader(yaml.SafeLoader):
    """SafeLoader bo sung xu ly tag !!python/object:...ModelInfo (config bi hong tu version cu)."""


def _modelinfo_constructor(loader, node):
    values = loader.construct_mapping(node, deep=True)
    return {
        "name": values.get("name", ""),
        "is_active": values.get("is_active", False),
    }


_ModelInfoSafeLoader.add_constructor(
    "tag:yaml.org,2002:python/object:src.core.ai_config.ModelInfo",
    _modelinfo_constructor,
)
_ModelInfoSafeLoader.add_constructor(
    "tag:yaml.org,2002:python/object:__main__.ModelInfo",
    _modelinfo_constructor,
)


def _load_config() -> Dict[str, Any]:
    if not os.path.exists(AI_CONFIG_FILE):
        if os.path.exists(AI_CONFIG_TEMPLATE):
            os.makedirs(CONFIG_DIR, exist_ok=True)
            import shutil
            shutil.copy2(AI_CONFIG_TEMPLATE, AI_CONFIG_FILE)
        else:
            return {}
    with open(AI_CONFIG_FILE, encoding="utf-8") as f:
        raw = f.read()
    try:
        return yaml.safe_load(raw) or {}
    except yaml.constructor.ConstructorError:
        logger.warning(
            f"Config {AI_CONFIG_FILE} chua tag khong hop le (likely ModelInfo object). "
            "Dang tu repair..."
        )
        data = yaml.load(raw, Loader=_ModelInfoSafeLoader) or {}
        _save_config(data)
        logger.info("Da repair config file thanh cong.")
        return data


def _save_config(data: Dict[str, Any]):
    os.makedirs(CONFIG_DIR, exist_ok=True)
    with open(AI_CONFIG_FILE, "w", encoding="utf-8") as f:
        yaml.dump(data, f, allow_unicode=True, default_flow_style=False, sort_keys=False)


def _provider_to_dict(p: ProviderConfig) -> dict:
    return {
        "api_key": p.api_key,
        "base_url": p.base_url,
        "models": [{"name": m.name, "is_active": m.is_active} for m in p.models],
        "status": p.status.value,
        "last_checked": p.last_checked,
        "credit_info": p.credit_info,
    }


def _dict_to_provider(name: str, data: dict, default_models: List[str] = None) -> ProviderConfig:
    display = DEFAULT_DISPLAY_NAMES.get(name, name.title())
    base_url = data.get("base_url", DEFAULT_BASE_URLS.get(name, ""))

    models_data = data.get("models", [])
    if models_data:
        models = []
        for m in models_data:
            if isinstance(m, str):
                models.append(ModelInfo(name=m, is_active=False))
            elif isinstance(m, dict):
                models.append(ModelInfo(
                    name=m.get("name", ""),
                    is_active=m.get("is_active", False),
                ))
        if not any(m.is_active for m in models) and models:
            models[0].is_active = True
    else:
        old_model = data.get("model", "")
        if old_model and default_models:
            merged = []
            merged.append(ModelInfo(name=old_model, is_active=True))
            for dm in default_models:
                if dm != old_model:
                    merged.append(ModelInfo(name=dm, is_active=False))
            models = merged
        elif old_model:
            models = _models_from_list([old_model], old_model)
        elif default_models:
            models = _models_from_list(default_models, default_models[0])
        else:
            models = []

    status_str = data.get("status", "unchecked")
    try:
        status = APIStatus(status_str)
    except ValueError:
        status = APIStatus.UNCHECKED

    return ProviderConfig(
        name=name,
        display_name=display,
        api_key=data.get("api_key", ""),
        base_url=base_url,
        models=models,
        status=status,
        last_checked=data.get("last_checked", ""),
        credit_info=data.get("credit_info", ""),
    )


def get_all_providers() -> Dict[str, ProviderConfig]:
    config = _load_config()
    saved = config.get("providers", {})
    result = {}

    all_names = list(set(list(DEFAULT_MODELS.keys()) + list(saved.keys())))
    for name in all_names:
        default_models = DEFAULT_MODELS.get(name, [])
        if name in saved:
            result[name] = _dict_to_provider(name, saved[name], default_models)
        else:
            result[name] = ProviderConfig(
                name=name,
                display_name=DEFAULT_DISPLAY_NAMES.get(name, name.title()),
                base_url=DEFAULT_BASE_URLS.get(name, ""),
                models=_models_from_list(default_models) if default_models else [],
            )

    return result


def save_provider(provider: ProviderConfig):
    config = _load_config()
    if "providers" not in config:
        config["providers"] = {}
    config["providers"][provider.name] = _provider_to_dict(provider)
    _save_config(config)


def _models_to_dicts(models: List[ModelInfo]) -> List[dict]:
    return [{"name": m.name, "is_active": m.is_active} for m in models]


def delete_provider(name: str) -> bool:
    config = _load_config()
    providers = config.get("providers", {})
    if name not in providers:
        return False
    if name in DEFAULT_MODELS:
        default_models = DEFAULT_MODELS.get(name, [])
        providers[name] = {
            "api_key": "",
            "base_url": DEFAULT_BASE_URLS.get(name, ""),
            "models": _models_to_dicts(_models_from_list(default_models, default_models[0])) if default_models else [],
            "status": "unchecked",
            "last_checked": "",
            "credit_info": "",
        }
    else:
        del providers[name]
    config["providers"] = providers
    _save_config(config)
    return True


def add_custom_provider(name: str, display_name: str, base_url: str,
                        api_key: str = "", model: str = "") -> ProviderConfig:
    name = name.strip().lower().replace(" ", "_")
    config = _load_config()
    providers = config.get("providers", {})
    if name in DEFAULT_MODELS:
        raise ValueError(f"Ten '{name}' da ton tai. Hay chon ten khac.")
    if name in providers:
        raise ValueError(f"Custom provider '{name}' da ton tai. Hay chon ten khac.")
    models = _models_from_list([model] if model else ["default"], model or "default")
    p = ProviderConfig(
        name=name,
        display_name=display_name or name.title(),
        api_key=api_key,
        base_url=base_url,
        models=models,
    )
    providers[name] = _provider_to_dict(p)
    config["providers"] = providers
    _save_config(config)
    return p


def remove_custom_provider(name: str) -> bool:
    if name in DEFAULT_MODELS:
        return False
    config = _load_config()
    providers = config.get("providers", {})
    if name not in providers:
        return False
    del providers[name]
    config["providers"] = providers
    _save_config(config)
    return True


def get_active_provider() -> Optional[ProviderConfig]:
    providers = get_all_providers()
    for name in ["openai", "gemini", "claude", "deepseek"] + [n for n in providers if n not in DEFAULT_MODELS]:
        p = providers.get(name)
        if p and p.api_key and p.model and p.status in (APIStatus.VALID, APIStatus.UNCHECKED):
            return p
    return None


def set_active_model(provider_name: str, model_name: str) -> bool:
    providers = get_all_providers()
    p = providers.get(provider_name)
    if not p:
        return False
    p.model = model_name
    save_provider(p)
    return True


def add_model_to_provider(provider_name: str, model_name: str) -> bool:
    providers = get_all_providers()
    p = providers.get(provider_name)
    if not p:
        return False
    if any(m.name == model_name for m in p.models):
        return False
    p.models.append(ModelInfo(name=model_name, is_active=not bool(p.models)))
    save_provider(p)
    return True


def remove_model_from_provider(provider_name: str, model_name: str) -> bool:
    providers = get_all_providers()
    p = providers.get(provider_name)
    if not p:
        return False
    if len(p.models) <= 1:
        return False
    p.models = [m for m in p.models if m.name != model_name]
    if not any(m.is_active for m in p.models):
        p.models[0].is_active = True
    save_provider(p)
    return True


def rename_model_in_provider(provider_name: str, old_name: str, new_name: str) -> bool:
    providers = get_all_providers()
    p = providers.get(provider_name)
    if not p:
        return False
    for m in p.models:
        if m.name == old_name:
            m.name = new_name
            save_provider(p)
            return True
    return False


def check_api_key(provider_name: str) -> ProviderConfig:
    providers = get_all_providers()
    p = providers.get(provider_name)
    if not p:
        raise ValueError(f"Provider not found: {provider_name}")

    if not p.api_key:
        p.status = APIStatus.UNCHECKED
        p.credit_info = "Chua nhap API key"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
        save_provider(p)
        return p

    try:
        if provider_name == "openai":
            return _check_openai(p)
        elif provider_name == "gemini":
            return _check_gemini(p)
        elif provider_name == "claude":
            return _check_claude(p)
        elif provider_name == "deepseek":
            return _check_deepseek(p)
        else:
            return _check_custom(p)
    except Exception as e:
        p.status = APIStatus.ERROR
        p.credit_info = f"Loi: {str(e)[:80]}"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
        save_provider(p)

    return p


def _check_openai(p: ProviderConfig) -> ProviderConfig:
    import urllib.request
    import urllib.error
    import json

    req = urllib.request.Request(
        f"{p.base_url}/models",
        headers={
            "Authorization": f"Bearer {p.api_key}",
            "Content-Type": "application/json",
        },
    )
    try:
        resp = urllib.request.urlopen(req, timeout=15)
        data = json.loads(resp.read().decode())
        model_count = len(data.get("data", []))
        p.status = APIStatus.VALID
        p.credit_info = f"Hop le. {model_count} models kha dung."
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    except urllib.error.HTTPError as e:
        if e.code == 401:
            p.status = APIStatus.INVALID
            p.credit_info = "API key khong hop le (401)"
        elif e.code == 429:
            p.status = APIStatus.LOW_CREDIT
            p.credit_info = "Rate limited hoac het credit (429)"
        else:
            p.status = APIStatus.ERROR
            p.credit_info = f"HTTP {e.code}: {e.read().decode()[:60]}"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    except Exception as e:
        p.status = APIStatus.ERROR
        p.credit_info = f"Loi ket noi: {str(e)[:60]}"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    save_provider(p)
    return p


def _check_gemini(p: ProviderConfig) -> ProviderConfig:
    import urllib.request
    import urllib.error
    import json

    url = f"{p.base_url}/models?key={p.api_key}"
    req = urllib.request.Request(url)
    try:
        resp = urllib.request.urlopen(req, timeout=15)
        data = json.loads(resp.read().decode())
        model_count = len(data.get("models", []))
        p.status = APIStatus.VALID
        p.credit_info = f"Hop le. {model_count} models kha dung."
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    except urllib.error.HTTPError as e:
        if e.code == 400 or e.code == 403:
            p.status = APIStatus.INVALID
            p.credit_info = f"API key khong hop le ({e.code})"
        elif e.code == 429:
            p.status = APIStatus.LOW_CREDIT
            p.credit_info = "Rate limited (429)"
        else:
            p.status = APIStatus.ERROR
            p.credit_info = f"HTTP {e.code}"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    except Exception as e:
        p.status = APIStatus.ERROR
        p.credit_info = f"Loi ket noi: {str(e)[:60]}"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    save_provider(p)
    return p


def _check_claude(p: ProviderConfig) -> ProviderConfig:
    import urllib.request
    import urllib.error
    import json

    payload = json.dumps({
        "model": p.model,
        "max_tokens": 10,
        "messages": [{"role": "user", "content": "hi"}],
    }).encode()

    req = urllib.request.Request(
        f"{p.base_url}/messages",
        data=payload,
        headers={
            "x-api-key": p.api_key,
            "anthropic-version": "2023-06-01",
            "Content-Type": "application/json",
        },
    )
    try:
        resp = urllib.request.urlopen(req, timeout=15)
        data = json.loads(resp.read().decode())
        if data.get("content"):
            p.status = APIStatus.VALID
            p.credit_info = "Hop le. API key hoat dong tot."
        else:
            p.status = APIStatus.VALID
            p.credit_info = "Hop le (response rong)."
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    except urllib.error.HTTPError as e:
        body = ""
        try:
            body = e.read().decode()[:100]
        except Exception:
            pass
        if e.code == 401:
            p.status = APIStatus.INVALID
            p.credit_info = "API key khong hop le (401)"
        elif e.code == 429:
            p.status = APIStatus.LOW_CREDIT
            p.credit_info = "Rate limited (429)"
        elif e.code == 400 and "credit" in body.lower():
            p.status = APIStatus.LOW_CREDIT
            p.credit_info = "Het credit (400)"
        else:
            p.status = APIStatus.ERROR
            p.credit_info = f"HTTP {e.code}: {body[:50]}"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    except Exception as e:
        p.status = APIStatus.ERROR
        p.credit_info = f"Loi ket noi: {str(e)[:60]}"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    save_provider(p)
    return p


def _check_deepseek(p: ProviderConfig) -> ProviderConfig:
    import urllib.request
    import urllib.error
    import json

    req = urllib.request.Request(
        f"{p.base_url}/models",
        headers={
            "Authorization": f"Bearer {p.api_key}",
            "Content-Type": "application/json",
        },
    )
    try:
        resp = urllib.request.urlopen(req, timeout=15)
        data = json.loads(resp.read().decode())
        p.status = APIStatus.VALID
        p.credit_info = "Hop le. API key hoat dong."
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    except urllib.error.HTTPError as e:
        if e.code == 401:
            p.status = APIStatus.INVALID
            p.credit_info = "API key khong hop le (401)"
        elif e.code == 429:
            p.status = APIStatus.LOW_CREDIT
            p.credit_info = "Rate limited (429)"
        else:
            p.status = APIStatus.ERROR
            p.credit_info = f"HTTP {e.code}"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    except Exception as e:
        p.status = APIStatus.ERROR
        p.credit_info = f"Loi ket noi: {str(e)[:60]}"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    save_provider(p)
    return p


def _check_custom(p: ProviderConfig) -> ProviderConfig:
    import urllib.request
    import urllib.error
    import json

    if not p.base_url:
        p.status = APIStatus.INVALID
        p.credit_info = "Chua nhap base URL"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
        save_provider(p)
        return p

    headers = {"Content-Type": "application/json"}
    if p.api_key:
        headers["Authorization"] = f"Bearer {p.api_key}"

    payload = json.dumps({
        "model": p.model or "default",
        "messages": [{"role": "user", "content": "hi"}],
        "max_tokens": 10,
    }).encode()

    req = urllib.request.Request(
        f"{p.base_url}/chat/completions",
        data=payload,
        headers=headers,
    )
    try:
        resp = urllib.request.urlopen(req, timeout=15)
        data = json.loads(resp.read().decode())
        p.status = APIStatus.VALID
        p.credit_info = "Hop le. Custom API hoat dong."
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    except urllib.error.HTTPError as e:
        if e.code == 401:
            p.status = APIStatus.INVALID
            p.credit_info = "API key khong hop le (401)"
        elif e.code == 429:
            p.status = APIStatus.LOW_CREDIT
            p.credit_info = "Rate limited (429)"
        else:
            p.status = APIStatus.ERROR
            p.credit_info = f"HTTP {e.code}"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    except Exception as e:
        p.status = APIStatus.ERROR
        p.credit_info = f"Loi ket noi: {str(e)[:60]}"
        p.last_checked = time.strftime("%Y-%m-%d %H:%M:%S")
    save_provider(p)
    return p


def get_provider_status_color(status: APIStatus) -> str:
    colors = {
        APIStatus.VALID: "\033[32m",
        APIStatus.LOW_CREDIT: "\033[33m",
        APIStatus.INVALID: "\033[31m",
        APIStatus.ERROR: "\033[31m",
        APIStatus.UNCHECKED: "\033[90m",
    }
    return colors.get(status, "\033[0m")


def get_provider_status_label(status: APIStatus) -> str:
    labels = {
        APIStatus.VALID: "HOP LE",
        APIStatus.LOW_CREDIT: "GAN HET",
        APIStatus.INVALID: "KHONG HOP LE",
        APIStatus.ERROR: "LOI",
        APIStatus.UNCHECKED: "CHUA KIEM TRA",
    }
    return labels.get(status, "UNKNOWN")
