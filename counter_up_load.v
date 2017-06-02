module counter_up_with_load(out, clk, reset, load, in);
output [2:0] out;
reg [2:0] out;
input clk, reset, load;
input [2:0] in;	// value to load

// load has to become 1 then 0

always @(posedge clk or reset)
begin
	if (reset == 1'b1)
		out <= 3'b000;
	else if (load == 1'b1)
		out <= in;
	else
		out <= out + 1;
end
endmodule
