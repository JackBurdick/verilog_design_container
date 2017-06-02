module mux_2to1 (Out, In, Sel);
output Out;
input [1:0] In;
input Sel;

assign Out = Sel ? In[1] : In[0];

endmodule