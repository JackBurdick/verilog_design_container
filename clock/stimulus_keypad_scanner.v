module stimulus_keypad_scanner;
reg [1:0]key_row;
reg [1:0]key_col;
reg stimulus;
wire [3:0]value;

keypad_scanner C1(value, key_row, key_col, stimulus);

initial
begin
	key_row = 2'b00;
	key_col = 2'b00;
	stimulus = 1'b0;
end

initial
begin
	// start
	// [4]
	#5 key_row = 2'b01; key_col = 2'b00;
	#5 stimulus = 1'b1;
	#5 stimulus = 1'b0;
	// [3]
	#5 key_row = 2'b00; key_col = 2'b10;
	#5 stimulus = 1'b1;
	#5 stimulus = 1'b0;
	// [8]
	#5 key_row = 2'b10; key_col = 2'b01;
	#5 stimulus = 1'b1;
	#5 stimulus = 1'b0;
	// [0]
	#5 key_row = 2'b11; key_col = 2'b01;
	#5 stimulus = 1'b1;
	#5 stimulus = 1'b0;
	// shouldn't return to [8]
	#5 key_row = 2'b10; key_col = 2'b01;
	#10 $finish;
end

initial
begin
	$monitor($time, "key_row = %b, key_col = %b, value = %d \n", key_row, key_col, value);
end

endmodule