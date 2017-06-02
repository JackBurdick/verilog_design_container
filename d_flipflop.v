module d_flipflop (q, d, clk, reset);
input d, clk, reset;
output q;
reg q;


// will only execute one or the other
// (un)comment selection


// asychronous reset
always @(posedge clk or reset)
begin
	if (reset == 1'b1)
		q <= 1'b0;
	else
		q <= d;
end

/*
// sychronous reset
always @(posedge clk)
begin
	if (reset == 1'b1)
		q <= 1'b0;
	else
		q <= d;
end
*/
endmodule

