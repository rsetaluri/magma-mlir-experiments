import dataclasses
from typing import Any, Callable, Mapping, Union

import magma as m

from common import make_unique_name, replace_all


ModuleLike = Union[m.DefineCircuitKind, m.Circuit]


_VALUE_OR_TYPE_TO_STRING_REPLACEMENTS = {
    "(": "_",
    ")": "",
    "[": "_",
    "]": "",
    " ": "",
    ",": "_",
    "=": "_",
    ".": "_",
}


def contains_tuple(T: m.Kind):
    if isinstance(T, m.ProductMeta):
        return True
    if isinstance(T, m.ArrayMeta):
        return contains_tuple(T.T)
    return False


def value_or_type_to_string(value_or_type: Union[m.Type, m.Kind]):
    if isinstance(value_or_type, m.Type):
        s = value_or_type.name.qualifiedname("_")
    else:
        s = str(value_or_type)
    return replace_all(s, _VALUE_OR_TYPE_TO_STRING_REPLACEMENTS)


def visit_value_by_direction(
        value: m.Type,
        input_visitor: Callable[[m.Type], Any],
        output_visitor: Callable[[m.Type], Any],
        **kwargs):

    def descend(value):
        if isinstance(value, m.Product):
            for field in value.values():
                visit_value_by_direction(
                    field, input_visitor, output_visitor, **kwargs)
            return
        if isinstance(value, m.Array):
            for item in value:
                visit_value_by_direction(
                    item, input_visitor, output_visitor, **kwargs)
            return
        raise TypeError(value)

    flatten_all_tuples = kwargs.get("flatten_all_tuples", False)
    if flatten_all_tuples and contains_tuple(type(value)):
        return descend(value)
    if value.is_input():
        return input_visitor(value)
    if value.is_output():
        return output_visitor(value)
    if value.is_mixed():
        return descend(value)
    raise TypeError(value)


@dataclasses.dataclass(frozen=True)
class ValueWrapper:
    id: str = dataclasses.field(default_factory=make_unique_name, init=False)
    name: str
    T: m.Kind


def visit_value_wrapper_by_direction(
        value_wrapper: ValueWrapper,
        input_visitor: Callable[[ValueWrapper], Any],
        output_visitor: Callable[[ValueWrapper], Any],
        **kwargs):

    def descend(value_wrapper):
        T = value_wrapper.T
        if isinstance(T, m.ProductMeta):
            for key, TT in T.field_dict.items():
                field = ValueWrapper(f"{value_wrapper.name}_{key}", TT)
                visit_value_wrapper_by_direction(
                    field, input_visitor, output_visitor, **kwargs)
            return
        if isinstance(T, m.ArrayMeta):
            for index in range(T.N):
                item = ValueWrapper(f"{value_wrapper.name}[{key}]", T.T)
                visit_value_wrapper_by_direction(
                    item, input_visitor, output_visitor, **kwargs)
            return
        raise TypeError(value_wrapper)

    T = value_wrapper.T
    flatten_all_tuples = kwargs.get("flatten_all_tuples", False)
    if flatten_all_tuples and contains_tuple(T):
        return descend(value_wrapper)
    if T.is_input():
        return input_visitor(value_wrapper)
    if T.is_output():
        return output_visitor(value_wrapper)
    if T.is_mixed():
        return descend(value_wrapper)
    raise TypeError(value_wrapper)


class InstanceWrapper:
    def __init__(
            self,
            name: str,
            ports: Mapping[str, m.Kind],
            attrs: Mapping[str, Any]):
        self._name = name
        self._ports = {name: ValueWrapper(name, T) for name, T in ports.items()}
        self._attrs = attrs
        for name, value in self._ports.items():
            setattr(self, name, value)

    def __repr__(self) -> str:
        return f"InstanceWrapper({self.name})"

    @property
    def name(self) -> str:
        return self._name

    @property
    def ports(self) -> Mapping[str, m.Kind]:
        return self._ports.copy()

    @property
    def attrs(self) -> Mapping[str, Any]:
        return self._attrs.copy()


def safe_root(ref: m.ref.Ref) -> m.ref.Ref:
    """Returns the root ref of @ref."""
    # TODO(rsetaluri): This should be able to return `ref.root()`, but depends
    # on #990.
    parent = ref
    if isinstance(ref, m.ref.ArrayRef):
        parent = ref.array.name
    elif isinstance(ref, m.ref.TupleRef):
        parent = ref.tuple.name
    if parent is ref:
        return ref
    return safe_root(parent)
