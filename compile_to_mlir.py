from graph_base import write_to_dot
from magma_graph import build_magma_graph
from debug_utils import flatten_magma_graph
from passes import *
from mlir_passes import *


def emit_module(ckt, g):
    emitter = Emitter()
    inputs = [MlirValue(f"%{port.name}", lower_type(type(port)))
              for port in ckt.interface.outputs()]
    outputs = [MlirValue(f"%{port.name}", lower_type(type(port)))
               for port in ckt.interface.inputs()]
    emitter.emit(f"hw.module @{ckt.name}({values_to_string(inputs, 2)}) -> ({values_to_string(outputs, 2)}) {{")
    emitter.push()
    EmitMlirVisitor(g, emitter).run(topological_sort)
    emitter.pop()
    emitter.emit("}")


def compile_to_mlir(ckt: m.DefineCircuitKind):
    g = build_magma_graph(ckt)

    write_to_dot(flatten_magma_graph(g), "graph.txt")

    SplitPortEdgesTranformer(g).run()
    RemoveDuplicateEdgesTransformer(g).run()
    NetMerger(g).run()

    ctx = MlirContext()
    ModuleInputSplitter(g, ctx).run()
    NetToValueTransformer(g, ctx).run(topological_sort)
    EdgePortToIndexTransformer(g, ctx).run()
    ModuleToOpTransformer(g, ctx).run()

    emit_module(ckt, g)

    write_to_dot(flatten_magma_graph(g), "graph-lowered.txt")