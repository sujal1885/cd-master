import sys
from tabulate import tabulate

terminals = ['a', 'b', 'c', 'd']
non_terminals = ['S', 'A', 'B']
starting_symbol = 'A'
productions = ["A->SB/B", "S->a/Bc/e", "B->b/d"]
productions_dict = {nT: [] for nT in non_terminals}

for production in productions:
    nonterm_to_prod = production.split("->")
    alternatives = nonterm_to_prod[1].split("/")
    for alternative in alternatives:
        productions_dict[nonterm_to_prod[0]].append(alternative)

LL1_table = {}
conflicts = False

def first(string):
    first_ = set()
    if string in non_terminals:
        alternatives = productions_dict[string]
        for alternative in alternatives:
            first_2 = first(alternative)
            first_ |= first_2
    elif string in terminals:
        first_ = {string}
    elif string == '' or string == 'e':
        first_ = {'e'}
    else:
        first_2 = first(string[0])
        if 'e' in first_2:
            i = 1
            while 'e' in first_2:
                first_ |= (first_2 - {'e'})
                if string[i:] in terminals:
                    first_ |= {string[i:]}
                    break
                elif string[i:] == '':
                    first_ |= {'e'}
                    break
                first_2 = first(string[i:])
                first_ |= (first_2 - {'e'})
                i += 1
        else:
            first_ |= first_2
    return first_

def follow(nT):
    follow_ = set()
    prods = productions_dict.items()
    if nT == starting_symbol:
        follow_ |= {'$'}
    for nt, rhs in prods:
        for alt in rhs:
            for char in alt:
                if char == nT:
                    following_str = alt[alt.index(char) + 1:]
                    if following_str == '':
                        if nt == nT:
                            continue
                        else:
                            follow_ |= follow(nt)
                    else:
                        follow_2 = first(following_str)
                        if 'e' in follow_2:
                            follow_ |= (follow_2 - {'e'})
                            follow_ |= follow(nt)
                        else:
                            follow_ |= follow_2
    return follow_

FIRST = {non_terminal: set() for non_terminal in non_terminals}
FOLLOW = {non_terminal: set() for non_terminal in non_terminals}

for non_terminal in non_terminals:
    FIRST[non_terminal] |= first(non_terminal)
FOLLOW[starting_symbol] |= {'$'}

for non_terminal in non_terminals:
    FOLLOW[non_terminal] |= follow(non_terminal)

print("{: ^20}{: ^20}{: ^20}".format('Non Terminals', 'First', 'Follow'))
for non_terminal in non_terminals:
    print("{: ^20}{: ^20}{: ^20}".format(non_terminal, str(FIRST[non_terminal]), str(FOLLOW[non_terminal])))

for non_terminal, alternatives in productions_dict.items():
    for alternative in alternatives:
        first_set_alt = first(alternative)
        for terminal in first_set_alt - {'e'}:
            if (non_terminal, terminal) not in LL1_table:
                LL1_table[(non_terminal, terminal)] = alternative
            else:
                print(f"Conflict at ({non_terminal}, {terminal})")
                conflicts = True
        if 'e' in first_set_alt or '' in first_set_alt: 
            for terminal in FOLLOW[non_terminal]:
                if (non_terminal, terminal) not in LL1_table:
                    LL1_table[(non_terminal, terminal)] = alternative
                else:
                    print(f"Conflict at ({non_terminal}, {terminal})")
                    conflicts = True


table_data = []
for key, value in LL1_table.items():
    table_data.append([key[0], key[1], value])

print(tabulate(table_data, headers=['Non Terminal', 'Terminal', 'Production'], tablefmt='grid'))
if not conflicts:
    print("No conflicts found.")###

def validate_string(input_string):
    stack = [starting_symbol]
    buffer = list(input_string)
    buffer.append('$')  

    steps = []  # Collecting steps for table display

    while len(stack) > 0:
        top_of_stack = stack[-1]
        current_input = buffer[0]

        if top_of_stack == current_input:
            action = "Matched '{}'".format(current_input)
            stack.pop()
            buffer.pop(0)
        else:
            if (top_of_stack, current_input) in LL1_table:
                production = LL1_table[(top_of_stack, current_input)]
                stack.pop()
                if production != 'ε':
                    for symbol in reversed(production):
                        stack.append(symbol)
                action = "Applied production '{}'".format(top_of_stack + '->' + production)
            else:
                action = "Error: No valid action found"
                break

        steps.append([action, ''.join(stack), ''.join(buffer)])  # Collecting step details

    # Prepare data for tabulate
    table_data = [['Step', 'Action', 'Stack', 'Buffer Input']]
    for idx, step in enumerate(steps):
        table_data.append([idx + 1, step[0], ' '.join(step[1]), ' '.join(step[2])])

    # Print the table
    print(tabulate(table_data, headers='firstrow', tablefmt='grid'))

    # Print final result
    if len(stack) == 0 and '$' in buffer:
        print("\nString '{}' is valid.".format(input_string))
    else:
        print("\nString '{}' is invalid.".format(input_string))

validate_string("ad")
