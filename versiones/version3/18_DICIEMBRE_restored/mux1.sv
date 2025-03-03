module mux1 (A, B,sel,O);
input  sel; 
input [31:0] A, B;
output logic [31:0] O;
always @(sel or A or B)
      case(sel)
      1'b0: O = A;
      1'b1: O = B;
      default: O = 0;
      endcase
 
endmodule
