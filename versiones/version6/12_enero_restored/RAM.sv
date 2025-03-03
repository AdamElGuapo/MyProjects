module RAM	#(parameter profundidad = 1024)
(
    input logic clk,
    input logic [$clog2(profundidad-1)-1:0] address,
    input logic [31:0] write_data,
    input logic MemWrite,
	 input logic MemRead,
    output logic [31:0] read_data
);

    logic [31:0] ram [0:profundidad-1];

    
    initial 
		begin
        $readmemb("C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version6/12_enero_restored/ram.txt", ram); 
		end

    always_ff @(posedge clk)
			begin
				if (MemWrite) 
					begin
						ram[address] <= write_data;
					end
			end

assign read_data = ram[address]; 
endmodule

