import os
from collections import Counter
from typing import List
import yaml

from src.parsers.factory import get_parser
from src.parsers.base import ParsedDocument


class StyleProfile:
    def __init__(self, style_name: str, count: int):
        self.style_name = style_name
        self.count = count
        self.font_names = Counter()
        self.font_sizes = Counter()
        self.bold_counts = Counter()
        self.italic_counts = Counter()
        self.colors = Counter()
        self.alignments = Counter()
        self.line_spacings = Counter()
        self.space_befores = Counter()
        self.space_afters = Counter()

    def to_rule(self) -> dict:
        font_name = self.font_names.most_common(1)
        font_size = self.font_sizes.most_common(1)
        color = self.colors.most_common(1)
        alignment = self.alignments.most_common(1)
        line_spacing = self.line_spacings.most_common(1)
        space_before = self.space_befores.most_common(1)
        space_after = self.space_afters.most_common(1)

        total_runs = sum(self.bold_counts.values())
        bold_ratio = self.bold_counts.get(True, 0) / total_runs if total_runs > 0 else 0
        italic_ratio = self.italic_counts.get(True, 0) / total_runs if total_runs > 0 else 0

        actions = {"font": {}, "paragraph": {}}

        if font_name:
            actions["font"]["name"] = font_name[0][0]
        if font_size:
            actions["font"]["size"] = round(font_size[0][0], 1)
        if bold_ratio > 0.5:
            actions["font"]["bold"] = True
        if italic_ratio > 0.5:
            actions["font"]["italic"] = True
        if color:
            actions["font"]["color"] = color[0][0]

        if alignment:
            actions["paragraph"]["alignment"] = alignment[0][0]
        if line_spacing:
            actions["paragraph"]["line_spacing"] = round(line_spacing[0][0], 1)
        if space_before:
            actions["paragraph"]["space_before"] = round(space_before[0][0], 1)
        if space_after:
            actions["paragraph"]["space_after"] = round(space_after[0][0], 1)

        heading_level = None
        sn = self.style_name.lower()
        if sn.startswith("heading"):
            try:
                heading_level = int(sn.replace("heading", "").strip())
            except ValueError:
                pass

        rule = {
            "name": f"{self.style_name} - learned",
            "target": "paragraph",
            "conditions": {"style": self.style_name},
            "actions": actions,
        }
        if heading_level:
            rule["actions"]["heading"] = {"level": heading_level}

        return rule


class StyleLearner:
    def __init__(self):
        self.min_samples = 2

    def learn(self, template_path: str) -> List[StyleProfile]:
        parser = get_parser(template_path)
        doc = parser.read(template_path)
        style_map = {}

        for para in doc.paragraphs:
            sn = para.style_name or "Normal"
            if sn not in style_map:
                style_map[sn] = StyleProfile(sn, 0)
            sp = style_map[sn]
            sp.count += 1

            if para.alignment:
                sp.alignments[para.alignment] += 1
            if para.line_spacing:
                sp.line_spacings[para.line_spacing] += 1
            if para.space_before is not None:
                sp.space_befores[para.space_before] += 1
            if para.space_after is not None:
                sp.space_afters[para.space_after] += 1

            for run in para.runs:
                if run.font_name:
                    sp.font_names[run.font_name] += 1
                if run.font_size:
                    sp.font_sizes[run.font_size] += 1
                sp.bold_counts[bool(run.bold)] += 1
                sp.italic_counts[bool(run.italic)] += 1
                if run.color:
                    sp.colors[run.color] += 1

        return [sp for sp in style_map.values() if sp.count >= self.min_samples]

    def learn_to_yaml(self, template_path: str, output_path: str = None):
        profiles = self.learn(template_path)
        rules = [p.to_rule() for p in profiles]

        data = {"rules": rules}

        if output_path is None:
            base = os.path.splitext(os.path.basename(template_path))[0]
            output_path = os.path.join(
                os.path.dirname(__file__), "..", "..", "rules", f"{base}_rules.yaml"
            )

        os.makedirs(os.path.dirname(os.path.abspath(output_path)), exist_ok=True)
        with open(output_path, "w", encoding="utf-8") as f:
            yaml.dump(data, f, allow_unicode=True, default_flow_style=False, sort_keys=False)

        return output_path, len(rules)
