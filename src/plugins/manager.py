import importlib
import inspect
import os
from typing import List
from src.formatters.base import BaseFormatter


class PluginManager:
    def __init__(self, plugin_dir: str = None):
        self.plugin_dir = plugin_dir or os.path.join(
            os.path.dirname(__file__)
        )

    def discover_formatters(self) -> List[BaseFormatter]:
        formatters = []
        if not os.path.isdir(self.plugin_dir):
            return formatters

        for fname in os.listdir(self.plugin_dir):
            if fname.endswith(".py") and not fname.startswith("__"):
                mod_name = fname[:-3]
                try:
                    import importlib.util
                    spec = importlib.util.spec_from_file_location(
                        mod_name,
                        os.path.join(self.plugin_dir, fname),
                    )
                    mod = importlib.util.module_from_spec(spec)
                    spec.loader.exec_module(mod)
                except Exception as e:
                    continue

                for _, obj in inspect.getmembers(mod, inspect.isclass):
                    if (
                        issubclass(obj, BaseFormatter)
                        and obj is not BaseFormatter
                    ):
                        formatters.append(obj())

        return formatters
