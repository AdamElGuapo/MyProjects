module PUERTA_AND (
		input logic A, 
		input logic B, 
		output logic O);
		
always @	(A or B)
	O = A & B; 
	
endmodule 