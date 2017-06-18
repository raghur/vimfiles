
from datetime import datetime
from tzlocal import get_localzone  # $ pip install tzlocal


def rfc3339():
    now = datetime.now(get_localzone())
    return now.isoformat('T')
