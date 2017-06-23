module comp_dismux(alarm_time, current_time, show_a, sound_alarm, display_time);

input [3:0] alarm_time, current_time;
input show_a;

output [3:0] display_time;
output sound_alarm;

wire [3:0] display_time;
wire [3:0] show_a_vector;
reg sound_alarm;

assign show_a_vector = {4{show_a}};
assign display_time = (alarm_time & show_a_vector | current_time & ~show_a_vector);

always@(alarm_time or current_time)
begin
	if (alarm_time == current_time)
		sound_alarm <= 1;
	else
		sound_alarm <= 0;
end
endmodule