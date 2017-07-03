module mealy_sm_1001(data_out, data_in, clock, reset);
output data_out;
reg data_out;
input data_in, reset, clock;
reg [1:0] present_state, next_state;

parameter	S0 = 2'b00,
        	S1 = 2'b01,
        	S2 = 2'b10,
        	S3 = 2'b11;

// advance and reset logic
always @(posedge clock or reset)
	begin
		if (reset == 1'b1)
			present_state = S0;
		else
			present_state = next_state;
	end

// input data assignment logic
always @(posedge clock or data_in)
	begin
		case(present_state)
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
endmodule