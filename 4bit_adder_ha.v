module FourBit_Adder_HA(Sum, Carry, A, B);
output [3:0]Sum;
output Carry;
input [3:0]A;
input [3:0]B;
wire [2:0]w;

// HA signature:
//    $ module HA (Sum, Carry, A, B);

// Full_Adder signature:
//    $ Full_Adder (Sum, Carry, A, B, C);

HA C1(Sum[0], w[0], A[0], B[0]);
Full_Adder C2(Sum[1], w[1], A[1], B[1], w[0]);
Full_Adder C3(Sum[2], w[2], A[2], B[2], w[1]);
Full_Adder C4(Sum[3], Carry, A[3], B[3], w[2]);
endmodule