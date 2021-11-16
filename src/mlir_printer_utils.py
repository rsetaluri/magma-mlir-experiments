from typing import List, Mapping, Union

from mlir import MlirValue
from printer_base import PrinterBase


MlirValueList = List[MlirValue]
MlirValueOrMlirValueList = Union[MlirValue, MlirValueList]


def _maybe_wrap_value_or_value_list(
        value_or_value_list: MlirValueOrMlirValueList) -> MlirValueList:
    if isinstance(value_or_value_list, MlirValue):
        return [value_or_value_list]
    return value_or_value_list


def print_names(
        value_or_value_list: MlirValueOrMlirValueList, printer: PrinterBase):
    value_list = _maybe_wrap_value_or_value_list(value_or_value_list)
    printer.print(", ".join(v.name for v in value_list))


def print_types(
        value_or_value_list: MlirValueOrMlirValueList, printer: PrinterBase):
    value_list = _maybe_wrap_value_or_value_list(value_or_value_list)
    printer.print(", ".join(v.type.emit() for v in value_list))


def print_signature(
        value_or_value_list: MlirValueOrMlirValueList, printer: PrinterBase):
    value_list = _maybe_wrap_value_or_value_list(value_or_value_list)
    printer.print(", ".join(f"{v.name}: {v.type.emit()}" for v in value_list))


def print_attr_dict(attr_dict: Mapping, printer: PrinterBase):
    attr_dict_to_string = ", ".join(f"{k} = {v}" for k, v in attr_dict.items())
    printer.print(f"{{{attr_dict_to_string}}}")
