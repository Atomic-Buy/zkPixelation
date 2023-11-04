from PIL import Image
import numpy as np

# Open the image file
img = Image.open('img/t1_compressed.jpg')

# Convert the image to numpy array for easier manipulation
np_img = np.array(img)

# Define the size of the pixelation
block_size = (3, 4)

# Create an empty array to store the pixelated image
pixelated_img = np.zeros((300, 400, 3))

# Loop over the image array by block
for i in range(0, 100, block_size[0]):
    for j in range(0, 100, block_size[1]):
        # Get the block
        block = np_img[i:i+block_size[0], j:j+block_size[1]]
        # calculate the avg color of the block 12 pixel 
        for k in range(block_size[0]):
            for l in range(block_size[1]):
                block[k][l] = block[k][l].tolist()
        avg_color = np.mean(block, axis=(0, 1))
        print(avg_color)
        # Fill the block with the average color
        for k in range(block_size[0]):
            for l in range(block_size[1]):
                pixelated_img[i+k][j+l] = avg_color
# Convert the result back to an Image object
pixelated_img = Image.fromarray(pixelated_img.astype('uint8'), 'RGB')

# Save the pixelated image
pixelated_img.save('img/t1_pixeled.jpg')
