module fase1 ( 
	input logic CLK, RESET,
	input logic [31:0] INSTRUCCION_IF, READ_DATA_MEM,
	output logic [31:0] ALU_RESULT_MEM, PC_IF, READ_DATA_2_MEM,
	output logic MEMWRITE_MEM, MEM_READ); 
 
//
logic [31:0] SALIDA_MUX, W3, W4, ENTRADA_PC, SALIDA_SUM1, WRITE, SALIDA;  
logic SALIDA_AND;
logic [3:0]ALU_CONTROL;
//
//CABLES PARA LOS REGISTROS
//ETAPA IF

//ETAPA ID
logic [31:0] READ_DATA_1_ID, READ_DATA_2_ID, IMM_ID, INSTRUCCION_ID, PC_ID; 
logic BRANCH_ID, MEMTOREG_ID, MEMWRITE_ID, ALUSRC_ID, REGWRITE_ID, JAL_ID, JALR_ID, MEMREAD_ID; 
logic [1:0] AUIPCLUI_ID; 
logic [2:0]	ALUOP_ID; 

//ETAPA EX
logic BRANCH_EX, MEMTOREG_EX, MEMWRITE_EX, ALUSRC_EX, REGWRITE_EX, JAL_EX, JALR_EX, MEMREAD_EX, ZEROFLAG_EX;
logic [31:0] READ_DATA_1_EX, READ_DATA_2_EX, RESULT_EX, ALU_RESULT_EX, PC_EX, IMM_EX;
logic [1:0] AUIPCLUI_EX;
logic [2:0]	ALUOP_EX;
logic [3:0]	INSTR_3014_EX;
logic [4:0]	INSTR_117_EX;  

//ETAPA MEM
logic [31:0] RESULT_MEM; 
logic [4:0]	INSTR_117_MEM; 
logic BRANCH_MEM, MEMTOREG_MEM, REGWRITE_MEM, JAL_MEM, JALR_MEM, ZEROFLAG_MEM; 

//ETAPA WB
logic [31:0] READ_DATA_WB, ALU_RESULT_WB,ADDRESS_WB; 
logic [4:0]	INSTR_117_WB;
logic MEMTOREG_WB, REGWRITE_WB, JAL_WB; 

//REGISTROS
registro_if_id IF_ID(.clk(CLK), .pc_if(PC_IF), .pc_id(PC_ID), .instruccion_id(INSTRUCCION_ID), 
	.instruccion_if(INSTRUCCION_IF)
							);

registro_id_ex ID_EX (.clk(CLK), .Branch_id(BRANCH_ID), .MemtoReg_id(MEMTOREG_ID), .MemWrite_id(MEMWRITE_ID), .ALUSrc_id(ALUSRC_ID), 
	.RegWrite_id(REGWRITE_ID), .Jal_id(JAL_ID), .Jalr_id(JALR_ID),.AuipcLui_id(AUIPCLUI_ID), .ALUOp_id(ALUOP_ID), .pc_id(PC_ID), 
	.read_data_1_id(READ_DATA_1_ID), .read_data_2_id(READ_DATA_2_ID), .imm_id(IMM_ID), .instr_3014_id({INSTRUCCION_ID[30],INSTRUCCION_ID[14:12]}), 
	.instr_117_id(INSTRUCCION_ID[11:7]), .Branch_ex(BRANCH_EX), .MemtoReg_ex(MEMTOREG_EX),  .MemWrite_ex(MEMWRITE_EX),  
	.ALUSrc_ex(ALUSRC_EX), .RegWrite_ex(REGWRITE_EX), .Jal_ex(JAL_EX), .Jalr_ex(JALR_EX), .AuipcLui_ex(AUIPCLUI_EX), 
	.ALUOp_ex(ALUOP_EX), .pc_ex(PC_EX), .read_data_1_ex(READ_DATA_1_EX), .read_data_2_ex(READ_DATA_2_EX), .imm_ex(IMM_EX),
	.instr_3014_ex(INSTR_3014_EX), .instr_117_ex(INSTR_117_EX)
							); 

registro_ex_mem EX_MEM(.clk(CLK), .read_data_2_ex(READ_DATA_2_EX), .aluresult_ex(ALU_RESULT_EX), .branch_ex(BRANCH_EX), 
	.memwrite_ex(MEMWRITE_EX), .memtoreg_ex(MEMTOREG_EX), .zero_ex(ZEROFLAG_EX), .instruccion_117_ex(INSTR_117_EX), 
	.result_ex(RESULT_EX), .read_data_2_mem(READ_DATA_2_MEM), .aluresult_mem(ALU_RESULT_MEM), .branch_mem(BRANCH_MEM), 
	.memwrite_mem(MEMWRITE_MEM), .memtoreg_mem(MEMTOREG_MEM), .zero_mem(ZEROFLAG_MEM), .instruccion_117_mem(INSTR_117_MEM), 
	.result_mem(RESULT_MEM), .regwrite_ex(REGWRITE_EX), .regwrite_mem(REGWRITE_MEM), 
	.Jal_ex(JAL_EX), .Jalr_ex(JALR_EX), .Jal_mem(JAL_MEM), .Jalr_mem(JALR_MEM)
					);
							
