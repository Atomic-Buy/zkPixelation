from PIL import Image
import numpy as np
import json

# Load the blocks from the json file
json_path = 'img/t1_blocks.json'
with open(json_path, 'r') as f:
    blocks = json.load(f)
"""
# Decompress the RGB values in the blocks
for i in range(len(blocks)):
    R = (blocks[i] >> 16) & 0xFF
    G = (blocks[i] >> 8) & 0xFF
    B = blocks[i] & 0xFF
    blocks[i] = [R, G, B]

"""

# Define the block size
block_size = (3, 4)
print(len(blocks))
# build blocks from blocks list: convert [[R, G, B], ...] to [[[R, G, B], ...], ...] based on the block size 
# first 12 elements in blocks list is the first block, and so on
# each block is a 3*4 matrix of 12 elements, ordering from left to right, top to bottom
# first, pop 12 elements every time 
# second, convert 12 elements to 3*4 matrix
# third, append the 3*4 matrix to blocks_matrix
blocks_matrix = []
k = 0 
while k < 10000: 
    # new a 3 x 4 matrix array 
    matrix = np.zeros((3, 4, 3))
    # fill the matrix with 12 elements
    for i in range(3):
        for j in range(4):
            matrix[i][j] = blocks.pop(0)
    # append the matrix to blocks_matrix
    blocks_matrix.append(matrix)
    k += 1
print(len(blocks_matrix))

# combine 10000 small (3, 4) block into a big block (300, 400)

# 初始化一个空的 NumPy 数组来保存图像
img_array = np.zeros((300, 400, 3), dtype=np.uint8)

# range every blocks in blocks_matrix, copy to img_array

for index, block in enumerate(blocks_matrix): 
    # 计算块的左上角坐标
    i = (index // 100) * block_size[0]
    j = (index % 100) * block_size[1]
    # 将块复制到图像数组中
    img_array[i:i+block_size[0], j:j+block_size[1]] = block

# 将 NumPy 数组转换为图像
img = Image.fromarray(img_array)

# 保存图像
img.save('img/t1_decompressed.jpg')
    





