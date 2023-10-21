from PIL import Image
import hashlib
import numpy as np 
import json
image_path = "img/t1_src.jpg" 
img = Image.open(image_path)


original_width, original_height = img.size
new_width = 400
new_height = 300

# 使用 PIL 的 resize 函数来压缩图像，该函数默认使用的是 ANTIALIAS 滤波器，可以保证压缩的效果
resized_img = img.resize((new_width, new_height), Image.ANTIALIAS)


resized_image_path = 'img/t1_compressed.jpg'
resized_img.save(resized_image_path)

img_list = np.array(resized_img).tolist()

# cal hash, after test the hash is constant, which means the compression is deterministic

with open(resized_image_path, 'rb') as f:
    bytes = f.read() 
    readable_hash = hashlib.sha256(bytes).hexdigest()
    print(readable_hash)
    