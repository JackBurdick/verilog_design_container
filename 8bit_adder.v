module EightBit_Adder(Sum, Cout, A, B, Cin);
output [7:0]Sum;
output Cout;
input [7:0]A;
input [7:0]B;
input Cin;
wire w0;

// Chain two 4-bit adders to create 8-bit adder
// NOTE: Cin must be fixed to 0 if not chaining this module

// FourBit_Adder signature:
//	$ FourBit_Adder(Sum, Cout, A, B, Cin);

FourBit_Adder C1(Sum[3:0], w0, A[3:0], B[3:0], Cin);
FourBit_Adder C2(Sum[7:4], Cout, A[7:4], B[7:4], w0);

endmodule