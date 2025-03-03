module mux2 (A, B, sel, O);
input  [31:0] A, B;
input [1:0] sel;
output logic [31:0] O;

always @(sel or A or B)
      case(sel)
				2'b00: O = A; 
				2'b01: O = 32'd0; 
				2'b10: O = B; 
				default: O = 32'd0;
      endcase
 
 
endmodule
