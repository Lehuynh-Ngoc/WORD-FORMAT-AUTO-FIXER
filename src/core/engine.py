from typing import List
from src.parsers.base import ParsedDocument
from src.parsers.factory import get_parser
from src.formatters.font import FontFormatter
from src.formatters.spacing import SpacingFormatter
from src.formatters.alignment import AlignmentFormatter
from src.formatters.heading import HeadingFormatter
from src.formatters.smart_heading import SmartHeadingFormatter
from src.core.rules import FormatRule
from src.utils.reporter import ChangeReporter
from src.plugins.manager import PluginManager


class FormatEngine:
    def __init__(self):
        self.formatters = [
            SmartHeadingFormatter(),
            FontFormatter(),
            SpacingFormatter(),
            AlignmentFormatter(),
            HeadingFormatter(),
        ]
        plugin_formatters = PluginManager().discover_formatters()
        self.formatters.extend(plugin_formatters)

    def format(
        self,
        input_path: str,
        output_path: str,
        rules: List[FormatRule],
        dry_run: bool = False,
    ) -> ChangeReporter:
        parser = get_parser(input_path)
        doc = parser.read(input_path)
        reporter = ChangeReporter(input_path)

        for fmt in self.formatters:
            changes = fmt.apply(doc, rules)
            reporter.add_changes(type(fmt).__name__, changes)

        if not dry_run:
            parser.save(doc, output_path)
            reporter.output_path = output_path
        else:
            reporter.output_path = None

        return reporter
