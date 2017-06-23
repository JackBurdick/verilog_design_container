module keyscan_stimulus;

reg clk, reset, shift;
reg [3:0] rows;

wire [2:0] columns;
wire [3:0] key;
wire [3:0] key_buffer_0, key_buffer_1, key_buffer_2, key_buffer_3;
wire  time_button, alarm_button;

keyscan C1(clk, reset, shift, rows, columns, key, 
	   key_buffer_0, key_buffer_1, key_buffer_2, key_buffer_3, 
	   time_button, alarm_button);


initial
begin
	reset = 1'b0;
	shift = 1'b0;
	rows  = 3'b000;
	clk   = 1'b0;
end

always
begin
	#1 clk = !clk;
end


initial
begin
	// [4]
	#5 shift = 1'b0; rows = 3'b111;
	// [8]
	#5 shift = 1'b1; rows = 3'b000;
	// [2]
	#5 shift = 1'b1; rows = 3'b101;
	// [1]
	#5 shift = 1'b1; rows = 3'b110;

	#10 $finish;
end

initial
begin
	$monitor($time, "rows = %b, shift = %b, key = %d, [%d][%d][%d][%d] \n", rows, shift, key, key_buffer_3, key_buffer_2, key_buffer_1, key_buffer_0);
end

endmodule