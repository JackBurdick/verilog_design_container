module ac_four_digit(key_buffer_out, key_buffer_in, keypad_int, clk, key_row, key_col);

// 4(digits)*4(key_mapping) = 16 -> 15:0
output [15:0]key_buffer_out;
reg [15:0]key_buffer_out;
reg i;

input clk, keypad_int;
input [1:0]key_row;
input [1:0]key_col;
wire [1:0]key_row;
wire [1:0]key_col;
input [15:0]key_buffer_in;
//reg [15:0]key_buffer_in;

reg [1:0]key_row_req;
reg [1:0]key_col_req;
//wire [3:0]value;

wire [3:0]return_digit;

// register used to 
reg key_stim;

// current digit returned from keypad scanner
wire [3:0]cur_digit;

keypad_scanner C1(return_digit, key_row_req, key_col_req, key_stim);



always@(posedge keypad_int)
begin
	key_buffer_out = key_buffer_in;
	// place key selection in function
	// this should be fast enough that simultaneous button presses don't occur
	key_row_req = key_row;
	key_col_req = key_col;

	// create key_stim pulse to capture key entry
	key_stim = 1'b0;
	key_stim = 1'b1;
	//return_digit = value;
	key_stim = 1'b0;
	//return_digit = value;

	key_buffer_out = key_buffer_out<<4;
	key_buffer_out[3] = return_digit[3];
	//key_buffer_out = key_buffer_out<<1;
	key_buffer_out[2] = return_digit[2];
	//key_buffer_out = key_buffer_out<<1;
	key_buffer_out[1] = return_digit[1];
	//key_buffer_out = key_buffer_out<<1;
	key_buffer_out[0] = return_digit[0];
	

	
	// shift values from s into the key_buffer
	//for (i=3; i>=0; i = i-1)
	//begin
	//	// make room for new value
	//	key_buffer = key_buffer<<1;
	//	
	//	// insert value from scanner in LSB
	//	key_buffer[0] = value[i];
	//end

end

endmodule