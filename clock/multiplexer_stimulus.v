module multiplexer_stimulus;

reg [3:0] alarm_time, current_time;
reg show_a;

wire [3:0] display_time;

multiplexer C1(alarm_time, current_time, show_a, display_time);

initial
begin
	show_a = 1'b0;
	alarm_time = 4'b0000;
	current_time = 4'b1111;
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
	$monitor($time, "display time = %b, a_time = %b, cur_time = %b, show_a = %b\n", display_time, alarm_time, current_time, show_a);
end

endmodule