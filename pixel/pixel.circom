
pragma circom 2.0.0;

// calculate the avg of 12 numbers
template avg12(){
    signal input in[12]; 
    signal output out;
    signal sum;
    signal av1[11]; 
    // calucate avg, counting overflow 
    av1[0] <== in[0] + in[1];
    av1[1] <== av1[0] + in[2];
    av1[2] <== av1[1] + in[3];
    av1[3] <== av1[2] + in[4];
    av1[4] <== av1[3] + in[5];
    av1[5] <== av1[4] + in[6];
    av1[6] <== av1[5] + in[7];
    av1[7] <== av1[6] + in[8];
    av1[8] <== av1[7] + in[9];
    av1[9] <== av1[8] + in[10];
    av1[10] <== av1[9] + in[11];
    sum <== av1[10];
    out <== sum;
}

template rgbavg(){
    signal input in[12][3]; 
    signal output  out[3];
    // calculate avg for each rgb
    component r_avg12 = avg12();
    component g_avg12 = avg12();
    component b_avg12 = avg12();
    for (var i = 0; i < 12; i++){
        r_avg12.in[i] <== in[i][0];
        g_avg12.in[i] <== in[i][1];
        b_avg12.in[i] <== in[i][2];
    }
    out[0] <== r_avg12.out;
    out[1] <== g_avg12.out;
    out[2] <== b_avg12.out;
   
}
// pixelation a image with 12*N pixels
// return the avg color of each N block
template pixelation12N(N){
    signal input in[12 * N][3];
    signal output out[N][3];
    component avg12[N];
    for (var i= 0; i< N; i++){
        avg12[i] = rgbavg();
    }
    for(var i=0;i<N;i++){
        avg12[i].in[0] <== in[i*12];
        avg12[i].in[1] <== in[i*12+1];
        avg12[i].in[2] <== in[i*12+2];
        avg12[i].in[3] <== in[i*12+3];
        avg12[i].in[4] <== in[i*12+4];
        avg12[i].in[5] <== in[i*12+5];
        avg12[i].in[6] <== in[i*12+6];
        avg12[i].in[7] <== in[i*12+7];
        avg12[i].in[8] <== in[i*12+8];
        avg12[i].in[9] <== in[i*12+9];
        avg12[i].in[10] <== in[i*12+10];
        avg12[i].in[11] <== in[i*12+11];
        out[i] <== avg12[i].out;
    }
    signal tmp <== out[0][0] * out[0][1]; 
}
component main = pixelation12N(10000); 