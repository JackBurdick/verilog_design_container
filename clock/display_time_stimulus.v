module display_time_stimulus;

reg [3:0] alarm_time, current_time;
reg show_a;

wire sound_alarm;
wire [7:0] display;

display_time C1(alarm_time, current_time, show_a, sound_alarm, display);

initial
begin
	show_a = 1'b0;
	alarm_time = 4'b0001;
	current_time = 4'b0111;
end


initial
begin
	#5 alarm_time = 4'b0001; current_time = 4'b0010;
	#5 show_a = 1'b1;
	#5 show_a = 1'b0;
	#5 alarm_time = 4'b0001; current_time = 4'b0001;
	#5 alarm_time = 4'b0001; current_time = 4'b0010;
	#5 $finish;
end

initial
begin
	$monitor($time, "display time = %b, a_time = %b, cur_time = %b, alarm = %b, show_a = %b\n", display, alarm_time, current_time, sound_alarm, show_a);
end

endmodule