module Full_Adder (Sum, Carry, A, B, C);
output Sum, Carry;
input A, B, C;
wire w1, w2, w3;

// Chain two half adders to create `Sum`
// terminate with `or` of HA output to obtain `Carry`

// FourBit_Adder signature:
//    $ HA(Sum, Carry, A, B)

HA C1(w1, w2, A, B);
HA C2(Sum, w3, w1, C);
or C3(Carry, w2, w3);

endmodule