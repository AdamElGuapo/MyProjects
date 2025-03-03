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

    
   always_ff @(posedge clk or negedge reset)	
		if (!reset)
			for (int i=0; i<32; i=i+1)
				begin
					x[i] <= 32'd0;
				end	
		else if (RegWrite) 
				begin
					if (write_register != 0) 
						x[write_register] <= write_data;		
				end
				
assign read_data_1 = x[read_register_1];
assign read_data_2 = x[read_register_2];


assert property (@(posedge clk) disable iff (reset==1'b0 && x[1]==32'hffffffff ) x[1]==32'd20 |-> ##1 read_data_1==32'd0 ##10 read_data_1==32'd1 ##11 read_data_1==32'd2) else    $info("fibonacci falla"); 

 

endmodule
