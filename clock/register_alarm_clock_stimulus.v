module register_alarm_clock_stimulus;

reg [3:0]	new_current_alarm_ls_min,
		new_current_alarm_ms_min,
		new_current_alarm_ls_hr,
		new_current_alarm_ms_hr;
reg		new_current_alarm_am;

reg load_new_a, reset_a;

wire [3:0]	current_alarm_ls_min,
		current_alarm_ms_min,
		current_alarm_ls_hr,
		current_alarm_ms_hr;
wire		current_alarm_am;

register_alarm_clock C1(new_current_alarm_ls_min, new_current_alarm_ms_min,
		new_current_alarm_ls_hr, new_current_alarm_ms_hr, new_current_alarm_am,
		load_new_a, reset_a,
		current_alarm_ls_min, current_alarm_ms_min,
		current_alarm_ls_hr, current_alarm_ms_hr, current_alarm_am);


initial
begin
	new_current_alarm_ls_min = 4'b0000;
	new_current_alarm_ms_min = 4'b0000;
	new_current_alarm_ls_hr = 4'b0000;
	new_current_alarm_ms_hr = 4'b0000;
	new_current_alarm_am = 1'b0;
	load_new_a = 1'b0;
	reset_a = 1'b0;
end


initial
begin
	#5 reset_a = 1'b1;
	#5 reset_a = 1'b0;
	#5 load_new_a = 1'b0;
	// [1][2][4][2]{AM=1]
	#5 new_current_alarm_ls_min = 4'b0010; new_current_alarm_ms_min = 4'b0100; new_current_alarm_ls_hr = 4'b0010; new_current_alarm_ms_hr = 4'b0001; new_current_alarm_am = 1'b1; load_new_a = 1'b1;
	#5 load_new_a = 1'b0;
	#5 reset_a = 1'b1;
	#5 reset_a = 1'b0;
	#10 $finish;
end

initial
begin
	$monitor($time, "display_a_time = [%d][%d]:[%d][%d][AM=%b], load_a = %d, reset_a = %d\n", current_alarm_ms_hr, current_alarm_ls_hr, current_alarm_ms_min, current_alarm_ls_min, current_alarm_am, load_new_a, reset_a);
end





endmodule