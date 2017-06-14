module mux_4to1_df(Out, In, Sel);
output Out;
input [3:0]In;
input [1:0]Sel;

/*
 00-In[0]
 01-In[1]
 10-In[2]
 11-In[3]
*/

assign Out = Sel[1]&(~Sel[0]&In[2])|(Sel[0]&In[3])|~Sel[1]&(~Sel[0]&In[0])|(Sel[0]&In[1]);

endmodule