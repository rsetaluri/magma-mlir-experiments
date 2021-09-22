import functools
from typing import Any, Dict, Iterable, Tuple
import uuid


_MISSING = object()


def wrap_with_not_implemented_error(fn):

    @functools.wraps(fn)
    def wrapped(*args, **kwargs):
        ret = fn(*args, **kwargs)
        if ret is None:
            raise NotImplementedError(args, kwargs)
        return ret

    return wrapped


def missing() -> object:
    global _MISSING
    return _MISSING


def dict_from_items(items: Iterable[Tuple[Any, Any]]) -> Dict:
    return {k: v for k, v in items}


def make_unique_name() -> str:
    return str(uuid.uuid4())