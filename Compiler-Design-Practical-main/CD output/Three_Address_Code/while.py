def generate_output(input_text):
    # Splitting input text into lines
    lines = input_text.split('\n')
    
    output = []
    label_count = 1
    while_count = 1
    
    for line in lines:
        # Checking if the line contains while loop condition
        if 'while' in line:
            output.append(f"{label_count}) Goto_{label_count + 2}")
            output.append(f"{label_count + 1}) {line.strip()} goto {label_count + 5}")
            label_count += 2
        elif '{' in line or '}' in line:
            continue
        else:
            # Extracting variables and operations
            operations = line.split('=')
            variables = operations[0].split(',')
            if len(variables) == 1:
                output.append(f"{label_count}) T{label_count}={operations[1]}")
                output.append(f"{label_count + 1}) {variables[0].strip()}=T{label_count}")
            else:
                operation = operations[1].split('+')
                output.append(f"{label_count}) T{label_count}={operation[0]}")
                output.append(f"{label_count + 1}) {variables[0].strip()}=T{label_count}")
                output.append(f"{label_count + 2}) T{label_count + 3}={operation[1]}")
                output.append(f"{label_count + 3}) {variables[1].strip()}=T{label_count + 3}")
            output.append(f"{label_count + 4}) Goto_{label_count - 2}")
            label_count += 5
    
    output.append(f"{label_count}) END")
    return '\n'.join(output)

# Example input with while loop
input_text = """while (a<5)
{
c= b+d
d= i+j
}"""

output = generate_output(input_text)
print("Output:")
print(output)