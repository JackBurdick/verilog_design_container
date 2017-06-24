module fsm(clk, reset, key, alarm_button, time_button, one_second, load_new_a, show_a, show_new_time, load_new_c, shift);

/*
NOTE: this module, is, unfortunately, incomplete. the individual modules are "working" (shown in respective testbenches) but
the the modules are not glued together here like they should be

*/


input clk, reset, alarm_button, time_button, one_second;
input [3:0] key;

output load_new_a, show_a, show_new_time, load_new_c, shift;

parameter	show_time		= 3'b000,
		key_entry		= 3'b001,
		key_stored		= 3'b010,
		show_alarm		= 3'b011,
		set_alarm_time		= 3'b100,
		set_current_time	= 3'b101,
		key_waited		= 3'b110,
		flashing		= 3'b111;



wire load_new_a, show_a, show_new_time, load_new_c, shift;

reg [2:0] present_state; 	// advance and reset logic
reg [2:0] next_state; 	// advance and reset logic
reg [3:0] num_keys;	// used to keep track of the number of keys received
reg [3:0] wait_time;	// used to keep track of how long we've waited for keys


// [10] = alarm_button
// [11] = time_button

// may not be needed --> broken into comparator, mux, and seven_seg
display_time C1(alarm_time, current_time, show_a, sound_alarm, display);

// show the time (clock | alarm)
multiplexer(alarm_time, current_time, show_a, display_time);

// determine if alarm needs to be high
comp_dismux(alarm_time, current_time, show_a, sound_alarm, display_time);

// count up
counting_logic C2(new_current_time_ls_min, new_current_time_ms_min,
		  new_current_time_ls_hr, new_current_time_ms_hr, new_current_time_AM,
		  load_new_c, reset, clk, one_minute,
		  current_time_ls_min, current_time_ms_min,
		  current_time_ls_hr, current_time_ms_hr, current_time_AM);

// map col/row=>key
keypad C3(key, columns, rows);
keyscan C5(clk, reset, shift, rows, columns, key, 
	   key_buffer_0, key_buffer_1, key_buffer_2, key_buffer_3, 
	   time_button, alarm_button);

// set new alarm time
register_alarm_clock C4(new_current_alarm_ls_min, new_current_alarm_ms_min,
			new_current_alarm_ls_hr, new_current_alarm_ms_hr, new_current_alarm_AM,
			load_new_a, reset_a,
			current_alarm_ls_min, current_alarm_ms_min,
			current_alarm_ls_hr, current_alarm_ms_hr, current_alarm_AM);


// drive minutes/seconds
timegen C6(clk, reset, stopwatch, one_second, one_minute);


// seven segments
// [MH][LH][MM][LM]
seven_segment LM(LM_digit, LM_seg);
seven_segment MM(MM_digit, MM_seg);
seven_segment LH(LH_digit, LH_seg);
seven_segment MH(MH_digit, MH_seg);


always @(posedge clk or reset)
	begin
		if (reset == 1'b1)
			present_state = show_time;
		else
			present_state = next_state;
	end

always @(posedge clk or data_in)
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
				else
					next_state = show_time;
			key_entry:
				// display the keys from right to left
				if(num_keys == 3'b100)
				// if all four keys have been collected, then set indicated time
					if (key == 4'b1010)
						// key selected is alarm key
						next_state = set_alarm_time;
					else if (key == 4'b1011)
						// time key selected
						next_state = set_current_time;
					else
						// if a 5th number is entered, go back to displaying time
						next_state = show_time;
						
				// if the key is the alarm or time key, display that time
				else if(key == 4'b1010)
					// show alarm time
					next_state = show_time;
				else if(key == 4'b1011)
					// show clock time
					next_state = show_alarm;
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
				else if(key)
					next_state = key_entry;
			show_alarm:
				// while the alarm key is pressed, we will loop 
				// key_entry->show_alarm, but user will only see the alarm
				if(key)
					next_state = key_entry;
	
			set_alarm_time:
				// after new alarm time is set, the current clock time is displayed
				next_state = show_time;
	
			set_current_time:
				// after new time is set, the new time is displayed
				next_state = show_time;

			key_waited:
				// if a key is still being pressed, then store key in buffer (2 cycles)
				if(key)
					// a key has been pressed, will go store it
					next_state = key_stored;
					
				else
					// key not pressed long enough, go back to key_entry
					next_state = key_entry;
		
			flashing:
				// if a key is pressed, we jump into the assignment logic
				if(key)
					next_state = key_entry;
		endcase
	end

// output data assignment logic
always@(posedge clk or data_in)
	begin
		case (present_state)
			show_time:
				// set display time to the segment displays assigned from counting/assignment
				LM_seg;
				MM_seg;
				LH_seg;
				MH_seg;
			key_entry:
				// make sure values are stored in the buffer

			key_stored:
				if(num_keys == 3'b100)
					if (key == 4'b1010)
						// key selected is alarm key
						next_state = set_alarm_time;
					else if (key == 4'b1011)
						// time key selected
						next_state = set_current_time;
			show_alarm:
				// set display time to the segment displays assigned from counting/assignment
				LM_seg;
				MM_seg;
				LH_seg;
				MH_seg;
				
			set_alarm_time:
				// call seven_seg for each digit
				LM_digit = new_current_alarm_ls_min;
				MM_digit = new_current_alarm_ms_min;
				LH_digit = new_current_alarm_ls_hr;
				MH_digit = new_current_alarm_ms_hr;
				
			set_current_time:
				// call seven_seg for each digit
				LM_digit = new_current_time_ls_min;
				MM_digit = new_current_time_ms_min;
				LH_digit = new_current_time_ls_hr;
				MH_digit = new_current_time_ms_hr;
			key_waited:
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
				else
					//reset
					num_keys = 3'b000;
				
			flashing:
				// TODO: some logic to make the time/flash
				// a 'none_seg' was created to toggle between this and the current time
		endcase
	end

endmodule