registro_mem_wb MEM_WB(.clk(CLK), .read_data_mem(READ_DATA_MEM), .alu_result_mem(ALU_RESULT_MEM),
	.instruccion117_mem(INSTR_117_MEM), .memtoreg_mem(MEMTOREG_MEM), .regwrite_mem(REGWRITE_MEM), 
	.read_data_wb(READ_DATA_WB), .instruccion117_wb(INSTR_117_WB), .memtoreg_wb(MEMTOREG_WB), .regwrite_wb(REGWRITE_WB), 
	.alu_result_wb(ALU_RESULT_WB), .Jal_mem(JAL_MEM), .Jal_wb(JAL_WB)
							);


//ROM
//ROM rom (.address(PC_IF[11:2]), .data_out(INSTRUCCION_IF)); 
//BANCO REGISTROS
Banco_registros banco_registros (.clk(CLK), .reset(RESET), .read_register_1(INSTRUCCION_ID[19:15]), 
.read_register_2(INSTRUCCION_ID[24:20]), .write_register(INSTR_117_WB), .write_data(WRITE), 
.read_data_1(READ_DATA_1_ID), .read_data_2(READ_DATA_2_ID), .RegWrite(REGWRITE_WB));
//ALU
ALU alu (.A(W3), .B(W4), .ALU_control(ALU_CONTROL), .result(ALU_RESULT_EX), .zero_flag(ZEROFLAG_EX));
//RAM
//RAM ram (.clk(clk), .write_data(READ_DATA_2_MEM), .address(ALU_RESULT_MEM[11:2]), .read_data(READ_DATA_MEM), .MemWrite(MEMWRITE_MEM), .MemRead(MEM_READ));
//CONTROL
Control control(.entrada(INSTRUCCION_ID[6:0]), .Branch(BRANCH_ID), .MemRead(MEMREAD_ID), .MemtoReg(MEMTOREG_ID), .ALUOp(ALUOP_ID), 
.MemWrite(MEMWRITE_ID), .ALUSrc(ALUSRC_ID), .RegWrite(REGWRITE_ID), .AuipcLui(AUIPCLUI_ID), .Jal(JAL_ID), .Jalr(JALR_ID)); 
//ALU_CONTROL
ALU_CONTROL alu_control(.entrada(INSTR_3014_EX), .alu_op(ALUOP_EX), .alu_control(ALU_CONTROL)); 
//IMMGEN
ImmGen immgen(.clk(CLK), .inst(INSTRUCCION_ID), .imm(IMM_ID)); 
//MUX1 REGSITRO 
mux1 multiplexorREGISTROS(.A(READ_DATA_2_EX), .B(IMM_EX), .O(W4), .sel(ALUSRC_EX)); 
//MUX1 RAM 
mux1 multiplexorRAM(.A(ALU_RESULT_WB), .B(READ_DATA_WB), .O(SALIDA_MUX), .sel(MEMTOREG_WB));
//MUX1 SUMADOR 
mux1 multiplexorSUMADOR(.A(SALIDA), .B(RESULT_MEM), .O(ENTRADA_PC), .sel(SALIDA_AND)); 
//MUX1 JAL 
mux1 muxJAL(.A(SALIDA_MUX), .B(SALIDA_SUM1), .O(WRITE), .sel(JAL_WB)); 
//MUX1 JALR
mux1 muxJALR(.A(SALIDA_SUM1), .B(RESULT_MEM), .O(SALIDA), .sel(JALR_MEM));
//MUX2
mux2 multiplexor2(.A(PC_EX), .B(READ_DATA_1_EX), .O(W3), .sel(AUIPCLUI_EX)); 
//SUMADOR1
sumador1 SUMADOR1(.instruccion(PC_IF), .result(SALIDA_SUM1)); 
//SUMADOR2
sumador2 SUMADOR2(.instruccion(PC_EX), .result(RESULT_EX), .Imm(IMM_EX)); 
//PC
pc PC(.clk(CLK), .reset(RESET), .pc_anterior(ENTRADA_PC), .pc_siguiente(PC_IF)); 
//PUERTA_AND
PUERTA_AND puerta_and(.A(BRANCH_MEM), .B(ZEROFLAG_MEM), .O(SALIDA_AND));
 
endmodule 