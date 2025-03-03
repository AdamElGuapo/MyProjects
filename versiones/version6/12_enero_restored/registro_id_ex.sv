module registro_id_ex (
	input clk, Branch_id, MemtoReg_id, MemWrite_id, ALUSrc_id, RegWrite_id, Jal_id, Jalr_id,
	input [1:0] AuipcLui_id,
	input [2:0] ALUOp_id,
	input [31:0] pc_id, read_data_1_id, read_data_2_id, imm_id, 
	input [3:0] instr_3014_id, 
	input [4:0]instr_117_id, 
	output logic Branch_ex, MemtoReg_ex, MemWrite_ex, ALUSrc_ex, RegWrite_ex, Jal_ex, Jalr_ex,
	output logic [1:0] AuipcLui_ex,
	output logic [2:0] ALUOp_ex,
	output logic [31:0] pc_ex, read_data_1_ex, read_data_2_ex, imm_ex, 
	output logic [3:0] instr_3014_ex, 
	output logic [4:0]instr_117_ex
	); 
	
	
	always @(posedge clk)
		begin
			Branch_ex <= Branch_id; //2
			MemtoReg_ex <= MemtoReg_id; //3
			MemWrite_ex <= MemWrite_id; //2
			ALUSrc_ex <= ALUSrc_id; //1
			RegWrite_ex <= RegWrite_id; //3
			Jal_ex <= Jal_id; 
			Jalr_ex <= Jalr_id; 
			AuipcLui_ex <= AuipcLui_id; 
			ALUOp_ex <= ALUOp_id; //1
			pc_ex <= pc_id; 
			read_data_1_ex <= read_data_1_id; 
			read_data_2_ex <= read_data_2_id; 
			imm_ex <= imm_id; 
			instr_3014_ex <= instr_3014_id; 
			instr_117_ex <= instr_117_id; 
		end
endmodule
	
	

	