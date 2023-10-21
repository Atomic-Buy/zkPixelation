from PIL import Image
import numpy as np

# 压缩后的图像路径
resized_image_path = 'img/t1_compressed.jpg'

# 打开图像并转换为 RGB
img = Image.open(resized_image_path).convert('RGB')

# 将图像转换为 NumPy 数组
img_array = np.array(img)



# 将 NumPy 数组转换为 Python 列表
img_list = img_array.tolist()

# 保存到文件
import json
json_path = 'img/t1_arr.json'
with open(json_path, 'w') as f:
    json.dump(img_list, f)

# cal hash, the hash is constent 
import hashlib
with open(json_path, 'rb') as f:
    bytes = f.read() 
    readable_hash = hashlib.sha256(bytes).hexdigest()
    print(readable_hash)