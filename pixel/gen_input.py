import json 

# read a json file "../img/t1_blocks.json"

json_path = '../img/t1_blocks.json'
with open(json_path, 'r') as f:
    blocks = json.load(f)

# convert the single list [...] into { "in": [...] }

data = {"in": blocks}

# write the data into a json file "input.json"

with open("input.json", "w") as f:
    json.dump(data, f)