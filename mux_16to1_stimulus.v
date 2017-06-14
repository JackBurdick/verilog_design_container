module stimulus_mux_16to1;
reg [15:0]In;
reg [3:0]Sel;
wire Out;

mux_16to1 C1(Out, In, Sel);

// inital block
initial
begin
	Sel = 4'b0000;
	//In = 16'b1111000011110000;
	In = 16'b1010101010101010;
end

// assignment
initial
begin
	#5 Sel = 4'b0001;
	#5 Sel = 4'b0010;
	#5 Sel = 4'b0011;
	#5 Sel = 4'b0100;
	#5 Sel = 4'b0101;
	#5 Sel = 4'b0110;
	#5 Sel = 4'b0111;
	#5 Sel = 4'b1000;
	#5 Sel = 4'b1001;
	#5 Sel = 4'b1010;
	#5 Sel = 4'b1011;
	#5 Sel = 4'b1100;
	#5 Sel = 4'b1101;
	#5 Sel = 4'b1110;
	#5 Sel = 4'b1111;
	#10 $finish;
end

// monitor
initial
begin
	$monitor($time, " Out = %b, Sel = %d", Out, Sel);
end

endmodule