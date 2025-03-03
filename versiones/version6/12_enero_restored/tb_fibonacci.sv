`timescale 1ns/100ps
module tb_fibonacci(); 
	localparam T=20; 
	

	
	// DUV instance 
	reg CLK, RESET; 
	micro duv (.clk(CLK),.reset(RESET)); 
	
	
	//	clock generation
	always 
	begin 
		#(T/2)  CLK = ~CLK; 
	end
	
	// Test procedure
	//assert property(x[1]==32'hffffffff)
	
	initial 
	begin 
		CLK = 1'b1; 
		RESET = 1'b0;
		#1
		RESET = 1'b1; 
		#10000
		
		$display("Test finished"); 
		$stop; 
	end
	
endmodule 