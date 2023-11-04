circom pixel.circom --wasm --c --r1cs

cd pixel_cpp 

make 

./pixel ../input.json ../output.wtns

cd ..

snarkjs groth16 setup pixel.r1cs p15_final.ptau pixel_0001.zkey

snarkjs zkey contribute pixel_0001.zkey pixel_0002.zkey --name="1st Contributor Name" -v -e="sdfasdfds"

snarkjs zkey export verificationkey pixel_0002.zkey verification_key.json


snarkjs groth16 prove pixel_0002.zkey ./output.wtns proof.json public.json 



