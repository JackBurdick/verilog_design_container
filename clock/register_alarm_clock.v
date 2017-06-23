module register_alarm_clock(new_current_alarm_ls_min, new_current_alarm_ms_min,
		new_current_alarm_ls_hr, new_current_alarm_ms_hr, new_current_alarm_AM,
		load_new_a, reset_a,
		current_alarm_ls_min, current_alarm_ms_min,
		current_alarm_ls_hr, current_alarm_ms_hr, current_alarm_AM);

input [3:0]	new_current_alarm_ls_min,
		new_current_alarm_ms_min,
		new_current_alarm_ls_hr,
		new_current_alarm_ms_hr;


input load_new_a, reset_a, new_current_alarm_AM;

output [3:0]	current_alarm_ls_min,
		current_alarm_ms_min,
		current_alarm_ls_hr,
		current_alarm_ms_hr;
output 		current_alarm_AM;

reg [3:0] ls_a_min, ms_a_min, ls_a_hr, ms_a_hr;
reg a_AM;

wire [3:0]	current_alarm_ls_min,
		current_alarm_ms_min,
		current_alarm_ls_hr,
		current_alarm_ms_hr;
wire		current_alarm_AM;


always@ (posedge reset_a or posedge load_new_a)
begin
	if (reset_a)
	begin
		ls_a_min	<= 4'b0000;
		ms_a_min	<= 4'b0000;
		ls_a_hr		<= 4'b0000;
		ms_a_hr		<= 4'b0000;
		a_AM		<= 1'b0;
		
	end
	else if (load_new_a)
	begin
		ls_a_min	<= new_current_alarm_ls_min;
		ms_a_min	<= new_current_alarm_ms_min;
		ls_a_hr		<= new_current_alarm_ls_hr;
		ms_a_hr		<= new_current_alarm_ms_hr;
		a_AM		<= new_current_alarm_AM;
	end

end

assign current_alarm_ls_min = ls_a_min;
assign current_alarm_ms_min = ms_a_min;
assign current_alarm_ls_hr  = ls_a_hr;
assign current_alarm_ms_hr  = ms_a_hr;
assign current_alarm_AM  = a_AM;


endmodule