import os
import sys
import tempfile

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from src.core.rules import FormatRule, FontAction, ParagraphAction, rule_from_dict
from src.core.config import ConfigLoader
from src.core.engine import FormatEngine


def test_rule_from_dict():
    data = {
        "name": "Test Rule",
        "target": "paragraph",
        "conditions": {"style": "Normal"},
        "actions": {
            "font": {"name": "Arial", "size": 12},
            "paragraph": {"alignment": "left", "line_spacing": 1.5},
        },
    }
    rule = rule_from_dict(data)
    assert rule.name == "Test Rule"
    assert rule.conditions.style == "Normal"
    assert rule.font.name == "Arial"
    assert rule.font.size == 12
    assert rule.paragraph.alignment == "left"
    assert rule.paragraph.line_spacing == 1.5


def test_rule_applies_to():
    rule = FormatRule(
        name="Test",
        conditions=type('obj', (object,), {'style': 'Normal', 'text_contains': None, 'pattern': None})(),
    )
    assert rule.applies_to("Normal") is True
    assert rule.applies_to("Heading 1") is False


def test_rule_applies_to_with_text():
    from src.core.rules import Condition

    class FakeRule:
        def __init__(self):
            self.conditions = Condition(text_contains="hello")

    rule = FormatRule(
        name="Test",
        conditions=Condition(text_contains="hello"),
    )
    assert rule.applies_to("Normal", "hello world") is True
    assert rule.applies_to("Normal", "goodbye") is False


def test_config_loader_list():
    loader = ConfigLoader()
    rules_dir = os.path.join(os.path.dirname(__file__), "..", "rules")
    assert os.path.isdir(rules_dir)
    files = loader.list_rule_files()
    assert "default.yaml" in files
    assert "academic.yaml" in files


def test_load_default_rules():
    loader = ConfigLoader()
    rules = loader.load_rules("default.yaml")
    assert len(rules) > 0
    assert all(isinstance(r, FormatRule) for r in rules)


def test_load_academic_rules():
    loader = ConfigLoader()
    rules = loader.load_rules("academic.yaml")
    assert len(rules) > 0


def test_engine_initialization():
    engine = FormatEngine()
    assert len(engine.formatters) == 5
