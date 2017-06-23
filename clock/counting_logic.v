module counting_logic(new_current_time_ls_min, new_current_time_ms_min,
		new_current_time_ls_hr, new_current_time_ms_hr, new_current_time_AM,
		load_new_c, reset, clk, one_minute,
		current_time_ls_min, current_time_ms_min,
		current_time_ls_hr, current_time_ms_hr, current_time_AM);

input [3:0]	new_current_time_ls_min,
		new_current_time_ms_min,
		new_current_time_ls_hr,
		new_current_time_ms_hr;
input		new_current_time_AM;

input load_new_c, reset, clk, one_minute;

output [3:0]	current_time_ls_min,
		current_time_ms_min,
		current_time_ls_hr,
		current_time_ms_hr;
output		current_time_AM;

reg [3:0] ls_min, ms_min, ls_hr, ms_hr;
reg AM;

wire [3:0]	current_time_ls_min,
		current_time_ms_min,
		current_time_ls_hr,
		current_time_ms_hr;
wire		current_time_AM;


always@ (posedge clk or posedge reset)
begin
	if (reset)
	begin
		ls_min	<= 4'b0000;
		ms_min	<= 4'b0000;
		ls_hr	<= 4'b0000;
		ms_hr	<= 4'b0000;
		AM	<= 1'b0;
	end
	else if (load_new_c)
	begin
		ls_min	<= new_current_time_ls_min;
		ms_min	<= new_current_time_ms_min;
		ls_hr	<= new_current_time_ls_hr;
		ms_hr	<= new_current_time_ms_hr;
		AM	<= new_current_time_AM;
	end
	else
	begin
		if(one_minute)
		begin
			if (ls_min == 9)
			begin
				ls_min <= 0;
				if (ms_min == 5)
				begin
					ms_min <= 0;
					if (ls_hr == 2)
					begin	
						if(ms_hr == 1)
						begin
							ms_hr <= 0;
							ls_hr <= 1;
							AM <= ~AM;
						end
					end
					else if (ls_hr == 9)		
					begin
						ms_hr <= ms_hr + 1;
						ls_hr <= 0;
					end
					else
					begin
						ls_hr <= ls_hr+1;
					end
				end				
				else
				begin
					ms_min <= ms_min + 1;
				end
			end
			else
			begin
				ls_min <= ls_min + 1;
			end
		end
	end
end

assign current_time_ls_min = ls_min;
assign current_time_ms_min = ms_min;
assign current_time_ls_hr  = ls_hr;
assign current_time_ms_hr  = ms_hr;
assign current_time_AM  = AM;

endmodule