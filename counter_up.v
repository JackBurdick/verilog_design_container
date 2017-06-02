module counter_up(out, clk, reset);
output [2:0] out;
reg [2:0] out;
input clk, reset;

always @(posedge clk)
begin
	if (reset == 1'b1)
		out <= 3'b000;
	else
		out <= out + 1;
end
endmodule
