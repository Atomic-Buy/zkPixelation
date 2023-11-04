import json
import random

# Generate a list of 12000 random integers in the range [0, 2^240 - 1]
numbers = [random.randint(0, 2**240 - 1) for _ in range(12000)]

# Create a dictionary with the list under the key "input"
data = {"in": numbers}

# Open the file "input.json" in write mode
with open("input.json", "w") as f:
    # Write the dictionary to the file in JSON format
    json.dump(data, f)
