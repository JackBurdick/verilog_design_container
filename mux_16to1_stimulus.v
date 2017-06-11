module stimulus_mux_16to1;
reg In[15:0];
reg Sel[3:0];
wire Out;

mux_16to1 C1(Out, In, Sel);

// inital block
initial
begin
	Sel[3:0] = 4'b0000;
	In[0] = 1'h0;
	In[0] = 1'h1;
	In[0] = 1'h2;
	In[0] = 1'h3;
	In[0] = 1'h4;
	In[0] = 1'h5;
	In[0] = 1'h6;
	In[0] = 1'h7;
	In[0] = 1'h8;
	In[0] = 1'h9;
	In[0] = 1'h10;
	In[0] = 1'h11;
	In[0] = 1'h12;
	In[0] = 1'h13;
	In[0] = 1'h14;
	In[0] = 1'h15;
end

// assignment
initial
begin
	#5 Sel[3:0] = 4'b0001;
	#5 Sel[3:0] = 4'b0010;
	#5 Sel = 4'b0011;
	#5 Sel = 4'b0100;
	#5 Sel = 4'b0101;
	#5 Sel = 4'b0110;
	#5 Sel = 4'b0111;
	#5 Sel = 4'b1000;
	#5 Sel = 4'b1001;
	#5 Sel = 4'b1010;
	#5 Sel = 4'b1011;
	#5 Sel = 4'b1100;
	#5 Sel = 4'b1101;
	#5 Sel = 4'b1110;
	#5 Sel = 4'b1111;
	#10 $finish;
end

// monitor
initial
begin
	$monitor($time, "Out = %h, Sel = %b", Out, Sel);
end








endmodule