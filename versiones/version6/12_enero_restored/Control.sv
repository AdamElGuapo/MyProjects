module Control(
		input logic [6:0]entrada,
		output logic Branch,
		output logic MemRead,
		output logic MemtoReg,
		output logic [2:0] ALUOp,
		output logic MemWrite,
		output logic ALUSrc,
		output logic RegWrite,
		output logic [1:0] AuipcLui,
		output logic Jal,
		output logic Jalr); 
		
		reg [12:0] valores;  
		
always @(entrada)
	case(entrada) 
			7'b0110011: 	valores = 13'b0_0_0_000_0_0_1_10_0_0;//R_FORMAT
			7'b0010011: 	valores = 13'b0_0_0_001_0_1_1_10_0_0;//I_FORMAT
			7'b1100011: 	valores = 13'b1_0_0_010_0_0_0_10_0_0;//B_FORMAT
			7'b0100011: 	valores = 13'b0_1_0_011_1_1_0_10_0_0;//SW
			7'b0010111: 	valores = 13'b0_0_0_100_0_1_1_00_0_0;//AUIPC
			7'b0110111: 	valores = 13'b0_0_0_100_0_1_1_01_0_0;//LUI
			7'b1101111: 	valores = 13'b0_0_0_101_0_1_1_10_1_0;//JAL
			7'b1100111: 	valores = 13'b0_0_0_101_0_1_1_10_1_1;//JALR
			7'b0000011: 	valores = 13'b0_1_1_110_0_1_1_10_0_0;//LW
			default: valores = 13'b0_0_0_000_0_0_1_10_0_0;//R_FORMAT
	endcase 
		
assign 	{Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, AuipcLui, Jal, Jalr} = valores; 


		
endmodule 
		
		
		
	