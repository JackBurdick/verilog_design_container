module mux_16to1(Out, In, Sel);
output Out;
input [15:0]In;
input [3:0]Sel;

assign Out = Sel[3]?(Sel[2]?(Sel[1]?(Sel[0]?In[15]:In[14]):(Sel[0]?In[13]:In[12])):(Sel[1]?(Sel[0]?In[11]:In[10]):(Sel[0]?In[9]:In[8]))):(Sel[2]?(Sel[1]?(Sel[0]?In[7]:In[6]):(Sel[0]?In[5]:In[4])):(Sel[1]?(Sel[0]?In[3]:In[2]):(Sel[0]?In[1]:In[0])));

endmodule