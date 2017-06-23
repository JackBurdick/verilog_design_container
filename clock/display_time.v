module display_time(alarm_time, current_time, show_a, sound_alarm, display);

input [3:0] alarm_time, current_time;
input show_a;

output sound_alarm;
output [7:0] display;

parameter zero_seg = 7'b0111111,
	one_seg		= 7'b0000011,
	two_seg		= 7'b1101101,
	three_seg	= 7'b1100111,
	four_seg	= 7'b1010011,
	five_seg	= 7'b1110110,
	six_seg		= 7'b1111110,
	seven_seg	= 7'b0100011,
	eight_seg	= 7'b1111111,
	nine_seg	= 7'b1110111,
	err_seg		= 7'b1000000;

reg sound_alarm;
reg [3:0] display_time;
reg [6:0] display;

always@(alarm_time or current_time or show_a)
begin
	if (show_a)
		display_time <= alarm_time;
	else
		display_time <= current_time;

	if (alarm_time == current_time)
		sound_alarm <= 1;
	else
		sound_alarm <= 0;
end

always @ (display_time)
begin
	case (display_time)
		4'b0000: display <= zero_seg;
		4'b0001: display <= one_seg;
		4'b0010: display <= two_seg;
		4'b0011: display <= three_seg;
		4'b0100: display <= four_seg;
		4'b0101: display <= five_seg;
		4'b0110: display <= six_seg;
		4'b0111: display <= seven_seg;
		4'b1000: display <= eight_seg;
		4'b1001: display <= nine_seg;
		default: display <= err_seg;
	endcase
end
endmodule




