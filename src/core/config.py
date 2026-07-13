import yaml
import os
from typing import List
from src.core.rules import FormatRule, rule_from_dict


class ConfigLoader:
    def __init__(self, rules_dir: str = None):
        self.rules_dir = rules_dir or os.path.join(
            os.path.dirname(__file__), "..", "..", "rules"
        )

    def _resolve_path(self, name: str) -> str:
        if os.path.isabs(name):
            return name
        if os.sep in name or "/" in name:
            return os.path.abspath(name)
        return os.path.join(self.rules_dir, name)

    def _load_single(self, path: str) -> List[FormatRule]:
        resolved = self._resolve_path(path)
        if not os.path.exists(resolved):
            raise FileNotFoundError(f"Rule file not found: {resolved}")
        with open(resolved, encoding="utf-8") as f:
            data = yaml.safe_load(f)
        if not data or "rules" not in data:
            raise ValueError(f"Invalid rule file: missing 'rules' key in {resolved}")
        return [rule_from_dict(r) for r in data["rules"]]

    def load_rules(self, rule_file: str) -> List[FormatRule]:
        files = [f.strip() for f in rule_file.split(",") if f.strip()]
        if not files:
            raise ValueError("No rule file specified")

        all_rules = []
        errors = []
        for f in files:
            try:
                all_rules.extend(self._load_single(f))
            except FileNotFoundError as e:
                errors.append(str(e))

        if not all_rules:
            msg = "\n".join(errors) if errors else "No rules loaded"
            raise FileNotFoundError(msg)

        if errors:
            import logging
            logging.warning("Some rule files could not be loaded:\n" + "\n".join(errors))

        return all_rules

    def list_rule_files(self) -> List[str]:
        if not os.path.isdir(self.rules_dir):
            return []
        return [
            f for f in os.listdir(self.rules_dir)
            if f.endswith((".yaml", ".yml"))
        ]
