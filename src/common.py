import collections
import dataclasses
import functools
from typing import Any, Callable, Dict, Iterable, Tuple


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


_unique_name_index = 0


def make_unique_name() -> str:
    global _unique_name_index
    name = "%032d" % _unique_name_index
    _unique_name_index += 1
    return name


def default_field(cons, **kwargs):
    return dataclasses.field(default_factory=cons, **kwargs)


@dataclasses.dataclass
class WithId:
    id: str = dataclasses.field(default_factory=make_unique_name, init=False)


class Stack:
    """Lightweight wrapper over builtin lists to provide a stack interface"""
    def __init__(self):
        self._stack = []

    def push(self, value):
        self._stack.append(value)

    def pop(self):
        return self._stack.pop()

    def peek(self):
        return self._stack[-1]


def replace_all(s: str, replacements: Dict[str, str]) -> str:
    for old, new in replacements.items():
        s = s.replace(old, new)
    return s


def constant(value: Any):
    return lambda: value


def try_call(fn: Callable[[], Any], ExceptionType: Any):
    if ExceptionType is None:
        ExceptionType = BaseException
    try:
        ret = fn()
    except ExceptionType:
        pass
    else:
        return ret


def slice_opts(dct: Dict, cls: type):
    kwargs = {}
    for name, field in cls.__dataclass_fields__.items():
        try:
            value = dct.pop(name)
        except KeyError:
            continue
        kwargs[name] = value
    return cls(**kwargs)
