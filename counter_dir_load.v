module counter_up_down_with_load(out, clk, reset, dir, load, in);
output [2:0] out;
reg [2:0] out;
input clk, reset, load, dir;
input [2:0] in;	// value to load

// load has to become 1 then 0

always @(posedge clk or reset)
begin
	if (reset == 1'b1)
		out <= 3'b000;
	else if (load == 1'b1)
		out <= in;
	else if (dir == 1'b1)
		out <= out + 1;
	else
		out <= out - 1;
end
endmodule