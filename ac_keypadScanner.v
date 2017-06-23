module keypad_scanner(value, key_row, key_col, stimulus);

input stimulus;

input [1:0]key_row;
input [1:0]key_col;

output [3:0]value;
reg [3:0]value;
/*
0-0000
1-0001
2-0010
3-0011
4-0100
5-0101
6-0110
7-0111
8-1000
9-1001
*-1010
#-1011
err-(1100,1101,1110,*1111*)

*/

// keypad scanner perfoms a basic mapping of [row,col] to
// determine the mapped value.

// col 1 [1, 4, 7, *]
always@ (posedge stimulus)
if (key_col == 2'b00)
begin
	// row 0
	if (key_row == 2'b00)
	begin
		// [1]
		value <= 4'b0001;
	end
	// row 1
	else if (key_row == 2'b01)
	begin
		// [4]
		value <= 4'b0100;
	end
	// row 2
	else if (key_row == 2'b10)
	begin
		// [7]
		value <= 4'b0111;
	end
	else
	// row 3
	begin
		// [*]
		value <= 4'b1010;
	end
end
// col 2 [2, 5, 8, 0]
else if (key_col == 2'b01)
begin
	// row 0
	if (key_row == 2'b00)
	begin
		// [2]
		value <= 4'b0010;
	end
	// row 1
	else if (key_row == 2'b01)
	begin
		// [5]
		value <= 4'b0101;
	end
	// row 2
	else if (key_row == 2'b10)
	begin
		// [8]
		value <= 4'b1000;
	end
	// row 3
	else
	begin
		// [0]
		value <= 4'b0000;
	end
end
// col 3 [3, 6, 9, #]
else if (key_col == 2'b10)
begin
	// row 0
	if (key_row == 2'b00)
	begin
		// [3]
		value <= 4'b0011;
	end
	// row 1
	else if (key_row == 2'b01)
	begin
		// [6]
		value = 4'b0110;
	end
	// row 2
	else if (key_row == 2'b10)
	begin
		// [9]
		value <= 4'b1001;
	end
	// row 3
	else
	begin
		// [#]
		value <= 4'b1011;
	end
end
// error
else
begin
	value <= 4'b1111;
end

endmodule