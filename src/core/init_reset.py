import os
import shutil
import glob
from typing import List, Tuple

BASE_DIR = os.path.join(os.path.dirname(__file__), "..", "..")

DEFAULT_DIRS = [
    "config",
    "outputs",
    "mau",
    "rules",
]

DEFAULT_FILES = {
    "config/ai_keys_template.yaml": "config/ai_keys_template.yaml",
}

RESET_KEEP_FILES = [
    "rules/default.yaml",
    "rules/academic.yaml",
]

RESET_DELETE_PATTERNS = [
    "config/ai_keys.yaml",
    "outputs/*",
    "rules/learned_rules.yaml",
    "rules/custom_rules.yaml",
    "rules/smart_patterns.yaml",
]


def _abs(path: str) -> str:
    return os.path.join(BASE_DIR, path)


def init_project() -> Tuple[List[str], List[str]]:
    created_dirs = []
    created_files = []

    for d in DEFAULT_DIRS:
        path = _abs(d)
        if not os.path.exists(path):
            os.makedirs(path, exist_ok=True)
            created_dirs.append(d)

    for src_name, dst_name in DEFAULT_FILES.items():
        src = _abs(src_name)
        dst = _abs(dst_name)
        if not os.path.exists(dst) and os.path.exists(src):
            shutil.copy2(src, dst)
            created_files.append(dst_name)

    outputs_gitkeep = _abs("outputs/.gitkeep")
    if not os.path.exists(outputs_gitkeep):
        with open(outputs_gitkeep, "w") as f:
            pass
        if "outputs" not in [d for d in created_dirs]:
            created_files.append("outputs/.gitkeep")

    return created_dirs, created_files


def reset_project() -> Tuple[List[str], List[str]]:
    deleted_files = []
    kept_files = []

    for pattern in RESET_DELETE_PATTERNS:
        full_pattern = _abs(pattern)
        matches = glob.glob(full_pattern)
        for match in matches:
            if os.path.isfile(match):
                os.remove(match)
                rel = os.path.relpath(match, BASE_DIR)
                deleted_files.append(rel)
            elif os.path.isdir(match):
                shutil.rmtree(match)
                rel = os.path.relpath(match, BASE_DIR)
                deleted_files.append(rel + "/")

    outputs_dir = _abs("outputs")
    if os.path.exists(outputs_dir):
        gitkeep = os.path.join(outputs_dir, ".gitkeep")
        if not os.path.exists(gitkeep):
            with open(gitkeep, "w") as f:
                pass

    for f in RESET_KEEP_FILES:
        path = _abs(f)
        if os.path.exists(path):
            kept_files.append(f)

    return deleted_files, kept_files


def get_status() -> dict:
    status = {}
    for d in DEFAULT_DIRS:
        status[d] = os.path.exists(_abs(d))

    status["config/ai_keys.yaml"] = os.path.exists(_abs("config/ai_keys.yaml"))
    status["config/ai_keys_template.yaml"] = os.path.exists(_abs("config/ai_keys_template.yaml"))

    for f in ["rules/default.yaml", "rules/academic.yaml", "rules/learned_rules.yaml",
              "rules/custom_rules.yaml", "rules/smart_patterns.yaml"]:
        status[f] = os.path.exists(_abs(f))

    outputs_files = glob.glob(_abs("outputs/*"))
    outputs_files = [f for f in outputs_files if not f.endswith(".gitkeep")]
    status["outputs_count"] = len(outputs_files)

    return status
