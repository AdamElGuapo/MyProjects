module Banco_registros(
	input logic clk,
	input logic reset, 
   input logic [4:0] read_register_1, 
   input logic [4:0] read_register_2, 
   input logic [4:0] write_register,    
   input logic [31:0] write_data,
	input logic RegWrite, 
   output logic [31:0] read_data_1, 
   output logic [31:0] read_data_2 
);

   logic [31:0]x[31:0]; 

    
   always_ff @(posedge clk)	
			if (RegWrite) 
				begin
					if (write_register != 0) 
						x[write_register] <= write_data;		
				end
				
assign read_data_1 = x[read_register_1];
assign read_data_2 = x[read_register_2];
endmodule
