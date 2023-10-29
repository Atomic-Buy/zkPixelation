pragma circom 2.0.0;

include "../circomlib/circuits/poseidon.circom";

template Poseidon2() {
    signal input in[2];
    signal output out;

    component poseidon = Poseidon(2);
    poseidon.inputs <== in;
    out <== poseidon.out;
}
// template of merkle tree witch is 2 ^ 4 leaves 
template MerkleN(N){
    signal input in[2 ** N];
    signal output out;
    component layers[N];
    for (var i = 0; i < N; i++){
        layers[i] = MerkleLayer(N -i);
    }
    layers[0].in <== in;
    for (var i = 0; i < N - 1; i++){
        layers[i + 1].in <== layers[i].out;
    }
    out <== layers[N - 1].out[0];
    
}

template Merkle4(){
    signal input in[16];
    signal output out;
    component layer1 = MerkleLayer(4);
    component layer2 = MerkleLayer(3);
    component layer3 = MerkleLayer(2);
    component layer4 = MerkleLayer(1);
    layer1.in <== in;
    layer2.in <== layer1.out;
    layer3.in <== layer2.out;
    layer4.in <== layer3.out;
    out <== layer4.out[0];
}

template Merkle12(){
    signal input in[4096];
    signal output out;
    component layer1 = MerkleLayer(12);
    component layer2 = MerkleLayer(11);
    component layer3 = MerkleLayer(10);
    component layer4 = MerkleLayer(9);
    component layer5 = MerkleLayer(8);
    component layer6 = MerkleLayer(7);
    component layer7 = MerkleLayer(6);
    component layer8 = MerkleLayer(5);
    component layer9 = MerkleLayer(4);
    component layer10 = MerkleLayer(3);
    component layer11 = MerkleLayer(2);
    component layer12 = MerkleLayer(1);
    layer1.in <== in;
    layer2.in <== layer1.out;
    layer3.in <== layer2.out;
    layer4.in <== layer3.out;
    layer5.in <== layer4.out;
    layer6.in <== layer5.out;
    layer7.in <== layer6.out;
    layer8.in <== layer7.out;
    layer9.in <== layer8.out;
    layer10.in <== layer9.out;
    layer11.in <== layer10.out;
    layer12.in <== layer11.out;
    out <== layer12.out[0];
}

template Merkle15(){
    signal input in[32768];
    signal output out;
    component layer1 = MerkleLayer(15);
    component layer2 = MerkleLayer(14);
    component layer3 = MerkleLayer(13);
    component layer4 = MerkleLayer(12);
    component layer5 = MerkleLayer(11);
    component layer6 = MerkleLayer(10);
    component layer7 = MerkleLayer(9);
    component layer8 = MerkleLayer(8);
    component layer9 = MerkleLayer(7);
    component layer10 = MerkleLayer(6);
    component layer11 = MerkleLayer(5);
    component layer12 = MerkleLayer(4);
    component layer13 = MerkleLayer(3);
    component layer14 = MerkleLayer(2);
    component layer15 = MerkleLayer(1);
    layer1.in <== in;
    layer2.in <== layer1.out;
    layer3.in <== layer2.out;
    layer4.in <== layer3.out;
    layer5.in <== layer4.out;
    layer6.in <== layer5.out;
    layer7.in <== layer6.out;
    layer8.in <== layer7.out;
    layer9.in <== layer8.out;
    layer10.in <== layer9.out;
    layer11.in <== layer10.out;
    layer12.in <== layer11.out;
    layer13.in <== layer12.out;
    layer14.in <== layer13.out;
    layer15.in <== layer14.out;
    out <== layer15.out[0];
}
template MerkleLayer(N){
    var total_hash = 2 ** (N - 1); 
    signal input in[total_hash * 2];
    signal output out[total_hash];
    component poseidon[total_hash];
    for (var i = 0; i < total_hash; i++){
        poseidon[i] = Poseidon2();
    }
    for(var i=0;i<total_hash;i++){
        poseidon[i].in[0] <== in[2*i];
        poseidon[i].in[1] <== in[2*i+1];
        out[i] <== poseidon[i].out;
    }
}

component main = Merkle15();
