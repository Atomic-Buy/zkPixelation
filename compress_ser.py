from PIL import Image
import numpy as np
import json
import hashlib

# 压缩后的图像路径
resized_image_path = 'img/t1_compressed.jpg'

# 打开图像并转换为 RGB
img = Image.open(resized_image_path).convert('RGB')

# 将图像转换为 NumPy 数组
img_array = np.array(img)

# print img_array dimension 
print(img_array.shape)
# 定义块的大小
block_size = (3, 4)

# 初始化一个空列表来保存块
blocks = []

# 遍历图像，将其划分为块
for i in range(0, img_array.shape[0], block_size[0]):
    for j in range(0, img_array.shape[1], block_size[1]):
        # 获取当前块
        block = img_array[i:i+block_size[0], j:j+block_size[1]]
        # conpress the block from (w, h, rgb) to [rgb] list 
        block = block.reshape(-1, 3).tolist()
        
        # 将块添加到列表中
        for rgb in block:
            blocks.append(rgb)

print(len(blocks))
"""
# compress the [R, G, B] in blocks list into ( R<< 16 + G <<8 + B)
for i in range(len(blocks)):
    blocks[i] = (blocks[i][0] & 0xFF) << 16  | (blocks[i][1] & 0xFF) << 8 | (blocks[i][2] & 0xFF)

"""
print(len(blocks))
# 保存到文件
json_path = 'img/t1_blocks.json'
with open(json_path, 'w') as f:
    json.dump(blocks, f)

# 计算哈希值
with open(json_path, 'rb') as f:
    bytes = f.read() 
    readable_hash = hashlib.sha256(bytes).hexdigest()
    print(readable_hash)