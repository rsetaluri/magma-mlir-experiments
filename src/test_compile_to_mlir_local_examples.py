import pytest

from compile_to_mlir_opts import CompileToMlirOpts
from examples import simple_aggregates_tuple
from test_utils import get_local_examples, run_test_compile_to_mlir


@pytest.mark.parametrize("ckt", get_local_examples())
def test_compile_to_mlir(ckt):
    run_test_compile_to_mlir(ckt)


def test_compile_to_mlir_flatten_all_tuples():
    run_test_compile_to_mlir(
        simple_aggregates_tuple, flatten_all_tuples=True,
        gold_name="simple_aggregates_tuple_flattened_tuples")
