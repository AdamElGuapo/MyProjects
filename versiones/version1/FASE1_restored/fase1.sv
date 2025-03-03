module fase1 (
input logic clk, reset); 

reg [31:0] cable, resultado, salida_alu; 
logic [4:0] w1, w2; 

//ROM
ROM duv1 (.address(), .data_out(cable)); 

//BANCO REGISTROS
Banco_registros duv2 (.clk(clk), .reset(reset), .read_register_1(cable[19:15]), .read_register_2(cable[24:20]), .write_register(cable[11:7]), .write_data(resultado), 
								.read_data_1(w1), .read_data_2(w2), .RegWrite());
//ALU
ALU duv3 (.A(w1), .B(w2), .ALU_control(), .result(salida_alu), .zero_flag());

//RAM
RAM duv4 (.clk(clk), .reset(reset), .data_in(salida_alu), .address(address), .data_out(resultado), .MemWrite());

endmodule 