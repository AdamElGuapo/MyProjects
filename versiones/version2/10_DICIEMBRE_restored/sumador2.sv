module sumador2(instruccion,Imm,result);

input [31:0]instruccion,Imm;
output [31:0]result;
 
 
assign result = instruccion + Imm;

endmodule
