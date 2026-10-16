import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from docx import Document
from docx.shared import Pt

from src.core.learner import StyleLearner, StyleProfile


def make_template(tmp_path, paragraphs):
    """paragraphs: list of (style_name, text, font_size)."""
    doc = Document()
    for style_name, text, size in paragraphs:
        p = doc.add_paragraph(style=style_name)
        run = p.add_run(text)
        run.font.name = "Times New Roman"
        run.font.size = Pt(size)
        if style_name.startswith("Heading"):
            run.bold = True

    path = str(tmp_path / "template.docx")
    doc.save(path)
    return path


def test_learn_min_samples_filter(tmp_path):
    path = make_template(tmp_path, [
        ("Normal", "doan mot", 13),
        ("Normal", "doan hai", 13),
        ("Heading 1", "chuong mot", 16),
    ])

    profiles = StyleLearner().learn(path)
    names = [p.style_name for p in profiles]

    assert "Normal" in names        # 2 mau -> du dieu kien
    assert "Heading 1" not in names # chi 1 mau -> bi loc


def test_learn_profile_values(tmp_path):
    path = make_template(tmp_path, [
        ("Normal", "doan mot", 13),
        ("Normal", "doan hai", 13),
    ])

    profiles = StyleLearner().learn(path)
    normal = next(p for p in profiles if p.style_name == "Normal")

    assert normal.font_names.most_common(1)[0][0] == "Times New Roman"
    assert normal.font_sizes.most_common(1)[0][0] == 13.0


def test_to_rule_structure():
    profile = StyleProfile("Heading 1", 3)
    profile.font_names["Arial"] = 3
    profile.font_sizes[16.0] = 3
    profile.bold_counts[True] = 3
    profile.line_spacings[1.5] = 3

    rule = profile.to_rule()

    assert rule["name"] == "Heading 1 - learned"
    assert rule["conditions"]["style"] == "Heading 1"
    assert rule["actions"]["font"]["name"] == "Arial"
    assert rule["actions"]["font"]["size"] == 16.0
    assert rule["actions"]["font"]["bold"] is True
    assert rule["actions"]["paragraph"]["line_spacing"] == 1.5
    assert rule["actions"]["heading"] == {"level": 1}


def test_learned_rule_loadable_by_config_loader(tmp_path):
    """Rule tu learn phai doc duoc boi ConfigLoader (format dung ngay duoc)."""
    from src.core.config import ConfigLoader

    path = make_template(tmp_path, [
        ("Normal", "doan mot", 13),
        ("Normal", "doan hai", 13),
        ("Heading 2", "muc mot", 14),
        ("Heading 2", "muc hai", 14),
    ])

    learner = StyleLearner()
    out_path, count = learner.learn_to_yaml(path, str(tmp_path / "learned.yaml"))

    assert count >= 2
    assert os.path.exists(out_path)

    rules = ConfigLoader(rules_dir=str(tmp_path)).load_rules("learned.yaml")
    assert len(rules) == count


def test_learn_to_yaml_default_path(tmp_path, monkeypatch):
    """Khi khong truyen output, learn_to_yaml van hoat dong va tra ve duong dan."""
    path = make_template(tmp_path, [
        ("Normal", "mot", 13),
        ("Normal", "hai", 13),
    ])

    learner = StyleLearner()
    out_path, count = learner.learn_to_yaml(path, str(tmp_path / "custom.yaml"))

    assert os.path.basename(out_path) == "custom.yaml"
    assert count == 1
