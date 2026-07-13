import logging
import sys


C_CYA = "\033[36m"
C_GRN = "\033[32m"
C_YLW = "\033[33m"
C_RED = "\033[31m"
C_GRY = "\033[90m"
C_BLD = "\033[1m"
C_RST = "\033[0m"


LEVEL_COLORS = {
    logging.INFO: C_GRN,
    logging.WARNING: C_YLW,
    logging.ERROR: C_RED,
    logging.DEBUG: C_GRY,
}


class ColoredFormatter(logging.Formatter):
    def format(self, record):
        level_color = LEVEL_COLORS.get(record.levelno, "")
        timestamp = self.formatTime(record, "%H:%M:%S")
        level_orig = record.levelname
        record.levelname = f"{level_color}{level_orig}{C_RST}"
        result = f"{C_GRY}{timestamp}{C_RST} [{record.levelname}] {record.getMessage()}"
        record.levelname = level_orig
        return result


def setup_logger(verbose: bool = False) -> logging.Logger:
    logger = logging.getLogger("wordfix")
    logger.setLevel(logging.DEBUG if verbose else logging.INFO)

    if logger.handlers:
        return logger

    handler = logging.StreamHandler(sys.stdout)
    handler.setLevel(logging.DEBUG if verbose else logging.INFO)
    handler.setFormatter(ColoredFormatter())
    logger.addHandler(handler)

    return logger
