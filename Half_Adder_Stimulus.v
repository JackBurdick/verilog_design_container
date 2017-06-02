module stimulus_HA;
reg A, B;
wire Sum, Carry;

HA C1(Sum, Carry, A, B);

initial
begin
	A = 1'b0;
	B = 1'b0;
end

initial
begin
	#5 A = 1'b0; B = 1'b1;
	#5 A = 1'b1; B = 1'b0;
	#5 A = 1'b1; B = 1'b1;
	#10 $finish;
end

initial
begin
	$monitor($time, "Sum = %b, Carry = %b, A = %b, B = %b \n", Sum, Carry, A, B);
end

endmodule