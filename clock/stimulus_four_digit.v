module stimulus_ac_four_digit;
reg [1:0]key_row;
reg [1:0]key_col;
reg keypad_int;
reg clk;
reg [15:0]key_buffer_in;

wire [15:0]key_buffer_out;
//reg [15:0]key_buffer_out;


ac_four_digit C1(key_buffer_out, key_buffer_in, keypad_int, clk, key_row, key_col);

initial
begin
	key_row = 2'b00;
	key_col = 2'b00;
	keypad_int = 1'b0;
	key_buffer_in = 16'b0000000000000000;
end

initial
begin
	// start
	// [4]
	#5 key_row <= 2'b01; key_col <= 2'b00;
	#5 keypad_int = 1'b1;
	#5 keypad_int = 1'b0;
	// [3]
	#5 key_row <= 2'b00; key_col <= 2'b10; key_buffer_in <= key_buffer_out;
	#5 keypad_int = 1'b1;
	#5 keypad_int = 1'b0;
	// [8]
	#5 key_row <= 2'b10; key_col <= 2'b01; key_buffer_in <= key_buffer_out;
	#5 keypad_int = 1'b1;
	#5 keypad_int = 1'b0;
	// [0]
	#5 key_row <= 2'b11; key_col <= 2'b01; key_buffer_in <= key_buffer_out;
	#5 keypad_int = 1'b1;
	#5 keypad_int = 1'b0;

	#10 $finish;
end

initial
begin
	$monitor($time, "key_row = %b, key_col = %b, value =  %b [%b][%b][%b] \n", key_row, key_col, key_buffer_out[15:12],key_buffer_out[11:8],key_buffer_out[7:4],key_buffer_out[3:0]);
end

endmodule