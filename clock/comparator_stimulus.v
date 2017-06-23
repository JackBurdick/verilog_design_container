module comparator_stimulus;

reg [3:0] alarm_time, current_time;
reg show_a;

wire [3:0] display_time;
wire sound_alarm;

comp_dismux C1(alarm_time, current_time, show_a, sound_alarm, display_time);

initial
begin
	show_a = 1'b0;
	alarm_time = 4'b0000;
	current_time = 4'b1111;
end


initial
begin
	#5 alarm_time = 4'b0001; current_time = 4'b0010;
	#5 alarm_time = 4'b0001; current_time = 4'b0001;
	#5 alarm_time = 4'b0001; current_time = 4'b0010;
	#5 $finish;
end

initial
begin
	$monitor($time, "alarm_time = %d, current_time = %d, alarm = %b\n", alarm_time, current_time, sound_alarm);
end

endmodule