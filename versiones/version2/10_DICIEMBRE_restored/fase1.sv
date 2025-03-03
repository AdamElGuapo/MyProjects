module fase1 (
input logic clk, reset); 

logic [31:0] INSTRUCCION, IMMEDIATO, SALIDA_PC, SALIDA_MUX, W1, W2, W3, W4, SALIDA_ALU, SALIDA_RAM, ENTRADA_PC, SALIDA, SALIDA_SUM2, SALIDA_SUM1, WRITE;  
logic [3:0] ALU_CONTROL; 
logic [2:0] ALUOP; 
logic [1:0] AUIPCLUI;
//CABLES PARA EL CONTROL
logic ALU_SRC, MEMTO_REG, BRANCH, ZERO_FLAG, REG_WRITE, MEM_WRITE, JAL, JALR, MEM_READ, SALIDA_AND; 

//ROM
ROM rom (.address(SALIDA_PC), .data_out(INSTRUCCION)); 
//BANCO REGISTROS
Banco_registros banco_registros (.clk(clk), .reset(reset), .read_register_1(INSTRUCCION[19:15]), .read_register_2(INSTRUCCION[24:20]), 
.write_register(INSTRUCCION[11:7]), .write_data(WRITE), .read_data_1(W1), .read_data_2(W2), .RegWrite(REG_WRITE));
//ALU
ALU alu (.A(W3), .B(W4), .ALU_control(ALU_CONTROL), .result(SALIDA_ALU), .zero_flag(ZERO_FLAG));
//RAM
RAM ram (.clk(clk), .reset(reset), .write_data(W2), .address(SALIDA_ALU), .read_data(SALIDA_RAM), .MemWrite(MEM_WRITE), .MemRead(MEM_READ));
//CONTROL
Control control(.entrada(INSTRUCCION[6:0]), .Branch(BRANCH), .MemRead(MEM_READ), .MemtoReg(MEMTO_REG), .ALUOp(ALUOP), 
.MemWrite(MEM_WRITE), .ALUSrc(ALU_SRC), .RegWrite(REG_WRITE), .AuipcLui(AUIPCLUI), .Jal(JAL), .Jalr(JALR)); 
//ALU_CONTROL
ALU_CONTROL alu_control(.entrada(INSTRUCCION), .alu_op(ALUOP), .alu_control(ALU_CONTROL)); 
//IMMGEN
ImmGen immgen(.clk(clk), .inst(INSTRUCCION), .imm(IMMEDIATO)); 
//MUX1 REGSITRO 
mux1 multiplexorREGISTROS(.A(W2), .B(IMMEDIATO), .O(W4), .sel(ALU_SRC)); 
//MUX1 RAM 
mux1 multiplexorRAM(.A(SALIDA_ALU), .B(SALIDA_RAM), .O(SALIDA_MUX), .sel(MEMTO_REG));
//MUX1 SUMADOR 
mux1 multiplexorSUMADOR(.A(SALIDA), .B(SALIDA_SUM2), .O(ENTRADA_PC), .sel(SALIDA_AND)); 
//MUX1 JAL 
mux1 muxJAL(.A(SALIDA_MUX), .B(SALIDA_SUM1), .O(WRITE), .sel(JAL)); 
//MUX1 JALR
mux1 muxJALR(.A(SALIDA_SUM1), .B(SALIDA_SUM2), .O(SALIDA), .sel(JALR)); 
//MUX2
mux2 multiplexor2(.A(SALIDA_PC), .B(W1), .O(W3), .sel(AUIPCLUI)); 
//SUMADOR1
sumador1 SUMADOR1(.instruccion(SALIDA_PC), .result(SALIDA_SUM1)); 
//SUMADOR2
sumador2 SUMADOR2(.instruccion(SALIDA_PC), .result(SALIDA_SUM2), .Imm(IMMEDIATO)); 
//PC
pc PC(.clk(clk), .reset(reset), .pc_anterior(ENTRADA_PC), .pc_siguiente(SALIDA_PC)); 
//PUERTA_AND
PUERTA_AND puerta_and(.A(BRANCH), .B(ZERO_FLAG), .O(SALIDA_AND));
 
endmodule 