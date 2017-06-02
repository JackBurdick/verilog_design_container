module FourBit_Adder(Sum, Cout, A, B, Cin);
output [3:0]Sum;
output Cout;
input [3:0]A;
input [3:0]B;
input Cin;
wire [2:0]w;

// Chain four full adders to create 4-bit adder
// NOTE: Cin must be fixed to 0 if not chaining this module

// Full_Adder signature:
//    $ Full_Adder (Sum, Carry, A, B, C);

Full_Adder C1(Sum[0], w[0], A[0], B[0], Cin);
Full_Adder C2(Sum[1], w[1], A[1], B[1], w[0]);
Full_Adder C3(Sum[2], w[2], A[2], B[2], w[1]);
Full_Adder C4(Sum[3], Cout, A[3], B[3], w[2]);

endmodule