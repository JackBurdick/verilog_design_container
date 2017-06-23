module timegen_stimulus;

reg clk, reset, stopwatch;

wire one_second, one_minute;

timegen C1(clk, reset, stopwatch, one_second, one_minute);

initial
begin
	reset = 1'b1;
	stopwatch = 1'b0;
	clk = 1'b0;
end

// have clock running so we capture posedge w/in module
initial
begin
	forever 
	begin
	#1 clk = ~clk;
	end
end

initial
begin
	#2 reset = 1'b0;
	#60000 $finish;
end

initial
begin
	$monitor($time, "one_second = %d, one_minute = %d \n", one_second, one_minute);
end

endmodule