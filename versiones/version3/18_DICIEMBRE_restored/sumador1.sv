module sumador1 (instruccion,result);

input [31:0]instruccion;
output [31:0]result;
 
 
assign result = instruccion + 32'd4;

endmodule
