module ImmGen(clk,inst,imm);
	input clk;
	input logic[31:0] inst;
	output logic[31:0] imm;

always @(inst)
   case(inst[6:0])
	  7'b0010011:	imm = {{21{inst[31]}},inst[30:20]};//IFORMAT
	  7'b0100011:	imm = {{21{inst[31]}},inst[30:25],inst[11:7]};//SFORMAT
	  7'b1100011:	imm = {{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0};//BFORMAT
	  7'b0110111:	imm = {inst[31:12],12'b0};//UFORMAT LUI
	  7'b0010111:	imm = {inst[31:12],12'b0};//UFORMAT AUIPC
	  7'b1101111:	imm = {{21{inst[31]}},inst[30:20]};//JFORMAT
	  7'b1100111:	imm = {{21{inst[31]}},inst[30:20]};//JALR
	  7'b0000011:	imm = {{21{inst[31]}},inst[30:20]};//LW
     7'b0100011:	imm = {{21{inst[31]}},inst[30:25],inst[11:7]};//SW
	  endcase
								
endmodule 