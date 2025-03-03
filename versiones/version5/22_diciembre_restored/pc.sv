module pc (clk,reset,pc_anterior,pc_siguiente);
input clk, reset;
input [31:0] pc_anterior;
output reg [31:0] pc_siguiente;

always @(posedge clk or negedge reset)
	if (!reset)
		pc_siguiente <= 32'd0;
	 else
		pc_siguiente <= pc_anterior;
		
endmodule 