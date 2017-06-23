/*
this is the matrix keypad model used in the alarm clock design */

module keypad (key, columns, rows);

input [3:0] key;
input [2:0] columns;

output [3:0] rows;
reg [3:0] rows;

always @ (key or columns)
begin
	// modified to be 0s, rather than 1s.
	rows <= 4'b0000;
	case (key)
		0	: rows[0] <= columns[1]; // [0]
		1	: rows[3] <= columns[2]; // [1]
		2	: rows[3] <= columns[1]; // [2]
		3	: rows[3] <= columns[0]; // [3]
		4	: rows[2] <= columns[2]; // [4]
		5	: rows[2] <= columns[1]; // [5]
		6	: rows[2] <= columns[0]; // [6]
		7	: rows[1] <= columns[2]; // [7]
		8	: rows[1] <= columns[1]; // [8]
		9	: rows[1] <= columns[0]; // [9]
		10	: rows[0] <= columns[2]; // [*] alarm button
		11	: rows[0] <= columns[0]; // [#] time button
	endcase
end
endmodule