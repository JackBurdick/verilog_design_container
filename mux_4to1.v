module mux_4to1 (Out, In, Sel);
output Out;
input [3:0]In;
input [1:0]Sel;

assign Out = Sel[1] ? (Sel[0] ? In[3] : In[2]) : (Sel[0] ? In[1] : In[0]);

endmodule