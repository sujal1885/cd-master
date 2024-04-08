def copy_propagation(tac):
    symbol_table = {}
    optimized_tac = []

    for op, arg1, arg2, result in tac:
        if op == '=' and arg1 in symbol_table:
            symbol_table[result] = symbol_table[arg1]
        else:
            symbol_table[result] = (op, arg1, arg2)

    for op, arg1, arg2, result in tac:
        if op != '=' or result not in symbol_table or symbol_table[result] != (op, arg1, arg2):
            optimized_tac.append((op, arg1, arg2, result))

    return optimized_tac

def constant_propagation(tac):
    symbol_table = {}
    optimized_tac = []

    for op, arg1, arg2, result in tac:
        if arg1.isdigit():
            symbol_table[arg1] = result
        elif arg1 in symbol_table:
            arg1 = symbol_table[arg1]

        if arg2.isdigit():
            symbol_table[arg2] = result
        elif arg2 in symbol_table:
            arg2 = symbol_table[arg2]

        optimized_tac.append((op, arg1, arg2, result))

    return optimized_tac

def constant_folding(tac):
    optimized_tac = []

    for op, arg1, arg2, result in tac:
        if arg1.isdigit() and arg2.isdigit():
            if op == '+':
                value = int(arg1) + int(arg2)
            elif op == '-':
                value = int(arg1) - int(arg2)
            elif op == '*':
                value = int(arg1) * int(arg2)
            elif op == '/':
                value = int(arg1) / int(arg2)
            else:
                value = None

            optimized_tac.append(('=', str(value), '', result) if value is not None else (op, arg1, arg2, result))
        else:
            optimized_tac.append((op, arg1, arg2, result))

    return optimized_tac

def common_subexpression_elimination(tac):
    expressions = {}
    optimized_tac = []

    for op, arg1, arg2, result in tac:
        expression = (op, arg1, arg2)
        if expression not in expressions:
            expressions[expression] = result
            optimized_tac.append((op, arg1, arg2, result))
        else:
            optimized_tac.append(('=', expressions[expression], '', result))

    return optimized_tac

def dead_code_elimination(tac):
    used_symbols = set()
    optimized_tac = []

    for op, arg1, arg2, result in tac:
        if arg1:
            used_symbols.add(arg1)
        if arg2:
            used_symbols.add(arg2)
        if result in used_symbols or op == '=':
            optimized_tac.append((op, arg1, arg2, result))

    return optimized_tac

def optimize_tac(tac):
    optimized_tac = copy_propagation(tac)
    optimized_tac = constant_propagation(optimized_tac)
    optimized_tac = constant_folding(optimized_tac)
    optimized_tac = common_subexpression_elimination(optimized_tac)
    optimized_tac = dead_code_elimination(optimized_tac)

    return optimized_tac

tac = [
    ('=', '1', '', 't1'),
    ('+', 't1', '2', 't2'),
    ('=', 't2', '', 'x'),
    ('+', 'x', '3', 't3'),
    ('*', 't3', '0', 't4'),
    ('=', 't4', '', 'y'),
    ('+', 'x', '3', 't5'),
    ('=', 't5', '', 'z'),
    ('*', '3', '3', 't6'),
    ('=', 't6', '', 'w')
]


optimized_tac = optimize_tac(tac)

for instruction in optimized_tac:
    print(instruction)