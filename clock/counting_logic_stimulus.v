module counting_logic_stimulus;

reg [3:0]	new_current_time_ls_min,
		new_current_time_ms_min,
		new_current_time_ls_hr,
		new_current_time_ms_hr;
reg		new_current_time_AM;

reg load_new_c, reset, clk, one_minute;

wire [3:0]	current_time_ls_min,
		current_time_ms_min,
		current_time_ls_hr,
		current_time_ms_hr;
wire		current_time_AM;

counting_logic C1(new_current_time_ls_min, new_current_time_ms_min,
		new_current_time_ls_hr, new_current_time_ms_hr, new_current_time_AM,
		load_new_c, reset, clk, one_minute,
		current_time_ls_min, current_time_ms_min,
		current_time_ls_hr, current_time_ms_hr, current_time_AM);


initial
begin
	reset = 1'b0;
	clk = 1'b0;
	one_minute = 1'b0;

	new_current_time_ls_min = 4'b0000;
	new_current_time_ms_min = 4'b0000;
	new_current_time_ls_hr = 4'b0000;
	new_current_time_ms_hr  = 4'b0000;
	new_current_time_ms_hr  = 1'b0;
	new_current_time_AM = 1'b0;
	
	load_new_c = 1'b0;
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
	// set reset high to wipe clock
	#5 reset = 1'b1;
	#5 reset = 1'b0;
	//load value onto clock
	#5 load_new_c = 1'b0;
	// [1][2]:[5][8]{AM=1]
	#5 new_current_time_ms_hr = 4'b0001; new_current_time_ls_hr = 4'b0010; new_current_time_ms_min = 4'b0101; new_current_time_ls_min = 4'b1000; new_current_time_AM = 1'b1; load_new_c = 1'b1;
	#5 load_new_c = 1'b0;
	// set one_minute high to begin counting -- for simulation, we don't need to pulse
	#1 one_minute = 1'b1;
	// this should count 10 values (wait time/2 for clk cycle)
	#20 one_minute = 1'b0;
	#1 reset = 1'b1;
	#1 reset = 1'b0;
	#10 $finish;
end

initial
begin
	$monitor($time, "c_time = [%d][%d]:[%d][%d][AM=%b], load_c = %d, reset = %d\n", current_time_ms_hr, current_time_ls_hr, current_time_ms_min, current_time_ls_min, current_time_AM, load_new_c, reset);
end

endmodule
