from typing import Any, Optional

a: str | None = 1
print(a)


def foo21(a: int, b: Optional[str] = None) -> list:
    a = "ads"
    return str(a)


foo21(1, b=2)
