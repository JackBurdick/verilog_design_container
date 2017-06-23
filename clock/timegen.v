module timegen (clk, reset, stopwatch, one_second, one_minute);

input clk, reset, stopwatch;

output one_second, one_minute;

// assuming that our clock as 256 cycles in a second
parameter LIMIT = ((256*60)-1);
//parameter LIMIT = 100;

reg one_second, one_minute;

// counter width must be 14
// LIMIT = 15360 (256*60)-1.. 14'b array
reg [13:0]one_minute_count;


// minute count logic
// asynchonous reset
always @(posedge clk or posedge reset)
begin
	if(reset)
		one_minute_count <= 0;
	else
		one_minute_count <= (one_minute_count == LIMIT) ? 0: one_minute_count+1;
end

// second logic
// asynchonous reset
always @(posedge clk or posedge reset)
begin
	if (reset)
	begin
		one_second <= 0;
	end
	else
	begin
		one_second <= (one_minute_count[7:0] == 0);
		one_minute <= stopwatch ? (one_minute_count[7:0] == 0) : (one_minute_count == 0);
	end
end
endmodule