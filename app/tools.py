import json

def string_to_json(input_string):
    lines = input_string.strip().split('\n')
    data = {}
    for line in lines:
        key, value = line.split(' : ')
        data[key.strip()] = value.strip()
    return json.dumps(data)

def json_to_string(json_string):
    data = json.loads(json_string)
    lines = [f"{key} : {value}" for key, value in data.items()]
    return '\n'.join(lines)

# Example usage:
#input_string = """key1 : value 1
#key2 : value 2
#key3 : value 3
#key4 : value 4"""

#json_string = string_to_json(input_string)
#print(json_string)

#output_string = json_to_string(json_string)
#print(output_string)

