import dataclasses
from typing import Any, Iterable, List

import magma as m

from common_visitors import replace_node
from graph_lib import Graph, Node
from graph_visitor import NodeVisitor, NodeTransformer
from magma_graph import Net
from mlir_context import MlirContext, Contextual
from mlir_emitter import MlirEmitter
from mlir_graph import MlirOp, MlirMultiOp, CombConcatOp, op_kind_get_attr
from mlir_type import MlirType
from mlir_utils import magma_type_to_mlir_type, magma_module_to_mlir_op
from mlir_value import MlirValue, mlir_value_is_anonymous


class ModuleInputSplitter(NodeTransformer, Contextual):
    def __init__(self, g: Graph, ctx: MlirContext):
        super().__init__(g)
        self._ctx = ctx

    def generic_visit(self, node: Node):
        if not isinstance(node, m.DefineCircuitKind):
            return node
        nodes = [node]
        edges = list(self.graph.in_edges(node, data=True))
        nodes_to_remove = []
        for edge in self.graph.out_edges(node, data=True):
            _, dst, data = edge
            assert isinstance(dst, Net)
            port = data["info"]
            assert dst.ports[0] is port
            t = magma_type_to_mlir_type(type(port))
            value = self.ctx.named_value(t, port.name, force=True)
            nodes.append(value)
            assert len(list(self.graph.predecessors(dst))) == 1
            for edge in self.graph.out_edges(dst, data=True):
                _, descendant, data = edge
                edges.append((value, descendant, data))
            nodes_to_remove.append(dst)
        for node in nodes_to_remove:
            self.graph.remove_node(node)
        return nodes, edges


class NetToValueTransformer(NodeTransformer, Contextual):
    def __init__(self, g: Graph, ctx: MlirContext):
        super().__init__(g)
        self._ctx = ctx

    def visit_Net(self, node: Net):
        assert len(list(self.graph.predecessors(node))) == 1
        t = magma_type_to_mlir_type(type(node.ports[0]))
        value = self.ctx.anonymous_value(t)
        edges = list(replace_node(self.graph, node, value))
        return [value], edges


def _get_value_index(value: m.Type, values: List[m.Type]) -> int:
    for i, v in enumerate(values):
        if v is value:
            return i
    raise KeyError(value)


class EdgePortToIndexTransformer(NodeTransformer):
    def visit_Net(self, net: Net):
        assert isinstance(net, Net)
        return net

    def visit_MlirValue(self, value: MlirValue):
        assert isinstance(value, MlirValue)
        return value

    def generic_visit(self, node: Node):
        assert isinstance(node, (m.DefineCircuitKind, m.Circuit))
        edges = []
        node_inputs = node.interface.inputs(include_clocks=True)
        node_outputs = node.interface.outputs()
        for edge in self.graph.in_edges(node, data=True):
            src, dst, data = edge
            port = data["info"]
            data["info"] = _get_value_index(port, node_inputs)
            edges.append((src, dst, data))
        for edge in self.graph.out_edges(node, data=True):
            src, dst, data = edge
            port = data["info"]
            data["info"] = _get_value_index(port, node_outputs)
            edges.append((src, dst, data))
        return [node], edges


class ModuleToOpTransformer(NodeTransformer, Contextual):
    def __init__(self, g: Graph, ctx: MlirContext):
        super().__init__(g)
        self._ctx = ctx

    def visit_Net(self, net: Net):
        assert isinstance(net, Net)
        return net

    def visit_MlirValue(self, value: MlirValue):
        assert isinstance(value, MlirValue)
        return value

    def generic_visit(self, node: Node):
        assert isinstance(node, (m.DefineCircuitKind, m.Circuit))
        new_node = magma_module_to_mlir_op(self.ctx, node)
        edges = list(replace_node(self.graph, node, new_node))
        return [new_node], edges


def _sort_values(g: Graph, node: MlirOp):
    inputs = {}
    outputs = {}
    for edge in g.in_edges(node, data=True):
        src, _, data = edge
        assert isinstance(src, MlirValue)
        idx = data["info"]
        assert idx not in inputs
        inputs[idx] = src
    for edge in g.out_edges(node, data=True):
        _, dst, data = edge
        assert isinstance(dst, MlirValue)
        idx = data["info"]
        assert idx not in outputs
        outputs[idx] = dst
    inputs = [inputs[i] for i in range(len(inputs))]
    outputs = [outputs[i] for i in range(len(outputs))]
    return inputs, outputs


class MultiOpFlattener(NodeTransformer):
    def visit_MlirMultiOp(self, op: MlirMultiOp):
        # TODO(rsetaluri): Run this to convergence (i.e. until there are no more
        # multi-ops).
        assert isinstance(op, MlirMultiOp)
        nodes = list(op.graph.nodes)
        edges = list((u, v, data) for u, v, data in op.graph.edges(data=True))
        in_edges = list(self.graph.in_edges(op, data=True))
        in_edges = sorted(in_edges, key=lambda e: e[2]["info"])
        for new_dst, in_edge_idx, idx in op.primary_inputs:
            src, _, data = in_edges[in_edge_idx]
            data["info"] = idx
            edges.append((src, new_dst, data))
        for i, edge in enumerate(self.graph.out_edges(op, data=True)):
            _, dst, data = edge
            new_src, idx = op.primary_outputs[i]
            data["info"] = idx
            edges.append((new_src, dst, data))
        return nodes, edges


class RemoveSingletonCombConcatOpsTransformer(NodeTransformer):
    def visit_CombConcatOp(self, op: CombConcatOp):
        assert isinstance(op, CombConcatOp)
        predecessors = list(self.graph.predecessors(op))
        if len(predecessors) > 1:
            return op
        assert len(predecessors) == 1
        predecessor = predecessors[0]
        successors = list(self.graph.successors(op))
        assert len(successors) == 1
        successor = successors[0]
        edges = []
        for edge in self.graph.out_edges(successor, data=True):
            _, dst, data = edge
            edges.append((predecessor, dst, data))
        self.graph.remove_node(successor)
        return [predecessor], edges


class DeanonymizeValuesTransformer(NodeTransformer, Contextual):
    def __init__(self, g: Graph, ctx: MlirContext):
        super().__init__(g)
        self._ctx = ctx

    def visit_MlirValue(self, value: MlirValue):
        assert isinstance(value, MlirValue)
        if not mlir_value_is_anonymous(value):
            return value
        named_value = self.ctx.named_value(value.type)
        edges = list(replace_node(self.graph, value, named_value))
        return [named_value], edges


class EmitMlirVisitor(NodeVisitor):
    def __init__(self, g: Graph, emitter: MlirEmitter):
        super().__init__(g)
        self._emitter = emitter

    def visit_MlirValue(self, node: MlirValue):
        pass

    def generic_visit(self, node: MlirOp):
        assert isinstance(node, MlirOp)
        inputs, outputs = _sort_values(self.graph, node)
        # TODO(rsetaluri): We should think about how to structure this more
        # elegantly. It smells bad to do this transform here since it should be
        # done at the time that the magma op is lowered to the mlir op, not at
        # emit-time.
        if op_kind_get_attr(node, "inputs_reversed", default=False):
            inputs = list(reversed(inputs))
        self._emitter.emit_op(node, inputs, outputs)
