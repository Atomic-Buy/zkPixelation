# Proof of Pixelation 

## Overall: 

- Define function Pixel, which `Pixel(x) = y`, where x is the array of original image array, y is the pixelated image array. 
- Define sha256, where `sha256(x)= h1, sha256(y) = h2`
- Define a circuit C, where `C(private x, private y, h1, h2) = true ` iff `Pixel(x) == y && sha256(x) == h1, && sha256(y) == h2`. 
-  Define a function F where `F(C, w) = 0` iff `C == true`, `w = [x,y]`. 

## Prove of Sha256 preimage 
Zokrates Sha256 implementation [source code](https://github.com/Zokrates/ZoKrates/blob/latest/zokrates_stdlib/stdlib/hashes/sha256/sha256.zok)
```
import "./shaRound" as shaRound;

// Initial values, FIPS 180-3, section 5.3.3
// https://csrc.nist.gov/csrc/media/publications/fips/180/3/archive/2008-10-31/documents/fips180-3_final.pdf
const u32[8] IV = [
    0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
    0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
];

// A function that takes N u32[16] arrays as inputs, concatenates them,
// and returns their sha256 compression as a u32[8].
// Note: no padding is applied
def main<N>(u32[N][16] a) -> u32[8] {
    u32[8] mut current = IV;

    for u32 i in 0..N {
        current = shaRound(a[i], current);
    }

    return current;
}
```
As this function only accept `N u32[16]m ( N * 512 bits)`, so if we want to calculate a `H x W` RGB-8bit depth color image's sha256, we concat the RGB color into a 24 bits value and see it as u32. This means the total number of points should be modified by 16. For test, we set `H = 300, W = 400`. 

## Feasibility Test 

### Preimage test 
Using zokrates gen circuit which calculate `(12 * 32 *16)` bits hash will consume almost all my 16gig ram, and the output r1cs circuit is about 3.7G. So circuit which calculate the hash of a 300x400 will be HUGE. 

```
-rw-rw-r-- 1 vielo vielo  501 Oct 21 20:19 abi.json
-rw-rw-r-- 1 vielo vielo 3.7G Oct 21 20:19 out
-rw-rw-r-- 1 vielo vielo 1.5G Oct 21 20:19 out.r1cs
-rw-rw-r-- 1 vielo vielo  345 Oct 21 20:18 p2.zok
```