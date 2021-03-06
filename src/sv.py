import dataclasses
from typing import List, Optional

from hw import hw
from mlir import (
    MlirDialect, MlirOp, MlirBlock, MlirValue, MlirSymbol,
    begin_dialect, end_dialect)
from mlir_printer_utils import print_names, print_types
from printer_base import PrinterBase


sv = MlirDialect("sv")
begin_dialect(sv)


@dataclasses.dataclass
class RegOp(MlirOp):
    results: List[MlirValue]
    name: str

    def print_op(self, printer: PrinterBase):
        print_names(self.results, printer)
        printer.print(f" = sv.reg {{name = \"{self.name}\"}} : ")
        print_types(self.results, printer)


@dataclasses.dataclass
class ReadInOutOp(MlirOp):
    operands: List[MlirValue]
    results: List[MlirValue]

    def print_op(self, printer: PrinterBase):
        print_names(self.results, printer)
        printer.print(f" = sv.read_inout ")
        print_names(self.operands, printer)
        printer.print(" : ")
        print_types(self.operands, printer)


@dataclasses.dataclass
class AssignOp(MlirOp):
    operands: List[MlirValue]

    def print_op(self, printer: PrinterBase):
        printer.print(f"sv.assign ")
        print_names(self.operands, printer)
        printer.print(" : ")
        print_types(self.operands[1], printer)


@dataclasses.dataclass
class PAssignOp(MlirOp):
    operands: List[MlirValue]

    def print_op(self, printer: PrinterBase):
        printer.print(f"sv.passign ")
        print_names(self.operands, printer)
        printer.print(" : ")
        print_types(self.operands[1], printer)


@dataclasses.dataclass
class BPAssignOp(MlirOp):
    operands: List[MlirValue]

    def print_op(self, printer: PrinterBase):
        printer.print(f"sv.bpassign ")
        print_names(self.operands, printer)
        printer.print(" : ")
        print_types(self.operands[1], printer)


@dataclasses.dataclass
class AlwaysFFOp(MlirOp):
    operands: List[MlirValue]
    clock_edge: str
    reset_type: str = None
    reset_edge: str = None

    def __post_init__(self):
        self._body_block = self.new_region().new_block()
        if self.reset_type is None:
            return
        self._reset_block = self.new_region().new_block()

    @property
    def body_block(self) -> MlirBlock:
        return self._body_block

    @property
    def reset_block(self) -> MlirBlock:
        return self._reset_block

    def print(self, printer: PrinterBase):
        printer.print(f"sv.alwaysff({self.clock_edge} ")
        print_names(self.operands[0], printer)
        printer.print(") {")
        printer.flush()
        printer.push()
        self.body_block.print(printer)
        printer.pop()
        printer.print("}")
        if self.reset_type is None:
            printer.flush()
            return
        printer.print(f" ({self.reset_type} : {self.reset_edge} ")
        print_names(self.operands[1], printer)
        printer.print(") {")
        printer.flush()
        printer.push()
        self.reset_block.print(printer)
        printer.pop()
        printer.print_line("}")

    def print_op(self, printer: PrinterBase):
        raise NotImplementedError()


@dataclasses.dataclass
class InitialOp(MlirOp):
    def __post_init__(self):
        self._block = self.new_region().new_block()

    def add_operation(self, operation: MlirOp):
        self._block.add_operation(operation)

    def print_op(self, printer: PrinterBase):
        printer.print("sv.initial")


@dataclasses.dataclass
class WireOp(MlirOp):
    results: List[MlirValue]
    name: str
    sym: Optional[MlirSymbol] = None

    def print_op(self, printer: PrinterBase):
        print_names(self.results, printer)
        printer.print(" = sv.wire ")
        if self.sym is not None:
            printer.print(f"sym {self.sym.name} ")
        printer.print(f"{{name=\"{self.name}\"}} : ")
        print_types(self.results, printer)


@dataclasses.dataclass
class VerbatimOp(MlirOp):
    operands: List[MlirOp]
    string: str

    def print_op(self, printer: PrinterBase):
        # NOTE(rsetaluri): This is a hack to "double-escape" escape characters
        # like `\n`, `\t`.
        string = repr(self.string)[1:-1]
        string = string.replace("\"", "\\\"")
        string = string.replace("\\\'", "'")
        printer.print(f"sv.verbatim \"{string}\"")
        if self.operands:
            printer.print(" (")
            print_names(self.operands, printer)
            printer.print(") : ")
            print_types(self.operands, printer)


@dataclasses.dataclass
class BindOp(MlirOp):
    instance: hw.InnerRefAttr

    def print_op(self, printer: PrinterBase):
        printer.print(f"sv.bind {self.instance.emit()}")


@dataclasses.dataclass
class IfDefOp(MlirOp):
    cond: str

    def __post_init__(self):
        self._then_block = self.new_region().new_block()
        self._else_block = None

    @property
    def then_block(self) -> MlirBlock:
        return self._then_block

    @property
    def else_block(self) -> MlirBlock:
        if self._else_block is None:
            self._else_block = self.new_region().new_block()
        return self._else_block

    def print(self, printer: PrinterBase):
        printer.print(f"sv.ifdef \"{self.cond}\" {{")
        printer.flush()
        printer.push()
        self._then_block.print(printer)
        printer.pop()
        printer.print("}")
        if self._else_block is None:
            printer.flush()
            return
        printer.print(" else {")
        printer.flush()
        printer.push()
        self._else_block.print(printer)
        printer.pop()
        printer.print_line("}")

    def print_op(self, printer: PrinterBase):
        raise NotImplementedError()


@dataclasses.dataclass
class IfOp(MlirOp):
    operands: List[MlirOp]

    def __post_init__(self):
        self._then_block = self.new_region().new_block()
        self._else_block = None

    @property
    def then_block(self) -> MlirBlock:
        return self._then_block

    @property
    def else_block(self) -> MlirBlock:
        if self._else_block is None:
            self._else_block = self.new_region().new_block()
        return self._else_block

    def print(self, printer: PrinterBase):
        printer.print(f"sv.if ")
        print_names(self.operands[0], printer)
        printer.print(" {")
        printer.flush()
        printer.push()
        self._then_block.print(printer)
        printer.pop()
        printer.print("}")
        if self._else_block is None:
            printer.flush()
            return
        printer.print(" else {")
        printer.flush()
        printer.push()
        self._else_block.print(printer)
        printer.pop()
        printer.print_line("}")

    def print_op(self, printer: PrinterBase):
        raise NotImplementedError()


end_dialect()
