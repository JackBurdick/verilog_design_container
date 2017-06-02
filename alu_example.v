module alu_example()
output [7:0]out;
reg [7:0]out;
input [3:0]A,B;
input [1:0]Sel;

always @(A or B or Sel)
begin
	if(Sel[1] == 1'b0 & Sel[0] == 1'b0
		Out = A + B;
	else if (Sel == 2'b01)
		Out = A - B;
	else if (Sel == 2'b10)
		Out = A*B;
	else if (Sel == 2'b11)
		Out = A/B;
	else
		// error message
end
endmodule