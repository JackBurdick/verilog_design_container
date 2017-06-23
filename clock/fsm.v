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



wire load_new_a, show_a, show_new_time, load_new_c, shift;

reg [2:0] state; 	// advance and reset logic
reg [3:0] num_keys;	// used to keep track of the number of keys received
reg [3:0] wait_time;	// used to keep track of how long we've waited for keys


//10 = alarm
//11 = time

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
				if (key)
				// a key has been pressed
					next_state = key_entry;
				else if (show_a)
				// users wants to see alarm
					next_state = show_alarm;
				// else stay here
			key_entry:
				// display the keys from right to left
				if(num_keys = 3'b100)
					// all four keys collected
					if (key == 
				else
					// still collecting keys, continue looping
					next_state = key_waited;

			key_stored:
				if(num_keys == 3'b100)
				// all 4 keys have been entered
				// NOTE: the user must enter all four numbers, ie 0300
					if(load_new_a)
						// will set alarm with current entry
						next_state = set_alarm_time;
					else if (load_new_c)
						// will set current time with current entry
						next_state = set_current_time;
					else
						// display current time
						next_state = show_time;
			show_alarm:
	
			set_alarm_time:
	
			set_current_time:

			key_waited:
				// if a key is still being pressed, then store key in buffer (2 cycles)
				if (key)
					// a key has been pressed, will go store it
					if(num_keys == 3'b000)
						// one key collected
						num_keys = 3'b001;
					else if(num_keys == 3'b001)
						// two keys collected
						num_keys = 3'b010;
					else if(num_keys == 3'b010)
						// three keys collected
						num_keys = 3'b011;
					else if(num_keys == 3'b011)
						// four keys collected
						num_keys = 3'b100;
					next_state = key_stored;
				else
					// key not pressed long enough, go back to key_entry
					next_state = key_entry;
		
			flashing:

		endcase
	end

// output data assignment logic
always@(posedge clock or data_in)
	begin
		case (present_state)
			show_time:
				
			key_entry:
				
			key_stored:
				
			show_alarm:
				
			set_alarm_time:
				
			set_current_time:
				
			key_waited:
				
			flashing:
				
		endcase
	end