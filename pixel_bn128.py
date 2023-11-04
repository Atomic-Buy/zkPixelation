import numpy as np
from py_ecc.bn128 import FQ

def extended_gcd(a, b):
    if a == 0:
        return b, 0, 1
    else:
        g, y, x = extended_gcd(b % a, a)
        return g, x - (b // a) * y, y

def mod_inverse(a, m):
    g, x, y = extended_gcd(a, m)
    if g != 1:
        raise Exception('Modular inverse does not exist')
    else:
        return x % m

def compute_average(numbers, mod, inverse):
    sum_numbers = sum(numbers)
    return (sum_numbers * inverse) % mod

# get a image ( 12 * N, 3)
def pixelation12N(image, N):
    mod = FQ.field_modulus
    output = np.zeros((N, 3), dtype=int)
    inverse12 = mod_inverse(12, mod)
    for i in range(N):
        for j in range(3):
            output[i][j] = compute_average(image[i*12:(i+1)*12, j], mod, inverse12)
    return output

# replace with your image data
image = np.random.randint(0, 256, (1200, 3))  # a random image with 120000 pixels
output = pixelation12N(image, 100)
print(output)
