import dataclasses
from typing import Any, Optional, Tuple

from common import missing, make_unique_name
from graph_lib import Graph, Node
from mlir_value import MlirValue


HashableMapping = Tuple[Tuple[Any, Any]]


def op_kind_set_attr(key: str, value: Any):

    def wrapped(op_kind: type) -> type:
        try:
            attrs = op_kind._mlir_op_kind_attrs_
        except AttributeError:
            attrs = op_kind._mlir_op_kind_attrs_ = {}
        attrs[key] = value
        return op_kind

    return wrapped


def op_kind_get_attr(op_kind: type, key: str, default: Any = missing()):
    attrs = getattr(op_kind, "_mlir_op_kind_attrs_", {})
    if default is missing():
        return attrs[key]
    return attrs.get(key, default)


@dataclasses.dataclass(frozen=True)
class MlirOp:
    id: str = dataclasses.field(default_factory=make_unique_name, init=False)


@dataclasses.dataclass(frozen=True)
class MlirMultiOp(MlirOp):
    name: str
    graph: Graph
    primary_inputs: Tuple[Tuple[Node, int, int]]
    primary_outputs: Tuple[Tuple[Node, int]]


@dataclasses.dataclass(frozen=True)
class CombOp(MlirOp):
    name: str
    op: str

    def emit(self):
        return (f"{{outputs.names}} = comb.{self.op} {{inputs.names}} : "
                f"{{outputs.types}}")


@dataclasses.dataclass(frozen=True)
class CombICmpOp(MlirOp):
    name: str
    predicate: str

    def emit(self):
        return (f"{{outputs.names}} = comb.icmp {self.predicate} "
                f"{{inputs.names}} : {{inputs[0].type}}")


@dataclasses.dataclass(frozen=True)
class CombExtractOp(MlirOp):
    name: str
    lo: int
    hi: int

    def emit(self):
        return (f"{{outputs.names}} = comb.extract {{inputs.names}} "
                f"from {self.lo} : ({{inputs.types}}) -> {{outputs.types}}")


@op_kind_set_attr("inputs_reversed", True)
@dataclasses.dataclass(frozen=True)
class CombConcatOp(MlirOp):
    name: str

    def emit(self):
        return (f"{{outputs.names}} = comb.concat {{inputs.names}} : "
                f"({{inputs.types}}) -> {{outputs.types}}")


@dataclasses.dataclass(frozen=True)
class CombMuxOp(MlirOp):
    name: str

    def emit(self):
        return (f"{{outputs.names}} = comb.mux {{inputs.names}} : "
                f"{{outputs.types}}")


@dataclasses.dataclass(frozen=True)
class HwConstantOp(MlirOp):
    name: str
    value: int

    def emit(self):
        return (f"{{outputs.names}} = hw.constant {self.value} : "
                f"{{outputs.types}}")


@dataclasses.dataclass(frozen=True)
class HwArrayGetOp(MlirOp):
    name: str

    def emit(self):
        return (f"{{outputs.names}} = hw.array_get "
                f"{{inputs[0].name}}[{{inputs[1].name}}] : {{inputs[0].type}}")


@op_kind_set_attr("inputs_reversed", True)
@dataclasses.dataclass(frozen=True)
class HwArrayCreateOp(MlirOp):
    name: str

    def emit(self):
        return (f"{{outputs.names}} = hw.array_create {{inputs.names}} : "
                f"{{inputs[0].type}}")


@dataclasses.dataclass(frozen=True)
class HwStructExtractOp(MlirOp):
    name: str
    field: str

    def emit(self):
        return (f"{{outputs.names}} = hw.struct_extract "
                f"{{inputs.names}}[\"{self.field}\"] : {{inputs.types}}")


@dataclasses.dataclass(frozen=True)
class HwStructCreateOp(MlirOp):
    name: str

    def emit(self):
        return (f"{{outputs.names}} = hw.struct_create ({{inputs.names}}) : "
                f"{{outputs.types}}")


@dataclasses.dataclass(frozen=True)
class HwInstanceOp(MlirOp):
    name: str
    defn: str

    def emit(self):
        return (f"{{outputs.names}} = hw.instance \"{self.name}\" "
                f"@{self.defn}({{inputs.names}}) : ({{inputs.types}}) -> "
                f"({{outputs.types}})")


@dataclasses.dataclass(frozen=True)
class HwOutputOp(MlirOp):
    name: str

    def emit(self):
        return (f"hw.output {{inputs.names}} : {{inputs.types}}")


@dataclasses.dataclass(frozen=True)
class SvRegOp(MlirOp):
    name: str

    def emit(self):
        return (f"{{outputs.names}} = sv.reg {{{{name = \"{self.name}\"}}}} : "
                f"{{outputs.types}}")


@dataclasses.dataclass(frozen=True)
class SvReadInOutOp(MlirOp):
    name: str

    def emit(self):
        return (f"{{outputs.names}} = sv.read_inout {{inputs.names}} : "
                f"{{inputs.types}}")


# NOTE(rsetaluri): This is a canned op to emulate a sv.alwaysff region.
@dataclasses.dataclass(frozen=True)
class SvRegAssignOp(MlirOp):
    name: str
    sensitivity: bool

    def emit(self):
        sense = "posedge" if self.sensitivity else "negedge"
        return (f"sv.alwaysff({sense} {{inputs[2].name}}) {{{{ sv.passign "
                f"{{inputs[1].name}}, {{inputs[0].name}} : "
                f"{{inputs[0].type}} }}}}")


# NOTE(rsetaluri): This is a canned op to emulate a sv.initial region.
@dataclasses.dataclass(frozen=True)
class SvRegInitOp(MlirOp):
    name: str

    def emit(self):
        return (f"sv.initial {{{{ sv.bpassign {{inputs[0].name}}, "
                f"{{inputs[1].name}} : {{inputs[1].type}} }}}}")


@dataclasses.dataclass(frozen=True)
class SvWireOp(MlirOp):
    name: str
    sym: Optional[str] = None

    def emit(self):
        if self.sym is not None:
            raise NotImplementedError()
        return (f"{{outputs.names}} = sv.wire : {{outputs.types}}")


@dataclasses.dataclass(frozen=True)
class SvAssignOp(MlirOp):
    name: str

    def emit(self):
        return (f"sv.assign {{inputs.names}} : {{inputs[1].type}}")