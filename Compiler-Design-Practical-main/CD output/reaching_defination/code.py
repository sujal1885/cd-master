from tabulate import tabulate

class Block:
    def __init__(self, name):
        self.name = name
        self.gen = set()
        self.kill = set()
        self.pred = set()
        self.in_set = set()
        self.out_set = set()

class FlowGraph:
    def __init__(self):
        self.blocks = {}

    def add_block(self, name, gen, kill, pred):
        block = Block(name)
        block.gen = set(gen)
        block.kill = set(kill)
        block.pred = set(pred)
        self.blocks[name] = block

    def compute_in_out_sets(self):
        for block in self.blocks.values():
            block.out_set = set()

        for block in self.blocks.values():
            block.in_set = block.gen.copy()

        changed = True
        iteration = 0
        while changed:
            changed = False
            iteration += 1
            print("Iteration", iteration, ":")

            table = [["Block", "GEN", "KILL", "Predecessor", "IN", "OUT"]]
            for block in self.blocks.values():
                in_set_before = block.in_set.copy()
                out_set_before = block.out_set.copy()
                out_set = set()
                for succ_name in block.pred:
                    succ_block = self.blocks[succ_name]
                    out_set.update(succ_block.in_set)
                block.out_set = out_set
                in_set = block.gen.union(block.out_set.difference(block.kill))
                block.in_set = in_set
                if in_set_before != block.in_set or out_set_before != block.out_set:
                    changed = True

                table.append([
                    block.name,
                    block.gen,
                    block.kill,
                    block.pred,
                    block.in_set,
                    block.out_set
                ])

            print(tabulate(table, headers="firstrow", tablefmt="grid"))
            print()

flow_graph = FlowGraph()
flow_graph.add_block("B1", [1, 2], [6, 10, 11], [])
flow_graph.add_block("B2", [3, 4], [5, 8], ["B1", "B4"])
flow_graph.add_block("B3", [5], [4, 8], ["B2", "B5"])
flow_graph.add_block("B4", [6, 7], [2, 9, 11], ["B2", "B3"])
flow_graph.add_block("B5", [8, 9], [4, 5, 7], ["B3"])
flow_graph.add_block("B6", [10, 11], [1, 2, 6], ["B4"])
flow_graph.compute_in_out_sets()
