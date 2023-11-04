from PIL import Image
import numpy as np
import json

# Load the json list from the json file
json_path = 'pixel/public.json'
with open(json_path, 'r') as f:
    blocks = json.load(f)

# This list contain 30000 number,  3 adjacent number compose one [r, g, b] pixel 

pixels = np.zeros((10000, 3), dtype=np.float64)
for i in range(10000):
    for j in range(3): 
        pixels[i][j] = blocks.pop(0)

# divide each element by 12 
pixels = pixels / 12

# convert to uint8
pixels = pixels.astype(np.uint8)

# reshape to 100 * 100 * 3 
pixels = pixels.reshape((100, 100, 3))

# span the (100 * 100 *3 ) to (300 * 400 * 3)
# one pixels in (100 * 100 * 3) is 3 * 4 pixels in (300 * 400 * 3)

p2 = np.zeros((300, 400, 3), dtype=np.uint8)
for i in range(100):
    for j in range(100):
        for k in range(3):
            for l in range(4):
                p2[i*3+k][j*4+l] = pixels[i][j]

# convert to image
img = Image.fromarray(p2)



# save 
img.save('img/circom.jpg')
