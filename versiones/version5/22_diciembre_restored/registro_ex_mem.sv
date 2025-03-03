module registro_ex_mem(

	input clk,
	input logic [31:0] read_data_2_ex,
	input logic [31:0] aluresult_ex,
	input logic branch_ex, memwrite_ex, memtoreg_ex, zero_ex, regwrite_ex, Jal_ex, Jalr_ex,
	input logic [4:0] instruccion_117_ex,
	input logic [31:0] result_ex,

	output logic [31:0] read_data_2_mem,
	output logic [31:0] aluresult_mem,
	output logic branch_mem, memwrite_mem, memtoreg_mem, zero_mem, regwrite_mem, Jal_mem, Jalr_mem,
	output logic [4:0] instruccion_117_mem,
	output logic [31:0] result_mem
	); 

always@(posedge clk)
	begin
		read_data_2_mem <= read_data_2_ex;
		aluresult_mem <= aluresult_ex;
		branch_mem <= branch_ex;
		memwrite_mem <= memwrite_ex;
		zero_mem <= zero_ex;
		instruccion_117_mem <= instruccion_117_ex;
		memtoreg_mem <= memtoreg_ex;
		result_mem <= result_ex; 
		regwrite_mem <= regwrite_ex; 
		Jal_mem <= Jal_ex; 
		Jalr_mem <= Jalr_ex; 
	end


endmodule 