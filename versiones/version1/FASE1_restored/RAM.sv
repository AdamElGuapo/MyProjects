module RAM(
    input logic clk,
    input logic reset,
    input logic [31:0] address,
    input logic [31:0] data_in,
    input logic MemWrite,
    output logic [31:0] data_out
);

    parameter profundidad = 1024; 

    logic [31:0] ram [0:profundidad-1];

    
    initial 
		begin
        $readmemb("RAM.txt", ram); 
		end

    always_ff @(posedge clk or negedge reset)
	 
			if (!reset) 
				begin           
					ram[address] <= 32'b0;
				end 
				
			else 
				begin
					if (MemWrite) 
						begin
							ram[address] <= data_in;
						end
				end
	 
	 
    assign data_out = ram[address];

endmodule

