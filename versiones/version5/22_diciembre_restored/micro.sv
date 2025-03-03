module micro (
	input logic clk, reset); 

logic [31:0] w1, w2, w3, w4, w5; 
logic w6, w7;   
	
fase1 duv(.CLK(clk), .RESET(reset), .INSTRUCCION_IF(w2), .READ_DATA_MEM(w5), .READ_DATA_2_MEM(w3), 
.ALU_RESULT_MEM(w4), .PC_IF(w1), .MEMWRITE_MEM(w6), .MEM_READ(w7)); 

//RAM ram (.clk(clk), .write_data(READ_DATA_2_MEM), .address(ALU_RESULT_MEM[11:2]), .read_data(READ_DATA_MEM), .MemWrite(MEMWRITE_MEM), .MemRead(MEM_READ));
RAM ram(.clk(clk), .write_data(w3), .address(w4[11:2]), .read_data(w5), .MemWrite(w6), .MemRead(w7));

//ROM rom (.address(PC_IF[11:2]), .data_out(INSTRUCCION_IF));
ROM rom(.address(w1[11:2]), .data_out(w2)); 

endmodule 