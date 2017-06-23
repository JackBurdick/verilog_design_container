module multiplexer(alarm_time, current_time, show_a, display_time);

input [3:0] alarm_time, current_time;
input show_a;

output [3:0] display_time;

wire [3:0] display_time;
wire [3:0] show_a_vector;

assign show_a_vector = {4{show_a}};
assign display_time = (alarm_time & show_a_vector)|(current_time & ~show_a_vector);

endmodule