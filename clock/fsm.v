module fsm(clk, reset, key, alarm_button, time_button, one_second, load_new_a, show_a, show_new_time, load_new_c, shift);

input clk, reset, alarm_button, time_button, one_second;
input [3:0] key;

output load_new_a, show_a, show_new_time, load_new_c, shift;

parameter	show_time		= 3'b000,
		key_entry		= 3'b001,
		key_stored		= 3'b010,
		show_alarm		= 3'b011,
		set_alarm_time		= 3'b100,
		set_current_time	= 3'b101,
		key_waited		= 3'b110;
		flashing		= 3'b111;
parameter	nokey			= 10;

wire load_new_a, show_a, show_new_time, load_new_c, shift;

reg [7:0] state;// advance and reset logic


// include functions here


always @(posedge clock or reset)
	begin
		if (reset == 1'b1)
			present_state = show_time;
		else
			present_state = next_state;
	end

always @(posedge clock or data_in)
	begin
		case(present_state)
			show_time:
				if(data_in == 1'b0)
					next_state = S0;
				else
					next_state = S1;
			S1:
				if(data_in == 1'b0)
					next_state = S2;
				else
					next_state = S1;
			S2:
				if(data_in == 1'b0)
					next_state = S3;
				else
					next_state = S1;
			S3:
				if(data_in == 1'b0)
					next_state = S0;
				else
					next_state = S0;
		endcase
	end

// output data assignment logic
always@(posedge clock or data_in)
	begin
		case (present_state)
			S0:
				data_out = 1'b0;
			S1:
				data_out = 1'b0;
			S2:
				data_out = 1'b0;
			S3:
				if (data_in == 1'b0)
					data_out = 1'b0;
				else
					data_out = 1'b1;
		endcase
	end