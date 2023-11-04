pragma circom 2.0.0;

include "../circomlib/circuits/poseidon.circom";

template Poseidon15() {
    signal input in[15];
    signal output out;

    component poseidon = Poseidon(15);
    poseidon.inputs <== in;
    out <== poseidon.out;
}
//a merkle layer with 15^N leaves
template LayerN(N){
    var total_gate = 15 ** (N-1); 
    signal input in[total_gate * 15];
    signal output out[total_gate]; 
    component poseidon[total_gate]; 
    for (var i = 0; i < total_gate; i++){
        poseidon[i] = Poseidon15();
    }
    for(var i = 0; i < total_gate; i++){
        poseidon[i].in[0] <== in[15*i];
        poseidon[i].in[1] <== in[15*i+1];
        poseidon[i].in[2] <== in[15*i+2];
        poseidon[i].in[3] <== in[15*i+3];
        poseidon[i].in[4] <== in[15*i+4];
        poseidon[i].in[5] <== in[15*i+5];
        poseidon[i].in[6] <== in[15*i+6];
        poseidon[i].in[7] <== in[15*i+7];
        poseidon[i].in[8] <== in[15*i+8];
        poseidon[i].in[9] <== in[15*i+9];
        poseidon[i].in[10] <== in[15*i+10];
        poseidon[i].in[11] <== in[15*i+11];
        poseidon[i].in[12] <== in[15*i+12];
        poseidon[i].in[13] <== in[15*i+13];
        poseidon[i].in[14] <== in[15*i+14];
        out[i] <== poseidon[i].out;
    }
}
// a 15-merkle tree with 15^N leaves
template RecursiveN(N){
    signal input in[15**N];
    signal output out;
    component layers[N];
    for (var i = 0; i < N; i++) {
        layers[i] = LayerN(N - i);
    }
    layers[0].in <== in;
    for (var i = 1; i < N; i++) {
        layers[i].in <== layers[i-1].out;
    }
    out <== layers[N-1].out[0];
}

// a single layer of 15-merkle tree which take 12000 inputs and 800 outputs
template hash15N(N){
    var num_input = N * 15; 
    signal input in[num_input];
    signal output out[N];
    component hash[N]; 
    for (var i = 0; i < N; i++){
        hash[i] = Poseidon15();
    }
    for(var i = 0; i < N; i++){
        hash[i].in[0] <== in[15*i];
        hash[i].in[1] <== in[15*i+1];
        hash[i].in[2] <== in[15*i+2];
        hash[i].in[3] <== in[15*i+3];
        hash[i].in[4] <== in[15*i+4];
        hash[i].in[5] <== in[15*i+5];
        hash[i].in[6] <== in[15*i+6];
        hash[i].in[7] <== in[15*i+7];
        hash[i].in[8] <== in[15*i+8];
        hash[i].in[9] <== in[15*i+9];
        hash[i].in[10] <== in[15*i+10];
        hash[i].in[11] <== in[15*i+11];
        hash[i].in[12] <== in[15*i+12];
        hash[i].in[13] <== in[15*i+13];
        hash[i].in[14] <== in[15*i+14];
        out[i] <== hash[i].out;
    }
}
component main = hash15N(800);