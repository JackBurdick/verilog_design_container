module moore_sm_1001(data_out, data_in, clock, reset);
output data_out;
reg data_out;
input data_in, reset, clock;
reg [2:0] present_state, next_state;
parameter	S0 = 3'b000,
        	S1 = 3'b001,
        	S2 = 3'b010,
        	S3 = 3'b011,
        	S4 = 3'b100;

// advance and reset logic
always@(posedge clock or reset)
	begin
		if (reset)
			present_state = S0;
		else
			present_state = next_state;
	end

// input data assignment logic
always@(posedge clock or data_in)
	begin
		case (present_state)
			S0:
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
					next_state = S4;
			S4:
				if(data_in == 1'b0)
					next_state = S0;
				else
					next_state = S1;
			endcase
		end

// output data assignment logic
// output is only a function of state
always@(present_state)
	begin
		case(present_state)
			S0: data_out = 1'b0;
			S1: data_out = 1'b0;
			S2: data_out = 1'b0;
			S3: data_out = 1'b0;
			S4: data_out = 1'b1;
		endcase
	end

endmodule
