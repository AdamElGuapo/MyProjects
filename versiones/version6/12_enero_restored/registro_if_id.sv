module registro_if_id(clk,pc_if,pc_id,instruccion_id,instruccion_if);

input clk;
input [31:0] pc_if,instruccion_if;
output logic [31:0] pc_id,instruccion_id;

always @(posedge clk)
   begin
	pc_id<=pc_if;
	instruccion_id<=instruccion_if;
	end
	
	
endmodule
