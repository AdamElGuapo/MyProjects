module registro_mem_wb (clk,Jal_mem,Jal_wb,alu_result_mem,alu_result_wb,read_data_mem,read_data_wb,instruccion117_mem,instruccion117_wb,memtoreg_mem,memtoreg_wb,regwrite_mem,regwrite_wb);

input clk ;
input [31:0] read_data_mem, alu_result_mem;
input [4:0] instruccion117_mem;
input memtoreg_mem, regwrite_mem, Jal_mem;

output logic [31:0] read_data_wb, alu_result_wb;
output logic [4:0] instruccion117_wb;
output logic memtoreg_wb, regwrite_wb, Jal_wb; 


always @(posedge clk)
	begin
		read_data_wb <= read_data_mem;
		instruccion117_wb <= instruccion117_mem;
		memtoreg_wb <= memtoreg_mem;
		regwrite_wb <= regwrite_mem;
		alu_result_wb <= alu_result_mem;
		Jal_wb <= Jal_mem; 
	end

endmodule 
 