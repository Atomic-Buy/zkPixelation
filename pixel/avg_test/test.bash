circom rgbavg.circom --wasm --c --r1cs

cd rgbavg_cpp 

make 

./rgbavg ../input.json ../output.wtns

cd ..

snarkjs groth16 setup rgbavg.r1cs pot12_final.ptau multiplier2_0000.zkey

snarkjs zkey contribute multiplier2_0000.zkey multiplier2_0001.zkey --name="1st Contributor Name" -v 



