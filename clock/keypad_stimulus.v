module keypad_stimulus;

reg [2:0] columns_a;
reg [3:0] key_a;

wire [3:0] rows_a;

keypad C1(key_a, columns_a, rows_a);

initial
begin
	columns_a = 3'b000;
	key_a = 4'b0000;
end

initial
begin
	// [4]
	#5 key_a = 4'b0100; columns_a = 3'b100;
	// [8]
	#5 key_a = 4'b1000; columns_a = 3'b010;
	// [2]
	#5 key_a = 4'b0010; columns_a = 3'b010;
	// [1]
	#5 key_a = 4'b0001; columns_a = 3'b100;

	#10 $finish;
end

initial
begin
	$monitor($time, "key_row = %b, key_col = %b, value = %d \n", rows_a, columns_a, key_a);
end

endmodule