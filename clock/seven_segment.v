module seven_segment(digit, seven_seg_vals)

input [3:0]digit;
output [3:0]seven_seg_vals;

// none seg is used for flashing
parameter zero_seg      = 7'b0111111,
	  one_seg	= 7'b0000011,
    	  two_seg	= 7'b1101101,
	  three_seg	= 7'b1100111,
	  four_seg	= 7'b1010011,
	  five_seg	= 7'b1110110,
	  six_seg	= 7'b1111110,
	  seven_seg	= 7'b0100011,
	  eight_seg	= 7'b1111111,
	  nine_seg	= 7'b1110111,
	  // error segment
	  err_seg	= 7'b1000000,
	  // no segment, for flashing
	  none_seg	= 7'b0000000;

always @ (digit)
begin
	case (digit)
		// digit
		4'b0000: seven_seg_vals <= zero_seg;
		4'b0001: seven_seg_vals <= one_seg;
		4'b0010: seven_seg_vals <= two_seg;
		4'b0011: seven_seg_vals <= three_seg;
		4'b0100: seven_seg_vals <= four_seg;
		4'b0101: seven_seg_vals <= five_seg;
		4'b0110: seven_seg_vals <= six_seg;
		4'b0111: seven_seg_vals <= seven_seg;
		4'b1000: seven_seg_vals <= eight_seg;
		4'b1001: seven_seg_vals <= nine_seg;
		// flashing
		4'b1111: seven_seg_vals <= nine_seg;
		// error
		default: seven_seg_vals <= err_seg;
	endcase
end
endmodule